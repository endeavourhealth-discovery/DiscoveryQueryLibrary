USE data_extracts;

DROP PROCEDURE IF EXISTS ELbuildDatasetForDiabetes;

DELIMITER //

CREATE PROCEDURE ELbuildDatasetForDiabetes()
BEGIN

DROP TABLE IF EXISTS el_dm_dataset;

CREATE TABLE el_dm_dataset(
  RUN_DATE            DATE,
  PSEUDO_ID           VARCHAR(255),
  ELIGIBLE            VARCHAR(10),
  PATIENT_ID          BIGINT(20),
  NHS_NO              VARCHAR(255),
  -- TITLE               VARCHAR(50),
  FIRSTNAME           VARCHAR(255),
  LASTNAME            VARCHAR(255),
  ADDR_1              VARCHAR(255),
  ADDR_2              VARCHAR(255),
  ADDR_3              VARCHAR(255),
  ADDR_4              VARCHAR(255),
  POST_CODE           VARCHAR(10),
  GENDER              VARCHAR(10),
  ETHNICITY           VARCHAR(20),
  AGE                 VARCHAR(10),	
  BIRTH_DATE          VARCHAR(20),	
  PRACTICE_CODE	      VARCHAR(50),
  PRACTICE_REG_DATE   VARCHAR(10),	
  -- MOBILE_TEL_NO	     VARCHAR(50),
  -- HOME_TEL_NO         VARCHAR(50),
  DEATH_DATE          VARCHAR(20),
  LAST_BP             VARCHAR(100),
  BP_DATE             VARCHAR(100),
  LAST_HBA1C          VARCHAR(100),
  HBA1C_DATE          VARCHAR(100),	
  DM_CODE             VARCHAR(500),
  DM_DATE             VARCHAR(500),
  PAT_PREG_LIKELY     VARCHAR(10),
  PREGNANCY_CODE      VARCHAR(100),
  PREGNANCY_DATE      VARCHAR(100),	
  DM_RESOLVED_CODE    VARCHAR(500),
  DM_RESOLVED_DATE    VARCHAR(500),	
  ELIG_CODE           VARCHAR(500),
  ELIG_DATE           VARCHAR(500),
  ETHNIC_CODE         VARCHAR(500),
  ETHNIC_DATE         VARCHAR(500),
  PREF_LANG_CODE      VARCHAR(500),
  PREF_LANG_DATE      VARCHAR(500),
  REQ_INTERPRET_CODE  VARCHAR(500),
  REQ_INTERPRET_DATE  VARCHAR(500),
  DECEASED_CODE       VARCHAR(500),
  DECEASED_DATE       VARCHAR(500),
  ORG_ID              BIGINT(20)
  );

ALTER TABLE el_dm_dataset ADD INDEX el_dm_psuedoIdIdx (pseudo_id);
ALTER TABLE el_dm_dataset ADD INDEX el_dm_patientIdIdx (patient_id);
ALTER TABLE el_dm_dataset ADD INDEX el_dm_orgIdIdx (org_id);


INSERT INTO el_dm_dataset (run_date, eligible, patient_id, pseudo_id, practice_code, practice_reg_date, org_id, death_date)
  SELECT DISTINCT now(), 'Yes', patient_id, group_by, practice_code, registered_date, organization_id, date_of_death
  FROM data_extracts.cohort_el;

UPDATE el_dm_dataset dm
 JOIN ceg_compass_data.patient pat ON dm.patient_id = pat.id
 JOIN ceg_compass_data.person per ON pat.person_id = per.id
 JOIN ceg_compass_data.patient_gender ptg ON pat.patient_gender_id = ptg.id
SET dm.age = per.age_years,
    dm.ethnicity = per.ethnic_code,
    dm.gender = SUBSTRING(ptg.value,1,1);
    
-- build required dataset

-- diabetes mellitus codes and dates

CALL ELObservationFromCohort(1, NULL);

DROP TABLE IF EXISTS el_dataset_1;

