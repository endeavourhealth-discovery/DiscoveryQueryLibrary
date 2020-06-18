use data_extracts;

-- Ethnicity
call populateTerm(1, 'ethnicity', 'dataset1', 0, '9S%, 9i%,', null);

-- Country of birth
call populateTermCode(1, 'BirthCountry', 'dataset1', 0, '13d%, 13e%, 13f%, 13g%, 13h%, 13j%, 13k%, 13Zq,', null);

-- 	ELGH Family History of diabetes
call populateCodeDate(1, 'FHDiabetes', 'dataset1', 0, '1253, 1252, ZV18%, ZX198,', null);

-- ELGH Family History of ICD
call populateCodeDate(1, 'FHIHD', 'dataset1', 0 ,'12C2, 12CM, 12CV, 12CW, 12CL, 12CN, 12CP,', null);

-- ELGH Type 1 Diabetes
call populateCodeDate(0, 'T1Diabetes', 'dataset1', 0, 'C10E% , C10ER,', '21263, 212H,');

-- ELGH Type 2 diabetes
call populateCodeDate(0, 'T2Diabetes', 'dataset1', 0, 'C10F%, C109J,', 'C10F8, 21263, 212H,');

-- ELGH secondary diabetes
call populateCodeDate(0, 'Secondary', 'dataset1', 0, 'C10H%, C10B, C10N%, C10G%, C11y0,', null);

-- ELGH other diabetes
call populateCodeDate(0, 'Other', 'dataset1', 0, 'C10A, C10C, C10D, C1A%, C10M%, C326%, A3A2, C135, PKyP, Q441, C10FS, C150%, C3500, C10N1, C10K%, C10J%, C108y, C108z, PKyF, C1zy4, PH3yA, PKy93, PKy1,', null);

--	ELGH pancreatic disease
call populateCodeDate(0, 'Pancreatic', 'dataset1', 0, 'J670%, J671%, J6710, J6711, J67y6, 9b8G,', null);

-- 	ELGH Diabeties in pregnancy
call populateCodeDate(0, 'Pregnancy', 'dataset1', 0, 'L1808, L1809, L1800, L1801, L1802, L1803, L1804, L180z, ZV13F,', null);

-- 	ELGH Diabetes emergencies
call populateCodeDate(1, 'Emergencies', 'dataset1', 0, 'C10EM, C109K, C10EE%, C10EN%, C10FK%, C10FN%, C10FP%,', null);

-- 	ELGH Bariatric surgery
call populateCodeDate(0, 'Bariatric', 'dataset1', 0, '7611%, 7613%, 76140, 76141, 7614y, 7614z, 76150, 761H0, 761H5, 76160, 76166, 7633%, 76425, ZV453, ZV45P,', '76117, 76118, 76119,');

-- 	ELGH Prediabetes diabetes risk 1
call populateCodeDate(1, 'PrediabetesLatest', 'dataset1', 0, 'C11y2, C11y3, C11y5, R10E, R10D0, R102,', null);
call populateCodeDate(0, 'PrediabetesEarliest', 'dataset1', 0, 'C11y2, C11y3, C11y5, R10E, R10D0, R102,', null);

-- 	ELGH  diabetes risk 2
call populateCodeDate(1, 'AtRiskLatest', 'dataset1', 0, '14O8, 14O80,', null);
call populateCodeDate(0, 'AtRiskEarliest', 'dataset1', 0, '14O8, 14O80,', null);

-- 	ELGH HbA1c diabetes risk 3
    call addCodesToCodesetFinal(201, '42W5, 42W4,');
    -- LATEST
    call createObservationsFromCohort( 201, 1, null, 1 );
    delete from observationsFromCohort where original_code = '42W5.' and (result_value < 42 or result_value > 47.99);
    delete from observationsFromCohort where original_code = '42W4.' and (result_value < 6 or result_value > 6.4);
    -- Now apply filter
    call filterWithObservationsAlreadyPopulated( 1 );
    -- Populate Code Date
    call populateCodeDateValueUnitWithObservationAlreadyPopulated('HbA1cLatest', 'dataset1', 1);

    -- EARLIEST
    call createObservationsFromCohort( 201, 0, null, 1 );
    delete from observationsFromCohort where original_code = '42W5.' and (result_value < 42 or result_value > 47.99);
    delete from observationsFromCohort where original_code = '42W4.' and (result_value < 6 or result_value > 6.4);
    -- Now apply filter
    call filterWithObservationsAlreadyPopulated( 0 );
    -- Populate Code Date
    call populateCodeDateValueUnitWithObservationAlreadyPopulated('HbA1cEarliest', 'dataset1', 1);

