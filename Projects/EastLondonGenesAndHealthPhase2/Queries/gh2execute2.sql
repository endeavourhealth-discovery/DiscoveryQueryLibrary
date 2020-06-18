USE data_extracts;

DROP PROCEDURE IF EXISTS gh2execute2;

DELIMITER //
CREATE PROCEDURE gh2execute2()
BEGIN

-- Diagnoses (2)

-- 1 = latest
-- 0 = earliest

-- gh2_diagnoses2dataset
                                              
CALL populateCodeDateV2(0, 'AsthmaE', 'gh2_diagnoses2dataset', 0, '195967001', null, null, null,'N');                                           
CALL populateCodeDateV2(0, 'AsthmaEmergeE', 'gh2_diagnoses2dataset', 0, '195967001', null, '57607007', null,'N');
CALL populateCodeDateV2(0, 'AsthmaResolvedE', 'gh2_diagnoses2dataset', 0, '162660004', null, null, null,'N');                                  
CALL populateCodeDateV2(0, 'COPDE', 'gh2_diagnoses2dataset', 0, '13645005,196026004,63480004,10625791000119101,54410000', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'PulmonaryFibrosisE', 'gh2_diagnoses2dataset', 0, '51615001', null, null, null,'N');                                                   
CALL populateCodeDateV2(0, 'InterstitialLungDiseaseE', 'gh2_diagnoses2dataset', 0, '233703007', null, null, null,'N');                                     
CALL populateCodeDateV2(0, 'AgeRelatedMuscularDegenerationE', 'gh2_diagnoses2dataset', 0, '267718000', null, null, null,'N');                             
CALL populateCodeDateV2(0, 'GlaucomaE', 'gh2_diagnoses2dataset', 0, '23986001', null, null, null,'N');                
CALL populateCodeDateV2(0, 'RheumatoidArthritisE', 'gh2_diagnoses2dataset', 0, '69896004', null, null, null,'N');                                          
CALL populateCodeDateV2(0, 'SystemicLupusE', 'gh2_diagnoses2dataset', 0, '55464009', null, null, null,'N');                                
CALL populateCodeDateV2(0, 'InflammatoryBowelDiseaseE', 'gh2_diagnoses2dataset', 0, '24526004', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'CrohnsDiseaseE', 'gh2_diagnoses2dataset', 0, '34000006', null, null, null,'N');                       
CALL populateCodeDateV2(0, 'UlcerativeColitisCodeE', 'gh2_diagnoses2dataset', 0, '64766004', null, null, null,'N');     
CALL populateCodeDateV2(0, 'AtopicDermatitisE', 'gh2_diagnoses2dataset', 0, '24079001', null, null, null,'N');    
CALL populateCodeDateV2(0, 'InheritedMucociliaryClearanceE', 'gh2_diagnoses2dataset', 0, '233661002', null, null, null,'N');                                
CALL populateCodeDateV2(0, 'PrimaryCiliaryDyskinesiaE', 'gh2_diagnoses2dataset', 0, '86204009,233665006', null, null, null,'N');                        
CALL populateCodeDateV2(0, 'MelanomaE', 'gh2_diagnoses2dataset', 0, '372244006,16143200500', null, null, null,'N');                            
CALL populateCodeDateV2(0, 'ProstateCancerE', 'gh2_diagnoses2dataset', 0, '399068003,428262008,428262008', null, null, null,'N');                                      
CALL populateCodeDateV2(0, 'LungCancerE', 'gh2_diagnoses2dataset', 0, '363358000,415077006,415082004', null, null, null,'N');                                           
CALL populateCodeDateV2(0, 'SmallBowelCancerE', 'gh2_diagnoses2dataset', 0, '363509000,428833003', null, null, null,'N');                                      
CALL populateCodeDateV2(0, 'ColorectalCancerE', 'gh2_diagnoses2dataset', 0, '363510005,187760008,363352004,415080007', null, null, null,'N');                                   
CALL populateCodeDateV2(0, 'BreastCancerE', 'gh2_diagnoses2dataset', 0, '254837009,41919003,429087003', null, null, null,'N');                                    
CALL populateCodeDateV2(0, 'MiscarriageE', 'gh2_diagnoses2dataset', 0, '17369002,161744009', null, null, null,'N');                                      

-- gh2_diagnoses2adataset

