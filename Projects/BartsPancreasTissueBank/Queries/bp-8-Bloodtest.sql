use data_extracts;

drop procedure if exists executeBartsPancreas8BloodTest;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas8BloodTest ()
BEGIN

-- All since 2012

call populateDataset(
  'dataset_p_8',
  '423%,42H%,42P1.,42P2.,42P3.,42P4.,42PZ.,42QE%,44M4.%,44MI.,44I5%,44h1.,44h6.,44I4%,44h0.,44h8.,44J1.,44J2.,44J8.,44J9.,44JA.,44JB.,44J3%,44JC.,44JD.,44JF.,451K.,451M.,451N.,44E1.,44E2.,44E3.,44E6.,44E9.,44EC.,44EZ.,44G3%,44H5%,44HB.,44HC.,44CU.,44F1.,44F2.,44F3.,44FZ.,44G4%,44G7.,44G8.,44G9.,44CC%,44a0%,44a1.,44a2%,44a3%,44a6%,44a4.,44a5.,44M1.,44M2.,44M3%,44M6.,44M7.,44M8.,44M9.,44MA.,',
  4,
  '2012-01-01',
  '4231.,4232.,4233.,423C.,42H4.,42H6.,',
  0
);



END//
DELIMITER ;
