USE data_extracts;

DROP PROCEDURE IF EXISTS populateglycSnomeds;

DELIMITER //

CREATE PROCEDURE populateglycSnomeds()

BEGIN


  INSERT INTO snomed_codes
    (GROUP_ID, SNOMED_ID, DESCRIPTION)
  VALUES
    (15, 999791000000106, 'glycated haemoglobin');

END
//
DELIMITER ;