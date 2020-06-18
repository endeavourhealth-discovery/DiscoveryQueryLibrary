USE data_extracts;

-- ahui 19/2/2020

DROP PROCEDURE IF EXISTS elgh2execute;

DELIMITER //
CREATE PROCEDURE elgh2execute()
BEGIN

SET SQL_SAFE_UPDATES=0;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
CALL gh2execute1();
CALL gh2execute2();
CALL gh2execute3();
CALL gh2execute4();
CALL gh2execute5();
CALL gh2execute6();
CALL gh2execute7();
CALL gh2execute8();
CALL gh2execute9();
CALL gh2execute10();
CALL gh2execute11();
CALL gh2execute12();
CALL gh2execute13();
CALL gh2execute14();
CALL gh2execute15();
CALL gh2execute16();
CALL gh2execute17();
CALL gh2execute18();
CALL gh2execute19();

SET SQL_SAFE_UPDATES=1;

END //
DELIMITER ;

