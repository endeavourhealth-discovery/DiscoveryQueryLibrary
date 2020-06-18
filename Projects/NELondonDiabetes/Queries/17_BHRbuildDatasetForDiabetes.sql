USE data_extracts;

DROP PROCEDURE IF EXISTS BHRbuildDatasetForDiabetes;

DELIMITER //

CREATE PROCEDURE BHRbuildDatasetForDiabetes()
BEGIN

  DROP TABLE IF EXISTS bhr_dm_dataset;

  CREATE TABLE bhr_dm_dataset
  (
    RUN_DATE           DATE,
    PSEUDO_ID          VARCHAR(255),
    ELIGIBLE           VARCHAR(10),
    PATIENT_ID         BIGINT(20),
    NHS_NO             VARCHAR(255),
    -- TITLE              VARCHAR(50),
    FIRSTNAME          VARCHAR(255),
    LASTNAME           VARCHAR(255),
    ADDR_1             VARCHAR(255),
    ADDR_2             VARCHAR(255),
    ADDR_3             VARCHAR(255),
    ADDR_4             VARCHAR(255),
    POST_CODE          VARCHAR(10),
    GENDER             VARCHAR(10),
    ETHNICITY          VARCHAR(20),
    AGE                VARCHAR(10),
    BIRTH_DATE         VARCHAR(20),
    PRACTICE_CODE      VARCHAR(50),
    PRACTICE_REG_DATE  VARCHAR(10),
    -- MOBILE_TEL_NO      VARCHAR(50),
    -- HOME_TEL_NO        VARCHAR(50),
    DEATH_DATE         VARCHAR(20),
    LAST_BP            VARCHAR(100),
    BP_DATE            VARCHAR(100),
    LAST_HBA1C         VARCHAR(100),
    HBA1C_DATE         VARCHAR(100),
    DM_CODE            VARCHAR(500),
    DM_DATE            VARCHAR(500),
    PAT_PREG_LIKELY    VARCHAR(10),
    PREGNANCY_CODE     VARCHAR(100),
    PREGNANCY_DATE     VARCHAR(100),
    DM_RESOLVED_CODE   VARCHAR(500),
    DM_RESOLVED_DATE   VARCHAR(500),
    ELIG_CODE          VARCHAR(500),
    ELIG_DATE          VARCHAR(500),
    ETHNIC_CODE        VARCHAR(500),
    ETHNIC_DATE        VARCHAR(500),
    PREF_LANG_CODE     VARCHAR(500),
    PREF_LANG_DATE     VARCHAR(500),
    REQ_INTERPRET_CODE VARCHAR(500),
    REQ_INTERPRET_DATE VARCHAR(500),
    DECEASED_CODE      VARCHAR(500),
    DECEASED_DATE      VARCHAR(500),
    ORG_ID             BIGINT(20)
  );

  ALTER TABLE bhr_dm_dataset ADD INDEX bhr_dm_psuedoIdIdx (pseudo_id);
  ALTER TABLE bhr_dm_dataset ADD INDEX bhr_dm_patientIdIdx (patient_id);
  ALTER TABLE bhr_dm_dataset ADD INDEX bhr_dm_orgIdIdx (org_id);


  INSERT INTO bhr_dm_dataset
    (run_date, eligible, patient_id, pseudo_id, practice_code, practice_reg_date, org_id, death_date)
  SELECT DISTINCT now(), 'Yes', patient_id, group_by, practice_code, registered_date, organization_id, date_of_death
  FROM data_extracts.cohort_bhr;

  UPDATE bhr_dm_dataset dm
  JOIN enterprise_pi.patient p  ON dm.patient_id = p.id
  JOIN enterprise_pi.person per ON p.person_id = per.id
  JOIN enterprise_pi.patient_gender ptg ON p.patient_gender_id = ptg.id
  SET dm.age = ROUND(DATEDIFF(NOW(), per.date_of_birth) / 365.25),
      dm.birth_date = per.date_of_birth,
      dm.ethnicity = per.ethnic_code,
      dm.gender = SUBSTRING(ptg.value,1,1),
      dm.nhs_no = per.nhs_number,
      dm.post_code = per.postcode;

