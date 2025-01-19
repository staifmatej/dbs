
/*
Query: List all unique meal names (each type only once) that were cooked in the current year.
*/

SELECT DISTINCT *
FROM hotove_jidlo
WHERE (datum_uvareni >= TO_DATE('01.01.2024', 'dd.mm.yyyy'))
  AND (datum_uvareni <= TO_DATE('31.12.2024', 'dd.mm.yyyy'));
