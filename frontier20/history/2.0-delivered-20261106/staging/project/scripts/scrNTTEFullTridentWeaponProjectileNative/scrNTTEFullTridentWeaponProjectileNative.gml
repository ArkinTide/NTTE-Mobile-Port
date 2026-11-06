// temerge1695..1708 exempts an actual physical weapon projectile whose sprite
// matches that weapon. Native merged replacement runs after the charge/fire
// mount returns, by which time held Trident visibility has changed. Preserve
// the exact synchronous creation identity/art, rather than querying hidden art.
function scrNTTEFullTridentWeaponProjectileCapture(_shot,_weapon,_state) {
    if(!instance_exists(_shot)) return;
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    if(!is_struct(_model) || !scrNTTEIsTrident(_raw)
        || scrNTTEFullValue(_model,"ntte_native_state",undefined)!=_state
        || scrNTTEFullWeaponModel(scrNTTEFullValue(_shot,"wep",undefined))!=_model
        || scrNTTEFullValue(_shot,"state",undefined)!=_state) return;
    _shot.ntte_trident_weapon_projectile_origin={projectile:_shot,model:_model,state:_state,
        raw:_raw,sprite:_shot.sprite_index,frame:current_frame}
}
function scrNTTEFullTridentWeaponProjectileRetain(_shot,_part) {
    if(!instance_exists(_shot)) return false
    var _origin=scrNTTEFullValue(_shot,"ntte_trident_weapon_projectile_origin",undefined)
    if(!is_struct(_origin)) return false
    var _model=scrNTTEFullWeaponModel(_part)
    return _origin.projectile==_shot && _origin.frame==current_frame
        && is_struct(_origin.model) && _origin.model==_model
        && scrNTTEIsTrident(_origin.raw) && _origin.raw==scrNTTEFullWeaponRaw(_model)
        && scrNTTEFullWeaponModel(scrNTTEFullValue(_shot,"wep",undefined))==_model
        && is_struct(_origin.state) && scrNTTEFullValue(_model,"ntte_native_state",undefined)==_origin.state
        && scrNTTEFullValue(_shot,"state",undefined)==_origin.state
        && _shot.sprite_index==_origin.sprite
}
