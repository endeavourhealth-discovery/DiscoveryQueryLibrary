
/* table to hold all the non_core_concept_id's that we are interested in for our queries.  
Saves having to perform this expensive join every time the procs are run.

****  TABLE MUST BE DROPPED AND RECREATED IF THE underlying code sets change at all *****

*/
CREATE TABLE data_extracts.codeSetMapped AS
	SELECT DISTINCT 
           cm.legacy,
           scs.codeSetId
	FROM nwl_subscriber_pid.concept_map cm JOIN nwl_subscriber_pid.concept c ON c.dbid = cm.core
	     JOIN data_extracts.snomed_code_set_codes scs ON scs.snomedCode = c.code;
         
         
ALTER TABLE data_extracts.codeSetMapped ADD INDEX codeSetMapped_idx(legacy, codeSetId);

-- table to hold the progress of the procs...as they are long running you can keep an eye 
-- on the progress and how long each section took...useful for targetting any long running sql in the process
create table data_extracts.bulkProcessingTiming (
event_time datetime,
currentProcessingDate datetime,
description varchar(100),
durationinSeconds int
);

DROP TABLE if exists data_extracts.know_diabetes_report;
CREATE TABLE data_extracts.know_diabetes_report (
 organisation_id BIGINT,
 organisation_ods_code varchar(50),
 organization_name varchar(255),
 total_sent bigint,
 outstanding bigint
);