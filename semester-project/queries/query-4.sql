
/*
Query: Validation of query-3. Ensures correctness by comparing guards and inmates relationships.
*/

SELECT DISTINCT v01.id_vezen
FROM vezen v01
EXCEPT
(
    SELECT v02.id_vezen
    FROM vezen v02
    NATURAL JOIN hotove_jidlo
    WHERE bachar_id_zamestnanec = (
        -- Copied query from category-D validation
        WITH pocetVeznu AS (
            SELECT COUNT(*) AS total_veznu FROM vezen
        )
        SELECT z.id_zamestnanec AS "bachar (id_zamestnanec)"
        FROM hotove_jidlo hj
        JOIN zamestnanec z ON z.id_zamestnanec = hj.bachar_id_zamestnanec
        GROUP BY z.id_zamestnanec
        HAVING COUNT(DISTINCT hj.id_vezen) = (SELECT total_veznu FROM pocetVeznu)
    )
);
