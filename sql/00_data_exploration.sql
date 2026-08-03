/*
===============================================================================
Project      : AdInsight AI
Module       : 00 - Data Exploration
Author       : Ankita
Dataset      : Google Analytics Sample Dataset (BigQuery)
Description  : Initial exploration of the Google Analytics dataset before
               performing traffic, revenue, user behavior, and machine learning
               analysis.
===============================================================================
*/

--------------------------------------------------------------------------------
-- BUSINESS QUESTION 1
-- What tables are available in the Google Analytics Sample dataset?
--
-- Business Value:
-- Before starting analysis, it is important to understand the available
-- tables and how the dataset is organized.
--------------------------------------------------------------------------------

SELECT
    table_name
FROM
    `bigquery-public-data.google_analytics_sample.INFORMATION_SCHEMA.TABLES`
LIMIT 10;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 2
-- Explore one day's session data.
--
-- Business Value:
-- Understand the dataset structure, identify nested fields, and inspect
-- important variables such as:
-- • Traffic Source
-- • Device Information
-- • Geography
-- • Revenue
-- • Transactions
--------------------------------------------------------------------------------

SELECT *
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
LIMIT 5;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 3
-- What is the schema of the session table?
--
-- Business Value:
-- Understanding column names and data types helps during feature engineering
-- and machine learning.
--------------------------------------------------------------------------------

SELECT
    column_name,
    data_type
FROM
    `bigquery-public-data.google_analytics_sample.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS`
WHERE
    table_name = 'ga_sessions_20170801'
ORDER BY
    column_name;