USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas9UrineBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas9UrineBP1()
BEGIN

-- All since 2012

CALL populateDatasetBP1(
  'bp1_urinetestdataset',
  '463%,466%,467%,468%,469%,46A%,46X%,46f%,46M1.-46MA.,46ML.,46MR.,46R1.,46R2.,46R5.,46T%,46g%,',
  4,
  '2012-01-01',
  '4661.,467A.,467B.,467C.,467D.,467E.,467F.,467G.467H.,4681.,4691.,46A1.,46f1.,',
  0
);

END//
DELIMITER ;
