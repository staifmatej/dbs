
/*
Query: Re-insert the last date of inspection for prepared meals (hotove_jidlo).
*/

BEGIN;

SELECT *
FROM hotove_jidlo
ORDER BY datum_kontroly DESC
LIMIT 3;

INSERT INTO hotove_jidlo (datum_uvareni, id_jidlo, kuchar_id_zamestnanec, bachar_id_zamestnanec, id_vezen, datum_kontroly, pocet_porci)
SELECT CAST(NOW() AS TIMESTAMP) AS datum_uvareni, hj.id_jidlo, hj.kuchar_id_zamestnanec, 
       hj.bachar_id_zamestnanec, hj.id_vezen, CAST(NOW() AS DATE) AS datum_kontroly, hj.pocet_porci
FROM hotove_jidlo hj
ORDER BY hj.datum_kontroly DESC
LIMIT 1;

SELECT *
FROM hotove_jidlo
ORDER BY datum_kontroly DESC
LIMIT 3;

ROLLBACK;
