-- ----------------------------------------------------------------------
-- 10. removes any tables from the DB that are not required as final outputs
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists CAB11_output_file_clean_up;
DELIMITER //
create procedure CAB11_output_file_clean_up()
BEGIN

    -- delete test files
    drop table if exists F50_CAB_TEST_Serum_Prolactin;
    drop table if exists F50_CAB_TEST_Person_Level_Data;
    drop table if exists F50_CAB_TEST_Cabergoline_Prescriptions;

    -- delete output files
    drop table if exists F50_CAB_OUT_Serum_Prolactin;
    drop table if exists F50_CAB_OUT_Person_Level_Data;
    drop table if exists F50_CAB_OUT_Cabergoline_Prescriptions;


END;
// DELIMITER ;
