USE data_extracts;

DROP PROCEDURE IF EXISTS BHRbuildCohortForDiabetes;

DELIMITER //

CREATE PROCEDURE BHRbuildCohortForDiabetes()
BEGIN

  DROP TABLE IF EXISTS cohort_bhr;

  -- build cohort of anyone who had diabetes

  CREATE TABLE cohort_bhr AS
  SELECT DISTINCT
    p.id                                       AS patient_id,
    p.person_id                                AS person_id,
    p.nhs_number                               AS group_by,
    org.id                                     AS organization_id,
    org.ods_code                               AS practice_code,
    org.name                                   AS practice_name,
    e.date_registered                          AS registered_date,
    p.date_of_death                            AS date_of_death
  FROM enterprise_pi.observation o
    JOIN enterprise_pi.organization org ON org.id = o.organization_id
    JOIN enterprise_pi.patient p ON p.id = o.patient_id
    JOIN enterprise_pi.episode_of_care e ON e.patient_id = o.patient_id
  WHERE EXISTS (SELECT 'x'
                FROM data_extracts.snomed_codes s
                WHERE s.group_id = 1
                AND s.snomed_id = o.snomed_concept_id)
    AND NOT EXISTS (SELECT 'x'
                    FROM data_extracts.snomed_codes s
                    WHERE s.group_id = 2
                    AND s.snomed_id = o.snomed_concept_id)
    AND org.ods_code IN (SELECT e.local_id
                         FROM data_extracts.elccg_codes e
                         WHERE e.parent IN ('NHS BARKING AND DAGENHAM CCG','NHS HAVERING CCG','NHS REDBRIDGE CCG')
                         ) 
    AND p.date_of_death IS NULL
    AND e.registration_type_id = 2
    AND e.date_registered <= now()
    AND (e.date_registered_end > now() or e.date_registered_end IS NULL)
    AND DATEDIFF(NOW(), p.date_of_birth) / 365.25 >= 12;


  ALTER TABLE cohort_bhr ADD INDEX bhrgroupByIdx (group_by);
  ALTER TABLE cohort_bhr ADD INDEX bhrpatientIdx (patient_id);
  ALTER TABLE cohort_bhr ADD INDEX bhrprcidx (practice_code);

END
//

DELIMITER ;


