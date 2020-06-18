USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute7;

DELIMITER //
CREATE PROCEDURE gh2execute7()
BEGIN

-- Medications (Psych)

DROP TABLE IF EXISTS gh2_MedPsychDataset;

CREATE TABLE gh2_MedPsychDataset (
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

ALTER TABLE gh2_MedPsychDataset ADD INDEX gh2_mpd_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Psychiatry','Antidpepressants','TCA + related','gh2_MedPsychDataset','768611005,7336002,96200003,108430001',null,'108418007,349963006,108681001,439257008,134506008,1594006',null);

CALL populateMedicationsV2('Psychiatry','Antidpepressants','SNRI','gh2_MedPsychDataset','767562003,96199001',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antidpepressants','SSRI','gh2_MedPsychDataset','349854005',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antidpepressants','MAOI','gh2_MedPsychDataset','29877002,321911007,9500005,89092006',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antidpepressants','Other','gh2_MedPsychDataset','96220002,41365009,321995004,349857003,96199001',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antipsychotics','1st gen','gh2_MedPsychDataset','321391002,47331002,26574002,96220002,41365009,10756001,89029005,59270007,321467007,41147003,108438008,79129001,108438008,44658005,321506004,33588000,71699007,429346008',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antipsychotics','2nd gen','gh2_MedPsychDataset','321636003,406785006,443374004,763607001,96221003,715585000,108441004,425483000,108443001,108386000,349884002,321603004',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antipsychotics','AED','gh2_MedPsychDataset','40820003,96195007,40556005,13965000,415159003',null,null,null);

CALL populateMedicationsV2('Psychiatry','Antipsychotics','Other','gh2_MedPsychDataset','768698000,349883008,349879008,51073002,46709004',null,null,null);


END //
DELIMITER ;


