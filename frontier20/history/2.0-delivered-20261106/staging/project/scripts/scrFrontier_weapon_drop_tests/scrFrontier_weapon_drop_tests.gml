// These checks use the ordinary chest collision, source seed and native
// scrDecideWep provider. They never replace candidates, area rules or RNG.
function scrFRWeaponDropTestChest(_player,_target,_hard) {
    var _before=scrNTTEFullInstances(all),_chest=instance_create(_player.x,_player.y,WeaponChest),
        _chosen=wep_none,_seed=0,_source=scrNTTEFullSourceSeedState();
    try {
        GameCont.hard=_hard;
        for(var _try_seed=1;_try_seed<=4096;++_try_seed) {
            scrNTTEFullSourceRandomSeed(_try_seed,_source);
            with(_chest) _chosen=scrDecideWep(1,false);
            if((_target==wep_none && _chosen>0) || _chosen==_target) {_seed=_try_seed;break;}
        }
        assert(_seed>0,"Actual native chest provider never selected Frontier weapon "+string(_target));
        _source.wepseed=_seed;GameCont.ntte_source_wepdrops=0;
        _chest.curse=false;
        with(_chest) event_perform(ev_collision,Player);
        var _new=scrNTTEFullMergedRuntimeNew(_before),_drops=scrNTTEFullMergedRuntimeTestShots(_new,WepPickup);
        assert(!instance_exists(_chest) && array_length(_drops)==1 && _drops[0].wep==_chosen,
            "Real weapon chest did not create the provider's selected native weapon");
        assert(scr_weapon_is_valid(_drops[0].wep) && _drops[0].sprite_index==scr_weapon_get_sprite(_chosen)
            && _drops[0].name==scr_weapon_get_name(_chosen),
            "Frontier natural chest pickup has invalid identity or native presentation");
        scrNTTESmokeLog("FRONTIER REAL CHEST "+string(_chosen)+" seed="+string(_seed)+" hard="+string(_hard));
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);}
    return _chosen;
}

