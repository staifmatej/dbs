
/*
Query: Select prisoners who have ever eaten the food "spaghetti" or "lasagna".
*/

SELECT v.* FROM vezen v
JOIN hotove_jidlo hj USING(id_vezen)
JOIN jidlo j USING(id_jidlo)
WHERE j.nazev='spaghetti'
UNION
SELECT v2.* FROM vezen v2
JOIN hotove_jidlo hj2 USING(id_vezen)
JOIN jidlo j2 USING(id_jidlo)
WHERE j2.nazev='lasagna';
