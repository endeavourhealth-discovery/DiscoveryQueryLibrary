use data_extracts;

drop procedure if exists filterMedicationOrders;

DELIMITER //
CREATE PROCEDURE filterMedicationOrders (
	IN snomedIds varchar (15000),
	IN filterType int, -- 0 earliest, 1 since filterDate
	IN filterDate date
)
BEGIN

	call createMedicationOrdersFromCohort( snomedIds, filterType, filterDate );

	drop table if exists filteredMedications;

	if (filterType = 0) then
	    -- earliest
		create table filteredMedications as
			select distinct
			  mc.id,
			 	mc.group_by,
			  mc.original_term,
			  mc.quantity_value,
	      mc.clinical_effective_date,
			  mc.quantity_unit,
				mc.dmd_id
			 from medicationsFromCohort mc
			 left join medicationsFromCohort mcoo on mcoo.group_by = mc.group_by
			   and (mc.clinical_effective_date > mcoo.clinical_effective_date
				 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))
			 where mcoo.group_by is null;
	else
		-- all
		create table filteredMedications as
			select distinct
				mc.id,
			 	mc.group_by,
			  mc.original_term,
			  mc.quantity_value,
	      mc.clinical_effective_date,
			  mc.quantity_unit,
				mc.dmd_id
			 from medicationsFromCohort mc;

	end if;

END//

DELIMITER ;
