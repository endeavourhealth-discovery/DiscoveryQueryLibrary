use data_extracts;

drop procedure if exists addCodesToCodesetFinal;

DELIMITER //

CREATE PROCEDURE addCodesToCodesetFinal (
    IN codeSetId int,
    IN mixed_codes varchar (5000)
)
BEGIN

-- Reset
delete from code_set_codes where code_set_id = codeSetId;

WHILE (LOCATE(',', mixed_codes) > 0)
DO
    SET @value = substring(mixed_codes, 1, LOCATE(',',mixed_codes)-1);
    SET mixed_codes= SUBSTRING(mixed_codes, LOCATE(',',mixed_codes) + 1);

    set @value = trim(@value);

if (left(@value, 4) = 'EMIS') then
  insert into code_set_codes select codeSetId, @value, "", 'EMIS';

else if (right(@value, 1) = '%') then
  insert into code_set_codes
			select codeSetId, r2.read2_code, "", "read2"
			from read2_codes r2
			where r2.read2_code like @value;

else
		set @value = rpad(@value, 5,  '.');
		insert into code_set_codes	select codeSetId,  @value, "", "";
end if;

end if;

END WHILE;
 END//
DELIMITER ;
