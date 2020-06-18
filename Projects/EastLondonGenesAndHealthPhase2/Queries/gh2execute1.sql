USE data_extracts;

DROP PROCEDURE IF EXISTS gh2execute1;

DELIMITER //
CREATE PROCEDURE gh2execute1()
BEGIN
-- Demographics and Diagnoses (1)
-- 1 = latest
-- 0 = earliest

-- DemographicsDataset

CALL populateTermCodeV2(1, 'EthnicityL', 'gh2_demographicsDataset', 0, '397731000', null, null, null,'N');
CALL populateTermCodeV2(1, 'BirthCountryL', 'gh2_demographicsDataset', 0, '370159000', null, null, null,'N');

-- gh2_diagnoses1dataset

CALL populateCodeDateV2(1, 'FHDiabetesL', 'gh2_diagnoses1dataset', 0, '160303001', null, null, null,'N');
CALL populateCodeDateV2(1, 'FHIHDL', 'gh2_diagnoses1dataset', 0, '297242006', null, null, null,'N');
CALL populateCodeDateV2(1, 'FHFHL', 'gh2_diagnoses1dataset', 0, '443454007', null, null, null,'N');
CALL populateCodeDateV2(1, 'FHTXL', 'gh2_diagnoses1dataset', 0, '699108005', null, null, null,'N');
CALL populateCodeDateV2(0, 'Type1DiabetesE', 'gh2_diagnoses1dataset', 0, '46635009', null, null, null,'N');
CALL populateCodeDateV2(0, 'Type2DiabetesE', 'gh2_diagnoses1dataset', 0, '44054006', null, null, null,'N');
CALL populateCodeDateV2(0, 'SecondaryDiabetesE', 'gh2_diagnoses1dataset', 0, '8801005,105401000119101', null, null, null,'N');
CALL populateCodeDateV2(0, 'OtherDiabetesE', 'gh2_diagnoses1dataset', 0, '15771004,609569007,609568004,335621000000101,47270006,41545003,399187006,399144008,63702009,51626007,4434006,89392001,5619004,48606007', null, null, null,'N');
CALL populateCodeDateV2(0, 'DiabetesResolvedE', 'gh2_diagnoses1dataset', 0, '315051004', null, null, null,'N');
CALL populateCodeDateV2(0, 'PancreaticDiseaseE', 'gh2_diagnoses1dataset', 0, '3855007', null, null, null,'N');
CALL populateCodeDateV2(0, 'PancreaticSurgeryE', 'gh2_diagnoses1dataset', 0, '29630005,408474001', null, null, null,'N');
CALL populateCodeDateV2(0, 'DiabetesInPregnancyE', 'gh2_diagnoses1dataset', 0, '199223000,472971004', null, null, null,'N');
CALL populateCodeDateV2(0, 'HyperglycaemiaInPregnancyE', 'gh2_diagnoses1dataset', 0, '237625008', null, null, null,'N');
CALL populateCodeDateV2(1, 'DiabetesEmergenciesL', 'gh2_diagnoses1dataset', 0, '267384006,420422005,441656006,420662003', null, null, null,'N');
CALL populateCodeDateV2(0, 'BariatricSurgeryE', 'gh2_diagnoses1dataset', 0, '608848006,768551000000107,265364006,87604009,843581000000103,328701000119101,328711000119103,358575006,49245001,698450007,1060721000000106,329281000119107,107701000119101,24883002,359575000,83857006,843911000000101,49209004', null, null, null,'N');
CALL populateCodeDateV2(0, 'PrediabetesE', 'gh2_diagnoses1dataset', 0, '9414007,390951007,700449008,858301000000107,714628002,274858002,166927002', null, null, null,'N');
CALL populateCodeDateV2(1, 'PrediabetesL', 'gh2_diagnoses1dataset', 0, '9414007,390951007,700449008,858301000000107,714628002,274858002,166927002', null, null, null,'N');
CALL populateCodeDateV2(0, 'AtRiskE', 'gh2_diagnoses1dataset', 0, '161641009', null, null, null,'N');
CALL populateCodeDateV2(1, 'AtRiskL', 'gh2_diagnoses1dataset', 0, '161641009', null, null, null,'N');

