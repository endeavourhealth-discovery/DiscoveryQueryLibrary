USE data_extracts;

DROP PROCEDURE IF EXISTS populateBPSnomeds;

DELIMITER //

CREATE PROCEDURE populateBPSnomeds()

BEGIN


  INSERT INTO snomed_codes
    (GROUP_ID, SNOMED_ID, DESCRIPTION)
  VALUES
    (14, 72313002, 'Systolic BP reading'),
    (14, 1091811000000102, 'Diastolic BP reading');

END
//
DELIMITER ;