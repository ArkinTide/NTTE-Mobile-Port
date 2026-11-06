if scr_skill_get(mut_strong_spirit) {
	if !can_spirit && !spirit {
		can_spirit = true
	}
}

if race == Race.Frog {
    snd_stop(sndFrogLoopButt)
    snd_stop(sndFrogLoop)
    frogcharge = 0
}

instance_destroy(JoystickMove)
instance_destroy(JoystickAttack)
instance_destroy(ButtonSwap)
instance_destroy(ButtonActive)
instance_destroy(ButtonAct)

snd_stop(sndCarLoop)

// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Player.RoomEnd.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("Player.RoomEnd.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Player.RoomEnd.after