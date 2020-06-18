USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS storeSnomedString;

DELIMITER //

CREATE PROCEDURE storeSnomedString (
    IN stringValue VARCHAR(5000),
    IN cat_id      INT
)

BEGIN

       DECLARE front       VARCHAR(5000) DEFAULT NULL;
       DECLARE frontlen    INT           DEFAULT NULL;
       DECLARE TempValue   VARCHAR(5000) DEFAULT NULL;

    iterator:
    LOOP  
       IF LENGTH(TRIM(stringValue)) = 0 OR stringValue IS NULL THEN
         LEAVE iterator;
       END IF;

    SET front = SUBSTRING_INDEX(stringValue, ',', 1);
    SET frontlen = LENGTH(front);
    SET TempValue = TRIM(front);

    INSERT INTO gh2_store (id, org_snomed_id) VALUES (cat_id, CAST(TempValue AS SIGNED));
    SET stringValue = INSERT(stringValue, 1, frontlen + 1, '');
    END LOOP;

END//
DELIMITER ;