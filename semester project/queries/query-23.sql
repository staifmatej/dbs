
/*
Query: A new law requires reducing the release date by 50 years for inmates with a release date after 2075.
*/

BEGIN;

SELECT *
FROM vezen
WHERE datum_propusteni > TO_DATE('01.01.2075', 'dd.mm.yyyy');

UPDATE vezen
SET datum_propusteni = datum_propusteni - INTERVAL '50 years'
WHERE id_vezen IN (
    SELECT v.id_vezen
    FROM vezen v
    WHERE v.datum_propusteni > TO_DATE('01.01.2075', 'dd.mm.yyyy')
);

SELECT *
FROM vezen
WHERE datum_propusteni > TO_DATE('01.01.2075', 'dd.mm.yyyy');

ROLLBACK;
