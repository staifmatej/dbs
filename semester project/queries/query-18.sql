
/*
Query: List employees who do not have permanent residence in Slovakia.
*/

SELECT z.jmeno, z.prijmeni, a.mesto, s.nazev
FROM zamestnanec z
JOIN adresa a ON a.id_adresa = z.id_adresa
JOIN stat s ON s.id_stat = a.id_stat
WHERE (s.nazev != 'Slovakia');
