
/*
Query: Output the total number of inmates who are still residing in the prison as of today. (Result will only be a number.)
*/

SELECT COUNT(*)
FROM vezen
WHERE datum_propusteni >= CURRENT_DATE;
