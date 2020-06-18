-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Initialise
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
use data_extracts;

drop procedure if exists CAB6_apply_final_exclusions;
DELIMITER //
create procedure CAB6_apply_final_exclusions()
BEGIN

	-- generate cohort dataset with appropriate matching data at the person level
	drop table if exists person_cohort;
	create temporary table person_cohort as

	select  a.person_id
    ,	a.pseudo_id
	,	max(case when a.latest_reg_flag = 1 then a.organization_id else null end) as organization_id
	,	max(a.cohort_flag) as cohort_flag
	, 	max(case when a.latest_reg_flag = 1 then a.age_in_years else null end) as age_in_years -- take age from most recent registration
	, 	max(case when a.latest_reg_flag = 1 then a.ethnicity_16cat else null end) as ethnicity_16cat -- take ethnicity from most recent registration
	, 	max(case when a.latest_reg_flag = 1 then a.ethnicity_5cat else null end) as ethnicity_5cat -- take ethnicity from most recent registration
	,	max(case when a.latest_reg_flag = 1 then a.msoa_code else null end) as msoa_code -- take lsoa from most recent org
	,	max(case when a.latest_reg_flag = 1 then a.gender else null end) as gender -- take gender from most recent registration
	,	max(case
				when b.smoking_inc_earliest is not null then '2. Smoker/Unknown' -- if ever I hit this then trumps the others
				when b.smoking_exc_earliest is not null then '1. Never Smoked' -- only trumps absence of data, but not positive smoking indication
				else '2. Smoker/Unknown'
			end) as smoker_flag
	,	max(case
				when b.smoking_inc_earliest is not null then '3. Smoker' -- if ever I hit this then trumps the others
				when b.smoking_exc_earliest is not null then '2. Never Smoked' -- only trumps absence of data, but not positive smoking indication
				else '1. Unknown'
			end) as smoker_flag_granular
	,	max(case when b.diabetes_inc_earliest is not null and b.diabetes_exc_earliest is null then 1 else 0 end) as diabetes_flag
	,	max(case when b.htn_inc_earliest is not null and b.htn_exc_earliest is null then 1 else 0 end) as hypertension_flag
	,   min(td_ihd_inc_earliest) as td_ihd_inc_earliest
	,	min(ti_ihd_inc_earliest) as ti_ihd_inc_earliest
	,	min(cab_start_date) as cab_start_date
    ,	min(carc_inc_earliest) as carc_inc_earliest
	,	'Unmatched' as matched_with -- intialise field for the cohort algorithm to assing a matched cohort member, this has to be a string of 'unmatched' to create a wide enough memory allocation for the variable

	from F50_cab_candidate_cohort_all_GP_data as a
	left outer join F50_cab_observations as b
		on a.patient_id = b.patient_id

	group by a.person_id,	a.pseudo_id;
	create index person_id on person_cohort(person_id);

	-- filter on any conditions which drive an exclusion
	drop table if exists cohort_for_matching;
	create temporary table cohort_for_matching as

	select *

	from person_cohort

	-- where clause to pull out IHD patients who all need excluding, and those cabergolites who have IHD prior to their first dose of cabergoline
	-- but if they are a Control case then to ignore this (by comparing to stupidly early date) FOR NOW as we build the cohort table
	-- any controls with td_ihd wil be deemed ineligible for matching in the matching algorithm later
	where ti_ihd_inc_earliest is null 															-- include only those without relevant congenital heart conditions (T&C groups)...
	and coalesce(td_ihd_inc_earliest, '2100-01-01') > coalesce(cab_start_date, '1901-01-01') 	-- ...and only those for whom any time dependent heart disease post-dates their cabergoline usage...
    and carc_inc_earliest is null;																-- ...and those without carcinoid
	create index person_id on cohort_for_matching(person_id);


	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- Generate Matched Cohort
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	-- call the matching proecure (int number_of_matches, bool 5category_ethnicity, bool msoa) which assumes:
	-- Note: I've tried lsoa, it's worse than msoa, which in turn is worse than organization_id

	call F50_cohort_procedure
			(
				5,
				true, 		-- flag as to whether to use 5cat category or not (true = 5cat, false = 16cat)
				false 		-- flag as to whether to use msoa or org (true = msoa, false = organization_id)
			);

	-- create final driver table of people included in the output
	drop table if exists F50_cab_cohort_driver_table;
	create table F50_cab_cohort_driver_table as
	select * from cohort_for_matching
	where cohort_flag = 'T' or matched_with <> 'Unmatched';

    -- clean up temp tables
    drop table if exists person_cohort;
    drop table if exists cohort_for_matching;

END;
// DELIMITER ;

/*
	-- check the number of matches per 'T' member.
	drop table if exists match_counter;
	create temporary table match_counter as
	select count(*) as num_matched, matched_with from  F50_cab_cohort_driver_table where matched_with <> 'Unmatched' group by matched_with;

	-- check final number of matched cases
	select count(a.person_id)
	,	coalesce(b.num_matched,0)
	from F50_cab_cohort_driver_table as a
	left outer join match_counter as b
		on a.person_id = b.matched_with
	where cohort_flag = 'T'
	group by 2;
*/
