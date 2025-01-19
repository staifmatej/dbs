
/*
Query: List all employees who are guards, along with all their personal information (e.g., name, surname, etc.).
*/

SELECT z.id_zamestnanec AS "identifikační číslo", z.jmeno, z.prijmeni, z.smlouva_od AS "nástup do práce", a.ulice,
       a.cislo AS "číslo popisné", a.mesto AS "město", a.psc AS "PSČ", s.nazev AS "název stát"
FROM zamestnanec z
JOIN adresa a ON a.id_adresa = z.id_adresa
JOIN stat s ON s.id_stat = a.id_stat
JOIN bachar b ON b.id_zamestnanec = z.id_zamestnanec;
