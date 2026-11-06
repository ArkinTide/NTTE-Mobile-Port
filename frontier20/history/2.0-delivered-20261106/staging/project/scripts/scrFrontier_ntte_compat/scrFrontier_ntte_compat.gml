// Frontier 1.0.3.3 -> maintained NTTE native content adapters.
// All special-module calls use an args ARRAY; unsupported members throw.
// The parent bridge owns generic modules and invokes these only when Handles.
function scrFRNTTEHandles(_type,_module) {
    var _kind=string_lower(string(_type)),_name=string_lower(string(_module));
    if(_kind=="wep") _kind="weapon";
    if(_kind=="mod") {
        switch(_name) {
            case "ntte":case "tesewers":case "teassets":case "telib":
            case "petlib":case "details+":case "undergrowth":return true;
        }
    }
    if(_kind=="area" && _name=="undergrowth") return true;
    if(_kind=="weapon") {
        switch(_name) {case "fossil gun":case "fossil cannon":case "fossil hammer":case "energy bat":return true;}
    }
    return false;
}
function scrFRNTTEExists(_type,_module) {return scrFRNTTEHandles(_type,_module);}
function scrFRNTTEKey(_type,_module) {
    var _kind=string_lower(string(_type)),_name=string_lower(string(_module));
    if(_kind=="wep") _kind="weapon";
    if(_name=="undergrowth" && (_kind=="area" || _kind=="mod")) return "area:undergrowth";
    return _kind+":"+_name;
}
function scrFRNTTEState() {
    if(!variable_global_exists("fr_module_vars")) global.fr_module_vars={};
    var _key="mod:__frontier_ntte_adapter";
    if(!variable_struct_exists(global.fr_module_vars,_key))
        global.fr_module_vars[$ _key]={statues:{},scorches:{},native_sprites:{},initialized:false};
    return global.fr_module_vars[$ _key];
}
function scrFRNTTEAreaTag(_tag) {
    switch(_tag) {
        case "area_desert":return area_desert;
        case "area_sewers":return area_sewers;
        case "area_scrapyards":return area_scrapyards;
        case "area_caves":return area_caves;
        case "area_palace":return area_palace;
        case "area_oasis":return area_oasis;
        case "area_pizza_sewers":return area_pizza_sewers;
        case "area_cursed_caves":return area_cursed_caves;
        case "trench":return 205;
    }
    throw "Unknown NTTE sprite map area: "+string(_tag);
}
function scrFRNTTEPathSet(_root,_path,_value) {
    var _parts=string_split(_path,"."),_node=_root;
    for(var _i=0;_i<array_length(_parts)-1;++_i) {
        var _part=_parts[_i];
        if(!variable_struct_exists(_node,_part)) _node[$ _part]={};
        _node=_node[$ _part];
        if(!is_struct(_node)) throw "NTTE registry path is not a struct: "+_path;
    }
    _node[$ _parts[array_length(_parts)-1]]=_value;
}
function scrFRNTTEPathGet(_root,_path) {
    var _parts=string_split(_path,"."),_node=_root;
    for(var _i=0;_i<array_length(_parts);++_i) {
        if(!is_struct(_node) || !variable_struct_exists(_node,_parts[_i])) return undefined;
        _node=_node[$ _parts[_i]];
    }
    return _node;
}
function scrFRNTTESpriteMapSet(_root,_key,_value) {
    var _map=string_pos("msk.",_key)==1 ? _root.msk.BigTopDecal:_root.BigTopDecal;
    var _parts=string_split(_key,".");
    ds_map_set(_map,scrFRNTTEAreaTag(_parts[array_length(_parts)-1]),_value);
}
function scrFRNTTESpriteMapGet(_root,_key) {
    var _map=string_pos("msk.",_key)==1 ? _root.msk.BigTopDecal:_root.BigTopDecal;
    var _parts=string_split(_key,"."),_area=scrFRNTTEAreaTag(_parts[array_length(_parts)-1]);
    return ds_map_exists(_map,_area) ? _map[? _area]:undefined;
}
function scrFRNTTEInit() {
    var _state=scrFRNTTEState();
    if(_state.initialized) return;
    // Mark only after population. The uncached resolver prevents recursion
    // through the optional scrNTTERefSprite override hook during startup.
    var _assets={spr:{BigTopDecal:ds_map_create(),msk:{BigTopDecal:ds_map_create()}},snd:{}};
    var _keys=scrFRNTTESpriteKeys();
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_value=scrNTTERefSpriteUncached(_key);
        if(string_pos("BigTopDecal.",_key)==1 || string_pos("msk.BigTopDecal.",_key)==1)
            scrFRNTTESpriteMapSet(_assets.spr,_key,_value);
        else scrFRNTTEPathSet(_assets.spr,_key,_value);
    }
    var _sounds=scrFRNTTESoundKeys();
    for(var _i=0;_i<array_length(_sounds);++_i)
        scrFRNTTEPathSet(_assets.snd,_sounds[_i],scrNTTERefSound(_sounds[_i]));
    global.fr_module_vars[$ "mod:teassets"]=_assets;
    global.fr_module_vars[$ "mod:Details+"]={knownMods:[]};
    var _ug={},_ug_rows=scrFRNTTEUGSpriteRows();
    for(var _i=0;_i<array_length(_ug_rows);++_i) _ug[$ _ug_rows[_i][0]]=_ug_rows[_i][1];
    global.fr_module_vars[$ "area:undergrowth"]=_ug;
    global.fr_module_vars[$ "weapon:fossil gun"]={sprLavaBomb:sprUGLavaBomb};
    global.fr_module_vars[$ "weapon:fossil cannon"]={sprLavaBombBig:sprUGLavaBombBig};
    global.fr_module_vars[$ "weapon:fossil hammer"]={sprLavaSlash:sprUGLavaSlash};
    // The native weapon and teassets expose the same mutable source field.
    // Keep one struct so AugmentLaserBrain can replace and restore either view.
    global.fr_module_vars[$ "weapon:energy bat"]=_assets.spr.Weapon[$ "energy bat"];
    _state.initialized=true;
}
function scrFRRegisterNTTECompat() {scrFRNTTEInit();}
function scrFRNTTEScriptExists(_type,_module,_script) {
    if(!scrFRNTTEHandles(_type,_module)) return false;
    switch(scrFRNTTEKey(_type,_module)) {
        case "mod:telib":return _script=="obj_create";
        case "mod:petlib":return _script=="pet_set_skin";
        case "area:undergrowth":return _script=="obj_create";
        case "mod:details+":return _script=="detailsPlus_add_statue" || _script=="detailsPlus_add_scorch";
    }
    return false;
}
function scrFRNTTEVariableExists(_type,_module,_field) {
    if(!scrFRNTTEHandles(_type,_module)) return false;
    scrFRNTTEInit();
    var _key=scrFRNTTEKey(_type,_module);
    if(_key=="mod:details+") return _field=="knownMods";
    if(!variable_struct_exists(global.fr_module_vars,_key)) return false;
    return variable_struct_exists(global.fr_module_vars[$ _key],_field);
}
function scrFRNTTEGet(_type,_module,_field) {
    if(!scrFRNTTEVariableExists(_type,_module,_field))
        throw "Frontier NTTE variable is not implemented: "+string(_type)+":"+string(_module)+"."+string(_field);
    var _key=scrFRNTTEKey(_type,_module);
    if(_key=="mod:details+") _key="mod:Details+";
    return global.fr_module_vars[$ _key][$ _field];
}
function scrFRNTTESet(_type,_module,_field,_value) {
    if(!scrFRNTTEVariableExists(_type,_module,_field))
        throw "Frontier NTTE variable is not implemented: "+string(_type)+":"+string(_module)+"."+string(_field);
    var _key=scrFRNTTEKey(_type,_module);
    if(_key=="mod:details+") {
        if(!is_array(_value)) throw "Details+ knownMods must be an array";
        _key="mod:Details+";
    }
    if(_key=="area:undergrowth" || string_pos("weapon:fossil ",_key)==1 || _key=="weapon:energy bat") {
        var _base=scrFRNTTEOriginalNativeSprite(_key,_field);
        if(is_undefined(_base)) throw "No native sprite consumer binding: "+_key+"."+_field;
        if(!sprite_exists(_value)) throw "Frontier native sprite override is invalid: "+_key+"."+_field;
        var _state=scrFRNTTEState();
        _state.native_sprites[$ string(_base)]=_value;
    }
    global.fr_module_vars[$ _key][$ _field]=_value;
    return _value;
}
function scrFRNTTECall(_type,_module,_script,_args) {
    if(!is_array(_args)) throw "Frontier NTTE call requires an argument array";
    if(!scrFRNTTEScriptExists(_type,_module,_script))
        throw "Frontier NTTE script is not implemented: "+string(_type)+":"+string(_module)+"."+string(_script);
    scrFRNTTEInit();
    switch(scrFRNTTEKey(_type,_module)) {
        case "mod:telib":
            if(array_length(_args)!=3) throw "telib.obj_create expects x, y, name";
            return scrNTTEFullSystemsCreate(_args[2],_args[0],_args[1]);
        case "area:undergrowth":
            if(array_length(_args)!=3) throw "undergrowth.obj_create expects x, y, name";
            return scrUGCreate(_args[0],_args[1],_args[2]);
        case "mod:petlib":
            if(array_length(_args)!=2) throw "petlib.pet_set_skin expects pet, skin";
            return scrFRNTTEPetSetSkin(_args[0],_args[1]);
        case "mod:details+":
            if(_script=="detailsPlus_add_statue") {
                if(array_length(_args)!=2 || !is_array(_args[1]) || array_length(_args[1])!=2)
                    throw "Details+ statue registration expects area, [idle, dead]";
                var _state=scrFRNTTEState();
                _state.statues[$ string(_args[0])]=_args[1];
                return true;
            }
            if(array_length(_args)!=3 || !is_array(_args[1]) || !is_array(_args[2])
                || array_length(_args[1])==0 || array_length(_args[1])!=array_length(_args[2]))
                throw "Details+ scorch registration requires equally sized nonempty top/ground arrays";
            var _state=scrFRNTTEState();
            _state.scorches[$ string(_args[0])]=[_args[1],_args[2]];
            return true;
    }
    throw "Frontier NTTE dispatch contract was violated";
}
// Native consumers call these BEFORE their fixed switches/caches. Undefined
// explicitly means fall through to the existing native implementation.
function scrFRNTTESpriteOverride(_key,_index=-1) {
    if(!variable_global_exists("fr_module_vars") || !variable_struct_exists(global.fr_module_vars,"mod:teassets")) return undefined;
    var _root=global.fr_module_vars[$ "mod:teassets"].spr,_value;
    if(string_pos("BigTopDecal.",_key)==1 || string_pos("msk.BigTopDecal.",_key)==1)
        _value=scrFRNTTESpriteMapGet(_root,_key);
    else _value=scrFRNTTEPathGet(_root,_key);
    if(is_undefined(_value)) return undefined;
    if(_index<0) return _value;
    if(!is_array(_value)) throw "NTTE scalar sprite indexed: "+_key;
    if(_index!=floor(_index) || _index>=array_length(_value)) throw "NTTE sprite index missing: "+_key+"["+string(_index)+"]";
    return _value[_index];
}
function scrFRNTTENativeSprite(_sprite) {
    if(!variable_global_exists("fr_module_vars") || !variable_struct_exists(global.fr_module_vars,"mod:__frontier_ntte_adapter")) return _sprite;
    var _sprites=global.fr_module_vars[$ "mod:__frontier_ntte_adapter"].native_sprites,_key=string(_sprite);
    return variable_struct_exists(_sprites,_key) ? _sprites[$ _key]:_sprite;
}
function scrFRNTTEWeaponSprite(_weapon) {
    if(!is_real(_weapon) || _weapon!=wep_ntte_energy_bat) return undefined;
    if(!variable_global_exists("fr_module_vars") || !variable_struct_exists(global.fr_module_vars,"weapon:energy bat")) return undefined;
    return global.fr_module_vars[$ "weapon:energy bat"].sprWep;
}
function scrFRNTTEOriginalNativeSprite(_module_key,_field) {
    if(_module_key=="weapon:energy bat" && _field=="sprWep") return scrNTTERefSpriteUncached("Weapon.energy bat.sprWep");
    if(_module_key=="weapon:fossil gun" && _field=="sprLavaBomb") return sprUGLavaBomb;
    if(_module_key=="weapon:fossil cannon" && _field=="sprLavaBombBig") return sprUGLavaBombBig;
    if(_module_key=="weapon:fossil hammer" && _field=="sprLavaSlash") return sprUGLavaSlash;
    if(_module_key=="area:undergrowth") {
        var _rows=scrFRNTTEUGSpriteRows();
        for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i][0]==_field) return _rows[_i][1];
    }
    return undefined;
}
function scrFRNTTEStatueSprites(_area) {
    if(!variable_global_exists("fr_module_vars") || !variable_struct_exists(global.fr_module_vars,"mod:__frontier_ntte_adapter")) return undefined;
    var _items=scrFRNTTEState().statues,_key=string(_area);
    if(variable_struct_exists(_items,_key)) return _items[$ _key];
    // Source registries use named mod areas; the native world uses numeric IDs.
    if(variable_global_exists("fr_area_ids")) {
        var _names=variable_struct_get_names(global.fr_area_ids);
        for(var _i=0;_i<array_length(_names);++_i) if(global.fr_area_ids[$ _names[_i]]==_area) {
            var _name=_names[_i];
            if(string_pos("area:",_name)==1) _name=string_delete(_name,1,5);
            if(variable_struct_exists(_items,_name)) return _items[$ _name];
        }
    }
    return undefined;
}
function scrFRNTTEScorchSprites(_floor) {
    if(!variable_global_exists("fr_module_vars") || !variable_struct_exists(global.fr_module_vars,"mod:__frontier_ntte_adapter")) return undefined;
    var _items=scrFRNTTEState().scorches,_key=string(_floor);
    return variable_struct_exists(_items,_key) ? _items[$ _key]:undefined;
}
// NTTE's source pets were CustomHitme tagged NTTEPet; the maintained native
// implementation has its own NTTEFullPet class. Only this authored positive
// tag query admits that equivalent. Generic CustomHitme scans, other names,
// negative filters, constructors and the native inheritance tree stay intact.
function scrFRNTTEPetFilterItems(_target,_field,_values,_operation,_items) {
    if(is_array(_target) || is_struct(_target) || is_undefined(_target)
        || _target!=FRCustomHitme || _operation!=0 || _field!="name"
        || !array_contains(_values,"NTTEPet")) return _items;
    with(NTTEFullPet) if(name=="NTTEPet" && !array_contains(_items,real(id)))
        array_push(_items,real(id));
    return _items;
}

