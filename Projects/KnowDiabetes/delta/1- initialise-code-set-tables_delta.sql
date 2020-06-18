use data_extracts;

drop procedure if exists initialiseSnomedCodeSetTablesDelta;

DELIMITER //
CREATE PROCEDURE initialiseSnomedCodeSetTablesDelta()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	create table if not exists data_extracts.subscriber_cohort_test_patients (
		extractId int not null,
        patientId bigint not null,
        isBulked boolean,
        needsDelete boolean,
        
        primary key pk_extract_patient (extractId, patientId),
        index ix_cohort_patientId (patientId),
        index ix_cohort_patientId_bulked (patientId, isBulked)
	);

	create table if not exists data_extracts.subscriber_extracts (
		extractId int not null primary key,
        extractName varchar(100) not null,
        transactionDate datetime(3) null,
        cohortCodeSetId int null,
        observationCodeSetId int null
	);
    
	insert ignore into data_extracts.subscriber_extracts
	select 1, 'Know Diabetes', date_sub(now(), interval 50 year), 1, 2;
    
    drop table if exists data_extracts.currentEventLogDate;
    
    create table data_extracts.currentEventLogDate as
    select max(dt_change) as dt_change from nwl_subscriber_pid.event_log;
	
    -- set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    -- set @days_worth_of_data = (select date_add(@current_event_log_date, interval 2 hour));
    -- set @max_event_log_date = (select max(dt_change) as dt_change from nwl_subscriber_pid.event_log);
    -- if (@days_worth_of_data > @max_event_log_date) then
	-- set @days_worth_of_data = @max_event_log_date;
	-- end if;    
    -- create table data_extracts.currentEventLogDate as
    -- select @days_worth_of_data as dt_change;
    
    create table if not exists data_extracts.subscriber_cohort (
		extractId int not null,
        patientId bigint not null,
        isBulked boolean,
        needsDelete boolean,
        
        primary key pk_extract_patient (extractId, patientId),
        index ix_cohort_patientId (patientId),
        index ix_cohort_patientId_bulked (patientId, isBulked)
    );
    
    -- alter table data_extracts.subscriber_cohort
    -- add index ix_cohort_patientId (patientId);
    
    -- alter table data_extracts.subscriber_cohort
    -- add index ix_cohort_patientId_bulked (patientId, isBulked);

	create table if not exists data_extracts.snomed_code_set (
		codeSetId int not null,
		codeSetName varchar(200) not null
	);

	create table if not exists data_extracts.snomed_code_set_codes (
		codeSetId int not null,
		snomedCode bigint not null,
        
        primary key pk_codes_codeset_code (codeSetId, snomedCode)
	);
    
    create table if not exists data_extracts.filteredPatientsDelta (
		id bigint(20) primary key
    );
    
    create table if not exists data_extracts.filteredObservationsDelta (
		id bigint(20) primary key,
        `organization_id` bigint(20) DEFAULT NULL,
        KEY `ix_filtered_obs_organization` (`organization_id`)
    );
    
    create table if not exists data_extracts.filteredAllergiesDelta (
		id bigint(20) primary key
    );
    
    create table if not exists data_extracts.filteredMedicationsDelta (
		id bigint(20) primary key,
		`organization_id` bigint(20) DEFAULT NULL,
        KEY `ix_filtered_rx_organization` (`organization_id`)
    );
    
    create table if not exists data_extracts.filteredDeletionsDelta (
		record_id bigint(20) primary key,
        table_id tinyint(4)
    );

END//
DELIMITER ;



