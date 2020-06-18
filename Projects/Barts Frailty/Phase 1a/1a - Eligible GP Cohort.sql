-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Barts Four
-- %% Frailty Report
-- %% Factor 50, 2019
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Step 1a
-- %% GP Geographical cohort Definition
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use data_extracts;

drop procedure if exists BF1a_Eligible_GP_Cohort;
DELIMITER //
create procedure BF1a_Eligible_GP_Cohort()
BEGIN

	-- ----------------------------------------------------------------------------
	-- find all patients registered with GPs in 4 CCGs of interest (patient level)
	-- ----------------------------------------------------------------------------

	drop table if exists geog_cohort;
	create temporary table geog_cohort as

	select e.date_registered
	,	p.id as 'patient_id'
	,	p.person_id
	,	p.organization_id
    ,	org.ods_code
    ,	org.name
    ,	par.name as ccg
	,  	coalesce(p.age_years, floor(p.age_months/12), floor(p.age_weeks/52.14)) as 'age_in_years'
	,	p.date_of_death
	,	case
			when p.patient_gender_id = 0 then 'Male'
			when p.patient_gender_id = 1 then 'Female'
			when p.patient_gender_id = 2 then 'Other'
			when p.patient_gender_id = 3 then 'Unknown'
			else '???'
		end as 'gender'

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
			and e.registration_type_id = 2
			and coalesce(p.age_years, floor(p.age_months/12), floor(p.age_weeks/52.14)) >= 65 		-- over 65s only
			and e.date_registered <= now()															-- registered in the past
			and (
					(e.date_registered_end > now() or e.date_registered_end IS NULL) 				-- still registered (not cancelled, or cancellation date is in the future)...
					and
					(p.date_of_death is null) 														-- ... and still alive (should be caught by registration end, but not always)
				);
	create index person_id on geog_cohort(person_id);

	-- ----------------------------------------------------------------------------
	-- find most recent registration by person
	-- ----------------------------------------------------------------------------

	drop table if exists recent_reg_dt;
	create temporary table recent_reg_dt as
	select max(gc.date_registered) as max_date_registered
	, 	gc.person_id
	from geog_cohort as gc

	group by person_id;
	create index person_id on recent_reg_dt(person_id);

	-- find all (potentially non-unique by person) with latest registration date
	drop table if exists geog_cohort_rr;
	create temporary table geog_cohort_rr as
	select gc.*

	from geog_cohort gc
	join recent_reg_dt rr
		on gc.person_id = rr.person_id
	where gc.date_registered = rr.max_date_registered;
	create index person_id on geog_cohort_rr(person_id);

	-- ----------------------------------------------------------------------------
	-- apply patient_id tiebreaker
	-- ----------------------------------------------------------------------------

	-- find max patient_id as tie-breaker (where multiple registrations on the same day)
	drop table if exists recent_reg_id;
	create temporary table recent_reg_id as
	select max(gc.patient_id) as max_patient_id
	, 	gc.person_id
	from geog_cohort_rr as gc
	group by person_id;
	create index person_id on recent_reg_id(person_id);

	-- eliminate dupes (where multiple registrations on the same day)
	drop table if exists F50_bartsfrailty_GP_in_area;
	create table F50_bartsfrailty_GP_in_area as
	select gc.*

	from geog_cohort_rr gc
	join recent_reg_id rr
		on gc.person_id = rr.person_id
	where gc.patient_id = rr.max_patient_id
	and age_in_years >= 65;
	create index person_id on F50_bartsfrailty_GP_in_area(person_id);

    -- drop temp tables
    drop table if exists geog_cohort;
    drop table if exists recent_reg_dt;
    drop table if exists geog_cohort_rr;
    drop table if exists recent_reg_id;

END;
// DELIMITER ;
