USE data_extracts;

DROP PROCEDURE IF EXISTS knowDiabetesPatientBulkBatched;

DELIMITER //
CREATE PROCEDURE knowDiabetesPatientBulkBatched()
BEGIN

	/*  
		This procedure loops down 1000 patients at a time that have bulkSent = 0.
        
        This procedure updates after every loop of 1000 so it can be interuppted and only current batch
        of 1000 would need to be processed again when it is restarted. 
        
        Should complete a batch of 1000 in roughly 1 minute so it will take roughly
        
        (number_of_patients_to_bulk / 1000) * 1 minute to process
        
        eg 100,000 patients would take ~ 100 minutes
        
        Follow progress by running the below.  It generates 4 lines per batch of 1000
        select * from data_extracts.bulkProcessingTiming order by event_time asc;
		
    */
    
    DECLARE startTime DATETIME;
    DECLARE endTime DATETIME;
  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;    
    
    -- reset the timing table...comment this out if you want to preserve the timings
	truncate table data_extracts.bulkProcessingTiming;
    
    insert into data_extracts.bulkProcessingTiming
	select now(), null, 'Starting the bulk process', 0;
    
    
	set startTime = (now());
    
    DROP TEMPORARY TABLE IF EXISTS data_extracts.cohort_tmp;
		CREATE TEMPORARY TABLE data_extracts.cohort_tmp (
		 row_id      INT,
		 patientId   BIGINT, PRIMARY KEY(row_id)
		) AS
		SELECT (@row_no := @row_no + 1) AS row_id,
			   coh.patientId
		FROM data_extracts.subscriber_cohort coh, (SELECT @row_no := 0) t
		where coh.isBulked = 0
          and coh.extractId = 1
		GROUP BY coh.patientId;
        
    set endTime = (now());
    
    insert into data_extracts.bulkProcessingTiming
	select now(), null, 'Gathering patients to bulk', TIMESTAMPDIFF(SECOND, startTime, endTime);
    
	set startTime = (now());
    
    SET @row_id = 0;
	   
	   
		  -- process 1000 rows at a time 
		run_batch: WHILE EXISTS (SELECT row_id from data_extracts.cohort_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO


			set startTime = (now());
			  REPLACE INTO data_extracts.filteredPatientsDelta
			  SELECT q.patientId FROM cohort_tmp q WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;
			  
			  set endTime = (now());
    
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Bulk patients', TIMESTAMPDIFF(SECOND, startTime, endTime);
                      
			set startTime = (now());    
    
			REPLACE INTO data_extracts.filteredObservationsDelta
			select distinct
				o.id, 
				o.organization_id
			from data_extracts.cohort_tmp q
			join nwl_subscriber_pid.observation o on o.patient_id = q.patientId
			join data_extracts.codeSetMapped csm on csm.legacy = o.non_core_concept_id
			where csm.codeSetId = 2
			  and q.row_id > @row_id AND q.row_id <= @row_id + 1000;
			
			set endTime = (now());
			
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Bulk observations', TIMESTAMPDIFF(SECOND, startTime, endTime);
            
            set startTime = (now());    
    
			REPLACE INTO data_extracts.filteredAllergiesDelta
			select distinct
				ai.id
			from data_extracts.cohort_tmp q
			join nwl_subscriber_pid.allergy_intolerance ai on ai.patient_id = q.patientId
			where q.row_id > @row_id AND q.row_id <= @row_id + 1000;
			
			set endTime = (now());
			
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Bulk allergies', TIMESTAMPDIFF(SECOND, startTime, endTime);
            
                set startTime = (now());    
    
			REPLACE INTO data_extracts.filteredMedicationsDelta
			select distinct
				ms.id,  
				ms.organization_id
			from data_extracts.cohort_tmp q
			join nwl_subscriber_pid.medication_statement ms on ms.patient_id = q.patientId
			where ms.cancellation_date is null
			  and q.row_id > @row_id AND q.row_id <= @row_id + 1000;
			
			set endTime = (now());
			
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Bulk medications', TIMESTAMPDIFF(SECOND, startTime, endTime);

            -- set the bulk patients to 1 so this can be stopped and started at will
            update data_extracts.subscriber_cohort sc
            join data_extracts.cohort_tmp q on q.patientId = sc.patientId
            set sc.isBulked = 1
            where q.row_id > @row_id AND q.row_id <= @row_id + 1000;
            
            -- set the test patients to 1 so this can be stopped and started at will
            update data_extracts.subscriber_cohort_test_patients sc
            join data_extracts.cohort_tmp q on q.patientId = sc.patientId
            set sc.isBulked = 1
            where q.row_id > @row_id AND q.row_id <= @row_id + 1000;
			
			SET @row_id = @row_id + 1000; 

		END WHILE run_batch;
         
END//
DELIMITER ;