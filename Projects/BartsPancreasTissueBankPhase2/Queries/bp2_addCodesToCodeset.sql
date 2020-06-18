USE data_extracts;

-- ahui 25/3/2020

DROP PROCEDURE IF EXISTS addCodesToCodesetBP2;

DELIMITER //

CREATE PROCEDURE addCodesToCodesetBP2 (p_cat_id INT)
BEGIN

  DECLARE done           BOOLEAN DEFAULT FALSE;
  DECLARE l_parent_code  VARCHAR(20);
  DECLARE l_right_code   VARCHAR(20);
  DECLARE l_sub_code     VARCHAR(20);

  DECLARE c_get_code CURSOR FOR SELECT code, RIGHT(code,1) right_code, SUBSTRING(code, 1, 5) sub_code FROM store WHERE id = p_cat_id;
    
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;


        OPEN c_get_code;

        cursor_loop: LOOP

             FETCH c_get_code INTO l_parent_code, l_right_code, l_sub_code;

            IF done THEN
                  CLOSE c_get_code;
                  LEAVE cursor_loop;
            END IF;

            IF p_cat_id IN (1, 2) THEN
                
               IF  (l_right_code = '%') THEN
 
                    IF (l_sub_code = 'CTV3_') THEN

                        SET l_parent_code = SUBSTRING(l_parent_code,6);
                     
                        INSERT INTO code_set_codes_bp2 (cat_id, code) 
                        SELECT p_cat_id, CONCAT('CTV3_', h.ctv3_child_read_code) AS code 
                        FROM tpp_ctv3_hierarchy_ref_tmp h WHERE h.ctv3_parent_read_code LIKE CONVERT(l_parent_code USING latin1);  

                    ELSE 

                         INSERT INTO code_set_codes_bp2 (cat_id, code)
                         SELECT p_cat_id, r2.read2_code 
                         FROM read2_codes_tmp r2 WHERE r2.read2_code LIKE CONVERT(l_parent_code USING latin1);

                    END IF; 
                
               END IF;   

               IF (l_right_code != '%') THEN
                    
                   IF (l_sub_code = 'CTV3_') THEN

                        INSERT INTO code_set_codes_bp2 (cat_id, code) SELECT p_cat_id, CONCAT('CTV3_',RPAD(SUBSTRING(l_parent_code,6),5,'.'));

                   ELSE

                        INSERT INTO code_set_codes_bp2 (cat_id, code) SELECT p_cat_id, RPAD(l_parent_code,5,'.');

                   END IF;


               END IF;             

             END IF;

        END LOOP cursor_loop;


END //
DELIMITER ;