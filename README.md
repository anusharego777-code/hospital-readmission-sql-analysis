# Hospital Readmission SQL Analysis

Which patients come back to hospital within 30 days? This project analyses the UCI Diabetes 130-US Hospitals dataset (101,766 patient records) in MySQL to find what drives 30-day readmission.

## Key findings
- Patients aged 20-30 had the highest 30-day readmission rate: 14.24%
- High medication level with a long hospital stay: 13.96% readmission, vs 7.21% for low medication level with a short stay

## What I did
- Created 3 lookup tables (admission type, discharge disposition, admission source) and joined them to the patient data with LEFT JOINs into one master table
- Used a CTE to calculate 30-day readmission rates by age group
- Used SUM() OVER for percentage distributions and RANK() OVER (PARTITION BY age) to rank patients by medication count within each age group
- Used CASE statements to group patients by medication level (Low: 5 or fewer, Medium: 6 to 15, High: over 15) and length of stay (Short: up to 3 days, Medium: 4 to 7 days, Long: over 7 days)
- Built a summary table and a view (vw_diabetes_dashboard) for the final analysis
- Also looked at readmission by insulin use, length of stay, number of medicines and admission type

## Files
- diabetes_project_final.sql: all queries, from table creation to final results
- Screenshots: step-by-step outputs (04_final_query_result.png shows the final result)

## Data
UCI Diabetes 130-US Hospitals dataset (public).

## Tools
MySQL, MySQL Workbench

Note: you may see yellow warnings when running the script. They come from DROP TABLE IF EXISTS and DROP VIEW IF EXISTS and are normal.
