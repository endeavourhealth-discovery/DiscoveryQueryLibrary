use data_extracts;

drop procedure if exists executeBartsPancreas1BasicBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas1BasicBP2()
BEGIN

-- earliest
-- CALL populateDatasetBP2('bp2_basicdataset', '9155.,', 0, null, null, 0); -- DOB
-- CALL populateDatasetBP2('bp2_basicdataset', '915B.,', 0, null, null, 0); -- NHS
-- CALL populateDatasetBP2('bp2_basicdataset', '1K%,', 0, null, null, 0);  -- Gender
CALL populateDatasetBP2('bp2_basicdataset', '94E..,CTV3_XaJOG', 0, null, null, 0); -- Date of death
CALL populateDatasetBP2('bp2_basicdataset', '94B..,CTV3_XE2IM', 0, null, null, 0); -- Cause of death

-- earliest p2

CALL populateDatasetBP2('bp2_basicdataset', '134%,CTV3_XaAzG%', 0, null, null, 0); -- Country of origin

CALL populateDatasetBP2('bp2_basicdataset', 'CTV3_Xa8Es%', 0, null, null, 0); -- Race

CALL populateDatasetBP2('bp2_basicdataset', '9S%,CTV3_XactE%', 0, null, null, 0);  -- Ethnic groups (census)
CALL populateDatasetBP2('bp2_basicdataset', '9i%,CTV3_XaJQu%', 0, null, null, 0);  -- Ethnic groups (census)  -- added for phase 2

-- latest p2

CALL populateDatasetBP2('bp2_basicdataset', '134%,CTV3_XaAzG%', 1, null, null, 0); -- Country of origin

CALL populateDatasetBP2('bp2_basicdataset', 'CTV3_Xa8Es%', 1, null, null, 0); -- Race

CALL populateDatasetBP2('bp2_basicdataset', '9S%,CTV3_XactE%', 1, null, null, 0);  -- Ethnic groups (census)
CALL populateDatasetBP2('bp2_basicdataset', '9i%,CTV3_XaJQu%', 1, null, null, 0);  -- Ethnic groups (census)

-- Since 2002

-- height
CALL populateDatasetBP2(
  'bp2_basicdataset',
  '229..,229Z.,CTV3_229..,CTV3_229Z.,CTV3_X76Bt',
  4,
  '2002-01-01',   
  null,
  0
);

-- weight
CALL populateDatasetBP2(
  'bp2_basicdataset',
  '22A.., 22AZ.,CTV3_22A..,CTV3_22AZ.,CTV3_X76CE%,CTV3_Ua17A',
  4,
  '2002-01-01',   
  null,
  0
);

-- BMI & obesity
CALL populateDatasetBP2(
  'bp2_basicdataset',
  '22K..,CTV3_22K..,CTV3_XaZcl,CTV3_Xa7wG%',
  4,
  '2002-01-01',  
  '22K9%,22KA.,22KB.',
  0
);

-- Peak flow
CALL populateDatasetBP2(
  'bp2_basicdataset',
  '339%,CTV3_339%,CTV3_XS7q5',
  4,
  '2002-01-01',
  null,
  0
);

-- Blood pressure
CALL populateDatasetBP2(
  'bp2_basicdataset',
  '246%,CTV3_X773t%',
  4,
  '2002-01-01',
  null,
  0
);

END//
DELIMITER ;
