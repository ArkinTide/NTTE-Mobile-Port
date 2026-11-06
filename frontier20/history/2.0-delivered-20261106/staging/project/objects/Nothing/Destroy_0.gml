// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Nothing.Destroy.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("Nothing.Destroy.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Nothing.Destroy.before
// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
instance_create(x, y, NothingDeath)

with (MusCont) alarm[1] = 1

snd_play(sndNothingDeath1)
audio_stop_sound(sndNothingBeamLoop)

with (enemy) hp = 0

with (projectile) {
    if (team != team_player) instance_destroy()
}

with (BigGenerator) {
    instance_create(x, y, BigGeneratorInactive)
    instance_destroy(id, false)
}

scrOnBossKill()