-- build required dataset

-- diabetes mellitus codes and dates

CALL BHRObservationFromCohort(1, NULL);

DROP TABLE IF EXISTS bhr_dataset_1;

CREATE TABLE bhr_dataset_1 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS dm_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS dm_dates
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_1 ADD INDEX bhrpatientIdIdx1 (patient_id);
ALTER TABLE bhr_dataset_1 ADD INDEX bhrorgIdx1 (organization_id);

UPDATE bhr_dm_dataset dm
JOIN bhr_dataset_1 d1
ON dm.patient_id = d1.patient_id AND dm.org_id = d1.organization_id
SET dm.dm_code = d1.dm_codes,
    dm.dm_date = d1.dm_dates;

-- diabetes resolved codes and dates

CALL BHRObservationFromCohort(9, NULL);

DROP TABLE IF EXISTS bhr_dataset_2;

CREATE TABLE bhr_dataset_2 AS
SELECT o.patient_id              AS patient_id,
       o.organization_id         AS organization_id,
       o.snomed_concept_id       AS resolved_code,
       o.clinical_effective_date AS resolved_date
FROM data_extracts.bhrobservationfromcohort o;

ALTER TABLE bhr_dataset_2 ADD INDEX bhrpatientIdIdx2 (patient_id);
ALTER TABLE bhr_dataset_2 ADD INDEX bhrorgIdx2 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN (SELECT patient_id, resolved_code, MAX(resolved_date) AS resolved_date , organization_id
      FROM data_extracts.bhr_dataset_2
      GROUP BY patient_id, resolved_code, organization_id) d2 
ON dm.patient_id = d2.patient_id AND dm.org_id = d2.organization_id
SET dm.dm_resolved_code = d2.resolved_code,
    dm.dm_resolved_date = d2.resolved_date;
      
-- eligibility codes and dates

CALL BHRObservationFromCohort(4, NULL);

DROP TABLE IF EXISTS bhr_dataset_3;

CREATE TABLE bhr_dataset_3 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS elig_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS elig_dates  
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_3 ADD INDEX bhrpatientIdIdx3 (patient_id);
ALTER TABLE bhr_dataset_3 ADD INDEX bhrorgIdx3 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_3 d3 ON dm.patient_id = d3.patient_id 
AND dm.org_id = d3.organization_id
SET dm.eligible  = 'No',
    dm.elig_code = d3.elig_codes,
    dm.elig_date = d3.elig_dates;

-- ethnicity codes and dates

CALL BHRObservationFromCohort(5, NULL);

DROP TABLE IF EXISTS bhr_dataset_4;

CREATE TABLE bhr_dataset_4 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS eth_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS eth_dates 
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_4 ADD INDEX bhrpatientIdIdx4 (patient_id);
ALTER TABLE bhr_dataset_4 ADD INDEX bhrorgIdx4 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_4 d4 ON dm.patient_id = d4.patient_id 
AND dm.org_id = d4.organization_id
SET dm.ethnic_code = d4.eth_codes,
    dm.ethnic_date = d4.eth_dates;

-- preferred language codes and dates
CALL BHRObservationFromCohort(6, NULL);

DROP TABLE IF EXISTS bhr_dataset_5;

CREATE TABLE bhr_dataset_5 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS lang_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS lang_dates 
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_5 ADD INDEX bhrpatientIdIdx5 (patient_id);
ALTER TABLE bhr_dataset_5 ADD INDEX bhrorgIdx5 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_5 d5 ON dm.patient_id = d5.patient_id 
AND dm.org_id = d5.organization_id
SET dm.pref_lang_code = d5.lang_codes,
    dm.pref_lang_date = d5.lang_dates;

-- interpreter codes and dates

CALL BHRObservationFromCohort(7, NULL);

DROP TABLE IF EXISTS bhr_dataset_6;

