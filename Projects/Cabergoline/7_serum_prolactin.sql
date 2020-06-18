-- ----------------------------------------------------------------------
-- 8. pulls back deduplicated list of serum prolactin results for
-- every person in the cohort
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists CAB7_serum_prolactin;
DELIMITER //
create procedure CAB7_serum_prolactin()
BEGIN

	drop table if exists cohort;
	create temporary table cohort as
	-- All GP person/patient/org combinaions in scope
	(
		select distinct a.patient_id, a.person_id, a.organization_id
		from F50_cab_candidate_cohort_all_GP_data as a 		-- all GP data in scope..
		inner join F50_cab_candidate_cohort_drug_excl as b 	-- ...filtered on those people still in cohort
			on a.person_id = b.person_id
	)
	union
	-- All Hospital person/patient/org combinations in scope
	(
		select distinct b.id as patient_id
		,	a.person_id
		,	b.organization_id

		from F50_cab_candidate_cohort_all_GP_data as a
		inner join ceg_compass_data.patient as b
			on a.person_id = b.person_id
			and b.organization_id in   (294564, -- Barts Health NHS Trust
										468127) -- Homerton University Hospital NHS Foundation Trust
		inner join F50_cab_candidate_cohort_drug_excl as c 	-- ...filtered on those people still in cohort
			on a.person_id = c.person_id
	);
	alter table cohort add index (person_id);
	alter table cohort add index (patient_id);
	alter table cohort add index (organization_id);


	drop table if exists serum_prolactin_dedupe;
	create temporary table serum_prolactin_dedupe as
	select obs.person_id
	,	obs.result_value
	,	obs.result_value_units
	,	obs.result_date
	,	obs.result_text
	,	obs.clinical_effective_date
	,	obs.original_code
	,	obs.original_term
	,	max(obs.id) as primary_obs_id -- arbitrary choice
	,	count(obs.id) as num_dupes

	from ceg_compass_data.observation as obs
	inner join cohort as cab
		on obs.person_id = cab.person_id
		and obs.patient_id = cab.patient_id
		and obs.organization_id = cab.organization_id
	where snomed_concept_id = '1027171000000101'

	group by obs.person_id
	,	obs.result_value
	,	obs.result_value_units
	,	obs.result_date
	,	obs.result_text
	,	obs.clinical_effective_date
	,	obs.original_code
	,	obs.original_term;

	-- write out deduped table at person level
	drop table if exists F50_cab_serum_prolactin;
	create table F50_cab_serum_prolactin as
	select person_id
	,	original_term
	,	result_value
	,	result_value_units
	,	clinical_effective_date

	from serum_prolactin_dedupe;

    -- clean up temp tables
    drop table if exists serum_prolactin_dedupe;
    drop table if exists cohort;

END;
// DELIMITER ;
