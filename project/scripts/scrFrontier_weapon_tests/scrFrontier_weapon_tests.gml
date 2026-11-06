// Desktop harness only. Exercise the real native firing path and allow its
// ordinary projectiles/controllers to step between checks at both frame rates.
function scrFRWeaponTestsStart(_driver) {
    _driver.fr_wep_ids=variable_struct_get_names(global.fr_weapon_keys);
    _driver.fr_wep_index=0;_driver.fr_wep_age=0;_driver.fr_wep_rate=0;
    _driver.fr_wep_player=instance_find(Player,0);
    assert(instance_exists(_driver.fr_wep_player),"Weapon tests require an actual native Player");
    _driver.fr_wep_player_count=instance_number(Player);
    _driver.fr_wep_damage=0;_driver.fr_wep_seen={};_driver.fr_wep_outputs=0;
    _driver.fr_wep_original_rate=game_get_speed(gamespeed_fps);
    _driver.fr_wep_original_options={rate:save_get_option("options","framerate",60),
        autopause:save_get_option("options","autopause",true),
        freeze:save_get_option("visual","freezeframes",true),
        bossintro:save_get_option("visual","bossintro",true)};
    with(enemy) instance_deactivate_object(id);
    var _target=instance_create(52112,52000,Bandit),_sprite=_target.sprite_index,_mask=_target.mask_index;
    with(_target) {
        instance_change(FRCustomEnemy,false);scrFRActorInit();
        sprite_index=_sprite;mask_index=_mask;speed=0;hp=100000;max_hp=100000;can_die=false;
    }
    _driver.fr_wep_target=_target;
    _driver.fr_wep_baseline=scrNTTEFullInstances(all);
    scrFRWeaponTestsRate(30);
}

function scrFRWeaponTestsRate(_rate) {
    // Native options reload from the isolated save. Transient UberCont writes
    // are overwritten by scrOptionsUpdate and would both reset30 to60 and
    // enable focus-loss pause in the background acceptance runner.
    save_set_value("options","framerate",_rate);
    save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);
    scrOptionsUpdate();
    assert(game_get_speed(gamespeed_fps)==_rate && UberCont.opt_framerate==_rate
        && !UberCont.opt_autopause,"Frontier weapon fixture lost its native rate or background focus policy");
}

function scrFRWeaponTestsDamageIdentity(_shot,_owner) {
    // Disc deliberately keeps its constructor's native death-cause identity.
    // Wormhole can choose it from the real bolt list, so owner equality alone
    // rejects a correct random outcome. Still require the real caller context,
    // and do not admit arbitrary numeric identities on ordinary projectiles.
    return _shot.hitid==_owner.hitid || is_array(_shot.hitid)
        || (instance_is(_shot,Disc) && _shot.hitid==HitId.Disc
            && (_shot[$ "fr_damage_context_hitid"]??HitId.None)==_owner.hitid);
}

function scrFRWeaponTestsGather(_driver) {
    var _new=scrNTTEFullMergedRuntimeNew(_driver.fr_wep_baseline),_owner=_driver.fr_wep_player;
    for(var _i=0;_i<array_length(_new);++_i) {
        var _item=_new[_i],_key=string(real(_item));
        if(!instance_exists(_item) || variable_struct_exists(_driver.fr_wep_seen,_key)) continue;
        _driver.fr_wep_seen[$ _key]=true;_driver.fr_wep_outputs++;
        if(!instance_is(_item,projectile) || !variable_instance_exists(_item,"creator")) continue;
        var _creator=_item.creator;
        if(_creator==_owner) {
            if(_item.team!=_owner.team || !scrFRWeaponTestsDamageIdentity(_item,_owner))
                scrNTTESmokeLog("FRONTIER WEAPON ATTRIBUTION "+json_stringify({
                    weapon:global.fr_weapon_keys[$ string(real(_driver.fr_wep_ids[_driver.fr_wep_index]))],
                    age:_driver.fr_wep_age,rate:_driver.fr_wep_rate==0?30:60,
                    instance:real(_item),object:object_get_name(_item.object_index),
                    name:_item[$ "name"]??"",hitid:_item.hitid,
                    inherited:_item[$ "fr_damage_context_hitid"]??HitId.None,
                    step:string(_item[$ "on_step"]??undefined),
                    creator:real(_creator),creator_object:object_get_name(_creator.object_index),
                    creator_hitid:_creator.hitid,owner:real(_owner),owner_hitid:_owner.hitid,
                    team:_item.team,owner_team:_owner.team}));
            assert(_item.team==_owner.team,"Frontier authored projectile lost the native shooter's team");
            assert(scrFRWeaponTestsDamageIdentity(_item,_owner),"Frontier projectile lost damage attribution");
        }
    }
}

