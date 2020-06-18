drop procedure if exists remove_excluded_codes_from_code_set;

DELIMITER //
CREATE PROCEDURE remove_excluded_codes_from_code_set (
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
		
        delete csc
        from rf2.code_set_codes csc
		join reference.ctv3_to_read2_map map on map.ctv3_concept_id = csc.ctv3_concept_id
		join publisher_common.tpp_ctv3_hierarchy_ref hier on hier.ctv3_child_read_code = map.ctv3_concept_id
		where map.map_status = 1
		and hier.ctv3_parent_read_code = @value
		and map.read2_concept_id <> '_NONE' and map.read2_concept_id <> '_DRUG';
	else
    
		set @value = rpad(@value, 5,  '.');                     
                
		delete csc
        from rf2.code_set_codes csc
		join reference.ctv3_to_read2_map map on map.ctv3_concept_id = csc.ctv3_concept_id
		where map.ctv3_concept_id = @value
		and map.map_status = 1
		and map.read2_concept_id <> '_NONE' and map.read2_concept_id <> '_DRUG';
	end if;
END WHILE;
 END//
DELIMITER ;