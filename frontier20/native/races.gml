// Frontier race identities, menus, Ultra choices, and source lifecycle.
// Hidden transformation skins remain absent from the normal loadout slots.
// scrInit asks for all races' starters before Frontier's source bootstrap.
// These two identities are fixed by staging/identity-ledger.json.
#macro FR_BUBBLES_CUTLASS 187
#macro FR_BUBBLES_SHOVEL 188
function scrFRRaceIs(_race) {
    return is_numeric(_race) ? _race==19 : is_string(_race) && array_contains(["bubbles","race:bubbles"],string_lower(_race));
}

function scrFRRaceTryResolve(_race) {
    if(!is_string(_race)) return _race;
    if(scrFRRaceIs(_race)) return 19;
    var _key=string(_race);
    if(string_copy(_key,1,5)=="race:") _key=string_delete(_key,1,5);
    return scrRaceGetNumericID(_key);
}

function scrFRRaceResolve(_race) {
    var _native=scrFRRaceTryResolve(_race);
    assert(!is_undefined(_native),"Unknown Frontier race: "+string(_race));
    return _native;
}

function scrFRRaceKey(_race) {
    return scrFRRaceIs(_race) ? "bubbles" : scrRaceGetStringID(_race);
}

function scrFRSkinKey(_skin) {
    if(is_string(_skin)) return _skin;
    var _keys=["FreakFish","RobotBluescreened","RobotBluescreenedB","RobotBluescreenedC","RobotBluescreenedBonus","RobotBluescreenedTurret"];
    return _skin>=207 && _skin<=212 ? _keys[_skin-207] : scrNTTEFullSkinKey(_skin);
}

function scrFRSkinResolve(_skin) {
    if(is_numeric(_skin)) return _skin;
    _skin=string(_skin);
    if(string_copy(_skin,1,5)=="skin:") _skin=string_delete(_skin,1,5);
    for(var _i=207;_i<=212;++_i)
        if(string_lower(scrFRSkinKey(_i))==string_lower(string(_skin))) return _i;
    var _native=scrNTTEFullSkinNativeId(_skin);
    assert(_native>=0,"Unknown Frontier skin: "+string(_skin));
    return _native;
}

function scrFRSkinIs(_skin) { return is_numeric(_skin) && _skin>=207 && _skin<=212; }
function scrFRSkinMatches(_race,_skin) {
    if(!scrFRSkinIs(_skin)) return false;
    return _race==(_skin==207 ? Race.Fish:Race.Robot);
}

function scrFRPlayerRace(_index) {
    var _p=scr_playerinstance_find(_index);
    return is_struct(_p) ? scrFRRaceKey(_p.get_race()) : "random";
}

function scrFRPlayerSetRace(_index,_race) {
    var _native=scrFRRaceResolve(_race),_p=scr_playerinstance_find(_index);
    if(is_struct(_p)) _p.race=_native;
    var _target=scrFRPlayerFind(_index);
    if(instance_exists(_target)) with(_target) scrPlayerRaceChange(_native,0);
    return _native;
}

function scrFRPlayerSkin(_index) {
    var _p=scr_playerinstance_find(_index),_skin=is_struct(_p)?_p.skin:0;
    return _skin>=200 ? scrFRSkinKey(_skin) : _skin;
}

function scrFRPlayerSetSkin(_index,_skin) {
    var _native=scrFRSkinResolve(_skin),_p=scr_playerinstance_find(_index);
    if(is_struct(_p)) _p.skin=_native;
    var _target=scrFRPlayerFind(_index);
    // Changing a skin must not reset health, race abilities, or weapons.
    if(instance_exists(_target)) with(_target) {
        bskin=_native;
        scrFRRaceRefreshSprites();
    }
    return _native;
}

function scrFRRaceCall(_name,_args=[]) { return scrFRModCallArray("race","bubbles",_name,_args); }
function scrFRRaceVar(_name,_skin=undefined) {
    var _value=scrFRModGet("race","bubbles",_name);
    return is_undefined(_skin) ? _value : _value[clamp(_skin,0,1)];
}

function scrFRRaceAvailable() { return scrFREnabled() && scrFRRaceCall("race_avail")>0; }

// Native CharSelect positions and hover state are already GUI coordinates.
// Frontier's one-shot source overlays add world view offsets and read NTT's
// absent mouseover/alarm1 state. Let the existing native NEW draw consumer
// own these two markers, preserving their separate authored eligibility.
function scrFRRaceSelectMarkerOwned(_icon) {
    return scrFREnabled() && instance_exists(_icon) && instance_is(_icon,CharSelect)
        && (scrFRRaceIs(_icon.race) || _icon.race==Race.Robot);
}

