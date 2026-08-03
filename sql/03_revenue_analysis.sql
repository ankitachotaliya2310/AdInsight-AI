/*
===============================================================================
Project      : AdInsight AI
Module       : 03 - Revenue Analytics
Author       : Ankita
Dataset      : Google Analytics Sample Dataset (BigQuery)

Objective:
Analyze revenue performance across different dimensions to identify
high-performing marketing channels, campaigns, devices, countries,
and revenue trends.

===============================================================================
*/


/******************************************************************************
BUSINESS QUESTION 1
-------------------------------------------------------------------------------
Question:
Which traffic sources generate the highest revenue?

Why it matters:
Traffic volume alone does not determine business success.
This query identifies which acquisition sources generate the highest revenue.

Business Use:
• Allocate marketing budget
• Improve SEO and SEM strategies
• Optimize acquisition channels
******************************************************************************/

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

LIMIT 15;



/******************************************************************************
BUSINESS QUESTION 2
-------------------------------------------------------------------------------
Question:
Which marketing channels generate the highest revenue?

Business Use:
Compare Organic Search, Direct, Referral, Social, etc.
******************************************************************************/

SELECT

    channelGrouping,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    channelGrouping

ORDER BY
    revenue DESC;



/******************************************************************************
BUSINESS QUESTION 3
-------------------------------------------------------------------------------
Question:
Which campaigns generate the highest revenue?

Business Use:
Identify high-performing advertising campaigns.
******************************************************************************/

SELECT

    trafficSource.campaign,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    trafficSource.campaign

ORDER BY
    revenue DESC

LIMIT 15;



/******************************************************************************
BUSINESS QUESTION 4
-------------------------------------------------------------------------------
Question:
Which countries generate the highest revenue?

Business Use:
Identify high-value markets.
******************************************************************************/

SELECT

    geoNetwork.country,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    COUNT(*) AS sessions,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    geoNetwork.country

ORDER BY
    revenue DESC

LIMIT 20;



/******************************************************************************
BUSINESS QUESTION 5
-------------------------------------------------------------------------------
Question:
Which devices generate the highest revenue?

Business Use:
Optimize website experience for the highest-value devices.
******************************************************************************/

SELECT

    device.deviceCategory,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    COUNT(*) AS sessions,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device.deviceCategory

ORDER BY
    revenue DESC;



/******************************************************************************
BUSINESS QUESTION 6
-------------------------------------------------------------------------------
Question:
What is the monthly revenue trend?

Business Use:
Understand seasonality and business growth.
******************************************************************************/

SELECT

    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS month,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    month

ORDER BY
    month;



/******************************************************************************
BUSINESS QUESTION 7
-------------------------------------------------------------------------------
Question:
What is the Average Order Value (AOV)?

Business Use:
Measure the average revenue generated per transaction.
******************************************************************************/

SELECT

    ROUND(
        SAFE_DIVIDE(
            SUM(IFNULL(totals.transactionRevenue,0))/1000000,
            SUM(IFNULL(totals.transactions,0))
        ),
        2
    ) AS average_order_value;



/******************************************************************************
BUSINESS QUESTION 8
-------------------------------------------------------------------------------
Question:
Which day generated the highest revenue?

Business Use:
Identify peak revenue days.
******************************************************************************/

SELECT

    PARSE_DATE('%Y%m%d',date) AS transaction_date,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    transaction_date

ORDER BY
    revenue DESC

LIMIT 20;



/******************************************************************************
BUSINESS QUESTION 9
-------------------------------------------------------------------------------
Question:
Which browsers generate the highest revenue?

Business Use:
Optimize browser compatibility for revenue-generating users.
******************************************************************************/

SELECT

    device.browser,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device.browser

ORDER BY
    revenue DESC

LIMIT 15;



/******************************************************************************
BUSINESS QUESTION 10
-------------------------------------------------------------------------------
Question:
Which operating systems generate the highest revenue?

Business Use:
Prioritize optimization for high-value operating systems.
******************************************************************************/

SELECT

    device.operatingSystem,

    ROUND(SUM(IFNULL(totals.transactionRevenue,0))/1000000,2) AS revenue,

    SUM(IFNULL(totals.transactions,0)) AS transactions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device.operatingSystem

ORDER BY
    revenue DESC;