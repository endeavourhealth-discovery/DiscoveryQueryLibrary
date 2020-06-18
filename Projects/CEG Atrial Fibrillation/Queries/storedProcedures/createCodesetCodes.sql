use rf2;

delete from rf2.code_set_codes where code_set_id between 554 and 562;

-- AF Atrial fibrillation code
call addRead2CodesToCodeSet( 554, 'G573.% , G5730% , G573.% , G5731%,');

-- AF Atrial fibrillation resolved code
call addRead2CodesToCodeSet( 555, '212R. , XaLFz,');

-- AF Atrial fibrillation excepted code
call addRead2CodesToCodeSet( 556, '9hF0. , 9hF1., XaLFi , XaLFj,');

-- AF Oral anticoagulant contraindications: persisten
call addRead2CodesToCodeSet( 557, '14LP. , TJ42.%, U6042 , ZV14A , 1Z34. , 1Z43. , 1Z340 , 1Z431 , 1Z341 , 1Z430, XaJ60 , TJ42.% , U6042 , XaJ8B , Xa5yP% , Xad9m , Xad9p , Xad9n , Xad9o , Xa5Zn , Xa5yG,');
call removeRead2CodesFromCodeSet( 557, 'TJ420, TJ420,');

-- AF Oral anticoagulant contraindications: expiring ');
call addRead2CodesToCodeSet( 558, '8I25. , 8I3E. , 8I65. , 8I71. , 8I2R. , 8I3d. , 8I6N. , 8I7A. , 8I2o. , 8IES. , 8I611 , 8I7R. , 8I2u. , 8IH1. , 8I6s. , 8I7V. , 8IJ0. , 8IHG. , 8I7Z. , 8IJ1. , 8IHH. , 8I7a.
XaFsz , XaIIn , XaIIh , XaJ5b , XaKAB , XaKAD , XaKA7 , XaKA0 , XaZbj , XaZZl , XaZbl , XaZbr , XabEn , XabEe , XabEp , XabEo , XadAI , Xad9q , Xad9s , XadAK , Xad9r , Xad9t,');

-- AF Oral anticoagulant drug
call addRead2CodesToCodeSet( 559, 'bs...% , 8B2K., x01O3% , x01O5% , XaKAk,');

-- AF Hypertension diagnosis
call addRead2CodesToCodeSet( 560, 'G2... , G20..% , G24..-G2z.., Gyu2. , Gyu20 , XE0Ub , XE0Uc% , G24..%, G2...% , Xa0Cs , XSDSb , G202. , Xa3fQ , XaZWn , XaZbz , XaZWm , Xab9M , Xab9L,');
call removeRead2CodesFromCodeSet( 560, '61462, G2400 , G2410 , G24z1 , Gyu21 , L1282 , Xa0kX, G24z1 , G2400 , G2410 , G27..,');

-- AF Hypertension resolved
call addRead2CodesToCodeSet( 561, '21261 , 212K. , 21261,');

-- AF Stroke risk
call addRead2CodesToCodeSet( 562, '38DE0, XaY6i,');
