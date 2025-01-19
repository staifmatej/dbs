
/*
Query: List all cells containing fewer than two inmates. Display the number of inmates in each cell on the same row as the cell number.
*/

SELECT cislo_cely, COUNT(id_vezen) AS "počet vězňů v cele"
FROM cela
JOIN vezen USING(id_cela)
GROUP BY cislo_cely
HAVING COUNT(id_vezen) < 2;
