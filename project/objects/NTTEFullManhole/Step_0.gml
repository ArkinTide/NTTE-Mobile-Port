// BEGIN NTTE OASIS TRENCH READONLY PROBE Manhole.Step.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Manhole.Step.before");
// END NTTE OASIS TRENCH READONLY PROBE Manhole.Step.before
// BEGIN NTTE SEWER PIZZA TEST PROBE Manhole.Step.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Manhole.Step.before");
// END NTTE SEWER PIZZA TEST PROBE Manhole.Step.before
scrNTTEFullManholeStep()
// BEGIN NTTE SEWER PIZZA TEST PROBE Manhole.Step.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Manhole.Step.after");
// END NTTE SEWER PIZZA TEST PROBE Manhole.Step.after

// BEGIN NTTE OASIS TRENCH READONLY PROBE Manhole.Step.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Manhole.Step.after");
// END NTTE OASIS TRENCH READONLY PROBE Manhole.Step.after