/*
=======================================
1. ROW COUNT VALIDATION 
=======================================
*/

SELECT 'Accounts', COUNT(*) AS Total_Rows
FROM accounts

UNION ALL 

SELECT 'subscriptions', COUNT (*)
FROM subscriptions

UNION ALL


SELECT 'churn_events', COUNT (*)
FROM churn_events 

UNION ALL 

SELECT 'feature_usage', COUNT (*)
FROM feature_usage

UNION ALL 

SELECT 'support_tickets', COUNT (*)
FROM support_tickets;