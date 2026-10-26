// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomEnd.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("GameCont.RoomEnd.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomEnd.before
// BEGIN NTTE GUARDIAN ESCAPE SOURCE STAGE
scrNTTEFullGuardianEscapeRoomEndBegin();
// END NTTE GUARDIAN ESCAPE SOURCE STAGE
var _race = Race.Random,
	_went_crib = false

if (instance_exists(Player)) {
	same_weapons_for ++
	
	with (Player) {
		if (scr_player_is_local(index)) _race = race
		
		if (scrPlayerUpdateSameWeaponsFor(id)) {
			GameCont.same_weapons_for = 0
		}
	}
}

snd_stop(sndSalamanderFire)
snd_stop(sndSalamanderFireLoop)
snd_stop(sndLightningCannonLoop)
snd_stop(sndEyesLoop)
snd_stop(sndEyesLoopUpg)
snd_stop(sndHorrorLoop)
snd_stop(sndHorrorLoopTB)

fromcrib = false
gonna_oasis = 0
want_oasis = 0
spawn_vans = 0
vans = 0

if (gocrib) {
    gocrib = false
	if (area != area_crib) {
		lastarea = area
		lastsubarea = subarea
	}
    area = area_crib
    subarea = 1
    waypnt[waypoints] = area
    waysub[waypoints] = subarea
    waylps[waypoints] = loops
    waypoints ++
	scrRaceUnlock(Race.Cuz)
	_went_crib = true
}

maxsubarea = scrAreaGetMaxSubarea(area)
finalsubarea = (subarea == maxsubarea)

if (!can_advance_stage) {
	can_advance_stage = true
	exit
}

scrNTTEFullSourceSeedAdvanceStage();

