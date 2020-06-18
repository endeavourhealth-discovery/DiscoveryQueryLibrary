drop procedure if exists filterMedications;

DELIMITER //
CREATE PROCEDURE filterMedications (
	IN snomedIds varchar (15000),
	IN filterType int -- 0 earliest, 1 12 months previously from now()
)
BEGIN

call createMedicationsFromCohortR9( snomedIds, filterType );

drop table if exists filteredMedications;

if (filterType = 0) then
    -- earliest
	create table filteredMedications as
		select distinct
		 	mc.pseudo_id,
		  mc.original_term,
		  mc.quantity_value,
      mc.clinical_effective_date,
		  mc.quantity_unit
		 from medicationsFromCohort mc
		 left join medicationsFromCohort mcoo on mcoo.pseudo_id = mc.pseudo_id
		   and (mc.clinical_effective_date > mcoo.clinical_effective_date
			 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))
		 where mcoo.patient_id is null;
else
	-- within 12 months of now()
	create table filteredMedications as
		select distinct
		 	mc.pseudo_id,
		  mc.original_term,
		  mc.quantity_value,
      mc.clinical_effective_date,
		  mc.quantity_unit
		 from medicationsFromCohort mc
		 left join medicationsFromCohort mcoo on mcoo.pseudo_id = mc.pseudo_id
		   and (mc.clinical_effective_date < mcoo.clinical_effective_date
			 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id < mcoo.id))
		 where mcoo.patient_id is null;

end if;

drop table medicationsFromCohort;

 END//
DELIMITER ;
