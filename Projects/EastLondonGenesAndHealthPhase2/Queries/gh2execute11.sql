USE data_extracts;

-- ahui 10/2/2020

DROP PROCEDURE IF EXISTS gh2execute11;

DELIMITER //
CREATE PROCEDURE gh2execute11()
BEGIN

-- Medications (Asthma)

DROP TABLE IF EXISTS gh2_MedAsthmaDataset;

CREATE TABLE gh2_MedAsthmaDataset (
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

ALTER TABLE gh2_MedAsthmaDataset ADD INDEX gh2_mdast_pseduo_id (pseudo_id);

CALL populateMedicationsV2('Asthma','Oral steroid','Oral steroid','gh2_MedAsthmaDataset','10312003,349354003',null,null,null);

CALL populateMedicationsV2('Asthma','ICS','ICS','gh2_MedAsthmaDataset','1389007,108632003,75203002,416739001',null,'349361004,432681009,350386006,11880411000001105,13229101000001104,34855311000001107,20121811000001105,16072611000001102,22053511000001109,29731511000001103,350438003,350437008,13229401000001105,13229501000001109,21991211000001107,34955711000001102,407754007,407753001,13229701000001103,32695711000001104,32695811000001107,32695811000001107,18525411000001101,424048001',null);

CALL populateMedicationsV2('Asthma','Beta2 agonist','Beta2 agonist','gh2_MedAsthmaDataset','91143003,45311002,108605008,386171009,349923005',null,'421685007,135640007,13159601000001109,35937011000001102,28279711000001100,35916011000001108,349928001,28367211000001102,34855311000001107,763710002',null);

CALL populateMedicationsV2('Asthma','Other','Other','gh2_MedAsthmaDataset','66493003,55867006',null,null,null);

CALL populateMedicationsV2('Asthma','Leukotriene antagonist','Leukotriene antagonist','gh2_MedAsthmaDataset','320883008',null,null,null);

CALL populateMedicationsV2('Asthma','Mast cell stabilizer','Mast cell stabilizer','gh2_MedAsthmaDataset','108627004,4161311000001109,35926611000001105,35926711000001101,13801911000001104',null,'430684006',null);

CALL populateMedicationsV2('Asthma','Monoclonal Ab','Monoclonal Ab','gh2_MedAsthmaDataset','763652003,406442003,31201911000001104,33999711000001105',null,null,null);

CALL populateMedicationsV2('Asthma','Leukotriene antagonist','Leukotriene antagonist','gh2_MedAsthmaDataset','108614003,386180009',null,null,null);


END //
DELIMITER ;
