// temerge.mod.gml 160..293: data model for a source lightweight weapon.
// Native inventory/fire/sprite adapters are integrated separately. A valid
// merge tree alone does not mean the native game can equip/fire that tree.
function scrNTTEFullWeaponRaw(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    while(is_struct(_weapon) && variable_struct_exists(_weapon,"wep")) _weapon=_weapon.wep;
    return _weapon;
}
function scrNTTEFullWeaponHasMerge(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    if(!is_struct(_weapon) || !variable_struct_exists(_weapon,"temerge") || !is_struct(_weapon.temerge)) return false;
    return _weapon.temerge.is_active?true:-1;
}
function scrNTTEFullWeaponMergedPart(_weapon,_index=1) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    if(_index<0 || _index!=floor(_index)) throw "Invalid merged weapon chain index";
    repeat(_index) {
        if(scrNTTEFullWeaponHasMerge(_weapon)==false) throw "Merged weapon chain has no requested part";
        _weapon=_weapon.temerge.wep[0];
    }
    return _weapon;
}
function scrNTTEFullWeaponHasMergedWeapon(_weapon,_part) {
    _weapon=scrNTTEFullWeaponModel(_weapon); _part=scrNTTEFullWeaponModel(_part);
    var _is_lwo=is_struct(_part);
    while(scrNTTEFullWeaponHasMerge(_weapon)!=false) {
        var _front=_weapon.temerge.wep[0];
        if(_part==(_is_lwo?_front:scrNTTEFullWeaponRaw(_front))) return _weapon.temerge.is_active?true:-1;
        _weapon=_front;
    }
    return false;
}
function scrNTTEFullWeaponSetMergedPart(_weapon,_front) {
    _weapon=scrNTTEFullWeaponModel(_weapon); _front=scrNTTEFullWeaponModel(_front);
    _weapon.temerge.wep[0]=_front;
    _weapon.temerge.is_part=(scrNTTEFullWeaponRaw(_weapon)==wep_none || scrNTTEFullWeaponHasMergedWeapon(_weapon,wep_none)!=false);
}
function scrNTTEFullWeaponSetMerge(_weapon,_front) {
    _weapon=scrNTTEFullWeaponModel(_weapon); _front=scrNTTEFullWeaponModel(_front);
    if(!is_struct(_weapon)) _weapon={wep:_weapon};
    _weapon.temerge={is_active:true,is_part:true,wep:[wep_none],wep_fire_frame:0,
        wep_fire_reload:undefined,fire_frame:0,fire_at_vars:undefined,
        last_type:0,last_cost:0,last_rads:0,last_stock_cost:0};
    scrNTTEFullWeaponSetMergedPart(_weapon,_front);
    return _weapon;
}
function scrNTTEFullWeaponAddMergedPart(_weapon,_front) {
    _weapon=scrNTTEFullWeaponModel(_weapon); _front=scrNTTEFullWeaponModel(_front);
    var _old=_weapon.temerge.wep[0];
    if(scrNTTEFullWeaponHasMerge(_old)==true) {
        scrNTTEFullWeaponAddMergedPart(_old,_front);
        _weapon.temerge.is_part=(scrNTTEFullWeaponRaw(_weapon)==wep_none || scrNTTEFullWeaponHasMergedWeapon(_weapon,wep_none)!=false);
    }
    else scrNTTEFullWeaponSetMergedPart(_weapon,scrNTTEFullWeaponSetMerge(_old,_front));
}
function scrNTTEFullWeaponMerge(_stock,_front) {
    _stock=scrNTTEFullWeaponModel(_stock); _front=scrNTTEFullWeaponModel(_front);
    if(scrNTTEFullWeaponHasMerge(_stock)==true) scrNTTEFullWeaponAddMergedPart(_stock,_front);
    else _stock=scrNTTEFullWeaponSetMerge(_stock,_front);
    return _stock;
}
function scrNTTEFullWeaponMergeActive(_weapon,_active=true) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    if(scrNTTEFullWeaponHasMerge(_weapon)==false) throw "Cannot activate a weapon without a merge";
    _weapon.temerge.is_active=_active;
}
// Property reducers below preserve the original exponential ammo factor,
// cross-ammo rad conversion and reload rules, without flattening the chain.
function scrNTTEFullWeaponMergeProperty(_weapon,_field) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    var _stock=is_struct(_weapon)?_weapon.wep:_weapon;
    var _value;
    switch(_field) {
        case "area": _value=scr_weapon_get_area(_stock); break;
        case "gold": _value=scr_weapon_is_golden(_stock); break;
        case "type": _value=scr_weapon_get_type(_stock); break;
        case "cost": _value=scr_weapon_get_cost(_stock); break;
        case "rads": _value=scr_weapon_get_rads(_stock); break;
        case "load": _value=scr_weapon_get_load(_stock); break;
        case "auto": _value=scrNTTEFullWeaponStockAuto(_weapon); break;
        case "melee": _value=scr_weapon_is_melee(_stock); break;
        default: throw "Merged property adapter not integrated: "+_field;
    }
    _value=scrNTTEFullTunnellerMetadata(_weapon,_field,_value);
    if(scrNTTEFullWeaponHasMerge(_weapon)!=true) return _value;
    var _merge=_weapon.temerge,_front=_merge.wep[0];
    var _other=scrNTTEFullWeaponMergeProperty(_front,_field);
    switch(_field) {
        case "area": return max(_value,_other);
        case "gold": return _value!=0?min(_value,_other):_value;
        case "type":
            if(_merge.is_part) return Ammo.None;
            _merge.last_type=_other; return _other;
        case "cost":
            _merge.last_stock_cost=_value;
            if(_merge.is_part) return 0;
            var _result=_other;
            if(_value!=0 && _other!=0) {
                _result+=round(_result*(power(abs(_value),0.795)-1));
                if(_result>99) {
                    if(scrNTTEFullWeaponMergeProperty(_weapon,"type")==Ammo.Bullets) {
                        if(_result>555 && _value<=555 && _other<=555) _result=555;
                    }
                    else if(_value<=99 && _other<=99) _result=99;
                }
            }
            _merge.last_cost=_result; return _result;
        case "rads":
            if(_merge.is_part) return 0;
            var _result=_other;
            if(_value!=0 || _other!=0) {
                if(_result!=0) {
                    var _stock_cost=abs(scr_weapon_get_cost(_stock));
                    if(_stock_cost!=0 && _stock_cost!=1) _result+=round(_result*(power(_stock_cost,0.795)-1));
                }
                if(_value!=0) {
                    var _add=_value/2,_front_cost=scrNTTEFullWeaponMergeProperty(_front,"cost");
                    var _front_type=scrNTTEFullWeaponMergeProperty(_front,"type"),_stock_type=scr_weapon_get_type(_stock);
                    if(_front_cost!=0) _add*=abs(_front_cost);
                    if(_front_type!=_stock_type) {
                        if(_stock_type==Ammo.Bullets) _add*=3;
                        else if(_front_type==Ammo.Bullets) _add/=3;
                    }
                    _result+=round(_add);
                }
                if(_result>1200 && _value<=1200 && _other<=1200) _result=1200;
            }
            _merge.last_rads=_result; return _result;
        case "load":
            if(_merge.is_part) return 1;
            var _result=_other*lerp(1,_value/8,0.8);
            if(_result>_other && (!scrNTTEFullWeaponMergeProperty(_weapon,"melee") || scrNTTEFullWeaponMergeProperty(_front,"melee")))
                _result=lerp(_result,_other,2/3);
            if(scrNTTEFullWeaponMergeProperty(_weapon,"cost")==0) _result+=2*max(0,abs(scr_weapon_get_cost(_stock))-1);
            return _result;
        case "auto":
            if(_value>=0) {
                if(_merge.is_part) return -1;
                if(_other?((is_undefined(_merge.wep_fire_reload)?scrNTTEFullWeaponMergeProperty(_weapon,"load"):_merge.wep_fire_reload)<=8):(_other<0)) return _other;
            }
            return _value;
        case "melee": return _value || _other;
    }
}
function scrNTTEFullMergedWeaponModelTests() {
    var _w=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun);
    var _same=scrNTTEFullWeaponMerge(_w,wep_crossbow);
    assert(_same==_w && scrNTTEFullWeaponRaw(_w)==wep_revolver,"Adding merge replaced stock identity");
    assert(scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_w,1))==wep_shotgun
        && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_w,2))==wep_crossbow,"Merge append flattened/reordered parts");
    var _lwo={wep:wep_wrench,ammo:7};
    var _a=scrNTTEFullWeaponMerge(wep_revolver,_lwo),_b=scrNTTEFullWeaponMerge(wep_revolver,wep_wrench);
    assert(scrNTTEFullWeaponHasMergedWeapon(_a,_lwo)==true && scrNTTEFullWeaponHasMergedWeapon(_b,_lwo)==false,"Merged LWO equality lost instance identity");
    assert(scrNTTEFullWeaponMergeProperty(_w,"type")==scr_weapon_get_type(wep_crossbow),"Merged ammo type did not come from front weapon");
    assert(scrNTTEFullWeaponMergeProperty(_w,"area")==max(scr_weapon_get_area(wep_crossbow),scr_weapon_get_area(wep_shotgun)),"Merged difficulty did not use highest part");
    var _partial=scrNTTEFullWeaponMerge(wep_none,wep_shotgun);
    assert(_partial.temerge.is_part && scrNTTEFullWeaponMergeProperty(_partial,"cost")==0
        && scrNTTEFullWeaponMergeProperty(_partial,"type")==Ammo.None && scrNTTEFullWeaponMergeProperty(_partial,"load")==1,"Stock placeholder became a complete weapon");
    var _middle=scrNTTEFullWeaponMerge(wep_revolver,wep_none);
    scrNTTEFullWeaponMerge(_middle,wep_shotgun);
    assert(_middle.temerge.is_part && scrNTTEFullWeaponHasMergedWeapon(_middle,wep_none)==true,"Nested empty part lost source incomplete state");
    scrNTTEFullWeaponMergeActive(_w,false);
    assert(scrNTTEFullWeaponHasMerge(_w)==-1 && scrNTTEFullWeaponMergeProperty(_w,"type")==scr_weapon_get_type(wep_revolver),"Inactive merge still overrides stock");
    scrNTTEFullWeaponMergeActive(_w,true);
    var _saved=json_parse(json_stringify(_w));
    assert(scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_saved,2))==wep_crossbow,"JSON lost nested merge structure");
    scrNTTESmokeLog("PASS source merged chain identity/order/placeholder/active state and stat reducers; native inventory/fire adapters separate");
}
