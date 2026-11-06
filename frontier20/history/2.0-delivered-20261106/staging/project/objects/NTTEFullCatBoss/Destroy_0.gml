// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Cat.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Cat.Destroy.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Cat.Destroy.before
scrNTTEFullCatBossDeath()
scrNTTEFullCatBossCleanup()
event_inherited()

// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Cat.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Cat.Destroy.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Cat.Destroy.after