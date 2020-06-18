USE data_extracts;

-- ahui 8/2/2020

DROP PROCEDURE IF EXISTS gh2execute5;

DELIMITER //
CREATE PROCEDURE gh2execute5()
BEGIN

-- Measurements

-- 1 = latest
-- 0 = earliest
-- 3 = +/- 6 month window


-- Age in years
-- UPDATE cohort_gh2 d 
-- JOIN enterprise_pseudo.patient p ON d.group_by = p.pseudo_id 
-- SET d.age_years = p.age_years;

CALL populateTermCodeDateV2(1, 'SmokingStatusL', 'gh2_measuresdataset', 0, '365980008', null, null, null,'Y'); 

CALL populateCodeTermDateValueUnitAgeV2(0, 'WeightE', 'gh2_measuresdataset', 0, '27113001,162763007', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(1, 'WeightL', 'gh2_measuresdataset', 0, '27113001,162763007', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(3, 'Weight6', 'gh2_measuresdataset', 0, '27113001,162763007', null, null, null,'Y'); 

CALL populateCodeTermDateValueUnitAgeV2(0, 'HeightE', 'gh2_measuresdataset', 0, '50373000,162755006', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(1, 'HeightL', 'gh2_measuresdataset', 0, '50373000,162755006', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(3, 'Height6', 'gh2_measuresdataset', 0, '50373000,162755006', null, null, null,'Y'); 

CALL populateCodeTermDateValueUnitAgeV2(0, 'BMIE', 'gh2_measuresdataset', 0, '301331008,60621009', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(1, 'BMIL', 'gh2_measuresdataset', 0, '301331008,60621009', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(3, 'BMI6', 'gh2_measuresdataset', 0, '301331008,60621009', null, null, null,'Y'); 

CALL populateCodeTermDateValueUnitAgeV2(0, 'SystolicBloodPressureE', 'gh2_measuresdataset', 0, '271649006', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(1, 'SystolicBloodPressureL', 'gh2_measuresdataset', 0, '271649006', null, null, null,'Y');

CALL populateCodeTermDateValueUnitAgeV2(0, 'DiastolicBloodPressureE', 'gh2_measuresdataset', 0, '271650006', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitAgeV2(1, 'DiastolicBloodPressureL', 'gh2_measuresdataset', 0, '271650006', null, null, null,'Y');


END //
DELIMITER ;
