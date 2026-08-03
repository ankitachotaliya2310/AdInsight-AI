/*
===============================================================================
Project      : AdInsight AI
Module       : 02 - User Behavior Analytics
Author       : Ankita
Dataset      : Google Analytics Sample Dataset (BigQuery)

Objective:
Analyze user engagement and behavior after visitors arrive on the website.
The goal is to understand how users interact with the website, identify
high-value users, and discover opportunities to improve engagement and
conversion rates.

===============================================================================
*/


/******************************************************************************
BUSINESS QUESTION 1
-------------------------------------------------------------------------------
Question:
How many new and returning visitors come from each marketing channel?

Why it matters:
Knowing whether users are new or returning helps marketers evaluate customer
loyalty and acquisition performance.

Business Use:
• Measure customer retention.
• Compare acquisition channels.
• Improve remarketing campaigns.
******************************************************************************/

SELECT

    channelGrouping,

    SUM(IFNULL(totals.newVisits,0)) AS new_visitors,

    COUNT(*) - SUM(IFNULL(totals.newVisits,0)) AS returning_visitors

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    channelGrouping

ORDER BY
    new_visitors DESC;



/******************************************************************************
BUSINESS QUESTION 2
-------------------------------------------------------------------------------
Question:
Which device category has the highest user engagement?

Why it matters:
Understanding device performance helps optimize user experience across
Desktop, Mobile and Tablet devices.

Business Use:
• Improve mobile experience.
• Optimize responsive website design.
• Prioritize development efforts.
******************************************************************************/

SELECT

    device.deviceCategory AS device,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    ROUND(AVG(IFNULL(totals.hits,0)),2) AS average_hits

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device

ORDER BY
    average_pageviews DESC;



/******************************************************************************
BUSINESS QUESTION 3
-------------------------------------------------------------------------------
Question:
Which traffic source generates the highest average page views?

Why it matters:
Average page views indicate how engaged users are after arriving from
different traffic sources.

Business Use:
• Identify high-quality traffic.
• Improve marketing investment.
• Optimize acquisition channels.
******************************************************************************/

SELECT

    trafficSource.source AS source,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    source

ORDER BY
    average_pageviews DESC

LIMIT 15;



/******************************************************************************
BUSINESS QUESTION 4
-------------------------------------------------------------------------------
Question:
Which countries have the highest user engagement?

Why it matters:
Understanding geographical engagement helps identify high-value markets.

Business Use:
• Target advertising campaigns.
• Personalize regional marketing.
• Expand into high-performing countries.
******************************************************************************/

SELECT

    geoNetwork.country,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    geoNetwork.country

ORDER BY
    average_pageviews DESC

LIMIT 20;



/******************************************************************************
BUSINESS QUESTION 5
-------------------------------------------------------------------------------
Question:
Which browsers are used by the most engaged users?

Why it matters:
Browser compatibility issues may reduce user engagement.

Business Use:
• Improve browser compatibility.
• Prioritize browser testing.
******************************************************************************/

SELECT

    device.browser,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device.browser

ORDER BY
    average_pageviews DESC

LIMIT 15;



/******************************************************************************
BUSINESS QUESTION 6
-------------------------------------------------------------------------------
Question:
Which operating systems generate the highest engagement?

Why it matters:
Different operating systems may have different user experiences.

Business Use:
• Improve platform-specific optimization.
• Identify operating systems requiring improvements.
******************************************************************************/

SELECT

    device.operatingSystem,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    device.operatingSystem

ORDER BY
    average_pageviews DESC;



/******************************************************************************
BUSINESS QUESTION 7
-------------------------------------------------------------------------------
Question:
Which marketing channels generate users with the highest average page views?

Why it matters:
Traffic quality is more important than traffic quantity.

Business Use:
• Allocate advertising budget efficiently.
• Improve campaign targeting.
******************************************************************************/

SELECT

    channelGrouping,

    ROUND(AVG(IFNULL(totals.pageviews,0)),2) AS average_pageviews,

    COUNT(*) AS sessions

FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY
    channelGrouping

ORDER BY
    average_pageviews DESC;



/******************************************************************************
BUSINESS QUESTION 8
-------------------------------------------------------------------------------
Question:
Which device category has the highest conversion rate?

Why it matters:
Conversion rate helps identify the devices that generate the highest business
value.

Business Use:
• Optimize checkout experience.
• Improve conversion on low-performing devices.
******************************************************************************/

SELECT

    device.deviceCategory,

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
    device.deviceCategory

ORDER BY
    conversion_rate_percent DESC;