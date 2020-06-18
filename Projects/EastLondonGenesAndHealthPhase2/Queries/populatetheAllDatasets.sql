USE data_extracts;

-- -- ahui 8/2/2020

DROP PROCEDURE IF EXISTS populatetheAllDatasetsV2;

DELIMITER //

CREATE PROCEDURE populatetheAllDatasetsV2 (
    IN datasetTable     VARCHAR(100),    -- table name of dataset
    IN codesToAdd1      VARCHAR(5000),   -- all parents and their children
    IN codesToAdd2      VARCHAR(5000),   -- parents only
    IN codesToRemove3   VARCHAR(5000),   -- parents and their children to be excluded
    IN codesToRemove4   VARCHAR(5000),   -- just parents to be excluded
    IN ignorenulls      VARCHAR(1)
)

BEGIN

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds

    IF codesToAdd1 IS NOT NULL THEN
       CALL storeSnomedString (codesToAdd1, 1);
       CALL getAllSnomedsFromSnomedString (1);
    END IF;

    IF codesToAdd2 IS NOT NULL THEN
       CALL storeSnomedString (codesToAdd2, 2);
       CALL getAllSnomedsFromSnomedString (2);
    END IF;

    IF codesToRemove3 IS NOT NULL THEN
       CALL storeSnomedString (codesToRemove3, 3);
       CALL getAllSnomedsFromSnomedString (3);
    END IF;

    IF codesToRemove4 IS NOT NULL THEN
       CALL storeSnomedString (codesToRemove4, 4);
       CALL getAllSnomedsFromSnomedString (4);
    END IF;

CALL filterObservationsV2(2, 1, ignorenulls);  -- all historical results

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

IF (datasetTable IN ('gh2_weightALLdataset','gh2_heightALLdataset','gh2_BMIALLdataset','gh2_SBPALLdataset','gh2_DBPALLdataset')) THEN

   CREATE TEMPORARY TABLE qry_tmp (
      row_id                  INT,
      group_by                VARCHAR(255),
      original_code           BIGINT,
      original_term           VARCHAR(200),
      result_value            DOUBLE,
      result_value_units      VARCHAR(50),
      clinical_effective_date DATE,
      age_at_event            INT, PRIMARY KEY(row_id)
   ) AS
   SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.original_code,
       a.original_term,
       a.result_value,
       a.result_value_units,
       a.clinical_effective_date,
       a.age_at_event
   FROM (SELECT DISTINCT
             f.group_by,
             f.original_code,
             f.original_term,
             f.result_value,
             f.result_value_units,
             f.clinical_effective_date,
             f.age_years - ( year(now()) - year(f.clinical_effective_date)) AS age_at_event
   FROM filteredObservationsV2 f) a, (SELECT @row_no := 0) t
   WHERE a.result_value <> 0; 

ELSE

   CREATE TEMPORARY TABLE qry_tmp (
      row_id                  INT,
      group_by                VARCHAR(255),
      original_code           BIGINT,
      original_term           VARCHAR(200),
      result_value            DOUBLE,
      result_value_units      VARCHAR(50),
      clinical_effective_date DATE,
      age_at_event            INT, PRIMARY KEY(row_id)
   ) AS
   SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.original_code,
       a.original_term,
       a.result_value,
       a.result_value_units,
       a.clinical_effective_date,
       a.age_at_event
   FROM (SELECT DISTINCT
             f.group_by,
             f.original_code,
             f.original_term,
             f.result_value,
             f.result_value_units,
             f.clinical_effective_date,
             f.age_years - ( year(now()) - year(f.clinical_effective_date)) AS age_at_event
   FROM filteredObservationsV2 f) a, (SELECT @row_no := 0) t; 

END IF;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

   SET @sql = CONCAT('INSERT INTO ', datasetTable, ' (pseudo_id, pseudo_nhsnumber, code, term, value, units, date, age_at_event)  
         SELECT q.group_by                AS pseudo_id, 
                q.group_by                AS pseudo_nhsnumber,
                q.original_code           AS code,
                q.original_term           AS term,
                q.result_value            AS value, 
                q.result_value_units      AS units, 
                q.clinical_effective_date AS effective_date, 
                q.age_at_event            AS age_at_event
         FROM qry_tmp q WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000');

   PREPARE sqlstmt FROM @sql;
   EXECUTE sqlstmt;
   DEALLOCATE PREPARE sqlstmt;

   SET @row_id = @row_id + 1000; 

END WHILE;

END//

DELIMITER ;