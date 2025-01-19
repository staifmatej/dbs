
/*
Query: Find the guard who inspects meals only for cells with number 8005.
*/

SELECT hj.bachar_id_zamestnanec AS "id zaměstnance, který kontroloval jídlo"
FROM bachar b
JOIN hotove_jidlo hj ON hj.bachar_id_zamestnanec = b.id_zamestnanec
JOIN vezen v ON v.id_vezen = hj.id_vezen
JOIN cela c ON c.id_cela = v.id_cela
WHERE c.cislo_cely = 8005
AND NOT EXISTS (
    SELECT 1 FROM hotove_jidlo hj3
    JOIN vezen v3 ON v3.id_vezen = hj3.id_vezen
    JOIN cela c3 ON c3.id_cela = v3.id_cela
    WHERE c3.cislo_cely <> 8005 -- Excludes cells other than 8005
    AND hj3.bachar_id_zamestnanec = hj.bachar_id_zamestnanec
);
