// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.AnimationEnd.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("BigPortal.AnimationEnd.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.AnimationEnd.before
// BEGIN NTTE WORLD RESTART PORTAL DIAGNOSTIC
if(os_type==os_windows && instance_exists(NTTEFullWorldEventsRoomRestartTest))
    scrNTTEFullWorldEventsRoomRestartPortalProbe("BigPortal.Other7.animation-end.before");
// END NTTE WORLD RESTART PORTAL DIAGNOSTIC
if sprite_index == sprBigPortalSpawn {
    instance_create(x, y, PortalShock)
    sprite_index = sprBigPortal
}

if sprite_index == sprBigPortalDisappear {
    with Player {
        reload = 0
        breload = 0
		can_shoot = true
		bcan_shoot = true
		scrPlayerUncurse(id)
    }

    GameCont.is_level_ended = true

    snd_stop(sndPortalLoop)

    if instance_exists(Player) {
        instance_activate_all()
        scrNTTEFullBeetleChestBeforeRoomEnd();
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST BIG PORTAL REAL RESTART
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("BigPortal.Restart.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST BIG PORTAL REAL RESTART
room_restart()
    }

    instance_destroy()
}

// BEGIN NTTE WORLD RESTART PORTAL DIAGNOSTIC
if(os_type==os_windows && instance_exists(id) && instance_exists(NTTEFullWorldEventsRoomRestartTest))
    scrNTTEFullWorldEventsRoomRestartPortalProbe("BigPortal.Other7.animation-end.after");
// END NTTE WORLD RESTART PORTAL DIAGNOSTIC
