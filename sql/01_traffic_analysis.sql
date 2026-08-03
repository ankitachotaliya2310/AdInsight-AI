/*
=============================================================
Project : AdInsight AI
Module  : Traffic Analytics
Author  : Ankita
Purpose : Analyze website traffic sources using Google Analytics
=============================================================
*/

-------------------------------------------------------------
-- Query 1
-- Business Question:
-- Which traffic sources bring the highest number of sessions?
--
-- Why it matters:
-- Helps marketers understand where website visitors are coming
-- from so they can prioritize the most effective acquisition
-- channels.
-------------------------------------------------------------

SELECT
    trafficSource.source AS source,
    COUNT(*) AS sessions
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY
    source
ORDER BY
    sessions DESC
LIMIT 10;



-------------------------------------------------------------
-- Query 2
-- Business Question:
-- What tables are available in the Google Analytics sample
-- dataset?
--
-- Why it matters:
-- Before analyzing data, a data scientist needs to understand
-- the available tables and how the data is organized.
-------------------------------------------------------------

SELECT
    table_name
FROM
    `bigquery-public-data.google_analytics_sample.INFORMATION_SCHEMA.TABLES`
LIMIT 10;



-------------------------------------------------------------
-- Query 3
-- Business Question:
-- What columns and nested fields exist in one day's session
-- data?
--
-- Why it matters:
-- Understanding the schema helps identify useful variables
-- such as traffic source, device, geography, revenue, and
-- transactions before performing analysis.
-------------------------------------------------------------

SELECT *
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
LIMIT 5;



-------------------------------------------------------------
-- Query 4
-- Business Question:
-- Which traffic sources generate the highest revenue and
-- transactions?
--
-- Why it matters:
-- Marketing teams want to know which acquisition channels
-- generate the greatest business value, not just the most
-- visitors.
-------------------------------------------------------------

SELECT
    trafficSource.source AS source,

    SUM(IFNULL(totals.transactionRevenue,0))/1000000 AS revenue,

    COUNT(*) AS sessions,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    source

ORDER BY
    revenue DESC

LIMIT 10;