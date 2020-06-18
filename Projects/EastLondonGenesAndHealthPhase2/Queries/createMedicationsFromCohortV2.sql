USE data_extracts;

-- ahui 9/2/2020

DROP PROCEDURE IF EXISTS createMedicationsFromCohortV2;

DELIMITER //

CREATE PROCEDURE createMedicationsFromCohortV2()
BEGIN

DROP TEMPORARY TABLE IF EXISTS gh2_snomeds_tmp;

CREATE TEMPORARY TABLE gh2_snomeds_tmp AS
SELECT cat_id, 
       snomed_id 
FROM gh2_snomeds 
WHERE cat_id IN (3, 4);

DELETE t1 FROM gh2_snomeds t1 JOIN gh2_snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1, 2);

DROP TABLE IF EXISTS medicationsFromCohortV2;

-- latest or earliest or ever (so all medications)

CREATE TABLE medicationsFromCohortV2 AS
      SELECT DISTINCT
             m.id,
             m.original_code,
             m.person_id,
             m.patient_id,
             m.group_by,
             SUBSTRING(m.original_term,1,200) AS original_term,
             m.clinical_effective_date,
             m.cancellation_date
      FROM cohort_gh2_medications m 
      WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
      AND m.clinical_effective_date IS NOT NULL;

ALTER TABLE medicationsFromCohortV2 ADD INDEX gh2_med_pat_idx1 (patient_id);
ALTER TABLE medicationsFromCohortV2 ADD INDEX gh2_dmdId_idx (original_code);

END//
DELIMITER ;