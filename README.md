
Diabetes Hospital Readmission SQL Project
Project Overview
This project analyzes a healthcare dataset to understand factors affecting diabetes patient readmission. The goal was to process raw patient data and create a summarized view to analyze the relationship between medication levels, hospital stay duration, and readmission rates.

Tools Used
Database: MySQL
Interface: MySQL Workbench
Project Structure
The project folder contains the following:

diabetes_project_final.sql: The complete SQL script used for the analysis.
README.txt: This documentation file.
/Screenshots/: A folder containing visual proof of successful execution.
SQL Workflow & Logic
Database Setup: Used the hospital_readmission database.
Data Cleaning & Transformation:
Created a summary table diabetes_summary.
Used a CASE statement to categorize medication levels as 'Low' (<= 5 medications) or 'High' (> 5 medications).
Advanced Analysis:
Created a dashboard view vw_diabetes_dashboard.
Implemented a RANK() window function to analyze patient records by age and medication usage.
Final Summary:
Ran an aggregation query to calculate total patients and the readmission rate based on medicine levels and stay duration.
Note on Execution Warnings
During the execution of the script, you may see yellow warning triangles for the following commands:

DROP TABLE IF EXISTS diabetes_summary
DROP VIEW IF EXISTS vw_diabetes_dashboard
These warnings (Error 1051) simply mean that the table or view did not exist before the script was run. They are not errors and do not affect the final results. All primary actions (Create Table, Create View, and Select) completed successfully with green checkmarks.

Final Result
The final query produced a summarized table showing that readmission rates vary based on the length of the hospital stay and the level of medication prescribed.

