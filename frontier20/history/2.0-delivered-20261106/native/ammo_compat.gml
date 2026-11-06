// NTT stores typ_ammo/typ_amax on each Player. Epsilon maintains a shared
// baseline which changes with Fish, Back Muscle and Haste. Keep per-player
// source changes as deltas against that live baseline, and use the same read
// boundary in native ammo pickup, cap, refill, drop and HUD consumers.
function scrFRAmmoField(_field) {
    return _field=="typ_amax" || _field=="typ_ammo" || _field=="typ_name";
}

function scrFRAmmoPlayer(_scope,_creator=false) {
    if(is_struct(_scope) || is_array(_scope) || is_string(_scope) || is_undefined(_scope) || !instance_exists(_scope)) return noone;
    if(instance_is(_scope,Player)) return _scope.id;
    if(_creator && variable_instance_exists(_scope,"creator")) {
        var _owner=_scope.creator;
        if(!is_struct(_owner) && !is_array(_owner) && !is_string(_owner) && !is_undefined(_owner)
            && instance_exists(_owner) && instance_is(_owner,Player)) return _owner.id;
    }
    return noone;
}

function scrFRAmmoTarget(_scope,_field) {
    return scrFRAmmoField(_field) && instance_exists(scrFRAmmoPlayer(_scope));
}

function scrFRAmmoBase(_field) {
    switch(_field) {
        case "typ_amax":return typ_amax;
        case "typ_ammo":return typ_ammo;
        case "typ_name":return typ_name;
    }
    throw "Unexpected Frontier ammo field: "+string(_field);
}

function scrFRAmmoDeltaField(_field) {return _field=="typ_amax"?"fr_ammo_max_delta":"fr_ammo_gain_delta";}

function scrFRAmmoArray(_scope,_field,_creator=false) {
    var _base=scrFRAmmoBase(_field),_player=scrFRAmmoPlayer(_scope,_creator);
    if(!scrFREnabled()) return _base;
    if(!instance_exists(_player)) {
        // Source corpse stand-ins and libGeneral fire proxies legitimately
        // own copied tables. Only real Players use native baseline deltas.
        var _owned=is_struct(_scope)?_scope[$ _field]:scrNTTEFullValue(_scope,_field,undefined);
        return is_array(_owned)?_owned:_base;
    }
    if(_field=="typ_name") return _base;
    var _delta=scrNTTEFullValue(_player,scrFRAmmoDeltaField(_field),undefined),_values=array_create(array_length(_base));
    for(var _i=0;_i<array_length(_base);++_i)
        _values[_i]=_base[_i]+(is_array(_delta) && _i<array_length(_delta)?_delta[_i]:0);
    return _values;
}

function scrFRAmmoRead(_scope,_field,_type) {
    var _base=scrFRAmmoBase(_field);
    if(!scrFREnabled()) return _base[_type];
    var _player=scrFRAmmoPlayer(_scope,true);
    if(!instance_exists(_player)) {var _array=scrFRAmmoArray(_scope,_field);return _array[_type];}
    if(_field=="typ_name") return _base[_type];
    var _delta=scrNTTEFullValue(_player,scrFRAmmoDeltaField(_field),undefined);
    return _base[_type]+(is_array(_delta) && _type<array_length(_delta)?_delta[_type]:0);
}

function scrFRAmmoIndexWrite(_scope,_field,_path,_value,_operation="=") {
    assert(array_length(_path)==1,"Unsupported Frontier ammo table mutation");
    var _player=scrFRAmmoPlayer(_scope),_type=_path[0],_base=scrFRAmmoBase(_field);
    if(!instance_exists(_player)) {
        var _owned=scrFRArrayClone(scrFRAmmoArray(_scope,_field)),
            _result=scrFRIndexWrite(_owned,_type,_value,_operation);
        if(is_struct(_scope)) _scope[$ _field]=_owned;else variable_instance_set(_scope,_field,_owned);
        return _result;
    }
    assert(_field!="typ_name","Native player ammo names are a shared baseline");
    assert(instance_exists(_player) && _type>=0 && _type<array_length(_base),"Frontier ammo write requires a real Player and ammo type");
    var _before=scrFRAmmoRead(_player,_field,_type),_written=scrFRNumericWrite(_before,_value,_operation),
        _name=scrFRAmmoDeltaField(_field),_delta=scrNTTEFullValue(_player,_name,undefined);
    if(!is_array(_delta)) _delta=array_create(array_length(_base),0);
    _delta[_type]=_written-_base[_type];
    variable_instance_set(_player,_name,_delta);
    return _written;
}

function scrFRAmmoIndexIncrement(_scope,_field,_path,_delta,_post) {
    var _before=scrFRAmmoRead(_scope,_field,_path[0]);
    var _written=scrFRAmmoIndexWrite(_scope,_field,_path,_delta,"+=");
    return _post?_before:_written;
}

