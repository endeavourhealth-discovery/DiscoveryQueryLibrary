USE data_extracts;

-- ahui 03/3/2020

DROP PROCEDURE IF EXISTS createObservationsFromLBHSCCohort;

DELIMITER //
CREATE PROCEDURE createObservationsFromLBHSCCohort (
    IN filterType INT -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort_gh2.pivot_date (6 months)
)
BEGIN


DROP TABLE IF EXISTS ObservationsFromLBHSCCohort;

IF (filterType IN (0, 1)) THEN 

-- latest or earliest or ever (so all observations)

 CREATE TABLE ObservationsFromLBHSCCohort AS
      SELECT DISTINCT
             o.id,
             o.patient_id,
             o.person_id,
             o.group_by,
             o.clinical_effective_date,
             o.original_code,
             o.original_term,
             o.result_value,
             o.result_value_units
      FROM cohort_lbhsc_observations o
      WHERE EXISTS (SELECT 'x' FROM snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
      AND o.clinical_effective_date IS NOT NULL;
      
END IF;

ALTER TABLE ObservationsFromLBHSCCohort ADD INDEX grp_by_idx (group_by);

END//
DELIMITER ;