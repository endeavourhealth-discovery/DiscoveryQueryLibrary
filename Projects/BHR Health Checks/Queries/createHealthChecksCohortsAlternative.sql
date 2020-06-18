USE data_extracts;

DROP PROCEDURE IF EXISTS createHealthChecksCohorts;

DELIMITER //
CREATE PROCEDURE createHealthChecksCohorts( p_start_date DATE, p_end_date DATE)
BEGIN

DROP TABLE IF EXISTS tmp_health_checks_observation;
DROP TABLE IF EXISTS tmp_health_checks_medication;

CREATE TABLE tmp_health_checks_medication AS    
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 org.ods_code,
                 o.dmd_id,
                 o.original_term
FROM enterprise_pi.medication_statement o
     JOIN enterprise_pi.patient pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.sct_concept_id = o.dmd_id
     JOIN enterprise_pi.organization org ON org.id = o.organization_id
WHERE c.code_set_id = 25
AND DATEDIFF(o.clinical_effective_date, pt.date_of_birth) / 365.25 BETWEEN 40 AND 75
AND org.ods_code IN (SELECT ods_code FROM hc_organisations);

ALTER TABLE tmp_health_checks_medication
ADD INDEX patient_idx (patient_id ASC, dmd_id ASC, clinical_effective_date ASC);

CREATE TABLE tmp_health_checks_observation AS    
SELECT DISTINCT  
       o.patient_id,
       pt.nhs_number,
       pt.patient_gender_id,
       pt.ethnic_code,
       pt.date_of_birth,
       pt.lsoa_code,
       pt.msoa_code,
       o.clinical_effective_date,
       org.ods_code,
       o.original_code,
       o.original_term,
       o.result_value,
       o.result_value_units
FROM enterprise_pi.observation o
      JOIN enterprise_pi.patient pt ON pt.id = o.patient_id
      JOIN rf2.code_set_codes c ON CONCAT('CTV3_',cs.ctv3_concept_id) = o.original_code     -- ctv3
      JOIN enterprise_pi.organization org ON org.id = o.organization_id
WHERE (c.code_set_id BETWEEN 6 AND 67 OR c.code_set_id = 0)
AND DATEDIFF(o.clinical_effective_date, pt.date_of_birth) / 365.25 BETWEEN 40 AND 75
AND org.ods_code IN (SELECT ods_code FROM hc_organisations)
UNION
SELECT DISTINCT  
       o.patient_id,
       pt.nhs_number,
       pt.patient_gender_id,
       pt.ethnic_code,
       pt.date_of_birth,
       pt.lsoa_code,
       pt.msoa_code,
       o.clinical_effective_date,
       org.ods_code,
       o.original_code,
       o.original_term,
       o.result_value,
       o.result_value_units
FROM enterprise_pi.observation o
 JOIN enterprise_pi.patient pt ON pt.id = o.patient_id
 JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code -- read2
 JOIN enterprise_pi.organization org ON org.id = o.organization_id
WHERE (c.code_set_id BETWEEN 6 AND 67 OR c.code_set_id = 0)
AND DATEDIFF(o.clinical_effective_date, pt.date_of_birth) / 365.25 BETWEEN 40 AND 75
AND org.ods_code IN (SELECT ods_code FROM hc_organisations);

ALTER TABLE tmp_health_checks_observation
ADD INDEX patient_id (patient_id ASC, original_code ASC, clinical_effective_date ASC);


-- *********** RUN EACH DATE BATCH ****************

DROP TABLE IF EXISTS tmp_health_checks_cohort_eligible;
DROP TABLE IF EXISTS tmp_health_checks_cohort_ineligible;
DROP TABLE IF EXISTS tmp_health_checks_cohort_eligible_codes;
DROP TABLE IF EXISTS tmp_health_checks_cohort_ineligible_codes;
DROP TABLE IF EXISTS tmp_health_checks_invitation_codes;

-- health checks report cohort -- patients who had health checks offered or completed this quarter
CREATE TABLE tmp_health_checks_cohort_eligible AS    
SELECT DISTINCT (p.id) 
FROM tmp_health_checks_observation o
     JOIN enterprise_pi.patient p ON p.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code   -- ctv3 
WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date;

ALTER TABLE tmp_health_checks_cohort_eligible
ADD INDEX p_idx (id ASC);

