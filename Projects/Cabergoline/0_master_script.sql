-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Runs all the scripts as store procs
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- --------------------------------------------------------------------
-- STEP 1a: Modify the target database name here...
-- --------------------------------------------------------------------

	use data_extracts;

 -- --------------------------------------------------------------------
-- STEP 1b: ... and in all of the below scripts/codes (where it will appear once at the top):
-- --------------------------------------------------------------------

	-- F50_get_all_obs_on_cohort
	-- F50_join_to_observation
	-- F50_add_obs_column_batched
	-- F50_cohort_procedure
	-- 1_cab_meds_cohort
	-- 2_cab_full_cohort
	-- 3_cabergoline_dosage
	-- 4_other_medication_exclusions
	-- 5_join_to_observations
	-- 6_apply_final_exclusions
	-- 7_serum_prolactin
	-- 8_generate_final_outputs
    -- 9_generate_test_output_files
	-- 10_temp_file_clean_up
    -- 11_all_file_clean_up

-- --------------------------------------------------------------------
-- STEP 2: Initialise all the store procs
-- --------------------------------------------------------------------

	-- Prior to running this below scripts, the following store procs will need to be initialised in the database:
	-- F50_get_all_obs_on_cohort
	-- F50_join_to_observation
	-- F50_add_obs_column_batched
	-- F50_cohort_procedure
	-- 1_cab_meds_cohort
	-- 2_cab_full_cohort
	-- 3_cabergoline_dosage
	-- 4_other_medication_exclusions
	-- 5_join_to_observations
	-- 6_apply_final_exclusions
	-- 7_serum_prolactin
	-- 8_generate_final_outputs
    -- 9_generate_test_output_files
    -- 10_temp_file_clean_up
    -- 11_all_file_clean_up

-- --------------------------------------------------------------------
-- STEP 3: initialise the hash key look up for person_id
-- --------------------------------------------------------------------

	-- in order to preserve the secrecy of the key, this code is not stored here, but will be provided at runtime

-- --------------------------------------------------------------------
-- STEP 4: run the below which call the store procs
-- --------------------------------------------------------------------

	call CAB1_cab_meds_cohort(); 				-- FILENAME: 1_cab_meds_cohort
	call CAB2_cab_full_cohort(); 				-- FILENAME: 2_cab_full_cohort
	call CAB3_cabergoline_dosage(); 			-- FILENAME: 3_cabergoline_dosage
	call CAB4_other_medication_exclusions();	-- FILENAME: 4_other_medication_exclusions
	call CAB5_join_to_observations();			-- FILENAME: 5_join_to_observations
	call CAB6_apply_final_exclusions();			-- FILENAME: 6_apply_final_exclusions
	call CAB7_serum_prolactin();				-- FILENAME: 7_serum_prolactin
	call CAB8_generate_final_outputs();			-- FILENAME: 8_generate_final_outputs
    call CAB9_generate_test_output_files();		-- FILENAME: 9_generate_test_output_files


-- --------------------------------------------------------------------
-- STEP 5: clean up table space, leaving only relevant files
-- --------------------------------------------------------------------
-- This will remove any temporary files leaving only 6 output files:
-- 3 x test files: F50_CAB_TEST_Serum_Prolactin; F50_CAB_TEST_Person_Level_Data; F50_CAB_TEST_Cabergoline_Prescriptions;
-- 3 x output files: F50_CAB_OUT_Serum_Prolactin; F50_CAB_OUT_Person_Level_Data; F50_CAB_OUT_Cabergoline_Prescriptions;


	call CAB10_temp_file_clean_up();			-- FILENAME: 10_temp_file_clean_up

-- --------------------------------------------------------------------
-- STEP 6: clean up table space, leaving only relevant files
-- --------------------------------------------------------------------
	-- this will remove the 6 output files described above as part of step 4 (so commented out)

	-- call CAB11_output_file_clean_up();		-- FILENAME: 11_all_file_clean_up
