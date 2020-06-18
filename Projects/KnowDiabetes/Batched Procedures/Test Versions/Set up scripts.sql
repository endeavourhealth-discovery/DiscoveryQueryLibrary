
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


/*  These are all just copies of the existing tables for testing purposes */
create table data_extracts.filteredPatientsDeltaTest
as select * from data_extracts.filteredPatientsDelta where id = 456446;

select * from filteredObservationsDeltaTest;
create table data_extracts.filteredObservationsDeltaTest
as select * from data_extracts.filteredObservationsDelta where id = 45644634;

alter table filteredObservationsDeltaTest add column organization_id bigint;

create table data_extracts.filteredAllergiesDeltaTest
as select * from data_extracts.filteredAllergiesDelta where id = 456446;


create table data_extracts.filteredMedicationsDeltaTest
as select * from data_extracts.filteredMedicationsDelta where id = 45644634;


alter table filteredMedicationsDeltaTest add column organization_id bigint;


create table data_extracts.filteredDeletionsDeltaTest
as select * from data_extracts.filteredDeletionsDelta where record_id = 45644634;

create table data_extracts.subscriber_extracts_test
as select * from data_extracts.subscriber_extracts where id = 456446;
