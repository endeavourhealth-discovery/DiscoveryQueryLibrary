-- ----------------------------------------------------------------------
-- 3. obtains patient level medication statistics
-- ----------------------------------------------------------------------
use data_extracts;

drop procedure if exists CAB3_cabergoline_dosage;
DELIMITER //
create procedure CAB3_cabergoline_dosage()
BEGIN

	-- to get to patient_level data need to eliminate duplicates that come from old GP registrations.
	-- create only records that are distinct only across: person_id, clinical_effective_date,dmd_id, quantity_value/unit, does and original_term
	drop temporary table if exists cab_dosage_dedupe;
	create temporary table cab_dosage_dedupe as
	select meds.person_id
	,	meds.dmd_id
	,	meds.quantity_value
	,	meds.quantity_unit
	,	meds.clinical_effective_date
	,	meds.dose
	,	meds.original_term
	,	max(meds.id) as primary_id -- arbitrary choice as other records duplicates across important fields
	,	count(meds.id) as number_of_dupes

	from F50_cab_meds_cohort as c
	join ceg_compass_data.medication_order as meds -- inner join as already know that they are on cabergoline
		on c.patient_id = meds.patient_id
		and meds.dmd_id in (109139002, 323194009, 323192008, 323193003, 326064008)

	group by meds.person_id
	,	meds.dmd_id
	,	meds.quantity_value
	,	meds.quantity_unit
	,	meds.clinical_effective_date
	,	meds.dose
	,	meds.original_term;

	drop temporary table if exists cab_dosage_processed;
	create temporary table cab_dosage_processed as
	select *
	-- convert value_unit into number of tablets
	,	case
			when quantity_unit = '1 x 8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '1 x8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '1x4 tablet(s)' then 4 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '1x8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '2 x 8 tablet(s)' then 16 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '2 x8 tablet(s)' then 16 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '2*8 tablet' then 16 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '20 x tablet(s) x2' then 40 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '3 x8 tablet(s)' then 24 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '30 tablets' then 30 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = '8' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'pack of 8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'packs of 8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablet' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablet - 500 micrograms' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablet(s)' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablet(s) - 500 micrograms' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablets' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tablets - 500 micrograms' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'tabs' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'Unk UoM' then 1 * (case when quantity_value = 0 then 1 else quantity_value end) -- examined these specific records. all one patient, agrees with dates
			when quantity_unit = 'x tablet(s)' then 1 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'x16 tablet(s)' then 16 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'x20 tablet(s)' then 20 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_unit = 'x8 tablet(s)' then 8 * (case when quantity_value = 0 then 1 else quantity_value end)
			when quantity_value in (1,0) and quantity_unit is null then 8 -- eyeballed these cases, assumes a packet which lines up with dates
			when quantity_value > 1 and quantity_unit is null then quantity_value
			when quantity_unit = 'INVALID' then 8 -- had to assume a single packet of 8 tablets!
			when quantity_unit = 'months' then 8 -- had to assume a single packet of 8 tablets!
			else -1 -- should be nothing that has -1 at the end!
		end as num_tablets

	from cab_dosage_dedupe;

	-- aggregate cabergoline metrics up to the person level
	drop temporary table if exists cab_dosage;
	create temporary table cab_dosage as
	select person_id
	,	sum(case
				when dmd_id = 323194009 then   4 * num_tablets -- 4mg Tablets
				when dmd_id = 323193003 then   2 * num_tablets -- 2mg Tablets
				when dmd_id = 323192008 then   1 * num_tablets -- 1mg Tablets
				when dmd_id = 326064008 then 0.5 * num_tablets -- 0.5mg Tablets
				else 0
			end) as total_dosage
	,	max(case
				when dmd_id = 323194009 then   4 -- 4mg Tablets
				when dmd_id = 323193003 then   2 -- 2mg Tablets
				when dmd_id = 323192008 then   1 -- 1mg Tablets
				when dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
				else 0
			end) as peak_prescription_mg
	,	min(case
				when dmd_id = 323194009 then   4 -- 4mg Tablets
				when dmd_id = 323193003 then   2 -- 2mg Tablets
				when dmd_id = 323192008 then   1 -- 1mg Tablets
				when dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
				else 0
			end) as lowest_prescription_mg
	,	sum(case
				when dmd_id = 323194009 then   4 * num_tablets -- 4mg Tablets
				when dmd_id = 323193003 then   2 * num_tablets -- 2mg Tablets
				when dmd_id = 323192008 then   1 * num_tablets -- 1mg Tablets
				when dmd_id = 326064008 then 0.5 * num_tablets -- 0.5mg Tablets
				else 0
			end)
			/
			(case
				when datediff(max(clinical_effective_date), min(clinical_effective_date)) = 0 then 1
				else datediff(max(clinical_effective_date), min(clinical_effective_date))
			end) as ave_daily_dosage_approx
	,   datediff(max(clinical_effective_date), min(clinical_effective_date)) as first_to_last_prescription_days
	,   count(*) as number_of_prescriptions -- currently this will assign even fairly large single prescriptions as one-offs
	,	min(clinical_effective_date) as first_cab_prescription_date
	,   max(clinical_effective_date) as latest_cab_prescription_date

	from cab_dosage_processed

	group by person_id;

	-- max dosage date
	drop temporary table if exists max_dosage;
	create temporary table max_dosage as
	select a.person_id
	,	min(a.clinical_effective_date) as max_dosage_date
	,	max(case
				when a.dmd_id = 323194009 then   4 * a.num_tablets -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 * a.num_tablets -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 * a.num_tablets -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 * a.num_tablets -- 0.5mg Tablets
				else 0
			end) as max_dosage_total
	from cab_dosage_processed as a
	inner join cab_dosage as b
		on a.person_id = b.person_id
		and case
				when a.dmd_id = 323194009 then   4 -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
				else 0
			end = b.peak_prescription_mg
	group by person_id;

	-- first dosage level
	drop temporary table if exists first_dosage;
	create temporary table first_dosage as
	select a.person_id
	,	max(case
				when a.dmd_id = 323194009 then   4 -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
				else 0
			end) as first_dosage
	,	max(case
				when a.dmd_id = 323194009 then   4 * a.num_tablets -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 * a.num_tablets -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 * a.num_tablets -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 * a.num_tablets -- 0.5mg Tablets
				else 0
			end) as first_dosage_total
	from cab_dosage_processed as a
	inner join cab_dosage as b
		on a.person_id = b.person_id
		and a.clinical_effective_date = b.first_cab_prescription_date
	group by person_id;

	-- last dosage level
	drop temporary table if exists last_dosage;
	create temporary table last_dosage as
	select a.person_id
	,	max(case
				when a.dmd_id = 323194009 then   4 -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
				else 0
			end) as last_dosage
	,	max(case
				when a.dmd_id = 323194009 then   4 * a.num_tablets -- 4mg Tablets
				when a.dmd_id = 323193003 then   2 * a.num_tablets -- 2mg Tablets
				when a.dmd_id = 323192008 then   1 * a.num_tablets -- 1mg Tablets
				when a.dmd_id = 326064008 then 0.5 * a.num_tablets -- 0.5mg Tablets
				else 0
			end) as last_dosage_total
	from cab_dosage_processed as a
	inner join cab_dosage as b
		on a.person_id = b.person_id
		and a.clinical_effective_date = b.latest_cab_prescription_date
	group by person_id;


	-- create output at person level
	drop table if exists F50_cab_prescription_stats;
	create table F50_cab_prescription_stats as
	select a.person_id
	,	c.last_dosage as latest_cab_prescription_tablet_mg-- Latest cabergoline prescription amount (single dose, mg)
	,	c.last_dosage_total as latest_cab_prescription_total_mg-- Latest cabergoline prescription amount (mg)
	,	a.latest_cab_prescription_date-- Latest cabergoline prescription date
	,	b.first_dosage as first_cab_prescription_tablet_mg-- First cabergoline prescription amount (single dose, mg)
	,	b.first_dosage_total as first_cab_prescription_total_mg-- First cabergoline prescription amount (mg)
	,	a.first_cab_prescription_date-- First cabergoline prescription date
	,	a.peak_prescription_mg as peak_cab_prescription_tablet_mg-- Peak cabergoline prescription amount (single dose, mg)
	,	d.max_dosage_date as peak_cab_prescription_date-- Peak cabergoline prescription date
	,	a.first_to_last_prescription_days as days_on_cabergoline-- Cumulative time on cabergoline medication (days)
	,	a.total_dosage as cumulative_cabergoline_consumption-- Total cumulative cabergoline consumption (mg)

	from cab_dosage as a
	left outer join first_dosage as b
		on a.person_id = b.person_id
	left outer join last_dosage as c
		on a.person_id = c.person_id
	left outer join max_dosage as d
		on a.person_id = d.person_id;

	-- Create output meds table (will filter down later on final cohort)
	drop table if exists F50_cab_detailed_prescription_data;
	create table F50_cab_detailed_prescription_data as

	select a.person_id
	,	c.dmd_id
	,	c.original_term as prescribed_tablet_description
	,	case
			when c.dmd_id = 323194009 then   4 -- 4mg Tablets
			when c.dmd_id = 323193003 then   2 -- 2mg Tablets
			when c.dmd_id = 323192008 then   1 -- 1mg Tablets
			when c.dmd_id = 326064008 then 0.5 -- 0.5mg Tablets
			else 0
		end as prescribed_tablet_size_mg
	,	c.dose as gp_dosage
	,	c.clinical_effective_date as gp_prescription_start_date
	,	c.quantity_value as gp_prescription_quantity_value
	,	c.quantity_unit as gp_prescription_quantity_unit
	,	c.duration_days as gp_prescription_duration_days
	,	case
				when c.dmd_id = 323194009 then   4 * num_tablets -- 4mg Tablets
				when c.dmd_id = 323193003 then   2 * num_tablets -- 2mg Tablets
				when c.dmd_id = 323192008 then   1 * num_tablets -- 1mg Tablets
				when c.dmd_id = 326064008 then 0.5 * num_tablets -- 0.5mg Tablets
				else 0
		end as CALC_total_amount_prescribed_mg
	,	case when coalesce(c.duration_days,0) > 0 then date_add(c.clinical_effective_date, interval c.duration_days day) else null end as CALC_prescription_end_date
	,	case
				when c.dmd_id = 323194009 then   4 * num_tablets -- 4mg Tablets
				when c.dmd_id = 323193003 then   2 * num_tablets -- 2mg Tablets
				when c.dmd_id = 323192008 then   1 * num_tablets -- 1mg Tablets
				when c.dmd_id = 326064008 then 0.5 * num_tablets -- 0.5mg Tablets
				else 0
		end * 7 / c.duration_days as CALC_weekly_dosage_amount

	from cab_dosage_processed as a
	inner join F50_cab_candidate_cohort as b
		on a.person_id = b.person_id
		and b.cohort_flag = 'T'
	inner join ceg_compass_data.medication_order as c
		on a.person_id = c.person_id -- same person
		and a.primary_id = c.id -- only the "primary" record (i.e. no dupes)
		and c.dmd_id in (109139002, 323194009, 323192008, 323193003, 326064008); -- cab only


	-- clean up temp tables
    drop temporary table if exists cab_dosage_dedupe;
    drop temporary table if exists cab_dosage_processed;
    drop temporary table if exists cab_dosage;
    drop temporary table if exists first_dosage;
    drop temporary table if exists max_dosage;
    drop temporary table if exists last_dosage;

END;
// DELIMITER ;
