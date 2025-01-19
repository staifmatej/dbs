/*
Query: Retrieve information about inmates who occupy cells with a number greater than 8009.
List cell ID, cell number, inmate ID, first name, and last name.
*/

SELECT c.id_cela, c.cislo_cely, v.jmeno, v.prijmeni, v.id_vezen
FROM vezen v
JOIN cela c ON v.id_cela = c.id_cela
WHERE c.cislo_cely > 8009;
