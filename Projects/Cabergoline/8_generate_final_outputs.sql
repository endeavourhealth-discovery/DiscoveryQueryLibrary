
use data_extracts;

drop procedure if exists CAB8_generate_final_outputs;
DELIMITER //
create procedure CAB8_generate_final_outputs()
BEGIN

	drop table if exists F50_CAB_OUT_Person_Level_Data;
	create table F50_CAB_OUT_Person_Level_Data as
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    	-- %% Hash person_id using project and variable specific hash key in lookup table
    	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    	select sha2(concat(cast(a.person_id as char(32)),(select key_value from project_keys where project_name = 'Cabergoline' and variable_name = 'person_id')),256) as unique_person_id
	,	case
			when matched_with = 'Unmatched' then NULL
            		else sha2(concat(cast(a.matched_with as char(32)),(select key_value from project_keys where project_name = 'Cabergoline' and variable_name = 'person_id')),256)
		end as matched_unique_person_id
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	,	c.ccg
	,	a.cohort_flag
	,	b.ods_code as organization_ods_code
	,	b.name as organization_name
	,	c.gender 																									-- Gender
	,	c.ethnicity_5cat as ethnicity																				-- Ethnicity
	,	c.age_in_years																								-- Age
	,	case when a.diabetes_flag = 1 then 'Y' else 'N' end as diabetes_indicator 									-- Diabetes
	,	case when a.td_ihd_inc_earliest is not null then 'Y'
			 when a.ti_ihd_inc_earliest is not null then 'Y' else 'N' end as IHD_indicator  						-- IHD
	,	case when a.hypertension_flag = 1 then 'Y' else 'N' end as hypertension_indicator							-- Hypertension
	,	a.smoker_flag as smoking_status_for_matching																-- Smoking (ever smoked; other)
	,	a.smoker_flag_granular as granular_smoking_status															-- Smoking (ever; never; unknown)
	,	d.latest_cab_prescription_tablet_mg																			-- Latest cabergoline prescription amount (single dose, mg)
	,	d.latest_cab_prescription_total_mg																			-- Latest cabergoline prescription amount (mg)
	,	d.latest_cab_prescription_date																				-- Latest cabergoline prescription date
	,	d.first_cab_prescription_tablet_mg																			-- First cabergoline prescription amount (single dose, mg)
	,	d.first_cab_prescription_total_mg																			-- First cabergoline prescription amount (mg)
	,	d.first_cab_prescription_date																				-- First cabergoline prescription date
	,	d.peak_cab_prescription_tablet_mg																			-- Peak cabergoline prescription amount (single dose, mg)
	,	d.peak_cab_prescription_date																				-- Peak cabergoline prescription date
	,	d.days_on_cabergoline																						-- Cumulative time on cabergoline medication (days)
	,	d.cumulative_cabergoline_consumption																		-- Total cumulative cabergoline consumption (mg)
	,	case when e.prolactinoma_earliest is not null then 'Y' else 'N' end as prolactinoma_diagnosis				-- Hard prolactinoma diagnosis
	,	e.prolactinoma_earliest as prolactinoma_diagnosis_date														-- Hard prolactinoma diagnosis date
	,	case when e.hyperprolactinaemia_earliest is not null then 'Y' else 'N' end as hyperprolactinaemia_diganosis	-- Hard hyperprolactinaemia diagnosis
	,	e.hyperprolactinaemia_earliest as hyperprolactinaemia_diganosis_date										-- Hard hyperprolactinaemia diagnosis date
	,	case when e.prolactin_result_earliest is not null then 'Y' else 'N' end as serum_prolactin_result			-- Serum Prolactin result flag
	,	e.prolactin_result_earliest as serum_prolactin_result_date													-- Earliest serum prolactin blood date
	,	case when e.parkinsons_earliest is not null then 'Y' else 'N' end as parkinsons_diagnosis					-- Parkinson's diagnosis
	,	e.parkinsons_earliest as parkinsons_diagnosis_date															-- Parkinson's diagnosis date
	,	case when e.parkinsons_drug_marker_earliest is not null then 'Y' else 'N' end as parkinsons_drug_marker		-- Parkinson's drug indicator
	,	e.parkinsons_drug_marker_earliest as parkinsons_drug_marker_date											-- Parkinson's drug indicator date
	,	case when e.restless_legs_earliest is not null then 'Y' else 'N' end as restless_leg_diganosis				-- Restless leg syndrome diganosis
	,	e.restless_legs_earliest as restless_leg_diganosis_date 													-- Restless leg syndrome diganosis date
	,	e.echo_earliest as first_echo_date 																			-- First echocardiagram date
	,	e.echo_latest as latest_echo_date 																			-- Most recent echocardiagram date
	, 	round(e.ave_inter_echo_days,1) 																				-- Average intra-echocardiogram period (days)
	,	e.echo_count as number_of_echos																				-- Number of echocardiograms
	,	case when e.valve_replacement_earliest is not null then 'Y' else 'N' end as valve_replacement_surgery		-- Valve Replacement Surgery
	,	e.valve_replacement_earliest as valve_replacement_surgery_date												-- Valve Replacement Surgery date
	,	datediff(a.cab_start_date, e.valve_replacement_earliest) as time_from_cab_to_valve_replacement				-- Time from start of Cabergoline usage to Valve Replacement Surgery (days)
	,	case when e.hf_admission_earliest is not null then 'Y' else 'N' end as heart_failure_admission				-- Admission with Heart Failure
	,	e.hf_admission_earliest as heart_failure_admission_date														-- Heart failure admission date
	,	datediff(a.cab_start_date, e.hf_admission_earliest)	as time_from_cab_to_hf_admission						-- Time from start of Cabergoline usage to heart failure admission (days)
	,	case when e.gp_heart_failure_earliest is not null then 'Y' else 'N' end as gp_heart_failure_diagnosis		-- Clinical Heart Failure Diagnosis
	,	e.gp_heart_failure_earliest as gp_heart_failure_diagnosis_date												-- Clinical Heart Failure Diagnosis date
	,	datediff(a.cab_start_date, e.gp_heart_failure_earliest)	as time_from_cab_to_hf_diagnosis					-- Time from start of Cabergoline usage to Clinical Heart Failure Diagnosis (days)
	,	case when e.hf_drug_marker_earliest is not null then 'Y' else 'N' end as heart_failure_drugs_marker			-- Heart Failure Medications
	,	e.hf_drug_marker_earliest as heart_failure_drugs_marker_date												-- Heart Failure Medications date
	,	datediff(a.cab_start_date, e.hf_drug_marker_earliest) as time_from_cab_to_hf_drugs_marker					-- Time from start of Cabergoline usage to first Heart Failure Medications (days)

	from F50_cab_cohort_driver_table as a
	-- join to organization data
	left outer join ceg_compass_data.organization as b
		on a.organization_id = b.id
	-- join to latest patient record for demographics
	left outer join F50_cab_candidate_cohort_all_GP_data as c
		on a.person_id = c.person_id
		and c.latest_reg_flag = 1
	-- join to person level cabergoline stats
	left outer join F50_cab_prescription_stats as d
		on a.person_id = d.person_id
	left outer join F50_cab_observations_person as e
		on a.person_id = e.person_id;

	-- select * from F50_CAB_OUT_Person_Level_Data;

	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- Cabergoline Prescription Output
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	drop table if exists F50_CAB_OUT_Cabergoline_Prescriptions;
	create table F50_CAB_OUT_Cabergoline_Prescriptions as

	select sha2(concat(cast(a.person_id as char(32)),(select key_value from project_keys where project_name = 'Cabergoline' and variable_name = 'person_id')),256) as unique_person_id
	,	a.dmd_id
	,	a.prescribed_tablet_description
	,	a.prescribed_tablet_size_mg
	,	a.gp_dosage
	,	a.gp_prescription_start_date
	,	a.gp_prescription_quantity_value
	,	a.gp_prescription_quantity_unit
	,	a.gp_prescription_duration_days
	,	a.CALC_total_amount_prescribed_mg
	,	a.CALC_prescription_end_date
	,	a.CALC_weekly_dosage_amount

	from F50_cab_detailed_prescription_data as a
	-- only people in final output samples
	inner join F50_cab_cohort_driver_table as b
		on a.person_id = b.person_id;

	-- select * from F50_CAB_OUT_Cabergoline_Prescriptions;


	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- Serum Prolactin Outputs
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	drop table if exists F50_CAB_OUT_Serum_Prolactin;
	create table F50_CAB_OUT_Serum_Prolactin as

	select sha2(concat(cast(a.person_id as char(32)),(select key_value from project_keys where project_name = 'Cabergoline' and variable_name = 'person_id')),256) as unique_person_id
	,	a.original_term
	,	a.result_value
	,	a.result_value_units
	,	a.clinical_effective_date

	from F50_cab_serum_prolactin as a
	-- only people in final output samples
	inner join F50_cab_cohort_driver_table as b
		on a.person_id = b.person_id;

	-- select * from F50_CAB_OUT_Serum_Prolactin;

	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- AMMENDMENT: Acromegaly Code Outputs
	-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- New table to capture additional codes missed in initial request (applicant driven)
 
    	drop table if exists F50_CAB_OUT_Acromegaly_Codes;
	create table F50_CAB_OUT_Acromegaly_Codes as
	
    	select a.unique_person_id
	,	b.original_term
	,	b.snomed_concept_id
	,	clinical_effective_date

	from F50_CAB_TEST_Person_Level_Data as a

	inner join F50_cab_cohort_all_obs as b
		on a.person_id = b.person_id
		and b.clinical_effective_date <= '2019-10-29'
		and b.snomed_concept_id in (2041006,12331003,27713005,74107003,75968004,80849007,81780002,86073008,180082008,180145002,230581008,237661003,240089002,241101009,267386008,403254007,719826004,725418006);

	-- select * from F50_CAB_OUT_Acromegaly_Codes;						    

END;
// DELIMITER ;
