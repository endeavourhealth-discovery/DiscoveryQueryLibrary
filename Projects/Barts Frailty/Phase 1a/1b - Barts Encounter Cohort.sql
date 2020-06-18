-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Step 1b
-- %% Get all Barts A&E Encounters
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use data_extracts;

drop procedure if exists BF1b_Barts_Encounter_Cohort;
DELIMITER //
create procedure BF1b_Barts_Encounter_Cohort()
BEGIN

	-- Build a table of all patients who have had a Barts encounter
	drop table if exists F50_bartsfrailty_ae_encounters;
	create table F50_bartsfrailty_ae_encounters AS
	SELECT barts.person_id
	,	barts.patient_id
	,	barts.organization_id
	,	barts.location_id
	,	barts.name as location_name
	,	case
			when barts.name like '%Whipps Cross%' then 'Whipps Cross'
			when barts.name like '%Royal London%' then 'Royal London'
			when barts.name like '%Newham%' then 'Newham'
			else '???'
		end as hospital_name
	, 	barts.age as age
	, 	barts.id as barts_encounter_id
	, 	barts.clinical_effective_date as barts_encounter_date
	, 	barts.original_code as barts_encounter_code
	,	barts.snomed_concept_id as barts_snomed_id
	, 	barts.original_term as barts_encounter_term

	FROM
		(
			-- Get all barts encounters and join to categories
			SELECT be.organization_id
				, 	be.person_id
				, 	be.patient_id
				,	d.location_id
				,	l.name
				, 	coalesce(ap.age_years, floor(ap.age_months/12), floor(ap.age_weeks/52.14)) as age
				, 	be.clinical_effective_date
				,	be.id
				, 	be.original_term
				, 	be.original_code
				,	be.snomed_concept_id

				FROM ceg_compass_data.encounter  as be
				LEFT OUTER JOIN ceg_compass_data.person as ap
					ON be.person_id = ap.id
				LEFT OUTER JOIN ceg_compass_data.encounter_detail as d
					on d.id = be.id
				LEFT OUTER JOIN ceg_compass_data.location as l
					on l.id = d.location_id

				WHERE ap.date_of_death is null -- assumes person level date_of_death is correct
					AND coalesce(ap.age_years, floor(ap.age_months/12), floor(ap.age_weeks/52.14)) >= 65 	-- assumes person level age is correct
					AND be.organization_id = 294564 														-- Barts
					AND be.clinical_effective_date > DATE_ADD(CURDATE(), INTERVAL -30 DAY)					-- Last 30 days of encounters (base table)
					AND be.snomed_concept_id = 8009999999104 												-- Corresponds to term of "Emergency department Discharge/end visit (emergency)"
		) AS barts
	WHERE barts.clinical_effective_date = DATE_ADD(CURDATE(), INTERVAL -1 DAY);								-- Filter on yesterday's admissions

	create index person_id on F50_bartsfrailty_ae_encounters(person_id);
	create index patient_id on F50_bartsfrailty_ae_encounters(patient_id);
	create index organization_id on F50_bartsfrailty_ae_encounters(organization_id);

	-- find the earliest encounter
	drop table if exists barts_ae_attendees;
	create temporary table barts_ae_attendees as
	select person_id, min(barts_encounter_date) as first_encounter_date
	from F50_bartsfrailty_ae_encounters
	group by person_id;
	create index person_id on barts_ae_attendees(person_id);

	-- exclude any encounters that aren't ealiest date
	drop table if exists barts_ae_attendees_earliest;
	create temporary table barts_ae_attendees_earliest as
	select a.*
	from F50_bartsfrailty_ae_encounters as a
	inner join barts_ae_attendees as b
		on a.person_id = b.person_id
		and a.barts_encounter_date = b.first_encounter_date;
	create index person_id on barts_ae_attendees_earliest(person_id);

	-- tie breaker on encounter_id
	drop table if exists barts_ae_attendees;
	create temporary table barts_ae_attendees as
	select person_id, max(barts_encounter_id) as max_encounter_id
	from barts_ae_attendees_earliest
	group by person_id;
	create index person_id on barts_ae_attendees(person_id);

	-- get full data on list of first encounters (one per person)
	drop table if exists F50_bartsfrailty_first_encounters;
	create table F50_bartsfrailty_first_encounters as
	select a.*
	from barts_ae_attendees_earliest as a
	inner join barts_ae_attendees as b
		on a.person_id = b.person_id
		and a.barts_encounter_id = b.max_encounter_id;
	create index person_id on F50_bartsfrailty_first_encounters(person_id);

    drop table if exists barts_ae_attendees;
    drop table if exists barts_ae_attendees_earliest;

END;
// DELIMITER ;
