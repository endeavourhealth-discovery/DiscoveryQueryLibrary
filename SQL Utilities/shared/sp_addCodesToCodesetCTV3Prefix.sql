use data_extracts;

drop procedure if exists addCodesToCodesetCTVPrefix;

DELIMITER //

CREATE PROCEDURE addCodesToCodesetCTVPrefix (
    IN codeSetId int,
    IN codesToAdd varchar (10000),
    IN codesToRemove varchar(5000)
)
BEGIN

-- Reset
delete from code_set_codes where code_set_id = codeSetId;

WHILE (LOCATE(',', codesToAdd) > 0)
DO
    SET @value = substring(codesToAdd, 1, LOCATE(',', codesToAdd) - 1);
    SET codesToAdd= substring(codesToAdd, LOCATE(',', codesToAdd) + 1);

    set @value = trim(@value);

if (left(@value, 4) = 'EMIS') then
  insert into code_set_codes select codeSetId, @value, "", 'EMIS';

else if (right(@value, 1) = '%') then
  insert into code_set_codes
			select codeSetId, r2.read2_code, "read2", ""
			from read2_codes r2
			where r2.read2_code like @value;

else

   	set @value = rpad(@value, 5,  '.');
    set @codeType = 'read2';

	IF NOT EXISTS (SELECT * FROM read2_codes r2 WHERE r2.read2_code = @value LIMIT 1) THEN
      	set @value= concat("CTV3_", @value);
          set @codeType = 'ctv3';
   END IF;

		insert into code_set_codes	select codeSetId,  @value, @codeType, "";
end if;

end if;

END WHILE;

-- remove codes
WHILE (LOCATE(',', codesToRemove) > 0)
DO
    SET @value = substring(codesToRemove, 1, LOCATE(',', codesToRemove) - 1);
    SET codesToRemove = substring(codesToRemove, LOCATE(',', codesToRemove) + 1);

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
