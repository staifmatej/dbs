
/*
Query: Create a view of overcrowded cells that are occupied by more than 3 inmates (Category L).
For cells with a number greater than 8005, count them (Category M).
*/

CREATE OR REPLACE VIEW PreplneneCely AS
SELECT *
FROM cela
WHERE (SELECT COUNT(*)
       FROM vezen
       WHERE vezen.id_cela = cela.id_cela) > 3
WITH CHECK OPTION; -- Ensures that any modification respects the view's criteria

SELECT COUNT(*)
FROM PreplneneCely
WHERE cislo_cely > 8005;
