
/*
Query: Provide information about employees who are cooks but do not have any record associated with prepared meals.
*/

SELECT z1.id_zamestnanec 
FROM zamestnanec z1
NATURAL JOIN kuchar k1
EXCEPT
SELECT id_zamestnanec
FROM hotove_jidlo hj2
JOIN kuchar k2 ON hj2.kuchar_id_zamestnanec = k2.id_zamestnanec;
