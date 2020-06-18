use data_extracts;

drop procedure if exists executeBartsPancreas7Family;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas7Family ()
BEGIN

-- earliest

call populateDataset('dataset_p_7', '1252%,', 0, null, null, 0);
call populateDataset('dataset_p_7', '1253.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '1228.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '12E%,', 0, null, null, 0);
call populateDataset('dataset_p_7', '124%,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122B%,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122F.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122G.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122K.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122L.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122M.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122N.,', 0, null, null, 0);
call populateDataset('dataset_p_7', '122P.,', 0, null, null, 0);

-- latest

call populateDataset('dataset_p_7', '1252%,', 1, null, null, 0);
call populateDataset('dataset_p_7', '1253.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '1228.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '12E%,', 1, null, null, 0);
call populateDataset('dataset_p_7', '124%,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122B%,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122F.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122G.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122K.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122L.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122M.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122N.,', 1, null, null, 0);
call populateDataset('dataset_p_7', '122P.,', 1, null, null, 0);

END//
DELIMITER ;
