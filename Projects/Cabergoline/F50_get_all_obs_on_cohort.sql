-- ----------------------------------------------------------------
-- Procedure to batch up the addition of avious codes to a cohort
-- ----------------------------------------------------------------

-- ASSUMPTIONS:
-- 1. Input data is in a table 'cohort' which contains unique patient_id
-- 2. Output is written to temporary table 'obs_out'

-- INPUTS:
-- 1. batch_size - the number of records processed at a time (1-2k seems to work best)
-- 2. mixed_code - a string containing comma-separated list of SNOMED CODES ONLY (for now)

-- OUTPUTS:
-- 1. A temporary table 'obs_out' with one row per matched observation (patient_id; snomed_concept_id; clinical_effective_date)

use data_extracts;
drop procedure if exists F50_get_all_obs_on_cohort;

DELIMITER //
create procedure F50_get_all_obs_on_cohort
(
	-- ASSUMES: Input file contains patient_id and person_id
    in batch_size int,				-- number of rows to be processed at a time
    in in_file varchar(255),	-- the source file containing the cohort data which must contain: org_id, person_id, patient_id
    in out_file varchar (255)	-- the location of the output file
)

BEGIN
	-- declare and initialise variables
	DECLARE row_offset int;
    DECLARE counter int;
    SET row_offset = 0;
    SET counter = 0;

    -- initialise output dataset
	SET @statement = CONCAT('drop table if exists ',out_file,';');
    PREPARE statement FROM @statement;
	EXECUTE statement;

    SET @statement = CONCAT('create table ',out_file,' (
			id bigint(20),
            patient_id bigint(20),
            person_id bigint(20),
            organization_id bigint(20),
            snomed_concept_id bigint(20),
            original_code varchar(20),
            original_term varchar(1000),
            clinical_effective_date date,
            is_problem tinyint(1),
            primary key (person_id, id),
            index (patient_id),
            index(snomed_concept_id),
            index(organization_id)
            );');
	PREPARE statement FROM @statement;
	EXECUTE statement;

	-- extract total number of records
	SET @T = (select count(person_id) from cohort);

    -- prepare SQL code to insert observations into output table
	SET @statement = CONCAT(
	'insert into ',out_file,'
	select obs_incl.id
    , 	obs_incl.patient_id
    ,	ch.person_id
    ,	obs_incl.organization_id
	,	obs_incl.snomed_concept_id
    ,	obs_incl.original_code
    ,	obs_incl.original_term
	,	obs_incl.clinical_effective_date
	,	obs_incl.is_problem

	from batch as ch

	inner join ceg_compass_data.observation as obs_incl
		on ch.person_id = obs_incl.person_id
        and ch.patient_id = obs_incl.patient_id
        and ch.organization_id = obs_incl.organization_id;'
	);

    WHILE row_offset < @T DO

        -- select another "batch_size" from the sample
        drop table if exists batch;
        create temporary table batch as
        select person_id, patient_id, organization_id
        from cohort limit row_offset, batch_size;

		-- run prepared SQL statement
		PREPARE statement FROM @statement;
        EXECUTE statement;

        -- increment how many you have done
        SET row_offset = row_offset + batch_size;
        SET counter = counter + batch_size;

        -- output a running counter (updates every 20k)
        IF counter >= 10000 THEN
			select row_offset; -- output the completed rows so far
            set counter = counter - 10000; -- reset the counter and start again!
		END IF;
   END WHILE;

	select 'All obs - COMPLETE';

    -- drop the temporary tables to free up memory
    drop table if exists batch;

END;

// DELIMITER ;
