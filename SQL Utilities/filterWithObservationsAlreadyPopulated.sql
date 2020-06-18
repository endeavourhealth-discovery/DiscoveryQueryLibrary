drop procedure if exists filterWithObservationsAlreadyPopulated;

DELIMITER //
CREATE PROCEDURE filterWithObservationsAlreadyPopulated (
	IN filterType int -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months)
)
BEGIN

-- Already called
-- call createObservationsFromCohortPseudo( codeSetId, filterType );

drop table if exists filteredObservations;

if (filterType = 0) then
    -- earliest
	create table filteredObservations as
		select distinct
			mc.group_by,
		  mc.original_code,
		  mc.original_term,
		  mc.result_value,
  		mc.clinical_effective_date,
		  mc.result_value_units
		 from observationsFromCohort mc
		 left join observationsFromCohort mcoo on mcoo.group_by = mc.group_by
		   and (mc.clinical_effective_date > mcoo.clinical_effective_date
			 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))
		 where mcoo.group_by is null;
elseif (filterType = 2) then
  -- ever
	create table filteredObservations as
		select distinct
			mc.group_by,
		  mc.original_code,
		  mc.original_term,
		  mc.result_value,
      mc.clinical_effective_date,
		  mc.result_value_units
		 from observationsFromCohort mc;

elseif (filterType = 1 or filterType = 3) then
	-- latest or pivot (pivot uses latest, but doesn't have to be so)
	create table filteredObservations as
		select distinct
			mc.group_by,
		  mc.original_code,
		  mc.original_term,
		  mc.result_value,
      mc.clinical_effective_date,
		  mc.result_value_units
		 from observationsFromCohort mc
		 left join observationsFromCohort mcoo on mcoo.group_by = mc.group_by
		   and (mc.clinical_effective_date < mcoo.clinical_effective_date
			 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id < mcoo.id))
		 where mcoo.group_by is null;
else
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'filterType not recognised';
end if;

 END//
DELIMITER ;
