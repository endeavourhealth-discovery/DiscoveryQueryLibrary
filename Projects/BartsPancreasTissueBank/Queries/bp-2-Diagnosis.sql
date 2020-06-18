use data_extracts;

drop procedure if exists executeBartsPancreas2Diagnosis;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas2Diagnosis ()
BEGIN

-- All since 2012
call populateDataset(
  'dataset_p_2',
  'B12%,B15%,B16%,B17%,Byu10,Byu11,Byu12,B574%,B577%,B807%,B808%,B80z0,ByuF0,B712%,B715%,B716%,B717%,ByuG3,B903%,B9021,B9022,B9023,B9051,J30%,J32%,J33%,Jyu3%,J6%,Jyu7%,Jyu8%,',
  4,
  '2012-01-01',
  'J62%, J68%, J69%,',
  0
);

END//
DELIMITER ;
