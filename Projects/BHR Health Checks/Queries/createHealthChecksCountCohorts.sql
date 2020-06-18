USE data_extracts;

DROP PROCEDURE IF EXISTS createHealthChecksCountCohorts;

DELIMITER //
CREATE PROCEDURE createHealthChecksCountCohorts()
BEGIN

DROP TABLE IF EXISTS tmp_health_checks_cohort_eligible;
DROP TABLE IF EXISTS tmp_health_checks_cohort_ineligible;
    
-- health checks report cohort     -- eligible population regardless of whether a health check has been given
CREATE TABLE tmp_health_checks_cohort_eligible AS    
SELECT DISTINCT (p.id) as id 
FROM enterprise_pi.patient p
     JOIN enterprise_pi.organization o ON o.id = p.organization_id
     JOIN enterprise_pi.episode_of_care e ON e.patient_id = p.id
WHERE p.date_of_death IS NULL
AND e.registration_type_id = 2
AND e.date_registered <= now()
AND (e.date_registered_end > now() or e.date_registered_end IS NULL)
AND DATEDIFF(now(), p.date_of_birth) / 365.25 BETWEEN 40 AND 75
AND o.ods_code IN (SELECT ods_code FROM hc_organisations);

ALTER TABLE tmp_health_checks_cohort_eligible
ADD INDEX id_idx (id ASC);

-- these patients should be excluded from this extract
-- create ineligible cohort list (who have the exclusion codes IN their record)
CREATE TABLE tmp_health_checks_cohort_ineligible AS    
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code AND BINARY CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23); -- exclusion code sets

INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code AND BINARY c.read2_concept_id = o.original_code
WHERE c.code_set_id IN (8,9,11,14,15,16,17,20,21,22,23); -- exclusion code sets

-- add ineligible patients who have had a health check IN the last 5 years and therefore will be excluded from the completed HC count for this period
INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.ctv3_concept_id = o.original_code AND BINARY c.ctv3_concept_id = o.original_code
WHERE c.code_set_id IN (6) -- NHS Health Check Completed
AND o.clinical_effective_date >= DATE_SUB(NOW(), INTERVAL 5 YEAR);

-- exclude patients who have had CVD 10yr risk >=20% within the previous year
INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code AND BINARY CONCAT('CTV3_',c.ctv3_concept_id) = o.original_code
WHERE c.code_set_id IN (0) -- -- cvd 10yr
AND o.result_value >= 20
AND o.result_value IS NOT NULL
AND o.clinical_effective_date >= DATE_SUB(NOW(), INTERVAL 1 YEAR);  -- exclude if cvd 10yr >= 20% is within the previous year

INSERT INTO tmp_health_checks_cohort_ineligible (id)    
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.observation o
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = o.patient_id
     JOIN rf2.code_set_codes c ON c.read2_concept_id = o.original_code AND BINARY c.read2_concept_id = o.original_code 
WHERE c.code_set_id IN (0) -- cvd 10yr
AND o.result_value >= 20
AND o.result_value IS NOT NULL
AND o.clinical_effective_date >= DATE_SUB(NOW(), INTERVAL 1 YEAR);  -- exclude if cvd 10yr >= 20% is within the previous year

ALTER TABLE tmp_health_checks_cohort_ineligible
ADD INDEX id (id ASC);

-- add statin patients to ineligible list
INSERT INTO tmp_health_checks_cohort_ineligible (id)
SELECT DISTINCT (pt.id) 
FROM enterprise_pi.medication_statement m
     JOIN tmp_health_checks_cohort_eligible pt ON pt.id = m.patient_id
     JOIN rf2.code_set_codes c ON c.sct_concept_id = m.dmd_id
WHERE c.code_set_id IN (25) -- statins
AND m.clinical_effective_date >= DATE_SUB(NOW(), INTERVAL 1 YEAR); -- only exclude if statin code is within a year

-- remove ineligible patients FROM the eligible patients list
DELETE FROM tmp_health_checks_cohort_eligible WHERE id IN    
(SELECT DISTINCT (id) FROM tmp_health_checks_cohort_ineligible);

END//
DELIMITER ;