function scrFRWeaponDropTests() {
    var _players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),_player=instance_find(Player,0),
        _options=scrFRModGet("mod","Frontier_Options","options"),
        _old_pirate=_options.settingMainPoolPirateWeps,_old_labs=_options.settingMainPoolLabsWeps,
        _found=scrFRModGet("mod","Frontier_Projectiles","foundPirateWeps"),
        _before=scrNTTEFullInstances(all);
    try {
        _player.x=43816;_player.y=43816;_player.race=Race.Fish;
        _player.curse=0;_player.bcurse=0;
        _player.wep=wep_revolver;_player.bwep=wep_wrench;
        _player.ntte_state=scrNTTENewState(wep_revolver);_player.bntte_state=scrNTTENewState(wep_wrench);
        scrFRWeaponSlotsSync(_player);
        GameCont.crown=Crown.None;GameCont.area=area_desert;GameCont.subarea=1;
        GameCont.underwater=false;GameCont.ntte_weapon_spawn=[];
        var _base=scrNTTEFullWeaponDropCandidates(false),
            _all=scrFRWeaponDropCandidates(scrNTTEFullArrayCopy(_base)),_loaded=0;
        assert(array_length(_base)==166,"Frontier integration changed the existing NTTE candidate provider");
        for(var _i=0;_i<array_length(global.fr_module_order);++_i) {
            var _key=global.fr_module_order[_i];
            if(string_copy(_key,1,7)!="weapon:" || !(global.fr_initialized[$ _key]??false)) continue;
            var _raw=string_delete(_key,1,7),_weapon=scrFRWeaponDropRaw(_raw);
            if(is_undefined(_weapon)) continue;
            assert(_weapon>=179 && _weapon<=255 && scr_weapon_is_valid(_weapon)
                && scrNTTEFullWeaponDropResolve(_raw)==_weapon,
                "Frontier registered raw failed the actual native drop resolver: "+_raw);
            assert(_all[array_length(_base)+_loaded]==_raw,"Frontier loaded declaration order changed before shuffle");
            _loaded++;
        }
        assert(_loaded==77 && array_length(_all)==243
            && array_length(scrFRWeaponDropCandidates(_all))==243,
            "Frontier drop consumer omitted or duplicated a registered source declaration");
        var _pirate=scrFRWeaponResolve("FR_Blunderbuss"),_labs=scrFRWeaponResolve("FR_AR3");
        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolPirateWeps",0);
        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolLabsWeps",false);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        for(var _w=179;_w<=255;++_w) assert(scr_weapon_get_area(_w)==-1,
            "Disabled Frontier declaration remained in the natural drop pool: "+string(_w));
        assert(scrFRWeaponDropTestChest(_player,wep_none,22)<=178,
            "Disabled Frontier settings changed the eligible native chest pool");

        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolPirateWeps",1);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        assert(scr_weapon_get_area(_pirate)==8 && scrNTTEFullWeaponDropArea("FR_Blunderbuss",_player)==8
            && scr_weapon_get_area(_labs)==-1,"Live pirate setting did not reach the source area callback");
        var _loot_record={curse:0},_record_area;
        with(_loot_record) _record_area=scrNTTEFullWeaponDropArea("FR_Blunderbuss",self);
        assert(_record_area==8,
            "Real native drop metadata consumer required an instance id while scoped to its loot record");
        scrFRWeaponDropTestChest(_player,_pirate,8);
        GameCont.hard=0;
        for(var _sample=1;_sample<=32;++_sample) {
            scrNTTEFullSourceRandomSeed(_sample);
            var _low;with(_player) _low=scrDecideWep(1,false);
            assert(_low>0 && _low<=178,"Frontier natural drops bypassed native early difficulty bounds");
        }
        _player.wep=_pirate;_player.ntte_state=scrNTTENewState(_pirate);scrFRWeaponSlotsSync(_player);
        assert(scrNTTEFullWeaponDropDuplicates("FR_Blunderbuss",_player),"Frontier primary raw duplicate was admitted");
        _player.wep=wep_revolver;_player.ntte_state=scrNTTENewState(wep_revolver);
        _player.bwep=_pirate;_player.bntte_state=scrNTTENewState(_pirate);scrFRWeaponSlotsSync(_player);
        assert(scrNTTEFullWeaponDropDuplicates("FR_Blunderbuss",_player),"Frontier secondary raw duplicate was admitted");
        _player.race=Race.Steroids;
        assert(!scrNTTEFullWeaponDropDuplicates("FR_Blunderbuss",_player),"Frontier drops lost the native Steroids duplicate exception");
        _player.race=Race.Fish;_player.bwep=wep_wrench;_player.bntte_state=scrNTTENewState(wep_wrench);
        _player.wep=scrFRWeaponResolve("FR_Ballista");_player.ntte_state=scrNTTENewState(_player.wep);
        with(_player) scrFRWeaponPrepare(wep,true);
        assert(is_struct(scrFRWeaponSlotRead(_player,"wep"))
            && !scrNTTEFullWeaponDropDuplicates("FR_Ballista",_player),
            "Frontier duplicate filtering flattened an authored lightweight weapon record");
        _player.wep=wep_revolver;_player.ntte_state=scrNTTENewState(wep_revolver);scrFRWeaponSlotsSync(_player);

        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolPirateWeps","FOUND");
        scrFRModSet("mod","Frontier_Projectiles","foundPirateWeps",[]);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        assert(scr_weapon_get_area(_pirate)==-1 && scr_weapon_get_area(scrFRWeaponResolve("FR_AutoBlunderbuss"))==-1,
            "FOUND mode was treated as the author's all-pirate ON mode");
        var _discovered=scrFRModGet("mod","Frontier_Projectiles","foundPirateWeps");
        array_push(_discovered,"FR_Blunderbuss");
        assert(scr_weapon_get_area(_pirate)==8 && scr_weapon_get_area(scrFRWeaponResolve("FR_Ballista"))==-1,
            "Live source trade discovery did not update FOUND-mode natural eligibility");
        scrFRWeaponDropTestChest(_player,_pirate,8);

        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolPirateWeps",0);
        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolLabsWeps",true);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        assert(scr_weapon_get_area(_pirate)==-1 && scr_weapon_get_area(_labs)==21,
            "Live source Labs setting did not replace pirate eligibility");
        scrFRWeaponDropTestChest(_player,_labs,21);
        scrFROptionSet("mod","Frontier_Options","gameplay2","settingMainPoolLabsWeps",false);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        for(var _w=179;_w<=255;++_w) assert(scr_weapon_get_area(_w)==-1,
            "Switching settings OFF retained a cached Frontier natural spawn area");
        assert(scrFRWeaponDropTestChest(_player,wep_none,22)<=178,
            "Switching settings OFF failed to restore the original eligible chest pool");
    } finally {
        _options.settingMainPoolPirateWeps=_old_pirate;_options.settingMainPoolLabsWeps=_old_labs;
        scrFRModSet("mod","Frontier_Projectiles","foundPirateWeps",_found);
        scrFRModCall("mod","Frontier_Options","ExternalOptions_load");
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        global.rng_state=_rng;random_set_seed(_seed);
    }
    scrNTTESmokeLog("PASS FRONTIER actual native weapon chest drops, live Pirate/Labs/FOUND source callbacks, bounds and raw/LWO duplicates");
}
