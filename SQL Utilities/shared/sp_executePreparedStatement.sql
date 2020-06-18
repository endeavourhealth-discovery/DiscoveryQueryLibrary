use data_extracts;

drop procedure if exists executePreparedStatement;

DELIMITER //
CREATE PROCEDURE executePreparedStatement (
	IN sql varchar (3000)
)
BEGIN

	PREPARE sqlStatement FROM @sql;
	EXECUTE sqlStatement;
	DEALLOCATE PREPARE sqlStatement;

END//

DELIMITER ;
