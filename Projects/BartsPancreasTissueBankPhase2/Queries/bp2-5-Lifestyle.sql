USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas5LifestyleBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas5LifestyleBP2()
BEGIN

-- Lifestyle ever

CALL populateDatasetBP2('bp2_lifestyledataset',
  '137%,136%,1462.,1463.,146E.,146F.,13c%,CTV3_Ub1nZ%,CTV3_XaBUG%,CTV3_E251%,CTV3_Ub0lD%,CTV3_XE1YQ%,CTV3_Xabi7,CTV3_Xabi8,CTV3_Xabi9,CTV3_XaJz5%,CTV3_Ub0mp%,CTV3_XaJzi%,CTV3_XaMyB%,CTV3_X00S3,CTV3_X00S4,CTV3_XE1YR%',
  2,
  null,
  '137C.,137D.,137E.,137G.,137I.,137Q.,137U.,137V.,137W.,137b.,137c.,137d.,137e.,137f.,137h.,137i.,137k.,137m.,1369.,136a.,136b.,136c.,136d.,136e.,13c2.,13c5.,13c6.,13c8.,13cg%,13cL.,13cM.,13cN.,13cO.,13cP.,13cQ.,13cR.,13cS.,13cT.,CTV3_XaXPD,CTV3_XaJX2,CTV3_XaWNE,CTV3_XaLQh,CTV3_Xaa26,CTV3_Ub0nz%,CTV3_Ub0ma,CTV3_Ub0mb,CTV3_Ub0mc,CTV3_Ub0md,CTV3_Ub0me,CTV3_Ub0mf,CTV3_Ub0mg,CTV3_Ub0mh,CTV3_Ub0mi,CTV3_Ub0mj,CTV3_Ub0mk,CTV3_Ub0ml,CTV3_Ub0mm,CTV3_Ub0mE,CTV3_Ub0mF,CTV3_Ub0mG,CTV3_Ub0mH,CTV3_Ub0mI,CTV3_Ub0mJ,CTV3_Ub0mK,CTV3_Ub0mL,CTV3_Ub0mM,CTV3_Ub0mN,CTV3_Ub0mO,CTV3_Ub0mP,CTV3_Ub0mQ,CTV3_Ub0mR,CTV3_Ub0mS,CTV3_Ub0mT,CTV3_Ub0mU,CTV3_Ub0mV,CTV3_Ub0mW,CTV3_Ub0mX,CTV3_Ub0mY,CTV3_Ub0mZ',
  0
);


END//
DELIMITER ;