// BEGIN NTTE SEWER PIZZA TEST PROBE SludgePool.Step.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("SludgePool.Step.before");
// END NTTE SEWER PIZZA TEST PROBE SludgePool.Step.before
scrNTTEFullSludgePoolStep()
// BEGIN NTTE SEWER PIZZA TEST PROBE SludgePool.Step.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("SludgePool.Step.after");
// END NTTE SEWER PIZZA TEST PROBE SludgePool.Step.after
