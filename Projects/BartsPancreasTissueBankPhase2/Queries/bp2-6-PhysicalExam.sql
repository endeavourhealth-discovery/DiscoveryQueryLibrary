USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas6PhysicalBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas6PhysicalBP2()
BEGIN

CALL populateDatasetBP2('bp2_physicalexamdataset',
  '1675.,2274.,25C%,25F%,25J%,25K%,25L%,25M%,25N%,25R%,2C3%,2C4%,CTV3_X769z,CTV3_X307w,CTV3_X308V,CTV3_XM097%,CTV3_Xa7Vi,CTV3_Xa86n%',
  4,
  '2002-01-01', 
  null,
  0
);

END//
DELIMITER ;
