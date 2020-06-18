USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas7FamilyBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas7FamilyBP1()
BEGIN

-- earliest

CALL populateDatasetBP1('bp1_familyhistorydataset', '1252%,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '1253.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '1228.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '12E%,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '124%,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122B%,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122F.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122G.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122K.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122L.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122M.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122N.,', 0, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122P.,', 0, null, null, 0);

-- latest

CALL populateDatasetBP1('bp1_familyhistorydataset', '1252%,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '1253.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '1228.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '12E%,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '124%,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122B%,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122F.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122G.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122K.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122L.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122M.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122N.,', 1, null, null, 0);
CALL populateDatasetBP1('bp1_familyhistorydataset', '122P.,', 1, null, null, 0);

END//
DELIMITER ;
