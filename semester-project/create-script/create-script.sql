-- odeberu pokud existuje funkce na oodebrání tabulek a sekvencí
DROP FUNCTION IF EXISTS remove_all();

-- vytvořím funkci která odebere tabulky a sekvence
CREATE or replace FUNCTION remove_all() RETURNS void AS $$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT
            'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace
        WHERE
            relkind = 'S' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    FOR rec IN SELECT
            'DROP TABLE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace WHERE relkind = 'r' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
-- zavolám funkci co odebere tabulky a sekvence - Mohl bych dropnout celé schéma a znovu jej vytvořit, použíjeme však PLSQL
select remove_all();

CREATE TABLE adresa (
    id_adresa SERIAL NOT NULL,
    id_stat INTEGER NOT NULL,
    ulice VARCHAR(250),
    cislo INTEGER,
    mesto VARCHAR(200) NOT NULL,
    psc INTEGER NOT NULL
);
ALTER TABLE adresa ADD CONSTRAINT pk_adresa PRIMARY KEY (id_adresa);

CREATE TABLE alergeny (
    id_alergeny SERIAL NOT NULL,
    nazev VARCHAR(100) NOT NULL,
    cislo_alergenu_dle_eu VARCHAR(27),
    zdroj VARCHAR(256) NOT NULL
);
ALTER TABLE alergeny ADD CONSTRAINT pk_alergeny PRIMARY KEY (id_alergeny);

CREATE TABLE bachar (
    id_zamestnanec INTEGER NOT NULL,
    nadrizeny_id_bachar INTEGER
);
ALTER TABLE bachar ADD CONSTRAINT pk_bachar PRIMARY KEY (id_zamestnanec);

CREATE TABLE cela (
    id_cela SERIAL NOT NULL,
    cislo_cely INTEGER NOT NULL
);
ALTER TABLE cela ADD CONSTRAINT pk_cela PRIMARY KEY (id_cela);
ALTER TABLE cela ADD CONSTRAINT uc_cela_cislo_cely UNIQUE (cislo_cely);

CREATE TABLE hotove_jidlo (
    datum_uvareni TIMESTAMP NOT NULL,
    id_jidlo INTEGER NOT NULL,
    kuchar_id_zamestnanec INTEGER NOT NULL,
    bachar_id_zamestnanec INTEGER,
    id_vezen INTEGER,
    datum_kontroly DATE NOT NULL,
    pocet_porci VARCHAR(100)
);
ALTER TABLE hotove_jidlo ADD CONSTRAINT pk_hotove_jidlo PRIMARY KEY (datum_uvareni, id_jidlo, kuchar_id_zamestnanec);

CREATE TABLE jidlo (
    id_jidlo SERIAL NOT NULL,
    nazev VARCHAR(200) NOT NULL,
    popis VARCHAR(100),
    doba_pripravy VARCHAR(150),
    pocet_porci VARCHAR(27) NOT NULL
);
ALTER TABLE jidlo ADD CONSTRAINT pk_jidlo PRIMARY KEY (id_jidlo);

CREATE TABLE kuchar (
    id_zamestnanec INTEGER NOT NULL,
    nadrizeny_id_kuchar INTEGER
);
ALTER TABLE kuchar ADD CONSTRAINT pk_kuchar PRIMARY KEY (id_zamestnanec);

CREATE TABLE stat (
    id_stat SERIAL NOT NULL,
    nazev VARCHAR(200) NOT NULL
);
ALTER TABLE stat ADD CONSTRAINT pk_stat PRIMARY KEY (id_stat);
ALTER TABLE stat ADD CONSTRAINT uc_stat_nazev UNIQUE (nazev);

CREATE TABLE vezen (
    id_vezen SERIAL NOT NULL,
    id_cela INTEGER NOT NULL,
    cislo_vezne VARCHAR(27) NOT NULL,
    jmeno VARCHAR(156),
    prijmeni VARCHAR(156),
    prezdivka VARCHAR(100),
    datum_propusteni DATE NOT NULL,
    datum_narozeni DATE,
    vyska VARCHAR(27),
    popis VARCHAR(256)
);
ALTER TABLE vezen ADD CONSTRAINT pk_vezen PRIMARY KEY (id_vezen);

