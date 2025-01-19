# Insert Script Documentation

This document explains the functionality of the `insert-script.sql` used in the project, detailing its purpose, structure, and contents. The script is designed to initialize the database with essential data, reset sequences, and clean tables.

---

## Purpose of the Script

The `insert-script.sql` serves the following purposes:

1. **Table Cleanup**:
   - Truncates all tables within the `public` schema using the `clean_tables` function.
   - Ensures tables are emptied safely with cascading dependencies handled.

2. **Sequence Reset**:
   - Resets all database sequences to ensure primary keys start from the correct values using the `restart_sequences` function.

3. **Data Insertion**:
   - Inserts initial data into tables such as `cela`, `stat`, `adresa`, `zamestnanec`, `kuchar`, `bachar`, `alergeny`, `vezen`, `vezen_alergeny`, `jidlo`, `jidlo_alergeny`, and `hotove_jidlo`.
   - Sets sequences for each table to reflect the last inserted record.

---

## Contents of the Script

Below is the complete code of the `insert-script.sql`:

```sql
-- Delete all records from tables
CREATE OR REPLACE FUNCTION clean_tables() RETURNS void AS
$$
DECLARE
    l_stmt text;
BEGIN
    SELECT 'truncate ' || STRING_AGG(FORMAT('%I.%I', schemaname, tablename), ',')
    INTO l_stmt
    FROM pg_tables
    WHERE schemaname IN ('public');

    EXECUTE l_stmt || ' cascade';
END;
$$ LANGUAGE plpgsql;
SELECT clean_tables();

-- Reset sequences
CREATE OR REPLACE FUNCTION restart_sequences() RETURNS void AS
$$
DECLARE
    i TEXT;
BEGIN
    FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
        LOOP
            EXECUTE 'ALTER SEQUENCE' || ' ' || SUBSTRING(SUBSTRING(i FROM '\''[a-z_]*') FROM '[a-z_]+') || ' ' ||
                    ' RESTART 1;';
        END LOOP;
END
$$ LANGUAGE plpgsql;
SELECT restart_sequences();

insert into cela (id_cela, cislo_cely) values (24, 8024);
insert into cela (id_cela, cislo_cely) values (25, 8025);
insert into cela (id_cela, cislo_cely) values (26, 8026);
insert into cela (id_cela, cislo_cely) values (27, 8027);
SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('cela', 'id_cela'), 27);

insert into stat (id_stat, nazev) values (1, 'Czech Republic');
insert into stat (id_stat, nazev) values (2, 'Slovakia');
insert into stat (id_stat, nazev) values (3, 'Poland');
insert into stat (id_stat, nazev) values (4, 'Ukraine');
insert into stat (id_stat, nazev) values (5, 'Germany');
SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('stat', 'id_stat'), 5);

insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (96, 3, null, 579, 'Tanbu', 18624);
insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (97, 1, 'Paget', 623, 'Sadabe', 13251);
insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (98, 4, null, 628, 'Zhlobin', 12751);
insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (99, 4, null, null, 'Kezileboyi', 17118);
insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (100, 3, null, null, 'Zhongshan Donglu', 18181);
SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('adresa', 'id_adresa'), 100);

-- Further insertion scripts for other tables follow a similar pattern.
-- For brevity, only a sample is shown here.

commit;
```

---

## Key Functions and Features

### `clean_tables` Function
- **Purpose**: Truncates all tables in the `public` schema.
- **Key Code**:
  ```sql
  CREATE OR REPLACE FUNCTION clean_tables() RETURNS void AS
  $$
  BEGIN
      SELECT 'truncate ' || STRING_AGG(FORMAT('%I.%I', schemaname, tablename), ',')
      INTO l_stmt
      FROM pg_tables
      WHERE schemaname IN ('public');

      EXECUTE l_stmt || ' cascade';
  END;
  $$ LANGUAGE plpgsql;
  SELECT clean_tables();
  ```

### `restart_sequences` Function
- **Purpose**: Resets database sequences to maintain data integrity.
- **Key Code**:
  ```sql
  CREATE OR REPLACE FUNCTION restart_sequences() RETURNS void AS
  $$
  BEGIN
      FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
      LOOP
          EXECUTE 'ALTER SEQUENCE ' || SUBSTRING(SUBSTRING(i FROM '\''[a-z_]*') FROM '[a-z_]+') || ' RESTART 1;';
      END LOOP;
  END;
  $$ LANGUAGE plpgsql;
  SELECT restart_sequences();
  ```

### `cela` Table Example
- **Purpose**: Holds cell data.
- **Key Code**:
  ```sql
  insert into cela (id_cela, cislo_cely) values (24, 8024);
  -- Code shortened to highlight key insertions.
  ```

### `stat` Table Example
- **Purpose**: Stores country data.
- **Key Code**:
  ```sql
  insert into stat (id_stat, nazev) values (1, 'Czech Republic');
  -- Code shortened to highlight key insertions.
  ```

### `adresa` Table Example
- **Purpose**: Maintains address information.
- **Key Code**:
  ```sql
  insert into adresa (id_adresa, id_stat, ulice, cislo, mesto, psc) values (96, 3, null, 579, 'Tanbu', 18624);
  -- Code shortened to highlight key insertions.
  ```

### `zamestnanec` Table Example
- **Purpose**: Stores employee data.
- **Key Code**:
  ```sql
  insert into zamestnanec (id_zamestnanec, id_adresa, jmeno, prijmeni, smlouva_od) values (95, 68, 'Bérengère', 'Plail', '2012-10-03T21:53:32Z');
  -- Code shortened to highlight key insertions.
  ```

### `kuchar` Table Example
- **Purpose**: Stores cook data.
- **Key Code**:
  ```sql
  insert into kuchar (id_zamestnanec, nadrizeny_id_kuchar) values (7, NULL);
  -- Code shortened to highlight key insertions.
  ```

### `bachar` Table Example
- **Purpose**: Stores warden data.
- **Key Code**:
  ```sql
  insert into bachar (id_zamestnanec, nadrizeny_id_bachar) values (96, NULL);
  -- Code shortened to highlight key insertions.
  ```

### `alergeny` Table Example
- **Purpose**: Stores allergen information.
- **Key Code**:
  ```sql
  insert into alergeny (id_alergeny, nazev, cislo_alergenu_dle_eu, zdroj) values (11, 'Sesame seeds', 11, 'and products thereof');
  -- Code shortened to highlight key insertions.
  ```

### `vezen` Table Example
- **Purpose**: Stores prisoner data.
- **Key Code**:
  ```sql
  insert into vezen (id_vezen, id_cela, cislo_vezne, jmeno, prijmeni, prezdivka, datum_propusteni, datum_narozeni, vyska, popis) values (94, 9, 94, 'Valérie', 'Cartman', null, '2070-03-24T05:53:54Z', '11/8/1985', null, null);
  -- Code shortened to highlight key insertions.
  ```

### `jidlo` Table Example
- **Purpose**: Stores food data.
- **Key Code**:
  ```sql
  insert into jidlo (id_jidlo, nazev, popis, doba_pripravy, pocet_porci) values (19, 'tortellini', 'recommend adding sage butter', '4:40:48.000', 92);
  -- Code shortened to highlight key insertions.
  ```

---

## Summary

The `Insert Script` is an essential part of the database setup, allowing for efficient population of the schema with consistent and reliable data. The script ensures a clean state and aligns sequences to maintain database integrity.

For further details about database structure and creation, refer to the [Create Script Documentation](../create-script/).
