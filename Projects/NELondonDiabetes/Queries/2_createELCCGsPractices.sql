USE data_extracts;

DROP PROCEDURE IF EXISTS createELCCGsPractices;

DELIMITER //

CREATE PROCEDURE createELCCGsPractices()

BEGIN

DROP TABLE IF EXISTS elccg_codes;

CREATE TABLE elccg_codes (
   name             VARCHAR(100),      
   local_id         VARCHAR(50),
   parent           VARCHAR(200),
   publisher_config VARCHAR(100)
);

ALTER TABLE elccg_codes ADD INDEX idx_local_id (local_id);

END//
DELIMITER ;