-- 	ELGH QDiabetes risk 4
call populateCodeDateValueUnit(1, 'QDiabetesLatest', 'dataset1', 0, '38Gj,', 0, null);
call populateCodeDateValueUnit(0, 'QDiabetesEarliest', 'dataset1', 0, '38Gj,', 0, null);

-- 	ELGH cvd risk
call addCodesToCodesetFinal(201, '38DP, 38DF, EMISNQQR1, EMISNQQR2,');
  -- LATEST
  call createObservationsFromCohort( 201, 1, null, 1 );
  delete from observationsFromCohort where result_value < 20;
  -- Now apply filter
  call filterWithObservationsAlreadyPopulated( 1 );
  -- Populate Code Date
  call populateCodeDateValueUnitWithObservationAlreadyPopulated('QRiskLatest', 'dataset1', 1);
  -- EARLIEST
  call createObservationsFromCohort( 201, 0, null, 1 );
  delete from observationsFromCohort where result_value < 20;
  -- Now apply filter
  call filterWithObservationsAlreadyPopulated( 0 );
  -- Populate Code Date
  call populateCodeDateValueUnitWithObservationAlreadyPopulated('QRiskEarliest', 'dataset1', 1);

-- 	ELGH Retinopathy Screen
call populateCodeDate(1, 'RetinopathyScreen', 'dataset1', 0, '2BB, 68A8, 9N1v, 9N2f, 8I6F, 8I3X,', null);

-- Retinal disease status (either eye)
call populateCodeDate(1, 'RetinalDiseaseStatusEitherEyeLatest', 'dataset1', 0, '2BBP, 2BBR, 2BBT, EMISQRI13, 2BBk, EMISQLE13, 2BBQ, 2BBS, 2BBV, 2BBl, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBK,2BBJ,', null);
call populateCodeDate(0, 'RetinalDiseaseStatusEitherEyeEarliest', 'dataset1', 0, '2BBP, 2BBR, 2BBT, EMISQRI13, 2BBk, EMISQLE13, 2BBQ, 2BBS, 2BBV, 2BBl, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBK,2BBJ,', null);

-- Retinal disease status (left eye)
call populateCodeDate(1, 'RetinalDiseaseStatusLeftEyeLatest', 'dataset1', 0, 'EMISQLE13, 2BBQ, 2BBS, 2BBV, 2BBl, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBK,', null);
call populateCodeDate(0, 'RetinalDiseaseStatusLeftEyeEarliest', 'dataset1', 0, 'EMISQLE13, 2BBQ, 2BBS, 2BBV, 2BBl, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBK,', null);

-- Retinal disease status (right eye)
call populateCodeDate(1, 'RetinalDiseaseStatusRightEyeLatest', 'dataset1', 0, '2BBP, 2BBR, 2BBT, EMISQRI13, 2BBk, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBJ,', null);
call populateCodeDate(0, 'RetinalDiseaseStatusRightEyeEarliest', 'dataset1', 0, '2BBP, 2BBR, 2BBT, EMISQRI13, 2BBk, F420%, 2BBo, 2BBa, 2BBY, C1087%, C1096%, C10E7%, C10F6%, 2BBI, 2BBJ,', null);

-- Maculopathy status (either eye)
call populateCodeDate(1, 'MaculopathyStatusEitherEyeLatest', 'dataset1', 0,   '2BBW, 2BBX, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBj, 2BBi, 2BBM,', null);
call populateCodeDate(0, 'MaculopathyStatusEitherEyeEarliest', 'dataset1', 0, '2BBW, 2BBX, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBj, 2BBi, 2BBM,', null);

-- Maculopathy status (left eye)
call populateCodeDate(1, 'MaculopathyStatusLeftEyeLatest', 'dataset1', 0, '2BBX, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBj, 2BBM,', null);
call populateCodeDate(0, 'MaculopathyStatusLeftEyeEarliest', 'dataset1', 0, '2BBX, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBj, 2BBM,', null);

