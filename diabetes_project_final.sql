-- =============================================
-- DIABETES READMISSION PROJECT
-- UCI Diabetes Dataset Analysis
-- =============================================

USE hospital_readmission;

-- Creating the 3 mapping tables
CREATE TABLE IF NOT EXISTS admission_type (
    admission_type_id INT PRIMARY KEY,
    description VARCHAR(100)
);

INSERT INTO admission_type VALUES 
(1,'Emergency'),(2,'Urgent'),(3,'Elective'),(4,'Newborn'),
(5,'Not Available'),(6,'NULL'),(7,'Trauma Center'),(8,'Not Mapped');

CREATE TABLE IF NOT EXISTS discharge_disposition (
    discharge_disposition_id INT PRIMARY KEY,
    description VARCHAR(200)
);

INSERT INTO discharge_disposition VALUES 
(1,'Discharged to home'),(2,'Discharged to another hospital'),
(3,'Discharged to SNF'),(6,'Discharged to home with home health'),
(7,'Against medical advice'),(11,'Expired'),(18,'NULL'),(25,'Not Mapped');

CREATE TABLE IF NOT EXISTS admission_source (
    admission_source_id INT PRIMARY KEY,
    description VARCHAR(200)
);

INSERT INTO admission_source VALUES 
(1,'Physician Referral'),(7,'Emergency Room'),(17,'NULL'),(25,'Not Mapped');

-- Creating the main master table using JOINs
DROP TABLE IF EXISTS diabetes_master;

CREATE TABLE diabetes_master AS
SELECT 
    d.*,
    a.description AS admission_type,
    dis.description AS discharge_disposition,
    s.description AS admission_source,
    CASE 
        WHEN d.readmitted = '<30' THEN 'Readmitted_<30_days'
        WHEN d.readmitted = '>30' THEN 'Readmitted_>30_days'
        ELSE 'Not_Readmitted'
    END AS readmitted_category
FROM diabetic_data d
LEFT JOIN admission_type a ON d.admission_type_id = a.admission_type_id
LEFT JOIN discharge_disposition dis ON d.discharge_disposition_id = dis.discharge_disposition_id
LEFT JOIN admission_source s ON d.admission_source_id = s.admission_source_id;

-- Query 1: Overall Readmission Rate
SELECT 
    readmitted_category,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM diabetes_master
GROUP BY readmitted_category
ORDER BY percentage DESC;

-- Query 2: Readmission by Age (using CTE)
WITH AgeAnalysis AS (
    SELECT 
        age,
        COUNT(*) AS total_cases,
        SUM(CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 1 ELSE 0 END) AS readmitted_30
    FROM diabetes_master
    GROUP BY age
)
SELECT 
    age,
    total_cases,
    readmitted_30,
    ROUND(readmitted_30 * 100.0 / total_cases, 2) AS readmission_rate_30
FROM AgeAnalysis
ORDER BY readmission_rate_30 DESC;

-- Query 3: Readmission by Insulin
SELECT 
    insulin,
    COUNT(*) AS total_cases,
    ROUND(AVG(CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 100.0 ELSE 0 END), 2) AS readmission_rate_30
FROM diabetes_master
GROUP BY insulin
ORDER BY readmission_rate_30 DESC;

-- Query 4: Readmission by Length of Stay
SELECT 
    time_in_hospital,
    COUNT(*) AS total_cases,
    ROUND(AVG(CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 100.0 ELSE 0 END), 2) AS readmission_rate_30
FROM diabetes_master
GROUP BY time_in_hospital
ORDER BY time_in_hospital;

-- Query 5: Readmission by Number of Medicines
SELECT 
    CASE 
        WHEN num_medications <= 5 THEN '01-05'
        WHEN num_medications <= 10 THEN '06-10'
        WHEN num_medications <= 15 THEN '11-15'
        WHEN num_medications <= 20 THEN '16-20'
        ELSE '21 and above' 
    END AS medicine_count,
    COUNT(*) AS total_cases,
    ROUND(AVG(CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 100.0 ELSE 0 END), 2) AS readmission_rate_30
FROM diabetes_master
GROUP BY medicine_count
ORDER BY medicine_count;

-- Query 6: Readmission by Admission Type
SELECT 
    admission_type,
    COUNT(*) AS total_cases,
    ROUND(AVG(CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 100.0 ELSE 0 END), 2) AS readmission_rate_30
FROM diabetes_master
GROUP BY admission_type
ORDER BY readmission_rate_30 DESC;

-- Creating Summary Table
DROP TABLE IF EXISTS diabetes_summary;

CREATE TABLE diabetes_summary AS
SELECT 
    *,
    CASE WHEN num_medications <= 5 THEN 'Low'
         WHEN num_medications <= 15 THEN 'Medium' 
         ELSE 'High' END AS medicine_level,
    CASE WHEN time_in_hospital <= 3 THEN 'Short Stay'
         WHEN time_in_hospital <= 7 THEN 'Medium Stay' 
         ELSE 'Long Stay' END AS stay_duration,
    CASE WHEN readmitted_category = 'Readmitted_<30_days' THEN 1 ELSE 0 END AS readmitted_flag
FROM diabetes_master;

-- Creating View
DROP VIEW IF EXISTS vw_diabetes_dashboard;

CREATE VIEW vw_diabetes_dashboard AS
SELECT *,
       RANK() OVER (PARTITION BY age ORDER BY num_medications DESC) as rank_by_medicine
FROM diabetes_summary;

-- Final Summary
SELECT 
    medicine_level,
    stay_duration,
    COUNT(*) AS total_patients,
    ROUND(AVG(readmitted_flag)*100, 2) AS readmission_rate_30
FROM vw_diabetes_dashboard
GROUP BY medicine_level, stay_duration
ORDER BY readmission_rate_30 DESC;