-- HbA1c
-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);
-- add snomeds
CALL storeSnomedString ('999791000000106,1019431000000105', 2);  -- just the parents no children
CALL getAllSnomedsFromSnomedString (2);
-- create observations table
CALL createObservationsFromCohortV2 (1);
-- delete exclusions from the observations table
DELETE FROM observationsFromCohortV2 WHERE original_code = '999791000000106' AND (result_value < 42 OR result_value > 47.99);
DELETE FROM observationsFromCohortV2 WHERE original_code = '1019431000000105' AND (result_value < 6 OR result_value > 6.4);
-- filter out the earliest observations
CALL filterObservationsV2(0,0,'N'); 
-- update dataset columns
CALL populateCodeDateValueUnitWithObservationAlreadyPopulatedV2('HbA1cE','gh2_diagnoses1dataset', 0);
-- filter out the latest observations
CALL filterObservationsV2(1,0,'N'); 
-- update dataset columns
CALL populateCodeDateValueUnitWithObservationAlreadyPopulatedV2('HbA1cL','gh2_diagnoses1dataset', 0);

CALL populateCodeDateValueUnitV2(0, 'QDiabetesE', 'gh2_diagnoses1dataset', 0, '863501000000102', null, null, null,'N');
CALL populateCodeDateValueUnitV2(1, 'QDiabetesL', 'gh2_diagnoses1dataset', 0, '863501000000102', null, null, null,'N');

-- HighQRisk
-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);
-- add snomeds
CALL storeSnomedString ('718087004,353641000000105', 2);  -- just the parents no children
CALL getAllSnomedsFromSnomedString (2);
-- create observations table
CALL createObservationsFromCohortV2 (1);
-- delete exclusions from the observations table
DELETE FROM observationsFromCohortV2 WHERE original_code = '718087004' AND (result_value < 20);
-- filter out the earliest observations
CALL filterObservationsV2(0,0,'N'); 
-- update dataset columns
CALL populateCodeDateValueUnitWithObservationAlreadyPopulatedV2('HighQRiskE','gh2_diagnoses1dataset', 0);
-- filter out the latest observations
CALL filterObservationsV2(1,0,'N'); 
-- update dataset columns
CALL populateCodeDateValueUnitWithObservationAlreadyPopulatedV2('HighQRiskL','gh2_diagnoses1dataset', 0);

CALL populateCodeDateV2(0, 'RetinalScreenE', 'gh2_diagnoses1dataset', 0, '426880003,390735007,390856001', null, null, null,'N');
CALL populateCodeDateV2(1, 'RetinalScreenL', 'gh2_diagnoses1dataset', 0, '426880003,390735007,390856001', null, null, null,'N');
CALL populateCodeDateV2(1, 'RetinalScreenDeclinedL', 'gh2_diagnoses1dataset', 0, '408396006,413122001,201751000000104,839811000000106,413122001,374901000000103,371811000000106,294751000000103', null, null, null,'N');
CALL populateCodeDateV2(0, 'RetinopathyIncludeMaculopathyE', 'gh2_diagnoses1dataset', 0, '4855003,373041000000101', null, null, null,'N');
CALL populateCodeDateV2(1, 'RetinopathyIncludeMaculopathyL', 'gh2_diagnoses1dataset', 0, '4855003,373041000000101', null, null, null,'N');
CALL populateCodeDateV2(0, 'RetinopathyExcludeMaculopathyE', 'gh2_diagnoses1dataset', 0, '4855003,373041000000101', null, '232020009', null,'N');
CALL populateCodeDateV2(1, 'RetinopathyExcludeMaculopathyL', 'gh2_diagnoses1dataset', 0, '4855003,373041000000101', null, '232020009', null,'N');
CALL populateCodeDateV2(0, 'MaculopathyE', 'gh2_diagnoses1dataset', 0, '312999006', null, null, null,'N');
CALL populateCodeDateV2(1, 'MaculopathyL', 'gh2_diagnoses1dataset', 0, '312999006', null, null, null,'N');
CALL populateCodeDateV2(0, 'DiabeticMaculopathyE', 'gh2_diagnoses1dataset', 0, '232020009', null, null, null,'N');
CALL populateCodeDateV2(1, 'DiabeticMaculopathyL', 'gh2_diagnoses1dataset', 0, '232020009', null, null, null,'N');
CALL populateCodeDateV2(0, 'ErectileDysfunctionE', 'gh2_diagnoses1dataset', 0, '397803000,275553005,366290004,473327001,851081000000105', null, '300525002', null,'N');
CALL populateCodeDateV2(0, 'PVDALLVesselsE', 'gh2_diagnoses1dataset', 0, '400047006', null, null, null,'N');
CALL populateCodeDateV2(0, 'PVDVeinsE', 'gh2_diagnoses1dataset', 0, '400047006', null, '473449006', null,'N');
CALL populateCodeDateV2(0, 'PVDArteriesNoncoronaryE', 'gh2_diagnoses1dataset', 0, '473449006', null, null, null,'N');
CALL populateCodeDateV2(0, 'AbdominalAorticAneurysmE', 'gh2_diagnoses1dataset', 0, '233985008,405525004,307701005,175301002,175300001,21574003,982021000000101,982121000000102,982141000000109', null, null, null,'N');
CALL populateCodeDateV2(0, 'FootUlcerE', 'gh2_diagnoses1dataset', 0, '95345008,238796009', null, null, null,'N');
CALL populateCodeDateV2(0, 'DiabeticFootUlcerE', 'gh2_diagnoses1dataset', 0, '371087003,394674001,394673007', null, null, null,'N');
CALL populateCodeDateV2(0, 'NeuropathyE', 'gh2_diagnoses1dataset', 0, '302226006', null, null, null,'N');
CALL populateCodeDateV2(0, 'DiabeticPeripheralNeuropathyE', 'gh2_diagnoses1dataset', 0, '230572002', null, '50620007, 770095003, 35777006', null,'N');

