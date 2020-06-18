USE data_extracts;

DROP PROCEDURE IF EXISTS buildDatasetForBartsPancreasBP2;

DELIMITER //

CREATE PROCEDURE buildDatasetForBartsPancreasBP2()
BEGIN

DROP TABLE IF EXISTS bp2_genericgrp1dataset;  
DROP TABLE IF EXISTS bp2_genericgrp2dataset; 
DROP TABLE IF EXISTS bp2_basicdataset;
DROP TABLE IF EXISTS bp2_diagnosisdataset;
DROP TABLE IF EXISTS bp2_symptomsdataset;
DROP TABLE IF EXISTS bp2_medicalhistorydataset;
DROP TABLE IF EXISTS bp2_lifestyledataset;
DROP TABLE IF EXISTS bp2_physicalexamdataset;
DROP TABLE IF EXISTS bp2_familyhistorydataset;
DROP TABLE IF EXISTS bp2_bloodtestdataset;
DROP TABLE IF EXISTS bp2_urinetestdataset;
DROP TABLE IF EXISTS bp2_surgicaldataset;
DROP TABLE IF EXISTS bp2_medications;

CREATE TABLE bp2_genericgrp1dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  NULL,
   gender               VARCHAR(7)   NULL,
   ethnicity            VARCHAR(100) NULL,
   birthdate            VARCHAR(100) NULL,
   dateofdeath          VARCHAR(30)  NULL
);

CREATE TABLE bp2_genericgrp2dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  NULL,
   appointmentdate      DATETIME,
   appointmentstatus    VARCHAR(50)
);

CREATE TABLE bp2_basicdataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  DEFAULT NULL,
   codedate             VARCHAR(20)  DEFAULT NULL,
   codeterm             VARCHAR(255) DEFAULT NULL,
   code                 VARCHAR(100) DEFAULT NULL,
   codevalue            VARCHAR(100) DEFAULT NULL,
   codeunit             VARCHAR(100) DEFAULT NULL
);

CREATE TABLE bp2_diagnosisdataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_symptomsdataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_medicalhistorydataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_lifestyledataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_physicalexamdataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_familyhistorydataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_bloodtestdataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_urinetestdataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_surgicaldataset AS SELECT * FROM bp2_basicdataset;
CREATE TABLE bp2_medications AS SELECT * FROM bp2_basicdataset;

ALTER TABLE bp2_basicdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_diagnosisdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_symptomsdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_medicalhistorydataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_lifestyledataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_physicalexamdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_familyhistorydataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_bloodtestdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_urinetestdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_surgicaldataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_medications ADD id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE bp2_genericgrp1dataset ADD INDEX genericgrp1pseudoIdx (pseudo_id);
ALTER TABLE bp2_genericgrp2dataset ADD INDEX genericgrp2pseudoIdx (pseudo_id);
ALTER TABLE bp2_basicdataset ADD INDEX basicpseudoIdx (pseudo_id);
ALTER TABLE bp2_diagnosisdataset ADD INDEX diagnosispseudoIdx (pseudo_id);
ALTER TABLE bp2_symptomsdataset ADD INDEX symptomspseudoIdx (pseudo_id);
ALTER TABLE bp2_medicalhistorydataset ADD INDEX medicalhistorypseudoIdx (pseudo_id);
ALTER TABLE bp2_lifestyledataset ADD INDEX lifestylepseudoIdx (pseudo_id);
ALTER TABLE bp2_physicalexamdataset ADD INDEX physicalexampseudoIdx (pseudo_id);
ALTER TABLE bp2_familyhistorydataset ADD INDEX familyhistorypseudoIdx (pseudo_id);
ALTER TABLE bp2_bloodtestdataset ADD INDEX bloodtestpseudoIdx (pseudo_id);
ALTER TABLE bp2_urinetestdataset ADD INDEX urinetestpseudoIdx (pseudo_id);
ALTER TABLE bp2_surgicaldataset ADD INDEX surgicalpseudoIdx (pseudo_id);
ALTER TABLE bp2_medications ADD INDEX medicationspseudoIdx (pseudo_id);

ALTER TABLE bp2_medications ADD INDEX code_idx (code);
ALTER TABLE bp2_medications ADD INDEX codedate_idx (codedate);


DROP TABLE IF EXISTS code_set_codes_bp2;

CREATE TABLE code_set_codes_bp2 (
  cat_id       INT,
  code         VARCHAR(20)
);

ALTER TABLE code_set_codes_bp2 ADD id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE code_set_codes_bp2 ADD INDEX bp2_cat_idx (cat_id);
ALTER TABLE code_set_codes_bp2 ADD INDEX bp2_sno_idx (code);

DROP TABLE IF EXISTS store;

CREATE TABLE store (
   id            INT,
   code          VARCHAR(20)
);

ALTER TABLE store ADD INDEX store_idx (code);
ALTER TABLE store ADD INDEX id_idx (id);

DROP TABLE IF EXISTS snomeds;

CREATE TABLE snomeds (
   snomed_id   BIGINT,
   cat_id      INT
);

ALTER TABLE snomeds ADD INDEX snomedid_idx (snomed_id);

DROP TABLE IF EXISTS tpp_ctv3_hierarchy_ref_tmp;

CREATE TABLE tpp_ctv3_hierarchy_ref_tmp AS
SELECT * FROM rf2.tpp_ctv3_hierarchy_ref;

ALTER TABLE tpp_ctv3_hierarchy_ref_tmp 
ADD PRIMARY KEY (row_id, ctv3_parent_read_code)
PARTITION BY KEY(ctv3_parent_read_code)
PARTITIONS 200;

ALTER TABLE tpp_ctv3_hierarchy_ref_tmp ADD INDEX ctv3_idx (ctv3_parent_read_code);

DROP TABLE IF EXISTS read2_codes_tmp;

CREATE TABLE read2_codes_tmp AS
SELECT * FROM read2_codes;

ALTER TABLE read2_codes_tmp ADD INDEX read2_idx (read2_code);

DROP TEMPORARY TABLE IF EXISTS cohort_bp2_observations;

CREATE TEMPORARY TABLE cohort_bp2_observations AS
      SELECT DISTINCT
             o.id,
             o.patient_id,
             cr.group_by,
             cr.person_id,
             o.clinical_effective_date,
             o.original_code,
             o.original_term,
             o.result_value,
             o.result_value_units
      FROM cohort_bp2 cr
      JOIN enterprise_pseudo.observation o ON o.person_id = cr.person_id;

CREATE INDEX bp2_obv_ix ON cohort_bp2_observations (original_code);


DROP TEMPORARY TABLE IF EXISTS cohort_bp2_medications;

CREATE TEMPORARY TABLE cohort_bp2_medications AS
       SELECT DISTINCT
             m.id,
             m.dmd_id,
             m.patient_id,
             cr.group_by,
             cr.person_id,
             m.original_term,
             m.clinical_effective_date,
             m.quantity_unit,
             m.quantity_value
       FROM cohort_bp2 cr
       JOIN enterprise_pseudo.medication_order m ON m.person_id = cr.person_id;

CREATE INDEX bp2_med_ix ON cohort_bp2_medications (dmd_id);


END//
DELIMITER ;