function scrFRRaceSelectMarker(_icon,_hover=false) {
    if(!scrFRRaceSelectMarkerOwned(_icon) || !_icon.visible) return undefined;
    var _sprite=sprNew;
    if(scrFRRaceIs(_icon.race)) {
        if(!_icon.can || scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"])>0)
            return undefined;
    } else {
        if(!scrFRModGet("mod","Frontier_Main","settingCyberspaceEnabled")
            || scrFRModCallArray("mod","libSaves","save_get",["Frontier","cyberspace_visits"])>0
            || scrFRModCallArray("mod","libSaves","save_get",["Frontier","deeplabs_finales"])<=0)
            return undefined;
        _sprite=scrFRModGet("mod","Frontier_Main","sprNewRobot");
    }
    return {sprite:_sprite,image:_icon.image_index,x:_icon.xstart,y:_icon.ystart-!!_hover};
}

function scrFRRaceSkinAvailable(_skin) {
    if(!scrFREnabled()) return _skin==0;
    return _skin>=0 && _skin<2 && scrFRRaceCall("race_skin_avail",[_skin])>0;
}

function scrFRRaceUnlockSet(_value,_skin=undefined) {
    if(!scrFREnabled()) return false;
    if(!is_undefined(_skin) && _skin!=1) return false;
    var _field=is_undefined(_skin)?"unlock_bubbles":"unlock_bubbles_bskin";
    scrFRModCallArray("mod","libSaves","save_set",["Frontier",_field,_value]);
    return true;
}

function scrFRRaceText(_kind,_value=0) {
    if(!scrFREnabled()) return _kind=="name" ? "BUBBLES" : "";
    if(_kind=="passive" || _kind=="active") {
        var _parts=string_split(scrFRRaceCall("race_text"),"#");
        var _part=_kind=="passive"?0:1;
        return _part<array_length(_parts)?_parts[_part]:"";
    }
    switch(_kind) {
        case "name":return scrFRRaceCall("race_name");
        case "thronebutt":return scrFRRaceCall("race_tb_text");
        case "lock":return scrFRRaceCall("race_lock");
        case "unlock":return scrFRRaceCall("race_unlock");
        case "skin_lock":return scrFRRaceCall("race_skin_lock",[_value]);
        case "skin_unlock":return scrFRRaceCall("race_skin_unlock",[_value]);
        case "ultra_name":return scrFRRaceCall("race_ultra_name",[_value]);
        case "ultra_text":return scrFRRaceCall("race_ultra_text",[_value]);
    }
    return "";
}

function scrFRRaceNativeSprite(_kind,_skin=0,_default=-1) {
    if(!scrFREnabled()) return _default;
    var _field="";
    switch(_kind) {
        case "Idle":_field="sprIdle";break;
        case "Walk":_field="sprWalk";break;
        case "Hurt":_field="sprHurt";break;
        case "Dead":_field="sprDead";break;
        case "GoSit":_field="sprGoSit";break;
        case "Sit":_field="sprSit";break;
        case "Fire":_field="sprFire";break;
        case "Portrait":return scrFRRaceVar("sprPortrait");
        case "Map":return scrFRRaceVar("sprMapIcon");
        case "Loadout":return scrFRRaceVar("sprSkinIcon",_skin);
        case "Select":return scrFRRaceVar("sprSelect");
        case "Menu":return scrFRRaceVar("sprCampfireMenu");
        case "MenuSelect":return scrFRRaceVar("sprCampfireTo");
        case "MenuSelected":return scrFRRaceVar("sprCampfireSlct");
        case "MenuDeselect":return scrFRRaceVar("sprCampfireFrom");
    }
    return _field=="" ? _default : scrFRRaceVar(_field,_skin);
}

function scrFRRaceNativeSound(_kind,_default=-1) {
    if(!scrFREnabled()) return _default;
    var _field="sndBubbles"+_kind;
    return scrFRModExists("race","bubbles",_field) ? scrFRRaceVar(_field) : _default;
}

function scrFRRaceMenuSprite(_skin,_sprite) {
    if(!scrFREnabled()) return _sprite;
    switch(_sprite) {
        case sprBigPortrait:return scrFRRaceNativeSprite("Portrait",_skin);
        case sprMapIcon:return scrFRRaceNativeSprite("Map",_skin);
        case sprLoadoutSkin:
        case sprLoadoutSkinLocked:return scrFRRaceNativeSprite("Loadout",_skin);
    }
    return _sprite;
}

function scrFRSkinSprite(_skin,_sprite) {
    if(!scrFREnabled()) return _sprite;
    var _key=scrFRSkinKey(_skin);
    var _value=scrFRModCallArray("skin",_key,"skin_sprite",[_sprite]);
    return is_undefined(_value) ? _sprite : _value;
}

function scrFRSkinRaceSprite(_race,_skin,_kind,_default) {
    var _base=asset_get_index("sprMutant"+string(_race)+_kind);
    return _base>=0 ? scrFRSkinSprite(_skin,_base) : _default;
}

// Source API remaps a sprite through the selected race/skin. Unknown module
// names are permitted by NTT and leave unrelated sprites unchanged.
function scrFRRaceSprite(_race,_sprite) {
    if(scrFRRaceIs(_race)) {
        var _skin=self[$ "bskin"]??0;
        var _kinds=["Idle","Walk","Hurt","Dead","GoSit","Sit","Fire"];
        for(var _i=0;_i<array_length(_kinds);++_i) {
            var _base=asset_get_index("sprMutant1"+_kinds[_i]);
            if(_sprite==_base) return scrFRRaceNativeSprite(_kinds[_i],_skin,_sprite);
        }
        return scrFRRaceMenuSprite(_skin,_sprite);
    }
    var _native=is_numeric(_race)?_race:scrRaceGetNumericID(string(_race));
    if(is_undefined(_native)) return _sprite;
    return scrNTTEFullSkinMenuSprite(_native,self[$ "bskin"]??0,_sprite);
}

function scrFRRaceStarterWeapon(_skin=undefined) {
    if(!scrFREnabled()) return FR_BUBBLES_CUTLASS;
    if(is_undefined(_skin)) {
        _skin=0;
        if(variable_global_exists("index")) {
            var _p=scr_playerinstance_find(global.index);
            if(is_struct(_p)) _skin=_p.skin;
        }
    }
    return scrFRWeaponResolve(_skin==1?"FR_BubblesShovel":"FR_BubblesCutlass");
}

function scrFRUltraCount(_race) { return scrRaceGetUltraSkillMax(scrFRRaceResolve(_race)); }
function scrFRUltraGet(_race,_which) { return scr_ultra_get(scrFRRaceResolve(_race),_which); }
function scrFRUltraSet(_race,_which,_value) {
    var _native=scrFRRaceResolve(_race);
    if(_native!=19) { scr_ultra_set(_native,_which,_value);return _value; }
    if(!instance_exists(GameCont) || _which<1 || _which>2) return 0;
    var _previous=GameCont.ultra_got[19,_which];
    if(_previous==_value) return _value;
    GameCont.ultra_got[19,_which]=_value;
    var _icon=19*3+_which-1,_found=array_get_index(GameCont.ultra_hud,_icon);
    if(_value && _found<0) array_push(GameCont.ultra_hud,_icon);
    else if(!_value && _found>=0) array_delete(GameCont.ultra_hud,_found,1);
    if(_value>_previous) with(Player) if(race==19) scrFRRaceCall("race_ultra_take",[_which]);
    return _value;
}

function scrFRRaceUltraSprite(_which,_hud=false) {
    if(!scrFREnabled()) return -1;
    var _sprites=scrFRRaceVar(_hud?"sprUltraIcon":"sprUltra");
    return _sprites[clamp(_which,1,2)];
}

function scrFRRaceRefreshSprites() {
    var _kinds=["Idle","Walk","Hurt","Dead","GoSit","Sit"];
    var _fields=["spr_idle","spr_walk","spr_hurt","spr_dead","spr_gosit","spr_sit"];
    for(var _i=0;_i<array_length(_kinds);++_i) {
        var _old=variable_instance_get(id,_fields[_i]);
        variable_instance_set(id,_fields[_i],scr_race_get_sprite(race,_kinds[_i],_old,bskin));
    }
    if(race==19) {
        scrFRRaceCall("assign_sprites");
        scrFRRaceCall("assign_sounds");
    }
}

function scrFRRacePlayerChange() {
    scrFRSkinEnsureGameStart();
    if(race!=19) { fr_native_race=-1;return; }
    if((self[$ "fr_native_race"]??-1)!=19) {
        // A complete saved instance already owns its charge and orbitals.
        if(!variable_instance_exists(id,"bubbles_bubbleCharge")) scrFRRaceCall("create");
        fr_native_race=race==19?19:-1;
    }
    if(race==19) {
        scrFRRaceRefreshSprites();
        scrFRRaceEnsureGameStart();
    }
}

function scrFRSkinEnsureGameStart() {
    if(!scrFREnabled() || !instance_exists(GameCont)) return;
    if(variable_global_exists("fr_loading_save") && global.fr_loading_save) return;
    if((self[$ "fr_skin_started_game"]??noone)==GameCont.id) return;
    // Mark ordinary skins too: a transformation later in this same run must
    // retain its hidden art until the following run, rather than reset now.
    fr_skin_started_game=GameCont.id;
    if(!scrFRSkinIs(bskin)) return;
    var _selected=bskin,_key=scrFRSkinKey(_selected);
    if(_selected==212 && !scrFRModLoaded("skin","turret")) return;
    with(Player) if(bskin==_selected) fr_skin_started_game=GameCont.id;
    if(scrFRScriptExists("skin",_key,"game_start")) scrFRModCallArray("skin",_key,"game_start",[]);
}

function scrFRRaceEnsureGameStart() {
    if(race!=19 || !scrFREnabled() || !instance_exists(GameCont)) return;
    if(variable_global_exists("fr_loading_save") && global.fr_loading_save) return;
    if((self[$ "fr_race_started_game"]??noone)==GameCont.id) return;
    // GameCont.Create precedes Player creation. Mark before invoking source
    // to make delayed first-player dispatch safe against recursive callbacks.
    fr_race_started_game=GameCont.id;
    scrFRRaceCall("game_start");
}

function scrFRRacePlayerAfterLoad() {
    // Continue restores charge/stat state. It never counts as a new run.
    if(instance_exists(GameCont)) {
        fr_race_started_game=GameCont.id;
        fr_skin_started_game=GameCont.id;
    }
    // The saved enemies belong to the previous process/map instance IDs.
    if(race==19) bubbles_reducedEnemies=[];
    scrFRRacePlayerChange();
    if(scrFRSkinMatches(race,bskin)) scrFRRaceRefreshSprites();
}

function scrFRRacePlayerEndStep() {
    if(lockstep_stop || !scrFRReadyTick() || UberCont.paused) return;
    scrFRSkinEnsureGameStart();
    if(race!=19) return;
    if((self[$ "fr_native_race"]??-1)!=19) scrFRRacePlayerChange();
    else scrFRRaceEnsureGameStart();
    scrFRRaceCall("step");
}

// Called by the real NTTE Guardian-pet ability consumer in scrPowers. Source
// race callbacks run as their Player, with the pet as logical other. Calling
// this from generic Player Step would lose both that scope and pet filtering.
function scrFRRaceGuardianActive() {
    if(lockstep_stop || !scrFRReadyTick() || UberCont.paused) return;
    var _player=leader;
    if(!instance_exists(_player) || !instance_is(_player,Player)
        || !_player.visible || _player.race!=19) return;
    with(_player) scrFRRaceCall("race_ntte_guardian_step");
}

function scrFRRaceEventAll(_event,_args=[]) {
    if(!scrFREnabled()) return;
    // getRef opts Bubbles into lib's own event dispatcher. These hooks are
    // generated by lib.step and its bindings, rather than by NTT itself.
    if(array_contains(["level_start","late_step","end_step","update","end_update","mutation_update","weapon_prefire"],_event)) return;
    // Hidden skin hooks scan their own players. Snapshot the selected skins
    // before invoking any callback, since game_start restores original skins.
    var _selected=[];
    with(Player) if(scrFRSkinIs(bskin) && !array_contains(_selected,bskin)) array_push(_selected,bskin);
    for(var _i=0;_i<array_length(_selected);++_i) {
        var _skin=_selected[_i],_key=scrFRSkinKey(_skin);
        if(_selected[_i]==212 && !scrFRModLoaded("skin","turret")) continue;
        if(_event=="game_start") {
            with(Player) if(bskin==_skin) scrFRSkinEnsureGameStart();
        } else if(scrFRScriptExists("skin",_key,_event)) scrFRModCallArray("skin",_key,_event,_args);
    }
    with(Player) if(race==19) {
        scrFRRacePlayerChange();
        if(_event=="game_start") scrFRRaceEnsureGameStart();
        else scrFRRaceCall(_event,_args);
    }
}
