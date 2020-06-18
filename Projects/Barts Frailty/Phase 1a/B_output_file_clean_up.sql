-- ----------------------------------------------------------------------
-- 10. removes any tables from the DB that are not required as final outputs
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists BFB_output_file_clean_up;
DELIMITER //
create procedure BFB_output_file_clean_up()
BEGIN

    -- test files
    drop table if exists BF_TEST_Royal_London;
    drop table if exists BF_TEST_Newham;
    drop table if exists BF_TEST_Whipps_Cross;

    -- output files
    drop table if exists BF_OUT_Royal_London;
    drop table if exists BF_OUT_Newham;
    drop table if exists BF_OUT_Whipps_Cross;

END;
// DELIMITER ;
