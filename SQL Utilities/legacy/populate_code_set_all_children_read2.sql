drop procedure if exists populate_code_set_all_children_read2;

DELIMITER //
CREATE PROCEDURE populate_code_set_all_children_read2 (
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
		set @value = trim('%' from @value);
		set @value = rpad(@value, 5,  '.');
		
        insert into rf2.code_set_codes 
		select distinct codeSetId, r2.read_code, map.ctv3_concept_id, ''
		from rf2.read2_codes r2
        left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read_code
        left outer join rf2.code_set_codes csc on csc.ctv3_concept_id = map.ctv3_concept_id and csc.read2_concept_id = r2.read_code and csc.code_set_id = codeSetId
		where isnull(map.map_status, 1) = 1
		and r2.read_code like @value
		and map.read2_concept_id <> '_NONE' and map.read2_concept_id <> '_DRUG'
        and csc.ctv3_concept_id is null;
        
	else
    
		set @value = rpad(@value, 5,  '.');                     
                
		insert into rf2.code_set_codes 
		select distinct codeSetId, r2.read_code, map.ctv3_concept_id, ''
		from rf2.read2_codes r2
        left outer join rf2.ctv3_to_read2_map map on map.read2_concept_id = r2.read_code
        left outer join rf2.code_set_codes csc on csc.ctv3_concept_id = map.ctv3_concept_id and csc.read2_concept_id = r2.read_code and csc.code_set_id = codeSetId
		where r2.read_code = @value
		and isnull(map.map_status, 1) = 1
		and map.read2_concept_id <> '_NONE' and map.read2_concept_id <> '_DRUG'
        and csc.ctv3_concept_id is null;
	end if;
END WHILE;
 END//
DELIMITER ;