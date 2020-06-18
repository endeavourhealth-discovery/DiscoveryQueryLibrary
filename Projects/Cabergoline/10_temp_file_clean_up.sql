-- ----------------------------------------------------------------------
-- 10. removes any tables from the DB that are not required as final outputs
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists CAB10_temp_file_clean_up;
DELIMITER //
create procedure CAB10_temp_file_clean_up()
BEGIN

    drop table if exists F50_cab_candidate_cohort_all_GP_data;
    drop table if exists F50_cab_candidate_cohort_drug_excl;
    drop table if exists F50_cab_cohort_all_obs;
    drop table if exists F50_cab_cohort_driver_table;
    drop table if exists F50_cab_detailed_prescription_data;
    drop table if exists F50_cab_meds_cohort;
	drop table if exists F50_cab_observations;
    drop table if exists F50_cab_observations_person;
    drop table if exists F50_cab_prescription_stats;
    drop table if exists F50_cab_serum_prolactin;
    drop table if exists project_keys;

END;
// DELIMITER ;