-- create ineligible cohort list (who have the exclusion codes IN their record)
CREATE TABLE tmp_health_checks_cohort_ineligible AS    
SELECT DISTINCT (pt.id) 
FROM tmp_health_checks_observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code 
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23) -- exclusion code sets
AND o.clinical_effective_date < (SELECT MIN(o.clinical_effective_date)  -- only exclude if exclusion code is before the health check
                                 FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                 WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                 AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                 AND pt2.id = pt.id);

INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM tmp_health_checks_observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code 
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23) -- exclusion code sets
AND o.clinical_effective_date < (SELECT MIN(o.clinical_effective_date)  -- only exclude if exclusion code is before the health check
                                 FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                 WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                 AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                 AND pt2.id = pt.id);

-- cvd 10yr 

INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM tmp_health_checks_observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code    -- cvt3
WHERE c.code_set_id IN (0) -- exclusion code sets for cvd 10yr
AND o.result_value >= 20  -- exclude if risk score >= 20% and is within a year of the health check
AND o.result_value IS NOT NULL
AND o.clinical_effective_date >= (SELECT DATE_SUB(MIN(o.clinical_effective_date), INTERVAL 1 YEAR)
                                  FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                  AND pt2.id = pt.id);

INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM tmp_health_checks_observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code   -- read2
WHERE c.code_set_id IN (0) -- exclusion code sets for cvd 10y
AND o.result_value >= 20  -- exclude if risk score >= 20% and is within a year of the health check
AND o.result_value IS NOT NULL
AND o.clinical_effective_date >= (SELECT DATE_SUB(MIN(o.clinical_effective_date), INTERVAL 1 YEAR)
                                  FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                  AND pt2.id = pt.id);


ALTER TABLE tmp_health_checks_cohort_ineligible
ADD INDEX p_idx (id ASC);

-- add statin patients to ineligible list
INSERT INTO tmp_health_checks_cohort_ineligible (id)
SELECT DISTINCT (pt.id) 
FROM tmp_health_checks_medication m
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = m.patient_id
     JOIN rf2.code_set_codes c ON c.sct_concept_id = m.dmd_id
WHERE c.code_set_id IN (25) -- statins
AND m.clinical_effective_date <  (SELECT MIN(o.clinical_effective_date)  -- only exclude if statin code is before the health check i.e. already being prescribed satins
                                  FROM tmp_health_checks_observation o
                                       JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                       JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
                                  AND pt2.id = pt.id)
AND m.clinical_effective_date >= (SELECT DATE_SUB(MIN(o.clinical_effective_date),INTERVAL 1 YEAR)  -- only exclude if statin code is within a year of the health check
                                  FROM tmp_health_checks_observation o
                                       JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                       JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
                                  AND pt2.id = pt.id);

-- remove ineligible patients FROM the eligible patients list
DELETE FROM tmp_health_checks_cohort_eligible WHERE id IN    
(SELECT DISTINCT (id) FROM tmp_health_checks_cohort_ineligible);

-- create ineligible report (exclusion codes IN their record) -- latest recording 
CREATE TABLE tmp_health_checks_cohort_ineligible_codes AS    
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code 
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23) -- exclusion code sets 
AND o2.clinical_effective_date IS NULL
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code 
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23) -- exclusion code sets -- add cvd y10 here
AND o2.clinical_effective_date IS NULL
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code 
WHERE c.code_set_id IN (0) -- add cvd y10 
AND o.result_value >= 20
AND o.result_value IS NOT NULL
AND o2.clinical_effective_date IS NULL
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code 
WHERE c.code_set_id IN (0) -- add cvd y10 
AND o.result_value >= 20
AND o.result_value IS NOT NULL
AND o2.clinical_effective_date IS NULL
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value
FROM tmp_health_checks_observation o
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
WHERE c.code_set_id IN (6,7) -- exclusion code sets
AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 NULL,
                 o.original_term,
                 NULL result_value
FROM tmp_health_checks_medication o
     JOIN tmp_health_checks_cohort_ineligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.sct_concept_id = o.dmd_id
WHERE c.code_set_id IN (25); -- exclusion code sets
 
