use data_extracts;

drop procedure if exists executeBartsPancreas6Physical;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas6Physical ()
BEGIN

call populateDataset('dataset_p_6',
  '1675.,2274.,25C%,25F%,25J%,25K%,25L%,25M%,25N%,25R%,2C3%,2C4%,',
  4,
  '2012-01-01',
  null,
  0
);

END//
DELIMITER ;
