-- Escalation Flow
WITH RECURSIVE EscalationFlow AS (
    SELECT InteractionID, AgentID, EscalatedTo, Level
    FROM Escalations
    WHERE EscalatedTo IS NULL
    UNION ALL
    SELECT e.InteractionID, e.AgentID, e.EscalatedTo, e.Level
    FROM Escalations e
    JOIN EscalationFlow ef ON e.EscalatedTo = ef.AgentID
)
SELECT * FROM EscalationFlow;

-- Most Escalated Agents
SELECT AgentID,
       COUNT(*) AS EscalationCount,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS EscalationRank
FROM Escalations
GROUP BY AgentID;