CREATE TABLE el_dataset_1 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS dm_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS dm_dates
FROM data_extracts.elobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE el_dataset_1 ADD INDEX elpatientIdIdx1 (patient_id);
ALTER TABLE el_dataset_1 ADD INDEX elorgIdx1 (organization_id);

UPDATE el_dm_dataset dm
JOIN el_dataset_1 d1 ON dm.patient_id = d1.patient_id 
AND dm.org_id = d1.organization_id
SET dm.dm_code = d1.dm_codes,
    dm.dm_date = d1.dm_dates;

-- diabetes resolved codes and dates

CALL ELObservationFromCohort(9, NULL);

DROP TABLE IF EXISTS el_dataset_2;

CREATE TABLE el_dataset_2 AS
SELECT o.patient_id              AS patient_id, 
       o.organization_id         AS organization_id, 
       o.snomed_concept_id       AS resolved_code, 
       o.clinical_effective_date AS resolved_date 
FROM data_extracts.elobservationfromcohort o;

ALTER TABLE el_dataset_2 ADD INDEX elpatientIdIdx2 (patient_id);
ALTER TABLE el_dataset_2 ADD INDEX elorgIdx2 (organization_id);

UPDATE el_dm_dataset dm JOIN 
(SELECT  patient_id, resolved_code, MAX(resolved_date) AS resolved_date , organization_id 
 FROM data_extracts.el_dataset_2 GROUP BY patient_id, resolved_code, organization_id) d2 
ON dm.patient_id = d2.patient_id AND dm.org_id = d2.organization_id
SET dm.dm_resolved_code = d2.resolved_code,
    dm.dm_resolved_date = d2.resolved_date;
      
-- eligibility codes and dates

CALL ELObservationFromCohort(4, NULL);

DROP TABLE IF EXISTS el_dataset_3;

CREATE TABLE el_dataset_3 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id, 
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS elig_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS elig_dates  
FROM data_extracts.elobservationfromcohort o 
GROUP BY  o.patient_id, o.organization_id;

ALTER TABLE el_dataset_3 ADD INDEX elpatientIdIdx3 (patient_id);
ALTER TABLE el_dataset_3 ADD INDEX elorgIdx3 (organization_id);

UPDATE el_dm_dataset dm 
JOIN el_dataset_3 d3
ON dm.patient_id = d3.patient_id 
AND dm.org_id = d3.organization_id
SET dm.eligible  = 'No',
    dm.elig_code = d3.elig_codes,
    dm.elig_date = d3.elig_dates;

-- ethnicity codes and dates

CALL ELObservationFromCohort(5, NULL);

DROP TABLE IF EXISTS el_dataset_4;

CREATE TABLE el_dataset_4 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id, 
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS eth_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS eth_dates 
FROM data_extracts.elobservationfromcohort o 
GROUP BY  o.patient_id, o.organization_id;

ALTER TABLE el_dataset_4 ADD INDEX elpatientIdIdx4 (patient_id);
ALTER TABLE el_dataset_4 ADD INDEX elorgIdx4 (organization_id);

UPDATE el_dm_dataset dm 
JOIN el_dataset_4 d4 
ON dm.patient_id = d4.patient_id 
AND dm.org_id = d4.organization_id
SET dm.ethnic_code = d4.eth_codes,
    dm.ethnic_date = d4.eth_dates;

-- preferred language codes and dates

CALL ELObservationFromCohort(6, NULL);

DROP TABLE IF EXISTS el_dataset_5;

CREATE TABLE el_dataset_5 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id, 
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS lang_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS lang_dates 
FROM  data_extracts.elobservationfromcohort o 
GROUP BY  o.patient_id, o.organization_id;

ALTER TABLE el_dataset_5 ADD INDEX elpatientIdIdx5 (patient_id);
ALTER TABLE el_dataset_5 ADD INDEX elorgIdx5 (organization_id);

UPDATE el_dm_dataset dm 
JOIN el_dataset_5 d5 
ON dm.patient_id = d5.patient_id 
AND dm.org_id = d5.organization_id
SET dm.pref_lang_code = d5.lang_codes,
    dm.pref_lang_date = d5.lang_dates;

