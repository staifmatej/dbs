
/*
Query: For each cell except cell 8001, list how many inmates reside in it. Focus only on cells with more than 3 inmates.
The result will be ordered by the number of inmates in ascending order.
*/

SELECT c.id_cela, c.cislo_cely, COUNT(v.id_vezen) "pocet_veznu" 
FROM cela c
JOIN vezen v USING(id_cela)
WHERE c.cislo_cely != 8001
GROUP BY c.id_cela
HAVING COUNT(v.id_vezen) > 3
ORDER BY "pocet_veznu" ASC;
