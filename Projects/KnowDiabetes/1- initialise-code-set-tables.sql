use data_extracts;

drop procedure if exists initialiseSnomedCodeSetTables;

DELIMITER //
CREATE PROCEDURE initialiseSnomedCodeSetTables()
BEGIN

	create table if not exists snomed_code_set (
		codeSetId int not null,
		codeSetName varchar(200) not null
	);

	create table if not exists snomed_code_set_codes (
		codeSetId int not null,
		snomedCode bigint not null
	);

END//
DELIMITER ;



