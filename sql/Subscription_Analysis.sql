/*
=========================================================
Subscription Analysis

Objective:
Analyze subscription trends, customer lifecycle,
plan adoption and subscription behaviour.

=========================================================
*/

---------------------------------------------------------
-- Subscription KPI Summary
---------------------------------------------------------

SELECT

    COUNT(*) AS Total_Subscriptions,

    SUM(CASE WHEN is_trial = 1 THEN 1 ELSE 0 END) AS Trial_Subscriptions,

    SUM(CASE WHEN churn_flag = 1 THEN 1 ELSE 0 END) AS Churned_Subscriptions,

    SUM(CASE WHEN auto_renew_flag = 1 THEN 1 ELSE 0 END) AS Auto_Renew_Subscriptions,

    SUM(CASE WHEN upgrade_flag = 1 THEN 1 ELSE 0 END) AS Upgraded_Subscriptions,

    SUM(CASE WHEN downgrade_flag = 1 THEN 1 ELSE 0 END) AS Downgraded_Subscriptions,

    AVG(seats) AS Average_Seats

FROM subscriptions;


---------------------------------------------------------
-- Subscription Distribution by Plan Tier
---------------------------------------------------------

SELECT

    plan_tier,

    COUNT(*) AS Total_Subscriptions,
     
    AVG(seats) AS Average_Seats,

    SUM(mrr_amount) AS Total_MRR

FROM subscriptions

GROUP BY plan_tier

ORDER BY Total_Subscriptions DESC;



---------------------------------------------------------
-- Billing Frequency Analysis
---------------------------------------------------------

SELECT

    billing_frequency,

    COUNT(*) AS Total_Subscriptions,

    SUM(mrr_amount) AS Total_MRR,

    SUM(arr_amount) AS Total_ARR

FROM subscriptions

GROUP BY billing_frequency

ORDER BY Total_Subscriptions DESC;



---------------------------------------------------------
-- Subscription Duration Analysis
---------------------------------------------------------

SELECT

   AVG(DATEDIFF(DAY, start_date, end_date)) AS Average_Subscription_Days,

    MIN(DATEDIFF(DAY,start_date,end_date))
        AS Minimum_Subscription_Days,

    MAX(DATEDIFF(DAY,start_date,end_date))
        AS Maximum_Subscription_Days

FROM subscriptions

WHERE end_date IS NOT NULL;



---------------------------------------------------------
-- Customers with Multiple Subscriptions
---------------------------------------------------------

SELECT

    account_id,

    COUNT(subscription_id) AS Total_Subscriptions,

    SUM(mrr_amount) AS Total_MRR

FROM subscriptions

GROUP BY account_id

HAVING COUNT(subscription_id) > 1

ORDER BY Total_Subscriptions DESC;