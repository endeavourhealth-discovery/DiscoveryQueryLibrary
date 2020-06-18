use data_extracts;
drop procedure if exists F50_cohort_procedure;

DELIMITER //
CREATE PROCEDURE `F50_cohort_procedure` (
		IN factor INT(2), 	-- number of matches required for each test individual
        five_cat BOOL, 		-- flag as to whether to use 5cat category or not (true = 5cat, false = 16cat)
        msoa BOOL			-- flag as to whether to use msoa or org (true = msoa, false = organization_id)
        )
BEGIN
-- Refactored to not use cursors (as they are read only and also apparently, are evil)
-- I cannot think of a way to do this without doing it as a row by row generation
-- This is because
-- a) We need to match the age at which IHD is diagnosed
-- b) We need to ensure that a cabergolite is matched to 5 unique cohort patients
-- DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET @done = 1;
SET @factor = factor;
SET @person = 0;
SET @counter = 0;
SET @num_records = (select count(person_id) from cohort_for_matching where cohort_flag = 'T');

WHILE @counter <= @num_records DO
SELECT MIN(person_id),
            case when msoa then msoa_code else organization_id end,
            age_in_years,
            case when five_cat then ethnicity_5cat else ethnicity_16cat end,
            gender,
            smoker_flag,
            diabetes_flag,
            hypertension_flag,
            cab_start_date,
            td_ihd_inc_earliest
		INTO
			@person,
			@location,
            @age,
            @ethnicity,
            @gender,
            @smoker,
            @diabetes,
            @hypertension,
            @cab_start_date,
            @ihd
    FROM cohort_for_matching WHERE cohort_flag = 'T' AND person_id > @person;

	UPDATE cohort_for_matching
		SET matched_with = @person
		WHERE matched_with = 'Unmatched'
			AND age_in_years - @age BETWEEN -2 AND 2
			AND case when five_cat then ethnicity_5cat = @ethnicity else ethnicity_16cat = @ethnicity end
			AND gender = @gender
			AND case when msoa then msoa_code = @location else organization_id = @location end
			AND smoker_flag = @smoker
			AND diabetes_flag = @diabetes
			AND hypertension_flag = @hypertension
            -- The number of days old they were when they were diagnosed should not be less days old than when the test started cabergoline
            AND case when td_ihd_inc_earliest is not null then
				not (age_in_years * 365) - DATEDIFF(CURDATE(), td_ihd_inc_earliest) < (@age * 365) - DATEDIFF(CURDATE(), @cab_start_date)
                else true
                end
			-- This was garbage AND not COALESCE(DATEDIFF(CURDATE(), earliest_td_ihd_inc),0) > COALESCE(DATEDIFF(CURDATE(), @cab_start_date), 100000000)
			AND cohort_flag = 'C'
		ORDER BY rand(999) -- set seed to ensure replicability
		LIMIT factor;

		IF floor(@counter/100) = @counter/100 THEN -- check if counter is an integer multiple of 100
			select @counter; -- output the completed members of test cohort so far
		END IF;
		set @counter = @counter + 1;
END WHILE;
END
// DELIMITER ;
