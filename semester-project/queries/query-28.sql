/*
Query: Remove guards who do not have permanent residence in the Czech Republic from serving as guards in Czech prisons.
*/

begin;

SELECT DISTINCT b.id_zamestnanec, s.nazev FROM bachar b
JOIN zamestnanec z USING(id_zamestnanec)
NATURAL JOIN stat s
NATURAL JOIN adresa a;

DELETE FROM bachar WHERE id_zamestnanec IN (
    SELECT DISTINCT b.id_zamestnanec FROM bachar b
    JOIN zamestnanec z
    NATURAL JOIN stat s
    NATURAL JOIN adresa a
    WHERE s.nazev != 'Czech Republic'
);

SELECT DISTINCT b.id_zamestnanec, s.nazev FROM bachar b
JOIN zamestnanec z USING(id_zamestnanec)
NATURAL JOIN stat s
NATURAL JOIN adresa a;

rollback;
