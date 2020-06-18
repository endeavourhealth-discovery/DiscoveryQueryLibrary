USE data_extracts;

DROP PROCEDURE IF EXISTS buildDatasetForBartsPancreasBP1;

DELIMITER //
CREATE PROCEDURE buildDatasetForBartsPancreasBP1()
BEGIN

DROP TABLE IF EXISTS bp1_basicdataset;
DROP TABLE IF EXISTS bp1_diagnosisdataset;
DROP TABLE IF EXISTS bp1_symptomsdataset;
DROP TABLE IF EXISTS bp1_medicalhistorydataset;
DROP TABLE IF EXISTS bp1_lifestyledataset;
DROP TABLE IF EXISTS bp1_physicalexamdataset;
DROP TABLE IF EXISTS bp1_familyhistorydataset;
DROP TABLE IF EXISTS bp1_bloodtestdataset;
DROP TABLE IF EXISTS bp1_urinetestdataset;
DROP TABLE IF EXISTS bp1_surgicaldataset;
DROP TABLE IF EXISTS bp1_medications;

CREATE TABLE bp1_basicdataset (
   pseudo_id        VARCHAR(255) DEFAULT NULL,
   DonerId          VARCHAR(255) DEFAULT NULL,
   NHSNumber        VARCHAR(10)  DEFAULT NULL,
   CodeDate         VARCHAR(20)  DEFAULT NULL,
   CodeTerm         VARCHAR(255) DEFAULT NULL,
   CodeName         VARCHAR(100) DEFAULT NULL,
   CodeValue        VARCHAR(100) DEFAULT NULL,
   CodeUnit         VARCHAR(100) DEFAULT NULL
);

CREATE TABLE bp1_diagnosisdataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_symptomsdataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_medicalhistorydataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_lifestyledataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_physicalexamdataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_familyhistorydataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_bloodtestdataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_urinetestdataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_surgicaldataset AS SELECT * FROM bp1_basicdataset;
CREATE TABLE bp1_medications AS SELECT * FROM bp1_basicdataset;


ALTER TABLE bp1_basicdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_diagnosisdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_symptomsdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_medicalhistorydataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_lifestyledataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_physicalexamdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_familyhistorydataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_bloodtestdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_urinetestdataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_surgicaldataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp1_medications ADD id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE bp1_basicdataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_diagnosisdataset ADD INDEX pseudoIdx (pseudo_id);

ALTER TABLE bp1_symptomsdataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_medicalhistorydataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_lifestyledataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_physicalexamdataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_familyhistorydataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_bloodtestdataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_urinetestdataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_surgicaldataset ADD INDEX pseudoIdx (pseudo_id);
ALTER TABLE bp1_medications ADD INDEX pseudoIdx (pseudo_id);

ALTER TABLE bp1_medications ADD INDEX codename_idx(codename);
ALTER TABLE bp1_medications ADD INDEX codedate_idx(codedate);

-- added 26/03/2020

DROP TABLE IF EXISTS bp1_genericgrp1dataset;
DROP TABLE IF EXISTS bp1_genericgrp2dataset;

CREATE TABLE bp1_genericgrp1dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  NULL,
   gender               VARCHAR(7)   NULL,
   ethnicity            VARCHAR(100) NULL,
   birthdate            VARCHAR(100) NULL,
   dateofdeath          VARCHAR(30)  NULL,
   doner_id             VARCHAR(100) NULL
);

CREATE TABLE bp1_genericgrp2dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  NULL,
   appointmentdate      DATETIME,
   appointmentstatus    VARCHAR(50)
);

ALTER TABLE bp1_genericgrp1dataset ADD INDEX pseudoIdx(pseudo_id);
ALTER TABLE bp1_genericgrp2dataset ADD INDEX pseudoIdx(pseudo_id);

DROP TABLE IF EXISTS store;

CREATE TABLE store (
   id            INT,
   code          VARCHAR(20)
);

ALTER TABLE store ADD INDEX store_idx(code);
ALTER TABLE store ADD INDEX id_idx(id);

DROP TABLE IF EXISTS snomeds;

CREATE TABLE snomeds (
   snomed_id   BIGINT,
   cat_id      INT
);

ALTER TABLE snomeds ADD INDEX snomedid_idx(snomed_id);


DROP TEMPORARY TABLE IF EXISTS cohort_bp1_observations;

CREATE TEMPORARY TABLE cohort_bp1_observations AS
     SELECT 
            o.id,
            o.patient_id,
            cr.group_by,
            cr.person_id,
            o.clinical_effective_date,
            o.original_code,
            o.original_term,
            o.result_value,
            o.result_value_units
     FROM cohort_bp1 cr JOIN enterprise_pseudo.observation o ON o.person_id = cr.person_id;

CREATE INDEX bp1_obv_ix ON cohort_bp1_observations(original_code);
CREATE INDEX bp1_obv_grp_ix ON cohort_bp1_observations(group_by);

DROP TEMPORARY TABLE IF EXISTS cohort_bp1_medications;

CREATE TEMPORARY TABLE cohort_bp1_medications AS
     SELECT 
              m.id,
              m.dmd_id,
              m.patient_id,
              cr.group_by,
              cr.person_id,
              m.original_term,
              m.clinical_effective_date,
              m.quantity_unit,
              m.quantity_value
     FROM cohort_bp1 cr JOIN enterprise_pseudo.medication_order m ON m.patient_id = cr.patient_id;

CREATE INDEX bp1_med_ix ON cohort_bp1_medications(dmd_id);
CREATE INDEX bp1_med_grp_ix ON cohort_bp1_medications(group_by);

END//
DELIMITER ;