-- Maculopathy status (right eye)
call populateCodeDate(1, 'MaculopathyStatusRightEyeLatest', 'dataset1', 0, '2BBW, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBi, 2BBM,', null);
call populateCodeDate(0, 'MaculopathyStatusRightEyeEarliest', 'dataset1', 0, '2BBW, 2BBL, F4203, F4204, F4259, C10EP%, C10FQ%, 2BBi, 2BBM,', null);

-- ELGH ED
call populateCodeDate(0, 'ED', 'dataset1', 0, '1598, 1ABB , 1ABC, 1D1B, 7C25E, E2273,', '1598-1,');

-- ELGH PVD
call populateCodeDate(0, 'PVD', 'dataset1', 0, 'G73%, Gyu74,', 'G73z1,');

-- ELGH Abdominal aortic aneurysm AAA
call populateCodeDate(0, 'AAA', 'dataset1', 0, 'G71%,', null);

-- 	ELGH Foot Ulcer Left
call populateCodeDate(0, 'FootUlcerLeft', 'dataset1', 0, '2G5L, 2G55, 2G5W, M271%,', null);

-- 	ELGH Foot Ulcer Right
call populateCodeDate(0, 'FootUlcerRight', 'dataset1', 0, '2G5H, 2G54, 2G5V, M271%,', null);

-- 	ELGH Neuropathy
call populateCodeDate(0, 'Neuropathy', 'dataset1', 0, 'C106, F367, F3y0,', null);

-- 	ELGH Ischaemic Heart Disease\CHD [QOF] IHD
call populateCodeDate(1, 'IHDLatest', 'dataset1', 0, 'G3, G30%, G31%, G32%, G33%, G34%, G35%, G38%, G39%, G3y%, G3z, Gyu3%,', 'G30A, G310, G331, G332, G341, G36%, G37, Gyu31,');
call populateCodeDate(0, 'IHDEarliest', 'dataset1', 0, 'G3, G30%, G31%, G32%, G33%, G34%, G35%, G38%, G39%, G3y%, G3z, Gyu3%,', 'G30A, G310, G331, G332, G341, G36%, G37, Gyu31,');

-- ELGH Angina
call populateCodeDate(0, 'Angina', 'dataset1', 0, 'G3111, G3112, G3113, G3114, G33%,', 'G331, G332,');

-- ELGH Myocardial Infarction
call populateCodeDate(0, 'MI', 'dataset1', 0, 'G32%, G30%, G35%, G38%,', 'G30A,');

-- 	ELGH Atrial fibriallation & flutter
call populateCodeDate(0, 'AFFlutter', 'dataset1', 0, 'G573%,', '212R,');

-- ELGH HD
call populateCodeDate(0, 'HD', 'dataset1', 0, 'G58%, G1yz1, 662f, 662g, 662h,662i, I50%,', null);

-- ELGH TIA
call populateCodeDate(0, 'TIA', 'dataset1', 0, 'G65%,', 'G655,');

-- ELGH Stroke
call populateCodeDate(0, 'Stroke', 'dataset1', 0, 'G60%, G61%, G62%, G63%, G64%, G66%, G63y0, G63y1, G6760, G6W, G6X, Gyu60, Gyu61, Gyu62, Gyu63, Gyu64, Gyu65,Gyu66, Gyu6F, Gyu6G, ZV12D, Fyu55, G65%,', 'G617, G669 , G655,');

-- ELGh Stroke (haemorrhagic)
call populateCodeDate(0, 'StrokeHaemorrhagic', 'dataset1', 0, 'G60%, G61%, G62%, Gyu60, Gyu61, Gyu6F,', 'G617,');

-- ELGh Stroke (ischaemic)
call populateCodeDate(0, 'StrokeIschaemic', 'dataset1', 0, 'G63%, G64%, G66%, G6760, G6W, G6X, Gyu63, Gyu6G, Gyu64, Gyu65, Gyu66,', 'G65%, G67%, G68%, G669, G6y, G6z,');

-- ELGH Hypertension
call populateCodeDate(0, 'Hypertension', 'dataset1', 0, 'G2%, Gyu2%,', '21261, 212K,');

-- ELGH Chronic Kidney Disease CKD
call populateCodeDate(1, 'CKDLatest', 'dataset1', 0, '1Z1%, K051, K052, K053, K054, K055,', null);
call populateCodeDate(0, 'CKDEarliest', 'dataset1', 0, '1Z1%, K051, K052, K053, K054, K055,', null);

