USE data_extracts;

DROP PROCEDURE IF EXISTS BHRObservationFromCohort;

DELIMITER //

CREATE PROCEDURE BHRObservationFromCohort(p_grp_1 int, p_grp_2 int)
BEGIN

  DROP TABLE IF EXISTS bhrobservationfromcohort;

IF (p_grp_1 NOT IN (10, 12)) THEN

  CREATE TABLE bhrobservationfromcohort AS
  SELECT
        o.id,
        o.organization_id,
        o.person_id,
        o.patient_id,
        o.clinical_effective_date  AS clinical_effective_date,
        o.snomed_concept_id,
        o.result_value,
        o.parent_observation_id
  FROM enterprise_pi.observation o JOIN data_extracts.cohort_bhr ce
  ON o.person_id = ce.person_id AND o.organization_id = ce.organization_id
  WHERE EXISTS ( SELECT 'x'
                 FROM data_extracts.snomed_codes s
                 WHERE s.group_id = p_grp_1
                 AND s.snomed_id = o.snomed_concept_id );

ELSE

  CREATE TABLE bhrobservationfromcohort AS
  SELECT
      o.id,
      o.organization_id,
      o.person_id,
      o.patient_id,
      o.clinical_effective_date AS clinical_effective_date,
      o.snomed_concept_id,
      o.result_value,
      o.parent_observation_id
  FROM enterprise_pi.observation o JOIN data_extracts.cohort_bhr ce
  ON o.person_id = ce.person_id AND o.organization_id = ce.organization_id
  WHERE EXISTS (SELECT 'x'
                FROM data_extracts.snomed_codes s
                WHERE s.group_id = p_grp_1
                AND s.snomed_id = o.snomed_concept_id)
  AND NOT EXISTS (SELECT 'x'
                  FROM data_extracts.snomed_codes s
                  WHERE s.group_id = p_grp_2
                  AND s.snomed_id = o.snomed_concept_id)
  AND DATEDIFF(CURDATE(), o.clinical_effective_date) BETWEEN 1 and 240;

END IF;


ALTER TABLE bhrobservationfromcohort ADD INDEX bhrobspersonIdx (person_id);
ALTER TABLE bhrobservationfromcohort ADD INDEX bhrobsordIdx (organization_id);


END
//

DELIMITER ;