USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas10SurgicalBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas10SurgicalBP2()

BEGIN
-- All since 2012

call populateDatasetBP2(
  'bp2_surgicaldataset',
  '78%,76%,77%,CTV3_760%,CTV3_762%,CTV3_XM0Bp%,CTV3_XM0Bx%,CTV3_780%,CTV3_783%,CTV3_X20bT%,CTV3_782G%,CTV3_Xa1Qs%',
  2,
  null,
  null,
  0
);

END//
DELIMITER ;
