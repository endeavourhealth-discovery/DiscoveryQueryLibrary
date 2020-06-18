USE data_extracts;

DROP PROCEDURE IF EXISTS transferFromBartsPancreasCohortBP1;

DELIMITER //

CREATE PROCEDURE transferFromBartsPancreasCohortBP1()

BEGIN

-- remove duplicates

-- bp1_basicdataset
DROP TABLE IF EXISTS bp1_basicdataset_fin;

CREATE TABLE bp1_basicdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
	m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_basicdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_basicdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_diagnosisdataset
DROP TABLE IF EXISTS bp1_diagnosisdataset_fin;

CREATE TABLE bp1_diagnosisdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
	m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_diagnosisdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_diagnosisdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_symptomsdataset
DROP TABLE IF EXISTS bp1_symptomsdataset_fin;

CREATE TABLE bp1_symptomsdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_symptomsdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_symptomsdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_medicalhistorydataset
DROP TABLE IF EXISTS bp1_medicalhistorydataset_fin;

CREATE TABLE bp1_medicalhistorydataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_medicalhistorydataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_medicalhistorydataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_lifestyledataset
DROP TABLE IF EXISTS bp1_lifestyledataset_fin;

CREATE TABLE bp1_lifestyledataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_lifestyledataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_lifestyledataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_physicalexamdataset
DROP TABLE IF EXISTS bp1_physicalexamdataset_fin;

CREATE TABLE bp1_physicalexamdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_physicalexamdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_physicalexamdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_familyhistorydataset
DROP TABLE IF EXISTS bp1_familyhistorydataset_fin;

CREATE TABLE bp1_familyhistorydataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_familyhistorydataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_familyhistorydataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_bloodtestdataset
DROP TABLE IF EXISTS bp1_bloodtestdataset_fin;

CREATE TABLE bp1_bloodtestdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_bloodtestdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_bloodtestdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_urinetestdataset
DROP TABLE IF EXISTS bp1_urinetestdataset_fin;

CREATE TABLE bp1_urinetestdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_urinetestdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_urinetestdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_surgicaldataset
DROP TABLE IF EXISTS bp1_surgicaldataset_fin;

CREATE TABLE bp1_surgicaldataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_surgicaldataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_surgicaldataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp1_medications
DROP TABLE IF EXISTS bp1_medications_fin;

CREATE TABLE bp1_medications_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(255)) DonerId,
       CAST(NULL AS NCHAR(10)) NHSNumber,
       p.CodeDate,
       p.CodeTerm,
       p.CodeName,
       p.CodeValue,
       p.CodeUnit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.CodeDate,
       m.CodeTerm,
       m.CodeName,
       m.CodeValue,
       m.CodeUnit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.CodeDate IS NULL, 'x', m.CodeDate) AND 
       @curcodeterm =IF(m.CodeTerm IS NULL,'x', m.CodeTerm) AND 
       @curcodename = IF(m.CodeName IS NULL,'x', m.CodeName) AND 
       @curcodevalue = IF(m.Codevalue IS NULL,'x', m.Codevalue) AND 
       @curcodeunit = IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.CodeDate IS NULL, 'x', m.CodeDate),
       @curcodeterm := IF(m.CodeTerm IS NULL,'x', m.CodeTerm),
       @curcodename := IF(m.CodeName IS NULL,'x', m.CodeName),
       @curcodevalue := IF(m.Codevalue IS NULL,'x', m.Codevalue),
       @curcodeunit := IF(m.CodeUnit IS NULL,'x', m.CodeUnit )
FROM  bp1_medications m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcodename := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.CodeDate, m.CodeTerm, m.CodeName, m.CodeValue, m.CodeUnit) p
WHERE p.rnk = 1;

ALTER TABLE bp1_medications_fin ADD INDEX pseudo_idx (pseudo_id);

UPDATE bp1_basicdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_diagnosisdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_symptomsdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_medicalhistorydataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_lifestyledataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_physicalexamdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_familyhistorydataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_bloodtestdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_urinetestdataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_surgicaldataset_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;
UPDATE bp1_medications_fin d JOIN cohort_bp1 c ON c.group_by = d.pseudo_id set d.DonerId = c.doner_id, d.NHSNumber = c.NHSNumber;

ALTER TABLE bp1_basicdataset_fin DROP COLUMN id;
ALTER TABLE bp1_diagnosisdataset_fin DROP COLUMN id;
ALTER TABLE bp1_symptomsdataset_fin DROP COLUMN id;
ALTER TABLE bp1_medicalhistorydataset_fin DROP COLUMN id;
ALTER TABLE bp1_lifestyledataset_fin DROP COLUMN id;
ALTER TABLE bp1_physicalexamdataset_fin DROP COLUMN id;
ALTER TABLE bp1_familyhistorydataset_fin DROP COLUMN id;
ALTER TABLE bp1_bloodtestdataset_fin DROP COLUMN id;
ALTER TABLE bp1_urinetestdataset_fin DROP COLUMN id;
ALTER TABLE bp1_surgicaldataset_fin DROP COLUMN id;
ALTER TABLE bp1_medications_fin DROP COLUMN id;

ALTER TABLE bp1_basicdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_diagnosisdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_symptomsdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_medicalhistorydataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_lifestyledataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_physicalexamdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_familyhistorydataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_bloodtestdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_urinetestdataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_surgicaldataset_fin DROP COLUMN rnk;
ALTER TABLE bp1_medications_fin DROP COLUMN rnk;

ALTER TABLE bp1_basicdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_diagnosisdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_symptomsdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_medicalhistorydataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_lifestyledataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_physicalexamdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_familyhistorydataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_bloodtestdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_urinetestdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_surgicaldataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_medications_fin DROP COLUMN pseudo_id;

-- added 26/03/2020

DROP TABLE IF EXISTS bp1_genericgrp1dataset_fin;
CREATE TABLE bp1_genericgrp1dataset_fin AS SELECT * FROM bp1_genericgrp1dataset;

DROP TABLE IF EXISTS bp1_genericgrp2dataset_fin;
CREATE TABLE bp1_genericgrp2dataset_fin AS SELECT * FROM bp1_genericgrp2dataset;

ALTER TABLE bp1_genericgrp1dataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp1_genericgrp2dataset_fin DROP COLUMN pseudo_id;

DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS snomeds;

END//
DELIMITER ;
