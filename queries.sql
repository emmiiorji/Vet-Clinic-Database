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
  DELETE FROM animals WHERE date_of_birth > CAST('2022-01-01' AS DATE);
  SAVEPOINT DELETE_DATE_OF_BIRTH;

  UPDATE animals SET weight_kg = weight_kg * -1;
  ROLLBACK TO DELETE_DATE_OF_BIRTH;
  UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Number of animals in animals table
SELECT COUNT(*) FROM animals;

-- Number of animals that have never tried to escape
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts < 1;

-- Calculate average weight of animals:
SELECT AVG(weight_kg) FROM animals;

-- Determine whether neutered or non-neutered animals escape most
SELECT neutered, COUNT(escape_attempts) FROM animals
GROUP BY neutered;

-- Get the maximum and minimum weight of each type of animal
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY species;

-- Get the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) FROM animals
  WHERE date_of_birth >= CAST('1990-01-01' AS DATE) AND date_of_birth <= CAST('2000-01-01' AS DATE)
  GROUP BY species;

-- Animals owned by Melody Pond
SELECT name FROM animals
  JOIN owners ON animals.owner_id = owners.id
  WHERE full_name = 'Melody Pond';

-- List all animals that are of tyoe Pokemon
SELECT A.name, A.id FROM animals A
  JOIN species S ON A.species_id = S.id
  WHERE A.name = 'Pokemon';

-- List all owners and their animals including those that don't own any animal.
SELECT full_name, name FROM animals
  FULL JOIN owners ON animals.owner_id = owners.id;

-- Get how many animals there are per species
SELECT S.id, S.name, COUNT(*) FROM animals A
  RIGHT JOIN species S ON A.species_id = S.id
  GROUP BY S.id;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.id, A.name FROM  animals A
  JOIN species S ON A.species_id = S.id
  JOIN owners O ON A.owner_id = O.id
  WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.id, A.name FROM animals A
  JOIN owners O ON A.owner_id = O.id
  WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

-- Tell who owns the most animals
SELECT O.id, O.full_name, COUNT(A.owner_id) FROM animals A
  JOIN owners O ON A.owner_id = O.id
  GROUP BY O.id
  ORDER BY COUNT(A.owner_id) DESC;

-- Get the last animal seen by William Tatcher
SELECT O.id, O.full_name, Vs.visit_date FROM animals A
  JOIN visits Vs ON A.id = Vs.animal_id
  JOIN vets V ON Vs.vet_id = V.id
  JOIN owners O ON A.owner_id = O.id
  WHERE V.name = 'William Tatcher'
  ORDER BY Vs.visit_date DESC
  LIMIT 1;

-- Get the number of different animals Stephanie Mendez saw
SELECT COUNT(DISTINCT A.id) FROM animals A
  JOIN visits Vs ON A.id = Vs.animal_id
  JOIN vets V ON Vs.vet_id = V.id
  WHERE V.name = 'Stephanie Mendez';

-- Get list of all vets and their specialties, including vets with no specialties.
SELECT V.id, V.name, Sp.name FROM vets V
  LEFT JOIN specializations S ON v.id = S.vet_id
  LEFT JOIN species Sp ON Sp.id = S.species_id;

-- Get list of all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT DISTINCT A.id, A.name FROM animals A
  JOIN visits Vs ON Vs.animal_id = A.id
  JOIN vets V ON V.id = Vs.vet_id
  WHERE V.name = 'Stephanie Mendez' AND Vs.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- Get the animal having the most visits to vets
SELECT A.id, A.name, COUNT(A.id) FROM visits Vs
  JOIN animals A ON A.id = Vs.animal_id
  GROUP BY A.id ORDER BY COUNT(A.id) DESC
  LIMIT 1;

-- Get who was Maisy Smith's first visit
SELECT A.id, A.name, Vs.visit_date FROM animals A
  JOIN visits Vs ON Vs.animal_id = A.id
  JOIN vets V ON V.id = Vs.vet_id
  WHERE V.name = 'Maisy Smith'
  ORDER BY Vs.visit_date ASC
  LIMIT 1;
