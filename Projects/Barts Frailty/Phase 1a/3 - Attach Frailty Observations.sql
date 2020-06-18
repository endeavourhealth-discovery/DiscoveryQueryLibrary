-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Step 3
-- %% Pull back metrics on frailty flags
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use data_extracts;

drop procedure if exists BF3_Attach_Frailty_Observations;
DELIMITER //
create procedure BF3_Attach_Frailty_Observations()
BEGIN

	-- -----------------------------------------------
	-- Create person level dataset and add comorbidity flags
	-- -----------------------------------------------

	drop table if exists F50_bartsfrailty_obs_person;
	create temporary table F50_bartsfrailty_obs_person as
	select a.person_id
    ,	c.pseudo_id
    ,	d.ccg
    ,	d.organization_id as gp_organization_id
    ,	d.ods_code as gp_ods_code
    ,	d.name as gp_name
	,	a.barts_encounter_date as admission_date
	,	a.age
	,	a.hospital_name
	-- gp frailty
	,	max(case when coalesce(b.frailty_gp_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as gp_frailty_flag
	-- admitted from carehome
	,	max(case when coalesce(b.carehome_admission_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as carehome_admission_flag
	-- delirium
	,	max(case when coalesce(b.delirium_admission_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as delirium_admission_flag
	,	max(case when coalesce(b.delirium_gp_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as delirium_gp_flag
	-- falls
	,	max(case when coalesce(b.falls_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as falls_flag
	-- comorbidities
	,	max(case when coalesce(b.cancer_a_earliest, b.cancer_b_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as cancer_flag
	,	max(case when coalesce(b.chronic_respiratory_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as chronic_respiratory_flag
	,	max(case when coalesce(b.parkinsons_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as parkinsons_flag
	,	max(case when coalesce(b.heart_failure_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as heart_failure_flag
	,	max(case when coalesce(b.arthritis_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as arthritis_flag
	,	max(case when coalesce(b.stroke_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as stroke_flag
	,	max(case when coalesce(b.dementia_earliest, '2100-01-01') <= a.barts_encounter_date then 1 else 0 end) as dementia_flag
	-- date fields to assist with testing
	,	max(b.dementia_earliest) as dementia_most_recent
    ,	max(b.falls_earliest) as falls_most_recent
    ,	max(b.carehome_admission_earliest) as carehome_admission_most_recent
	,	max(b.frailty_gp_earliest) as frailty_gp_most_recent
    ,	max(b.delirium_admission_earliest) as delirium_admission_most_recent
    -- list of comorbidities
    ,	max(b.parkinsons_earliest) as CM_parkinsons_most_recent
    ,	max(case
				when b.cancer_a_earliest > cancer_b_earliest then cancer_a_earliest
                when b.cancer_a_earliest < cancer_b_earliest then cancer_b_earliest
                else b.cancer_a_earliest
			end) as CM_cancer_most_recent
    ,	max(b.chronic_respiratory_earliest) as CM_chronic_respiratory_most_recent
    ,	max(b.heart_failure_earliest) as CM_heart_failure_most_recent
	,	max(b.arthritis_earliest) as CM_arthritis_most_recent
    ,	max(b.stroke_earliest) as CM_stroke_most_recent
	,	max(b.dementia_earliest) as CM_dementia_most_recent


	from F50_bartsfrailty_first_encounters as a
	left outer join F50_bartsfrailty_observations as b
		on a.person_id = b.person_id
	left outer join ceg_compass_data.person as c
		on a.person_id = c.id
	left outer join F50_bartsfrailty_GP_in_area as d
		on a.person_id = d.person_id

	group by a.person_id;
	alter table F50_bartsfrailty_obs_person add index (person_id);

	-- -----------------------------------------------
	-- define the flags
	-- -----------------------------------------------

	drop table if exists F50_bartsfrailty_flags;
	create table F50_bartsfrailty_flags as
	select pseudo_id
	,	admission_date
	,	hospital_name
	,	case when age >= 65 and gp_frailty_flag = 1 then 'Y' else 'N' end as gp_frailty_flag
	,	case when age >= 65 and carehome_admission_flag = 1 then 'Y' else 'N' end as over65_carehome_admission
	,	case when age >= 75 and falls_flag = 1 then 'Y' else 'N' end as over75_fall_history
	,	case when age >= 75 and delirium_admission_flag = 1 then 'Y' else 'N' end as over75_delirium_admission
	-- ,	case when age >= 75 and delirium_gp_flag = 1 then 'Y' else 'N' end as over75_delirium_gp
	,   case when age >= 85 and cancer_flag + chronic_respiratory_flag + parkinsons_flag
								+ heart_failure_flag + arthritis_flag + stroke_flag
								+ dementia_flag >= 4 then 'Y' else 'N' end as over85_over_4_comorbidities
	,	case
			when age >= 65 and gp_frailty_flag = 1 then 'Y'
			when age >= 65 and carehome_admission_flag = 1 then 'Y'
			when age >= 75 and falls_flag = 1 then 'Y'
			when age >= 75 and delirium_admission_flag = 1 then 'Y'
			-- when age >= 75 and delirium_gp_flag = 1 then 'Y'
			when age >= 85 and cancer_flag + chronic_respiratory_flag + parkinsons_flag
								+ heart_failure_flag + arthritis_flag + stroke_flag
								+ dementia_flag >= 4 then 'Y'
			else 'N'
		end as master_frailty_flag
	-- testing date fields
    ,	ccg
    -- ,	gp_organization_id
    ,	gp_ods_code
    -- ,	gp_name
    ,	age
	,	dementia_most_recent
    ,	falls_most_recent
    ,	carehome_admission_most_recent
	,	frailty_gp_most_recent
    ,	delirium_admission_most_recent
    ,	CM_parkinsons_most_recent
    ,	CM_cancer_most_recent
    ,	CM_chronic_respiratory_most_recent
    ,	CM_heart_failure_most_recent
	,	CM_arthritis_most_recent
    ,	CM_stroke_most_recent
	,	CM_dementia_most_recent

	from F50_bartsfrailty_obs_person;

    drop table if exists F50_bartsfrailty_obs_person;

END;
// DELIMITER ;