CALL populateCodeDateV2(0, 'StillbirthE', 'gh2_diagnoses2adataset', 0, '237364002,161743003', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'PregnancyInducedHypertensionE', 'gh2_diagnoses2adataset', 0, null, '48194001', null, null,'N');    -- just parent ignore children                                       
CALL populateCodeDateV2(0, 'PreEclampsiaE', 'gh2_diagnoses2adataset', 0, '398254007', null, null, null,'N');                      
CALL populateCodeDateV2(0, 'CholestasisE', 'gh2_diagnoses2adataset', 0, '235888006', null, null, null,'N');                                    
CALL populateCodeDateV2(0, 'GallstonesE', 'gh2_diagnoses2adataset', 0, '266474003,407637009', null, null, null,'N');                                         
CALL populateCodeDateV2(0, 'GoutE', 'gh2_diagnoses2adataset', 0, '90560007,161451004', null, null, null,'N');                                      
CALL populateCodeDateV2(0, 'AnkylosingSpondylitisE', 'gh2_diagnoses2adataset', 0, '9631008', null, null, null,'N');                                                
CALL populateCodeDateV2(0, 'JaundiceE', 'gh2_diagnoses2adataset', 0, '18165001,161536006', null, null, null,'N');                            
CALL populateCodeDateV2(0, 'PsoriasisE', 'gh2_diagnoses2adataset', 0, '9014002', null, null, null,'N');                                          
CALL populateCodeDateV2(0, 'DeafnessE', 'gh2_diagnoses2adataset', 0, '15188001', null, null, null,'N');                                           
CALL populateCodeDateV2(0, 'HearingAidE', 'gh2_diagnoses2adataset', 0, '365240006', null, null, null,'N');                                        
CALL populateCodeDateV2(0, 'TinnitusE', 'gh2_diagnoses2adataset', 0, '60862001', null, null, null,'N');                                        
CALL populateCodeDateV2(0, 'AssisstedFertilisationE', 'gh2_diagnoses2adataset', 0, '63487001', null, null, null,'N');                                            
CALL populateCodeDateV2(0, 'IVFEE', 'gh2_diagnoses2adataset', 0, '52637005', null, null, null,'N');                              
CALL populateCodeDateV2(0, 'AppendicitisE', 'gh2_diagnoses2adataset', 0, '161532008,74400008', null, null, null,'N');                                              
CALL populateCodeDateV2(0, 'FemoralHerniaE', 'gh2_diagnoses2adataset', 0, '50063009,238171002', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'InguinalHerniaE', 'gh2_diagnoses2adataset', 0, '396232000,429200006,44558001', null, null, null,'N');                                    
CALL populateCodeDateV2(0, 'UmbilicalHerniaE', 'gh2_diagnoses2adataset', 0, '396347007', null, null, null,'N');                                   
CALL populateCodeDateV2(0, 'AbdominalHerniaE', 'gh2_diagnoses2adataset', 0, '414396006', null, null, null,'N');                                   
CALL populateCodeDateV2(0, 'XanthomatosisE', 'gh2_diagnoses2adataset', 0, '63103006', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'TendinousXanthomaE', 'gh2_diagnoses2adataset', 0, '69880002', null, null, null,'N');                                          
CALL populateCodeDateV2(0, 'CornealArcusE', 'gh2_diagnoses2adataset', 0, '231924000,95740000', null, null, null,'N');                              
CALL populateCodeDateV2(0, 'GastricUlcerE', 'gh2_diagnoses2adataset', 0, '397825006,275128000', null, null, null,'N');                                       
CALL populateCodeDateV2(0, 'DuodenalUlcerE', 'gh2_diagnoses2adataset', 0, '51868009,275547005', null, null, null,'N');                                          
CALL populateCodeDateV2(0, 'GastricCancerE', 'gh2_diagnoses2adataset', 0, '363349007', null, null, null,'N');                                      
CALL populateCodeDateV2(0, 'PrematureMenopauseE', 'gh2_diagnoses2adataset', 0, '373717006', null, null, null,'N');                                        
CALL populateCodeDateV2(0, 'EndometriosisE', 'gh2_diagnoses2adataset', 0, '129103003', null, null, null,'N');                                
CALL populateCodeDateV2(0, 'AlopeciaAllE', 'gh2_diagnoses2adataset', 0, '56317004', null, null, null,'N');                                      
CALL populateCodeDateV2(0, 'MalePatternAlopeciaE', 'gh2_diagnoses2adataset', 0, '87872006', null, null, null,'N');                                          
CALL populateCodeDateV2(0, 'HirsuitismE', 'gh2_diagnoses2adataset', 0, '399939002', '29966009', '28934007,238919009,432726005,201159000', null,'N');                                 
CALL populateCodeDateV2(0, 'AmenorrhoeaOligomeorrhoeaIrregularMensesAnovulationE', 'gh2_diagnoses2adataset', 0, '237139007,14302001,64206003,52073004,80182007,161780009', null, '58851004', null,'N');                                        



END //
DELIMITER ;