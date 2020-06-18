use data_extracts;

drop procedure if exists getKnowDiabetesMedicationsDelta;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesMedicationsDelta()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date =  (select dt_change from data_extracts.currentEventLogDate);
    
	replace into filteredMedicationsDelta
		select distinct
			ms.id, ms.organization_id
		from data_extracts.subscriber_cohort coh
		join nwl_subscriber_pid.medication_statement ms on ms.patient_id = coh.patientId
		
        -- join (select record_id 
		-- from nwl_subscriber_pid.event_log e 
        -- where e.table_id = 10
        -- and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
        -- group by record_id) log on log.record_id = ms.id
		
		join (select distinct(record_id)
			from nwl_subscriber_pid.event_log e
			where e.table_id = 10
			and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
		) log on log.record_id = ms.id
        
		where ms.cancellation_date is null
        and coh.isBulked = 1
        
        union
        
        select distinct
			ms.id,  ms.organization_id
		from data_extracts.subscriber_cohort coh
		join nwl_subscriber_pid.medication_statement ms on ms.patient_id = coh.patientId
        where ms.cancellation_date is null
        and coh.isBulked = 0;
         
END//
DELIMITER ;