-- gh2_diagnoses1adataset

CALL populateCodeDateV2(0, 'CoronaryArteryDiseaseE', 'gh2_diagnoses1adataset', 0, '53741008,67682002,398274000,233970002,414545008,63739005', null, '703356002', null,'N');
CALL populateCodeDateV2(1, 'CoronaryArteryDiseaseL', 'gh2_diagnoses1adataset', 0, '53741008,67682002,398274000,233970002,414545008,63739005', null, '703356002', null,'N');
CALL populateCodeDateV2(0, 'AnginaE', 'gh2_diagnoses1adataset', 0, '194828000', '4557003', null, null,'N');  -- added 4557003
CALL populateCodeDateV2(0, 'MyocardialInfarctionE', 'gh2_diagnoses1adataset', 0, '22298006,399211009', null, null, null,'N');
CALL populateCodeDateV2(0, 'CoronaryAngioplastyE', 'gh2_diagnoses1adataset', 0, '41339005', null, null, null,'N');
CALL populateCodeDateV2(0, 'CABGE', 'gh2_diagnoses1adataset', 0, '232717009,399261000', null, null, null,'N');                     
CALL populateCodeDateV2(0, 'AtrialFibrillationE', 'gh2_diagnoses1adataset', 0, '49436004', null, null, null,'N');    -- replaced 232717009                            
CALL populateCodeDateV2(1, 'AtrialFibrillationResolvedL', 'gh2_diagnoses1adataset', 0, '196371000000102', null, null, null,'N');                           
CALL populateCodeDateV2(0, 'AtrialFlutterE', 'gh2_diagnoses1adataset', 0, '5370000', null, null, null,'N');   
CALL populateCodeDateV2(0, 'HeartFailureE', 'gh2_diagnoses1adataset', 0, '84114007,421518007,407596008,407597004,3545003,371037005', null, null, null,'N');                                              
CALL populateCodeDateV2(0, 'TIAE', 'gh2_diagnoses1adataset', 0, '266257000,161511000', null, null, null,'N');   
CALL populateCodeDateV2(0, 'StrokeE', 'gh2_diagnoses1adataset', 0, '230690007,432504007,75543006,287731003,95456009,71444005,48601002,15978471000119109,15978431000119106,95458005,95459002,390936003,703219008,20059004,275526006', null, null, null,'N');                                                                    
CALL populateCodeDateV2(0, 'HypertensionE', 'gh2_diagnoses1adataset', 0, '38341003', null, null, null,'N');   
CALL populateCodeDateV2(0, 'EssentialHypertensionE', 'gh2_diagnoses1adataset', 0, '38341003', null, '71701000119105,71421000119105,198941007,367390009,118781000119108,48194001,31992008', null,'N');                               
CALL populateCodeDateV2(0, 'SecondaryHypertensionE', 'gh2_diagnoses1adataset', 0, '71701000119105,71421000119105,198941007,367390009,118781000119108,48194001,31992008', null, null, null,'N');     
CALL populateCodeDateV2(0, 'ResistantHypertensionE', 'gh2_diagnoses1adataset', 0, '845891000000103', null, null, null,'N');                    
CALL populateCodeDateV2(1, 'HypertensionResolvedL', 'gh2_diagnoses1adataset', 0, '162659009', null, null, null,'N');                       
CALL populateCodeDateV2(0, 'ChronicKidneyDiseaseE', 'gh2_diagnoses1adataset', 0, '709044004', null, null, null,'N');                         
CALL populateCodeDateV2(1, 'ChronicKidneyDiseaseL', 'gh2_diagnoses1adataset', 0, '709044004', null, null, null,'N');                   
CALL populateCodeDateV2(0, 'DialysisE', 'gh2_diagnoses1adataset', 0, '105502003,265763003', null, null, null,'N');    
CALL populateCodeDateV2(1, 'DialysisL', 'gh2_diagnoses1adataset', 0, '105502003,265763003', null, null, null,'N');                     
CALL populateCodeDateV2(0, 'RenalTransplantationE', 'gh2_diagnoses1adataset', 0, '175902000,70536003,313030004', null, null, null,'N');  
CALL populateCodeDateV2(1, 'RenalTransplantationL', 'gh2_diagnoses1adataset', 0, '175902000,70536003,313030004', null, null, null,'N');  
CALL populateCodeDateV2(0, 'RenalTransplantRejectionE', 'gh2_diagnoses1adataset', 0, '236570004,236583003', null, null, null,'N');                      
CALL populateCodeDateV2(1, 'RenalTransplantRejectionL', 'gh2_diagnoses1adataset', 0, '236570004,236583003', null, null, null,'N');  
CALL populateCodeDateV2(0, 'PolycysticOvarianSyndromeE', 'gh2_diagnoses1adataset', 0, '69878008', null, null, null,'N');  
CALL populateCodeDateV2(0, 'SleepDisorderedBreathingE', 'gh2_diagnoses1adataset', 0, '111489007', null, null, null,'N');                  
CALL populateCodeDateV2(0, 'ObesityRelatedBreathingDisordersE', 'gh2_diagnoses1adataset', 0, '78275009,190966007', null, null, null,'N');         
CALL populateCodeDateV2(0, 'NAFLDE', 'gh2_diagnoses1adataset', 0, '197315008,442191002', null, null, null,'N');             
CALL populateCodeDateV2(0, 'FamilialHypercholesterolaemiaE', 'gh2_diagnoses1adataset', 0, '398036000', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'AcanthosisNigricansE', 'gh2_diagnoses1adataset', 0, '72129000,238634000,402599005', null, null, null,'N');    
CALL populateCodeDateV2(0, 'HyperthyroidismE', 'gh2_diagnoses1adataset', 0, '34486009', null, null, null,'N');    
CALL populateCodeDateV2(1, 'HyperthyroidismL', 'gh2_diagnoses1adataset', 0, '34486009', null, null, null,'N');                           
CALL populateCodeDateV2(0, 'GravesDiseaseE', 'gh2_diagnoses1adataset', 0, '353295004', null, null, null,'N');   
CALL populateCodeDateV2(0, 'ToxicMultinodularGoitreE', 'gh2_diagnoses1adataset', 0, '26389007', null, null, null,'N');                        
CALL populateCodeDateV2(0, 'ToxicThyroidAdenomaE', 'gh2_diagnoses1adataset', 0, '449097000', null, null, null,'N');                 
CALL populateCodeDateV2(0, 'HypothyroidismE', 'gh2_diagnoses1adataset', 0, '40930008', null, null, null,'N');  
CALL populateCodeDateV2(1, 'HypothyroidismL', 'gh2_diagnoses1adataset', 0, '40930008', null, null, null,'N');                        
CALL populateCodeDateV2(0, 'PrimaryHypothroidismExcSecSubE', 'gh2_diagnoses1adataset', 0, '40930008', null, '82598004,54823002,428165003', null,'N');                            
CALL populateCodeDateV2(0, 'AutoimmuneHypothyroidismE', 'gh2_diagnoses1adataset', 0, '237519003,66944004', null, null, null,'N');             
CALL populateCodeDateV2(0, 'HashimotosThyroiditisE', 'gh2_diagnoses1adataset', 0, '21983002', null, null, null,'N');                      
CALL populateCodeDateV2(0, 'CoeliacDiseaseE', 'gh2_diagnoses1adataset', 0, '396331005', null, null, null,'N');                        
CALL populateCodeDateV2(0, 'VitiligoE', 'gh2_diagnoses1adataset', 0, '56727007', null, null, null,'N');                             
CALL populateCodeDateV2(1, 'FrailtyIndexL', 'gh2_diagnoses1adataset', 0, '713634000,925791000000100,925831000000107,925861000000102,404904002', null, null, null,'N');                                   
CALL populateCodeDateV2(1, 'NHSHealthCheckL', 'gh2_diagnoses1adataset', 0, '523221000000100', null, null, null,'N');                               
CALL populateCodeDateV2(0, 'MetforminAdverseReactionE', 'gh2_diagnoses1adataset', 0, '293203005', null, null, null,'N');                             
CALL populateCodeDateV2(0, 'StatinAdverseReactionsDisorderE', 'gh2_diagnoses1adataset', 0, '293432006', null, null, null,'N');    
CALL populateCodeDateV2(0, 'StatinAdverseReactionsSituationE', 'gh2_diagnoses1adataset', 0, '413174003', null, null, null,'N');  
CALL populateCodeDateV2(0, 'StatinMuscleSymptomsDisorderE', 'gh2_diagnoses1adataset', 0, '240131006', null, null, null,'N');     
CALL populateCodeDateV2(0, 'StatinMuscleSymptomsFindingE', 'gh2_diagnoses1adataset', 0, '68962001', null, null, null,'N'); 

