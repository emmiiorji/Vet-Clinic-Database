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
