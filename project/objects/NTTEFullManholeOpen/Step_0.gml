scrNTTEFullManholeOpenStep()

// BEGIN NTTE OASIS TRENCH READONLY PROBE ManholeOpen.Step.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("ManholeOpen.Step.after");
// END NTTE OASIS TRENCH READONLY PROBE ManholeOpen.Step.after