event_inherited();
// NTTE trident physical-part EndStep transition.
if(!lockstep_stop) scrNTTEFullMergedRuntimeStateEndStep();

scrNTTEFullTridentPlayerEndStep();
scrFRRacePlayerEndStep(); // FRONTIER PLAYER STEP

// BEGIN FRONTIER BUBBLES STARTUP REAL END
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(FRIntegrationTest)) scrFRBubblesStartupTestsObserve("end",id);
// END FRONTIER BUBBLES STARTUP REAL END
