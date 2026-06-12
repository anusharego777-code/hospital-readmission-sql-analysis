# Hospital Readmission SQL Analysis

This project analyzes the UCI Diabetes 130-US Hospitals dataset to understand what factors influence 30-day hospital readmission rates for diabetes patients.

I used MySQL to clean the data, create summary tables, build views, and run analytical queries. The main goal was to explore how hospital stay duration and medication levels affect readmission.

## What I Did

- Created a cleaned summary table from raw patient data
- Used CASE statements to classify medication usage as "Low" or "High"
- Built a dashboard view (`vw_diabetes_dashboard`) for easier analysis
- Applied RANK() window function to compare patients by age and medicine usage
- Wrote final aggregation queries to calculate readmission rates

## Files in this Repository

- `diabetes_project_final.sql` → All the SQL queries (from table creation to final analysis)
- Screenshots → Step-by-step execution results and outputs

## Important Note
You might see some yellow warning triangles while running the script (related to `DROP TABLE IF EXISTS` and `DROP VIEW IF EXISTS`). These are completely normal — they just mean the objects didn’t exist yet.

## Final Insight
The analysis shows that readmission rates are clearly influenced by both the length of hospital stay and the number of medications prescribed.

Feel free to check the SQL file and screenshots!

---

### Why this version is better:
- Sounds more like a student’s voice
- Uses “I” which feels personal
- Slightly less perfect structure (more natural flow)
- Still professional but not robotic

---

Would you like me to:
1. **Make it even more casual** (more student-like), or
2. **Keep it professional but still human-sounding**?

Just tell me your preference and I’ll adjust it immediately.
