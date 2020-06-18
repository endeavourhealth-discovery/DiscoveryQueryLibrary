drop procedure if exists addMixedCodesToCodeSetNew;

DELIMITER //
CREATE PROCEDURE addMixedCodesToCodeSetNew (
    IN codeSetId int,
    IN mixed_codes varchar (5000)
)
BEGIN

WHILE (LOCATE(',', mixed_codes) > 0)
DO
    SET @value = substring(mixed_codes, 1, LOCATE(',',mixed_codes)-1);
    SET mixed_codes= SUBSTRING(mixed_codes, LOCATE(',',mixed_codes) + 1);

    set @value = trim(@value);

    if (left(@value, 4) = 'EMIS') then
      insert into rf2.code_set_codes select codeSetId, @value, @value, 'e';

else if (right(@value, 1) = '%') then

		insert into rf2.code_set_codes
			select distinct codeSetId, r2.read2_code, map.ctv3_concept_id, r2.description
			from jack.read2_codes r2
			left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read2_code
			left outer join rf2.code_set_codes csc on csc.read2_concept_id = r2.read2_code and csc.code_set_id = codeSetId
			where ifnull(map.map_status, 1) = 1
			and r2.read2_code like @value
			and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG'
			and csc.read2_concept_id is null;
else
		set @value = rpad(@value, 5,  '.');

		insert into rf2.code_set_codes
			select distinct codeSetId, r2.read2_code, map.ctv3_concept_id, '1'
			from jack.read2_codes r2
			left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read2_code
            left outer join rf2.code_set_codes csc on csc.ctv3_concept_id = map.ctv3_concept_id and csc.read2_concept_id = r2.read2_code and csc.code_set_id = codeSetId
			where ifnull(map.map_status, 1) = 1
			and r2.read2_code = @value
			and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG'
			and csc.ctv3_concept_id is null;

	end if;
end if;
END WHILE;
 END//
DELIMITER ;