CREATE TABLE zamestnanec (
    id_zamestnanec SERIAL NOT NULL,
    id_adresa INTEGER NOT NULL,
    jmeno VARCHAR(156) NOT NULL,
    prijmeni VARCHAR(156) NOT NULL,
    smlouva_od DATE NOT NULL
);
ALTER TABLE zamestnanec ADD CONSTRAINT pk_zamestnanec PRIMARY KEY (id_zamestnanec);

CREATE TABLE jidlo_alergeny (
    id_jidlo INTEGER NOT NULL,
    id_alergeny INTEGER NOT NULL
);
ALTER TABLE jidlo_alergeny ADD CONSTRAINT pk_jidlo_alergeny PRIMARY KEY (id_jidlo, id_alergeny);

CREATE TABLE vezen_alergeny (
    id_vezen INTEGER NOT NULL,
    id_alergeny INTEGER NOT NULL
);
ALTER TABLE vezen_alergeny ADD CONSTRAINT pk_vezen_alergeny PRIMARY KEY (id_vezen, id_alergeny);

ALTER TABLE adresa ADD CONSTRAINT fk_adresa_stat FOREIGN KEY (id_stat) REFERENCES stat (id_stat) ON DELETE CASCADE;

ALTER TABLE bachar ADD CONSTRAINT fk_bachar_zamestnanec FOREIGN KEY (id_zamestnanec) REFERENCES zamestnanec (id_zamestnanec) ON DELETE CASCADE;
ALTER TABLE bachar ADD CONSTRAINT fk_bachar_bachar FOREIGN KEY (nadrizeny_id_bachar) REFERENCES bachar (id_zamestnanec) ON DELETE CASCADE;

ALTER TABLE hotove_jidlo ADD CONSTRAINT fk_hotove_jidlo_jidlo FOREIGN KEY (id_jidlo) REFERENCES jidlo (id_jidlo) ON DELETE CASCADE;
ALTER TABLE hotove_jidlo ADD CONSTRAINT fk_hotove_jidlo_kuchar FOREIGN KEY (kuchar_id_zamestnanec) REFERENCES kuchar (id_zamestnanec) ON DELETE CASCADE;
ALTER TABLE hotove_jidlo ADD CONSTRAINT fk_hotove_jidlo_bachar FOREIGN KEY (bachar_id_zamestnanec) REFERENCES bachar (id_zamestnanec) ON DELETE CASCADE;
ALTER TABLE hotove_jidlo ADD CONSTRAINT fk_hotove_jidlo_vezen FOREIGN KEY (id_vezen) REFERENCES vezen (id_vezen) ON DELETE CASCADE;

ALTER TABLE kuchar ADD CONSTRAINT fk_kuchar_zamestnanec FOREIGN KEY (id_zamestnanec) REFERENCES zamestnanec (id_zamestnanec) ON DELETE CASCADE;
ALTER TABLE kuchar ADD CONSTRAINT fk_kuchar_kuchar FOREIGN KEY (nadrizeny_id_kuchar) REFERENCES kuchar (id_zamestnanec) ON DELETE CASCADE;

ALTER TABLE vezen ADD CONSTRAINT fk_vezen_cela FOREIGN KEY (id_cela) REFERENCES cela (id_cela) ON DELETE CASCADE;

ALTER TABLE zamestnanec ADD CONSTRAINT fk_zamestnanec_adresa FOREIGN KEY (id_adresa) REFERENCES adresa (id_adresa) ON DELETE CASCADE;

ALTER TABLE jidlo_alergeny ADD CONSTRAINT fk_jidlo_alergeny_jidlo FOREIGN KEY (id_jidlo) REFERENCES jidlo (id_jidlo) ON DELETE CASCADE;
ALTER TABLE jidlo_alergeny ADD CONSTRAINT fk_jidlo_alergeny_alergeny FOREIGN KEY (id_alergeny) REFERENCES alergeny (id_alergeny) ON DELETE CASCADE;

ALTER TABLE vezen_alergeny ADD CONSTRAINT fk_vezen_alergeny_vezen FOREIGN KEY (id_vezen) REFERENCES vezen (id_vezen) ON DELETE CASCADE;
ALTER TABLE vezen_alergeny ADD CONSTRAINT fk_vezen_alergeny_alergeny FOREIGN KEY (id_alergeny) REFERENCES alergeny (id_alergeny) ON DELETE CASCADE;

