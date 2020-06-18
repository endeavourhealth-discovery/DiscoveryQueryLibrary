USE data_extracts;

-- ahui 8/2/2020

DROP PROCEDURE IF EXISTS gh2execute6;

DELIMITER //
CREATE PROCEDURE gh2execute6()
BEGIN
-- the ALL tabs

-- 1 = latest
-- 0 = earliest
-- 3 = +/- 6 month window

-- Weight (all) -- 
DROP TABLE IF EXISTS gh2_weightALLdataset;
CREATE TABLE gh2_weightALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_weightALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_weightALLdataset','27113001,162763007',null,null,null,'Y');
-- Height (all) -- 
DROP TABLE IF EXISTS gh2_heightALLdataset;
CREATE TABLE gh2_heightALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_heightALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_heightALLdataset','50373000,162755006',null,null,null,'Y'); 
-- BMI (all) -- 
DROP TABLE IF EXISTS gh2_BMIALLdataset;
CREATE TABLE gh2_BMIALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_BMIALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_BMIALLdataset','301331008,60621009',null,null,null,'Y'); 
-- SBP (all) --
DROP TABLE IF EXISTS gh2_SBPALLdataset;
CREATE TABLE gh2_SBPALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_SBPALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_SBPALLdataset','271649006',null,null,null,'Y'); 
-- DBP (all) --
DROP TABLE IF EXISTS gh2_DBPALLdataset;
CREATE TABLE gh2_DBPALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_DBPALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_DBPALLdataset','271650006',null,null,null,'Y'); 
-- TotalCholesterol (all) -- 
DROP TABLE IF EXISTS gh2_TotalCholALLdataset;
CREATE TABLE gh2_TotalCholALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_TotalCholALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_TotalCholALLdataset','1005671000000105,850981000000101',null,null,null,'Y'); 
-- LDLCholesterol (all) -- 
DROP TABLE IF EXISTS gh2_LDLCholALLdataset;
CREATE TABLE gh2_LDLCholALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_LDLCholALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_LDLCholALLdataset','1022191000000100,1010591000000104,1014501000000104',null,null,null,'Y'); 
-- eGFR (all) -- 
DROP TABLE IF EXISTS gh2_eGFRALLdataset;
CREATE TABLE gh2_eGFRALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_eGFRALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_eGFRALLdataset','80274001',null,null,null,'Y'); 
-- TSH (all) --
DROP TABLE IF EXISTS gh2_TSHALLdataset;
CREATE TABLE gh2_TSHALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_TSHALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_TSHALLdataset','1027151000000105',null,null,null,'Y'); 
-- T4 (all) -- 
DROP TABLE IF EXISTS gh2_T4ALLdataset;
CREATE TABLE gh2_T4ALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_T4ALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_T4ALLdataset','1030801000000101',null,null,null,'Y'); 
-- ThyroidInhibitorAbs (all) -- 
DROP TABLE IF EXISTS gh2_ThyroidInhibALLdataset;
CREATE TABLE gh2_ThyroidInhibALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_ThyroidInhibALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_ThyroidInhibALLdataset','1087941000000104',null,null,null,'Y'); 
-- ThyrotropinBindingInhib (all) -- 
DROP TABLE IF EXISTS gh2_ThyrotropinBindALLdataset;
CREATE TABLE gh2_ThyrotropinBindALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_ThyrotropinBindALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_ThyrotropinBindALLdataset','1083811000000104',null,null,null,'Y'); 
-- AntithyroperoxidaseAbs (all) -- 
DROP TABLE IF EXISTS gh2_AntithyroperoxidaseALLdataset;
CREATE TABLE gh2_AntithyroperoxidaseALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_AntithyroperoxidaseALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_AntithyroperoxidaseALLdataset','1030111000000108',null,null,null,'Y'); 
-- AntithyroglobulinAbs (all) -- 
DROP TABLE IF EXISTS gh2_AntithyroglobulinALLdataset;
CREATE TABLE gh2_AntithyroglobulinALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_AntithyroglobulinALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_AntithyroglobulinALLdataset','995691000000101',null,null,null,'Y'); 
-- FastingGlucose (all) -- 
DROP TABLE IF EXISTS gh2_FastingGlucoseALLdataset;
CREATE TABLE gh2_FastingGlucoseALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_FastingGlucoseALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_FastingGlucoseALLdataset','997681000000108,1003131000000101,1003141000000105',null,null,null,'Y'); 
-- RandomGlucose (all) -- 
DROP TABLE IF EXISTS gh2_RandomGlucoseALLdataset;
CREATE TABLE gh2_RandomGlucoseALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_RandomGlucoseALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_RandomGlucoseALLdataset','1028881000000105,1089381000000101,1031331000000106',null,null,null,'Y'); 
-- HBA1C (all) -- 
DROP TABLE IF EXISTS gh2_HBA1CALLdataset;
CREATE TABLE gh2_HBA1CALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_HBA1CALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_HBA1CALLdataset','1003671000000109,443911005',null,null,null,'Y'); 
-- Ferritin (all) --
DROP TABLE IF EXISTS gh2_FerritinALLdataset;
CREATE TABLE gh2_FerritinALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_FerritinALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_FerritinALLdataset','993381000000106,992911000000107',null,null,null,'Y'); 
-- Haemoglobin (all) -- 
DROP TABLE IF EXISTS gh2_HaemoglobinALLdataset;
CREATE TABLE gh2_HaemoglobinALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_HaemoglobinALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_HaemoglobinALLdataset','1022431000000105',null,null,null,'Y'); 
-- FSH (all) -- 
DROP TABLE IF EXISTS gh2_FSHALLdataset;
CREATE TABLE gh2_FSHALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_FSHALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_FSHALLdataset','1027161000000108',null,null,null,'Y'); 
-- LH (all) -- 
DROP TABLE IF EXISTS gh2_LHALLdataset;
CREATE TABLE gh2_LHALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_LHALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_LHALLdataset','1030811000000104',null,null,null,'Y'); 
-- DHEA (all) -- 
DROP TABLE IF EXISTS gh2_DHEAALLdataset;
CREATE TABLE gh2_DHEAALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_DHEAALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_DHEAALLdataset','993101000000103,997171000000101',null,null,null,'Y'); 
-- SHBG (all) -- 
DROP TABLE IF EXISTS gh2_SHBGALLdataset;
CREATE TABLE gh2_SHBGALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_SHBGALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_SHBGALLdataset','999661000000105',null,null,null,'Y'); 
-- Prolactin (all) -- 
DROP TABLE IF EXISTS gh2_ProlactinALLdataset;
CREATE TABLE gh2_ProlactinALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_ProlactinALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_ProlactinALLdataset','1027171000000101',null,null,null,'Y'); 
-- Testosterone (all) -- 
DROP TABLE IF EXISTS gh2_TestosteroneALLdataset;
CREATE TABLE gh2_TestosteroneALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_TestosteroneALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_TestosteroneALLdataset','1026541000000101,997161000000108,995571000000101',null,null,null,'Y'); 
-- AntiMullerianHormone (all) -- 
DROP TABLE IF EXISTS gh2_AntiMullerianHormoneALLdataset;
CREATE TABLE gh2_AntiMullerianHormoneALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_AntiMullerianHormoneALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_AntiMullerianHormoneALLdataset','1006391000000109',null,null,null,'Y'); 
-- Oestradiol (all) -- 
DROP TABLE IF EXISTS gh2_OestradiolALLdataset;
CREATE TABLE gh2_OestradiolALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_OestradiolALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_OestradiolALLdataset','1024241000000108',null,null,null,'Y'); 
-- Progesterone (all) -- 
DROP TABLE IF EXISTS gh2_ProgesteroneALLdataset;
CREATE TABLE gh2_ProgesteroneALLdataset (
  pseudo_id           VARCHAR(255),
  pseudo_nhsnumber    VARCHAR(255),
  code                BIGINT,
  term                VARCHAR(200),
  value               DOUBLE,
  units               VARCHAR(50),
  date                DATE,
  age_at_event        INT
);
ALTER TABLE gh2_ProgesteroneALLdataset ADD INDEX gh2d6_pseudoid_idx (pseudo_id);

CALL populatetheAllDatasetsV2 ('gh2_ProgesteroneALLdataset','997151000000105',null,null,null,'Y'); 

END //
DELIMITER ;