function scrFRNTTEPetSkinSprite(_skin,_part) {
    if(!is_array(_skin) || array_length(_skin)!=3) throw "Frontier pet skin requires [type, module, name]";
    return scrFRModCallArray(_skin[0],_skin[1],_skin[2]+"_sprite",[_part]);
}
function scrFRNTTEPetSetSkin(_pet,_skin) {
    if(!instance_exists(_pet)) return false;
    if(!is_array(_skin)) return scrNTTEFullPetSetSkin(_pet,_skin);
    if(array_length(_skin)!=3) throw "Frontier pet skin requires [type, module, name]";
    // Resolve all fields before mutation, so a missing provider fails atomically.
    var _parts=["icon","idle","walk","hurt","dead","spwn","fire","shadow_y","bubble","bubble_pop"],_values=[];
    with(_pet) {
        for(var _i=0;_i<array_length(_parts);++_i) {
            var _value=scrFRNTTEPetSkinSprite(_skin,_parts[_i]);
            if(is_undefined(_value)) throw "Frontier pet skin is missing field: "+_parts[_i];
            array_push(_values,_value);
        }
        bskin=_skin;
        for(var _i=0;_i<array_length(_parts);++_i) scrNTTEFullPetSkinField("spr_"+_parts[_i],_values[_i]);
        hitid[0]=spr_idle;
        if(instance_exists(prompt)) {prompt.text=scrNTTEFullPetPromptText(id);prompt.sprite_index=spr_icon;}
    }
    return true;
}
function scrFRNTTEAdapterTests() {
    scrFRNTTEInit();
    assert(scrFRNTTEExists("mod","ntte") && scrFRNTTEExists("mod","tesewers"),"Native NTTE aliases missing");
    assert(scrFRNTTEExists("mod","undergrowth") && scrFRNTTEExists("area","undergrowth"),"Undergrowth alias mismatch");
    assert(!scrFRNTTEExists("area","scorpionboss"),"Unintegrated optional content advertised");
    assert(scrFRNTTEScriptExists("mod","telib","obj_create") && !scrFRNTTEScriptExists("mod","telib","not_implemented"),"NTTE script existence mismatch");
    var _spr=scrFRNTTEGet("mod","teassets","spr"),_same=scrFRNTTEGet("mod","teassets","spr");
    var _old=_spr.FloorCoast,_replacement=_spr.FloorCoastB;
    _spr.FloorCoast=_replacement;
    assert(_same.FloorCoast==_replacement && scrFRNTTESpriteOverride("FloorCoast")==_replacement,"teassets mutation was lost");
    _spr.FloorCoast=_old;
    assert(_spr.BigTopDecal[? area_caves]==scrNTTERefSpriteUncached("BigTopDecal.area_caves"),"NTT area-keyed sprite map changed");
    assert(scrFRNTTEGet("mod","teassets","snd").mus.Coast==scrNTTERefSound("mus.Coast"),"Native music binding changed");
    assert(scrFRNTTEExists("weapon","energy bat") && scrFRNTTEVariableExists("weapon","energy bat","sprWep")
        && !scrFRNTTEVariableExists("weapon","energy bat","not_implemented")
        && !scrFRNTTEScriptExists("weapon","energy bat","not_implemented"),"Native energy bat module contract changed");
    assert(scrFRNTTEExists("wep","energy bat") && scrFRNTTEExists("wep","fossil cannon")
        && scrFRNTTEKey("wep","energy bat")==scrFRNTTEKey("weapon","energy bat")
        && scrFRNTTEGet("wep","energy bat","sprWep")==scrFRNTTEGet("weapon","energy bat","sprWep")
        && scrFRNTTEScriptExists("wep","energy bat","not_implemented")==scrFRNTTEScriptExists("weapon","energy bat","not_implemented"),
        "NTT wep/weapon native module aliases diverged");
    var _bat=scrFRNTTEGet("weapon","energy bat","sprWep"),_bat_alt=_spr.PopoEnergyBatSlash;
    try {
        scrFRNTTESet("weapon","energy bat","sprWep",_bat_alt);
        assert(scrFRNTTEWeaponSprite(wep_ntte_energy_bat)==_bat_alt
            && scrNTTERefSprite("Weapon.energy bat.sprWep")==_bat_alt
            && scrFRNTTENativeSprite(scrFRNTTEOriginalNativeSprite("weapon:energy bat","sprWep"))==_bat_alt,
            "Native energy bat runtime consumers ignored the augment sprite");
        if(scrNTTEFullWeaponAvailable(wep_ntte_energy_bat))
            assert(scr_weapon_get_sprite(wep_ntte_energy_bat)==_bat_alt,"Native energy bat held/pickup artwork stayed cached");
    } finally {scrFRNTTESet("weapon","energy bat","sprWep",_bat);}
    assert(scrFRNTTEGet("weapon","energy bat","sprWep")==_bat
        && scrNTTERefSprite("Weapon.energy bat.sprWep")==_bat,"Native energy bat augment artwork failed to restore");
    var _failed=false;
    try {scrFRNTTECall("mod","telib","not_implemented",[]);} catch(_e) {_failed=true;}
    assert(_failed,"Unsupported special module operation was silently accepted");
    return true;
}
// Generated registry tables follow; source keys retain nested arrays/maps.

