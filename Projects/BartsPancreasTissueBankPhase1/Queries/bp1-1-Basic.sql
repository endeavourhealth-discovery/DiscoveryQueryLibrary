USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas1BasicBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas1BasicBP1()
BEGIN

-- earliest
CALL populateDatasetBP1('bp1_basicdataset','9155.,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','915B.,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','1K%,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','134%,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','9S%,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','94E..,',0,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','94B..,',0,null,null,0);

-- latest
CALL populateDatasetBP1('bp1_basicdataset','134%,',1,null,null,0);
CALL populateDatasetBP1('bp1_basicdataset','9S%,',1,null,null,0);

-- Since 2010
CALL populateDatasetBP1('bp1_basicdataset','229..,',4,'2010-01-01',null,0);
CALL populateDatasetBP1('bp1_basicdataset','22A..,',4,'2010-01-01',null,0);
CALL populateDatasetBP1('bp1_basicdataset','22K%,',4,'2010-01-01','22K9%,22KA.,22KB.,',0);

END//
DELIMITER ;
