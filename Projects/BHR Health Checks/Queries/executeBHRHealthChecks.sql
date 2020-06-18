USE data_extracts;

DROP PROCEDURE IF EXISTS executeHealthChecks;

DELIMITER //
CREATE PROCEDURE executeHealthChecks()
BEGIN

  DECLARE quarterlyStartDate      DATE;
  DECLARE quarterlyEndDate        DATE;

  SET quarterlyStartDate = DATE_ADD(LAST_DAY(CURDATE()), INTERVAL -1 MONTH);
  SET quarterlyEndDate = DATE_ADD(DATE_SUB(CURDATE(), INTERVAL DAYOFMONTH(CURDATE())-1 DAY), INTERVAL -4 MONTH);

  -- SET quarterlyStartDate = '2020-01-01';
  -- SET quarterlyEndDate = '2020-04-30';

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

  CALL createHealthChecksCohorts(quarterlyStartDate, quarterlyEndDate); 
  CALL buildHcDatasets();
  CALL createHealthChecksCountCohorts();
  CALL buildHcCountDatasets();


END//
DELIMITER ;