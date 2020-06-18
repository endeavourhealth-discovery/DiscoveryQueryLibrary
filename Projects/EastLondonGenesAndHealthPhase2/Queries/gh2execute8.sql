USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute8;

DELIMITER //
CREATE PROCEDURE gh2execute8()
BEGIN

-- Medications (diabetes)

DROP TABLE IF EXISTS gh2_MedDiabetesDataset;

CREATE TABLE gh2_MedDiabetesDataset (
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

ALTER TABLE gh2_MedDiabetesDataset ADD INDEX gh2_mdd_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Diabetes','Insulin','All','gh2_MedDiabetesDataset','39487003',null,null,null);
CALL populateMedicationsV2('Diabetes','Insulin','Short acting','gh2_MedDiabetesDataset','325013000',null,null,null);
CALL populateMedicationsV2('Diabetes','Insulin','Intermediate acting','gh2_MedDiabetesDataset','126214005',null,null,null);
CALL populateMedicationsV2('Diabetes','Insulin','Long acting','gh2_MedDiabetesDataset','126215006',null,null,null);
CALL populateMedicationsV2('Diabetes','Insulin','Ultra-long acting','gh2_MedDiabetesDataset','715774000',null,null,null);

CALL populateMedicationsV2('Diabetes','Hypoglycaemics','Sulphonylureas','gh2_MedDiabetesDataset','34012005',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','Metformin','gh2_MedDiabetesDataset','109081006',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','Alpha-glucosidase inhibitors','gh2_MedDiabetesDataset','762432004',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','DPP4 inhibitors','gh2_MedDiabetesDataset','422403005',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','GLP1 agonists','gh2_MedDiabetesDataset','416636000',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','Meglitinides','gh2_MedDiabetesDataset','109074004,134604002,109075003',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','SGLT2 inhibitors','gh2_MedDiabetesDataset','703677008',null,null,null);
CALL populateMedicationsV2('Diabetes','Hypoglycaemics','Thiazolidinediones','gh2_MedDiabetesDataset','764135009',null,null,null);

CALL populateMedicationsV2('Diabetes','Diabetes equipment','Glucose monitoring device','gh2_MedDiabetesDataset','354068006',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Glucose strip','gh2_MedDiabetesDataset','337388004',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Glucose + ketone strip','gh2_MedDiabetesDataset','34408811000001106',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Ketone strip','gh2_MedDiabetesDataset','413671005',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Insulin needles','gh2_MedDiabetesDataset','462662009,462552008,336919003',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Insulin syringes','gh2_MedDiabetesDataset','717306001',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetes equipment','Insulin pump','gh2_MedDiabetesDataset','69805005,450657002,443263006',null,null,null);

CALL populateMedicationsV2('Diabetes','Diabetic neuropathy','Tricyclics','gh2_MedDiabetesDataset','40589005,36113004',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetic neuropathy','SNRI','gh2_MedDiabetesDataset','407033009,108432009',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetic neuropathy','Other','gh2_MedDiabetesDataset','400416009',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetic neuropathy','AED','gh2_MedDiabetesDataset','40820003,108402001,415159003',null,null,null);
CALL populateMedicationsV2('Diabetes','Diabetic neuropathy','TCA','gh2_MedDiabetesDataset','13432000',null,null,null);

END //
DELIMITER ;


