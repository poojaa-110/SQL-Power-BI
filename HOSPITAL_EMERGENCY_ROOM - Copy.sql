use hospital;
-- CREATE DATABASE HOSPITAL;

-- 1) Total number of Patient

SELECT COUNT(*) AS total_patients
FROM hospital_emergency_room;

-- 2) Total number of Unique Patient

SELECT COUNT(DISTINCT patient_name) AS unique_patients
FROM hospital_emergency_room;

-- 3) Total number of Male and Female;

SELECT Patient_gender, COUNT(*) AS Total_patients
FROM hospital_emergency_room
GROUP BY Patient_gender;

-- 4) Age group Distribution;

SELECT Patient_age_group, COUNT(*) AS Total_patients
FROM hospital_emergency_room
GROUP BY Patient_age_group
ORDER BY Total_patientS DESC;

-- 1) Total no. of admitted and not admitted patient;
SELECT Patient_admission_status,
COUNT(*) AS total
FROM hospital_emergency_room
GROUP BY Patient_admission_status;

-- 2) Admission rate;

SELECT
ROUND(
SUM(CASE WHEN Patient_admission_status='Admitted' THEN 1 ELSE 0 END)*100/COUNT(*),2
) AS admission_rate
FROM hospital_emergency_room;

-- 1) Daily patient visit

SELECT Patient_admission_date,
COUNT(*) AS patients
FROM hospital_emergency_room
GROUP BY Patient_admission_date
ORDER BY Patient_admission_date;

-- 2)Monthly Patient visit
SELECT
MONTHNAME(Patient_admission_date) AS month,
COUNT(*) AS patients
FROM hospital_emergency_room
GROUP BY MONTH(Patient_admission_date),MONTHNAME(Patient_admission_date)
ORDER BY MONTH(Patient_admission_date);

-- 3) Day wise visit

SELECT
DAYNAME(Patient_admission_date) AS day_name,
COUNT(*) AS patients
FROM hospital_emergency_room
GROUP BY DAYNAME(Patient_admission_date);

-- 1)Patients by Hour:

SELECT
HOUR(Patient_admission_time) AS hour,
COUNT(*) AS patients
FROM hospital_emergency_room
GROUP BY HOUR (Patient_admission_time)
ORDER BY hour;

-- 2)Busiest Hour:
SELECT
HOUR(Patient_admission_time) AS hour,
COUNT(*) AS patients
FROM hospital_emergency_room
GROUP BY hour
ORDER BY patients DESC
LIMIT 1;

-- 1) Average waiting time

SELECT
ROUND(AVG(Patient_waittime),2) AS average_wait
FROM hospital_emergency_room;

-- 2)  Maximum waiting time

SELECT
MAX(Patient_waittime) AS max_wait
FROM hospital_emergency_room;

-- 3) Patient seen within 30 minutes

SELECT
COUNT(*) AS patients_seen_within_30
FROM hospital_emergency_room
WHERE Patient_waittime<=30;

-- 4)   Percentage of Patient seen within 30 minutes

SELECT
ROUND(
SUM(CASE WHEN Patient_waittime<=30 THEN 1 ELSE 0 END)*100/COUNT(*),2
) AS percentage
FROM hospital_emergency_room;

-- 1) Patients by Department:

SELECT
department_referral,
COUNT(*) AS total_patients
FROM hospital_emergency_room
GROUP BY department_referral
ORDER BY total_patients DESC;

-- 2) Top 5 Departments:

SELECT
department_referral,
COUNT(*) AS total_patients
FROM hospital_emergency_room
GROUP BY department_referral
ORDER BY total_patients DESC
LIMIT 5;

-- 1) Average Satisfaction Score;

SELECT
ROUND(AVG(patient_satisfaction_score),2)
FROM hospital_emergency_room;

-- 2) Satisfaction by Department;

SELECT
department_referral,
ROUND(AVG(patient_satisfaction_score),2) AS avg_score
FROM hospital_emergency_room
GROUP BY department_referral
ORDER BY avg_score DESC;

-- 1) Patients by Race: 

SELECT patient_race,
 COUNT(*)  AS total 
 FROM hospital_emergency_room
 GROUP BY patient_race;

-- 2) Patients by Gender and Age Group:

SELECT  patient_gender, patient_age_group,
 COUNT(*)  AS total 
 FROM hospital_emergency_room
 GROUP BY patient_gender,patient_age_group;

-- 1) Top 10 busiest days:

SELECT  patient_admission_date,
 COUNT(*)  AS patient 
 FROM hospital_emergency_room
 GROUP BY patient_admission_date
 ORDER BY patient DESC
 LIMIT 10
 ;

-- Rank Departments by Patient Count:

SELECT department_referral,
COUNT(*) AS patient,
RANK() OVER(ORDER BY COUNT(*) DESC) AS ranking
FROM hospital_emergency_room
GROUP BY department_referral;

-- Average count of daily patient;

SELECT
AVG(patient_count)
FROM
(
SELECT
patient_admission_date,
COUNT(*) AS patient_count
FROM hospital_emergency_room
GROUP BY patient_admission_date
) ;

-- Patient for each day:

SELECT
    patient_admission_date,
    COUNT(*) AS daily_patient_count
FROM hospital_emergency_room
GROUP BY patient_admission_date
ORDER BY daily_patient_count DESC
LIMIT 10;