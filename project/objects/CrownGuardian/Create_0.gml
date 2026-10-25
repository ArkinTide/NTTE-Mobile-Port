// BEGIN NTTE CRYSTAL CROWN GUARDIAN TEST before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && variable_global_exists("ntte_crystal_crown_probe") && is_struct(global.ntte_crystal_crown_probe) && global.ntte_crystal_crown_probe.measuring) scrNTTEFullCrystalCrownCreateProbe("before");
// END NTTE CRYSTAL CROWN GUARDIAN TEST before
raddrop = 11
max_hp = 70
meleedamage = 0
size = 3
spr_idle = sprCrownGuardianIdle
spr_walk = sprCrownGuardianIdle
spr_hurt = sprCrownGuardianHurt
spr_dead = sprCrownGuardianDead
event_inherited()
spr_fire = sprCrownGuardianFire
snd_hurt = sndCrownGuardianHurt
snd_dead = sndCrownGuardianDead
alarm[1] = (40 + random(10))

spr_shadow = shd24
spr_shadow_y = 4

hitid = HitId.CrownGuardian
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

// BEGIN NTTE CRYSTAL CROWN GUARDIAN TEST after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && variable_global_exists("ntte_crystal_crown_probe") && is_struct(global.ntte_crystal_crown_probe) && global.ntte_crystal_crown_probe.measuring) scrNTTEFullCrystalCrownCreateProbe("after");
// END NTTE CRYSTAL CROWN GUARDIAN TEST after