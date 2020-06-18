USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute10;

DELIMITER //
CREATE PROCEDURE gh2execute10()
BEGIN

-- Medications (OtherEndocrine)

DROP TABLE IF EXISTS gh2_MedEndoDataset;

CREATE TABLE gh2_MedEndoDataset (               
     pseudo_id                    VARCHAR(255),
     pseudo_nhsnumber             VARCHAR(255),
     category                     VARCHAR(100),
     subcategory                  VARCHAR(100),
     class                        VARCHAR(100),
     code                         VARCHAR(100),
     term                         VARCHAR(200),
     earliest_issue_date          DATE,
     latest_issue_date            DATE,
     discontinued_date            DATE,
     binary_4month_ind            VARCHAR(10),
     med_id                       BIGINT
);

ALTER TABLE gh2_MedEndoDataset ADD INDEX gh2_mdeno_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Endocrine','HRT','Oestrogen','gh2_MedEndoDataset','12839006,354050008,90017009,16832004,36915211000001107,325567003',null,null,null);

CALL populateMedicationsV2('Endocrine','Treatment of PCOS','Anti-oestrogen','gh2_MedEndoDataset','30466001,36621009,108777007',null,null,null);

CALL populateMedicationsV2('Endocrine','Oral contraceptives','Combined','gh2_MedEndoDataset','412362000,416617005,418031001,412420008,414147008,412256008,412182005,412450000,22381711000001105,15487811000001103',null,null,null);

CALL populateMedicationsV2('Endocrine','Oral contraceptives','Progesterone only','gh2_MedEndoDataset','326447002,400419002,326425002',null,null,null);

CALL populateMedicationsV2('Endocrine','Treatment of hirsutism','Anti-androgen','gh2_MedEndoDataset','768272001,13929005,96371003,109035006',null,'713979004',null);

CALL populateMedicationsV2('Endocrine','Treatment of hirsutism','Antiprotozoal','gh2_MedEndoDataset','108715006',null,null,null);

CALL populateMedicationsV2('Endocrine','Hypothyroidism','Thyroxine','gh2_MedEndoDataset','61020000',null,null,null);

CALL populateMedicationsV2('Endocrine','Thyroid altering meds','Thyroid altering meds','gh2_MedEndoDataset','40556005,69236009,321719003,404864000,3814009',null,null,null);


END //
DELIMITER ;
