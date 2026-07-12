/*
=========================================================
Support Analysis

Objective:
Analyze customer support performance, response
times and customer satisfaction.

=========================================================
*/

---------------------------------------------------------
-- Support KPI Summary
---------------------------------------------------------

SELECT

    COUNT(*) AS Total_Tickets,

    AVG(resolution_time_hours) AS Average_Resolution_Time,

    AVG(first_response_time_minutes) AS Average_First_Response_Time,

    AVG(satisfaction_score) AS Average_Satisfaction_Score,

    SUM(CASE WHEN escalation_flag = 1 THEN 1 ELSE 0 END) AS Escalated_Tickets

FROM support_tickets;



---------------------------------------------------------
-- Tickets by Priority
---------------------------------------------------------

SELECT

    priority,

    COUNT(*) AS Total_Tickets,

    AVG(resolution_time_hours) AS Average_Resolution_Time,

    AVG(satisfaction_score) AS Average_Satisfaction_Score

FROM support_tickets

GROUP BY priority

ORDER BY Total_Tickets DESC;



---------------------------------------------------------
-- Customer Support Performance
---------------------------------------------------------

SELECT

    account_id,

    COUNT(ticket_id) AS Total_Tickets,

    AVG(resolution_time_hours) AS Average_Resolution_Time,

    AVG(satisfaction_score) AS Average_Satisfaction_Score

FROM support_tickets

GROUP BY account_id

ORDER BY Total_Tickets DESC;



---------------------------------------------------------
-- Escalation Analysis
---------------------------------------------------------

SELECT

    escalation_flag,

    COUNT(*) AS Total_Tickets,

    AVG(resolution_time_hours) AS Average_Resolution_Time,

    AVG(satisfaction_score) AS Average_Satisfaction_Score

FROM support_tickets

GROUP BY escalation_flag;



---------------------------------------------------------
-- Customers with Slowest Resolution Time
---------------------------------------------------------

SELECT TOP 10

    account_id,

    resolution_time_hours,

    satisfaction_score

FROM support_tickets

ORDER BY resolution_time_hours DESC;