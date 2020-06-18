use data_extracts;

drop procedure if exists createObservationsFromCohortFinal;

DELIMITER //

CREATE PROCEDURE createObservationsFromCohortFinal (
    IN codeSetId int,
    IN filterType int, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 all since filterDate
    IN filterDate date,
  	IN ignoreNullValues bit -- 1 ignore, 0 include
)
BEGIN

-- SELECT CONVERT("2017-08-29", DATE);
drop table if exists observationsFromCohort;

if (filterType = 3) then  -- pivot over 6 months from pivot date (already set in cohort)
	create table observationsFromCohort as
	 select
     distinct
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
		(select distinct read2_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId
			union
		select distinct ctv3_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId) csc
		on csc.mixed_codes = o.original_code
	where o.clinical_effective_date between DATE_SUB(cr.pivot_date, INTERVAL 6 MONTH) and DATE_SUB(cr.pivot_date, INTERVAL -6 MONTH);
elseif (filterType = 4) then
-- allSince filterDate
	create table observationsFromCohort as
	 select
     distinct
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
		(select distinct read2_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId
			union
		select distinct ctv3_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId) csc
		on csc.mixed_codes = o.original_code
	where o.clinical_effective_date > filterDate;
else
	-- latest or earliest or ever (so all observations)
	create table observationsFromCohort as
	 select
     distinct
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
		(select distinct read2_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId
			union
		select distinct ctv3_concept_id as mixed_codes from code_set_codes csc where csc.code_set_id = codeSetId) csc
		on csc.mixed_codes = o.original_code;
end if;

if (ignoreNullValues = 1) then
  delete from observationsFromCohort where result_value_units is null;
end if;

alter table observationsFromCohort add index (patient_id);
alter table observationsFromCohort add index (pseudo_id);
alter table observationsFromCohort add primary key (id);
alter table observationsFromCohort add index (clinical_effective_date);

END//
DELIMITER ;
