USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute9;

DELIMITER //
CREATE PROCEDURE gh2execute9()
BEGIN

-- Medications (cardiovascular)

DROP TABLE IF EXISTS gh2_MedCardioDataset;

CREATE TABLE gh2_MedCardioDataset (
     pseudo_id              VARCHAR(255),
     pseudo_nhsnumber       VARCHAR(255),
     category               VARCHAR(100),
     subcategory            VARCHAR(100),
     class                  VARCHAR(100),
     code                   VARCHAR(100),
     term                   VARCHAR(200),
     earliest_issue_date    DATE,
     latest_issue_date      DATE,
     discontinued_date      DATE,
     binary_4month_ind      VARCHAR(10),
     med_id                 BIGINT
);

ALTER TABLE gh2_MedCardioDataset ADD INDEX gh2_mcdio_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Cardiovascular','Cardiac glycosides','Cardiac Glycoside','gh2_MedCardioDataset','91307002,81728006,796001,317911001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Diuretics','Thiazides and relateds','gh2_MedCardioDataset','768616000,74213004,22198003,317968004,57893000,400606007,429462003',null,'58905004',null);
CALL populateMedicationsV2('Cardiovascular','Diuretics','Loops','gh2_MedCardioDataset','81609008,318034005,86647004,81947000,318031002,64029000',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Diuretics','Potassium sparing','gh2_MedCardioDataset','346312000,87395005,12512008',null,null,null);

CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class II','gh2_MedCardioDataset','33252009',null,'108544005,108551001,46547007,108542009,18381001,318638009,85591001,349903009,108831007',null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class IV','gh2_MedCardioDataset','59941008,47898004',null,null,null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Other','gh2_MedCardioDataset','108502004,91307002,81728006,796001,317911001',null,null,null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class III','gh2_MedCardioDataset','69236009,443310000,37238511000001107,108491000',null,null,null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class Ia','gh2_MedCardioDataset','76759004,61773008,11959009,31306009',null,null,null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class Ic','gh2_MedCardioDataset','46576005,96300001',null,null,null);
CALL populateMedicationsV2('Cardiovascular','AntiArrhythmics','Class Ib','gh2_MedCardioDataset','10555000,96298001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Vasodilating anti-hypertensives','Vasodilating anti-hypertensives','gh2_MedCardioDataset','409434000,22696000,108556006,76058001,129484001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Centrally-acting anti-hypertensives','Centrally-acting anti-hypertensives','gh2_MedCardioDataset','84078002,318706009,62782004',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Alpha-blocker antihypertensives','Alpha-blocker antihypertensives','gh2_MedCardioDataset','108556006,76058001,129484001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Alpha adrenoceptor blockers','Alpha blockers','gh2_MedCardioDataset','67440007',null,null,null);

CALL populateMedicationsV2('Cardiovascular','ACE inhibitors','ACE inhibitors','gh2_MedCardioDataset','41549009',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Angiotensin II antagonists','Angiotensin II antagonists','gh2_MedCardioDataset','96308008',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Betablockers','Betablockers','gh2_MedCardioDataset','33252009',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Calcium channel blockers','Calcium channel blockers','gh2_MedCardioDataset','48698004',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Nitrates','Nitrates','gh2_MedCardioDataset','108478001,71759000',null,'319407007,317730008,16109611000001108,9315411000001108,18161111000001107,9056111000001102,22702711000001103,18153411000001105,20353011000001109,36774711000001102,15774611000001105,15648511000001108,9055911000001106',null);

CALL populateMedicationsV2('Cardiovascular','Antihypertensive CCBs','Dihydropiridine CCBs','gh2_MedCardioDataset','108537001,108535009,319299000,356862006,108526002,85272000,87285001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Angina','Other','gh2_MedCardioDataset','421692002,319304004,420624001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Peripheral vasodilators','Peripheral vasodilators','gh2_MedCardioDataset','350627007,423311006,356864007,91376007,74771007',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Oral anticoagulants','Oral anticoagulants','gh2_MedCardioDataset','768600002,47527007,442539005,764885002,385576000',null,'737675000',null);

CALL populateMedicationsV2('Cardiovascular','Antiplatelet drugs','Antiplatelet','gh2_MedCardioDataset','7947003,108979001,704464003,66859009,116065005,443312008,108971003,108981004,763606005,32966711000001108,395239000',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Lipid regulating drugs','Other','gh2_MedCardioDataset','408041006,23592411000001102,414932003,350626003,319982006,63639004,37648411000001106',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Lipid regulating drugs','Statin','gh2_MedCardioDataset','96302009',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Lipid regulating drugs','Fibrate','gh2_MedCardioDataset','319937007,35282000,320016006,108603001',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Lipid regulating drugs','Bile acid sequestrant','gh2_MedCardioDataset','66971004,72824008,441851004',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Lipid regulating drugs','PCSK9 inhibtor','gh2_MedCardioDataset','30912811000001107,30731011000001109',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Erectile dysfunction treatment','Phosphodiesterase 5 inihbitor','gh2_MedCardioDataset','407316005',null,null,null);
CALL populateMedicationsV2('Cardiovascular','Erectile dysfunction treatment','Prostaglandin receptor agonist','gh2_MedCardioDataset','109119001',null,null,null);

CALL populateMedicationsV2('Cardiovascular','Weight loss drugs','Lipase inhibitor','gh2_MedCardioDataset','116093009',null,null,null);

END //
DELIMITER ;


