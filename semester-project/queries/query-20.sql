
/*
Query: Select employees who do not reside in the Czech Republic.
*/

SELECT z.jmeno, z.prijmeni, z.id_zamestnanec
FROM zamestnanec z
JOIN adresa a ON a.id_adresa = z.id_adresa
JOIN stat s ON s.id_stat = a.id_stat
WHERE s.nazev NOT IN ('Czech Republic');
