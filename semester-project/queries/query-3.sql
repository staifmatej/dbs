
/*
Query: Select guards (all attributes) who have inspected meals for all inmates.
*/

WITH pocetVeznu AS (
    SELECT COUNT(*) AS total_veznu FROM vezen
)
SELECT z.id_zamestnanec AS "bachar (id_zamestnanec)"
FROM hotove_jidlo hj
JOIN zamestnanec z ON z.id_zamestnanec = hj.bachar_id_zamestnanec
GROUP BY z.id_zamestnanec
HAVING COUNT(DISTINCT hj.id_vezen) = (
    SELECT COUNT(*) AS total_veznu FROM vezen
);
