USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS getAllSnomeds;

DELIMITER //

CREATE PROCEDURE getAllSnomeds(p_cat_id INT)
BEGIN

  DECLARE done           INT;
  DECLARE l_parent_id    BIGINT;

  DECLARE c_get_snomeds CURSOR FOR SELECT code FROM store WHERE id = p_cat_id ;
    
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SET done = 0;

        OPEN c_get_snomeds;

        iterator: 
        WHILE (done = 0) DO

             FETCH c_get_snomeds INTO l_parent_id;

             IF done = 1 THEN
                  LEAVE iterator;
             END IF;

             IF p_cat_id IN (1, 3) THEN

                   INSERT INTO snomeds (snomed_id, cat_id) 
                   SELECT  DISTINCT
                           CAST(l_parent_id AS UNSIGNED INTEGER) AS snomed_id,
                           p_cat_id    AS cat_id
                   UNION
                   SELECT  CAST(s.subtypeid AS UNSIGNED INTEGER) AS snomed_id, 
                           p_cat_id    AS cat_id
                   FROM rf2.sct2_transitiveclosure s
                   WHERE s.supertypeid = l_parent_id
                   AND s.active = 1
                   UNION
                   SELECT  CAST(s.subtypeid AS UNSIGNED INTEGER) AS snomed_id, 
                           p_cat_id    AS cat_id
                   FROM rf2.sct2_transitiveclosure s
                   WHERE s.supertypeid IN (SELECT s1.subtypeid
                                           FROM rf2.sct2_transitiveclosure s1
                                           WHERE s1.supertypeid = l_parent_id)
                   AND s.active = 1;
             
             ELSE
                   INSERT INTO snomeds (snomed_id, cat_id) 
                   SELECT CAST(l_parent_id AS UNSIGNED INTEGER)  AS snomed_id,
                          p_cat_id     AS cat_id;

             END IF;

        END WHILE iterator;
        CLOSE c_get_snomeds;
        SET done = 0;

END //
DELIMITER ;