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
        ADD owner_id INT REFERENCES owners(id);

COMMIT;

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL,
    CONSTRAINT vet_age_check CHECK(age > 0),
    CONSTRAINT vet_date_of_graduation_check CHECK(date_of_graduation < CURRENT_DATE + 1)
);

CREATE TABLE specializations(
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY(vet_id, species_id)
);

CREATE TABLE visits(
    animal_id INT REFERENCES animals(id) NOT NULL,
    vet_id INT REFERENCES vets(id) NOT NULL,
    visit_date DATE NOT NULL
);
