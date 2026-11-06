if(lockstep_stop) exit;


scrNTTEFullRerollEndStep();
scrNTTEFullSystemProductionEndStep();


scrNTTEFullDiscoveryEndStep();
scrNTTEFullRaceProgressEndStep();
scrNTTEFullBaseFrameEndStep();

scrNTTEFullPetOctoAllChains();

scrNTTEFullBonusShellStep();

with(Player) scrNTTEFullParrotFlockEnd();

if(variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode) scrNTTEFullMergedNativeEndStep();
