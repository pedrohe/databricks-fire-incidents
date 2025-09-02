
-- Databricks notebook source
-- Bronze já populada automaticamente
SELECT * FROM fire_data.bronze_fire_incidents
LIMIT 10;



-- COMMAND ----------

-- Criar tabela Silver (se ainda não existir)
CREATE TABLE IF NOT EXISTS fire_data.silver_fire_incidents
USING DELTA;


-- COMMAND ----------

DESCRIBE TABLE fire_data.bronze_fire_incidents;



-- COMMAND ----------

CREATE OR REPLACE TABLE fire_data.silver_fire_incidents AS
SELECT
    `Incident Number`      AS incident_number,
    `Exposure Number`      AS exposure_number,
    ID,
    Address,
    `Incident Date`        AS incident_date,
    City,
    Battalion              AS battalion,
    Box,
    point
FROM fire_data.bronze_fire_incidents;



-- COMMAND ----------

-- Criar tabela Gold vazia para resumo agregado
CREATE TABLE IF NOT EXISTS fire_data.gold_fire_summary (
    year INT,
    month INT,
    battalion STRING,
    total_incidents BIGINT
)
USING DELTA;



-- COMMAND ----------

-- Inserir dados agregados na tabela Gold
INSERT INTO fire_data.gold_fire_summary
SELECT
    YEAR(incident_date) AS year,
    MONTH(incident_date) AS month,
    battalion,
    COUNT(*) AS total_incidents
FROM fire_data.silver_fire_incidents
GROUP BY YEAR(incident_date), MONTH(incident_date), battalion;


-- COMMAND ----------

-- Verificar os dados agregados na Gold
SELECT * FROM fire_data.gold_fire_summary
ORDER BY year, month, battalion;


-- COMMAND ----------

-- Total de incidentes por ano
SELECT
    year,
    SUM(total_incidents) AS total_anual
FROM fire_data.gold_fire_summary
GROUP BY year
ORDER BY year;


-- COMMAND ----------

-- Total de incidentes por mês (somando todos os anos)
SELECT
    month,
    SUM(total_incidents) AS total_mensal
FROM fire_data.gold_fire_summary
GROUP BY month
ORDER BY month;
