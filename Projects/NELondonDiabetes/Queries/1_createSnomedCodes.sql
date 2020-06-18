USE data_extracts;

DROP PROCEDURE IF EXISTS createSnomedCodes;

DELIMITER //

CREATE PROCEDURE createSnomedCodes()

BEGIN

DROP TABLE IF EXISTS snomed_codes;

CREATE TABLE snomed_codes (
   group_id     INT(10),
   snomed_id    BIGINT(20),
   description  VARCHAR(400)
);

ALTER TABLE snomed_codes ADD INDEX idx_snomed_grp (group_id);
ALTER TABLE snomed_codes ADD INDEX idx_snomed_id (snomed_id);

END//
DELIMITER ;