function scrFRWeaponTestsFireInput(_player,_held,_pressed) {
    var _index=_player.index,_hold=KeyCont.hold_fire[_index],_press=KeyCont.press_fire[_index];
    KeyCont.hold_fire[_index]=_held;KeyCont.press_fire[_index]=_pressed;
    try {with(_player) scrPlayerFiring(true);}
    finally {KeyCont.hold_fire[_index]=_hold;KeyCont.press_fire[_index]=_press;}
}

function scrFRWeaponTestsStep(_driver) {
    var _ids=_driver.fr_wep_ids,_index=_driver.fr_wep_index,_player=_driver.fr_wep_player;
    if(_index>=array_length(_ids)) {
        // Random Wormhole outcomes cannot guarantee coverage of its separate
        // NTTE object bridge. Exercise every real authored entry at the end
        // of each naturally settled 30/60Hz pass, retaining the strict oracle.
        scrFRWormholeNTTEAttributionTests(_player);
        if(_driver.fr_wep_rate==0) {
            _driver.fr_wep_rate=1;_driver.fr_wep_index=0;_driver.fr_wep_age=0;
            scrFRWeaponTestsRate(60);
            return false;
        }
        assert(_driver.fr_wep_damage>0,"Real Frontier projectile collisions never damaged a native enemy");
        scrNTTEFullMergedRuntimeTestCleanup(_driver.fr_wep_baseline);
        scrFRWeaponTestsCompatibility(_player);
        var _options=_driver.fr_wep_original_options;
        save_set_value("options","framerate",_options.rate);
        save_set_value("options","autopause",_options.autopause);
        save_set_value("visual","freezeframes",_options.freeze);
        save_set_value("visual","bossintro",_options.bossintro);
        scrOptionsUpdate();game_set_speed(_driver.fr_wep_original_rate,gamespeed_fps);
        return true;
    }
    var _weapon=real(_ids[_index]),_key=global.fr_weapon_keys[$ string(_weapon)],_age=_driver.fr_wep_age;
    if(_age==0) {
        scrNTTESmokeLog("FRONTIER WEAPON begin-cleanup "+_key);
        scrNTTEFullMergedRuntimeTestCleanup(_driver.fr_wep_baseline);
        scrNTTESmokeLog("FRONTIER WEAPON end-cleanup "+_key);
        _driver.fr_wep_seen={};_driver.fr_wep_outputs=0;
        scrNTTESmokeLog("FRONTIER FIRE "+string(_driver.fr_wep_rate==0?30:60)+" "+_key);
        with(_player) {
            x=52000;y=52000;xprevious=x;yprevious=y;speed=0;
            hp=10000;max_hp=10000;nexthurt=current_frame+100000;race=Race.Fish;
            wep=_weapon;bwep=wep_wrench;fr_source_wep=undefined;fr_source_bwep=undefined;
            ntte_state=scrNTTENewState(_weapon);bntte_state=scrNTTENewState(wep_wrench);
            ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);infammo=false;
            reload=0;breload=0;can_shoot=true;bcan_shoot=true;gunangle=0;accuracy=0;clicked=false;
            scrFRWeaponPrepare(_weapon,true);
        }
        scrNTTESmokeLog("FRONTIER WEAPON prepared "+_key);
        _driver.fr_wep_target.x=52112;_driver.fr_wep_target.y=52000;
        _driver.fr_wep_target.hp=100000;
        scrNTTESmokeLog("FRONTIER WEAPON prepared-target "+_key);
        _driver.fr_wep_charge=scrFRWeaponProperty(_key,"weapon_chrg",false);
        scrNTTESmokeLog("FRONTIER WEAPON prepared-charge "+_key+" charged="+string(_driver.fr_wep_charge));
    }
    if(_age==1 || (_driver.fr_wep_charge && _age>1 && _age<=20)) {
        if(_age==1) scrNTTESmokeLog("FRONTIER WEAPON begin-fire "+_key);
        scrFRWeaponTestsFireInput(_player,true,_age==1);
        if(_age==1) scrNTTESmokeLog("FRONTIER WEAPON end-fire "+_key);
    }
    if(_driver.fr_wep_charge && _age==21) {
        scrFRWeaponTestsFireInput(_player,false,false);
        var _state=scrFRWeaponSlotRead(_player,"wep");
        assert(is_struct(_state) && _state.chrg==0 && _state.chrg_num==0,"Charged input did not release/reset its source state");
    }
    if(_age<=1 || _age==23) scrNTTESmokeLog("FRONTIER WEAPON begin-gather "+_key+" age="+string(_age)
        +" instances="+string(instance_count)+" baseline="+string(array_length(_driver.fr_wep_baseline)));
    scrFRWeaponTestsGather(_driver);
    if(_age<=1 || _age==23) scrNTTESmokeLog("FRONTIER WEAPON end-gather "+_key+" age="+string(_age));
    if(_age==23) {
        assert(!is_struct(_player.wep) && _player.wep==_weapon && _player.bwep==wep_wrench,
            "Source lightweight state corrupted native equipped inventory");
        assert(_driver.fr_wep_outputs>0,"Frontier ordinary fire path produced no attack or authored effect: "+_key);
        _driver.fr_wep_damage+=max(0,100000-_driver.fr_wep_target.hp);
        // Exercise NPC/companion firing and let end-step ownership rewriting
        // happen naturally before the next assertions.
        _driver.fr_wep_owner_ammo=scrNTTEFullArrayCopy(_player.ammo);
        _driver.fr_wep_owner_state=_player[$ "fr_source_wep"]??undefined;
        scrNTTESmokeLog("FRONTIER WEAPON begin-npc "+_key);
        scrFRPlayerFireExt(0,_weapon,52000,52000,_player.team,_player,0);
        scrNTTESmokeLog("FRONTIER WEAPON end-npc "+_key);
    }
    if(_age==29) {
        assert(instance_number(Player)==_driver.fr_wep_player_count,"NPC fire proxy registered an extra native Player");
        assert(_player.wep==_weapon && _player.bwep==wep_wrench
            && (_player[$ "fr_source_wep"]??undefined)==_driver.fr_wep_owner_state,
            "NPC fire proxy modified its owner's source inventory");
        for(var _a=0;_a<array_length(_player.ammo);++_a)
            assert(_player.ammo[_a]==_driver.fr_wep_owner_ammo[_a],"NPC fire consumed its real owner's ammo");
    }
    if(_age>=40) {_driver.fr_wep_index++;_driver.fr_wep_age=0;}
    else _driver.fr_wep_age++;
    if(_age==0) scrNTTESmokeLog("FRONTIER WEAPON end-age0 "+_key+" frame="+string(current_frame));
    return false;
}