function scrFRNTTESpriteKeys() {
    return ["AcidPuff","AlbinoBolt","AlbinoGatorDead","AlbinoGatorHurt","AlbinoGatorIdle","AlbinoGatorWalk","AlbinoGatorWeap","AlbinoGrenade","AlbinoSplinter","AlertIndicator","AlertIndicatorMystery","AlertIndicatorOrchid","AlertIndicatorPopo","AllyAlert","AllyBackpack","AllyBackpackOpen","AllyLaserCharge","AllyNecroReviveArea","AllyReviveArea","AllySniperBullet","AnglerAppear","AnglerAssaultRifle","AnglerBazooka","AnglerBolt","AnglerCrossbow","AnglerDead","AnglerDisc","AnglerDiscGun","AnglerGoldAppear","AnglerGoldDead","AnglerGoldHurt","AnglerGoldIdle","AnglerGoldScreech","AnglerGoldWalk","AnglerGrenade","AnglerGrenadeLauncher","AnglerGuitar","AnglerHurt","AnglerIdle","AnglerLaserPistol","AnglerLight","AnglerMachinegun","AnglerNuke","AnglerNukeLauncher","AnglerPlasmaGun","AnglerRevolver","AnglerRocket","AnglerScrewdriver","AnglerShotgun","AnglerSlugger","AnglerSplinterGun","AnglerTeleportGun","AnglerTrail","AnglerTrident","AnglerTunneller","AnglerTunnellerHUD","AnglerWalk","AnglerWrench","BabyGatorDead","BabyGatorHurt","BabyGatorIdle","BabyGatorWalk","BabyGatorWeap","BabyScorpionDead","BabyScorpionFire","BabyScorpionGoldDead","BabyScorpionGoldFire","BabyScorpionGoldHurt","BabyScorpionGoldIdle","BabyScorpionGoldWalk","BabyScorpionHurt","BabyScorpionIdle","BabyScorpionWalk","Backpack","BackpackCursed","BackpackCursedOpen","BackpackDebris","BackpackOpen","BackpackerHurt","BackpackerIdle","BanditAlert","BanditCamperDead","BanditCamperHurt","BanditCamperIdle","BanditCamperWalk","BanditCampfire","BanditHikerDead","BanditHikerHurt","BanditHikerIdle","BanditHikerWalk","BanditTentDead","BanditTentHurt","BanditTentIdle","BanditTentWallDead","BanditTentWallHurt","BanditTentWallIdle","Base.AlbinoGatorWeap","Base.AnglerAssaultRifle","Base.AnglerBazooka","Base.AnglerCrossbow","Base.AnglerDiscGun","Base.AnglerGrenadeLauncher","Base.AnglerGuitar","Base.AnglerLaserPistol","Base.AnglerMachinegun","Base.AnglerNukeLauncher","Base.AnglerPlasmaGun","Base.AnglerRevolver","Base.AnglerScrewdriver","Base.AnglerShotgun","Base.AnglerSlugger","Base.AnglerSplinterGun","Base.AnglerTeleportGun","Base.AnglerTrident","Base.AnglerTunneller","Base.AnglerTunnellerHUD","Base.AnglerWrench","Base.BabyGatorWeap","Base.BatAssaultRifle","Base.BatBazooka","Base.BatBossWeap","Base.BatCrossbow","Base.BatDiscGun","Base.BatGrenadeLauncher","Base.BatLaserPistol","Base.BatMachinegun","Base.BatNukeLauncher","Base.BatPlasmaGun","Base.BatRevolver","Base.BatScrewdriver","Base.BatShotgun","Base.BatSlugger","Base.BatSplinterGun","Base.BatTeleportGun","Base.BatTrident","Base.BatTunneller","Base.BatTunnellerHUD","Base.BatWeap","Base.BatWrench","Base.Bone","Base.BoneShard","Base.BonusAssaultRifle","Base.BonusBazooka","Base.BonusCrossbow","Base.BonusDiscGun","Base.BonusGrenadeLauncher","Base.BonusLaserPistol","Base.BonusMachinegun","Base.BonusNukeLauncher","Base.BonusPlasmaGun","Base.BonusRevolver","Base.BonusScrewdriver","Base.BonusShotgun","Base.BonusSlugger","Base.BonusSplinterGun","Base.BonusTeleportGun","Base.BonusTrident","Base.BonusTunneller","Base.BonusTunnellerHUD","Base.BonusWrench","Base.CoatAssaultRifle","Base.CoatBazooka","Base.CoatCrossbow","Base.CoatDiscGun","Base.CoatGrenadeLauncher","Base.CoatLaserPistol","Base.CoatMachinegun","Base.CoatNukeLauncher","Base.CoatPlasmaGun","Base.CoatRevolver","Base.CoatScrewdriver","Base.CoatShotgun","Base.CoatSlugger","Base.CoatSplinterGun","Base.CoatTeleportGun","Base.CoatTrident","Base.CoatTunneller","Base.CoatTunnellerHUD","Base.CoatWrench","Base.CoolAssaultRifle","Base.CoolBazooka","Base.CoolCrossbow","Base.CoolDiscGun","Base.CoolFrogPistol","Base.CoolGrenadeLauncher","Base.CoolLaserPistol","Base.CoolMachinegun","Base.CoolNukeLauncher","Base.CoolPlasmaGun","Base.CoolRevolver","Base.CoolScrewdriver","Base.CoolShotgun","Base.CoolSlugger","Base.CoolSplinterGun","Base.CoolTeleportGun","Base.CoolTrident","Base.CoolTunneller","Base.CoolTunnellerHUD","Base.CoolWrench","Base.GoldTeleportGun","Base.GoldTeleportGunLoadout","Base.GoldTrident","Base.GoldTridentLoadout","Base.GoldTunneller","Base.GoldTunnellerLoadout","Base.Harpoon","Base.OrchidAssaultRifle","Base.OrchidBazooka","Base.OrchidCrossbow","Base.OrchidDiscGun","Base.OrchidFrogPistol","Base.OrchidFrogPistolRusty","Base.OrchidGrenadeLauncher","Base.OrchidLaserPistol","Base.OrchidMachinegun","Base.OrchidNukeLauncher","Base.OrchidPlasmaGun","Base.OrchidRevolver","Base.OrchidScrewdriver","Base.OrchidShotgun","Base.OrchidSlugger","Base.OrchidSplinterGun","Base.OrchidTeleportGun","Base.OrchidTrident","Base.OrchidTunneller","Base.OrchidTunnellerHUD","Base.OrchidWrench","Base.PelicanHammer","Base.QuestArtifact","Base.RedAssaultRifle","Base.RedBazooka","Base.RedCrossbow","Base.RedDiscGun","Base.RedGrenadeLauncher","Base.RedLaserPistol","Base.RedMachinegun","Base.RedNukeLauncher","Base.RedPlasmaGun","Base.RedRevolver","Base.RedScrewdriver","Base.RedShotgun","Base.RedSlugger","Base.RedSplinterGun","Base.RedTeleportGun","Base.RedTrident","Base.RedTunneller","Base.RedTunnellerHUD","Base.RedWrench","Base.TeleportGun","Base.TeleportGunLoadout","Base.Trident","Base.TridentLoadout","Base.Tunneller","Base.TunnellerHUD","Base.TunnellerLoadout","Base.UltraQuasarBlaster","Base.Weapon.annihilator.sprWep","Base.Weapon.annihilator.sprWepHUD","Base.Weapon.annihilator.sprWepLocked","Base.Weapon.bat disc cannon.sprWep","Base.Weapon.bat disc cannon.sprWepHoming","Base.Weapon.bat disc cannon.sprWepImage","Base.Weapon.bat disc cannon.sprWepLocked","Base.Weapon.bat disc launcher.sprWep","Base.Weapon.bat disc launcher.sprWepHoming","Base.Weapon.bat disc launcher.sprWepImage","Base.Weapon.bat disc launcher.sprWepLocked","Base.Weapon.bat tether.sprWep","Base.Weapon.bat tether.sprWepLocked","Base.Weapon.beetle pistol.sprWep","Base.Weapon.beetle pistol.sprWepLoadout","Base.Weapon.beetle pistol.sprWepLocked","Base.Weapon.bubble bat.sprWep","Base.Weapon.bubble bat.sprWepLocked","Base.Weapon.bubble cannon.sprWep","Base.Weapon.bubble cannon.sprWepLocked","Base.Weapon.bubble minigun.sprWep","Base.Weapon.bubble minigun.sprWepLocked","Base.Weapon.bubble rifle.sprWep","Base.Weapon.bubble rifle.sprWepLocked","Base.Weapon.bubble shotgun.sprWep","Base.Weapon.bubble shotgun.sprWepLocked","Base.Weapon.clam shield.sprWepHUD","Base.Weapon.clam shield.sprWepLocked","Base.Weapon.crabbone.sprWep","Base.Weapon.dematerializer.sprWep","Base.Weapon.dematerializer.sprWepLocked","Base.Weapon.electroplasma cannon.sprWep","Base.Weapon.electroplasma cannon.sprWepLocked","Base.Weapon.electroplasma rifle.sprWep","Base.Weapon.electroplasma rifle.sprWepLocked","Base.Weapon.electroplasma shotgun.sprWep","Base.Weapon.electroplasma shotgun.sprWepLocked","Base.Weapon.entangler.sprWep","Base.Weapon.entangler.sprWepHUD","Base.Weapon.entangler.sprWepLocked","Base.Weapon.harpoon launcher.sprWep","Base.Weapon.harpoon launcher.sprWepLocked","Base.Weapon.hyper bubbler.sprWep","Base.Weapon.hyper bubbler.sprWepLocked","Base.Weapon.lightring launcher.sprWep","Base.Weapon.lightring launcher.sprWepLocked","Base.Weapon.net launcher.sprWep","Base.Weapon.net launcher.sprWepLocked","Base.Weapon.pizza cutter.sprWep","Base.Weapon.pizza cutter.sprWepHUD","Base.Weapon.pizza cutter.sprWepHoming","Base.Weapon.pizza cutter.sprWepImage","Base.Weapon.pizza cutter.sprWepLocked","Base.Weapon.quasar blaster.sprWep","Base.Weapon.quasar blaster.sprWepLocked","Base.Weapon.quasar cannon.sprWep","Base.Weapon.quasar cannon.sprWepLocked","Base.Weapon.quasar rifle.sprWep","Base.Weapon.quasar rifle.sprWepLocked","Base.Weapon.rogue carbine.sprWep","Base.Weapon.scythe.sprShotbow","Base.Weapon.scythe.sprSlugbow","Base.Weapon.scythe.sprSlugbowHUD","Base.Weapon.scythe.sprWep","Base.Weapon.scythe.sprWepHUD","Base.Weapon.scythe.sprWepLocked","Base.Weapon.super lightring launcher.sprWep","Base.Weapon.super lightring launcher.sprWepLocked","Base.Weapon.super teleport gun.sprWep","Base.Weapon.teleport gun.sprWep","Base.Weapon.teleport gun.sprWepGold","Base.Weapon.teleport gun.sprWepGoldLoadout","Base.Weapon.teleport gun.sprWepLoadout","Base.Weapon.tesla coil.sprWep","Base.Weapon.tesla coil.sprWepLocked","Base.Weapon.trident.sprWep","Base.Weapon.trident.sprWepGold","Base.Weapon.trident.sprWepGoldLoadout","Base.Weapon.trident.sprWepLoadout","Base.Weapon.trident.sprWepLocked","Base.Weapon.tunneller.sprWep","Base.Weapon.tunneller.sprWepGold","Base.Weapon.tunneller.sprWepGoldLoadout","Base.Weapon.tunneller.sprWepHUD","Base.Weapon.tunneller.sprWepLoadout","Base.Weapon.tunneller.sprWepLocked","Base.Weapon.ultra quasar rifle.sprWep","Base.Weapon.ultra quasar rifle.sprWepLocked","BatAssaultRifle","BatBazooka","BatBolt","BatBossDead","BatBossHurt","BatBossIdle","BatBossWalk","BatBossWeap","BatBossYell","BatChest","BatChestBig","BatChestBigCursed","BatChestBigCursedOpen","BatChestBigOpen","BatChestCursed","BatChestCursedOpen","BatChestOpen","BatCrossbow","BatDead","BatDisc","BatDiscBig","BatDiscGun","BatDisk","BatGrenade","BatGrenadeLauncher","BatHurt","BatIdle","BatLaserPistol","BatLightning","BatLightningHit","BatMachinegun","BatNuke","BatNukeLauncher","BatPlasmaGun","BatRevolver","BatRocket","BatScreech","BatScrewdriver","BatShotgun","BatSlugger","BatSplinterGun","BatTeleportGun","BatTrident","BatTunneller","BatTunnellerHUD","BatWalk","BatWeap","BatWrench","BatYell","BigBloomingCactusDead","BigBloomingCactusHurt","BigBloomingCactusIdle","BigBubble","BigBubblePop","BigCactusDead","BigCactusHurt","BigCactusIdle","BigCrystalPropDead","BigCrystalPropHurt","BigCrystalPropIdle","BigDiscTrail","BigFishBecomeHurt","BigFishBecomeIdle","BigFishLeap","BigFishRise","BigFishSpwn","BigFishSwim","BigFishSwimBack","BigFishSwimFrnt","BigMaggotSpawnChrg","BigMaggotSpawnDead","BigMaggotSpawnHurt","BigMaggotSpawnIdle","BigManhole","BigManholeDebris","BigManholeDebrisChunk","BigManholeFloor","BigManholeOpen","BigNightCactusDead","BigNightCactusHurt","BigNightCactusIdle","BigPipeBottom","BigPipeBottomHurt","BigPipeDead","BigPipeHole","BigPipeTop","BigPipeTopHurt","BigRadUpg","BigTopDecal.area_caves","BigTopDecal.area_cursed_caves","BigTopDecal.area_desert","BigTopDecal.area_oasis","BigTopDecal.area_palace","BigTopDecal.area_pizza_sewers","BigTopDecal.area_scrapyards","BigTopDecal.area_sewers","BigTopDecal.trench","BigTopDecalScorpion","BigTopDecalScorpionDebris","BloomingAssassinDead","BloomingAssassinHide","BloomingAssassinHurt","BloomingAssassinIdle","BloomingAssassinWalk","BloomingBushDead","BloomingBushHurt","BloomingBushIdle","BloomingCactusDead","BloomingCactusHurt","BloomingCactusIdle","Bone","BoneArrow","BoneArrowHeavy","BoneGatorDead","BoneGatorHeal","BoneGatorHurt","BoneGatorIdle","BoneGatorWalk","BoneGatorWeap","BonePickup","BonePickupBig","BoneRavenDead","BoneRavenFly","BoneRavenHurt","BoneRavenIdle","BoneRavenLand","BoneRavenLift","BoneRavenWalk","BoneShard","BoneSlashHeavy","BoneSlashLight","BonusAmmoChest","BonusAmmoChestOpen","BonusAmmoChestSteroids","BonusAmmoChestSteroidsOpen","BonusAmmoHUD","BonusAmmoHUDFill","BonusAmmoHUDFillDrain","BonusAmmoMimicDead","BonusAmmoMimicFire","BonusAmmoMimicHurt","BonusAmmoMimicIdle","BonusAmmoMimicTell","BonusAmmoPickup","BonusAssaultRifle","BonusBazooka","BonusBolt","BonusCrossbow","BonusDisc","BonusDiscGun","BonusFX","BonusFXChestOpen","BonusFXPickupFade","BonusFXPickupOpen","BonusGrenade","BonusGrenadeLauncher","BonusHUDText","BonusHealBigFX","BonusHealFX","BonusHealthChest","BonusHealthChestOpen","BonusHealthHUDFill","BonusHealthHUDFillDrain","BonusHealthMimicDead","BonusHealthMimicFire","BonusHealthMimicHurt","BonusHealthMimicIdle","BonusHealthMimicTell","BonusHealthPickup","BonusLaserPistol","BonusMachinegun","BonusNuke","BonusNukeLauncher","BonusPlasmaGun","BonusRevolver","BonusRocket","BonusScrewdriver","BonusShell","BonusShellHeavy","BonusShotgun","BonusSlugger","BonusSplinterGun","BonusTeleportGun","BonusText","BonusTrident","BonusTunneller","BonusTunnellerHUD","BonusWrench","BossHealFX","BubbleBomb","BubbleBombBig","BubbleBombEnemy","BubbleCharge","BubbleExplosion","BubbleExplosionSmall","BubbleSlash","BuriedCarHurt","BuriedCarIdle","BuriedVaultChest","BuriedVaultChestBase","BuriedVaultChestDebris","BuriedVaultChestOpen","ButtonChest","ButtonChestDebris","ButtonDead","ButtonDebris","ButtonHurt","ButtonIdle","ButtonPickup","ButtonPickupDebris","ButtonPressedHurt","ButtonPressedIdle","ButtonRevive","ButtonReviveArea","CabinetDead","CabinetHurt","CabinetIdle","CatBossChrg","CatBossDead","CatBossFire","CatBossHurt","CatBossIdle","CatBossWalk","CatBossWeap","CatBossWeapChrg","CatChest","CatChestOpen","CatDead","CatDoor","CatDoorDebris","CatHurt","CatIdle","CatLight","CatLightBig","CatLightThin","CatSit1","CatSit2","CatSnowDead","CatSnowHurt","CatSnowIdle","CatSnowSit1","CatSnowSit2","CatSnowWalk","CatWalk","CatWeap","CaveHole","CaveHoleCursed","ChairFrontDead","ChairFrontHurt","ChairFrontIdle","ChairSideDead","ChairSideHurt","ChairSideIdle","ChaosHeartDead","ChaosHeartHurt","ChaosHeartIdle","ClamShield","ClamShieldSlash","ClamShieldWep","ClockParts","CoastTrans","CoatAssaultRifle","CoatBazooka","CoatBolt","CoatCrossbow","CoatDisc","CoatDiscGun","CoatGrenade","CoatGrenadeLauncher","CoatLaserPistol","CoatMachinegun","CoatNuke","CoatNukeLauncher","CoatPlasmaGun","CoatRevolver","CoatRocket","CoatScrewdriver","CoatShotgun","CoatSlugger","CoatSplinterGun","CoatTeleportGun","CoatTrident","CoatTunneller","CoatTunnellerHUD","CoatWrench","CoolAssaultRifle","CoolBazooka","CoolBolt","CoolCrossbow","CoolDisc","CoolDiscGun","CoolFrogPistol","CoolGrenade","CoolGrenadeLauncher","CoolLaserPistol","CoolMachinegun","CoolNuke","CoolNukeLauncher","CoolPlasmaGun","CoolRevolver","CoolRocket","CoolScrewdriver","CoolShotgun","CoolSlugger","CoolSplinterGun","CoolTeleportGun","CoolTrident","CoolTunneller","CoolTunnellerHUD","CoolWrench","CouchDead","CouchHurt","CouchIdle","CowSkullDead","CowSkullHurt","CowSkullIdle","CrabDead","CrabFire","CrabHide","CrabHurt","CrabIdle","CrabWalk","Crack","CreatureBott","CreatureFoam","CreatureHurt","CreatureIdle","CrimeBountyAlert","CrimeBountyFillAlert","Crown.Bonus.Icon","Crown.Bonus.Idle","Crown.Bonus.Loadout","Crown.Bonus.Walk","Crown.Crime.Icon","Crown.Crime.Idle","Crown.Crime.Loadout","Crown.Crime.Walk","Crown.Red.Icon","Crown.Red.Idle","Crown.Red.Loadout","Crown.Red.Walk","CrownRandomLoadout","CrystalBatDash","CrystalBatDead","CrystalBatHurt","CrystalBatIdle","CrystalBatTell","CrystalBrainAppear","CrystalBrainChunk","CrystalBrainDead","CrystalBrainDisappear","CrystalBrainEffect","CrystalBrainEffectAlly","CrystalBrainEffectPopo","CrystalBrainHurt","CrystalBrainIdle","CrystalBrainPart","CrystalBrainSurfMask","CrystalCloneOverlay","CrystalCloneOverlayAlly","CrystalCloneOverlayCorpse","CrystalCloneOverlayPopo","CrystalHeartBullet","CrystalHeartBulletBig","CrystalHeartBulletBigRed","CrystalHeartBulletBigRing","CrystalHeartBulletBigTrail","CrystalHeartBulletHit","CrystalHeartBulletRing","CrystalHeartBulletTrail","CrystalHeartDead","CrystalHeartHurt","CrystalHeartIdle","CrystalPropRedDead","CrystalPropRedHurt","CrystalPropRedIdle","CrystalPropWhiteDead","CrystalPropWhiteHurt","CrystalPropWhiteIdle","CrystalRedDead","CrystalRedGoSit","CrystalRedHurt","CrystalRedIdle","CrystalRedLoadout","CrystalRedMapIcon","CrystalRedPortrait","CrystalRedShield","CrystalRedShieldDisappear","CrystalRedShieldIdleBack","CrystalRedShieldIdleFront","CrystalRedShieldWalkBack","CrystalRedShieldWalkFront","CrystalRedSit","CrystalRedTrail","CrystalRedWalk","CrystalWhiteTrail","CursedAmmoChest","CursedAmmoChestOpen","CursedAmmoChestSteroids","CursedAmmoChestSteroidsOpen","CursedMimicDead","CursedMimicFire","CursedMimicHurt","CursedMimicIdle","CursedMimicTell","DebrisLair","DebrisRed","DebrisTrench","DetailCoast","DetailLair","DetailRed","DetailTrench","DiverDead","DiverHurt","DiverIdle","DiverWalk","EelDead","EelHurt","EelIdle","EelSkullDead","EelSkullHurt","EelSkullIdle","EelTell","EeliteDead","EeliteHurt","EeliteIdle","ElectroPlasma","ElectroPlasmaBig","ElectroPlasmaImpact","ElectroPlasmaTether","ElectroPlasmaTrail","EnemyBullet","EnemyEnergyBatSlash","EnemyHeavyBullet","EnemyHeavyBulletHit","EnemyHeavySlug","EnemyHeavySlugDisappear","EnemyHeavySlugHit","EnemyPlasmaBall","EnemyPlasmaBig","EnemyPlasmaHuge","EnemyPlasmaImpact","EnemyPlasmaImpactSmall","EnemyPlasmaTrail","EnemySlug","EnemySlugDisappear","EnemySlugHit","EnemySuperFlak","EnemySuperFlakHit","EnemyVlasmaBullet","EnemyVlasmaCannon","EnergyBatSlash","EyesBatDead","EyesBatGoSit","EyesBatHurt","EyesBatIdle","EyesBatLoadout","EyesBatMapIcon","EyesBatPortrait","EyesBatSit","EyesBatWalk","FirePitScorch","FishAnglerDead","FishAnglerGoSit","FishAnglerHurt","FishAnglerIdle","FishAnglerLoadout","FishAnglerMapIcon","FishAnglerPortrait","FishAnglerSit","FishAnglerTrail","FishAnglerWalk","FishFreakDead","FishFreakHurt","FishFreakIdle","FishFreakWalk","FlameSpark","Floor106Small","FloorCoast","FloorCoastB","FloorCrate","FloorLair","FloorLairB","FloorLairExplo","FloorMiddleSmall","FloorPalaceShrine","FloorPalaceShrineRoomLarge","FloorPalaceShrineRoomSmall","FloorPalaceStairs","FloorPalaceStairsCarpet","FloorRed","FloorRedB","FloorRedExplo","FloorRedRoom","FloorScorpion","FloorSeal","FloorSealRoom","FloorSealRoomBig","FloorSewerDirt","FloorSewerDrain","FloorSewerGrate","FloorSewerLightDirt","FloorSewerWeb","FloorTrench","FloorTrenchB","FloorTrenchBreak","FloorTrenchExplo","FlyAlert","FlySpin","FreakChamberAlarm","FrogCoolDead","FrogCoolGoSit","FrogCoolHurt","FrogCoolIdle","FrogCoolLoadout","FrogCoolMapIcon","FrogCoolPortrait","FrogCoolSit","FrogCoolWalk","GatorAlbinoAlert","GatorAlert","GatorPatchAlert","GatorStatueDead","GatorStatueHurt","GatorStatueIdle","GhostAppear","GhostDisappear","GhostHaloAppear","GhostHaloDisappear","GhostIdle","GhostStatueDead","GhostStatueDebris","GhostStatueHurt","GhostStatueIdle","GoldTeleportGun","GoldTeleportGunLoadout","GoldTrident","GoldTridentLoadout","GoldTunneller","GoldTunnellerLoadout","GroundFlameGreen","GroundFlameGreenBig","GroundFlameGreenBigDisappear","GroundFlameGreenDisappear","GroundSlash","GullDead","GullHurt","GullIdle","GullSword","GullWalk","HammerHeadChest","HammerHeadChestEffect","HammerHeadChestEffectSpawn","HammerHeadChestOpen","HammerHeadPickup","HammerHeadPickupEffect","HammerHeadPickupEffectSpawn","HammerSharkChrg","HammerSharkDead","HammerSharkHurt","HammerSharkIdle","Harpoon","HarpoonFade","HarpoonGun","HarpoonOpen","HugeCursedChest","HugeCursedChestOpen","HugeQuestChest","HugeQuestChestOpen","HugeWeaponChest","HugeWeaponChestOpen","IDPDHeavyBullet","IDPDHeavyBulletHit","IDPDHorrorBullet","IglooFrontDead","IglooFrontHurt","IglooFrontIdle","IglooSideDead","IglooSideHurt","IglooSideIdle","Intro.BigFish.Back","Intro.BigFish.Main","Intro.BigFish.Name","Intro.CatBat.Back","Intro.CatBat.Main","Intro.CatBat.Name","Intro.Palanking.Back","Intro.Palanking.Main","Intro.Palanking.Name","Intro.PetWeapon.Back","Intro.PetWeapon.Main","Intro.PetWeapon.Name","Intro.PetWeaponCursed.Back","Intro.PetWeaponCursed.Main","Intro.PetWeaponCursed.Name","Intro.PitSquid.Back","Intro.PitSquid.Main","Intro.PitSquid.Name","Intro.Tesseract.Back","Intro.Tesseract.Main","Intro.Tesseract.Name","InvBigCrystalPropDead","InvBigCrystalPropHurt","InvBigCrystalPropIdle","InvCrystalBatDash","InvCrystalBatDead","InvCrystalBatHurt","InvCrystalBatIdle","InvCrystalBatTell","InvMortarDead","InvMortarFire","InvMortarHurt","InvMortarIdle","InvMortarWalk","InvSpiderlingDead","InvSpiderlingHatch","InvSpiderlingHurt","InvSpiderlingIdle","InvSpiderlingWalk","JellyDead","JellyEliteFire","JellyFire","JellyHurt","JellyIdle","KelpDead","KelpHurt","KelpIdle","KingCrabIdle","LairTurretAppear","LairTurretDead","LairTurretFire","LairTurretHurt","LairTurretIdle","Manhole","ManholeOpen","MenuNTTE","MinerBanditDead","MinerBanditHurt","MinerBanditIdle","MinerBanditWalk","MortarDead","MortarFire","MortarHurt","MortarIdle","MortarPlasma","MortarWalk","MutantVatBack","MutantVatDead","MutantVatGlass","MutantVatHurt","MutantVatIdle","MutantVatLid","NestDebris","NetNade","NetNadeBlink","NothingDeathCause","OptionNTTE","OrchidAssaultRifle","OrchidBazooka","OrchidBolt","OrchidChest","OrchidChestOpen","OrchidChestWilted","OrchidCrossbow","OrchidDisc","OrchidDiscGun","OrchidFrogPistol","OrchidFrogPistolRusty","OrchidGrenade","OrchidGrenadeLauncher","OrchidLaserPistol","OrchidMachinegun","OrchidNuke","OrchidNukeLauncher","OrchidPlasmaGun","OrchidRevolver","OrchidRocket","OrchidScrewdriver","OrchidShotgun","OrchidSlugger","OrchidSplinterGun","OrchidTeleportGun","OrchidTrident","OrchidTunneller","OrchidTunnellerHUD","OrchidWrench","PStatTrenchHurt","PStatTrenchIdle","PStatTrenchLights","PalaceAltarDead","PalaceAltarDebris","PalaceAltarHurt","PalaceAltarIdle","PalankingBott","PalankingBurp","PalankingCall","PalankingChunk","PalankingDead","PalankingFire","PalankingFoam","PalankingHurt","PalankingIdle","PalankingSlash","PalankingStatueChunk","PalankingStatueDead","PalankingStatueHurt","PalankingStatueIdle","PalankingTaunt","PalankingWalk","PalmDead","PalmFortHurt","PalmFortIdle","PalmHurt","PalmIdle","Paper","PatchGatorDead","PatchGatorHurt","PatchGatorIdle","PatchGatorWalk","PelicanChrg","PelicanDead","PelicanHammer","PelicanHurt","PelicanIdle","PelicanWalk","PetArrow","PetCoolGuyHurt","PetCoolGuyIcon","PetCoolGuyIdle","PetCoolGuyWalk","PetCuzIcon","PetGuardianAppear","PetGuardianDash","PetGuardianDashCharge","PetGuardianDashEnd","PetGuardianDashStart","PetGuardianDisappear","PetGuardianHurt","PetGuardianIcon","PetGuardianIdle","PetGuardianShield","PetGuardianShieldDisappear","PetLost","PetMimicHide","PetMimicHurt","PetMimicIcon","PetMimicIdle","PetMimicOpen","PetMimicWalk","PetOctoHide","PetOctoHideIcon","PetOctoHurt","PetOctoIcon","PetOctoIdle","PetOrchidBall","PetOrchidHurt","PetOrchidIcon","PetOrchidIdle","PetOrchidWalk","PetParrotBHurt","PetParrotBIcon","PetParrotBIdle","PetParrotBWalk","PetParrotHurt","PetParrotIcon","PetParrotIdle","PetParrotNote","PetParrotWalk","PetPeasHurt","PetPeasIcon","PetPeasIdle","PetPeasWalk","PetPrismIcon","PetPrismIdle","PetSalamanderChrg","PetSalamanderHurt","PetSalamanderIcon","PetSalamanderIdle","PetSalamanderWalk","PetScorpionDead","PetScorpionFire","PetScorpionHurt","PetScorpionIcon","PetScorpionIdle","PetScorpionShield","PetScorpionWalk","PetSlaughterBite","PetSlaughterDead","PetSlaughterHurt","PetSlaughterIcon","PetSlaughterIdle","PetSlaughterSpwn","PetSlaughterWalk","PetSparkle","PetSpiderCursedHurt","PetSpiderCursedIcon","PetSpiderCursedIdle","PetSpiderCursedKill","PetSpiderCursedWalk","PetSpiderHurt","PetSpiderIcon","PetSpiderIdle","PetSpiderWalk","PetSpiderWeb","PetSpiderWebBits","PetTwinsIcon","PetTwinsRed","PetTwinsRedEffect","PetTwinsRedIcon","PetTwinsStat","PetTwinsWhite","PetTwinsWhiteEffect","PetTwinsWhiteIcon","PetWeaponChst","PetWeaponCursedChst","PetWeaponCursedDead","PetWeaponCursedHide","PetWeaponCursedHurt","PetWeaponCursedIcon","PetWeaponCursedIdle","PetWeaponCursedSpwn","PetWeaponCursedWalk","PetWeaponDead","PetWeaponHide","PetWeaponHurt","PetWeaponIcon","PetWeaponIdle","PetWeaponSpwn","PetWeaponStat","PetWeaponWalk","PickupRevive","PickupReviveArea","Pit","PitBot","PitSmall","PitSmallBot","PitSmallTop","PitSpark","PitSquidCornea","PitSquidEyelid","PitSquidMawBite","PitSquidMawSpit","PitSquidPupil","PitTop","PizzaDoor","PizzaDoorDebris","PizzaDrainDead","PizzaDrainHurt","PizzaDrainIdle","PizzaManhole","PizzaRubbleHurt","PizzaRubbleIdle","PlantOrchidDead","PlantOrchidGoSit","PlantOrchidHurt","PlantOrchidIdle","PlantOrchidLoadout","PlantOrchidMapIcon","PlantOrchidPortrait","PlantOrchidSit","PlantOrchidTangle","PlantOrchidTangleSeed","PlantOrchidWalk","PlasmaImpactSmall","PopoAlert","PopoEliteAlert","PopoEnergyBatSlash","PopoFreakAlert","PopoLaser","PopoLaserEnd","PopoLaserStart","PopoPlasmaImpactSmall","PopoSecurityCannon","PopoSecurityDead","PopoSecurityHurt","PopoSecurityIdle","PopoSecurityMinigun","PopoSecurityWalk","PopoVlasmaBullet","PopoVlasmaCannon","PortalBullet","PortalBulletHit","PortalBulletLightning","PortalBulletSpawn","PortalGuardianAppear","PortalGuardianDead","PortalGuardianDisappear","PortalGuardianHurt","PortalGuardianIdle","PortalGuardianImplode","ProtoChestFire","ProtoChestMerge","PufferChrg","PufferDead","PufferFire","PufferHurt","PufferIdle","PurpleEnergyBatSlash","QuasarBeam","QuasarBeamEnd","QuasarBeamHit","QuasarBeamStart","QuasarBeamTrail","QuestArtifact","QuestArtifactMerge","QuestArtifactSubMerge0","QuestArtifactSubMerge1","QuestChest","QuestChestOpen","QuestFloor","QuestPillar1Dead","QuestPillar1Hurt","QuestPillar1Idle","QuestPillar2Dead","QuestPillar2Hurt","QuestPillar2Idle","QuestSparkle","QuestTeleporterFloor","QuestTeleporterPad","QuestTeleporterSparkle","QuestTorchDead","QuestTorchHurt","QuestTorchIdle","Race.beetle.0.Dead","Race.beetle.0.GoSit","Race.beetle.0.Hurt","Race.beetle.0.Idle","Race.beetle.0.Loadout","Race.beetle.0.Map","Race.beetle.0.Menu","Race.beetle.0.MenuDeselect","Race.beetle.0.MenuSelect","Race.beetle.0.MenuSelected","Race.beetle.0.Portrait","Race.beetle.0.Select","Race.beetle.0.Sit","Race.beetle.0.ThroneButtIcon","Race.beetle.0.UltraHUDA","Race.beetle.0.UltraHUDB","Race.beetle.0.UltraIcon","Race.beetle.0.Walk","Race.beetle.1.Dead","Race.beetle.1.GoSit","Race.beetle.1.Hurt","Race.beetle.1.Idle","Race.beetle.1.Loadout","Race.beetle.1.Map","Race.beetle.1.Menu","Race.beetle.1.MenuDeselect","Race.beetle.1.MenuSelect","Race.beetle.1.MenuSelected","Race.beetle.1.Portrait","Race.beetle.1.Select","Race.beetle.1.Sit","Race.beetle.1.ThroneButtIcon","Race.beetle.1.UltraHUDA","Race.beetle.1.UltraHUDB","Race.beetle.1.UltraIcon","Race.beetle.1.Walk","Race.parrot.0.Dead","Race.parrot.0.Feather","Race.parrot.0.FeatherHUD","Race.parrot.0.GoSit","Race.parrot.0.Hurt","Race.parrot.0.Idle","Race.parrot.0.Loadout","Race.parrot.0.Map","Race.parrot.0.Menu","Race.parrot.0.MenuDeselect","Race.parrot.0.MenuSelect","Race.parrot.0.MenuSelected","Race.parrot.0.Portrait","Race.parrot.0.Select","Race.parrot.0.Sit","Race.parrot.0.UltraHUDA","Race.parrot.0.UltraHUDB","Race.parrot.0.UltraIcon","Race.parrot.0.Walk","Race.parrot.1.Dead","Race.parrot.1.Feather","Race.parrot.1.FeatherHUD","Race.parrot.1.GoSit","Race.parrot.1.Hurt","Race.parrot.1.Idle","Race.parrot.1.Loadout","Race.parrot.1.Map","Race.parrot.1.Menu","Race.parrot.1.MenuDeselect","Race.parrot.1.MenuSelect","Race.parrot.1.MenuSelected","Race.parrot.1.Portrait","Race.parrot.1.Select","Race.parrot.1.Sit","Race.parrot.1.UltraHUDA","Race.parrot.1.UltraHUDB","Race.parrot.1.UltraIcon","Race.parrot.1.Walk","RadSkillBall","RadSkillTrail","RadUpg","RatChest","RatChestOpen","RedAmmoChest","RedAmmoChestOpen","RedAmmoHUD","RedAmmoHUDAmmo","RedAmmoHUDCost","RedAmmoHUDCostGold","RedAmmoHUDFill","RedAmmoHUDGold","RedAmmoPickup","RedAssaultRifle","RedBazooka","RedBolt","RedBullet","RedBulletDisappear","RedChest","RedChestOpen","RedCrossbow","RedDisc","RedDiscGun","RedDot","RedExplosion","RedGrenade","RedGrenadeLauncher","RedHeavySlash","RedLaserPistol","RedMachinegun","RedMegaSlash","RedNuke","RedNukeLauncher","RedPlasmaGun","RedRevolver","RedRocket","RedScrewdriver","RedShank","RedShankGold","RedShotgun","RedSkillBall","RedSkillBallTether","RedSlash","RedSlugger","RedSpiderDead","RedSpiderHurt","RedSpiderIdle","RedSpiderWalk","RedSplinterGun","RedTeleportGun","RedText","RedTrident","RedTunneller","RedTunnellerHUD","RedWrench","RobotBonusDead","RobotBonusGoSit","RobotBonusHurt","RobotBonusIdle","RobotBonusLoadout","RobotBonusMapIcon","RobotBonusPortrait","RobotBonusSit","RobotBonusWalk","RockBott","RockDead","RockFoam","RockHurt","RockIdle","RogueBackpack","RogueBackpackOpen","RouteIcon","Rug","SawTrap","SawTrapDebris","SawTrapHurt","ScorpionRock","ScorpionRockAlly","ScorpionRockAllyHurt","ScorpionRockDead","ScorpionRockHurt","SealAlert","SealAnchor","SealArcticAlert","SealChain","SealDead","SealDisc","SealHeavyDead","SealHeavyHurt","SealHeavyIdle","SealHeavySpwn","SealHeavyTell","SealHeavyWalk","SealHurt","SealIdle","SealMine","SealMineHurt","SealSpwn","SealWalk","SealWeap","SewerDrainDead","SewerDrainHurt","SewerDrainIdle","SewerPool","SewerPoolBig","ShellBott","ShellDead","ShellFoam","ShellHurt","ShellIdle","Shine10","Shine12","Shine16","Shine20","Shine24","Shine64","Shine8","ShineHurt","ShineSnow","SilverScorpionDead","SilverScorpionFire","SilverScorpionFlak","SilverScorpionHurt","SilverScorpionIdle","SilverScorpionWalk","SkealAlert","SkealDead","SkealHurt","SkealIdle","SkealSpwn","SkealWalk","Skill.Annihilation.HUD","Skill.BatEars.HUD","Skill.Compassion.HUD","Skill.Compassion.Icon","Skill.LeadRibs.HUD","Skill.MagneticPulse.HUD","Skill.Reroll.HUD","Skill.SilverTongue.HUD","Skill.SilverTongue.Icon","Skill.ToadBreath.HUD","SkillRerollHUDSmall","SlaughterBite","SlaughterPropDead","SlaughterPropHurt","SlaughterPropIdle","SludgePool","SludgePoolAlert","SmallGreenExplosion","SmallLastBall","SnowFloorScorpion","SnowFloorSeal","SnowFloorSealRoom","SnowFloorSealRoomBig","SodaMachineDead","SodaMachineHurt","SodaMachineIdle","SparkleBullet","SpiderlingDead","SpiderlingHatch","SpiderlingHurt","SpiderlingIdle","SpiderlingWalk","SpiralDebrisNothing","SpiralStarfield","SpiritChest","SpiritChestOpen","SpiritPickup","SquidBloodStreak","SquidCharge","Starfield","SunkenChest","SunkenChestOpen","SunkenCoin","SunkenCoinBig","TVHurt","TableDead","TableHurt","TableIdle","TeleportGun","TeleportGunLoadout","TentacleDead","TentacleHurt","TentacleIdle","TentacleSpwn","TentacleTele","TentacleWheel","TesseractDeathCause","TesseractDeathCauseText","TesseractDeathLayer","TesseractFire","TesseractHurt","TesseractIdle","TesseractLayer","TesseractStrike","TesseractTell","TesseractWeapon","TopDecalLair","TopDecalScrapyardAlt","TopDecalTrench","TopDecalTrenchMine","TopTiny.sprWall100Trans","TopTiny.sprWall7Trans","TrapSpin","TrenchMineDead","Trident","TridentLoadout","Tunneller","TunnellerHUD","TunnellerHUDRed","TunnellerLoadout","UltraQuasarBeam","UltraQuasarBeamEnd","UltraQuasarBeamFlame","UltraQuasarBeamHit","UltraQuasarBeamStart","UltraQuasarBeamTrail","UltraQuasarBlaster","UltraQuasarBlasterEat","UnlockIcon.coast","UnlockIcon.crown","UnlockIcon.lair","UnlockIcon.oasis","UnlockIcon.red","UnlockIcon.trench","VanAlert","VaultFlowerDead","VaultFlowerDebris","VaultFlowerFloor","VaultFlowerFloorSmall","VaultFlowerHurt","VaultFlowerIdle","VaultFlowerSparkle","VaultFlowerWiltedDead","VaultFlowerWiltedDebris","VaultFlowerWiltedHurt","VaultFlowerWiltedIdle","VenomFlak","VenomPellet","VenomPelletAppear","VenomPelletBack","VenomPelletBackDisappear","VenomPelletDisappear","VentDead","VentHurt","VentIdle","VlasmaBullet","VlasmaCannon","Wall1BotRubble","Wall1OutRubble","Wall1TopRubble","Wall6BotTrans","WallBandit","WallCrateBot","WallCrateOut","WallCrateTop","WallDecalLair","WallDecalRed","WallFakeBot","WallFakeOut","WallFakeTop","WallLairBot","WallLairOut","WallLairTop","WallLairTrans","WallRedBot","WallRedFake","WallRedOut","WallRedTop","WallRedTrans","WallSpider","WallSpiderBot","WallSpiderling","WallSpiderlingTrans","WallTrenchBot","WallTrenchOut","WallTrenchTop","WallTrenchTrans","WantEel","Warp","WarpOpen","WarpOpenOut","WaterGradient","WaterStreak","Weapon.annihilator.sprWep","Weapon.annihilator.sprWepHUD","Weapon.annihilator.sprWepHUDRed","Weapon.annihilator.sprWepLocked","Weapon.bat disc cannon.sprWep","Weapon.bat disc cannon.sprWepHoming","Weapon.bat disc cannon.sprWepImage","Weapon.bat disc cannon.sprWepLocked","Weapon.bat disc cannon.sprWepStrip","Weapon.bat disc launcher.sprWep","Weapon.bat disc launcher.sprWepHoming","Weapon.bat disc launcher.sprWepImage","Weapon.bat disc launcher.sprWepLocked","Weapon.bat disc launcher.sprWepStrip","Weapon.bat tether.sprWep","Weapon.bat tether.sprWepLocked","Weapon.beetle pistol.sprWep","Weapon.beetle pistol.sprWepLoadout","Weapon.beetle pistol.sprWepLocked","Weapon.bubble bat.sprWep","Weapon.bubble bat.sprWepLocked","Weapon.bubble cannon.sprWep","Weapon.bubble cannon.sprWepLocked","Weapon.bubble minigun.sprWep","Weapon.bubble minigun.sprWepLocked","Weapon.bubble rifle.sprWep","Weapon.bubble rifle.sprWepLocked","Weapon.bubble shotgun.sprWep","Weapon.bubble shotgun.sprWepLocked","Weapon.clam shield.sprWep","Weapon.clam shield.sprWepHUD","Weapon.clam shield.sprWepLocked","Weapon.crabbone.sprWep","Weapon.dematerializer.sprWep","Weapon.dematerializer.sprWepLocked","Weapon.electroplasma cannon.sprWep","Weapon.electroplasma cannon.sprWepLocked","Weapon.electroplasma rifle.sprWep","Weapon.electroplasma rifle.sprWepLocked","Weapon.electroplasma shotgun.sprWep","Weapon.electroplasma shotgun.sprWepLocked","Weapon.energy bat.sprWep","Weapon.entangler.sprWep","Weapon.entangler.sprWepHUD","Weapon.entangler.sprWepHUDRed","Weapon.entangler.sprWepLocked","Weapon.harpoon launcher.sprWep","Weapon.harpoon launcher.sprWepLocked","Weapon.hyper bubbler.sprWep","Weapon.hyper bubbler.sprWepLocked","Weapon.lightring launcher.sprWep","Weapon.lightring launcher.sprWepLocked","Weapon.net launcher.sprWep","Weapon.net launcher.sprWepLocked","Weapon.pizza cutter.sprWep","Weapon.pizza cutter.sprWepHUD","Weapon.pizza cutter.sprWepHoming","Weapon.pizza cutter.sprWepImage","Weapon.pizza cutter.sprWepLocked","Weapon.pizza cutter.sprWepStrip","Weapon.quasar blaster.sprWep","Weapon.quasar blaster.sprWepLocked","Weapon.quasar cannon.sprWep","Weapon.quasar cannon.sprWepLocked","Weapon.quasar rifle.sprWep","Weapon.quasar rifle.sprWepLocked","Weapon.rogue carbine.sprWep","Weapon.scythe.sprShotbow","Weapon.scythe.sprSlugbow","Weapon.scythe.sprSlugbowHUD","Weapon.scythe.sprWep","Weapon.scythe.sprWepHUD","Weapon.scythe.sprWepLocked","Weapon.super lightring launcher.sprWep","Weapon.super lightring launcher.sprWepLocked","Weapon.super teleport gun.sprWep","Weapon.teleport gun.sprWep","Weapon.teleport gun.sprWepGold","Weapon.teleport gun.sprWepGoldLoadout","Weapon.teleport gun.sprWepLoadout","Weapon.tesla coil.sprWep","Weapon.tesla coil.sprWepLocked","Weapon.trident.sprWep","Weapon.trident.sprWepGold","Weapon.trident.sprWepGoldLoadout","Weapon.trident.sprWepLoadout","Weapon.trident.sprWepLocked","Weapon.tunneller.sprWep","Weapon.tunneller.sprWepGold","Weapon.tunneller.sprWepGoldLoadout","Weapon.tunneller.sprWepHUD","Weapon.tunneller.sprWepHUDRed","Weapon.tunneller.sprWepLoadout","Weapon.tunneller.sprWepLocked","Weapon.ultra quasar rifle.sprWep","Weapon.ultra quasar rifle.sprWepLocked","Weapon.venom rifle.sprWep","WhiteAmmoTypeIcon","WhiteReloadIcon","YVCoat","YVCoatDead","YVCoatGoSit","YVCoatHurt","YVCoatIdle","YVCoatLoadout","YVCoatMapIcon","YVCoatPortrait","YVCoatSit","YVCoatWalk","YetiCrabIdle","msk.AnglerHidden","msk.BatScreech","msk.BigPipe","msk.BigTopDecal.area_caves","msk.BigTopDecal.area_desert","msk.BigTopDecal.area_palace","msk.BigTopDecal.trench","msk.BoneSlashHeavy","msk.BoneSlashLight","msk.CatDoor","msk.CaveHole","msk.ClamShieldSlash","msk.FloorMiddleSmall","msk.NothingInactiveCool","msk.Palanking","msk.PizzaRubble","msk.PlasmaImpactSmall","msk.QuasarBeam","msk.SewerDrain","msk.SewerPool","msk.SewerPoolBig","msk.SludgePool","msk.SludgePoolSmall","msk.Trident","msk.UltraQuasarBeam","shd.BanditTent","shd.BigGenerator","shd.BigGeneratorR","shd.EyesMenu","shd.Nothing","shd.ParrotMenu","shd.VenuzTV"];
}

