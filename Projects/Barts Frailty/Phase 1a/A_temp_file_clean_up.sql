-- ----------------------------------------------------------------------
-- 10. removes any tables from the DB that are not required as final outputs
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists BFA_temp_file_clean_up;
DELIMITER //
create procedure BFA_temp_file_clean_up()
BEGIN

    drop table if exists F50_bartsfrailty_ae_encounters;
    drop table if exists F50_bartsfrailty_all_obs;
    drop table if exists F50_bartsfrailty_first_encounters;
    drop table if exists F50_bartsfrailty_flags;
    drop table if exists F50_bartsfrailty_GP_in_area;
    drop table if exists F50_bartsfrailty_observations;

END;
// DELIMITER ;
