USE data_extracts;

-- ahui 3/3/2020

DROP PROCEDURE IF EXISTS createCohortForLBHSC;

DELIMITER //
CREATE PROCEDURE createCohortForLBHSC()
BEGIN

DROP TABLE IF EXISTS cohort_lbhsc;

CREATE TABLE cohort_lbhsc AS
SELECT
        b.group_by,
        b.person_id,
        b.organization_id,
        b.NhsNumber,
        b.Gender,
        b.BirthDate,
        b.DateOfDeath,
        b.rnk
FROM (
SELECT
        a.group_by,
        a.person_id,
        a.organization_id,
        a.NhsNumber,
        a.Gender,
        a.BirthDate,
        a.DateOfDeath,
        @currank := IF(@curperson = a.person_id, @currank + 1, 1) AS rnk,
        @curperson := a.person_id AS cur_person
FROM (SELECT  DISTINCT
              d.pseudo_id AS group_by,
              p.person_id,
              p.organization_id,
              d.NhsNumber,
              d.Gender,
              d.BirthDate,
              d.DateOfDeath
     FROM start_data_lbhsc d
          JOIN enterprise_pseudo.patient p ON p.pseudo_id = d.pseudo_id
          JOIN enterprise_pseudo.episode_of_care e ON e.patient_id = p.id
          JOIN enterprise_pseudo.organization org ON org.id = p.organization_id
     WHERE EXISTS (SELECT 'x' FROM lbhsc_eastlondonccg_codes ccgs
                   WHERE ccgs.parent IN ('City & Hackney CCG','Newham CCG','Tower Hamlets CCG', 'Waltham Forest CCG') AND ccgs.local_id = org.ods_code)
     AND EXISTS (SELECT 'x' FROM lsoa_lookup lso WHERE lso.code = p.lsoa_code)
     AND e.registration_type_id = 2
     AND e.date_registered <= DATE_FORMAT("2017-04-01", "%Y-%m-%d")
     AND (e.date_registered_end > DATE_FORMAT("2017-04-01", "%Y-%m-%d") OR e.date_registered_end IS NULL)
     ORDER BY p.person_id, ISNULL(d.DateOfDeath), d.DateOfDeath ASC ) a, (SELECT @currank := 0, @curperson := 0) r ) b
WHERE b.rnk = 1;


ALTER TABLE cohort_lbhsc ADD INDEX lbhsc_groupby_idx(group_by);


DROP TABLE IF EXISTS cohort_lbhsc_observations;

CREATE TABLE cohort_lbhsc_observations 
AS
SELECT DISTINCT
       o.id,
       o.patient_id,
       o.person_id,
       cr.group_by,
       o.clinical_effective_date,
       o.snomed_concept_id AS original_code,
       SUBSTRING(o.original_term, 1, 200) AS original_term,
       o.result_value,
       o.result_value_units
FROM enterprise_pseudo.observation o JOIN cohort_lbhsc cr
ON o.person_id = cr.person_id 
AND o.organization_id = o.organization_id

CREATE INDEX lbhsc_obs_code_idx ON cohort_lbhsc_observations(original_code);
CREATE INDEX lbhsc_obs_grp_idx ON cohort_lbhsc_observations(group_by);

DROP TABLE IF EXISTS cohort_lbhsc_encounter_raw;

CREATE TABLE cohort_lbhsc_encounter_raw 
AS 
SELECT r.person_id,
       r.patient_id, 
       r.clinical_effective_date,
       SUBSTRING(UPPER(r.fhir_original_term),1,200) fhir_original_term,
       r.organization_id 
FROM enterprise_pseudo.encounter_raw r JOIN cohort_lbhsc c ON r.patient_id = c.patient_id;

CREATE INDEX lbhsc_encounter_term_idx ON cohort_lbhsc_encounter_raw(fhir_original_term);
CREATE INDEX lbhsc_encounter_person_idx ON cohort_lbhsc_encounter_raw(person_id);

END//
DELIMITER ;