// NTTE Oasis source finish/transit
if(area==scrNTTEFullAreaId("oasis")) {
    if(!is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined))) {
        var _oasis_area=area,_oasis_subarea=subarea;
        scrNTTEFullOasisFinish();
        scrNTTEFullAreaSet(area,subarea,loops);
        area=_oasis_area; subarea=_oasis_subarea;
    }
    scrNTTEFullOasisTransit();
}
// NTTE Pizza source finish/transit
if(area==scrNTTEFullAreaId("pizza")) {
    if(!is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined))) {
        var _pizza_area=area,_pizza_subarea=subarea;
        scrNTTEFullPizzaFinish(); scrNTTEFullAreaSet(area,subarea,loops);
        area=_pizza_area; subarea=_pizza_subarea;
    }
    scrNTTEFullPizzaTransit();
}
// NTTE Coast source finish/transit
if(area==scrNTTEFullAreaId("coast")) {
    if(!is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined))) {
        var _coast_area=area,_coast_subarea=subarea;
        scrNTTEFullCoastFinish(); scrNTTEFullAreaSet(area,subarea,loops);
        area=_coast_area; subarea=_coast_subarea;
    }
    scrNTTEFullCoastTransit();
}
// NTTE Trench source finish/transit: record every completed subarea.
if(area==scrNTTEFullAreaId("trench")) {
    var _trench_area=area,_trench_subarea=subarea;
    scrNTTEFullTrenchFinish();
    if(!is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined)))
        scrNTTEFullAreaSet(area,subarea,loops);
    area=_trench_area;subarea=_trench_subarea;
    scrNTTEFullTrenchTransit();
}
// NTTE Red finish records visits even when an exit already queued its Warp destination.
if(area==scrNTTEFullAreaId("red")) {
    var _red_area=area,_red_subarea=subarea;
    scrNTTEFullRedFinish();
    if(!is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined)))
        scrNTTEFullAreaSet(area,subarea,loops);
    area=_red_area;subarea=_red_subarea;
    scrNTTEFullRedTransit();
}
// BEGIN NTTE LAIR SOURCE FINISH TRANSIT
if(area==scrNTTEFullAreaId("lair")) {
    var _lair_area=area,_lair_subarea=subarea;
    var _lair_pending=scrNTTEFullValue(id,"ntte_full_pending_destination",undefined);
    scrNTTEFullLairFinish();
    if(!is_struct(_lair_pending)) scrNTTEFullAreaSet(area,subarea,loops);
    area=_lair_area;subarea=_lair_subarea;
    scrNTTEFullLairTransit();
}
// END NTTE LAIR SOURCE FINISH TRANSIT
if(area==207) {scrUGFinishDestination();}
var _ntte_destination=scrNTTEFullAreaTakeDestination();
if(is_struct(_ntte_destination)) {
    // BEGIN NTTE OASIS CRACK CONSUME ENTRY FINISH
    // TakeDestination cleared the queue. Reproduce original Trench0.finish once,
    // then retain the mobile bridge's final Trench1 and departing-area history.
    var _entry_finish=scrNTTEFullValue(_ntte_destination,"ntte_full_source_entry_finish",undefined);
    if (is_struct(_entry_finish)) {
        if (scrNTTEFullValue(_entry_finish,"origin","")=="oasis_crack"
            && area==scrNTTEFullAreaId("oasis")
            && scrNTTEFullValue(_entry_finish,"from_area",-1)==area
            && scrNTTEFullValue(_entry_finish,"from_subarea",-1)==subarea
            && scrNTTEFullValue(_entry_finish,"area",-1)==scrNTTEFullAreaId("trench")
            && scrNTTEFullValue(_entry_finish,"subarea",-1)==0
            && scrNTTEFullValue(_ntte_destination,"area",-1)==scrNTTEFullAreaId("trench")
            && scrNTTEFullValue(_ntte_destination,"subarea",-1)==1
            && scrNTTEFullValue(_entry_finish,"loops",-1)==scrNTTEFullValue(_ntte_destination,"loops",-2)
            && scrNTTEFullValue(_entry_finish,"loops",-1)==loops) {
            var _entry_old_area=area,_entry_old_subarea=subarea,_entry_old_loops=loops;
            area=_entry_finish.area; subarea=_entry_finish.subarea; loops=_entry_finish.loops;
            scrNTTEFullTrenchFinish();
            area=_entry_old_area; subarea=_entry_old_subarea; loops=_entry_old_loops;
        }
    }
    // Other original target0 finishes: strict natural-origin provenance.
    if (is_struct(_entry_finish)) {
        var _entry_origin=scrNTTEFullValue(_entry_finish,"origin","");
        var _entry_target=scrNTTEFullValue(_entry_finish,"area",-1);
        var _entry_coast=(_entry_origin=="coast_boss" && area==area_desert && subarea==3
            && _entry_target==scrNTTEFullAreaId("coast"));
        var _entry_pizza=(_entry_origin=="pizza_manhole" && area==area_sewers
            && _entry_target==scrNTTEFullAreaId("pizza"));
        if ((_entry_coast || _entry_pizza)
            && scrNTTEFullValue(_entry_finish,"from_area",-1)==area
            && scrNTTEFullValue(_entry_finish,"from_subarea",-1)==subarea
            && scrNTTEFullValue(_entry_finish,"subarea",-1)==0
            && scrNTTEFullValue(_ntte_destination,"area",-1)==_entry_target
            && scrNTTEFullValue(_ntte_destination,"subarea",-1)==1
            && scrNTTEFullValue(_entry_finish,"loops",-1)==scrNTTEFullValue(_ntte_destination,"loops",-2)
            && scrNTTEFullValue(_entry_finish,"loops",-1)==loops) {
            var _entry_source_area=area,_entry_source_subarea=subarea,_entry_source_loops=loops;
            area=_entry_finish.area; subarea=0; loops=_entry_finish.loops;
            if (_entry_coast) scrNTTEFullCoastFinish();
            else scrNTTEFullPizzaFinish();
            area=_entry_source_area; subarea=_entry_source_subarea; loops=_entry_source_loops;
        }
    }
    // END NTTE OASIS CRACK CONSUME ENTRY FINISH
    lastarea=scrNTTEFullValue(_ntte_destination,"lastarea",area);
    lastsubarea=scrNTTEFullValue(_ntte_destination,"lastsubarea",subarea);
    area=_ntte_destination.area; subarea=_ntte_destination.subarea; loops=_ntte_destination.loops;
} else {
var _is_secret = (area >= 100)

if (_is_secret && !_went_crib) {
	if (subarea == 1) {
	    if area == area_crib {
	        area = lastarea
	        subarea = lastsubarea
	        fromcrib = true
	    }
		
	    if area == area_jungle {
	        area = area_city
	        subarea = scrAreaGetMaxSubarea(area)
	    }
		
	    if area == area_cursed_caves {
	        area = area_city
	        subarea = 0
	    }
		
	    if area == area_mansion || area == area_oasis {
	        area = area_scrapyards
	        subarea = scrAreaGetMaxSubarea(area)
	    }
		
	    if area == area_pizza_sewers {
	        area = area_scrapyards
	        subarea = 0
	    }
	}
}
else if (!_went_crib && area != area_crib) {
    lastarea = area
    lastsubarea = subarea
}

var _max_subarea = scrAreaGetMaxSubarea(area)
if (subarea >= _max_subarea) {
	if (!_is_secret) {
		if (area < area_palace) {
			#region B-theme
			var _proto = 0
			
			if (crownvisits < 3) with (Player) {
				if (random(1) < 0.05 || hp <= 1) {
			        _proto = true
				}
			}
			
			if (!loops && (area == area_desert || area == area_palace)) _proto = false
			
			proto = _proto
			#endregion
			
		    area ++
			
		    if area == area_caves && scrPlayerCountCursed(all) {
		        area = area_cursed_caves
		    }
		}
		else {
		    loops ++
			area = area_campfire
			
		    scrAchievementUnlock(Achievement.GAME_LOOPED)
			
			if (!scrGameIsCustomMode()) {
			    UberCont.ctot_loop[_race] ++
				
			    if (loops > UberCont.cbst_loop[_race]) {
					UberCont.cbst_loop[_race] = loops
				}
				
				scrUnlocksWinOrLoop()
			}
		}

		subarea = 1
	}
}
else subarea ++
}

hard += scrGameIsHardmode() ? 2 : 1

waypnt[waypoints] = area
waysub[waypoints] = subarea
waylps[waypoints] = loops
waypoints ++

if instance_exists(Player) {
	if (instance_exists(WeaponChest) || instance_exists(BigWeaponChest)) && !(area == 1 && subarea == 1) {
	    nochest ++
	}
	
	if instance_exists(RadChest) || instance_exists(RadChestBig) || instance_exists(RadMaggotChest) {
		noradch ++
	}
	else noradch = 0
}

if scrGameIsHardmode() && _race == Race.Chicken && area == area_sewers {
    scrRaceUnlockSkin(Race.Chicken, SkinLetter.B)
}

if loops >= 2 && !UberCont.hardgot {
    save_set_value("etc", "hard", true)
    scrShowUnlockPopup("@wHARDMODE UNLOCKED@s#FOR REACHING LOOP 2")
    scrAchievementUnlock(Achievement.GO_HARD)
    UberCont.hardgot = true
	scrSave()
}

maxsubarea = scrAreaGetMaxSubarea(area)
finalsubarea = (subarea == maxsubarea)

// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomEnd.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("GameCont.RoomEnd.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomEnd.after