USE data_extracts;

-- ahui 5/3/2020

DROP PROCEDURE IF EXISTS storeString;

DELIMITER //

CREATE PROCEDURE storeString (
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

    INSERT INTO store (id, code) VALUES (cat_id, TempValue);
    SET stringValue = INSERT(stringValue, 1, frontlen + 1, '');
    END LOOP;

END//
DELIMITER ;