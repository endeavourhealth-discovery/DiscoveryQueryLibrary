USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS createTabsForGH2;

DELIMITER //
CREATE PROCEDURE createTabsForGH2()
BEGIN

DROP TABLE IF EXISTS gh2_snomeds;

CREATE TABLE gh2_snomeds (
  cat_id       INT,
  snomed_id    BIGINT
);

ALTER TABLE gh2_snomeds ADD INDEX gh2_cat_idx (cat_id);
ALTER TABLE gh2_snomeds ADD INDEX gh2_sno_idx (snomed_id);

DROP TABLE IF EXISTS gh2_store;

CREATE TABLE gh2_store (
   id            INT,
   org_snomed_id BIGINT
);

ALTER TABLE gh2_store ADD INDEX gh2_store_idx (org_snomed_id);

END //
DELIMITER ;