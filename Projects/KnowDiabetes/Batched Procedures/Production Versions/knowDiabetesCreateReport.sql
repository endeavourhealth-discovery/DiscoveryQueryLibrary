USE data_extracts;

DROP PROCEDURE IF EXISTS knowDiabetesCreateReport;

DELIMITER //
CREATE PROCEDURE knowDiabetesCreateReport()
BEGIN

	/*  
		This procedure loops down every organisation in our DB and figures out, one org at a time how
        many patients we have sent and how many patients are outstanding for each organisation.
        
        This procedure must be run to completion for it to work.  If it is stopped prematurely, then it will 
        need to process all the data again next time it runs.
        
        It only counts patients as the observation counts are horribly expensive.  Could be amended down the line if 
        required.
        
        Should complete in roughly 2.5 mins
        
        Follow progress by running the below.  It generates 2 lines per org.
        select * from data_extracts.bulkProcessingTiming order by event_time asc;
		
    */

	DECLARE startTime DATETIME;
	DECLARE endTime DATETIME;
	DECLARE orgId BIGINT;
    DECLARE orgOutStandingCount bigint;
    DECLARE orgProcessedCount bigint;
    DECLARE orgOds varchar(50);
    DECLARE orgName varchar(255);
	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;    
    
    -- reset the timing table...comment this out if you want to preserve the timings
	truncate table data_extracts.bulkProcessingTiming; 
    
    truncate table data_extracts.know_diabetes_report;
	
    insert into data_extracts.bulkProcessingTiming
	select now(), null, 'Starting the report process', 0;
	
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
	select now(), null, 'Report get all organisations', TIMESTAMPDIFF(SECOND, startTime, endTime);
	
	SET @row_id = 1;
	   
	   
		  -- process 1 org at a time 
		run_batch: WHILE EXISTS (SELECT row_id from data_extracts.org_tmp WHERE row_id = @row_id ) DO
			
            set orgOutStandingCount = 0;
            set orgProcessedCount = 0;
            set orgOds = '?';
            set orgName = '?';
            
			SET orgId = (SELECT organization_id FROM data_extracts.org_tmp WHERE row_id = @row_id);
            
			select IFNULL(ods_code, '?'), IFNULL(name, '?') into orgOds, orgName 
            from nwl_subscriber_pid.organization where id = orgId;
            
            set orgProcessedCount = orgProcessedCount + 
            (select count(*) 
            from nwl_subscriber_pid.patient p
            join data_extracts.references r on r.an_id = p.id
            where p.organization_id = orgId
              and r.resource = 'Patient');
              
             
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating processed patient resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			/*
			set startTime = (now()); 
            
			set orgProcessedCount = orgProcessedCount + 
            (select count(*) 
            from nwl_subscriber_pid.allergy_intolerance a
            join data_extracts.references r on r.an_id = a.id
            where a.organization_id = orgId
              and r.resource = 'AllergyIntolerance');
    
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating processed allergy resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			set startTime = (now()); 
            
			set orgProcessedCount = orgProcessedCount + 
            (select count(*) 
            from nwl_subscriber_pid.observation o
            join data_extracts.references r on r.an_id = o.id
            where o.organization_id = orgId
              and r.resource = 'Observation');
    
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating processed observation resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			set startTime = (now()); 
            
			set orgProcessedCount = orgProcessedCount + 
            (select count(*) 
            from nwl_subscriber_pid.medication_statement ms
            join data_extracts.references r on r.an_id = ms.id
            where ms.organization_id = orgId
              and r.resource = 'MedicationStatement');
    
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating processed medication resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
            
            */
			set startTime = (now()); 
            
            set orgOutStandingCount = orgOutStandingCount + 
            (select count(*) 
            from nwl_subscriber_pid.patient p
            join data_extracts.filteredPatientsDelta d on d.id = p.id
            where p.organization_id = orgId);
              
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating outstanding patient resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			/*
			set startTime = (now()); 
            
            set orgOutStandingCount = orgOutStandingCount + 
            (select count(*) 
            from nwl_subscriber_pid.patient p
            join data_extracts.filteredAllergiesDelta d on d.id = p.id
            where p.organization_id = orgId);
              
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating outstanding allergy resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			
			set startTime = (now()); 
            
            set orgOutStandingCount = orgOutStandingCount + 
            (select count(*) 
            from nwl_subscriber_pid.patient p
            join data_extracts.filteredObservationsDelta d on d.id = p.id
            where p.organization_id = orgId);
              
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating outstanding observation resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
		
			
			set startTime = (now()); 
            
            set orgOutStandingCount = orgOutStandingCount + 
            (select count(*) 
            from nwl_subscriber_pid.patient p
            join data_extracts.filteredMedicationsDelta d on d.id = p.id
            where p.organization_id = orgId);
              
			set endTime = (now());
				
			insert into data_extracts.bulkProcessingTiming
			select now(), null, 'Report calculating outstanding medication resources', TIMESTAMPDIFF(SECOND, startTime, endTime);
			*/

			insert into data_extracts.know_diabetes_report
            select orgId, orgOds, orgName, orgProcessedCount, orgOutstandingCount; 
			
			SET @row_id = @row_id + 1; 

		END WHILE run_batch;	
        
        insert into data_extracts.bulkProcessingTiming 
		select now(), null, 'Report finished', 0;
	
END//
DELIMITER ;