-- gh2_demographicsDataset

-- add age and LSOA2011

DROP TEMPORARY TABLE IF EXISTS qry_age;

CREATE TEMPORARY TABLE qry_age (
       row_id       INT,
       group_by     VARCHAR(255),
       age_years    INT,
       lsoa_code    VARCHAR(50), PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       c.group_by,
       p.age_years,
       p.lsoa_code
FROM enterprise_pseudo.patient p JOIN cohort_gh2 c ON p.pseudo_id = c.group_by, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_age WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

         UPDATE gh2_demographicsDataset d JOIN qry_age q ON d.pseudo_id = q.group_by
         SET d.Age = q.age_years,
             d.LSOA2011 = q.lsoa_code
         WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;  

         SET @row_id = @row_id + 1000;

END WHILE;

-- add IMD2010

DROP TEMPORARY TABLE IF EXISTS qry_imd;

CREATE TEMPORARY TABLE qry_imd (
       row_id     INT,
       pseudo_id  VARCHAR(255),
       IMD2010    DECIMAL(5,3), PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       d.pseudo_id,
       lso.imd_score
FROM  gh2_demographicsDataset d JOIN enterprise_pseudo.lsoa_lookup lso ON d.LSOA2011 = lso.lsoa_code, (SELECT @row_no := 0) t 
WHERE d.lsoa2011 IS NOT NULL;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_imd WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

         UPDATE gh2_demographicsDataset d JOIN qry_imd i ON d.pseudo_id = i.pseudo_id
         SET d.IMD2010 = i.imd_score WHERE i.row_id > @row_id AND i.row_id <= @row_id + 1000;  

         SET @row_id = @row_id + 1000;

END WHILE;

-- add RegistrationStart, RegistrationEnd, PracticeODSCode, PracticeODSName

DROP TEMPORARY TABLE IF EXISTS reg_sort;
DROP TEMPORARY TABLE IF EXISTS qry_reg;

CREATE TEMPORARY TABLE qry_reg AS
SELECT c.group_by,
       c.person_id,
       e.date_registered,
       e.date_registered_end,
       o.name,
       o.ods_code,
       g.parent
FROM cohort_gh2 c 
  JOIN enterprise_pseudo.episode_of_care e ON e.person_id = c.person_id 
  JOIN enterprise_pseudo.organization o ON o.id = e.organization_id 
  JOIN gh2ccg_codes g ON g.local_id = o.ods_code;

CREATE TEMPORARY TABLE reg_sort (
       row_id               INT,
       group_by             VARCHAR(255),
       person_id            BIGINT,
       date_registered      DATE,
       date_regiostered_end DATE,
       ode_code             VARCHAR(50),
       name                 VARCHAR(255),
       parent               VARCHAR(100),
       rnk                  INT, PRIMARY KEY(row_id)) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       a.group_by,
       a.person_id,
       a.date_registered,
       a.date_registered_end,
       a.ods_code,       
       a.name,
       a.parent,
       a.rnk
FROM (SELECT q.group_by, 
             q.person_id, 
             q.date_registered, 
             q.date_registered_end, 
             q.name, 
             q.ods_code,
             q.parent,
             @currank := IF(@curperson = q.person_id, @currank + 1, 1) AS rnk,
             @curperson := q.person_id AS cur_person
      FROM qry_reg q, (SELECT @currank := 0, @curperson := 0) r 
      ORDER BY q.person_id, q.date_registered DESC ) a, (SELECT @row_no := 0) t
WHERE a.rnk = 1; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from reg_sort WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE gh2_demographicsDataset d JOIN reg_sort reg ON d.pseudo_id = reg.group_by
        SET d.RegistrationStart = reg.date_registered,
            d.RegistrationEnd = reg.date_registered_end,
            d.PracticeODSCode = reg.ods_code,
            d.PracticeODSName = reg.name,
            d.CCGName = reg.parent
        WHERE reg.row_id > @row_id AND reg.row_id <= @row_id + 1000;  

        SET @row_id = @row_id + 1000;
        
END WHILE;

-- total no of f2f visits

DROP TEMPORARY TABLE IF EXISTS  noVisitsTotal;

CREATE TEMPORARY TABLE noVisitsTotal (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM (SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
      FROM cohort_gh2_encounter_raw e JOIN cohort_gh2 cr ON e.person_id = cr.person_id 
      WHERE EXISTS (SELECT 'x' FROM gh2_f2fEncounters s WHERE s.term = e.fhir_original_term) 
      AND e.clinical_effective_date IS NOT NULL
      AND e.fhir_original_term IS NOT NULL   
      GROUP BY cr.group_by) b, (SELECT @row_no := 0) t; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from noVisitsTotal WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE gh2_demographicsDataset d JOIN noVisitsTotal nvt ON d.pseudo_id = nvt.group_by
        SET d.F2fVisits_Total = nvt.visits WHERE nvt.row_id > @row_id AND nvt.row_id <= @row_id + 1000;  

        SET @row_id = @row_id + 1000;
        
END WHILE;

-- last 1 yr f2f visits

DROP TEMPORARY TABLE IF EXISTS lastyearvisits;

CREATE TEMPORARY TABLE lastyearvisits (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM (SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
      FROM cohort_gh2_encounter_raw e JOIN cohort_gh2 cr ON e.person_id = cr.person_id 
      WHERE EXISTS (SELECT 'x' FROM gh2_f2fEncounters s WHERE s.term = e.fhir_original_term) 
      AND e.clinical_effective_date > DATE_SUB(now(), INTERVAL 12 MONTH)  -- last 1 yr
      AND e.clinical_effective_date IS NOT NULL
      AND e.fhir_original_term IS NOT NULL   
      GROUP BY cr.group_by) b, (SELECT @row_no := 0) t;  

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from lastyearvisits WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE gh2_demographicsDataset d JOIN lastyearvisits lyr ON d.pseudo_id = lyr.group_by 
        SET d.F2fVisits_1year = lyr.visits WHERE lyr.row_id > @row_id AND lyr.row_id <= @row_id + 1000;
        
        SET @row_id = @row_id + 1000;
        
END WHILE;

-- last 5 yrs f2f visits

DROP TEMPORARY TABLE IF EXISTS lastfiveyearvisits;

CREATE TEMPORARY TABLE lastfiveyearvisits (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM ( SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
       FROM cohort_gh2_encounter_raw e JOIN cohort_gh2 cr ON e.person_id = cr.person_id 
       WHERE EXISTS (SELECT 'x' FROM gh2_f2fEncounters s WHERE s.term = e.fhir_original_term)
       AND e.clinical_effective_date > DATE_SUB(now(), INTERVAL 60 MONTH)  -- last 5 yrs
       AND e.clinical_effective_date IS NOT NULL
       AND e.fhir_original_term IS NOT NULL   
       GROUP BY cr.group_by) b, (SELECT @row_no := 0) t; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from lastfiveyearvisits WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE gh2_demographicsDataset d JOIN lastfiveyearvisits lfyr ON d.pseudo_id = lfyr.group_by 
        SET d.F2fVisits_5years = lfyr.visits WHERE lfyr.row_id > @row_id AND lfyr.row_id <= @row_id + 1000; 
        
        SET @row_id = @row_id + 1000;
        
END WHILE;


END //
DELIMITER ;

