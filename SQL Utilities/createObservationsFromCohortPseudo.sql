drop procedure if exists createObservationsFromCohortPseudo;

DELIMITER //
CREATE PROCEDURE createObservationsFromCohortPseudo (
    IN codeSetId int,
    IN filterType int -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months)
)
BEGIN

drop table if exists observationsFromCohortPseudo;

if (filterType = 3) then  -- pivot over 6 months from pivot date (already set in cohort)
	create table observationsFromCohortPseudo as
	 select
	  o.id,
	  o.patient_id,
	  cr.pseudo_id,
	  o.clinical_effective_date,
	  o.original_code,
	  o.original_term,
	  o.result_value,
	  o.result_value_units
	 from cohort cr
	 join ceg_compass_data.observation o on o.patient_id = cr.patient_id
     join
		(select distinct read2_code as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId
			union
		select distinct ctv3_code as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId) csc
		on csc.mixed_codes = o.original_code
	where o.clinical_effective_date between DATE_SUB(cr.pivot_date, INTERVAL 6 MONTH) and DATE_SUB(cr.pivot_date, INTERVAL -6 MONTH);
else
	-- latest or earliest or ever (so all observations)
	create table observationsFromCohortPseudo as
	 select
	  o.id,
	  o.patient_id,
    cr.pseudo_id,
	  o.clinical_effective_date,
	  o.original_code,
	  o.original_term,
	  o.result_value,
	  o.result_value_units
	 from cohort cr
     join ceg_compass_data.observation o on o.patient_id = cr.patient_id
     join
		(select distinct read2_code as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId
			union
		select distinct ctv3_code as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId) csc
		on csc.mixed_codes = o.original_code;
end if;


alter table observationsFromCohortPseudo add index (patient_id);
alter table observationsFromCohortPseudo add index (pseudo_id);
alter table observationsFromCohortPseudo add primary key (id);
alter table observationsFromCohortPseudo add index (clinical_effective_date);

END//
DELIMITER ;
