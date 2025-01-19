
/*
Query: List all possible combinations of which inmates a guard with ID 44 might have inspected meals for.
*/

SELECT DISTINCT v.id_vezen, v.jmeno, v.prijmeni, hj.bachar_id_zamestnanec
FROM vezen v
CROSS JOIN hotove_jidlo hj
WHERE hj.bachar_id_zamestnanec = 44;
