
/*
Query: List all employees (first name, last name, and full address) who live (have permanent residence) outside the Czech Republic.
*/

SELECT z.jmeno, z.prijmeni, a.mesto, a.ulice, a.cislo AS "číslo popisné",
       a.psc, s.nazev
FROM zamestnanec z
JOIN adresa a ON a.id_adresa = z.id_adresa
JOIN stat s ON s.id_stat = a.id_stat
WHERE NOT EXISTS (
    SELECT 1 FROM stat s2
    JOIN adresa a2 ON a2.id_stat = s2.id_stat
    WHERE z.id_adresa = a2.id_adresa
      AND s2.nazev = 'Czech Republic'
);
