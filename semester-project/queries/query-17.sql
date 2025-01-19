
/*
Query: List all inmates sorted by id_vezen in ascending order who do not have a nickname
and reside in the cell with number 8001.
*/

SELECT id_vezen
FROM (
    SELECT DISTINCT id_vezen
    FROM vezen
    JOIN cela USING(id_cela)
    WHERE (cislo_cely = 8001)
    INTERSECT
    SELECT DISTINCT id_vezen
    FROM vezen
    WHERE (prezdivka IS NOT NULL)
)
ORDER BY id_vezen ASC; /* ASC = ascending DESC = descending */
