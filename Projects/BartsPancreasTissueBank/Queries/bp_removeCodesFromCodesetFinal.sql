use data_extracts;

drop procedure if exists removeCodesFromCodesetFinal;

DELIMITER //

CREATE PROCEDURE removeCodesFromCodesetFinal (
    IN codeSetId int,
    IN read_codes varchar (5000)
)
BEGIN

WHILE (LOCATE(',', read_codes) > 0)
DO
    SET @value = substring(read_codes, 1, LOCATE(',',read_codes)-1);
    SET read_codes= SUBSTRING(read_codes, LOCATE(',',read_codes) + 1);

    set @value = trim(@value);

	if (right(@value, 1) = '%') then

        delete csc from code_set_codes csc where
			(csc.read2_concept_id like @value or csc.read2_concept_id like @value) and code_set_id = codeSetId;
	else

		set @value = rpad(@value, 5,  '.');
		delete csc from code_set_codes csc where
			(csc.read2_concept_id = @value or csc.read2_concept_id = @value) and code_set_id = codeSetId;
	end if;
END WHILE;
 END//
DELIMITER ;
