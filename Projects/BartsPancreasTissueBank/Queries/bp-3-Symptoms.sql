use data_extracts;

drop procedure if exists executeBartsPancreas3Symptoms;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas3Symptoms ()
BEGIN

-- All since 2012
call populateDataset(
  'dataset_p_3',
  '162%,198%,161%,199%,19G..,19F%,19C%,R07%,195%,19B%,19D%,19A%,19E%,182%,R065%,196%,197%,16Z2.,16C%,R090%,1674.,1675.,R024%,1A4%,1N0%,G801D,G801F,G801G,G801H,G801J,G801z,8HTm.,1JC..,G401%,F051%,F053%,16J%,183%,R0930,R0931,R0932,R093z,M18%,',
  4,
  '2012-01-01',
  '19F4.,1966.,',
  0
);

END//
DELIMITER ;
