USE data_extracts;

DROP PROCEDURE IF EXISTS addCodesToCodesetBP1;

DELIMITER //

CREATE PROCEDURE addCodesToCodesetBP1(
    IN codeSetId     INT,
    IN codesToAdd    VARCHAR(10000),
    IN codesToRemove VARCHAR(5000)
)
BEGIN

-- Reset
DELETE FROM code_set_codes WHERE code_set_id = codeSetId;

WHILE (LOCATE(',', codesToAdd) > 0)
DO
    SET @value = SUBSTRING(codesToAdd, 1, LOCATE(',', codesToAdd) - 1);
    SET codesToAdd = SUBSTRING(codesToAdd, LOCATE(',', codesToAdd) + 1);

    SET @value = trim(@value);

IF (left(@value, 4) = 'EMIS') THEN

      INSERT INTO code_set_codes SELECT codeSetId, @value, "", 'EMIS';

ELSE 
      
      IF (right(@value, 1) = '%') THEN
  
         INSERT INTO code_set_codes
         SELECT codeSetId, r2.read2_code, "", "read2"
         FROM read2_codes r2
         WHERE r2.read2_code LIKE @value;

      ELSE

         SET @value = rpad(@value, 5,  '.');
         INSERT INTO code_set_codes SELECT codeSetId,  @value, "", "";
       
      END IF;

END IF;

END WHILE;

-- remove codes
WHILE (LOCATE(',', codesToRemove) > 0)
DO
    SET @value = SUBSTRING(codesToRemove, 1, LOCATE(',', codesToRemove) - 1);
    SET codesToRemove = SUBSTRING(codesToRemove, LOCATE(',', codesToRemove) + 1);

    SET @value = trim(@value);

    IF (right(@value, 1) = '%') THEN

        DELETE csc FROM code_set_codes csc WHERE (csc.read2_concept_id LIKE @value OR csc.read2_concept_id like @value) AND code_set_id = codeSetId;
        
    ELSE

        SET @value = rpad(@value, 5,  '.');
        DELETE csc FROM code_set_codes csc WHERE (csc.read2_concept_id = @value OR csc.read2_concept_id = @value) AND code_set_id = codeSetId;
        
    END IF;

END WHILE;


END//
DELIMITER ;