function scrFRNTTESoundKeys() {
    return ["BeetleChst","BeetleCnfm","BeetleCrwn","BeetleDead","BeetleHurt","BeetleIDPD","BeetleLowA","BeetleLowH","BeetleSlct","BeetleSpch","BeetleUltraA","BeetleUltraB","BeetleWrld","BigBatDead","BigBatHurt","BigBatIntro","BigBatScreech","BigBatTaunt","BigCatCharge","BigCatDead","BigCatHurt","BigCatIntro","BigCatTaunt","BigShotsTaunt","PalankingCall","PalankingDead","PalankingHurt","PalankingSwipe","PalankingTaunt","ParrotChst","ParrotCnfm","ParrotCrwn","ParrotDead","ParrotHurt","ParrotIDPD","ParrotLowA","ParrotLowH","ParrotSlct","ParrotSpch","ParrotUltraA","ParrotUltraB","ParrotWrld","SawTrap","mus.BigShots","mus.BigShotsIntro","mus.Coast","mus.CoastB","mus.Lair","mus.PitSquid","mus.PitSquidIntro","mus.PitSquidIntroLoop","mus.PitSquidIntroStart","mus.Red","mus.SealKing","mus.Tesseract","mus.TesseractIntro","mus.Trench","mus.TrenchB"];
}

