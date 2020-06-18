USE data_extracts;

DROP PROCEDURE IF EXISTS buildHcCountDatasets;

DELIMITER //
CREATE PROCEDURE buildHcCountDatasets()
BEGIN

-- health_checks_cohort_count_40_74_eligible_codes_Redbridge.csv
DROP TABLE IF EXISTS hc_eligible_count_redbridge;
CREATE TABLE hc_eligible_count_redbridge AS
SELECT 
       o.ods_code,
       COUNT(o.ods_code) eligible_count
FROM tmp_health_checks_cohort_eligible e 
JOIN enterprise_pi.patient p ON p.id = e.id 
JOIN enterprise_pi.organization o ON o.id = p.organization_id 
JOIN hc_organisations o2 ON o2.ods_code = o.ods_code 
WHERE o2.ccg = 'Redbridge'  
GROUP BY o.ods_code ORDER BY o.ods_code;

-- health_checks_cohort_count_40_74_eligible_codes_Havering.csv
DROP TABLE IF EXISTS hc_eligible_count_havering;
CREATE TABLE hc_eligible_count_havering AS
SELECT 
       o.ods_code,
       COUNT(o.ods_code) eligible_count
FROM tmp_health_checks_cohort_eligible e 
JOIN enterprise_pi.patient p ON p.id = e.id 
JOIN enterprise_pi.organization o ON o.id = p.organization_id 
JOIN hc_organisations o2 ON o2.ods_code = o.ods_code 
WHERE o2.ccg = 'Havering'  
GROUP BY o.ods_code ORDER BY o.ods_code;

-- health_checks_cohort_count_40_74_eligible_codes_BarkingDagenham.csv
DROP TABLE IF EXISTS hc_eligible_count_barking;
CREATE TABLE hc_eligible_count_barking AS
SELECT 
       o.ods_code,
       COUNT(o.ods_code) eligible_count
FROM tmp_health_checks_cohort_eligible e 
JOIN enterprise_pi.patient p ON p.id = e.id 
JOIN enterprise_pi.organization o ON o.id = p.organization_id 
JOIN hc_organisations o2 ON o2.ods_code = o.ods_code 
WHERE o2.ccg = 'Barking & Dagenham'  
GROUP BY o.ods_code ORDER BY o.ods_code;


END//
DELIMITER ;

