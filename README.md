# Revenue Leakage & Denial Risk Prediction Analytics

## About This Project
Insurance companies reject a lot of medical claims, sometimes for valid reasons, 
sometimes not and every rejected claim means the hospital doesn't get paid, or 
gets paid late. This project analyzes 120,000 real-style claims to find out why 
claims get denied, how much money that's costing, and builds a model that can 
predict which future claims are at risk of denial before they're even submitted — 
plus a Power BI dashboard summarizing revenue leakage, denial trends, and the highest-risk payers.

## Tools Used
- SQL (SQLite) — data modeling and querying
- Python (Pandas, scikit-learn) — data cleaning, EDA, predictive modeling
- Power BI — dashboard and visualization

## Dataset
DenialIQ: 120K synthetic medical claims with real X12 denial codes, sourced from Kaggle.
(link: kaggle.com/datasets/nudratabbas/denialiq-120k-medical-claims-x12-denial-codes)

Note: Data is synthetically generated to simulate realistic claims patterns, since 
real healthcare claims data isn't publicly available due to privacy regulations 
(HIPAA). The analysis techniques used here apply directly to real claims data.

## Project Steps
1. Data exploration (Python/Pandas) — *done
2. SQL schema design & queries — *done*
3. Data cleaning & EDA (Python) — *done*
4. Predictive model — denial risk (Python) — *done*
5. Power BI dashboard — *done*

## Key Findings
- 28% of claims are outright denied; 48% don't result in full expected payment
- Payer type and claim amount have no meaningful effect on denial rate
- Missing prior authorization is a major driver: 71% denial rate vs 21% when obtained, representing $27.8M in at-risk revenue
- Documentation completeness is the strongest predictor: near step-function relationship from 88% denied (Low) to 0% denied (Very High)
- A Logistic Regression model achieved 91.5% accuracy predicting denial risk, confirming documentation completeness as the dominant factor


## Why this matters beyond healthcare
The same technique (leakage detection + risk prediction) applies to loan defaults 
in finance, churn in subscriptions, and fraud in ecommerce.
