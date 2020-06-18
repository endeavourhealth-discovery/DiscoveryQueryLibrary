USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas4MedicalBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas4MedicalBP2()
BEGIN


-- earliest
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C10%,CTV3_C10%,CTV3_XaR5E%,CTV3_XaBU9%', 0, null, 'L1808,CTV3_L1808', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1434.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '66A%', 0, null, '66AX.,66Ay.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H33%,CTV3_H33%,CTV3_XaBU3%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B4.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '173c.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '173d.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1780.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1O2..', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '663%', 0, null, '6631%,6632%,6633%,6634%,6635%,6636%,6637%,6638%,6639%,663M.,663R.,663S.,663T.,663X.,663Y.,663Z.,663a.,663b.,663c.,663g%,663i.,663k.,663l.,663o.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C11%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J%,CTV3_J%', 0, null, 'J0%,J2%,CTV3_XaYMi,CTV3_Xa9C3%', 0); -- p2

CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C320%,CTV3_Xa9As%,CTV3_XaNZC%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C329.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C325%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C3272', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C3273', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C328.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A2.,CTV3_XE0Ub%,CTV3_XaBU4%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M6', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N6', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G2%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu2%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6627.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6628.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6629.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662F.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662G.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662H.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662O.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662P%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662b.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662c.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662d.', 0, null, null, 0);




CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A%,CTV3_X2003%,CTV3_XaQia,CTV3_XaIvG%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1O1..', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M5', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N5', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6626.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662D.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662E.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662J%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662K%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662N.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662S.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662T.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662U.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662W.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662Z.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662p.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G1%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G3%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G5%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G40%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G41%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'GA%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S3.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S4.', 0, null, null, 0);


CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A7.,CTV3_XE2te,CTV3_X00D1%,CTV3_14AB%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14AK.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M7', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N7', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662M%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662e.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G61%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G65%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G64%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G66%', 0, null, 'G669.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6760', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6W..', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6X..', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu62', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu63', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu64', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu65', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu66', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu6F', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu6G', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'ZV12D', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'ZV125', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Fyu55', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D1.,CTV3_X30Hc%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D2.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D3.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D8.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S2.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1Z1%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K0%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K10%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K120%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K122.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K131%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K132%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K138%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K13y1', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K13z0', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '1411.,CTV3_XaLJz,CTV3_X102V%,CTV3_H32%,CTV3_A1%,CTV3_X104H%,CTV3_H3%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14AC.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B2.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B3.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14BA.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S9.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A1%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H06%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H3%', 0, null, 'H33%', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H4%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H53%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H59%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '115P.,CTV3_X306R%,CTV3_XaLow', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '141E.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '141F.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14C5.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S8.', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A17y4', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A70%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J60%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J61%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J62%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J63%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '115T%,CTV3_XaacN%,CTV3_X78ef%,CTV3_XE0q0%', 0, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '142%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B0%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B1%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B2%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B3%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B4%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B5%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B6%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B7%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B8%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B9%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'BA%', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'BC…', 0, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'By%', 0, null, null, 0);

-- latest
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C10%,CTV3_C10%,CTV3_XaR5E%,CTV3_XaBU9%', 1, null, 'L1808,CTV3_L1808', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1434.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '66A%', 1, null, '66AX.,66Ay.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H33%,CTV3_H33%,CTV3_XaBU3%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B4.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '173c.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '173d.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1780.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1O2..', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '663%', 1, null, '6631%,6632%,6633%,6634%,6635%,6636%,6637%,6638%,6639%,663M.,663R.,663S.,663T.,663X.,663Y.,663Z.,663a.,663b.,663c.,663g%,663i.,663k.,663l.,663o.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C11%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J%,CTV3_J%', 1, null, 'J0%,J2%,CTV3_XaYMi,CTV3_Xa9C3%', 0); -- p2

CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C320%,CTV3_Xa9As%,CTV3_XaNZC%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C329.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C325%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C3272', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C3273', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'C328.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A2.,CTV3_XE0Ub%,CTV3_XaBU4%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M6', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N6', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G2%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu2%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6627.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6628.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6629.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662F.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662G.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662H.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662O.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662P%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662b.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662c.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662d.', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A%,CTV3_X2003%,CTV3_XaQia,CTV3_XaIvG%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '1O1..', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M5', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N5', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '6626.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662D.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662E.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662J%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662K%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662N.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662S.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662T.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662U.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662W.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662Z.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662p.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G1%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G3%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G5%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G40%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G41%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'GA%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S3.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S4.', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14A7.,CTV3_XE2te,CTV3_X00D1%,CTV3_14AB%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14AK.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661M7', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '661N7', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662M%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '662e.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G61%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G65%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G64%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G66%', 1, null, 'G669.', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6760', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6W..', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'G6X..', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu62', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu63', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu64', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu65', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu66', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu6F', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Gyu6G', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'ZV12D', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'ZV125', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'Fyu55', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D1.,CTV3_X30Hc%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D2.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D3.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14D8.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S2.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '1Z1%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K0%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K10%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K120%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K122.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K131%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K132%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K138%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K13y1', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'K13z0', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '1411.,CTV3_XaLJz,CTV3_X102V%,CTV3_H32%,CTV3_A1%,CTV3_X104H%,CTV3_H3%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '14AC.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B2.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14B3.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14BA.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S9.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A1%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H06%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H3%', 1, null, 'H33%', 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H4%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H53%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'H59%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '115P.,CTV3_X306R%,CTV3_XaLow', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '141E.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '141F.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14C5.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', '14S8.', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A17y4', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'A70%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J60%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J61%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J62%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'J63%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '115T%,CTV3_XaacN%,CTV3_X78ef%,CTV3_XE0q0%', 1, null, null, 0);

CALL populateDatasetBP2('bp2_medicalhistorydataset', '142%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B0%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B1%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B2%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B3%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B4%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B5%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B6%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B7%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B8%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'B9%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'BA%', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'BC…', 1, null, null, 0);
CALL populateDatasetBP2('bp2_medicalhistorydataset', 'By%', 1, null, null, 0); 

END//
DELIMITER ;
