USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas7FamilyBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas7FamilyBP2()
BEGIN

-- earliest

CALL populateDatasetBP2('bp2_familyhistorydataset', '1252%,CTV3_1252%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '1253.', 0, null, null, 0);
-- CALL populateDatasetBP2('bp2_familyhistorydataset', '1228.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '12E%,CTV3_12E%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '124%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '122%,CTV3_122%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', 'CTV3_XaKYz', 0, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', 'CTV3_XE0o4%', 0, null, null, 0);



-- latest

CALL populateDatasetBP2('bp2_familyhistorydataset', '1252%,CTV3_1252%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '1253.', 1, null, null, 0);
-- CALL populateDatasetBP2('bp2_familyhistorydataset', '1228.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '12E%,CTV3_12E%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '124%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', '122%,CTV3_122%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', 'CTV3_XaKYz', 1, null, null, 0);
CALL populateDatasetBP2('bp2_familyhistorydataset', 'CTV3_XE0o4%', 1, null, null, 0);



END//
DELIMITER ;