-- interpreter codes and dates

CALL ELObservationFromCohort(7, NULL);

DROP TABLE IF EXISTS el_dataset_6;

CREATE TABLE el_dataset_6 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id, 
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS interp_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS interp_dates 
FROM data_extracts.elobservationfromcohort o  
GROUP BY  o.patient_id, o.organization_id;

ALTER TABLE el_dataset_6 ADD INDEX elpatientIdIdx6 (patient_id);
ALTER TABLE el_dataset_6 ADD INDEX elorgIdx6 (organization_id);

UPDATE el_dm_dataset dm 
JOIN el_dataset_6 d6 
ON dm.patient_id = d6.patient_id 
AND dm.org_id = d6.organization_id
SET dm.req_interpret_code = d6.interp_codes,
    dm.req_interpret_date = d6.interp_dates;

-- deceased codes and dates
CALL ELObservationFromCohort(8, NULL);

DROP TABLE IF EXISTS el_dataset_7;

CREATE TABLE el_dataset_7 AS
SELECT o.patient_id                                                               AS patient_id, 
       o.organization_id                                                          AS organization_id, 
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS rip_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS rip_dates 
FROM data_extracts.elobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE el_dataset_7 ADD INDEX elpatientIdIdx7 (patient_id);
ALTER TABLE el_dataset_7 ADD INDEX elorgIdx7 (organization_id);

UPDATE el_dm_dataset dm 
JOIN el_dataset_7 d7 
ON dm.patient_id = d7.patient_id 
AND dm.org_id = d7.organization_id
SET dm.deceased_code = d7.rip_codes,
    dm.deceased_date = d7.rip_dates;

-- BP Measurements
CALL ELObservationFromCohort(14, NULL);

DROP TABLE IF EXISTS el_dataset_8;

CREATE TABLE el_dataset_8 AS 
SELECT o.patient_id                  AS patient_id, 
       o.result_value                AS result, 
       o.clinical_effective_date     AS effective_date,
       o.parent_observation_id       AS parent_observation_id,
       o.snomed_concept_id           AS snomed_concept_id,
       o.organization_id             AS organization_id
FROM data_extracts.elobservationfromcohort o 
WHERE o.result_value IS NOT NULL;

ALTER TABLE el_dataset_8 ADD INDEX elpatientIdIdx8 (patient_id);
ALTER TABLE el_dataset_8 ADD INDEX elorgIdx8 (organization_id);

-- delete all records except the latest

