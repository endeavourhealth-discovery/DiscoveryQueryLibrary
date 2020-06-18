-- ----------------------------------------------------------------------
-- 1. identifies any patients with cabergoline medications in medication order
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists CAB1_cab_meds_cohort;
DELIMITER //
create procedure CAB1_cab_meds_cohort()
BEGIN

	drop table if exists F50_cab_meds_cohort;
	create table F50_cab_meds_cohort as

	select patient_id
	,	person_id
	,   min(case when dmd_id is not null then clinical_effective_date else curdate() end) as cab_meds_flag

	from ceg_compass_data.medication_order as meds

	where meds.dmd_id in (
	-- Cabergoline AMPs
	109139002
	-- Cabergoline VMPs
	, 323194009
	, 323192008
	, 323193003
	, 326064008)

	group by patient_id
	,	person_id;
	create index patient_id on F50_cab_meds_cohort(patient_id);
	create index person_id on F50_cab_meds_cohort(person_id);

END;
// DELIMITER ;
