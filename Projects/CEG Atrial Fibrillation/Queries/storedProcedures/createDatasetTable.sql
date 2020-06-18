drop procedure if exists createDatasetTable;

DELIMITER //
CREATE PROCEDURE createDatasetTable ()
BEGIN

drop table if exists dataset;
create table dataset (
	observation_id bigint(20),
	patient_id bigint(20),
	clinical_effective_date date,
	date_precision_id smallint(6),
	practitioner_id bigint(20),
	organization_id bigint(20),
	original_code varchar(20),
	original_term varchar(1000),
	result_value double,
	result_value_units varchar(50),
	medication_statement_id bigint(20)
);

 END//
DELIMITER ;
