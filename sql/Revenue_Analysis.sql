/*
=========================================================
Revenue Analysis
Project : Subscription & Churn Analytics

Objective:
Analyze recurring revenue to understand revenue
distribution across subscription plans, billing
frequencies, customer segments and geography.

=========================================================
*/
---------------------------------------------------------
-- Revenue Overview
---------------------------------------------------------

-- Total Monthly Recurring Revenue (MRR)
-- Total Annual Recurring Revenue (ARR)

SELECT
    SUM(mrr_amount) AS Total_MRR,
    SUM(arr_amount) AS Total_ARR
FROM subscriptions;



---------------------------------------------------------
-- Average Revenue Per Subscription
---------------------------------------------------------

SELECT

    ROUND(AVG(mrr_amount),2) AS Average_MRR,
    ROUND(AVG(arr_amount),2) AS Average_ARR

FROM subscriptions;



---------------------------------------------------------
-- Revenue by Subscription Plan
---------------------------------------------------------

SELECT

    plan_tier,

    COUNT(*) AS Total_Subscriptions,

    SUM(mrr_amount) AS Total_MRR,

    SUM(arr_amount) AS Total_ARR,

    ROUND(AVG(mrr_amount),2) AS Average_MRR

FROM subscriptions

GROUP BY plan_tier

ORDER BY Total_MRR DESC;



---------------------------------------------------------
-- Revenue by Billing Frequency
---------------------------------------------------------

SELECT

    billing_frequency,

    COUNT(*) AS Total_Subscriptions,

    SUM(mrr_amount) AS Total_MRR,

    SUM(arr_amount) AS Total_ARR

FROM subscriptions

GROUP BY billing_frequency

ORDER BY Total_MRR DESC;



---------------------------------------------------------
-- Top 10 Highest Revenue Customers
---------------------------------------------------------

SELECT TOP 10

    account_id,

    subscription_id,

    plan_tier,

    seats,

    mrr_amount,

    arr_amount

FROM subscriptions

ORDER BY mrr_amount DESC;



---------------------------------------------------------
-- Revenue by Industry
---------------------------------------------------------

SELECT

    a.industry,

    COUNT(*) AS Customers,

    SUM(s.mrr_amount) AS Total_MRR,

    SUM(s.arr_amount) AS Total_ARR

FROM accounts a

JOIN subscriptions s

ON a.account_id = s.account_id

GROUP BY a.industry

ORDER BY Total_MRR DESC;



---------------------------------------------------------
-- Revenue by Country
---------------------------------------------------------

SELECT

    a.country,

    COUNT(*) AS Customers,

    SUM(s.mrr_amount) AS Total_MRR,

    SUM(s.arr_amount) AS Total_ARR

FROM  accounts a

JOIN  subscriptions s

ON a.account_id = s.account_id

GROUP BY a.country

ORDER BY Total_MRR DESC;



---------------------------------------------------------
-- Customers Generating Above Average Revenue
---------------------------------------------------------

SELECT

    account_id,

    subscription_id,

    plan_tier,

    mrr_amount

FROM subscriptions

WHERE mrr_amount >

(
    SELECT AVG(mrr_amount)

    FROM subscriptions
)

ORDER BY mrr_amount DESC;



---------------------------------------------------------
-- Customer Revenue Ranking
---------------------------------------------------------

SELECT

    account_id,

    subscription_id,

    mrr_amount,

    RANK() OVER
    (
        ORDER BY mrr_amount DESC
    ) AS Revenue_Rank

FROM subscriptions;



---------------------------------------------------------
-- Revenue Contribution by Subscription Plan
---------------------------------------------------------

SELECT

    plan_tier,

    SUM(mrr_amount) AS Total_MRR,

    ROUND
    (
        100.0 * SUM(mrr_amount) /
        (
            SELECT SUM(mrr_amount)
            FROM subscriptions
        ),
        2
    ) AS Revenue_Percentage

FROM subscriptions

GROUP BY plan_tier

ORDER BY Revenue_Percentage DESC;