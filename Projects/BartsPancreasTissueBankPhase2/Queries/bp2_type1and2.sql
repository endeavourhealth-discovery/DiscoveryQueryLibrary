USE data_extracts;

DROP PROCEDURE IF EXISTS executeType12BP2;

DELIMITER //
CREATE PROCEDURE executeType12BP2()
BEGIN

CALL buildDatasetForBartsPancreasBP2();

DROP TABLE IF EXISTS bp2_type1dataset;

CREATE TABLE bp2_type1dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  DEFAULT NULL,
   codedate             VARCHAR(20)  DEFAULT NULL,
   codeterm             VARCHAR(100) DEFAULT NULL,
   code                 VARCHAR(100) DEFAULT NULL,
   codevalue            VARCHAR(100) DEFAULT NULL,
   codeunit             VARCHAR(100) DEFAULT NULL
);

ALTER TABLE bp2_type1dataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_type1dataset ADD INDEX type1pseudoIdx (pseudo_id);

DROP TABLE IF EXISTS bp2_type2dataset;

CREATE TABLE bp2_type2dataset (
   pseudo_id            VARCHAR(255) DEFAULT NULL,
   nhsnumber            VARCHAR(10)  DEFAULT NULL,
   codedate             VARCHAR(20)  DEFAULT NULL,
   codeterm             VARCHAR(100) DEFAULT NULL,
   code                 VARCHAR(100) DEFAULT NULL,
   codevalue            VARCHAR(100) DEFAULT NULL,
   codeunit             VARCHAR(100) DEFAULT NULL
);

ALTER TABLE bp2_type2dataset ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE bp2_type2dataset ADD INDEX type2pseudoIdx (pseudo_id);

CALL populateDatasetBP2('bp2_type1dataset', '9Nu0.,9Nu1.,CTV3_XaZ89,CTV3_XaZ8a', 0, null, null, 0);
CALL populateDatasetBP2('bp2_type2dataset', '9Nu4.,9Nu5.,CTV3_XaaVL,CTV3_XaaVM', 0, null, null, 0);

DELETE t1 FROM bp2_type1dataset t1 JOIN bp2_type1dataset t2
WHERE t1.id < t2.id AND t1.pseudo_id = t2.pseudo_id
  AND t1.codedate = t2.codedate
  AND t1.codeterm = t2.codeterm
  AND t1.code = t2.code
  AND t1.codevalue = t2.codevalue
  AND t1.codeunit = t2.codeunit;

UPDATE bp2_type1dataset d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.nhsnumber = c.NhsNumber;
ALTER TABLE bp2_type1dataset DROP COLUMN id;
ALTER TABLE bp2_type1dataset DROP COLUMN pseudo_id;

DELETE t1 FROM bp2_type2dataset t1 JOIN bp2_type2dataset t2
WHERE t1.id < t2.id AND t1.pseudo_id = t2.pseudo_id
  AND t1.codedate = t2.codedate
  AND t1.codeterm = t2.codeterm
  AND t1.code = t2.code
  AND t1.codevalue = t2.codevalue
  AND t1.codeunit = t2.codeunit;

UPDATE bp2_type2dataset d JOIN cohort_bp2 c ON c.group_by = d.pseudo_id SET d.nhsnumber = c.NhsNumber;
ALTER TABLE bp2_type2dataset DROP COLUMN id;
ALTER TABLE bp2_type2dataset DROP COLUMN pseudo_id;

END//
DELIMITER ;