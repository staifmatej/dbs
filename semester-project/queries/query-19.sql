
/*
Query: Select employees who are chefs and have had a contract for more than 5 years.
*/

SELECT k.id_zamestnanec, z.jmeno, z.prijmeni, z.smlouva_od
FROM zamestnanec z
JOIN kuchar k USING(id_zamestnanec)
WHERE smlouva_od <= (CURRENT_DATE - INTERVAL '5 years');