-- create eligible report (no exclusion codes IN their record)  -- latest recording after health checks
CREATE TABLE tmp_health_checks_cohort_eligible_codes AS    
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value,
                 o.result_value_units
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code 
WHERE c.code_set_id BETWEEN 8 AND 67 -- full health checks dataset
AND o2.clinical_effective_date IS NULL
AND o.clinical_effective_date >= (SELECT MAX(o.clinical_effective_date) 
                                  FROM tmp_health_checks_observation o
                                       JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
                                       JOIN enterprise_pi.patient pt2 ON pt2.id = p.id
                                       JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
                                  AND pt2.id = pt.id)
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value,
                 o.result_value_units
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code 
WHERE c.code_set_id BETWEEN 8 AND 67 -- full health checks dataset
AND o2.clinical_effective_date IS NULL
AND o.clinical_effective_date >= (SELECT MAX(o.clinical_effective_date) 
                                  FROM tmp_health_checks_observation o
                                       JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
                                       JOIN enterprise_pi.patient pt2 ON pt2.id = p.id
                                       JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
                                  AND pt2.id = pt.id)
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value,
                 o.result_value_units
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code 
WHERE c.code_set_id IN (0)
AND o.result_value <= 19
AND o.result_value IS NOT NULL
AND o2.clinical_effective_date IS NULL
AND o.clinical_effective_date >= (SELECT DATE_SUB(MIN(o.clinical_effective_date), INTERVAL 1 YEAR)
                                  FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                  AND pt2.id = pt.id) 
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 o.original_code,
                 o.original_term,
                 o.result_value,
                 o.result_value_units
FROM tmp_health_checks_observation o
     LEFT JOIN tmp_health_checks_observation o2 ON (o.patient_id = o2.patient_id AND o.original_code = o2.original_code AND o.clinical_effective_date < o2.clinical_effective_date)
     JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
     JOIN enterprise_pi.patient pt ON pt.id = p.id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code 
WHERE c.code_set_id IN (0)
AND o.result_value <= 19
AND o.result_value IS NOT NULL
AND o2.clinical_effective_date IS NULL
AND o.clinical_effective_date >= (SELECT DATE_SUB(MIN(o.clinical_effective_date), INTERVAL 1 YEAR)
                                  FROM tmp_health_checks_observation o
                                      JOIN tmp_health_checks_cohort_eligible pt2 ON pt2.id = o.patient_id
                                      JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN  p_start_date AND p_end_date
                                  AND pt2.id = pt.id)
UNION
SELECT DISTINCT o.patient_id,
                pt.nhs_number,
                pt.patient_gender_id,
                pt.ethnic_code,
                pt.date_of_birth,
                pt.lsoa_code,
                pt.msoa_code,
                o.clinical_effective_date,
                o.ods_code,
                o.original_code,
                o.original_term,
                o.result_value,
                o.result_value_units
FROM tmp_health_checks_observation o
JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
JOIN enterprise_pi.patient pt ON pt.id = p.id
JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
WHERE c.code_set_id IN (6,7)
AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
UNION
SELECT DISTINCT  o.patient_id,
                 pt.nhs_number,
                 pt.patient_gender_id,
                 pt.ethnic_code,
                 pt.date_of_birth,
                 pt.lsoa_code,
                 pt.msoa_code,
                 o.clinical_effective_date,
                 o.ods_code,
                 NULL,
                 o.original_term,
                 NULL,
                 NULL
FROM tmp_health_checks_medication o
LEFT JOIN tmp_health_checks_medication o2 ON (o.patient_id = o2.patient_id AND o.dmd_id = o2.dmd_id AND o.clinical_effective_date < o2.clinical_effective_date)
JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
JOIN enterprise_pi.patient pt ON pt.id = p.id
JOIN rf2.code_set_codes c ON c.sct_concept_id = o.dmd_id
WHERE c.code_set_id IN (25) -- statins
AND o2.clinical_effective_date IS NULL
AND o.clinical_effective_date >= (SELECT MAX(o.clinical_effective_date) 
                                  FROM tmp_health_checks_observation o
                                       JOIN tmp_health_checks_cohort_eligible p ON p.id = o.patient_id
                                       JOIN enterprise_pi.patient pt2 ON pt2.id = p.id
                                       JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
                                  WHERE c.code_set_id IN (6,7) -- NHS Health Check Completed, NHS Health Check invitation codes
                                  AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
                                  AND pt2.id = pt.id);

CREATE TABLE tmp_health_checks_invitation_codes AS
SELECT p.nhs_number,
       o.patient_id,
       o.ods_code,
       o.clinical_effective_date,
       o.original_code,original_term 
FROM tmp_health_checks_observation o
     JOIN enterprise_pi.patient p ON p.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code 
WHERE c.code_set_id IN (7) -- NHS Health Check invitation codes
AND o.clinical_effective_date BETWEEN p_start_date AND p_end_date
AND DATEDIFF(NOW(), p.date_of_birth) / 365.25 BETWEEN 40 AND 75
ORDER BY p.id;


END//
DELIMITER ;

