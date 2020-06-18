USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas5LifestyleBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas5LifestyleBP1()
BEGIN

-- Lifestyle ever

CALL populateDatasetBP1('bp1_lifestyledataset',
  '137%,136%,1462.,1463.,146E.,146F.,13c%,',
  2,
  null,
  '137C.,137D.,137E.,137G.,137I.,137Q.,137U.,137V.,137W.,137b.,137c.,137d.,137e.,137f.,137h.,137i.,137k.,137m.,1369.,136a.,136b.,136c.,136d.,136e.,13c2.,13c5.,13c6.,13c8.,13cg%,13cL.,13cM.,13cN.,13cO.,13cP.,13cQ.,13cR.,13cS.,13cT.,',
  0
);


END//
DELIMITER ;
