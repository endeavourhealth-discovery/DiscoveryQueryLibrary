use data_extracts;

drop procedure if exists populateDeltas;

DELIMITER //
CREATE PROCEDURE populateDeltas (
	IN tableName varchar (100),
	IN uniqueIdentifier varchar (100),
	IN deleteUniqueIdentifier bit
)
BEGIN
	DECLARE deltaTablename varchar (110);
	DECLARE previousTablename varchar (110);

	SET deltaTablename = CONCAT( tableName, '_delta');
	SET previousTablename = CONCAT( tableName, '_previous');

-- ADDITIONS

		SET @alterationsSql =
		CONCAT( 'insert into ', deltaTablename,
			" select t.* from ", tableName, " t left join ", previousTablename, " y on t.", uniqueIdentifier, " = y.", uniqueIdentifier, " where y.", uniqueIdentifier, " is null" );

		PREPARE alterationsSqlStatement FROM @alterationsSql;
		EXECUTE alterationsSqlStatement;
		DEALLOCATE PREPARE alterationsSqlStatement;

		SET @updateSql = CONCAT( 'update ', deltaTablename, ' set hash = "ADDITION"');

		PREPARE updateSqlStatement FROM @updateSql;
		EXECUTE updateSqlStatement;
		DEALLOCATE PREPARE updateSqlStatement;

-- DELETIONS

		SET @deletionsSql =
		CONCAT( 'insert into ', deltaTablename,
			" select y.* from ", tableName, " t right join ", previousTablename, " y on t.", uniqueIdentifier, " = y.", uniqueIdentifier, " where t.", uniqueIdentifier, " is null" );

		PREPARE deletionsSqlStatement FROM @deletionsSql;
		EXECUTE deletionsSqlStatement;
		DEALLOCATE PREPARE deletionsSqlStatement;

		SET @updateSql = CONCAT( 'update ', deltaTablename, ' set hash = "DELETION" where hash != "ADDITION"');

		PREPARE updateSqlStatement FROM @updateSql;
		EXECUTE updateSqlStatement;
		DEALLOCATE PREPARE updateSqlStatement;

-- ALTERATIONS

		SET @alterationsSql =
		CONCAT( 'insert into ', deltaTablename,
			" select t.* from ", tableName, " t join ", previousTablename, " y on t.", uniqueIdentifier, " = y.", uniqueIdentifier, " and t.hash != y.hash" );

		PREPARE alterationsSqlStatement FROM @alterationsSql;
		EXECUTE alterationsSqlStatement;
		DEALLOCATE PREPARE alterationsSqlStatement;

		SET @updateSql = CONCAT( 'update ', deltaTablename, ' set hash = "ALTERATION" where hash != "ADDITION" and  hash != "DELETION"');

		PREPARE updateSqlStatement FROM @updateSql;
		EXECUTE updateSqlStatement;
		DEALLOCATE PREPARE updateSqlStatement;

		-- Clean delta tablesALTER TABLE bhr_codes_delta CHANGE hash status varchar(20);
	SET @cleanSql =	CONCAT( 'alter table ', deltaTablename, " change hash status varchar(20)" );

	PREPARE cleanSqlStatement FROM @cleanSql;
	EXECUTE cleanSqlStatement;
	DEALLOCATE PREPARE cleanSqlStatement;

	if(deleteUniqueIdentifier = 1)  then
		SET @deleteUniqueIdentifierSql =	CONCAT( 'alter table ', deltaTablename, " drop column ", uniqueIdentifier );

		PREPARE cleanSqlStatement FROM @deleteUniqueIdentifierSql;
		EXECUTE cleanSqlStatement;
		DEALLOCATE PREPARE cleanSqlStatement;
	end if;

		-- Drop previous

		SET @dropSql = CONCAT( 'drop table  ', previousTablename );

		PREPARE dropSqlStatement FROM @dropSql;
		EXECUTE dropSqlStatement;
		DEALLOCATE PREPARE dropSqlStatement;

		-- Create previous table with same structure

		SET @copySql = CONCAT( 'create table ', previousTablename, ' like ', tableName);

		PREPARE copySqlStatement FROM @copySql;
		EXECUTE copySqlStatement;
		DEALLOCATE PREPARE copySqlStatement;

		--  over current to previous
		SET @insertSql = CONCAT( 'insert into ', previousTablename, ' select * from ', tableName);

		PREPARE insertSqlStatement FROM @insertSql;
		EXECUTE insertSqlStatement;
		DEALLOCATE PREPARE insertSqlStatement;

		-- -- Now clean up tableName by removing hash (NEEDED??)

		-- SET @cleanySql = CONCAT( 'alter table ', tableName, ' drop column hash');
		--
		-- PREPARE cleanSqlStatement FROM @cleanSql;
		-- EXECUTE cleanSqlStatement;
		-- DEALLOCATE PREPARE cleanSqlStatement;

END//

DELIMITER ;
