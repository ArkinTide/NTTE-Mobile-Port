// BEGIN NTTE PIZZA LAIR DRAIN READONLY PROBE Drain.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
    scrNTTEFullPizzaLairDrainProbe("Drain.Destroy.before");
// END NTTE PIZZA LAIR DRAIN READONLY PROBE Drain.Destroy.before
scrNTTEFullSewerDrainDeath()

// BEGIN NTTE PIZZA LAIR DRAIN READONLY PROBE Drain.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
    scrNTTEFullPizzaLairDrainProbe("Drain.Destroy.after");
// END NTTE PIZZA LAIR DRAIN READONLY PROBE Drain.Destroy.after