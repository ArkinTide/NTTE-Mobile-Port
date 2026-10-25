// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Step.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Manhole.Step.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Step.before
scrNTTEFullBigManholeStep()

// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Step.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Manhole.Step.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Step.after