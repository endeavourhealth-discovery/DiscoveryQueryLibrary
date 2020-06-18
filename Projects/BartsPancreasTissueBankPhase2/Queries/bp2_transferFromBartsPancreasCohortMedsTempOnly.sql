USE data_extracts;

DROP PROCEDURE IF EXISTS transferFromBartsPancreasCohortBP2;

DELIMITER //

CREATE PROCEDURE transferFromBartsPancreasCohortBP2()

BEGIN

-- remove duplicates
/*
-- bp2_basicdataset
DROP TABLE IF EXISTS bp2_basicdataset_tmp;

CREATE TABLE bp2_basicdataset_tmp AS
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id AS curpseudoid,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate) AS curcodedate,
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm) AS curcodeterm,
       @curcode := IF(m.code IS NULL,'x', m.code) AS curcode,
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue) AS curcodevalue,
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit ) AS curcodeunit
FROM  bp2_basicdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit;

ALTER TABLE bp2_basicdataset_tmp ADD INDEX rnk_idx(rnk);

DROP TABLE IF EXISTS bp2_basicdataset_fin;

CREATE TABLE bp2_basicdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM bp2_basicdataset_tmp p
WHERE p.rnk = 1;

ALTER TABLE bp2_basicdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_diagnosisdataset
DROP TABLE IF EXISTS bp2_diagnosisdataset_fin;

CREATE TABLE bp2_diagnosisdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_diagnosisdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_diagnosisdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_symptomsdataset
DROP TABLE IF EXISTS bp2_symptomsdataset_fin;

CREATE TABLE bp2_symptomsdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_symptomsdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_symptomsdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_medicalhistorydataset
DROP TABLE IF EXISTS bp2_medicalhistorydataset_fin;

CREATE TABLE bp2_medicalhistorydataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_medicalhistorydataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_medicalhistorydataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_lifestyledataset
DROP TABLE IF EXISTS bp2_lifestyledataset_fin;

CREATE TABLE bp2_lifestyledataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_lifestyledataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_lifestyledataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_physicalexamdataset
DROP TABLE IF EXISTS bp2_physicalexamdataset_fin;

CREATE TABLE bp2_physicalexamdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_physicalexamdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_physicalexamdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_familyhistorydataset
DROP TABLE IF EXISTS bp2_familyhistorydataset_fin;

CREATE TABLE bp2_familyhistorydataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_familyhistorydataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_familyhistorydataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_bloodtestdataset

DROP TABLE IF EXISTS bp2_bloodtestdataset_tmp;

CREATE TABLE bp2_bloodtestdataset_tmp AS
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id AS curpseudoid,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate) AS curcodedate,
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm) AS curcodeterm,
       @curcode := IF(m.code IS NULL,'x', m.code) AS curcode,
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue) AS curcodevalue,
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit ) AS curcodeunit
FROM  bp2_bloodtestdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit;

ALTER TABLE bp2_bloodtestdataset_tmp ADD INDEX rnk_idx(rnk);

DROP TABLE IF EXISTS bp2_bloodtestdataset_fin;

CREATE TABLE bp2_bloodtestdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM bp2_bloodtestdataset_tmp p
WHERE p.rnk = 1;

ALTER TABLE bp2_bloodtestdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_urinetestdataset
DROP TABLE IF EXISTS bp2_urinetestdataset_fin;

CREATE TABLE bp2_urinetestdataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_urinetestdataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_urinetestdataset_fin ADD INDEX pseudo_idx (pseudo_id);

-- bp2_surgicaldataset
DROP TABLE IF EXISTS bp2_surgicaldataset_fin;

CREATE TABLE bp2_surgicaldataset_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM (
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id ,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate),
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm),
       @curcode := IF(m.code IS NULL,'x', m.code),
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue),
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit )
FROM  bp2_surgicaldataset m, (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit) p
WHERE p.rnk = 1;

ALTER TABLE bp2_surgicaldataset_fin ADD INDEX pseudo_idx (pseudo_id);

*/

-- bp2_medications

  DROP TABLE IF EXISTS bp2_medications_tmp;

  CREATE TABLE bp2_medications_tmp (
   id            INT(11) NOT NULL DEFAULT '0',
   pseudo_id     VARCHAR(255) DEFAULT NULL,
   codedate      VARCHAR(20) DEFAULT NULL,
   codeterm      VARCHAR(100) DEFAULT NULL,
   code          VARCHAR(100) DEFAULT NULL,
   codevalue     VARCHAR(100) DEFAULT NULL,
   codeunit      VARCHAR(100) DEFAULT NULL,
   rnk           BIGINT(21) DEFAULT NULL,
   curpseudoid   VARCHAR(255) DEFAULT NULL,
   curcodedate   VARCHAR(20) DEFAULT NULL,
   curcodeterm   VARCHAR(100) DEFAULT NULL,
   curcode       VARCHAR(100) DEFAULT NULL,
   curcodevalue  VARCHAR(100) DEFAULT NULL,
   curcodeunit   VARCHAR(100) DEFAULT NULL
); 

ALTER TABLE bp2_medications_tmp ADD INDEX rnk_idx(rnk);

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

  CREATE TEMPORARY TABLE qry_tmp (
       row_id         INT,
       pseudo_id      VARCHAR(255), PRIMARY KEY(row_id)
  ) AS
  SELECT (@row_no := @row_no+1) AS row_id,
          f.pseudo_id
  FROM  bp2_medications f, (SELECT @row_no := 0) t
  GROUP BY f.pseudo_id;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

