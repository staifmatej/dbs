# Create Script Documentation

The `create-script.sql` file defines the schema for the database project **Surviving Regulars of the System / Přeživší štamgasti systému**. This document explains the purpose and structure of the SQL script with code examples for better understanding.

## Purpose
The Create Script establishes the relational schema for the prison management system. It creates tables, defines their attributes, and enforces relationships and constraints such as primary keys, foreign keys, and data integrity.

---

## Script Breakdown

### 1. Dropping Existing Tables
The script starts by dropping any existing tables to avoid conflicts when re-running the script.

```sql
DROP TABLE IF EXISTS kontrola_jidla;
DROP TABLE IF EXISTS alergeny;
DROP TABLE IF EXISTS jidlo;
DROP TABLE IF EXISTS cela;
DROP TABLE IF EXISTS vezni;
DROP TABLE IF EXISTS zamestnanci;
DROP TABLE IF EXISTS stat;
DROP TABLE IF EXISTS adresa;
```

This ensures that the database starts from a clean state.

---

### 2. Creating the `stat` Table
The `stat` table stores information about states where employees reside.

```sql
CREATE TABLE stat (
    id SERIAL PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL
);
```

- **Columns:**
  - `id`: Unique identifier for the state.
  - `nazev`: Name of the state.

---

### 3. Creating the `adresa` Table
The `adresa` table stores the address of employees.

```sql
CREATE TABLE adresa (
    id SERIAL PRIMARY KEY,
    ulice VARCHAR(100) NOT NULL,
    cislo INT NOT NULL,
    mesto VARCHAR(100) NOT NULL,
    psc CHAR(5) NOT NULL,
    stat_id INT REFERENCES stat(id)
);
```

- **Columns:**
  - `id`: Unique identifier for the address.
  - `ulice`, `cislo`, `mesto`, `psc`: Address details.
  - `stat_id`: Foreign key referencing the `stat` table.

---

### 4. Creating the `zamestnanci` Table
The `zamestnanci` table records information about employees, including both guards and cooks.

```sql
CREATE TABLE zamestnanci (
    id SERIAL PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    datum_nastupu DATE NOT NULL,
    adresa_id INT REFERENCES adresa(id)
);
```

- **Columns:**
  - `id`: Unique identifier for employees.
  - `jmeno`, `prijmeni`: Employee's name.
  - `datum_nastupu`: Date the employee started work.
  - `adresa_id`: Foreign key linking to the `adresa` table.

---

### 5. Creating the `vezni` Table
The `vezni` table captures prisoner details.

```sql
CREATE TABLE vezni (
    id SERIAL PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    datum_narozeni DATE NOT NULL,
    datum_propusteni DATE,
    vyska INT NOT NULL,
    vezenske_cislo CHAR(10) UNIQUE NOT NULL
);
```

- **Columns:**
  - `id`: Unique identifier for prisoners.
  - `jmeno`, `prijmeni`: Prisoner's name.
  - `datum_narozeni`, `datum_propusteni`: Birth and release dates.
  - `vyska`: Prisoner's height.
  - `vezenske_cislo`: Unique prisoner identification number.

---

### 6. Creating the `cela` Table
The `cela` table records information about cells.

```sql
CREATE TABLE cela (
    id SERIAL PRIMARY KEY,
    unikati_cislo INT NOT NULL UNIQUE
);
```

- **Columns:**
  - `id`: Unique identifier for cells.
  - `unikati_cislo`: Unique number for each cell.

---

### 7. Creating the `jidlo` Table
The `jidlo` table tracks information about meals.

```sql
CREATE TABLE jidlo (
    id SERIAL PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL,
    datum_uvareni DATE NOT NULL,
    kuchar_id INT REFERENCES zamestnanci(id)
);
```

- **Columns:**
  - `id`: Unique identifier for meals.
  - `nazev`: Meal name.
  - `datum_uvareni`: Preparation date.
  - `kuchar_id`: Foreign key referencing the cook who prepared the meal.

---

### 8. Creating the `alergeny` Table
The `alergeny` table tracks allergen information for prisoners and meals.

```sql
CREATE TABLE alergeny (
    id SERIAL PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    zdroje TEXT,
    cislo_dle_eu INT,
    jidlo_id INT REFERENCES jidlo(id),
    vezni_id INT REFERENCES vezni(id)
);
```

- **Columns:**
  - `id`: Unique identifier for allergens.
  - `nazev`: Allergen name.
  - `zdroje`: Source of the allergen.
  - `cislo_dle_eu`: EU allergen number.
  - `jidlo_id`, `vezni_id`: Foreign keys linking allergens to meals and prisoners.

---

### 9. Creating the `kontrola_jidla` Table
The `kontrola_jidla` table logs meal inspections conducted by guards.

```sql
CREATE TABLE kontrola_jidla (
    id SERIAL PRIMARY KEY,
    jidlo_id INT REFERENCES jidlo(id),
    bacha_id INT REFERENCES zamestnanci(id),
    datum_kontroly DATE NOT NULL
);
```

- **Columns:**
  - `id`: Unique identifier for meal inspections.
  - `jidlo_id`: Foreign key linking to the meal.
  - `bacha_id`: Foreign key linking to the inspecting guard.
  - `datum_kontroly`: Date of inspection.

---

## Summary
The Create Script forms the backbone of the database system, ensuring proper structure and relationships among the entities. It handles the definition of tables, attributes, and constraints to enforce data integrity.

For further details on how to populate the database with sample data, see the [Insert Script Documentation](../insert-script/).
