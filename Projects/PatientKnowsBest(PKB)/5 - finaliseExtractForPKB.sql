use data_extracts;

drop procedure if exists finaliseExtractForPKB;

DELIMITER //
CREATE PROCEDURE finaliseExtractForPKB()
BEGIN	
    
    update data_extracts.subscriber_extracts 
    set transactionDate = (select dt_change from currentEventLogDate) 
    where extractId = 2;
    
    update data_extracts.subscriber_cohort
    set isBulked = 1
    where extractId = 2;
         
END//
DELIMITER ;