CREATE TABLE bhr_dataset_6 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS interp_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS interp_dates 
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_6 ADD INDEX bhrpatientIdIdx6 (patient_id);
ALTER TABLE bhr_dataset_6 ADD INDEX bhrorgIdx6 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_6 d6 ON dm.patient_id = d6.patient_id 
AND dm.org_id = d6.organization_id
SET dm.req_interpret_code = d6.interp_codes,
    dm.req_interpret_date = d6.interp_dates;

-- deceased codes and dates
CALL BHRObservationFromCohort(8, NULL);

DROP TABLE IF EXISTS bhr_dataset_7;

CREATE TABLE bhr_dataset_7 AS
SELECT o.patient_id                                                               AS patient_id,
       o.organization_id                                                          AS organization_id,
       GROUP_CONCAT(o.snomed_concept_id ORDER BY o.clinical_effective_date)       AS rip_codes, 
       GROUP_CONCAT(o.clinical_effective_date ORDER BY o.clinical_effective_date) AS rip_dates 
FROM data_extracts.bhrobservationfromcohort o 
GROUP BY o.patient_id, o.organization_id;

ALTER TABLE bhr_dataset_7 ADD INDEX bhrpatientIdIdx7 (patient_id);
ALTER TABLE bhr_dataset_7 ADD INDEX bhrorgIdx7 (organization_id);

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_7 d7 ON dm.patient_id = d7.patient_id 
AND dm.org_id = d7.organization_id
SET dm.deceased_code = d7.rip_codes,
    dm.deceased_date = d7.rip_dates;

-- BP Measurements

CALL BHRObservationFromCohort(14, NULL);

DROP TABLE IF EXISTS bhr_dataset_8;

CREATE TABLE bhr_dataset_8 AS
SELECT o.patient_id                  AS patient_id,
       o.result_value                AS result,
       o.clinical_effective_date     AS effective_date,
       o.parent_observation_id       AS parent_observation_id,
       o.snomed_concept_id           AS snomed_concept_id,
       o.organization_id             AS organization_id
FROM data_extracts.bhrobservationfromcohort o
WHERE o.result_value IS NOT NULL;

ALTER TABLE bhr_dataset_8 ADD INDEX bhrpatientIdIdx8 (patient_id);
ALTER TABLE bhr_dataset_8 ADD INDEX bhrorgIdx8 (organization_id);

-- delete all records except the latest

