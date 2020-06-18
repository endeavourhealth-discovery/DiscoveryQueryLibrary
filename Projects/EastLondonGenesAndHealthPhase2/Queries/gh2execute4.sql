USE data_extracts;

-- ahui 7/2/2020

DROP PROCEDURE IF EXISTS gh2execute4;

DELIMITER //
CREATE PROCEDURE gh2execute4()
BEGIN

-- Lab Results
-- 1 = latest
-- 0 = earliest
-- 3 = +/- 6 month window

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4,'Y');
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);
-- add snomeds
CALL storeSnomedString ('46635009,44054006,8801005,105401000119101,15771004,609569007,609568004,335621000000101,47270006,41545003,399187006,399144008,63702009,51626007,4434006,89392001,5619004,48606007,199223000,472971004', 1);  -- get all diabetes related codes
CALL getAllSnomedsFromSnomedString (1);
-- get the earliest diabetes code
CALL filterObservationsV2(0,1,'N');  
-- update the pivot date to be used to calculate the 6 month window around the EARLIEST diabetes code
UPDATE cohort_gh2 c JOIN filteredObservationsV2 f ON f.group_by = c.group_by SET c.pivot_date = f.clinical_effective_date;

CALL populateCodeTermDateValueUnitV2(0, 'HbA1cE', 'gh2_labdataset', 0, '1003671000000109,443911005', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'HbA1cL', 'gh2_labdataset', 0, '1003671000000109,443911005', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(3, 'HbA1c6', 'gh2_labdataset', 0, '1003671000000109,443911005', null, null, null,'Y');  -- latest from 6 month window

CALL populateCodeTermDateValueUnitV2(0, 'TotalCholesterolE', 'gh2_labdataset', 0, '1005671000000105,850981000000101', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(1, 'TotalCholesterolL', 'gh2_labdataset', 0, '1005671000000105,850981000000101', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(3, 'TotalCholesterol6', 'gh2_labdataset', 0, '1005671000000105,850981000000101', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(0, 'HDLCholesterolE', 'gh2_labdataset', 0, '1005681000000107,1010581000000101', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'HDLCholesterolL', 'gh2_labdataset', 0, '1005681000000107,1010581000000101', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(3, 'HDLCholesterol6', 'gh2_labdataset', 0, '1005681000000107,1010581000000101', null, null, null,'Y');  

CALL populateCodeTermDateValueUnitV2(0, 'SerumLDLCholesterolE', 'gh2_labdataset', 0, '1022191000000100,1010591000000104,1014501000000104', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'SerumLDLCholesterolL', 'gh2_labdataset', 0, '1022191000000100,1010591000000104,1014501000000104', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(3, 'SerumLDLCholesterol6', 'gh2_labdataset', 0, '1022191000000100,1010591000000104,1014501000000104', null, null, null,'Y');  

CALL populateCodeTermDateValueUnitV2(0, 'SerumTriglyceridesE', 'gh2_labdataset', 0, '850991000000104,1005691000000109,1010601000000105,1026501000000104,1028871000000108,1026491000000105,1031321000000109', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'SerumTriglyceridesL', 'gh2_labdataset', 0, '850991000000104,1005691000000109,1010601000000105,1026501000000104,1028871000000108,1026491000000105,1031321000000109', null, null, null,'Y');
CALL populateCodeTermDateValueUnitV2(3, 'SerumTriglycerides6', 'gh2_labdataset', 0, '850991000000104,1005691000000109,1010601000000105,1026501000000104,1028871000000108,1026491000000105,1031321000000109', null, null, null,'Y');  

CALL populateCodeTermDateValueUnitV2(0, 'UrineProteinCreatinineRatioE', 'gh2_labdataset', 0, '1028731000000100', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'UrineProteinCreatinineRatioL', 'gh2_labdataset', 0, '1028731000000100', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(0, 'UrineAlbuminCreatinineRatioE', 'gh2_labdataset', 0, '1023491000000104', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'UrineAlbuminCreatinineRatioL', 'gh2_labdataset', 0, '1023491000000104', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(0, 'UrineAlbuminE', 'gh2_labdataset', 0, '1003301000000109', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'UrineAlbuminL', 'gh2_labdataset', 0, '1003301000000109', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(0, 'SerumCreatinineE', 'gh2_labdataset', 0, '1000731000000107,1001011000000107', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'SerumCreatinineL', 'gh2_labdataset', 0, '1000731000000107,1001011000000107', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(0, 'eGFRE', 'gh2_labdataset', 0, '80274001', null, null, null,'Y'); 
CALL populateCodeTermDateValueUnitV2(1, 'eGFRL', 'gh2_labdataset', 0, '80274001', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'GADL', 'gh2_labdataset', 0, '1007741000000102', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'IsletCellAntibodyLevelL', 'gh2_labdataset', 0, '1016671000000104', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'IA2L', 'gh2_labdataset', 0, '1006331000000108', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'CoeliacAutoantibodyProfileL', 'gh2_labdataset', 0, '440109001,443718009', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'AntiThyroidPeroxidaseL', 'gh2_labdataset', 0, '1030111000000108', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'CpeptideL', 'gh2_labdataset', 0, '999351000000102', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'SerumInsulinL', 'gh2_labdataset', 0, '997211000000103,995451000000106', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'SerumALTAlanineAminotransferaseLevelL', 'gh2_labdataset', 0, '1018251000000107,1013211000000103', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'ASTSerumLevelL', 'gh2_labdataset', 0, '1031101000000102,1000881000000102', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'T4L', 'gh2_labdataset', 0, '1030801000000101', null, null, null,'Y');

CALL populateCodeTermDateValueUnitV2(1, 'TSHL', 'gh2_labdataset', 0, '1027151000000105', null, null, null,'Y');

END //
DELIMITER ;

