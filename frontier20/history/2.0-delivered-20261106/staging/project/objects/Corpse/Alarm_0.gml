// BEGIN NTTE TRENCH SECOND HOP TEST Corpse.Alarm0.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Corpse.Alarm0.before"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Corpse.Alarm0.before
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Corpse.Alarm0.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Corpse.Alarm0.before"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Corpse.Alarm0.before
// BEGIN NTTE OASIS TRENCH READONLY PROBE Corpse.Alarm0.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Corpse.Alarm0.before");
// END NTTE OASIS TRENCH READONLY PROBE Corpse.Alarm0.before
if (
    !scrNTTEPortalRecoveryAllowed() || scrNTTEFullPortalBlocked() ||
	instance_exists(Portal) || instance_exists(GenCont) || (!forceportal && scr_check_enemies()) || GameCont.area == area_crib || instance_exists(RadMaggotChest)
	|| instance_exists(CrownGuardian) || instance_exists(VaultStatue) || instance_exists(CrownPickup) || instance_exists(TutCont) || !instance_exists(Player)
	|| instance_exists(BecomeScrapBoss) || ((GameCont.area == area_palace || GameCont.area == area_hq) && GameCont.subarea == GameCont.maxsubarea)
	|| instance_exists(SitDown)
) {
	exit
}

if GameCont.area == area_campfire {
	if !instance_exists(IDPDSpawn) && !(instance_exists(Nothing2Appear) || instance_exists(Nothing2) || instance_exists(NothingSpiral)) {
	    instance_create(x, y, Nothing2Appear)
	}
}
else {
    // The corpse remains where its animation/physics left it.
    var _portal_x=x,_portal_y=y,_death_point=false;
    if(!forceportal) {
        var _last=scrNTTEPortalDeathPoint();
        if(is_struct(_last)) {_portal_x=_last.x;_portal_y=_last.y;_death_point=true;}
    }
    // Authored forced portals and old continuations retain the native corpse
    // footprint check. Only a remembered death uses the recorded point.
	if (_death_point ? !position_meeting(_portal_x,_portal_y,Floor) : !place_meeting(x,y,Floor)) {
	    with (instance_nearest(_portal_x, _portal_y, Floor)) {
			_portal_x = bbox_center_x
			_portal_y = bbox_center_y
		}
	}
	
	with instance_create(_portal_x, _portal_y, Portal) {
	    type = 1
		
	    if GameCont.area == area_hq {
	        type = 2
	    }
	}
}