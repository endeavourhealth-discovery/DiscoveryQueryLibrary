USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS createCohortForELGH2;

DELIMITER //
CREATE PROCEDURE createCohortForELGH2()
BEGIN

DROP TABLE IF EXISTS cohort_gh2;

CREATE TABLE cohort_gh2 AS
    SELECT
        p.id               AS patient_id,
        p.pseudo_id        AS group_by,
        p.person_id        AS person_id,
        p.organization_id  AS organization_id,
        n.pseudo_nhsnumber AS pseudo_nhsnumber,
        p.age_years
    FROM gh2_pseudonhsnumbers n
        JOIN enterprise_pseudo.link_distributor l
            ON n.pseudo_nhsnumber = l.target_skid AND l.target_salt_key_name = 'EGH'
        JOIN enterprise_pseudo.patient p ON p.pseudo_id = l.source_skid
        JOIN enterprise_pseudo.organization org ON p.organization_id = org.id
    WHERE EXISTS (SELECT 'x' FROM gh2ccg_codes gh2ccgs
                  WHERE gh2ccgs.parent IN ('City & Hackney CCG','Newham CCG','Tower Hamlets CCG', 'Waltham Forest CCG')
                  AND gh2ccgs.local_id = org.ods_code);

ALTER TABLE cohort_gh2 ADD COLUMN pivot_date  DATE;
-- ALTER TABLE cohort_gh2 ADD COLUMN age_years   INT(11);

ALTER TABLE cohort_gh2 ADD INDEX gh2_groupby_idx (group_by);
-- ALTER TABLE cohort_gh2 ADD INDEX gh2_patientid_idx (patient_id);
ALTER TABLE cohort_gh2 ADD INDEX gh2_personid_idx (person_id);

DROP TABLE IF EXISTS cohort_gh2_observations;

CREATE TABLE cohort_gh2_observations AS
       SELECT DISTINCT
              o.id,
              o.patient_id,
              o.person_id,
              cr.group_by,
              cr.pivot_date,
              o.clinical_effective_date,
              o.snomed_concept_id AS original_code,
              SUBSTRING(o.original_term, 1, 200) AS original_term,
              o.result_value,
              o.result_value_units,
              cr.age_years
      FROM enterprise_pseudo.observation o JOIN cohort_gh2 cr
      ON o.person_id = cr.person_id 
      AND o.organization_id = cr.organization_id
      AND o.patient_id = cr.patient_id;

CREATE INDEX gh2_obs_ix ON cohort_gh2_observations(original_code);
CREATE INDEX gh2_obs_grpby_ix ON cohort_gh2_observations(group_by);

DROP TABLE IF EXISTS cohort_gh2_medications_stmt;

CREATE TABLE cohort_gh2_medications_stmt AS
      SELECT DISTINCT
             m.id,
             m.dmd_id AS original_code,
             m.person_id,
             m.patient_id,
             cr.group_by,
             cr.pivot_date,
             SUBSTRING(m.original_term, 1, 200) AS original_term,
             m.cancellation_date
      FROM enterprise_pseudo.medication_statement m 
      JOIN cohort_gh2 cr ON  m.organization_id = cr.organization_id AND m.person_id = cr.person_id AND m.patient_id = cr.patient_id;
      
 CREATE INDEX gh2_med_stmt_ix ON cohort_gh2_medications_stmt(id);    
  
 DROP TABLE IF EXISTS cohort_gh2_medications_ord;
 
 CREATE TABLE cohort_gh2_medications_ord AS    
      SELECT DISTINCT
             mo.id,
             mo.medication_statement_id,
             mo.person_id,
             mo.patient_id,
             mo.clinical_effective_date  
      FROM enterprise_pseudo.medication_order mo
      JOIN cohort_gh2 cr ON  mo.organization_id = cr.organization_id AND mo.person_id = cr.person_id AND mo.patient_id = cr.patient_id;
      
 CREATE INDEX gh2_med_ord_ix ON cohort_gh2_medications_ord(medication_statement_id);      
  
 DROP TABLE IF EXISTS cohort_gh2_medications;

 CREATE TABLE cohort_gh2_medications AS
      SELECT DISTINCT
             ms.id,
             ms.original_code,
             ms.person_id,
             ms.patient_id,
             ms.group_by,
             ms.pivot_date,
             ms.original_term,
             mo.clinical_effective_date,
             ms.cancellation_date
       FROM cohort_gh2_medications_stmt ms JOIN cohort_gh2_medications_ord mo ON ms.id = mo.medication_statement_id;

CREATE INDEX gh2_med_ix ON cohort_gh2_medications(original_code);
CREATE INDEX gh2_med_grpby_ix ON cohort_gh2_medications(group_by);

DROP TABLE IF EXISTS cohort_gh2_encounter_raw ;

CREATE TABLE cohort_gh2_encounter_raw 
AS 
SELECT r.person_id,
       r.patient_id, 
       r.clinical_effective_date,
       SUBSTRING(UPPER(r.fhir_original_term),1,200) fhir_original_term,
       r.organization_id 
FROM enterprise_pseudo.encounter_raw r JOIN cohort_gh2 c ON r.patient_id = c.patient_id;

CREATE INDEX gh2_encounter_term_idx ON cohort_gh2_encounter_raw(fhir_original_term);
CREATE INDEX gh2_encounter_person_idx ON cohort_gh2_encounter_raw(person_id);


END//
DELIMITER ;