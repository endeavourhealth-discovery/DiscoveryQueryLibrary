USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas10SurgicalBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas10SurgicalBP1()
BEGIN
-- All since 2012

CALL populateDatasetBP1('bp1_surgicaldataset','78%,76%,77%,',2,null,null,0);

END//
DELIMITER ;