function scrFRWeaponTestsCompatibility(_player) {
    scrFRWeaponTestsSourceValues(_player);
    var _raw=global.fr_weapon_ids[$ "FR_TeminiteCannon"];
    _player.wep=_raw;_player.bwep=wep_wrench;_player.fr_source_wep=undefined;
    with(_player) scrFRWeaponPrepare(_raw,true);
    var _state=scrFRWeaponSlotRead(_player,"wep");
    _state.teminite=5;
    with(_player) {
        assert(scr_weapon_get_cost(_raw)==1 && scr_weapon_get_load(_raw)==3,"LWO dynamic metadata ignored native held state");
        var _saved=scrFRContinueWeaponEncode(_state),_restored=scrFRContinueWeaponDecode(json_parse(json_stringify(_saved)));
        assert(_restored.teminite==5 && _restored.wep==_raw,"LWO symbolic continue round trip lost combo state");
        scrSwapWeps(false);
        assert(scrFRWeaponSlotRead(id,"bwep")==_state && !is_struct(scrFRWeaponSlotRead(id,"wep")),
            "Native weapon swap lost its lightweight state identity");
    }
    scrFRWeaponTestsPhysicalTransfers(_player);
    // A Frontier raw stock and an existing NTTE fusion front must remain a
    // native merge tree, without either adapter mistaking LWO for the other.
    var _before=scrNTTEFullInstances(all),_merge=scrNTTEFullWeaponMerge(_raw,{wep:wep_revolver});
    var _handle=scrNTTEFullWeaponNative(_merge);
    _player.wep=_handle;_player.bwep=wep_wrench;
    _player.ntte_state=scrNTTEFullWeaponNativeState(_merge);
    with(_player) {reload=0;can_shoot=true;scrFire(_handle,false,true);}
    assert(_player.wep==_handle && scrNTTEFullWeaponHasMerge(_merge)!=false,"Frontier firing damaged an existing NTTE fusion tree");
    assert(array_length(scrNTTEFullMergedRuntimeNew(_before))>0,"Mixed Frontier/NTTE fusion produced no native attack");
    scrNTTEFullMergedRuntimeTestCleanup(_before);
    scrNTTESmokeLog("PASS FRONTIER 77 ordinary input and NPC fire paths at30/60, charge release, team/owner, inventory, dynamic metadata and mixed fusion");
}

