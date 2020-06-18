use jack;

-- AF Atrial fibrillation code
call getAllObservations( 554 );

-- AF Atrial fibrillation resolved code
call getAllObservations( 555 );

-- AF Atrial fibrillation excepted code
call getAllObservations( 556 );

-- AF Oral anticoagulant contraindications: persisten
call getAllObservations( 557 );

-- AF Oral anticoagulant contraindications: expiring
-- 12 Months
-- call getAllObservations( 558 );

-- Blood Pressure
call getLatestObservations( 49 );
-- eGFR
call getLatestObservations( 63 );
-- hypertension
call getLatestObservations( 560 );
-- hypertension resolved
call getLatestObservations( 561 );
-- qrisk2
call getLatestObservations( 58 );
-- Stroke risk assessment
call getLatestObservations( 562 );
-- pulse rhythm
call getLatestObservationsAboveAgeInYears( 55, 65 );

-- MEDICINES

-- WARFARIN + DOAC
call getMedicationStatementsWithinMonthlyInterval('48603004,71703906002,4687009,714788005,42539005', null);
-- Other anti coagulates
call getMedicationStatementsWithinMonthlyInterval('79356008,435047527007,469004,10884812008,984007', 12);
-- Anti-platelet
call getMedicationStatementsWithinMonthlyInterval('7947003,108979001,443312008,704464003,66859009', 6);
-- Statins
call getMedicationStatementsWithinMonthlyInterval('96304005,96305006,96307003,108600003,768151007', 6);
-- NSAID (not topical)
call getMedicationStatementsWithinMonthlyInterval('411995002,329906008,370187009,418027007,329961001,350321003,350317005,350318000,108510003,395292007,71798005,60149003,412012003,438097008,16168311000001108,412018004,125694008,108508000,11847009,440256005,437906006,89505005,329913008,329889002', 6);
