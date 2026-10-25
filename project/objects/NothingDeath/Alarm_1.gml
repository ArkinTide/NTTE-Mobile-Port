// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT NothingDeath.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("NothingDeath.Alarm1.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT NothingDeath.Alarm1.before
instance_create(x + 16, y + 16, BigPortal)