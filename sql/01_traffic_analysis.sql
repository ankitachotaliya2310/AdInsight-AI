/*
===============================================================================
Project      : AdInsight AI
Module       : 01 - Traffic Analytics
Author       : Ankita
Dataset      : Google Analytics Sample Dataset (BigQuery)
Description  : Analyze website traffic sources, channels, devices, campaigns,
               and user acquisition performance.
===============================================================================
*/

--------------------------------------------------------------------------------
-- BUSINESS QUESTION 1
-- Which traffic sources bring the highest number of sessions?
--
-- Business Value:
-- Identify the primary acquisition sources driving website traffic.
--------------------------------------------------------------------------------

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


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 2
-- Which traffic sources generate the highest revenue?
--
-- Business Value:
-- High traffic does not always generate high revenue.
-- This helps marketing teams prioritize profitable channels.
--------------------------------------------------------------------------------

SELECT
    trafficSource.source AS source,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    COUNT(*) AS sessions,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    source

ORDER BY
    revenue DESC

LIMIT 10;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 3
-- Which marketing mediums generate the highest revenue?
--
-- Business Value:
-- Compare Organic, CPC, Referral, Email and other marketing mediums.
--------------------------------------------------------------------------------

SELECT

    trafficSource.medium AS medium,

    COUNT(*) AS sessions,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    medium

ORDER BY
    revenue DESC;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 4
-- Which marketing campaigns generate the highest revenue?
--
-- Business Value:
-- Identify top-performing campaigns for budget allocation.
--------------------------------------------------------------------------------

SELECT

    trafficSource.campaign AS campaign,

    COUNT(*) AS sessions,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    campaign

ORDER BY
    revenue DESC

LIMIT 15;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 5
-- Which traffic sources have the highest conversion rate?
--
-- Business Value:
-- Measure acquisition quality instead of only traffic volume.
--------------------------------------------------------------------------------

SELECT

    trafficSource.source AS source,

    COUNT(*) AS sessions,

    SUM(IFNULL(totals.transactions,0)) AS transactions,

    ROUND(
        SAFE_DIVIDE(
            SUM(IFNULL(totals.transactions,0)),
            COUNT(*)
        ) * 100,
        2
    ) AS conversion_rate_percent

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    source

HAVING
    sessions > 100

ORDER BY
    conversion_rate_percent DESC

LIMIT 15;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 6
-- Which devices bring the most sessions and revenue?
--
-- Business Value:
-- Understand customer behavior across Desktop, Mobile and Tablet.
--------------------------------------------------------------------------------

SELECT

    device.deviceCategory AS device,

    COUNT(*) AS sessions,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device

ORDER BY
    revenue DESC;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 7
-- Which browsers generate the highest website traffic?
--
-- Business Value:
-- Browser analysis helps identify compatibility and UX priorities.
--------------------------------------------------------------------------------

SELECT

    device.browser AS browser,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    browser

ORDER BY
    sessions DESC

LIMIT 15;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 8
-- Which operating systems generate the most sessions?
--
-- Business Value:
-- Helps prioritize testing and optimization across platforms.
--------------------------------------------------------------------------------

SELECT

    device.operatingSystem AS operating_system,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    operating_system

ORDER BY
    sessions DESC;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 9
-- Which countries generate the highest revenue?
--
-- Business Value:
-- Identify high-value geographic markets for advertising.
--------------------------------------------------------------------------------

SELECT

    geoNetwork.country AS country,

    COUNT(*) AS sessions,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    country

ORDER BY
    revenue DESC

LIMIT 20;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 10
-- Monthly traffic trend
--
-- Business Value:
-- Understand traffic growth over time.
--------------------------------------------------------------------------------

SELECT

    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS month,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    month

ORDER BY
    month;


--------------------------------------------------------------------------------
-- BUSINESS QUESTION 11
-- Monthly revenue trend
--
-- Business Value:
-- Analyze seasonality and revenue growth patterns.
--------------------------------------------------------------------------------

SELECT

    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS month,

    ROUND(
        SUM(IFNULL(totals.transactionRevenue,0))/1000000,
        2
    ) AS revenue

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    month

ORDER BY
    month;