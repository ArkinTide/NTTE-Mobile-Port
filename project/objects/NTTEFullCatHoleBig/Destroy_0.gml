// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Manhole.Destroy.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Destroy.before
scrNTTEFullBigManholeDeath()

// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Manhole.Destroy.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Manhole.Destroy.after