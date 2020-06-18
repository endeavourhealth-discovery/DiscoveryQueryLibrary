-- ----------------------------------------------------------------------
-- 4. identify patients with confounding medications and exclude from cohort
-- ----------------------------------------------------------------------
use data_extracts;

drop procedure if exists CAB4_other_medication_exclusions;
DELIMITER //
create procedure CAB4_other_medication_exclusions()
BEGIN

	-- identify those person_ids that have ever been prescribed any of the excluded medications
	drop table if exists drug_exclusions;
	create temporary table drug_exclusions as
	select c.person_id
	,	max(case when meds.person_id is not null then 1 else 0 end) as drug_exclusion_flag
	,	max(case when meds.dmd_id in (325989008, 325991000, 325992007, 325993002) then 1 else 0 end) as bromocriptine_flag
	,	max(case when meds.dmd_id in (322844002) then 1 else 0 end) as methysergide_flag
	,	max(case when meds.dmd_id in (322793003) then 1 else 0 end) as ergotamine_flag
	,	max(case when meds.dmd_id in (53480001,445490002,374235009,374352005,425766008,376768004,375061009) then 1 else 0 end) as phentermine_flag

	from F50_cab_candidate_cohort_all_GP_data as c -- make sure we find on other regs if there (not just most recent)
	left outer join ceg_compass_data.medication_order as meds
		on c.patient_id = meds.patient_id
		and c.person_id = meds.person_id
		and meds.dmd_id in 	(
								325989008, 325991000, 325992007, 325993002, -- Bromocriptine
								322844002, -- Methysergide
								322793003, -- Ergotamine
								53480001, 445490002, 374235009, 374352005, 425766008, 376768004, 375061009 -- Phentermine
							)
	group by c.person_id;
	create index person_id on drug_exclusions(person_id);

	-- exclude any of these individuals from the candidate cohort
	drop table if exists F50_cab_candidate_cohort_drug_excl;
	create table F50_cab_candidate_cohort_drug_excl as
	select a.*

	from F50_cab_candidate_cohort as a
	inner join drug_exclusions as b
		on a.person_id = b.person_id
		and b.drug_exclusion_flag = 0;
	create index patient_id on F50_cab_candidate_cohort_drug_excl(patient_id);
	create index person_id on F50_cab_candidate_cohort_drug_excl(person_id);

    -- clean up any temp tables
    drop table if exists drug_exclusions;

END;
// DELIMITER ;
