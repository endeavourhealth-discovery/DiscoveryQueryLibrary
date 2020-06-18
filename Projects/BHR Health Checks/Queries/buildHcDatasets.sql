USE data_extracts;

DROP PROCEDURE IF EXISTS buildHcDatasets;

DELIMITER //
CREATE PROCEDURE buildHcDatasets()
BEGIN

-- health_checks_invitation_codes_Redbridge_20191001_20191231.csv
DROP TABLE IF EXISTS hc_invite_codes_redbridge;
CREATE TABLE hc_invite_codes_redbridge AS
SELECT 
       d.patient_id*2 patient_id,
       d.ods_code,
       d.clinical_effective_date,
       d.original_code,
       d.original_term
FROM tmp_health_checks_invitation_codes d 
     JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Redbridge' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_invitation_codes_Havering_20191001_20191231.csv
DROP TABLE IF EXISTS hc_invite_codes_havering;
CREATE TABLE hc_invite_codes_havering AS
SELECT 
       d.patient_id*2 patient_id,
       d.ods_code,
       d.clinical_effective_date,
       d.original_code,
       d.original_term
FROM tmp_health_checks_invitation_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Havering' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_invitation_codes_BarkingDagenham_20191001_20191231.csv
DROP TABLE IF EXISTS hc_invite_codes_barking;
CREATE TABLE hc_invite_codes_barking AS
SELECT 
       d.patient_id*2 patient_id,
       d.ods_code,
       d.clinical_effective_date,
       d.original_code,
       d.original_term
FROM tmp_health_checks_invitation_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Barking & Dagenham' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_eligible_codes_Redbridge_20191001_20191231.csv
DROP TABLE IF EXISTS hc_eligible_codes_redbridge;
CREATE TABLE hc_eligible_codes_redbridge AS
SELECT 
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term,
      d.result_value,
      d.result_value_units 
FROM tmp_health_checks_cohort_eligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Redbridge' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_eligible_codes_Havering_20191001_20191231.csv
DROP TABLE IF EXISTS hc_eligible_codes_havering;
CREATE TABLE hc_eligible_codes_havering AS
SELECT 
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term,
      d.result_value,
      d.result_value_units 
FROM tmp_health_checks_cohort_eligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Havering' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_eligible_codes_BarkingDagenham_20191001_20191231.csv
DROP TABLE IF EXISTS hc_eligible_codes_barking;
CREATE TABLE hc_eligible_codes_barking AS
SELECT 
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term,
      d.result_value,
      d.result_value_units 
FROM tmp_health_checks_cohort_eligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Barking & Dagenham' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_ineligible_codes_Redbridge_20191001_20191231.csv
DROP TABLE IF EXISTS hc_ineligible_codes_redbridge;
CREATE TABLE hc_ineligible_codes_redbridge AS
SELECT
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term
FROM tmp_health_checks_cohort_ineligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Redbridge' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_ineligible_codes_Havering_20191001_20191231.csv
DROP TABLE IF EXISTS hc_ineligible_codes_havering;
CREATE TABLE hc_ineligible_codes_havering AS
SELECT
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term
FROM tmp_health_checks_cohort_ineligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Havering' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

-- health_checks_cohort_ineligible_codes_BarkingDagenham_20191001_20191231.csv
DROP TABLE IF EXISTS hc_ineligible_codes_barking;
CREATE TABLE hc_ineligible_codes_barking AS
SELECT
      d.patient_id*2 patient_id,
      d.patient_gender_id,
      d.ethnic_code,
      d.lsoa_code,
      d.msoa_code,
      d.clinical_effective_date,
      d.ods_code,
      d.original_code,
      d.original_term
FROM tmp_health_checks_cohort_ineligible_codes d 
JOIN hc_organisations o ON o.ods_code = d.ods_code 
WHERE o.ccg = 'Barking & Dagenham' 
ORDER BY d.ods_code, d.patient_id, d.original_code DESC, d.clinical_effective_date;

END//
DELIMITER ;

