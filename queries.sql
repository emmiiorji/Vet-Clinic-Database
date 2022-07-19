/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * from animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered=TRUE;

SELECT * from animals WHERE name<>'Gabumon';

SELECT * from animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;

-- Transactions
BEGIN;
  UPDATE animals SET species='unspecified';
  SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
  UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
  UPDATE animals SET species='pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
  DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
  DELETE FROM animals WHERE date_of_birth > '2022-01-01';
  SAVEPOINT DELETE_DATE_OF_BIRTH;

  UPDATE animals SET weight_kg = weight_kg * -1;
  ROLLBACK TO DELETE_DATE_OF_BIRTH;
  UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Number of animals in animals table
SELECT COUNT(*) FROM animals;

-- Number of animals that have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts < 1;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(escape_attempts) FROM animals
GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY species;
