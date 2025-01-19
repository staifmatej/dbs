
/*
Query: Write a query to select employees (guards) who have never inspected any meals.
*/

SELECT z.id_zamestnanec, z.jmeno, z.prijmeni
FROM zamestnanec z
JOIN bachar b USING(id_zamestnanec)
WHERE NOT EXISTS (
    SELECT 1
    FROM hotove_jidlo hj
    WHERE hj.bachar_id_zamestnanec = z.id_zamestnanec
);
