// telib3849..3944: persistent physical weapon wrappers, independent of owner.
// Only declarative tags are serialized; native getters dispatch the hooks.
function scrNTTEFullWeaponSkinInit() {
    global.ntte_full_weapon_skin=scrNTTEFullWeaponSkinGlobal
}
function scrNTTEFullWeaponSkinGlobal(_weapon,_skin,_caller=undefined) {
    // Calling a script reference through global.foo binds self to the global
    // struct; other may retain an earlier caller across with(...). Maintained
    // call-sites pass their actual id explicitly before source getters inspect
    // Player curse, live shield identity or contextual drop metadata.
    var _context=is_undefined(_caller)?other:_caller
    var _apply=method(_context,scrNTTEFullWeaponSkin)
    if(variable_global_exists("ntte_full_weapon_skin_debug_context") && global.ntte_full_weapon_skin_debug_context) {
        var _bound=method_get_self(_apply)
        scrNTTESmokeLog("COAT CALLBACK CONTEXT DIAG "+json_stringify({selfStruct:is_struct(self),otherStruct:is_struct(other),
            explicitCaller:!is_undefined(_caller),bound:is_struct(_bound)?"struct":string(_bound),
            boundCurse:scrNTTEFullValue(_bound,"curse",-999)}))
    }
    return _apply(_weapon,_skin)
}
function scrNTTEFullWeaponSkinKey(_weapon) {
    return scrNTTEFullValue(scrNTTEFullWeaponModel(_weapon),"ntte_weapon_skin","")
}
function scrNTTEFullWeaponSkinSprite(_weapon,_sprite,_hud=false) {
    var _skin=scrNTTEFullWeaponSkinKey(_weapon)
    return _skin=="" ? _sprite:scrNTTEFullSkinSprite(_skin,_sprite,_hud?"hud":"weapon")
}
function scrNTTEFullWeaponSkin(_weapon,_skin) {
    _skin=scrNTTEFullSkinKey(_skin)
    if(_skin=="") return _weapon
    var _model=scrNTTEFullWeaponModel(_weapon),_merged=scrNTTEFullWeaponHasMerge(_model)==true
    if(_merged) scrNTTEFullWeaponMergeActive(_model,false)
    try {
        var _sprite=scrNTTEFullWeaponNativeSprite(_model)
        if(scrNTTEFullSkinSprite(_skin,_sprite,"weapon")!=_sprite) {
            if(!is_struct(_model)) _model={wep:_model}
            _model.ntte_weapon_skin=_skin
        }
    }
    finally {if(_merged) scrNTTEFullWeaponMergeActive(_model,true)}
    if(_merged) scrNTTEFullWeaponSetMergedPart(_model,scrNTTEFullWeaponSkin(scrNTTEFullWeaponMergedPart(_model),_skin))
    if(!is_struct(_model)) return _model
    var _handle=scrNTTEFullWeaponNative(_model)
    scrNTTEFullWeaponNativeRefresh(_handle)
    return _handle
}
function scrNTTEFullWeaponSkinName(_weapon,_name) {
    var _skin=scrNTTEFullWeaponSkinKey(_weapon)
    if(_skin=="") return _name
    if(!is_string(_name)) _name=scr_weapon_get_name(scrNTTEFullWeaponRaw(_weapon))
    var _words=string_split(_name," "),_label=scrNTTEFullSkinName(_skin)
    for(var _i=array_length(_words)-1;_i>=0;--_i)
        if(string_upper(_words[_i])=="GOLDEN") _words[_i]=_label
    if(array_get_index(_words,_label)>=0) return string_join_ext(" ",_words)
    return scrNTTEFullWeaponRaw(_weapon)==wep_frog_pistol?_name:_label+" "+_name
}
function scrNTTEFullWeaponSkinStockSwap(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon),_swap=wep_swap[_raw]
    if(_raw>=wep_ug_fossil_pistol && _raw<=wep_ug_mega_grenade_launcher) _swap=scrUGWeaponSwap(_raw);
    if(_raw==wep_ntte_entangler || scrNTTEIsTunnel(_raw)) _swap=scrNTTEFullEntanglerSwap()
    else if(_raw==wep_ntte_annihilator) _swap=scrNTTEFullRedWeaponSwap()
    _swap=scrNTTEFullWeaponGoldMetadata(_weapon,"swap",_swap)
    var _skin=scrNTTEFullWeaponSkinKey(_weapon)
    return _skin==""?_swap:scrNTTEFullSkinSwap(_skin,_swap)
}
function scrNTTEFullWeaponSkinProjectiles(_instances,_weapon) {
    var _skin=scrNTTEFullWeaponSkinKey(_weapon)
    if(_skin=="") return;
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(!instance_exists(_inst) || !instance_is(_inst,projectile)) continue
        with(_inst) {
            var _old=sprite_index,_sprite=scrNTTEFullSkinSprite(_skin,_old,"weapon")
            if(_old!=_sprite) {
                var _hit=scrNTTEFullValue(id,"hitid",undefined)
                // NTT's source numeric101 is the native game's symbolic
                // HitId.Disc after mobile enum renumbering. Accept both source
                // imported data and genuine native scrFire emissions.
                if(is_numeric(_hit) && (_hit==101 || _hit==HitId.Disc)) _hit=[sprGoldDisc,"GOLDEN DISC"]
                if(is_array(_hit) && array_length(_hit)>0 && _hit[0]==_old) {
                    _hit[0]=_sprite
                    if(array_length(_hit)>1 && is_string(_hit[1])) _hit[1]=scrNTTEFullWeaponSkinName(_weapon,_hit[1])
                }
                if(!is_undefined(_hit)) hitid=_hit
                if(mask_index<0) mask_index=_old
                sprite_index=_sprite
            }
        }
    }
}
function scrNTTEFullWeaponSkinFiring() {
    var _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    return is_struct(_scope) && _scope.actor==id && scrNTTEFullWeaponSkinKey(_scope.part)!=""
}
