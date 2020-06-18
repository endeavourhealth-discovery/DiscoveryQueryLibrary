USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute12;

DELIMITER //
CREATE PROCEDURE gh2execute12()
BEGIN

-- Medications (Derm)

DROP TABLE IF EXISTS gh2_MedDermDataset;

CREATE TABLE gh2_MedDermDataset (
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

ALTER TABLE gh2_MedDermDataset ADD INDEX gh2_mdderm_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Derm','Calcineurin inhibitors','Calcineurin inhibitors','gh2_MedDermDataset','385581009,109129008',null,null,null);

CALL populateMedicationsV2('Derm','Topical steroid','Topical steroid','gh2_MedDermDataset','349355002,116576003,764616008,116589009,71455005,120624004,420859004,29058003,81457006,350465005,349355002,350438003,407754007,430519004,769209000,413870009,415158006,120623005',null,null,null);

CALL populateMedicationsV2('Derm','Emollient','Emollient','gh2_MedDermDataset','48279009',null,null,null);

CALL populateMedicationsV2('Derm','Antihistamine','Antihistamine','gh2_MedDermDataset','80165005,430971000,767990008,26462003 ,349964000,108655000,108652002,108650005,320830000,134506008',null,null,null);

CALL populateMedicationsV2('Derm','Oral steroid','Oral steroid','gh2_MedDermDataset','350448001,10312003,349354003,350449009,350396002,350463003',null,null,null);

CALL populateMedicationsV2('Derm','Phototherapy','Phototherapy','gh2_MedDermDataset','82350007',null,null,null);

CALL populateMedicationsV2('Derm','Other','Other','gh2_MedDermDataset','430167004,136113003,439257008,111165009,68887009,109131004',null,null,null);


END //
DELIMITER ;
