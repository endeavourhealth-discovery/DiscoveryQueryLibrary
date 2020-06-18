use data_extracts;

drop procedure if exists executeReportForBHRChildImms;

DELIMITER //
CREATE PROCEDURE executeReportForBHRChildImms()
BEGIN

call populateDatasetWithCTV3Prefix(
  'dataset_bhr',
  '65M10,Xaeec,653,654,6541,6551,6561,6581,654Z,657A,65a0,65H1,65H5,65I1,65I5,65J1,65J6,65K1,65K6,65K9,65L1,65M7,65MH,EMIS1S3,EMIS1S4,EMISNQ1S1,EMISNQFI5,EMISNQFI6,x05ua,x05uf,X74VB,XaCEP,XaIrD,XaJky,XaJo7,XaK4t,XaKMw,XaKMz,XaXJI,Y05d0,Y05d7,Y05da,Y05df,Y0676,Y0799,Y07d5,Y080c,Y09e5,Y0a12,Y0a1a,Y0a23,Y0a29,Y0a2f,Y0a35,Y0a3b,Y0a59,Y0aad,Y0ab4,Y0ab5,Y10b8,Y10bd,Y1110,Y1140,Y1186,Y1194,Y1198,Y1210,Y1214,Y2038,Y2041,Y2096,Y2110,Y2116,Y2120,Y2864,Y2893,Y3417,Y3717,Y3720,Y3725,Y3728,Y3736,Y3779,Y6813,YabtS,EMISNQFI26,Y19eb,XagJH,657L,EMISNQFI7,x05Fk,XaLqs,Y0c41,Y2100,65d0,Xaa9n,Y0b96,Y107f,65710,65715,XacJs,XacJw,XacKp,Y12d4,6542,6552,6562,6582,657B,65a1,65H2,65H6,65I2,65I6,65J2,65J7,65K2,65K7,65L2,65M8,65MI,EMIS2N3,EMIS2N4,EMIS2R4,EMISNQ2N1,EMISNQ2S1,EMISNQSE5,EMISNQSE6,XaCEQ,XaIrE,XaJkz,XaJo8,XaK4u,XaKMx,XaXJJ,Y05d1,Y05d8,Y05db,Y05e0,Y0677,Y06b4,Y06b6,Y06ba,Y06c2,Y06d5,Y06d8,Y06db,Y0742,Y074a,Y0750,Y07d6,Y080d,Y09e6,Y0a13,Y0a16,Y0a1b,Y0a24,Y0a2a,Y0a2d,Y0a30,Y0a36,Y0a38,Y0a3c,Y0a5a,Y0aae,Y0ab6,Y10b9,Y10be,Y1159,Y1187,Y1190,Y1195,Y1199,Y1211,Y1274,Y2039,Y2042,Y2060,Y2063,Y2097,Y2111,Y2117,Y2889,Y3024,Y3418,Y3718,Y3721,Y3724,Y3726,Y3729,Y3737,Y3815,Y3817,Y3819,Y9043,YabtT,EMISNQSE78,Y19ec,XagJI,6571,657E,657I,EMIS1S6,n4l4,n4l5,n4l6,n4l8,n4lx,n4ly,n4lz,x0552,X0552,x05Cs,XaaXs,XaF1x,XaF4P,Y0696,Y069f,Y0749,Y08d2,Y120c,Y120e,Y12e6,Y12e8,Y12f1,Y12f2,Y1315,Y1316,Y1317,Y1318,Y1319,Y1320,Y1358,Y2014,Y2015,Y2016,Y2017,Y2018,Y2021,Y2022,Y2023,Y2024,Y2025,Y2026,Y2027,Y2028,Y2029,Y2030,Y2031,Y2032,Y2033,Y2034,Y2035,Y4990,YA210,YA212,65d1,Xaa9o,Y0b95,Y108a,6543,6553,6563,6583,657C,65a2,65H3,65H7,65I3,65I7,65J3,65J8,65K3,65K8,65L3,65M9,65MJ,EMIS2R3,EMISNQ3R1,EMISNQTH4,EMISNQTH5,XaCER,XaIrF,XaJl0,XaJo9,XaK4v,XaKMy,Y05d9,Y05dc,Y05e1,Y0678,Y067a,Y06b1,Y06b5,Y06b7,Y06bb,Y06c0,Y06d6,Y06dc,Y06d9,Y0743,Y074b,Y0751,Y079a,Y07d7,Y080e,Y09e7,Y0a14,Y0a17,Y0a1c,Y0a25,Y0a2b,Y0a2e,Y0a31,Y0a37,Y0a39,Y0a3d,Y0a5b,Y0a5d,Y0aaf,Y0ab7,Y10ba,Y10bf,Y1160,Y1188,Y1191,Y1196,Y1212,Y1275,Y2007,Y2040,Y2043,Y2061,Y2064,Y2094,Y2098,Y2112,Y2118,Y2890,Y3025,Y3400,Y3719,Y3722,Y3727,Y3730,Y3738,Y3816,Y3818,Y3820,Y9535,YabtU,EMISNQTH31,Y19ed,XagJJ,6572%,657M,657P,EMISNQSE15,XacJv,XaCKa,XaIeO,XaLqt,Y05ef,Y069c,Y0c42,Y0c8c,Y0e50,Y157d,6571A,Y2101,Y2103,Y3830,Y3832,657F,EMIS2N6,XaF1y,Y08d3,Y08d5,Y2013,YA211,65711,65716,XacJt,XacKq,Y157b,657D,657G,65b,65b0,EMIS3R6,EMISNQHA21,X05uc,x05uc,XaF1z,XaMKL,Y0670,Y0672,Y0699,Y06dd,Y074c,Y08d4,Y1189,Y1192,Y1264,Y1324,Y5660,Yau9T,Yau9U,65712,65717,XacJu,XacKr,Y157c,65A%,65B%,65F5%,65M1,65M2,65MC,65VH,EMISME1,n4k%,x01LK,x01LL,x04sw,XaLkV,XaQFu,XaQPr,XaXeL,Y066c,Y06de,Y06df,Y0ef0,Y0ef1,Y0ef2,Y0ef3,Y0ef5,Y2091,Y2104,Y2107,Y3801,Y3825,Y3826,ZV064,657N,EMISNQTH9,XaLI8,XaLqu,Y0698,Y0c43,Y2102,Y3831,6544,6545,6554,6564,6584,65a3,65H4,65I4,65I8,65I9,65J4,65J5,65J9,65K4,65KA,65L4,65MK,65MP,65MQ,9N4c,EMISNQ4T2,EMISQPR3,x057l,Xa7Oi,XaEKG,XaIPv,XaIrG,XaKN0,XaLvG,XaNdZ,XaONV,XaPti,Y05e2,Y05ee,Y066d,Y0690,Y0691,Y069b,Y06a2,Y06a3,Y06a4,Y06a5,Y06a6,Y06a7,Y06aa,Y06ab,Y06b0,Y06b9,Y06bf,Y06c3,Y06c4,Y06c7,Y06c9,Y06cb,Y06cd,Y06cf,Y06d0,Y06d1,Y06d3,Y0744,Y0748,Y075f,Y0762,Y080b,Y09ea,Y0a1d,Y0a1e,Y0a20,Y0a26,Y0a27,Y0a28,Y0a33,Y0a3a,Y0a3f,Y0a5c,Y0a5e,Y0ab1,Y0ab8,Y0fcd,Y0fce,Y1115,Y1134,Y1161,Y1175,Y1179,Y1197,Y11b5,Y1213,Y12da,Y2000,Y2001,Y2099,Y2113,Y2119,Y2891,Y3723,Y3793,Y3794,Y3795,Yaeha,65MA,65MB,EMISBO2,x00S1,x043V,XaClE,XaJh1,Y016c,Y0291,Y0530,Y057b,Y05dd,Y0692,Y06ad,Y0ef4,Y10b3,Y2105,Y3824,Y3837,Y3838,65FS,X73k8,XaNQd,XaNNI,Y0cbd,EMISNQHU2,65FT,XaNNJ,Y0cbe,65FV,XaNNK,Y0cbf,65K5,Y057d,Y0679,Y06a8,Y06a9,Y06b8,Y06c5,Y06c8,Y06ca,Y06cc,Y06ce,Y06d2,Y06d4,Y0760,Y07d8,Y09e9,Y09eb,Y09f3,Y0a15,Y0a1f,Y0a21,Y0a2c,Y0a32,Y0a34,Y0a3e,Y0a40,Y0ab0,Y1098,Y2066,Y2895,Y3798,657S,657S0,EMISNQBO34,XaaXa,657J,657J0,657J1,657J2,657J3,657J4,x05EF,XaIQX,Y0671,Y0da5,Y0fcf,Y1143,Y1144,Y1145,Y15f5,Y15f6,Y15f7,Y15f8,Y2045,Y3805,Y3806,65F1,65F10,EMISNQ1S3,Xaa4V,Y0a0b,Y0a54,Y1176,Y1180,Y2088,Y3946,65F2,65F20,EMISNQ2N3,Xaa4W,Y066f,Y0763,Y0765,Y0767,Y0768,Y076a,Y076c,Y076d,Y0a0c,Y0a55,Y0a57,Y1177,Y2089,Y3947,65F3,65F30,Xaees,EMISNQ3R2,Xaa4X,Y06e0,Y0764,Y0766,Y0769,Y076b,Y076e,Y0a56,Y1178,Y1181,Y2090,Y3948,65F6,65F60,Xaa4Y,Y3949,65ED,65ED0,65ED1,65ED2,65ED3,9OX5%,n47D,n47H,Xaa9G,Xaac3,Xaac4,Xaac7,Xaac8,XaaED,XaaEF,XaaZp,XaLK4,XaZ0d,XaZ0e,XaZfY,Y0e4e,Y0e4f,Y11ca,Y12ef,Y12f0,Y13d6,Y13d7,65E20,65E21,65E22,Y1135,Y2109,Y3802,Y3803,Y3804,65O%,EMISNQ1S2,EMISNQ2N2,Y19ea,ZV030,ZV047,ZV035,ZV063,ZV061,ZV048,ZV042,ZV04,ZV036,ZV040,ZV043,ZV041,ZV037,ZV032,XaFTh,XaFTi,XaFTj,6579,6513,65MG,XaIPb,XaIed,XaJhz,65FD,65F4,XaG0H,Xaees,XaaXa,XaLK7,6523,XaQhk,XaQhl,651,651Z,XaE4T,Xabyv,XE2b2,65KZ,XE1Si,XaK4s,65I,65IZ,65H,65HZ,65F7,Xaakl,6575,6511,65MD,Xaa4a,XaEc9,XaEFH,65FA,Xaeev,Xaeet,XaLNG,65D1,6592,XaXnn,6521,XaMz5,Xaakk,XaavB,Xabyy,9OX2,XaEc8,XaXPW,XaZsM,XaQk3,XaN0i,XaQdj,XaQe5,XaN0g,XaQdk,XaN20,XaN0h,XaN0f,XaQgS,65E,XaIOT,XaJ5n,XaXsK,XaK2d,XaK4x,XaK4w,65A,XaVy4,XaF20,XacJx,XaCFh,65F5,XaQhm,XaQhn,655,XacJ3,6573,6572,XaIOS,XaKFY,XaObE,658,658Z,XaZVN,F034C,Xa1cN,XaXjc,XaKYF,65D,65DZ,XaQxb,XaNwr,Xaa9q,65B,XaZ0d,XaZ0j,XaZ0k,6576,6512,65ME,Xaa4b,XaEcA,XaEFI,Xaeew,XaLNH,65D2,XaXno,6522,XaMzA,XaIsO,65GZ,XaYvC,XE1Sj,656,656Z,65MF,Xaa4c,XaJhy,65FC,65D3,XaXnp,6700,Xa1po,6574,XaBbI,652Z,XaJov,,'
  ,2,
  null,
  null,
  1
);

 -- Practice
 update dataset_bhr d
     join enterprise_pi.patient p on p.id = patient_id
     left join health_checks_bhr.patient_search dem on dem.nhs_number = p.nhs_number
     join enterprise_pi.organization org on org.id = p.organization_id
    set d.NHSNumber = p.nhs_number,
      d.Gender = p.patient_gender_id,
      d.FirstName =dem.forenames,
      d.LastName = dem.surname,
      d.AddressLine1 =  dem.address_line_1,
      d.AddressLine2 = dem.address_line_2,
      d.AddressLine3 = dem.address_line_3,
      d.City = dem.city,
      d.PracticeODSCode = org.ods_code,
      d.PracticeName = org.name,
      d.Postcode = p.postcode,
      d.Ethnicity = p.ethnic_code,
      d.BirthDate = p.date_of_birth;

 -- Ethnicity
update dataset_bhr d join enterprise_pi.ethnicity_lookup el on el.ethnic_code = d.Ethnicity
  set d.Ethnicity = el.ethnic_name;

-- Gender
update dataset_bhr set gender = 'Male' where gender = '0';
update dataset_bhr set gender = 'Female' where gender = '1';
update dataset_bhr set gender = 'Other' where gender = '2';
update dataset_bhr set gender = 'Unknown' where gender = '3';


alter table dataset_bhr add index patientIdIdx (patient_id);

 END//
 DELIMITER ;
