-- Query 1: Count of total claims per insurance payer type
SELECT payer_type, COUNT(*) AS Total_Claims
FROM claims
GROUP BY payer_type;


-- Query 2: Total claims per payer, using a JOIN to link claims and payers tables
SELECT p.payer_type, COUNT(*) AS Total_Claims
FROM claims c
JOIN payers p ON c.payer_id = p.payer_id
GROUP BY p.payer_type;


-- Query 3: Total dollar value of claims at risk due to missing prior authorization
SELECT SUM(claim_amount_usd) AS total_at_risk
FROM claims
WHERE prior_auth_required = 1 AND prior_auth_obtained = 0;


-- Query 4: Denial rate by documentation completeness bucket
-- Uses <= for boundaries to include exact cutoff values (0.58, 0.78, 0.88) in the lower bucket
SELECT 
    CASE 
        WHEN documentation_completeness <= 0.58 THEN 'Low'
        WHEN documentation_completeness <= 0.78 THEN 'Medium'
        WHEN documentation_completeness <= 0.88 THEN 'High'
        ELSE 'Very High'
    END AS completeness_bucket,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN outcome = 'denied' THEN 1 ELSE 0 END) AS denied_claims
FROM claims
GROUP BY completeness_bucket;
ORDER BY MIN(documentation_completeness);


-- Query 5: Rank payers by denial rate using a window function (RANK)
SELECT 
    p.payer_type,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN c.outcome = 'denied' THEN 1 ELSE 0 END) AS denied_claims,
    RANK() OVER (ORDER BY SUM(CASE WHEN c.outcome = 'denied' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC) AS denial_rank
FROM claims c
JOIN payers p ON c.payer_id = p.payer_id
GROUP BY p.payer_type;