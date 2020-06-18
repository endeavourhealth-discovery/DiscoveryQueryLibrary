use data_extracts;

drop procedure if exists generateReportForChildImms;

DELIMITER //
CREATE PROCEDURE generateReportForChildImms ()
BEGIN

-- Breast fed at 6 weeks
call populateDatasetFromMixedCodes(2, 'dataset_wf', '6422,');

-- Breast and supplement fed at 6 weeks
call populateDatasetFromMixedCodes(2, 'dataset_wf', '6423,');

-- Breast fed
call populateDatasetFromMixedCodes(2, 'dataset_wf', '62P1,');

-- Bottle fed
call populateDatasetFromMixedCodes(2, 'dataset_wf', '62P2,');

-- Breast-feeding with supplement
call populateDatasetFromMixedCodes(2, 'dataset_wf', '62P3,');

-- Breast changed to bottle feed
call populateDatasetFromMixedCodes(2, 'dataset_wf', '62P4,');

-- Bottle changed to breast
call populateDatasetFromMixedCodes(2, 'dataset_wf', '62PB,');

-- Breast fed at birth
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'XaJgn,');

-- Breastfeeding at discharge from hospital
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'XaPO0,');

-- Breastfeeding and supplementary bottle feeding at discharge from hospital
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'XaPO8,');

-- 31 - 75
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'ZV030,ZV047,ZV035,ZV063,ZV061,ZV048,ZV042,ZV064,ZV04,ZV036,ZV040,ZV043,ZV041,ZV037,ZV032,XaFTh,XaFTi,XaFTj,6579,6513,65MG,65J4,XaNdZ,XaPti,6544,XaIPb,XaIPv,XaLvG,XaONV,657D,XaIed,XaJhz,65FD,65F4,XaLK4,XaG0H,Xaees,XaaXa,XaIeO,6584,XaIrG,65L4,6564,XaLK7,6523,');

-- 76 - 150
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'XaQhk,XaQhl,651,651Z,XaE4T,Xabyv,XE2b2,65KZ,XE1Si,XaK4s,654,65I,65IZ,65H,65HZ,65F7,Xaakl,6575,XaKMz,6511,65MD,Xaa4a,65J1,XaK4t,6541,65I1,65H1,XaJky,XagJH,XaJo7,XaCEP,XaXJI,XaEc9,XaEFH,65FA,Xaa4V,65F1,XaNNI,Xaeev,Xaeet,XaKMw,XacJs,XaF1x,Xaeec,XaLNG,6551,XaLqs,6581,65D1,Xaa9n,6592,XaIrD,6561,XaXnn,6521,XaMz5,XaEKG,Xaa4Y,65F6,XacJv,Xaakk,XaMKL,XaavB,Xabyy,9OX2,XaEc8,XaXPW,XaZsM,XaQk3,XaN0i,XaQdj,XaQe5,XaN0g,XaQdk,');

-- 151 - 250
call populateDatasetFromMixedCodes(2, 'dataset_wf', 'XaN20,XaN0h,XaN0f,XaQgS,XaNQd,65E,XaIOT,XaJ5n,XaXsK,XaK2d,6545,XaK4x,XaK4w,65MA,65MC,XaQPr,65A,XaVy4,65M1,65M2,XaF20,XacJx,6571,XaCFh,65F5,XaQhm,XaQhn,Xa7Oi,655,XacJ3,6573,6572,XaIOS,XaCKa,XaKFY,XaObE,658,658Z,XaZVN,F034C,Xa1cN,XaXjc,XaKYF,65D,65DZ,XaQxb,XaNwr,Xaa9q,65B,XaZ0d,XaZ0j,XaZfY,XaaZp,XaZ0k,6576,XaKN0,6512,65ME,Xaa4b,65J2,XaK4u,6542,65I2,65H2,XaJkz,XagJI,XaJo8,XaCEQ,XaXJJ,XaEcA,XaEFI,65FB,Xaa4W,65F2,XaNNJ,Xaeew,XaKMx,XacJt,XaF1y,XaLNH,6552,XaLqt,6582,65D2,Xaa9o,XaIrE,6562,XaXno,6522,XaMzA,XaIsO,XaF4P,65GZ,XaYvC,65J5,XE1Sj,656,656Z,');

-- 251 - 354
call populateDatasetFromMixedCodes(2, 'dataset_wf', '65MF,Xaa4c,65J3,XaK4v,6543,65I3,65H3,XaJl0,XagJJ,XaJo9,XaCER,657C,XaJhy,65FC,Xaa4X,65F3,XaNNK,XaKMy,XacJu,XaF1z,6553,XaLqu,6583,65D3,XaIrF,6563,XaXnp,6700,Xa1po,653,6574,XaBbI,652Z,XaJov,68N5,68N6,8BMN,657L,65d0,65710,EMISNQSE78,657M,65711,657N,6571A,65ED1,65ED3,65E21.,65E22,65E20,65ED0 ,657P,65720,65I8,65I9,65MB,65K5,657J,65FS,65FT,65FV,65a0,65a1,65a2,65MH,657E,65MI,657F,65MJ,657I,EMISNQ4T2,657A,657B,65I4,65A1,65O3,65F10,65F20,EMISNQFI26,EMISNQTH31,65F30,43B1,43d9,43BA,43B4,68NI,8I3x,68NI-1,');

-- pseudo ID
update dataset_wf d join ceg_compass_data.patient p on p.id = d.patient_id set d.pseudo_id = p.pseudo_id;

 -- Practice
update dataset_wf d join ceg_compass_data.patient p on p.id = patient_id join
 ceg_compass_data.organization org on org.id = p.organization_id set PracticeODSCode = org.ods_code, PracticeName = org.name;

 -- Age in years
 -- update dataset_wf d join ceg_compass_data.patient p on p.id = patient_id
 -- set
 -- AgeYears = p.age_years,
 -- AgeMonths = p.age_months;

 -- Ethnicity
  update dataset_wf d join ceg_compass_data.patient p on p.id = patient_id
  join ceg_compass_data.ethnicity_lookup el on el.ethnic_code = p.ethnic_code
 set Ethnicity = el.ethnic_name;

-- Hash for delta calcualtion
update dataset_wf d set hash = md5(CONCAT(d.CodeName, d.CodeTerm, d.CodeDate));

 -- clean

 -- alter table dataset_wf drop column patient_id;


 END//
 DELIMITER ;
