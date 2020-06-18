USE data_extracts;

DROP PROCEDURE IF EXISTS createcohortBartsPancreasBP1;

DELIMITER //
CREATE PROCEDURE createcohortBartsPancreasBP1()
BEGIN

DROP TABLE IF EXISTS cohort_bp1;

CREATE TABLE cohort_bp1 
SELECT 
       b.patient_id,
       b.group_by,
       b.person_id,
       b.doner_id, 
       b.NhsNumber,
       b.Gender,
       b.BirthDate,
       b.DateOfDeath,
       b.rnk
FROM (
SELECT
       a.patient_id, 
       a.group_by, 
       a.person_id,
       a.doner_id, 
       a.NhsNumber,
       a.Gender,
       a.BirthDate,
       a.DateOfDeath,
       @currank := IF(@curperson = a.person_id, @currank + 1, 1) AS rnk,
       @curperson := a.person_id AS cur_person
FROM (SELECT DISTINCT 
             p.id AS patient_id, 
             d.pseudo_id AS group_by, 
             p.person_id,  
             d.doner_id, 
             d.NhsNumber, 
             d.Gender, 
             d.BirthDate, 
             d.DateOfDeath
     FROM start_data_bp1 d 
         JOIN enterprise_pseudo.patient p ON p.pseudo_id = d.pseudo_id
         JOIN enterprise_pseudo.organization org ON org.id = p.organization_id
     WHERE EXISTS (SELECT 'x' FROM bp1_eastlondonccg_codes ccgs
                   WHERE ccgs.parent IN ('City & Hackney CCG','Newham CCG','Tower Hamlets CCG', 'Waltham Forest CCG')
                   AND ccgs.local_id = org.ods_code)
     ORDER BY p.person_id, ISNULL(d.DateOfDeath), d.DateOfDeath ASC ) a, (SELECT @currank := 0, @curperson := 0) r ) b
WHERE b.rnk = 1;


ALTER TABLE cohort_bp1 MODIFY COLUMN group_by VARCHAR(255);
ALTER TABLE cohort_bp1 ADD COLUMN PracticeName VARCHAR(100);
ALTER TABLE cohort_bp1 ADD COLUMN PracticeODScode VARCHAR(100);
ALTER TABLE cohort_bp1 ADD COLUMN AgeYears VARCHAR(10);

-- Practice
UPDATE cohort_bp1 c JOIN enterprise_pseudo.patient p ON p.pseudo_id = c.group_by
                    JOIN enterprise_pseudo.organization org ON p.organization_id = org.id
                    JOIN enterprise_pseudo.episode_of_care e ON e.patient_id = p.id
SET c.PracticeName = org.name, c.PracticeODScode = org.ods_code
WHERE e.registration_type_id = 2
AND e.date_registered <= now()
AND (e.date_registered_end > now() OR e.date_registered_end IS NULL);

-- Age years
UPDATE cohort_bp1 c JOIN enterprise_pseudo.patient p ON p.pseudo_id = c.group_by
SET c.AgeYears = p.age_years;

-- DateOfDeath can be '', or only recorded for certain patient_ids of a NHSNumber.
UPDATE cohort_bp1 c1 JOIN cohort_bp1 c2 ON c1.NhsNumber = c2.NhsNumber
SET c1.DateOfDeath = c2.DateOfDeath
WHERE c2.DateOfDeath IS NOT NULL AND c2.DateOfDeath != '';

END//
DELIMITER ;
