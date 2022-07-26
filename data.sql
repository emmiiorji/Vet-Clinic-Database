/* Populate database with sample data. */

INSERT INTO 
  animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Agumon', '2020-02-03', 0, TRUE, 10.23),
  ('Gabumon', '2018-11-15', 2, TRUE, 8.0),
  ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
  ('Devimon', '2017-12-05', 5, TRUE, 11.0)
RETURNING *;

INSERT INTO
  animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Charmander', '2020-02-08', 0, FALSE, -11),
  ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
  ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
  ('Angemon', '2005-06-12', 1, TRUE, -45),
  ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
  ('Blossom', '1998-10-13', 3, TRUE, 17.0),
  ('Ditto', '2022-05-14', 4, TRUE, 22.0)
RETURNING *;


INSERT INTO
  owners (full_name, age)
  VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38)
RETURNING *;

INSERT INTO
  species(name)
  VALUES
    ('Pokemon'),
    ('Digimon')
RETURNING *;

BEGIN;
  UPDATE animals
    SET species_id=2 WHERE name LIKE '%mon';

  UPDATE animals
    SET species_id=1 WHERE name NOT LIKE '%mon';
COMMIT;

BEGIN;

  UPDATE animals
    SET owner_id=1 WHERE name='Agumon';

  UPDATE animals
    SET owner_id=2 WHERE name='Gabumon' OR name='Pikachu';

  UPDATE animals
    SET owner_id=3 WHERE name='Devimon' OR name='Plantmon';
  
  UPDATE animals
    SET owner_id=4 WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';

  UPDATE animals
    SET owner_id=5 WHERE name='Angemon' OR name='Boarmon';

COMMIT;

INSERT INTO
  vets(name, age, date_of_graduation)
  VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08')
RETURNING *;

INSERT INTO
  specializations(vet_id, species_id)
  VALUES
  (1, 1),
  (3, 2),
  (3, 1),
  (4, 2)
RETURNING *;

INSERT INTO
  visits(animal_id, vet_id, visit_date)
  VALUES
  (1, 1, '2020-05-24'),
  (1, 3, '2020-07-22'),
  (2, 4, '2021-02-02'),
  (3, 2, '2020-01-05'),
  (3, 2, '2020-03-08'),
  (3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),
  (34, 4, '2021-02-24'),
  (35, 2, '2019-12-21'),
  (35, 1, '2020-08-10'),
  (35, 2, '2021-04-07'),
  (36, 3, '2019-09-29'),
  (37, 4, '2020-10-03'),
  (37, 4, '2020-11-04'),
  (38, 2, '2019-01-24'),
  (38, 2, '2019-05-15'),
  (38, 2, '2020-02-27'),
  (38, 2, '2020-08-03'),
  (39, 3, '2020-05-24'),
  (39, 1, '2021-01-11')
RETURNING *;