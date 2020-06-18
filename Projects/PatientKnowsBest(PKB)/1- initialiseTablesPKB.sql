use data_extracts;

drop procedure if exists initialiseTablesPKB;

DELIMITER //
CREATE PROCEDURE initialiseTablesPKB()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	create table if not exists data_extracts.subscriber_extracts (
		extractId int not null primary key,
        extractName varchar(100) not null,
        transactionDate datetime(3) null,
        cohortCodeSetId int null,
        observationCodeSetId int null
	);
    
	insert ignore into data_extracts.subscriber_extracts
	select 2, 'Patient Knows Best', date_sub(now(), interval 50 year), null, null;
    
    drop table if exists data_extracts.currentEventLogDate;
    
    create table data_extracts.currentEventLogDate as
    select max(dt_change) as dt_change from nwl_subscriber_pid.event_log;
    
    create table if not exists data_extracts.subscriber_cohort (
		extractId int not null,
        patientId bigint not null,
        isBulked boolean,
        needsDelete boolean,
        
        primary key pk_extract_patient (extractId, patientId),
        index ix_cohort_patientId (patientId),
        index ix_cohort_patientId_bulked (patientId, isBulked)
    );
    
    create table if not exists data_extracts.pkbPatients (
		id bigint(20) primary key
    );
    
    create table if not exists data_extracts.pkbDeletions (
		record_id bigint(20) primary key,
        table_id tinyint(4)
    );
    
    /*  Not needed for phase 1
	create table if not exists data_extracts.snomed_code_set (
		codeSetId int not null,
		codeSetName varchar(200) not null
	);

	create table if not exists data_extracts.snomed_code_set_codes (
		codeSetId int not null,
		snomedCode bigint not null,
        
        primary key pk_codes_codeset_code (codeSetId, snomedCode)
	);
    
    create table if not exists data_extracts.pkbObservations (
		id bigint(20) primary key,
        `organization_id` bigint(20) DEFAULT NULL,
        KEY `ix_filtered_obs_organization` (`organization_id`)
    );
    
    create table if not exists data_extracts.pkbAllergies (
		id bigint(20) primary key
    );
    
    create table if not exists data_extracts.pkbMedications (
		id bigint(20) primary key
    );
    
    */

END//
DELIMITER ;