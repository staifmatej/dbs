# Queries Documentation

This document provides a detailed overview of the SQL queries used in the project. Each query includes its purpose, the corresponding SQL code, and its functionality in the database. Where applicable, sample outputs have been included. Please note, outputs have been truncated for brevity.

---

## Query 1

**Purpose**: Retrieve all prisoner records with their cell number.

**SQL Code**:
```sql
SELECT v.id_vezen, v.jmeno, v.prijmeni, c.cislo_cely 
FROM vezen v 
JOIN cela c ON v.id_cela = c.id_cela;
```

**Output**:
| cislo_cely | pocet veznu v cele |
|------------|--------------------|
| 8006       | 4                  |
| 8018       | 6                  |
| 8013       | 3                  |
| 8027       | 7                  |
| 8007       | 5                  |

*Note: The output has been truncated for clarity.*

---

## Query 2

**Purpose**: Find the number of prisoners in each cell.

**SQL Code**:
```sql
SELECT c.cislo_cely, COUNT(v.id_vezen) AS pocet_veznu 
FROM cela c 
LEFT JOIN vezen v ON c.id_cela = v.id_cela 
GROUP BY c.cislo_cely;
```

**Output**:
| id_zamestnanec |
|----------------|
| 20             |
| 82             |
| 25             |
| 26             |
| 27             |

*Note: The output has been truncated for clarity.*

---

## Query 3

**Purpose**: List all employees who have a contract starting after a specific date.

**SQL Code**:
```sql
SELECT jmeno, prijmeni, smlouva_od 
FROM zamestnanec 
WHERE smlouva_od > '2020-01-01';
```

**Output**:
| bachar (id_zamestnanec) |
|-------------------------|
| 19                      |

---

## Query 4

**Purpose**: Retrieve all cooks and their supervisors.

**SQL Code**:
```sql
SELECT k.id_zamestnanec AS kuchar_id, k.nadrizeny_id_kuchar AS supervisor_id 
FROM kuchar k;
```

---

## Query 5

**Purpose**: Display all allergens and their sources.

**SQL Code**:
```sql
SELECT nazev, zdroj 
FROM alergeny;
```

**Output**:
| datum_uvareni       | id_jidlo | kuchar_id_zamestnanec | bachar_id_zamestnanec | id_vezen | datum_kontroly | pocet_porci |
|---------------------|----------|-----------------------|-----------------------|----------|---------------|-------------|
| 2024-12-18 02:51:26 | 5        | 9                     | 19                    | 18       | 2020-05-17    |             |

---

## Query 6

**Purpose**: List all dishes along with their preparation times.

**SQL Code**:
```sql
SELECT nazev, doba_pripravy 
FROM jidlo;
```

**Output**:
| jmeno     | prijmeni  | datum_narozeni |
|-----------|-----------|----------------|
| Noémie    | Sumnall   | 1931-12-18     |
| Gösta     | Costell   | 1943-09-01     |
| Maëlann   | Witcombe  | 1947-10-02     |
| Gérald    | Winckle   | 1946-04-11     |
| Miléna    | Bartoloma | 1948-08-18     |

*Note: The output has been truncated for clarity.*

---

## Query 7

**Purpose**: Retrieve all meals prepared by a specific cook.

**SQL Code**:
```sql
SELECT h.datum_uvareni, j.nazev AS jidlo, h.kuchar_id_zamestnanec AS kuchar 
FROM hotove_jidlo h 
JOIN jidlo j ON h.id_jidlo = j.id_jidlo 
WHERE h.kuchar_id_zamestnanec = 9;
```

**Output**:
| jmeno     | prijmeni  | mesto       | ulice     | cislo popisné | psc    | nazev          |
|-----------|-----------|-------------|-----------|---------------|--------|----------------|
| Yénora    | Couldwell | Gelap       |           | 13096         | Ukraine|
| Maëlla    | Grout     | Barra Velha |           | 12995         | Ukraine|
| Andréanne | O'Lehane  | Barra Velha |           | 12995         | Ukraine|
| Léone     | Balogun   | Valuyki     | Victoria  | 744           | 17817  | Germany        |
| Régine    | McAree    | Valuyki     | Victoria  | 744           | 17817  | Germany        |

*Note: The output has been truncated for clarity.*

---

## Query 8

**Purpose**: Display all prisoners with a specific allergy.

**SQL Code**:
```sql
SELECT v.jmeno, v.prijmeni, a.nazev AS alergen 
FROM vezen_alergeny va 
JOIN vezen v ON va.id_vezen = v.id_vezen 
JOIN alergeny a ON va.id_alergeny = a.id_alergeny 
WHERE a.nazev = 'Sesame seeds';
```

---

## Query 9

**Purpose**: Calculate the average number of portions per dish.

**SQL Code**:
```sql
SELECT AVG(pocet_porci) AS prumer_porci 
FROM jidlo;
```

---

## Query 10

**Purpose**: Retrieve the most recently prepared meal for each prisoner.

**SQL Code**:
```sql
SELECT h.id_vezen, j.nazev AS jidlo, MAX(h.datum_uvareni) AS posledni_jidlo 
FROM hotove_jidlo h 
JOIN jidlo j ON h.id_jidlo = j.id_jidlo 
GROUP BY h.id_vezen, j.nazev;
```

---

## Query 11

**Purpose**: List all employees sorted by their contract start date.

**SQL Code**:
```sql
SELECT jmeno, prijmeni, smlouva_od 
FROM zamestnanec 
ORDER BY smlouva_od;
```

---

## Query 12

**Purpose**: Find all cells without prisoners.

**SQL Code**:
```sql
SELECT c.cislo_cely 
FROM cela c 
LEFT JOIN vezen v ON c.id_cela = v.id_cela 
WHERE v.id_vezen IS NULL;
```

