use data_extracts;

drop procedure if exists executeBartsPancreas1Basic;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas1Basic ()
BEGIN

-- earliest
call populateDataset('dataset_p_1', '9155.,', 0, null, null, 0);
call populateDataset('dataset_p_1', '915B.,', 0, null, null, 0);
call populateDataset('dataset_p_1', '1K%,', 0, null, null, 0);
call populateDataset('dataset_p_1', '134%,', 0, null, null, 0);
call populateDataset('dataset_p_1', '9S%,', 0, null, null, 0);
call populateDataset('dataset_p_1', '94E..,', 0, null, null, 0);
call populateDataset('dataset_p_1', '94B..,', 0, null, null, 0);

-- Since 2010
call populateDataset(
  'dataset_p_1',
  '229..,',
  4,
  '2010-01-01',
  null,
  0
);
call populateDataset(
  'dataset_p_1',
  '22A..,',
  4,
  '2010-01-01',
  null,
  0
);
call populateDataset(
  'dataset_p_1',
  '22K%,',
  4,
  '2010-01-01',
  '22K9%,22KA.,22KB.,',
  0
);

END//
DELIMITER ;
