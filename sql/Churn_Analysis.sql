/*
=========================================================
Churn Analysis

Objective:
Analyze customer churn trends and identify key
factors contributing to customer attrition.

=========================================================
*/

---------------------------------------------------------
-- Churn KPI Summary
---------------------------------------------------------

SELECT

    COUNT(*) AS Total_Subscriptions,

    SUM(CASE WHEN churn_flag = 1 THEN 1 ELSE 0 END) AS Churned_Subscriptions,

    SUM(CASE WHEN is_trial = 1 THEN 1 ELSE 0 END) AS Trial_Subscriptions,

    SUM(CASE WHEN auto_renew_flag = 1 THEN 1 ELSE 0 END) AS Auto_Renew_Subscriptions

FROM subscriptions;



---------------------------------------------------------
-- Churn by Subscription Plan
---------------------------------------------------------

SELECT

    plan_tier,

    COUNT(*) AS Total_Subscriptions,

    SUM(CASE WHEN churn_flag = 1 THEN 1 ELSE 0 END) AS Churned_Customers,

    SUM(mrr_amount) AS Total_MRR

FROM subscriptions

GROUP BY plan_tier

ORDER BY Churned_Customers DESC;



---------------------------------------------------------
-- Churn by Billing Characteristics
---------------------------------------------------------

SELECT

    billing_frequency,

    is_trial,

    auto_renew_flag,

    COUNT(*) AS Total_Subscriptions,

    SUM(CASE WHEN churn_flag = 1 THEN 1 ELSE 0 END) AS Churned_Customers

FROM subscriptions

GROUP BY

    billing_frequency,

    is_trial,

    auto_renew_flag

ORDER BY Churned_Customers DESC;



---------------------------------------------------------
-- Churn by Industry and Country
---------------------------------------------------------

SELECT

    a.industry,

    a.country,

    COUNT(*) AS Total_Customers,

    SUM(CASE WHEN s.churn_flag = 1 THEN 1 ELSE 0 END) AS Churned_Customers

FROM accounts a

JOIN subscriptions s

ON a.account_id = s.account_id

GROUP BY

    a.industry,

    a.country

ORDER BY Churned_Customers DESC;



---------------------------------------------------------
-- Most Common Churn Reasons
---------------------------------------------------------

SELECT

    churn_reason,

    COUNT(*) AS Total_Customers

FROM churn_events

GROUP BY churn_reason

ORDER BY Total_Customers DESC;