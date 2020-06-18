drop procedure if exists addRead2CodesToCodeSet;

DELIMITER //
CREATE PROCEDURE addRead2CodesToCodeSet (
    IN codeSetId int,
    IN read_codes varchar (5000)
)
BEGIN

WHILE (LOCATE(',', read_codes) > 0)
DO
    SET @value = substring(read_codes, 1, LOCATE(',',read_codes)-1);
    SET read_codes= SUBSTRING(read_codes, LOCATE(',',read_codes) + 1);

    set @value = trim(@value);

    if (left(@value, 4) = 'EMIS') then
      insert into rf2.code_set_codes select codeSetId, @value, @value, '';
    end if;

    if (right(@value, 1) = '%') then

      insert into rf2.code_set_codes
  			select distinct codeSetId, r2.read_code, map.ctv3_concept_id, ''
  			from rf2.read2_codes r2
  			left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read_code
  			where ifnull(map.map_status, 1) = 1
  			and r2.read_code like @value
  			and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG';

      insert into rf2.code_set_codes
        select distinct codeSetId, map.read2_concept_id, map.ctv3_concept_id, ''
        from rf2.ctv3_to_read2_map map
        join rf2.tpp_ctv3_hierarchy_ref hier on hier.ctv3_child_read_code = map.ctv3_concept_id
        where ifnull(map.map_status, 1) = 1
        and hier.ctv3_parent_read_code like @value
        and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG';

      insert into rf2.code_set_codes
        select distinct codeSetId, map.read2_concept_id, map.ctv3_concept_id, ''
        from rf2.ctv3_to_read2_map map
        where map.ctv3_concept_id like @value
        and ifnull(map.map_status, 1) = 1
        and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG';

	else

		set @value = rpad(@value, 5,  '.');

		insert into rf2.code_set_codes
			select distinct codeSetId, r2.read_code, map.ctv3_concept_id, ''
			from rf2.read2_codes r2
			left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read_code
			where ifnull(map.map_status, 1) = 1
			and r2.read_code = @value
			and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG';

    insert into rf2.code_set_codes
      select distinct codeSetId, map.read2_concept_id, map.ctv3_concept_id, ''
      from rf2.ctv3_to_read2_map map
      where map.ctv3_concept_id = @value
      and ifnull(map.map_status, 1) = 1
      and ifnull(map.read2_concept_id, "") <> '_NONE' and ifnull(map.read2_concept_id, "") <> '_DRUG';

	end if;
END WHILE;
 END//
DELIMITER ;