-- ELGH Dialysis
call populateCodeDate(1, 'DialysisLatest', 'dataset1', 0, '7L1A%, 8DD, 8DF,', null);
call populateCodeDate(0, 'DialysisEarliest', 'dataset1', 0, '7L1A%, 8DD, 8DF,', null);

-- ELGH RT
call populateCodeDate(1, 'RTLatest', 'dataset1', 0, '7B00%, ZV420,', null);
call populateCodeDate(0, 'RTEarliest', 'dataset1', 0, '7B00%, ZV420,', null);

-- ELGH RTR
call populateCodeDate(1, 'RTRLatest', 'dataset1', 0, 'SP080%, SP081, SP083, SP08C, SP08D, SP08E, SP08F, SP08G, SP08H, SP08I, SP08K, SP08L, SP08M, SP08N, SP08R, SP08V,', null);
call populateCodeDate(0, 'RTREarliest', 'dataset1', 0, 'SP080%, SP081, SP083, SP08C, SP08D, SP08E, SP08F, SP08G, SP08H, SP08I, SP08K, SP08L, SP08M, SP08N, SP08R, SP08V,', null);

-- ELGH Polycystic ovarian syndrome PCS
-- call populateCodeDate(0, 'PCS', 'dataset1', 0, 'C165, C164, C164-12, C164-13,', null);
call populateCodeDate(0, 'PCS', 'dataset1', 0, 'C165, C164,', null);

-- ELGH Obesity Disorder
call populateCodeDate(0, 'ObesityDisorder', 'dataset1', 0, 'Fy03, C3802, C38y0, H5B%, R0051, R0053,', null);

-- ELGH Fatty Liver NAFLD
call populateCodeDate(0, 'NAFLD', 'dataset1', 0, 'J61y, J61y1, J61y7, J61y8, J61y9,', null);

-- ELGH Hypercholesterol
call populateCodeDate(0, 'Hypercholesterol', 'dataset1', 0, 'C3200, C3201, C3204, C3205, C3203, C3220,', null);

-- ELGH Acanthosis
call populateCodeDate(0, 'Acanthosis', 'dataset1', 0, 'M212, PH3y5,', null);

-- ELGH Thyroid
call populateCodeDate(1, 'ThyroidLatest', 'dataset1', 0, 'C02%, C03%, C04%, 1JM%, 1431, 1432, F3814, Q4337, C0A5,', null);
call populateCodeDate(0, 'ThyroidEarliest', 'dataset1', 0, 'C02%, C03%, C04%, 1JM%, 1431, 1432, F3814, Q4337, C0A5,', null);

-- ELGH Coeliac disease
call populateCodeDate(0, 'CoeliacDisease', 'dataset1', 0, 'J690%,', null);

-- ELGH Vitiligo
call populateCodeDate(0, 'Vitiligo', 'dataset1', 0, 'M2951,', null);

-- ELGH Frailtyindex
call populateCodeDate(1, 'Frailtyindex', 'dataset1', 0, '38Ql, 2Jd0, 2Jd1, 2Jd2,', null);

-- ELGH NHS Health Check (HC)
call populateCodeDate(1, 'NHSHC', 'dataset1', 0, '8BAg%,', null);

update dataset1 d join cohort c on c.group_by = d.pseudo_id
set d.DateOfBirth = c.DateOfBirth,
d.YearOfDeath = c.YearOfDeath,
d.Gender = c.Gender;

UPDATE dataset1 d
	join cohort c on c.group_by = d.pseudo_id
 join ceg_compass_data.patient p ON c.patient_id = p.id
  join ceg_compass_data.episode_of_care e on e.patient_id = c.patient_id
 SET
 d.Age = p.age_years,
 registrationStart = e.date_registered,
 registrationEnd = e.date_registered_end,
 LSOA2011 = p.lsoa_code
 where
 (e.date_registered_end > now() or e.date_registered_end IS NULL)
 and e.registration_type_id = 2;

UPDATE dataset1 d
	join cohort c on c.group_by = d.pseudo_id
 join ceg_compass_data.patient p ON c.patient_id = p.id
  join ceg_compass_data.organization o on p.organization_id = o.id
 SET
 d.PracticeODSCode = o.ods_code,
 d.PracticeODSName = o.name;