INSERT INTO bp2_medications_tmp
SELECT 
       m.id,
       m.pseudo_id,
       m.codedate,
       m.codeterm,
       m.code,
       m.codevalue,
       m.codeunit,
       @currank := IF(@curpseudoid = m.pseudo_id AND 
       @curcodedate = IF(m.codedate IS NULL, 'x', m.codedate) AND 
       @curcodeterm = IF(m.codeterm IS NULL,'x', m.codeterm) AND 
       @curcode = IF(m.code IS NULL,'x', m.code) AND 
       @curcodevalue = IF(m.codevalue IS NULL,'x', m.codevalue) AND 
       @curcodeunit = IF(m.codeunit IS NULL,'x', m.codeunit )
       , @currank + 1, 1) AS rnk,  
       @curpseudoid := m.pseudo_id AS curpseudoid,
       @curcodedate := IF(m.codedate IS NULL, 'x', m.codedate) AS curcodedate,
       @curcodeterm := IF(m.codeterm IS NULL,'x', m.codeterm) AS curcodeterm,
       @curcode := IF(m.code IS NULL,'x', m.code) AS curcode,
       @curcodevalue := IF(m.codevalue IS NULL,'x', m.codevalue) AS curcodevalue,
       @curcodeunit := IF(m.codeunit IS NULL,'x', m.codeunit ) AS curcodeunit
FROM  bp2_medications m JOIN qry_tmp q ON m.pseudo_id = q.pseudo_id
                        JOIN (SELECT @currank := 0, @curpseudoid := 0, @curcodedate := 0, @curcodeterm := 0, @curcode := 0, @curcodevalue := 0, @curcodeunit := 0) r 
WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000
ORDER BY m.pseudo_id, m.codedate, m.codeterm, m.code, m.codevalue, m.codeunit;

SET @row_id = @row_id + 1000;

END WHILE;

DROP TABLE IF EXISTS bp2_medications_fin;

CREATE TABLE bp2_medications_fin AS
SELECT 
       p.id,
       p.pseudo_id,
       CAST(NULL AS NCHAR(10)) nhsnumber,
       p.codedate,
       p.codeterm,
       p.code,
       p.codevalue,
       p.codeunit,
       p.rnk
FROM bp2_medications_tmp p
WHERE p.rnk = 1;

ALTER TABLE bp2_medications_fin ADD INDEX pseudo_idx (pseudo_id);

-- update demographics

UPDATE bp2_basicdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_diagnosisdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_symptomsdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_medicalhistorydataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_lifestyledataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_physicalexamdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_familyhistorydataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_bloodtestdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_urinetestdataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_surgicaldataset_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;
UPDATE bp2_medications_fin d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.NHSNumber = c.NhsNumber;

ALTER TABLE bp2_basicdataset_fin DROP COLUMN id;
ALTER TABLE bp2_diagnosisdataset_fin DROP COLUMN id;
ALTER TABLE bp2_symptomsdataset_fin DROP COLUMN id;
ALTER TABLE bp2_medicalhistorydataset_fin DROP COLUMN id;
ALTER TABLE bp2_lifestyledataset_fin DROP COLUMN id;
ALTER TABLE bp2_physicalexamdataset_fin DROP COLUMN id;
ALTER TABLE bp2_familyhistorydataset_fin DROP COLUMN id;
ALTER TABLE bp2_bloodtestdataset_fin DROP COLUMN id;
ALTER TABLE bp2_urinetestdataset_fin DROP COLUMN id;
ALTER TABLE bp2_surgicaldataset_fin DROP COLUMN id;
ALTER TABLE bp2_medications_fin DROP COLUMN id;

ALTER TABLE bp2_basicdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_diagnosisdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_symptomsdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_medicalhistorydataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_lifestyledataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_physicalexamdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_familyhistorydataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_bloodtestdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_urinetestdataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_surgicaldataset_fin DROP COLUMN rnk;
ALTER TABLE bp2_medications_fin DROP COLUMN rnk;

DROP TABLE IF EXISTS bp2_genericgrp1dataset_fin;

CREATE TABLE bp2_genericgrp1dataset_fin AS SELECT * FROM bp2_genericgrp1dataset;

DROP TABLE IF EXISTS bp2_genericgrp2dataset_fin;
CREATE TABLE bp2_genericgrp2dataset_fin AS SELECT * FROM bp2_genericgrp2dataset;

ALTER TABLE bp2_genericgrp1dataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_genericgrp2dataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_basicdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_diagnosisdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_symptomsdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_medicalhistorydataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_lifestyledataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_physicalexamdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_familyhistorydataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_bloodtestdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_urinetestdataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_surgicaldataset_fin DROP COLUMN pseudo_id;
ALTER TABLE bp2_medications_fin DROP COLUMN pseudo_id;

DROP TABLE IF EXISTS code_set_codes_bp2;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS snomeds;
DROP TABLE IF EXISTS tpp_ctv3_hierarchy_ref_tmp;
DROP TABLE IF EXISTS read2_codes_tmp;

DROP TEMPORARY TABLE IF EXISTS cohort_bp2_observations;
DROP TEMPORARY TABLE IF EXISTS cohort_bp2_medications;

END//
DELIMITER ;