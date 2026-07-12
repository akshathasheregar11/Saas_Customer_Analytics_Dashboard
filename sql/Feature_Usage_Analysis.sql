/*
=========================================================
Feature Usage Analysis

Objective:
Analyze customer feature adoption, engagement
patterns and product usage across subscription plans.

=========================================================
*/

---------------------------------------------------------
-- Overall Feature Usage
---------------------------------------------------------

SELECT
    COUNT(*) AS Total_Usage_Events,
    SUM(usage_count) AS Total_Usage,
    AVG(usage_duration_secs) AS Average_Usage_Duration
FROM feature_usage;



---------------------------------------------------------
-- Most Used Features
---------------------------------------------------------

SELECT
    feature_name,
    SUM(usage_count) AS Total_Usage
FROM feature_usage
GROUP BY feature_name
ORDER BY Total_Usage DESC;



---------------------------------------------------------
-- Feature Usage by Subscription Plan
---------------------------------------------------------

SELECT
    s.plan_tier,
    f.feature_name,
    SUM(f.usage_count) AS Total_Usage

FROM feature_usage f

JOIN subscriptions s
ON f.subscription_id = s.subscription_id

GROUP BY
    s.plan_tier,
    f.feature_name

ORDER BY
    s.plan_tier,
    Total_Usage DESC;



---------------------------------------------------------
-- Average Usage Duration by Feature
---------------------------------------------------------

SELECT
    feature_name,
    AVG(usage_duration_secs) AS Average_Usage_Duration
FROM feature_usage
GROUP BY feature_name
ORDER BY Average_Usage_Duration DESC;



---------------------------------------------------------
-- Top 10 Most Active Subscriptions
---------------------------------------------------------

SELECT TOP 10

    subscription_id,

    SUM(usage_count) AS Total_Usage

FROM feature_usage

GROUP BY subscription_id

ORDER BY Total_Usage DESC;



---------------------------------------------------------
-- Feature Usage by Industry
---------------------------------------------------------

SELECT

    a.industry,

    SUM(f.usage_count) AS Total_Usage

FROM feature_usage f

JOIN subscriptions s
ON f.subscription_id = s.subscription_id

JOIN accounts a
ON s.account_id = a.account_id

GROUP BY a.industry

ORDER BY Total_Usage DESC;
Select *
From feature_usage;