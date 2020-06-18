USE data_extracts;

DROP PROCEDURE IF EXISTS knowDiabetesCreateCohort;

DELIMITER //
CREATE PROCEDURE knowDiabetesCreateCohort()
BEGIN

	/*  
		This procedure loops down every organisation in our DB and figures out, one org at a time which patients
        fit our criteria for Know Diabetes.  That is having a read code in our code set and being correctly
        registered and over 17.
        
        This procedure must be run to completion for it to work.  If it is stopped prematurely, then it will 
        need to process all the data again next time it runs.
        
        Should complete in roughly 30 - 60 mins
        
        Follow progress by running the below.  It generates 2 lines per org.
        select * from data_extracts.bulkProcessingTiming order by event_time asc;
		
    */

	DECLARE startTime DATETIME;
	DECLARE endTime DATETIME;
	DECLARE orgId BIGINT;
	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;    
    
    -- reset the timing table...comment this out if you want to preserve the timings
	truncate table data_extracts.bulkProcessingTiming;    
    
	DROP TABLE IF EXISTS data_extracts.cohortDelta;  
	
	CREATE TEMPORARY TABLE data_extracts.cohortDelta (
	 patient_id BIGINT
	);
	
    insert into data_extracts.bulkProcessingTiming
	select now(), null, 'Starting the Cohort process', 0;
	
	set startTime = (now()); 
	
    -- get all orgs in our DB
	DROP TEMPORARY TABLE IF EXISTS data_extracts.org_tmp;
	CREATE TEMPORARY TABLE data_extracts.org_tmp (
	 row_id      INT,
	 organization_id   BIGINT, PRIMARY KEY(row_id)
	) AS
	SELECT (@row_no := @row_no + 1) AS row_id,
		   p.organization_id
	FROM nwl_subscriber_pid.patient p, (SELECT @row_no := 0) t
	group by p.organization_id;
	
	set endTime = (now());
		
	insert into data_extracts.bulkProcessingTiming
	select now(), null, 'Cohort get all organisations', TIMESTAMPDIFF(SECOND, startTime, endTime);
	
	SET @row_id = 1;
	   
	   
		  -- process 1 org at a time 
		run_batch: WHILE EXISTS (SELECT row_id from data_extracts.org_tmp WHERE row_id = @row_id ) DO
			
			SET orgId = (SELECT organization_id FROM data_extracts.org_tmp WHERE row_id = @row_id);

			set startTime = (now()); 
    
			-- get all observations for our code set at this organisation
			DROP TABLE IF EXISTS data_extracts.cohortDelta1; 
			CREATE TEMPORARY TABLE data_extracts.cohortDelta1 AS
			SELECT DISTINCT
			   o.patient_id
			FROM nwl_subscriber_pid.observation o
			JOIN data_extracts.codeSetMapped csm on csm.legacy = o.non_core_concept_id and csm.codeSetId = 1
			where o.organization_id = orgId;
			
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, concat('Cohort get all observations for code set for single org : ', orgId), TIMESTAMPDIFF(SECOND, startTime, endTime);
			
			set startTime = (now()); 
	
			-- get all valid registered patients for this org
			insert ignore into data_extracts.cohortDelta
			SELECT DISTINCT 
				   p.id AS patient_id
			FROM nwl_subscriber_pid.patient p 
			JOIN data_extracts.cohortDelta1 o ON p.id = o.patient_id 
			JOIN nwl_subscriber_pid.episode_of_care e ON e.patient_id = p.id 
			JOIN nwl_subscriber_pid.concept eocc ON eocc.dbid = e.registration_type_concept_id 
			WHERE  TIMESTAMPDIFF(YEAR,p.date_of_birth,CURDATE()) > 17
			AND eocc.code = 'R' -- currently registered
			AND p.date_of_death IS NULL 
			AND e.date_registered <= now() 
			AND (e.date_registered_end > now() or e.date_registered_end IS NULL);
			
			
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, concat('Cohort get all valid registered patients for single org : ', orgId), TIMESTAMPDIFF(SECOND, startTime, endTime);
			
	
			SET @row_id = @row_id + 1; 

		END WHILE run_batch;
		
        -- We need to do the inserts and updates to the subscriber_cohort table in one go 
        -- otherwise the needsDelete logic doesn't work
		set startTime = (now()); 		
		
		ALTER TABLE data_extracts.cohortDelta
		ADD INDEX ix_cohort_patient_id (patient_id);
	
		-- add all patients that meet the criteria into the cohort table
		insert ignore into data_extracts.subscriber_cohort
		select 1, patient_id, 0, 0 from cohortDelta;
		
		set endTime = (now());
			
		insert into data_extracts.bulkProcessingTiming
		select now(), null, 'Cohort Inserting all patients into the subscriber_cohort table ', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
		set startTime = (now()); 
		
        -- set needsDelete for any patients that are no longer in the cohort
		update data_extracts.subscriber_cohort sc 
		left outer join cohortDelta d on d.patient_id = sc.patientId and sc.extractId = 1
		set sc.needsDelete = 1 where d.patient_id is null;
		
		
		insert into data_extracts.bulkProcessingTiming
		select now(), null, 'Cohort update the cohort table for patients needing delete ', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
		
		set startTime = (now()); 
        
		-- update the test patients as the above will try to flag the patients as needing a delete
		insert into data_extracts.subscriber_cohort (extractId, patientId, isBulked, needsDelete)
		select t.extractId, t.patientId, t.isBulked, t.needsDelete
		from data_extracts.subscriber_cohort_test_patients t
		where t.extractId = 1 
		on duplicate key update isBulked = t.isBulked, needsDelete = t.needsDelete;
		
		drop table if exists data_extracts.cohortDelta;
		
		
		set endTime = (now());
			
		insert into data_extracts.bulkProcessingTiming
		select now(), null, 'Cohort process test patients ', TIMESTAMPDIFF(SECOND, startTime, endTime);
        
        set startTime = (now()); 
        
		-- insert the needsDelete patients into the deletions table
		replace into data_extracts.filteredDeletionsDelta 
		select distinct
			p.id, 2
		from data_extracts.subscriber_cohort coh
		join nwl_subscriber_pid.patient p on p.id = coh.patientId
		where coh.needsDelete = 1;
        
        -- remove deleted patients from cohort
		delete from data_extracts.subscriber_cohort where needsDelete = 1;
		
		drop table if exists data_extracts.cohortDelta;		
		
		set endTime = (now());
			
		insert into data_extracts.bulkProcessingTiming
		select now(), null, 'Cohort process deducted patients ', TIMESTAMPDIFF(SECOND, startTime, endTime);
        
		insert into data_extracts.bulkProcessingTiming
		select now(), null, 'Cohort generation finished ', 0;
	
	
END//
DELIMITER ;