---

## Query 13

**Purpose**: Retrieve the list of allergens along with the number of prisoners allergic to each.

**SQL Code**:
```sql
SELECT a.nazev AS alergen, COUNT(va.id_vezen) AS pocet_veznu 
FROM alergeny a 
LEFT JOIN vezen_alergeny va ON a.id_alergeny = va.id_alergeny 
GROUP BY a.nazev;
```

---

## Query 14

**Purpose**: Retrieve all supervisors and their cooks.

**SQL Code**:
```sql
SELECT k.nadrizeny_id_kuchar AS supervisor_id, COUNT(k.id_zamestnanec) AS pocet_kucharu 
FROM kuchar k 
GROUP BY k.nadrizeny_id_kuchar;
```

---

## Query 15

**Purpose**: Retrieve all employees who do not have an address.

**SQL Code**:
```sql
SELECT jmeno, prijmeni 
FROM zamestnanec 
WHERE id_adresa IS NULL;
```

---

## Query 16

**Purpose**: List all dishes without allergens.

**SQL Code**:
```sql
SELECT j.nazev 
FROM jidlo j 
LEFT JOIN jidlo_alergeny ja ON j.id_jidlo = ja.id_jidlo 
WHERE ja.id_alergeny IS NULL;
```

---

## Query 17

**Purpose**: Retrieve all prisoners released after a specific date.

**SQL Code**:
```sql
SELECT jmeno, prijmeni, datum_propusteni 
FROM vezen 
WHERE datum_propusteni > '2023-01-01';
```

---

## Query 18

**Purpose**: Find all dishes prepared by a specific cook.

**SQL Code**:
```sql
SELECT h.datum_uvareni, j.nazev 
FROM hotove_jidlo h 
JOIN jidlo j ON h.id_jidlo = j.id_jidlo 
WHERE h.kuchar_id_zamestnanec = 8;
```

---

## Query 19

**Purpose**: Calculate the total number of prisoners in the database.

**SQL Code**:
```sql
SELECT COUNT(*) AS pocet_veznu 
FROM vezen;
```

---

## Query 20

**Purpose**: Retrieve the number of allergens affecting each prisoner.

**SQL Code**:
```sql
SELECT v.jmeno, v.prijmeni, COUNT(va.id_alergeny) AS pocet_alergenu 
FROM vezen v 
LEFT JOIN vezen_alergeny va ON v.id_vezen = va.id_vezen 
GROUP BY v.jmeno, v.prijmeni;
```

---

## Query 21

**Purpose**: Find all food items that require preparation longer than 1 hour.

**SQL Code**:
```sql
SELECT nazev 
FROM jidlo 
WHERE doba_pripravy > '01:00:00';
```

---

## Query 22

**Purpose**: Retrieve the list of prisoners along with their cell numbers sorted by cell.

**SQL Code**:
```sql
SELECT v.jmeno, v.prijmeni, c.cislo_cely 
FROM vezen v 
JOIN cela c ON v.id_cela = c.id_cela 
ORDER BY c.cislo_cely;
```

---

## Query 23

**Purpose**: Find the most popular dish served to prisoners.

**SQL Code**:
```sql
SELECT j.nazev, COUNT(h.id_jidlo) AS pocet_servirovani 
FROM hotove_jidlo h 
JOIN jidlo j ON h.id_jidlo = j.id_jidlo 
GROUP BY j.nazev 
ORDER BY pocet_servirovani DESC 
LIMIT 1;
```

---

## Query 24

**Purpose**: List all supervisors with no cooks assigned.

**SQL Code**:
```sql
SELECT nadrizeny_id_kuchar 
FROM kuchar 
WHERE nadrizeny_id_kuchar IS NOT NULL 
GROUP BY nadrizeny_id_kuchar 
HAVING COUNT(id_zamestnanec) = 0;
```

---

## Query 25

**Purpose**: Retrieve the details of all meals served within a specific date range.

**SQL Code**:
```sql
SELECT * 
FROM hotove_jidlo 
WHERE datum_uvareni BETWEEN '2023-01-01' AND '2023-12-31';
```

---

## Query 26

**Purpose**: Count the number of meals served to each prisoner.

**SQL Code**:
```sql
SELECT id_vezen, COUNT(*) AS pocet_jidel 
FROM hotove_jidlo 
GROUP BY id_vezen;
```

---

## Query 27

**Purpose**: Retrieve all prisoners with more than 3 allergies.

**SQL Code**:
```sql
SELECT v.jmeno, v.prijmeni 
FROM vezen v 
JOIN vezen_alergeny va ON v.id_vezen = va.id_vezen 
GROUP BY v.jmeno, v.prijmeni 
HAVING COUNT(va.id_alergeny) > 3;
```

---

## Query 28

**Purpose**: Find all dishes prepared for a specific prisoner.

**SQL Code**:
```sql
SELECT h.id_vezen, j.nazev 
FROM hotove_jidlo h 
JOIN jidlo j ON h.id_jidlo = j.id_jidlo 
WHERE h.id_vezen = 94;
```

---

## Query 29

**Purpose**: Retrieve all prisoners taller than 180 cm.

**SQL Code**:
```sql
SELECT jmeno, prijmeni, vyska 
FROM vezen 
WHERE vyska > 180;
```

---

## Query 30

**Purpose**: Find all employees who started before 2000.

**SQL Code**:
```sql
SELECT jmeno, prijmeni 
FROM zamestnanec 
WHERE smlouva_od < '2000-01-01';
```

---

## Query 31

**Purpose**: Calculate the average height of all prisoners.

**SQL Code**:
```sql
SELECT AVG(vyska) AS prumerna_vyska 
FROM vezen;
```

---

