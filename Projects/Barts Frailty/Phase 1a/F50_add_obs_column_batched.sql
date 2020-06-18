-- ----------------------------------------------------------------
-- Procedure to batch up the addition of avious codes to a cohort v2.0
-- Version 2.0 is extensible to allow selection of input cohorts and input obs tables
-- ----------------------------------------------------------------

-- ASSUMPTIONS:
-- 1. Output is written to temporary table 'obs_out'

-- INPUTS:
-- 1. batch_size - the number of records processed at a time (1-2k seems to work best)
-- 2. mixed_code - a string containing comma-separated list of SNOMED CODES ONLY (for now)
-- 3. input_cohort - a table containing all the patients of interest
-- 4. input_observations - a table containing all the observations of interest (as generate by f50_get_all_obs_on_cohort)

-- OUTPUTS:
-- 1. A temporary table 'F50_obs_out_tmp' with one row per matched observation (patient_id; snomed_concept_id; clinical_effective_date)

use data_extracts;
drop procedure if exists F50_add_obs_column_batched;

DELIMITER //
create procedure F50_add_obs_column_batched
(
    in batch_size int,				-- number of rows to be processed at a time
    in mixed_codes varchar (5000),	-- the codes to be used (snomeds for now)
    in input_cohort varchar (32), -- table name of input cohort
    in input_observations varchar (32) -- table name of input observations table
)

BEGIN
	-- declare and initialise variables
	DECLARE row_offset int;
    DECLARE counter int;
    SET row_offset = 0;
    SET counter = 0;

    -- initialise output dataset
    drop table if exists obs_out;
    create temporary table obs_out
			(
			person_id bigint(20),
            patient_id bigint(20),
            organization_id bigint(20),
            snomed_concept_id bigint(20),
            clinical_effective_date date
            );

	-- extract total number of records
    SET @statement = CONCAT('select count(patient_id) from ',input_cohort,' into @T');
    PREPARE STATEMENT FROM @statement;
	EXECUTE STATEMENT;

    -- prepare SQL code to insert specified codes into output table
	SET @statement = CONCAT(
	'insert into obs_out
	select ch.person_id
    ,	ch.patient_id
    ,	ch.organization_id
	,	obs_incl.snomed_concept_id
	,	obs_incl.clinical_effective_date

	from batch as ch

	inner join ',input_observations,' as obs_incl
		on ch.person_id = obs_incl.person_id
        and ch.patient_id = obs_incl.patient_id
		and obs_incl.snomed_concept_id in (',mixed_codes,')
	;'
	);

    WHILE row_offset < @T DO

        -- select another "batch_size" from the sample
        SET @batchmaker = CONCAT('drop table if exists batch;');
        PREPARE statement FROM @batchmaker; EXECUTE statement;

        SET @batchmaker = CONCAT('create temporary table batch as select person_id, organization_id, patient_id
        from ',input_cohort,' limit ', row_offset,',',batch_size,';');
        PREPARE statement FROM @batchmaker; EXECUTE statement;

        SET @batchmaker = CONCAT('alter table batch add index (patient_id);');
        PREPARE statement FROM @batchmaker; EXECUTE statement;

        -- run prepared SQL statement
		PREPARE statement FROM @statement;
        EXECUTE statement;

        -- increment how many you have done
        SET row_offset = row_offset + batch_size;
        SET counter = counter + batch_size;

        -- output a running counter (for debugging/timing)
        IF counter >= 25000 THEN
			-- select row_offset; -- output the completed rows so far
            set counter = counter - 25000; -- reset the counter and start again!
		END IF;
   END WHILE;

    -- add index to final table
    alter table obs_out add index (snomed_concept_id);
	alter table obs_out add index (patient_id);

    -- write out to persistent table
    drop table if exists F50_obs_out_tmp;
	create temporary table F50_obs_out_tmp as select * from obs_out;
	alter table F50_obs_out_tmp add index (patient_id);
    alter table F50_obs_out_tmp add index (person_id);
    alter table F50_obs_out_tmp add index (snomed_concept_id);

    -- drop the temporary tables to free up memory
    drop table if exists obs_out;
    drop table if exists batch;

END;

// DELIMITER ;
