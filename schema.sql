/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT DEFAULT 0 CHECK(escape_attempts >= 0),
    neutered BOOLEAN DEFAULT FALSE,
    weight_kg FLOAT NOT NULL CHECK(weight_kg > 0.0)
);

ALTER TABLE animals
    ADD species VARCHAR(100);

ALTER TABLE animals
    DROP CONSTRAINT animals_weight_kg_check;

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

BEGIN;

    ALTER TABLE animals
        DROP COLUMN species;

    ALTER TABLE animals
        ADD species_id INT REFERENCES species(id);

    ALTER TABLE animals
        ADD owner_id INT REFERENCES owner(id);

COMMIT;
