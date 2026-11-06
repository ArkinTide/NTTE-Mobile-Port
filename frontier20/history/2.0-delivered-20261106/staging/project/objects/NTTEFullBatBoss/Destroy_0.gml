// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Bat.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Bat.Destroy.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Bat.Destroy.before
scrNTTEFullBatBossDeath()
event_inherited()

// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Bat.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Bat.Destroy.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Bat.Destroy.after