DELETE t
FROM el_dataset_8 as t
JOIN ( SELECT patient_id, MAX(effective_date) AS latest 
       FROM el_dataset_8
       GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;

-- update dataset with the latest records

UPDATE el_dm_dataset dm 
JOIN (SELECT d8.patient_id                                                        AS patient_id, 
             GROUP_CONCAT(CONCAT(d8.result, '/', b.result) SEPARATOR ',')         AS result, 
             d8.effective_date                                                    AS effective_date,
             d8.organization_id                                                   AS organization_id
      FROM el_dataset_8 d8 JOIN (SELECT a.result, 
                                        a.patient_id, 
                                        a.parent_observation_id
                                 FROM el_dataset_8 a
                                 WHERE a.snomed_concept_id = 1091811000000102) b  -- Diastolic
ON d8.patient_id = b.patient_id AND d8.parent_observation_id = b.parent_observation_id 
WHERE d8.snomed_concept_id = 72313002   -- Systolic
GROUP BY d8.patient_id) d88 
ON dm.patient_id = d88.patient_id 
AND dm.org_id = d88.organization_id
SET dm.LAST_BP = d88.result,
    dm.BP_DATE = d88.effective_date;
    
-- Glycated haemoglobin Measurements

CALL ELObservationFromCohort(15, NULL);

DROP TABLE IF EXISTS el_dataset_9;

CREATE TABLE el_dataset_9 AS 
SELECT o.patient_id               AS patient_id, 
       o.result_value             AS result, 
       o.clinical_effective_date  AS effective_date,
       o.snomed_concept_id        AS snomed_concept_id,
       o.organization_id          AS organization_id
FROM data_extracts.elobservationfromcohort o 
WHERE o.result_value IS NOT NULL;

ALTER TABLE el_dataset_9 ADD INDEX elpatientIdIdx9 (patient_id);
ALTER TABLE el_dataset_9 ADD INDEX elorgIdx9 (organization_id);

-- delete all records except the latest

DELETE t
FROM el_dataset_9 as t
JOIN ( SELECT patient_id, 
              MAX(effective_date) AS latest 
       FROM el_dataset_9
       GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;


UPDATE el_dm_dataset dm 
JOIN (SELECT d9.patient_id          AS patient_id, 
             d9.result              AS result, 
             d9.effective_date      AS effective_date,
             d9.organization_id     AS organization_id
      FROM el_dataset_9 d9
GROUP BY d9.patient_id) d99 
ON dm.patient_id = d99.patient_id 
AND dm.org_id = d99.organization_id
SET dm.last_hba1c = d99.result,
    dm.hba1c_date = d99.effective_date;
    
-- check for pregnancy  

CALL ELObservationFromCohort(10, 11);

DROP TABLE IF EXISTS el_dataset_10;

-- check preg del codes

CREATE TABLE el_dataset_10 AS    
SELECT  
       o.patient_id                AS patient_id, 
       o.clinical_effective_date   AS effective_date, 
       o.snomed_concept_id         AS snomed_concept_id,
       o.organization_id           AS organization_id
FROM data_extracts.elobservationfromcohort o;
 
ALTER TABLE el_dataset_10 ADD INDEX elpatientIdIdx10 (patient_id);
ALTER TABLE el_dataset_10 ADD INDEX elorgIdx10 (organization_id);

-- delete all records except the latest

DELETE t
FROM el_dataset_10 as t
JOIN ( SELECT patient_id, 
              MAX(effective_date) AS latest 
       FROM el_dataset_10
       GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;
               
CALL ELObservationFromCohort(12, 13);

DROP TABLE IF EXISTS el_dataset_11;

-- check preg code

CREATE TABLE el_dataset_11 AS    
SELECT  
       o.patient_id                AS patient_id, 
       o.clinical_effective_date   AS effective_date, 
       o.snomed_concept_id         AS snomed_concept_id,
       o.organization_id           AS organization_id
FROM data_extracts.elobservationfromcohort o
WHERE EXISTS (SELECT 'x' FROM data_extracts.el_dataset_10 d10
              WHERE d10.patient_id = o.patient_id
              AND d10.organization_id = o.organization_id);

ALTER TABLE el_dataset_11 ADD INDEX elpatientIdIdx11 (patient_id);
ALTER TABLE el_dataset_11 ADD INDEX elorgIdx11 (organization_id);

-- delete all records except the latest

DELETE t
FROM el_dataset_11 as t
JOIN ( SELECT patient_id, 
              MAX(effective_date) AS latest 
       FROM el_dataset_11
       GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;

-- update pregnancy code

UPDATE el_dm_dataset dm 
JOIN el_dataset_11 d11 
ON dm.patient_id = d11.patient_id AND dm.org_id = d11.organization_id
SET dm.pat_preg_likely = 'Yes',
    dm.pregnancy_code = d11.snomed_concept_id,
    dm.pregnancy_date = d11.effective_date;
    

DROP TABLE IF EXISTS el_dataset_1;
DROP TABLE IF EXISTS el_dataset_2;
DROP TABLE IF EXISTS el_dataset_3;
DROP TABLE IF EXISTS el_dataset_4;
DROP TABLE IF EXISTS el_dataset_5;
DROP TABLE IF EXISTS el_dataset_6;
DROP TABLE IF EXISTS el_dataset_7;
DROP TABLE IF EXISTS el_dataset_8;
DROP TABLE IF EXISTS el_dataset_9;
DROP TABLE IF EXISTS el_dataset_10;
DROP TABLE IF EXISTS el_dataset_11;

ALTER TABLE el_dm_dataset DROP COLUMN org_id;

END//
DELIMITER ;