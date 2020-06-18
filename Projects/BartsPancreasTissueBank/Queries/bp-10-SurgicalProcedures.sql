use data_extracts;

drop procedure if exists executeBartsPancreas10Surgical;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas10Surgical ()
BEGIN
-- All since 2012

call populateDataset(
  'dataset_p_10',
  '78%,76%,77%,',
  2,
  null,
  null,
  0
);

END//
DELIMITER ;
