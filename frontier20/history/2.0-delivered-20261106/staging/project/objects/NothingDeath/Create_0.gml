alarm[0] = 90
image_speed = (0.4) * timescale

hitid = HitId.ThroneDeath

spr_idle = sprNothingDeath
spr_dead = sprNothingDeath
soundplayed = false

team = team_enemy

// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT NothingDeath.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("NothingDeath.Create.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT NothingDeath.Create.after