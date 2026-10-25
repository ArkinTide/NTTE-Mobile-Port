// BEGIN NTTE OASIS TRENCH READONLY PROBE Manhole.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Manhole.Destroy.before");
// END NTTE OASIS TRENCH READONLY PROBE Manhole.Destroy.before
// BEGIN NTTE SEWER PIZZA TEST PROBE Manhole.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Manhole.Destroy.before");
// END NTTE SEWER PIZZA TEST PROBE Manhole.Destroy.before
scrNTTEFullManholeDeath()