function scrFRNTTEUGSpriteRows() {
    return [["sprBigDecalUndergrowth",sprUGBigDecalUndergrowth],
        ["sprBugBones1Dead",sprUGBugBones1Dead],
        ["sprBugBones1Hurt",sprUGBugBones1Hurt],
        ["sprBugBones1Idle",sprUGBugBones1Idle],
        ["sprDebrisUndergrowth",sprUGDebrisUndergrowth],
        ["sprDetailUndergrowth",sprUGDetailUndergrowth],
        ["sprDirectionalExplosion",sprUGDirectionalExplosion],
        ["sprDragonflyDead",sprUGDragonflyDead],
        ["sprDragonflyHurt",sprUGDragonflyHurt],
        ["sprDragonflyIdle",sprUGDragonflyIdle],
        ["sprDragonflyTurn",sprUGDragonflyTurn],
        ["sprDragonflyWalk",sprUGDragonflyWalk],
        ["sprEmber",sprUGEmber],
        ["sprEntryVineDead",sprUGEntryVineDead],
        ["sprEntryVineExit",sprUGEntryVineExit],
        ["sprEntryVineHurt",sprUGEntryVineHurt],
        ["sprEntryVineIdle",sprUGEntryVineIdle],
        ["sprFireflyDead",sprUGFireflyDead],
        ["sprFireflyExplode",sprUGFireflyExplode],
        ["sprFireflyHurt",sprUGFireflyHurt],
        ["sprFireflyIdle",sprUGFireflyIdle],
        ["sprFireflyWalk",sprUGFireflyWalk],
        ["sprFlamePuff",sprUGFlamePuff],
        ["sprFlameSparkle",sprUGFlameSparkle],
        ["sprFlameSparkleBig",sprUGFlameSparkleBig],
        ["sprFloorUndergrowth",sprUGFloorUndergrowth],
        ["sprFloorUndergrowthB",sprUGFloorUndergrowthB],
        ["sprFloorUndergrowthExplo",sprUGFloorUndergrowthExplo],
        ["sprFlytrapChrg",sprUGFlytrapChrg],
        ["sprFlytrapDead",sprUGFlytrapDead],
        ["sprFlytrapFire",sprUGFlytrapFire],
        ["sprFlytrapHurt",sprUGFlytrapHurt],
        ["sprFlytrapIdle",sprUGFlytrapIdle],
        ["sprFlytrapWalk",sprUGFlytrapWalk],
        ["sprFogUndergrowth",sprUGFogUndergrowth],
        ["sprFossilCannon",sprUGFossilCannon],
        ["sprFossilGun",sprUGFossilGun],
        ["sprFossilHammer",sprUGFossilHammer],
        ["sprFossilPistol",sprUGFossilPistol],
        ["sprFuelSheet",sprUGFuelSheet],
        ["sprFuelStreak",sprUGFuelStreak],
        ["sprGoldPitcherPlantCharge",sprUGGoldPitcherPlantCharge],
        ["sprGoldPitcherPlantDead",sprUGGoldPitcherPlantDead],
        ["sprGoldPitcherPlantFire",sprUGGoldPitcherPlantFire],
        ["sprGoldPitcherPlantHurt",sprUGGoldPitcherPlantHurt],
        ["sprGoldPitcherPlantIdle",sprUGGoldPitcherPlantIdle],
        ["sprGoldPitcherPlantWalk",sprUGGoldPitcherPlantWalk],
        ["sprGreenDirectionalExplosion",sprUGGreenDirectionalExplosion],
        ["sprHealFire",sprUGHealFire],
        ["sprHealFireUltra",sprUGHealFireUltra],
        ["sprLavaBomb",sprUGLavaBomb],
        ["sprLavaBombBig",sprUGLavaBombBig],
        ["sprLavaSheet",sprUGLavaSheet],
        ["sprLavaSlash",sprUGLavaSlash],
        ["sprLavaSplash",sprUGLavaSplash],
        ["sprLavaSplashUltra",sprUGLavaSplashUltra],
        ["sprLavaStreak",sprUGLavaStreak],
        ["sprLightBeamUndergrowth",sprUGLightBeamUndergrowth],
        ["sprMegaGrenade",sprUGMegaGrenade],
        ["sprMegaGrenadeBlink",sprUGMegaGrenadeBlink],
        ["sprMegaGrenadeLauncher",sprUGMegaGrenadeLauncher],
        ["sprMillipedeBodyHurt1",sprUGMillipedeBodyHurt1],
        ["sprMillipedeBodyHurt2",sprUGMillipedeBodyHurt2],
        ["sprMillipedeBodyHurt3",sprUGMillipedeBodyHurt3],
        ["sprMillipedeBodyHurt4",sprUGMillipedeBodyHurt4],
        ["sprMillipedeBodyIdle1",sprUGMillipedeBodyIdle1],
        ["sprMillipedeBodyIdle2",sprUGMillipedeBodyIdle2],
        ["sprMillipedeBodyIdle3",sprUGMillipedeBodyIdle3],
        ["sprMillipedeBodyIdle4",sprUGMillipedeBodyIdle4],
        ["sprMillipedeDead",sprUGMillipedeDead],
        ["sprMillipedeFootHurt",sprUGMillipedeFootHurt],
        ["sprMillipedeFootIdle",sprUGMillipedeFootIdle],
        ["sprMillipedeHeadHurt1",sprUGMillipedeHeadHurt1],
        ["sprMillipedeHeadHurt2",sprUGMillipedeHeadHurt2],
        ["sprMillipedeHeadHurt3",sprUGMillipedeHeadHurt3],
        ["sprMillipedeHeadHurt4",sprUGMillipedeHeadHurt4],
        ["sprMillipedeHeadHurt5",sprUGMillipedeHeadHurt5],
        ["sprMillipedeHeadHurt6",sprUGMillipedeHeadHurt6],
        ["sprMillipedeHeadHurt7",sprUGMillipedeHeadHurt7],
        ["sprMillipedeHeadHurt8",sprUGMillipedeHeadHurt8],
        ["sprMillipedeHeadIdle1",sprUGMillipedeHeadIdle1],
        ["sprMillipedeHeadIdle2",sprUGMillipedeHeadIdle2],
        ["sprMillipedeHeadIdle3",sprUGMillipedeHeadIdle3],
        ["sprMillipedeHeadIdle4",sprUGMillipedeHeadIdle4],
        ["sprMillipedeHeadIdle5",sprUGMillipedeHeadIdle5],
        ["sprMillipedeHeadIdle6",sprUGMillipedeHeadIdle6],
        ["sprMillipedeHeadIdle7",sprUGMillipedeHeadIdle7],
        ["sprMillipedeHeadIdle8",sprUGMillipedeHeadIdle8],
        ["sprMillipedeTailHurt1",sprUGMillipedeTailHurt1],
        ["sprMillipedeTailHurt2",sprUGMillipedeTailHurt2],
        ["sprMillipedeTailHurt3",sprUGMillipedeTailHurt3],
        ["sprMillipedeTailHurt4",sprUGMillipedeTailHurt4],
        ["sprMillipedeTailIdle1",sprUGMillipedeTailIdle1],
        ["sprMillipedeTailIdle2",sprUGMillipedeTailIdle2],
        ["sprMillipedeTailIdle3",sprUGMillipedeTailIdle3],
        ["sprMillipedeTailIdle4",sprUGMillipedeTailIdle4],
        ["sprMushroom1Dead",sprUGMushroom1Dead],
        ["sprMushroom1Explode",sprUGMushroom1Explode],
        ["sprMushroom1Hurt",sprUGMushroom1Hurt],
        ["sprMushroom1Idle",sprUGMushroom1Idle],
        ["sprMushroom1Spawn",sprUGMushroom1Spawn],
        ["sprMushroomExplosion",sprUGMushroomExplosion],
        ["sprPitcherPlantCharge",sprUGPitcherPlantCharge],
        ["sprPitcherPlantDead",sprUGPitcherPlantDead],
        ["sprPitcherPlantFire",sprUGPitcherPlantFire],
        ["sprPitcherPlantHurt",sprUGPitcherPlantHurt],
        ["sprPitcherPlantIdle",sprUGPitcherPlantIdle],
        ["sprPitcherPlantWalk",sprUGPitcherPlantWalk],
        ["sprUndergrowthBanditDead",sprUGUndergrowthBanditDead],
        ["sprUndergrowthBanditGun",sprUGUndergrowthBanditGun],
        ["sprUndergrowthBanditHurt",sprUGUndergrowthBanditHurt],
        ["sprUndergrowthBanditIdle",sprUGUndergrowthBanditIdle],
        ["sprUndergrowthBanditWalk",sprUGUndergrowthBanditWalk],
        ["sprUndergrowthDecal",sprUGUndergrowthDecal],
        ["sprUndergrowthDecalVine",sprUGUndergrowthDecalVine],
        ["sprUndergrowthTopDecal",sprUGUndergrowthTopDecal],
        ["sprVine1Dead",sprUGVine1Dead],
        ["sprVine1Hurt",sprUGVine1Hurt],
        ["sprVine1Idle",sprUGVine1Idle],
        ["sprVine2Dead",sprUGVine2Dead],
        ["sprVine2Hurt",sprUGVine2Hurt],
        ["sprVine2Idle",sprUGVine2Idle],
        ["sprVineChest",sprUGVineChest],
        ["sprVineChestOpen",sprUGVineChestOpen],
        ["sprWallUndergrowthBot",sprUGWallUndergrowthBot],
        ["sprWallUndergrowthOut",sprUGWallUndergrowthOut],
        ["sprWallUndergrowthTop",sprUGWallUndergrowthTop],
        ["sprWallUndergrowthTrans",sprUGWallUndergrowthTrans],
        ["sprWooDead",sprUGWooDead],
        ["sprWooHurt",sprUGWooHurt],
        ["sprWooIdle",sprUGWooIdle],
        ["sprWooWalk",sprUGWooWalk]];
}
