USE data_extracts;

DROP PROCEDURE IF EXISTS ELbuildCohortForDiabetes;

DELIMITER //

CREATE PROCEDURE ELbuildCohortForDiabetes()
BEGIN

  DROP TABLE IF EXISTS cohort_el;

  -- build cohort of anyone who had diabetes

  CREATE TABLE cohort_el AS
  SELECT DISTINCT
    p.id                                           AS patient_id,
    p.person_id                                    AS person_id,
    p.pseudo_id                                    AS group_by,
    org.id                                         AS organization_id,
    org.ods_code                                   AS practice_code,
    org.name                                       AS practice_name,
    e.date_registered                              AS registered_date,
    p.date_of_death                                AS date_of_death
  FROM ceg_compass_data.observation o
    JOIN ceg_compass_data.organization org ON org.id = o.organization_id
    JOIN ceg_compass_data.patient p ON p.id = o.patient_id
    JOIN ceg_compass_data.episode_of_care e ON e.patient_id = o.patient_id
  WHERE EXISTS (SELECT 'x'
                FROM data_extracts.snomed_codes s
                WHERE s.group_id = 1 AND s.snomed_id = o.snomed_concept_id)
  AND NOT EXISTS (SELECT 'x'
                  FROM data_extracts.snomed_codes s
                  WHERE s.group_id = 2 AND s.snomed_id = o.snomed_concept_id)
  AND org.ods_code IN (SELECT el.local_id
                       FROM data_extracts.elccg_codes el
                       WHERE el.parent IN ('City & Hackney CCG','Newham CCG','Tower Hamlets CCG','Waltham Forest CCG')
                       )
  AND p.date_of_death IS NULL
  AND e.registration_type_id = 2
  AND e.date_registered <= now()
  AND (e.date_registered_end > now() or e.date_registered_end IS NULL)
  AND (p.age_years >= 12);


  ALTER TABLE cohort_el ADD INDEX elgroupByIdx (group_by);
  ALTER TABLE cohort_el ADD INDEX elpatientIdx (patient_id);
  ALTER TABLE cohort_el ADD INDEX elprcidx (practice_code);

END
//

DELIMITER ;


