-- Master build script for data warehouse and mart pipeline
-- This file runs all steps in sequence to build the complete warehouse and marts
--
-- Usage (Local):
--   Run this script with: duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- Step 1: Create star schema tables
.read 01_create_tables_dw.sql

-- Step 2: Load data from csv into tables
.read 02_load_schema_dw.sql