/*
=========================================================
Data_Profiling

Purpose:
Understand the overall SaaS business before analysis.

=========================================================
*/

---------------------------------------------------------
-- 1. Total Accounts
---------------------------------------------------------

SELECT
COUNT(*) AS Total_Accounts
FROM accounts;


---------------------------------------------------------
-- 2. Total Subscriptions
---------------------------------------------------------

SELECT
COUNT(*) AS Total_Subscriptions
FROM subscriptions;


---------------------------------------------------------
-- 3. Trial vs Paid Subscriptions
---------------------------------------------------------

SELECT
is_trial,
COUNT(*) AS Total_Subscriptions
FROM subscriptions
GROUP BY is_trial;


---------------------------------------------------------
-- 4. Churned vs Active Subscriptions
---------------------------------------------------------

SELECT
churn_flag,
COUNT(*) AS Total_Subscriptions
FROM subscriptions
GROUP BY churn_flag;


---------------------------------------------------------
-- 5. Subscription Plan Distribution
---------------------------------------------------------

SELECT
plan_tier,
COUNT(*) AS Total_Customers
FROM subscriptions
GROUP BY plan_tier
ORDER BY Total_Customers DESC;


---------------------------------------------------------
-- 6. Billing Frequency Distribution
---------------------------------------------------------

SELECT
billing_frequency,
COUNT(*) AS Total_Customers
FROM subscriptions
GROUP BY billing_frequency
ORDER BY Total_Customers DESC;


---------------------------------------------------------
-- 7. Auto Renew Distribution
---------------------------------------------------------

SELECT
auto_renew_flag,
COUNT(*) AS Customers
FROM subscriptions
GROUP BY auto_renew_flag;


---------------------------------------------------------
-- 8. Upgrade & Downgrade Distribution
---------------------------------------------------------

SELECT
SUM(CASE WHEN upgrade_flag = 1 THEN 1 ELSE 0 END) AS Upgrades,
SUM(CASE WHEN downgrade_flag = 1 THEN 1 ELSE 0 END) AS Downgrades
FROM subscriptions;


---------------------------------------------------------
-- 9. Revenue Summary
---------------------------------------------------------

SELECT

SUM(mrr_amount) AS Total_MRR,

SUM(arr_amount) AS Total_ARR,

AVG(mrr_amount) AS Avg_MRR,

AVG(arr_amount) AS Avg_ARR,

MIN(mrr_amount) AS Minimum_MRR,

MAX(mrr_amount) AS Maximum_MRR

FROM subscriptions;


---------------------------------------------------------
-- 10. Seat Statistics
---------------------------------------------------------

SELECT

SUM(seats) AS Total_Seats,

AVG(seats) AS Average_Seats,

MIN(seats) AS Minimum_Seats,

MAX(seats) AS Maximum_Seats

FROM subscriptions;


---------------------------------------------------------
-- 11. Top 10 Highest Revenue Customers
---------------------------------------------------------

SELECT TOP 10

account_id,

plan_tier,

mrr_amount,

arr_amount

FROM subscriptions

ORDER BY mrr_amount DESC;


---------------------------------------------------------
-- 12. Feature Usage Summary
---------------------------------------------------------

SELECT

COUNT(*) AS Total_Feature_Events,

COUNT(DISTINCT subscription_id) AS Subscriptions_Using_Features

FROM feature_usage;


---------------------------------------------------------
-- 13. Most Used Features
---------------------------------------------------------

SELECT

feature_name,

SUM(usage_count) AS Total_Usage

FROM feature_usage

GROUP BY feature_name

ORDER BY Total_Usage DESC;


---------------------------------------------------------
-- 14. Support Ticket Overview
---------------------------------------------------------

SELECT

COUNT(*) AS Total_Tickets,

COUNT(DISTINCT account_id) AS Customers_Raised_Tickets

FROM support_tickets;


---------------------------------------------------------
-- 15. Churn Events Overview
---------------------------------------------------------

SELECT

COUNT(*) AS Total_Churn_Events,

COUNT(DISTINCT account_id) AS Customers_Churned

FROM churn_events;