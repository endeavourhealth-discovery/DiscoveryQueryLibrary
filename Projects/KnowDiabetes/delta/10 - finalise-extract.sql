use data_extracts;

drop procedure if exists finaliseExtract;

DELIMITER //
CREATE PROCEDURE finaliseExtract()
BEGIN	
    
    update data_extracts.subscriber_extracts 
    set transactionDate = (select dt_change from currentEventLogDate) 
    where extractId = 1;
    
    update data_extracts.subscriber_cohort
    set isBulked = 1
    where extractId = 1;
	
	-- update the test patients that have been bulked so they move into transactional mode
	update data_extracts.subscriber_cohort_test_patients
    set isBulked = 1
    where extractId = 1;
END//
DELIMITER ;