function scrFRWeaponTestsSourceValues(_player) {
    var _raw=global.fr_weapon_ids[$ "FR_StarPistol"],_lwo=global.fr_weapon_ids[$ "FR_TeminiteCannon"],
        _wep=_player.wep,_back=_player.bwep,_physical=_player.ntte_state,_bphysical=_player.bntte_state,
        _sourcea=_player[$ "fr_source_wep"]??undefined,_sourceb=_player[$ "fr_source_bwep"]??undefined,
        _language=global.language_current[$ "Init:Id"],
        _holder=instance_create(55000,55000,FRCustomObject);
    try {
        scrFRWeaponSlotWrite(_player,"wep",_raw);
        var _source=scrFRWeaponSlotRead(_player,"wep"),_local=_source,_array=[_local];
        assert(is_string(_local) && _local=="FR_StarPistol" && is_string(_array[0])
            && _player.wep==_raw && is_numeric(_player.wep),
            "Ordinary source MOD inventory lost string semantics or changed the native numeric slot");
        // Metadata is localized at its display boundary; dispatch identities
        // remain unchanged in either language. Check independent exact names
        // rather than requiring English while the isolated save uses Chinese.
        for(var _language_case=0;_language_case<2;++_language_case) {
            global.language_current[$ "Init:Id"]=_language_case==0?"English":"Simplified Chinese";
            var _expected_name=_language_case==0?"LITTLE DIPPER":"小北斗";
            assert(scrFRScriptExists("weapon",_local,"weapon_name")
                && scrFRModCallArray("weapon",_array[0],"weapon_name",[])==_expected_name,
                "Authored local/array is_string dispatch could not reach its actual loaded weapon module");
            assert(scrFRModCallArray("weapon",_raw,"weapon_name",[])==_expected_name
                && scrFRModCallArray("wep",{wep:_raw},"weapon_name",[])==_expected_name,
                "Native and lightweight weapon module dispatch did not resolve their declared source identity");
            assert(_local=="FR_StarPistol" && _array[0]==_local && _player.wep==_raw,
                "Localized weapon metadata changed an authored or native inventory identity");
        }
        scrFRWeaponSlotWrite(_holder,"wep",_raw);
        assert(scrFRWeaponSlotRead(_holder,"wep")==_source,
            "An authored burst/exchanger controller observed a different source weapon identity");
        scrFRWeaponSlotWrite(_player,"wep",wep_wrench);
        assert(is_numeric(scrFRWeaponSlotRead(_player,"wep")),"Vanilla source weapons must stay numeric");
        scrFRWeaponSlotWrite(_player,"wep",_lwo);
        with(_player) scrFRWeaponPrepare(_lwo,true);
        var _state=scrFRWeaponSlotRead(_player,"wep");
        assert(is_struct(_state) && !is_string(_state)
            && _player.ntte_state.fr_source_weapon==_state && scrFRWeaponRaw(_state)==_lwo,
            "The source type boundary replaced a canonical lightweight weapon with a string");
        scrNTTESmokeLog("PASS FRONTIER ordinary source MOD strings through locals/arrays/controller slots and actual metadata dispatch; native numeric inventory and canonical LWO identity retained");
    } finally {
        global.language_current[$ "Init:Id"]=_language;
        _player.wep=_wep;_player.bwep=_back;_player.ntte_state=_physical;_player.bntte_state=_bphysical;
        _player.fr_source_wep=_sourcea;_player.fr_source_bwep=_sourceb;
        instance_destroy(_holder,false);
    }
}

