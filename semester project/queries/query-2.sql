
/*
Query: List all guards who have never inspected any meals.
*/

SELECT id_zamestnanec
FROM bachar
WHERE NOT EXISTS (
    SELECT *
    FROM hotove_jidlo
    WHERE hotove_jidlo.bachar_id_zamestnanec = bachar.id_zamestnanec
);