function scrFRAmmoBonusSet(_scope,_field,_path,_bonus) {
    assert(_field!="typ_name" && array_length(_path)==1,"Invalid Wibbly ammo bonus reapply");
    var _player=scrFRAmmoPlayer(_scope),_base=scrFRAmmoBase(_field),_type=_path[0],
        _name=scrFRAmmoDeltaField(_field),_delta=scrNTTEFullValue(_player,_name,undefined);
    assert(instance_exists(_player) && _type>=0 && _type<array_length(_base),"Wibbly ammo reapply requires a native Player");
    if(!is_array(_delta)) _delta=array_create(array_length(_base),0);
    _delta[_type]=_bonus;variable_instance_set(_player,_name,_delta);
    return _base[_type]+_bonus;
}

function scrFRAmmoArrayWrite(_scope,_field,_values) {
    var _base=scrFRAmmoBase(_field);
    assert(is_array(_values) && array_length(_values)==array_length(_base),"Frontier ammo table has an invalid length");
    if(!instance_exists(scrFRAmmoPlayer(_scope))) {
        if(is_struct(_scope)) _scope[$ _field]=scrFRArrayClone(_values);
        else variable_instance_set(_scope,_field,scrFRArrayClone(_values));
        return _values;
    }
    for(var _i=0;_i<array_length(_values);++_i) scrFRAmmoIndexWrite(_scope,_field,[_i],_values[_i]);
    return _values;
}

function scrFRAmmoTests() {
    var _p=instance_find(Player,0),_other=instance_create(55016,55016,Player),_manager=noone;
    _other.index=1;
    var _baseMax=scrFRArrayClone(typ_amax),_baseGain=scrFRArrayClone(typ_ammo),
        _oldMax=scrNTTEFullValue(_p,"fr_ammo_max_delta",undefined),_oldGain=scrNTTEFullValue(_p,"fr_ammo_gain_delta",undefined),
        _ammo=scrFRArrayClone(_p.ammo),_bonusMax=scrFRArrayClone(GameCont.wib_ammoMaxBonus[_p.index]),
        _bonusGain=scrFRArrayClone(GameCont.wib_ammoGainBonus[_p.index]);
    try {
        _p.fr_ammo_max_delta=array_create(Ammo.NUM_AMMO_TYPES,0);
        _p.fr_ammo_gain_delta=array_create(Ammo.NUM_AMMO_TYPES,0);
        GameCont.wib_ammoMaxBonus[_p.index]=array_create(5,0);
        GameCont.wib_ammoGainBonus[_p.index]=array_create(5,0);
        scrFRModCallArray("mod","wibbly","ammoMaxBonus_add",[_p.index,Ammo.Bullets,25]);
        scrFRModCallArray("mod","wibbly","ammoGainBonus_add",[_p.index,Ammo.Bullets,7]);
        assert(scrFRAmmoRead(_p,"typ_amax",Ammo.Bullets)==_baseMax[Ammo.Bullets]+25
            && scrFRAmmoRead(_other,"typ_amax",Ammo.Bullets)==_baseMax[Ammo.Bullets]
            && typ_amax[Ammo.Bullets]==_baseMax[Ammo.Bullets],
            "Source ammo bonus changed the wrong player or the native shared baseline");
        var _source=scrFRVariableGet(_p,"typ_amax");
        assert(_source[Ammo.Bullets]==_baseMax[Ammo.Bullets]+25,"Source creator.typ_amax did not expose the live native cap");
        _p.ammo[Ammo.Bullets]=_baseMax[Ammo.Bullets]+20;
        scrPlayerGiveAmmo(_p,Ammo.Bullets,100,false);
        assert(_p.ammo[Ammo.Bullets]==_baseMax[Ammo.Bullets]+25,"Native ammo pickup did not use the source player's increased cap");
        var _gain=0;with(_p) _gain=scrAmmoGetPickupAmount(Ammo.Bullets);
        assert(_gain==_baseGain[Ammo.Bullets]+7,"Native pickup amount ignored the source per-player grant bonus");
        with(_other) _gain=scrAmmoGetPickupAmount(Ammo.Bullets);
        assert(_gain==_baseGain[Ammo.Bullets],"Another player's pickup amount inherited the first player's bonus");
        typ_amax[Ammo.Bullets]+=40;
        _manager=scrFRModCallArray("mod","wibbly","PlayerManager_create",[55000,55000]);
        _manager.prev_muscle=-1;
        with(_manager) scrFRModCallArray("mod","wibbly","PlayerManager_step",[]);
        assert(scrFRAmmoRead(_p,"typ_amax",Ammo.Bullets)==_baseMax[Ammo.Bullets]+65,
            "Native baseline refresh lost or duplicated the source Wibbly capacity bonus");
        scrNTTESmokeLog("PASS FRONTIER per-player native ammo caps, pickup amounts, source member reads and baseline refresh");
    } finally {
        typ_amax=_baseMax;typ_ammo=_baseGain;_p.ammo=_ammo;
        _p.fr_ammo_max_delta=_oldMax;_p.fr_ammo_gain_delta=_oldGain;
        GameCont.wib_ammoMaxBonus[_p.index]=_bonusMax;GameCont.wib_ammoGainBonus[_p.index]=_bonusGain;
        if(instance_exists(_manager)) instance_destroy(_manager,false);
        instance_destroy(_other,false);
    }
}
