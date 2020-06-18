USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas6PhysicalBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas6PhysicalBP1()
BEGIN

CALL populateDatasetBP1('bp1_physicalexamdataset',
  '1675.,2274.,25C%,25F%,25J%,25K%,25L%,25M%,25N%,25R%,2C3%,2C4%,3397.,246%,',
  4,
  '2012-01-01',
  null,
  0
);

-- added 
-- FEV	3397.
-- Blood pressure	246%

END//
DELIMITER ;
