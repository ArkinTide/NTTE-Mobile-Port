// crabbone.weapon_ntte_eat/type/sprt_hud + telib.weapon_ammo_hud.
// Source callbacks apply to this stock LWO, without walking unrelated fronts.
function scrNTTEFullCrabboneAmmoContext() {
    return instance_is(id,AmmoPickup) || (instance_exists(other) && instance_is(other,AmmoPickup))
}
function scrNTTEFullCrabboneAmmoTypes(_actor,_atype,_btype,_pickup_context) {
    if(!_pickup_context) return [_atype,_btype]
    var _a=scrNTTEFullCrabboneIs(_actor.wep),_b=scrNTTEFullCrabboneIs(_actor.bwep)
    // Snapshot both normal types before substituting. This is source's
    // UberCont context guard: two bones do not recursively ask each other.
    return [_a?_btype:_atype,_b?_atype:_btype]
}
function scrNTTEFullCrabboneEatState(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!scrNTTEFullCrabboneIs(_model)) return undefined
    if(is_struct(_model)) return scrNTTEFullValue(_model,"ntte_native_state",undefined)
    if(variable_instance_exists(id,"wep") && wep==_weapon) {
        var _state=scrNTTEFullValue(id,"ntte_state",undefined)
        if(is_struct(_state) && _state.weapon==_weapon) return _state
    }
    return undefined
}
function scrNTTEFullCrabboneExtraEat(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!scrNTTEFullCrabboneIs(_model)) return 0
    var _state=scrNTTEFullCrabboneEatState(_weapon),
        _num=scrNTTEFullValue(_model,"ammo",scrNTTEFullValue(_state,"ammo",0))-1
    if(_num<=0) return 0
    var _regurg=scr_ultra_get(Race.Robot,UltraSkill.Regurgitate),_tb=scr_skill_get(mut_throne_butt)
    repeat(_num) {
        if(_regurg>0 && random(7)<3) {
            snd_play_hit(sndRegurgitate,0.2)
            repeat(_regurg) instance_create(x,y,choose(AmmoChest,choose(WeaponChest,WeaponChest,HealthChest)))
        }
        // Source's Portal callback sees the zero-valued native health fields;
        // the modern Portal object has no corresponding declared properties.
        else if(random(scrNTTEFullValue(id,"max_hp",0))>scrNTTEFullValue(id,"hp",0) && !scrCrownCheck(crwn_life)) instance_create(x,y,HPPickup)
        else instance_create(x,y,AmmoPickup)
        repeat(_tb) instance_create(x,y,AmmoPickup)
    }
    return _num
}
function scrNTTEFullCrabboneHUDInfo(_actor,_weapon,_slot) {
    if(!scrNTTEFullCrabboneIs(_weapon) || _slot>1) return undefined
    var _model=scrNTTEFullWeaponModel(_weapon),_state=scrNTTEFullValue(_actor,_slot==0?"ntte_state":"bntte_state",undefined)
    if(is_struct(_model)) _state=scrNTTEFullValue(_model,"ntte_native_state",_state)
    if(!is_struct(_state)) return undefined
    var _ammo=scrNTTEFullValue(_model,"ammo",_state.ammo)
    if(_ammo<=1) return undefined
    var _max=scrNTTEFullValue(_model,"amax",_ammo),_min=scrNTTEFullValue(_model,"amin",round(_max*0.2)),
        _active=_slot==0 || _actor.race==Race.Steroids,
        _color=_ammo>0?(_active?(_ammo>_min?c_white:c_red):(_ammo>_min?c_ltgray:c_gray)):c_dkgray
    return {text:string(_ammo),color:_color}
}
function scrNTTEFullCrabboneHUDDraw(_actor,_weapon,_slot,_x,_y) {
    var _info=scrNTTEFullCrabboneHUDInfo(_actor,_weapon,_slot)
    if(!is_struct(_info)) return;
    var _ha=draw_get_halign(),_va=draw_get_valign(),_color=draw_get_color()
    draw_set_halign(fa_left);draw_set_valign(fa_top);draw_set_color(_info.color)
    scrNTTEFullDrawText(_x+18,_y+5,_info.text)
    draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_color)
}
