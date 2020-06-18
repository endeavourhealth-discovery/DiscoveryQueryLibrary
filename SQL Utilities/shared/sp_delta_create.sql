use data_extracts;

drop procedure if exists createDeltaTable;

DELIMITER //
CREATE PROCEDURE createDeltaTable (
	IN tableName varchar (100),
	IN columnsToHash varchar (1000)
)
BEGIN
	DECLARE deltaTablename varchar (110);
	SET deltaTablename = CONCAT( tableName, '_delta');

-- Add a hash column and calculate it based on columnsToHash
	SET @addHashColumnSql = CONCAT( 'alter table ', tableName, " add column hash CHAR(32) not null" );

	PREPARE addHashColumnSqlStatement FROM @addHashColumnSql;
	EXECUTE addHashColumnSqlStatement;
	DEALLOCATE PREPARE addHashColumnSqlStatement;

	SET @hashSql = CONCAT( 'update ', tableName, " set hash = md5(CONCAT(", columnsToHash, "))" );

	PREPARE hashStatement FROM @hashSql;
	EXECUTE hashStatement;
	DEALLOCATE PREPARE hashStatement;

-- Create a tablename_delta table
	SET @dropDeltaTable = CONCAT( 'drop table if exists ', deltaTablename );

	PREPARE dropDeltaTableStatement FROM @dropDeltaTable;
	EXECUTE dropDeltaTableStatement;
	DEALLOCATE PREPARE dropDeltaTableStatement;

	SET @createDeltaTable = CONCAT( 'create table ', deltaTablename, ' like ', tablename );

	PREPARE createDeltaTableStatement FROM @createDeltaTable;
	EXECUTE createDeltaTableStatement;
	DEALLOCATE PREPARE createDeltaTableStatement;

-- As deltaTablename column definitions have to be same as datatable in order to use insert into select * from table
-- must use hash as store for status. Hash is binary, so convert to varchar
--	SET @convertHashColumnSql =	CONCAT( 'alter table ', deltaTablename, " modify column hash varchar(50)" );

--	PREPARE convertHashColumnStatement FROM @convertHashColumnSql;
--	EXECUTE convertHashColumnStatement;
--	DEALLOCATE PREPARE convertHashColumnStatement;

END//

DELIMITER ;
