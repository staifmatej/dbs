
/*
Query: List information about prepared meals (hotove_jidlo) and their recipes (jidlo),
including recipes that have not yet been prepared.
*/

SELECT *
FROM jidlo j
FULL OUTER JOIN hotove_jidlo hj ON hj.id_jidlo = j.id_jidlo;
