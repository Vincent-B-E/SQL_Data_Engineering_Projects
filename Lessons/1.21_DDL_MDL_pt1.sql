-- .read Lessons/1.21_DDL_MDL_pt1.sql

USE data_jobs; -- any db that is not job_mart

DROP DATABASE IF EXISTS job_mart;

CREATE DATABASE IF NOT EXISTS job_mart;

SHOW DATABASES;

SELECT catalog_name, schema_name
FROM information_schema.schemata;

-- CREATE SCHEMA job_mart.staging;
-- or,
USE job_mart;
CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA staging;

CREATE TABLE staging.preferred_roles ( 
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT table_catalog, table_schema, table_name
FROM information_schema.tables
WHERE table_catalog = 'job_mart'; 

DROP TABLE IF EXISTS main.preferred_roles;

INSERT INTO staging.preferred_roles 
    (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

-- ALTER TABLE staging.preferred_roles
-- ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id in (1, 2);

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;