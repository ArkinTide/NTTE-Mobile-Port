// The source crown keeps native selection, ownership and save flows. Its ID
// follows NTTE's existing14..16 crowns without renumbering a saved selection.
function scrFRCrownReady() {
    return variable_global_exists("fr_enabled") && global.fr_enabled
        && scrFRScriptExists("crown","storms","crown_object");
}
function scrFRCrownKey(_crown) {
    if(_crown==17 || _crown=="storms" || _crown=="crown:storms") return "storms";
    return "";
}
function scrFRCrownResolve(_crown) {
    if(scrFRCrownKey(_crown)!="") return 17;
    if(is_string(_crown)) {
        switch(_crown) {
            case "bonus":case "crown:bonus":return 14;
            case "crime":case "crown:crime":return 15;
            case "red":case "crown:red":return 16;
        }
    }
    return _crown;
}
function scrFRCrownCurrent() {
    var _crown=scrCrownGetCurrent(),_key=scrNTTEFullCrownKey(_crown);
    return _key=="" ? _crown:_key;
}
function scrFRCrownAvailable(_loadout=false) {
    if(!scrFRCrownReady()) return false;
    if(_loadout) return scrNTTEFullUnlockGet("loadout:crown:storms",false);
    return instance_exists(GameCont) && scrFRModCallArray("crown","storms","crown_avail",[]);
}
function scrFRCrownLoadoutAvailable(_race) {
    return scr_race_is_unlocked(_race) && scrFRCrownAvailable(true);
}
function scrFRCrownMetadataInit() {
    if(!variable_global_exists("fr_module_scripts") || !scrFRScriptExists("crown","storms","crown_name")) return false;
    crown_name[17]=scrFRModCallArray("crown","storms","crown_name",[]);
    crown_text[17]=scrFRModCallArray("crown","storms","crown_text",[]);
    crown_tips[17]=scrFRModCallArray("crown","storms","crown_tip",[]);
    crown_sond[17]=sndCrownProtection;crownmax=max(crownmax,17);
    // Offline modules can finish after the native save arrays were loaded.
    // Extend the dense native rows so general stats/save code remains valid;
    // source global ownership stays in the established progress JSON.
    if(instance_exists(UberCont) && variable_instance_exists(UberCont,"crowngot")) {
        var _rows=UberCont.crowngot;
        for(var _i=0;_i<array_length(_rows);++_i)
            if(is_array(_rows[_i]) && array_length(_rows[_i])<=17) UberCont.crowngot[_i,17]=false;
    }
    return true;
}
function scrFRCrownSprite(_kind="Icon") {
    if(!scrFRCrownReady()) return -1;
    var _vars=global.fr_module_vars[$ "crown:storms"],_field;
    switch(_kind) {
        case "Idle":_field="sprCrownStormsIdle";break;
        case "Walk":_field="sprCrownStormsWalk";break;
        case "Icon":case "Loadout":_field="sprCrownStormsIcon";break;
        default:throw "Unknown Frontier Storms crown artwork: "+string(_kind);
    }
    var _sprite=_vars[$ _field];
    if(!sprite_exists(_sprite)) throw "Frontier Storms crown resource is missing: "+_field;
    return _sprite;
}
function scrFRCrownObject() {
    if(!scrFRCrownReady() || GameCont.crown!=17) return false;
    scrFRModCallArray("crown","storms","crown_object",[]);
    sprite_index=spr_idle;
    return true;
}
function scrFRCrownStep() {
    if(!scrFRCrownReady() || !instance_exists(GameCont) || GameCont.crown!=17
        || lockstep_stop || instance_exists(GenCont)) return;
    // Called at the parent's 30Hz source boundary, preserving the original
    // chance per tick when the native renderer is set to60Hz.
    scrFRModCallArray("crown","storms","step",[]);
}
function scrFRCrownTests() {
    assert(scrFRCrownResolve("storms")==17 && scrFRCrownResolve("crime")==15,
        "Frontier crown identity changed an existing saved selection");
    assert(scrNTTEFullCrownKey(17)=="storms" && crownmax>=17,"Frontier crown metadata consumer is missing");
    assert(sprite_exists(scrFRCrownSprite("Idle")) && sprite_exists(scrFRCrownSprite("Walk"))
        && sprite_exists(scrFRCrownSprite("Icon")),"Frontier source crown artwork missing");
    var _old=GameCont.loops;
    try {
        GameCont.loops=0;assert(scrFRCrownAvailable(),"Source Storms crown should be offered before looping");
        GameCont.loops=1;assert(!scrFRCrownAvailable(),"Source Storms crown should not be offered after looping");
    } finally {GameCont.loops=_old;}
    var _slots=scrNTTEFullCrownLoadoutSlots(),_count=0;
    for(var _i=0;_i<array_length(_slots);++_i) if(_slots[_i]==17) _count++;
    assert(_count==1,"Frontier crown loadout must contain exactly one Storms selection");
    return true;
}
