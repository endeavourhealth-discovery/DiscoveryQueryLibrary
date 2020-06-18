use data_extracts;
drop procedure if exists F50_join_to_observation;

DELIMITER //
create procedure F50_join_to_observation
(
    -- in code_set_name varchar(255),	-- name of the codeset
    in mixed_codes varchar (5000),	-- the codes to be used (snomeds for now)
    in this_column_name varchar (20), -- the column to add
    in table_to_modify varchar (20) -- the table to add this info to)
)

BEGIN

SET @min_column_name = CONCAT(this_column_name,'_earliest');
SET @max_column_name = CONCAT(this_column_name,'_latest');
SET @count_column_name = CONCAT(this_column_name,'_count');
SET @mixed_codes = mixed_codes;
SET @table_to_modify = table_to_modify;

-- print our what obs we're working on
select CONCAT(this_column_name,' - RUNNING...') as status_update;

-- ------------------------------------------------------
-- batch up and run to get the observations
-- ------------------------------------------------------

call F50_add_obs_column_batched
		(
			-- batch size
            2500
            -- codes
		,	@mixed_codes
		);

-- ------------------------------------------------------
-- Join latest set of observations to cohort
-- ------------------------------------------------------

SET @statement = 'drop table if exists latest_observations;';
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = CONCAT('create temporary table latest_observations as
select a.patient_id
,	min(obs.clinical_effective_date) as ',@min_column_name,'
,   max(obs.clinical_effective_date) as ',@max_column_name,'
,	count(obs.clinical_effective_date) as ',@count_column_name,'
from cohort as a
left join F50_obs_out_tmp as obs
	on a.patient_id = obs.patient_id
group by patient_id;');
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = 'alter table latest_observations add index (patient_id);';
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

-- ------------------------------------------------------
-- Add to observations master table
-- ------------------------------------------------------

SET @statement = CONCAT('drop table if exists ',table_to_modify,';');
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = CONCAT('create table ',table_to_modify,' as
select a.*
,	b.',@min_column_name,'
, 	b.',@max_column_name,'
from F50_cab_observations_temp  as a
left outer join latest_observations as b
	on a.patient_id = b.patient_id;');
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = CONCAT('alter table ',table_to_modify,' add index (patient_id);');
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

-- ------------------------------------------------------
-- update temp table
-- ------------------------------------------------------

SET @statement = 'drop table if exists F50_cab_observations_temp;';
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = CONCAT('create table F50_cab_observations_temp as select * from ',table_to_modify,';');
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;

SET @statement = 'alter table F50_cab_observations_temp add index (patient_id);';
PREPARE STATEMENT FROM @statement; EXECUTE STATEMENT;


-- ------------------------------------------------------
-- print completion message
-- ------------------------------------------------------
-- select CONCAT(this_column_name,' - COMPLETE') as status_update;

END
// DELIMITER ;