DELETE t
FROM bhr_dataset_8 as t
  JOIN ( 
  SELECT patient_id, MAX(effective_date) AS latest
  FROM bhr_dataset_8
  GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;

-- update dataset with the latest records

UPDATE bhr_dm_dataset dm 
JOIN (SELECT d8.patient_id                                                        AS patient_id, 
             GROUP_CONCAT(CONCAT(d8.result,'/',b.result) SEPARATOR ',')           AS result, 
             d8.effective_date                                                    AS effective_date,
             d8.organization_id                                                   AS organization_id
      FROM bhr_dataset_8 d8 JOIN (SELECT a.result, 
                                        a.patient_id, 
                                        a.parent_observation_id
                                 FROM bhr_dataset_8 a
                                 WHERE a.snomed_concept_id = 1091811000000102) b  -- Diastolic
ON d8.patient_id = b.patient_id AND d8.parent_observation_id = b.parent_observation_id 
WHERE d8.snomed_concept_id = 72313002   -- Systolic
GROUP BY d8.patient_id) d88 
ON dm.patient_id = d88.patient_id 
AND dm.org_id = d88.organization_id
SET dm.LAST_BP = d88.result,
    dm.BP_DATE = d88.effective_date;
    
-- Glycated haemoglobin Measurements

CALL BHRObservationFromCohort(15, NULL);

DROP TABLE IF EXISTS bhr_dataset_9;

CREATE TABLE bhr_dataset_9 AS
SELECT o.patient_id               AS patient_id,
       o.result_value             AS result,
       o.clinical_effective_date  AS effective_date,
       o.snomed_concept_id        AS snomed_concept_id,
       o.organization_id          AS organization_id
FROM data_extracts.bhrobservationfromcohort o
WHERE o.result_value IS NOT NULL;

ALTER TABLE bhr_dataset_9 ADD INDEX bhrpatientIdIdx9 (patient_id);
ALTER TABLE bhr_dataset_9 ADD INDEX bhrorgIdx9 (organization_id);

-- delete all records except the latest

DELETE t
FROM bhr_dataset_9 as t
  JOIN ( 
  SELECT patient_id, MAX(effective_date) AS latest
  FROM bhr_dataset_9
  GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;


UPDATE bhr_dm_dataset dm 
JOIN
(
SELECT d9.patient_id          AS patient_id,
       d9.result              AS result,
       d9.effective_date      AS effective_date,
       d9.organization_id     AS organization_id
FROM bhr_dataset_9 d9
GROUP BY d9.patient_id) d99 
ON dm.patient_id = d99.patient_id 
AND dm.org_id = d99.organization_id
SET dm.last_hba1c = d99.result,
    dm.hba1c_date = d99.effective_date;
    
-- check for pregnancy  

CALL BHRObservationFromCohort(10, 11);

DROP TABLE IF EXISTS bhr_dataset_10;

-- check preg del codes

CREATE TABLE bhr_dataset_10 AS
SELECT
  o.patient_id                AS patient_id,
  o.clinical_effective_date   AS effective_date,
  o.snomed_concept_id         AS snomed_concept_id,
  o.organization_id           AS organization_id
FROM data_extracts.bhrobservationfromcohort o;

ALTER TABLE bhr_dataset_10 ADD INDEX bhrpatientIdIdx10 (patient_id);
ALTER TABLE bhr_dataset_10 ADD INDEX bhrorgIdx10 (organization_id);

-- delete all records except the latest

DELETE t
FROM bhr_dataset_10 as t
  JOIN ( 
  SELECT patient_id, MAX(effective_date) AS latest
  FROM bhr_dataset_10
  GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;


CALL BHRObservationFromCohort(12, 13);

DROP TABLE IF EXISTS bhr_dataset_11;

-- check preg code

CREATE TABLE bhr_dataset_11 AS
SELECT
      o.patient_id                AS patient_id,
      o.clinical_effective_date   AS effective_date,
      o.snomed_concept_id         AS snomed_concept_id,
      o.organization_id           AS organization_id
FROM data_extracts.bhrobservationfromcohort o
WHERE EXISTS (SELECT 'x' FROM data_extracts.bhr_dataset_10 d10
              WHERE d10.patient_id = o.patient_id
              AND d10.organization_id = o.organization_id);

ALTER TABLE bhr_dataset_11 ADD INDEX elpatientIdIdx11 (patient_id);
ALTER TABLE bhr_dataset_11 ADD INDEX elorgIdx11 (organization_id);

-- delete all records except the latest

DELETE t
FROM bhr_dataset_11 as t
  JOIN ( SELECT patient_id, 
         MAX(effective_date) AS latest
         FROM bhr_dataset_11
         GROUP BY patient_id
) m ON t.patient_id = m.patient_id AND t.effective_date < m.latest;

-- update pregnancy code

UPDATE bhr_dm_dataset dm 
JOIN bhr_dataset_11 d11
ON dm.patient_id = d11.patient_id AND dm.org_id = d11.organization_id
SET dm.pat_preg_likely = 'Yes',
    dm.pregnancy_code = d11.snomed_concept_id,
    dm.pregnancy_date = d11.effective_date;

DROP TABLE IF EXISTS bhr_dataset_1;
DROP TABLE IF EXISTS bhr_dataset_2;
DROP TABLE IF EXISTS bhr_dataset_3;
DROP TABLE IF EXISTS bhr_dataset_4;
DROP TABLE IF EXISTS bhr_dataset_5;
DROP TABLE IF EXISTS bhr_dataset_6;
DROP TABLE IF EXISTS bhr_dataset_7;
DROP TABLE IF EXISTS bhr_dataset_8;
DROP TABLE IF EXISTS bhr_dataset_9;
DROP TABLE IF EXISTS bhr_dataset_10;
DROP TABLE IF EXISTS bhr_dataset_11;

ALTER TABLE bhr_dm_dataset DROP COLUMN org_id;

END//
DELIMITER ;