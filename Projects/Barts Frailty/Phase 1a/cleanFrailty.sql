-- ----------------------------------------------------------------------
-- 10. removes any tables from the DB that are not required as final outputs
-- ----------------------------------------------------------------------

use data_extracts;

drop procedure if exists cleanFrailty;
DELIMITER //
create procedure cleanFrailty()
BEGIN

alter table BF_OUT_Whipps_Cross drop column pseudo_id;
alter table BF_OUT_Newham drop column pseudo_id;
alter table BF_OUT_Royal_London drop column pseudo_id;

END;
// DELIMITER ;
