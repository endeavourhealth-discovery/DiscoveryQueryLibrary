USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS createObservationsFromCohortV2;

DELIMITER //
CREATE PROCEDURE createObservationsFromCohortV2 (
    IN filterType INT -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort_gh2.pivot_date (6 months)
)
BEGIN

DROP TEMPORARY TABLE IF EXISTS gh2_snomeds_tmp;

CREATE TEMPORARY TABLE gh2_snomeds_tmp AS
SELECT cat_id, 
       snomed_id
FROM gh2_snomeds 
WHERE cat_id IN (3, 4);

DELETE t1 FROM gh2_snomeds t1 JOIN gh2_snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1, 2);

DROP TABLE IF EXISTS observationsFromCohortV2;

IF (filterType = 3) THEN  -- pivot over 6 months from pivot date (already set in cohort)

 CREATE TABLE observationsFromCohortV2 AS
       SELECT DISTINCT
              o.id,
              o.patient_id,
              o.person_id,
              o.group_by,
              o.clinical_effective_date,
              o.original_code,
              SUBSTRING(o.original_term, 1, 200) AS original_term,
              o.result_value,
              o.result_value_units,
              o.age_years
      FROM cohort_gh2_observations o JOIN cohort_gh2 c ON o.group_by = c.group_by
      WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
      AND o.clinical_effective_date IS NOT NULL
      AND o.clinical_effective_date BETWEEN DATE_SUB(c.pivot_date, INTERVAL 6 MONTH) AND DATE_SUB(c.pivot_date, INTERVAL -6 MONTH);

ELSE
-- latest or earliest or ever (so all observations)

 CREATE TABLE observationsFromCohortV2 AS
      SELECT DISTINCT
             o.id,
             o.patient_id,
             o.person_id,
             o.group_by,
             o.clinical_effective_date,
             o.original_code,
             SUBSTRING(o.original_term, 1, 200) AS original_term,
             o.result_value,
             o.result_value_units,
             o.age_years
      FROM cohort_gh2_observations o
      WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
      AND o.clinical_effective_date IS NOT NULL;
END IF;

ALTER TABLE observationsFromCohortV2 ADD INDEX gh2_obv_pat_idx (patient_id);

END//
DELIMITER ;