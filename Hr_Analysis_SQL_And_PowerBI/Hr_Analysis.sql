CREATE DATABASE Hr_Analysis;

-- Create a join for table
SELECT * 
FROM Absenteeism_at_work a
LEFT JOIN compensation b ON a.ID = b.ID
LEFT JOIN Reasons r ON a.`Reason for absence` = r.Number;

-- Find the healthiest employees for the bonus
SELECT * 
FROM Absenteeism_at_work
WHERE `Social drinker` = 0 
  AND `Social smoker` = 0
  AND `Body mass index` < 25 
  AND `Absenteeism time in hours` < (
    SELECT AVG(`Absenteeism time in hours`) 
    FROM Absenteeism_at_work
);

-- Compensation rate increase for non-smokers
SELECT count(*) as nonsmokers FROM Absenteeism_at_work
WHERE `Social smoker` = 0;

-- Optimize this query 
SELECT 
    a.ID,
    r.Reason,
    `Month of absence`,
    `Body mass index`,
    CASE
        WHEN a.`Body mass index` < 18.5 THEN 'Underweight'
        WHEN a.`Body mass index` BETWEEN 18.5 AND 24.9 THEN 'Healthy'
        WHEN a.`Body mass index` BETWEEN 25 AND 30 THEN 'Overweight'
        WHEN a.`Body mass index` > 30 THEN 'Obese'
        ELSE 'Unknown' 
    END as BMI_Category,
    CASE 
        WHEN a.`Month of absence` IN (12, 1, 2) THEN 'Winter'
        WHEN a.`Month of absence` IN (3, 4, 5) THEN 'Spring'
        WHEN a.`Month of absence` IN (6, 7, 8) THEN 'Summer'
        WHEN a.`Month of absence` IN (9, 10, 11) THEN 'Fall'
        ELSE 'Unknown' 
    END as Season_Names,
    `Seasons`,
    `Month of absence`,
    `Day of the week`,
    `Transportation expense`,
    Education,
    Son,
    `Social drinker`,
    `Social smoker`,
    Pet,
    `Disciplinary failure`,
    Age,
    `Work load Average/day`,
    `Absenteeism time in hours`
FROM Absenteeism_at_work a
LEFT JOIN compensation b ON a.ID = b.ID
LEFT JOIN Reasons r ON a.`Reason for absence` = r.Number;



