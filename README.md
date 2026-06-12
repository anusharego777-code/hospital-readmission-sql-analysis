# Hospital Readmission SQL Analysis

## Project Overview
This project analyzes a healthcare dataset to understand factors affecting **diabetes patient readmission**. The goal was to process raw patient data and create summarized views to analyze the relationship between medication levels, hospital stay duration, and readmission rates.

## Tools Used
- **Database**: MySQL
- **Interface**: MySQL Workbench

## Project Structure
- `diabetes_project_final.sql` → Complete SQL script with all queries
- `README.md` → Project documentation (this file)
- `/Screenshots/` → Folder containing visual proof of execution (add this folder if you have screenshots)

## SQL Workflow & Key Analysis

- Used the `hospital_readmission` database
- Created a summary table `diabetes_summary`
- Used **CASE statement** to categorize medication levels as 'Low' (≤ 5 medications) or 'High' (> 5 medications)
- Created a dashboard view `vw_diabetes_dashboard`
- Used **RANK() window function** to analyze patient records by age and medication usage
- Final aggregation query to calculate total patients and readmission rate based on medicine levels and stay duration

## Important Note on Warnings
During execution, you may see yellow warning triangles for these commands:
```sql
DROP TABLE IF EXISTS diabetes_summary
DROP VIEW IF EXISTS vw_diabetes_dashboard

