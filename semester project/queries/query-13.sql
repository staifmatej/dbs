
/*
Query: Due to inmate transport reasons, list all possible combinations of guards and inmates.
Include the ID, first name, and last name of both guards and inmates.
*/

SELECT v.id_vezen, v.jmeno AS "jmeno vezne", v.prijmeni AS "prijmeni vezne",
       b.id_zamestnanec, z.jmeno AS "jmeno bachare", z.prijmeni AS "prijmeni bachare"
FROM bachar b
CROSS JOIN vezen v
JOIN zamestnanec z USING(id_zamestnanec)
ORDER BY id_vezen ASC;