function scrFRWeaponTestsPhysicalTransfers(_player) {
    var _before=scrNTTEFullInstances(all),_raw=global.fr_weapon_ids[$ "FR_TeminiteCannon"],
        _index=_player.index,_press=KeyCont.press_pick[_index],_swap=KeyCont.press_swap[_index];
    try {
        with(_player) {
            x=54000;y=54000;speed=0;can_pick=true;curse=0;bcurse=0;max_extra_weps=0;
            scrExtraWepsReset();wep=_raw;bwep=_raw;
            ntte_state=scrNTTENewState(_raw);bntte_state=scrNTTENewState(_raw);
            fr_source_wep=undefined;fr_source_bwep=undefined;
            scrFRWeaponPrepare(_raw,true);
        }
        var _a=scrFRWeaponSlotRead(_player,"wep"),_b=scrFRWeaponSlotRead(_player,"bwep");
        assert(is_struct(_a) && is_struct(_b) && _a!=_b,"Twin physical Frontier weapons shared their source record");
        _a.teminite=3;_b.teminite=7;
        with(_player) scrSwapWeps(false);
        assert(scrFRWeaponSlotRead(_player,"wep")==_b && scrFRWeaponSlotRead(_player,"bwep")==_a,
            "A native swap confused two distinct copies of the same Frontier raw weapon");
        var _incoming=instance_create(_player.x,_player.y,WepPickup),_c={wep:_raw,teminite:11};
        scrFRWeaponSlotWrite(_incoming,"wep",_c);
        _incoming.speed=0;_incoming.autopick=true;_incoming.visible=true;
        assert(is_numeric(_incoming.wep) && _incoming.wep==_raw && _incoming.ntte_state.fr_source_weapon==_c,
            "Source WepPickup assignment leaked an LWO into the native merge registry");
        assert(_incoming.sprite_index==scr_weapon_get_sprite(_raw),"Source WepPickup retained default screwdriver artwork");
        KeyCont.press_pick[_index]=false;KeyCont.press_swap[_index]=false;
        with(_incoming) with(_player) event_perform(ev_collision,WepPickup);
        assert(!instance_exists(_incoming) && scrFRWeaponSlotRead(_player,"wep")==_c
            && scrFRWeaponSlotRead(_player,"bwep")==_a,"Actual native pickup lost incoming or secondary Frontier state");
        var _drops=scrNTTEFullMergedRuntimeNew(_before),_outgoing=noone;
        for(var _i=0;_i<array_length(_drops);++_i) {
            var _item=_drops[_i];
            if(instance_exists(_item) && instance_is(_item,WepPickup)
                && scrFRWeaponSlotRead(_item,"wep")==_b) {_outgoing=_item;break;}
        }
        assert(instance_exists(_outgoing) && _outgoing.wep==_raw && _outgoing.ntte_state.fr_source_weapon==_b,
            "Native exchange dropped a fresh Frontier state instead of the held physical weapon");
        _outgoing.x=_player.x;_outgoing.y=_player.y;_outgoing.speed=0;_outgoing.autopick=true;
        with(_outgoing) with(_player) event_perform(ev_collision,WepPickup);
        assert(!instance_exists(_outgoing) && scrFRWeaponSlotRead(_player,"wep")==_b && _b.teminite==7,
            "Picking the physical Frontier weapon back up changed identity or its combo value");
        with(_player) {
            scrExtraWepStoreCurrent();wep=wep_none;ntte_state=undefined;scrExtraWepRestoreFirst();
            assert(scrFRWeaponSlotRead(id,"wep")==_b && ntte_state.fr_source_weapon==_b,
                "Native extra-slot storage lost the original Frontier source record");
        }
        scrNTTESmokeLog("PASS FRONTIER actual native same-type twin swap, source ground assignment, two-way pickup/drop and extra-slot state identity");
    } finally {
        KeyCont.press_pick[_index]=_press;KeyCont.press_swap[_index]=_swap;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}
