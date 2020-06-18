
-- ELGH - Myocardial infarction
call populateCodeDate(1, 'MI', 'dataset1c', 0, 'G30%, G32%, G38%, G3115%,', null);

-- ELGH - Congestive heart failure
call populateCodeDate(1, 'CHF', 'dataset1c', 0, 'G58%, G58113%, G343%, G5544%, G555%, G55y%, G5yy9%, G1yz1, 662f, 662g, 662h, 662i,', null);

-- ELGH - Peripheral vascular disease or bypass
call populateCodeDate(1, 'PVD', 'dataset1c', 0, 'G73%, Gyu74%,', null);

-- ELGH - Cerebrovascular disease or transient ischemic disease
call populateCodeDate(1, 'CVA', 'dataset1c', 0, 'G61%, G63y0%, G63y1%, G64%, G66%, G6760%, G6W%, G6X%, Gyu62%, Gyu63%, Gyu64%, Gyu65%,Gyu66%, Gyu6F%, Gyu6G%, ZV12D%, Fyu55%, G65%, G65z%.,', null);

-- ELGH - Hemiplegia
call populateCodeDate(1, 'PLEGIA', 'dataset1c', 0, 'F22%, F23%, F241%, F2A%, F038%, F141%.,', null);

-- ELGH - Pulmonary disease/asthma
call populateCodeDate(1, 'COPD', 'dataset1c', 0, 'H5%, Hyu30%, H3%, H4%, H36, H37, H38, H39, H3A, H3B, H3z, H4640, H4641, H5832, Hyu31., 173A,', null);

-- ELGH - Diabetes
call populateCodeDate(1, 'DM', 'dataset1c', 0, 'C100%, C1099%, C109J, C10E, C10E4%, C10E9%, C10EA%, C10F9%, C10FJ%, C10FR%, Cyu20%.,', null);

-- ELGH - Diabetes with end organ damage
call populateCodeDate(1, 'DMENDORGAN', 'dataset1c', 0, '7276%, C101%, C102%, C103%, C104%, C105%, C106%, C107%, C108%, C1090%, C1091%, C1092%, C1093%, C1094%, C1095%, C1096%, C109A%, C109B%, C109C%, C109E%, C109F%, C109G%, C109H%, C10E0%, C10E1%, C10E2%, C10E3%, C10E5%, C10E6%, C10E7%, C10EB%, C10EC%, C10ED%, C10EF%, C10EG%, C10EH%, C10EJ%, C10F1, C10F2, C10F3, C10F4, C10F5, C10F6, C10FA, C10FB, C10FC, C10FE, C10FF, C10FG, C10FH, F372%, K01x1%, K081%, K27y7%, Cyu23%, C31411%,', null);

-- ELGH - Renal disease
call populateCodeDate(1, 'RENAL', 'dataset1c', 0, '1Z1%, ZV451%, ZV560%, SP154%, Kyu2%, K0D%, K05%, K06%, K07%,', null);

-- ELGH - Liver disease
call populateCodeDate(1, 'LIVER', 'dataset1c', 0, '43B211%, 43B4%, 43B6%, 43XA%, 9kZ%, 8BB5%, 9kV%, 9NgR%, AyuB%, J61%, ZV026%, ZV02B%, ZV02C%, C3708%, J62%, Jyu7%, J6617%, PB6y%, PB62%, PB61%,  G81%, G82%, C31%, C35%, C3761%, C3762%, C3742%, B15%, BB5D%, J63%, A7073, A703%, A7071, A70z0, A7072, A70G, A7050, EMISNQVI15, A7051, A7070, A7052, AyuB1, AyuB2, A701, A7054, A705z, A707X, A70z1, A709,', null);

-- ELGH - Severe liver disease
call populateCodeDate(1, 'SEVERELIVER', 'dataset1c', 0, 'J615A%, J615B%, J615C%, J615y, J615G, J615F, J6150, J6151, J6152, J6154, J6155, J6156, J6157, J6158, J6159, J612%, SP086%, TB002%, ZV427%,', 'J61y3, J615y, J615G, J615F, J615B, J615A, J6150, J6151, J6152, J6154, J6155, J6156, J6157, J6158, J6159, J612%,');

-- ELGH - Gastric or peptic ulcer
call populateCodeDate(1, 'ULCER', 'dataset1c', 0, 'J11%, J12%, J13%, 4JQB, 14C1, ZV127-1 (syn), 1956,', null);

-- ELGH - Cancer (lymphoma, leukemia, solid tumour) exc skin
call populateCodeDate(1, 'CANCER', 'dataset1c', 0, 'B0%, B1%, B2%, B3%, B4%, B5%, B6%, Byu%, BBmK%, C33%, BBr%,ByuD5, ByuD6,ByuDF, BBg1%,', null);

-- ELGH - Metastatic solid tumour
call populateCodeDate(1, 'METASTASES', 'dataset1c', 0, 'B56%, B57%, B58%, B59%, ByuC2%, ByuC3%, ByuC4%, ByuC5%, ByuC6%, ByuC7%, ByuC8% ,BB03, BB13,', null);

-- ELGH - Dementia or Alzheimers
call populateCodeDate(1, 'DEMENTIA', 'dataset1c', 0, 'Eu02%, E00%, Eu01%, E02y1, E012%, Eu00%, E041, Eu041, F110, F111, F112, F116, F118, F21y2, A411%, A410, Eu107, F11x7,', null);

-- ELGH - Rheumatic or connective tissue disease
call populateCodeDate(1, 'RHEUMATIC', 'dataset1c', 0, 'N20%, N00%, N04%, Nyu11, Nyu12, Nyu1G, Nyu10, G5yA, G5y8,', null);

-- ELGH - HIV or AIDS
call populateCodeDate(1, 'HIV', 'dataset1c', 0, 'A788%, A789%, 43C3, Zv01A, AyuC,', null);

-- ELGH - Hypertension
call populateCodeDate(1, 'HBP', 'dataset1c', 0, 'G2%, Gyu2, Gyu20, ', null);

-- ELGH - Skin ulcers
call populateCodeDate(1, 'SKINULCER', 'dataset1c', 0, 'M270%, G837%, M271%,', null);

-- ELGH - Depression
call populateCodeDate(1, 'DEPRESSION', 'dataset1c', 0, 'E0013, E0021, E112%, E113%, E118, E11y2, E11z2, E130, E135, E2003, E291, E2B, E2B1, Eu204, Eu251, Eu32%, Eu33%, Eu341, Eu412,', null);

-- ELGH - Serious mental illness
call populateCodeDate(1, 'SMI', 'dataset1c', 0, 'E10%, E11%, E11z, E11z0, E11zz, E12% , E13%, E2122, Eu2%, Eu30% , Eu31%, Eu323, Eu328, Eu333, Eu329, Eu32A,', 'E11y2, E135,');
