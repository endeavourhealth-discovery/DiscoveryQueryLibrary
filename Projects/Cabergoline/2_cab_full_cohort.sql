-- ----------------------------------------------------------------------
-- 2a. filter to geographical cohort and add patient demog data
-- ----------------------------------------------------------------------
use data_extracts;

drop procedure if exists CAB2_cab_full_cohort;
DELIMITER //
create procedure CAB2_cab_full_cohort()
BEGIN

	drop table if exists geog_cohort;
	create temporary table geog_cohort as
		select p.id as 'patient_id'
		,	p.pseudo_id
		,	p.person_id
		-- Registration date (to filter on most recent registration if returns multiple)
		,   e.date_registered
		-- Age in years
		,  	coalesce(age_years, floor(age_months/12), floor(age_weeks/52.14)) as 'age_in_years'
		-- Grouped ethnicity (5+1)
		-- taken form NHS Digital definition https://www.datadictionary.nhs.uk/data_dictionary/attributes/e/end/ethnic_category_code_de.asp)
		,   case
				when p.ethnic_code in ('A','B','C') then 'White'
				when p.ethnic_code in ('D','E','F','G') then 'Mixed'
				when p.ethnic_code in ('H','J','K','L') then 'Asian or Asian British'
				when p.ethnic_code in ('M','N','P') then 'Black or Black British'
				when p.ethnic_code in ('R','S') then 'Black or Black British'
				when p.ethnic_code in ('Z') then 'Unknown'
				when p.ethnic_code is null then 'Unknown'
				else '???'
			end as 'ethnicity_5cat'
		-- DDS granular ethnicity (16+1)
		,	case
				when p.ethnic_code = 'A' then 'British'
				when p.ethnic_code = 'B' then 'Irish'
				when p.ethnic_code = 'C' then 'Any other White background'
				when p.ethnic_code = 'D' then 'White and Black Caribbean'
				when p.ethnic_code = 'E' then 'White and Black African'
				when p.ethnic_code = 'F' then 'White and Asian'
				when p.ethnic_code = 'G' then 'Any other mixed background'
				when p.ethnic_code = 'H' then 'Indian'
				when p.ethnic_code = 'J' then 'Pakistani'
				when p.ethnic_code = 'K' then 'Bangladeshi'
				when p.ethnic_code = 'L' then 'Any other Asian background'
				when p.ethnic_code = 'M' then 'Caribbean'
				when p.ethnic_code = 'N' then 'African'
				when p.ethnic_code = 'P' then 'Any other Black background'
				when p.ethnic_code = 'R' then 'Chinese'
				when p.ethnic_code = 'S' then 'Any other ethnic group'
				when p.ethnic_code = 'Z' then 'Unkown'
				when p.ethnic_code is null then 'Unknown'
			end as 'ethnicity_16cat'
		-- Gender
		,	case
				when patient_gender_id = 0 then 'Male'
				when patient_gender_id = 1 then 'Female'
				when patient_gender_id = 2 then 'Other'
				when patient_gender_id = 3 then 'Unknown'
				else '???'
			end as 'gender'
		-- CCG
		,	case
				-- Amended because there are more CCG IDs than we were told
				when par.name = 'NHS Waltham Forest CCG' then 'Waltham Forest'
				when par.name = 'NHS Tower Hamlets CCG' then 'Tower Hamlets'
				when par.name = 'NHS City and Hackney CCG' then 'City & Hackney'
				when par.name = 'NHS Newham CCG' then 'Newham'
				else '???'
			end as ccg
		-- Geographical proxies (for cohort matching)
		,	p.organization_id
		,   p.lsoa_code
		, 	p.msoa_code
		,	p.ward_code
		,	p.postcode_prefix
		,	p.date_of_death
		,	e.date_registered_end

		from ceg_compass_data.patient as p
		join ceg_compass_data.organization as org
			on p.organization_id = org.id
		join ceg_compass_data.episode_of_care as e
			on e.patient_id = p.id
		join ceg_compass_data.organization as par
			on org.parent_organization_id = par.id
			and par.name in ('NHS Waltham Forest CCG','NHS City and Hackney CCG','NHS Newham CCG','NHS Tower Hamlets CCG')

		-- Amended because there are more CCG IDs than we were told
		where par.name in ('NHS Waltham Forest CCG','NHS City and Hackney CCG','NHS Newham CCG','NHS Tower Hamlets CCG') -- All WF practices
			-- and org.ods_code = 'F86627'  -- Filter on specific surgery (CHURCHILL MEDICAL CENTRE)
			and e.registration_type_id = 2
			-- ###################################################################################
			-- ## report cut-off: end August 2019
			-- ###################################################################################
			and e.date_registered <= '2019-08-31' -- registered in the past
			-- not cancelled; or cancellation date is in the future; but include patients cancelled by virtue of death (otherwise miss dead patients that hit cancellation clause)
			and (
					(e.date_registered_end > now() or e.date_registered_end IS NULL) -- still registered
					or
					(p.date_of_death is not null) -- ... or dead (in which case retain record regardless of cancellation status)
				);
	create index patient_id on geog_cohort(patient_id);
	create index person_id on geog_cohort(person_id);

	-- ----------------------------------------------------------------------
	-- 2b. generate look-up of most recent registration date by person and assign T/C and mortality flags at person level
	-- ----------------------------------------------------------------------

	drop table if exists recent_reg;
	create temporary table recent_reg as
	select max(gc.date_registered) as max_date_registered -- latest registration date
	-- , max(gc.patient_id) as max_patient_id -- assumes incremental patient_id with time
	, 	min(case when cab.cab_meds_flag is null then null else cab.cab_meds_flag end) as cohort_flag
	, 	max(case when gc.date_of_death is not null then 1 else 0 end) as mortality_flag
	, 	gc.person_id

	from geog_cohort as gc
	left join F50_cab_meds_cohort as cab
		on gc.patient_id = cab.patient_id
	group by person_id;
	create index person_id on recent_reg(person_id);

	-- ----------------------------------------------------------------------
	-- 2c. join back to flag most recent registrations, and add cohort flag
	-- ----------------------------------------------------------------------

	drop table if exists full_cohort;
	create temporary table full_cohort as
	select case
			when rr.cohort_flag is null then 'C'
			when rr.cohort_flag is not null then 'T'
			else '???'
		end as cohort_flag
	,	rr.cohort_flag as cab_start_date
	,	rr.mortality_flag
	,	gc.*
	,	rr.max_date_registered

	from geog_cohort gc
	join recent_reg rr
		on gc.person_id = rr.person_id;

	create index patient_id on full_cohort(patient_id);
	create index person_id on full_cohort(person_id);

	-- ----------------------------------------------------------------------
	-- 2d. for case with multiple reg on same date, find max patient_id
	-- ----------------------------------------------------------------------

	drop table if exists recent_reg_2;
	create temporary table recent_reg_2 as
	select max(patient_id) as max_patient_id -- assumes incremental patient_id with time on same date
	, 	person_id
	from full_cohort
	where max_date_registered = date_registered
	group by person_id;
	create index person_id on recent_reg_2(person_id);

	-- ----------------------------------------------------------------------
	-- 2e. join back to flag most recent registrations, accounting for reg data and patient_id
	-- ----------------------------------------------------------------------

	drop table if exists full_cohort_2;
	create temporary table full_cohort_2 as
	select gc.*
	,	case when gc.date_registered = gc.max_date_registered and gc.patient_id = rr.max_patient_id then 1 else 0 end as latest_reg_flag

	from full_cohort gc
	join recent_reg_2 rr
		on gc.person_id = rr.person_id;

	create index patient_id on full_cohort_2(patient_id);
	create index person_id on full_cohort_2(person_id);

	-- ----------------------------------------------------------------------
	-- 2f. down-sample any data not matching to test cohort
	-- ----------------------------------------------------------------------

	-- create separate test cohort driver table as can't join back to same temp table
	drop table if exists test_cohort;
	create temporary table test_cohort as select * from full_cohort_2 where not cohort_flag = 'C';
	create index patient_id on test_cohort(patient_id);

	-- create sampled down version of control cohort (excluding PMH factors) to filter out sample we already know doesn't match across other dimensions
	-- contains anyone who could conceivably match across age, ethnicity, gender and GP surgery (but doesn't take account of PMH)
	drop table if exists sampled_cohort;
	create temporary table sampled_cohort as
		select distinct(c.patient_id)
		from test_cohort t
		inner join full_cohort_2 c
			on t.organization_id = c.organization_id
			and c.cohort_flag = 'C'
			and c.latest_reg_flag = 1
			and (t.age_in_years - c.age_in_years) between -2 and 2
			and t.ethnicity_16cat = c.ethnicity_16cat
			and t.gender = c.gender
		where t.cohort_flag = 'T'
		and t.latest_reg_flag = 1
	;

	-- create final candidate cohort (one row per person) and write out to tables
	drop table if exists F50_cab_candidate_cohort;
	create table F50_cab_candidate_cohort as
		select fc.* from full_cohort_2 as fc inner join sampled_cohort as sc on fc.patient_id = sc.patient_id
		union
		select * from test_cohort where latest_reg_flag = 1
	;
	create index patient_id on F50_cab_candidate_cohort(patient_id);
	create index person_id on F50_cab_candidate_cohort(person_id);

	-- create output of candidate cohort at patient level
	drop table if exists F50_cab_candidate_cohort_all_GP_data;
	create table F50_cab_candidate_cohort_all_GP_data as
		select fc.* from full_cohort_2 as fc inner join F50_cab_candidate_cohort as sc on fc.person_id = sc.person_id and sc.latest_reg_flag = 1
	;
	create index patient_id on F50_cab_candidate_cohort_all_GP_data(patient_id);
	create index person_id on F50_cab_candidate_cohort_all_GP_data(person_id);

    -- clean up temp tables
    drop table if exists geog_cohort;
    drop table if exists recent_reg;
	drop table if exists full_cohort;
    drop table if exists recent_reg_2;
	drop table if exists full_cohort_2;
    drop table if exists sampled_cohort;
    drop table if exists test_cohort;

END;
// DELIMITER ;
