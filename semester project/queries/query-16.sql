
/*
Query: List information about cells and the number of inmates residing in each cell.
*/

SELECT *,
       (SELECT COUNT(*)
        FROM vezen
        WHERE vezen.id_cela = cela.id_cela) AS "počet vězňů"
FROM cela;
