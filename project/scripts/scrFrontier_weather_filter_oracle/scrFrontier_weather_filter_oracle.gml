// Original snapshot query, retained only for explicit silent desktop comparison.
function scrFRWeatherFilterOracle(_target, _field, _values, _operation) {
    _field=scrFRFieldName(_field,_target);
    var _resolved=[];
    for(var _j=0;_j<array_length(_values);++_j) {
        var _expected=_values[_j];
        if(_field=="object_index" && is_string(_expected)) _expected=asset_get_index(_expected);
        if(_field=="wep"||_field=="bwep") {
            _expected=scrFRWeaponTryResolve(_expected);
            // Optional weapon modules are valid query operands even when
            // absent. They cannot match a native slot or a missing field.
            if(is_undefined(_expected)) continue;
        }
        if(_field=="area"||_field=="lastarea") {
            // Event compatibility pools also name optional, unloaded mods.
            // Missing areas cannot match a query; route writes remain strict.
            _expected=scrFRAreaTryResolve(_expected);
            if(is_undefined(_expected)) continue;
        }
        if(_field=="race") {
            // Optional companion races (Ace, Vanthro, Horsie) are queried by
            // supplied event/pickup callbacks without requiring those mods.
            // Skip unavailable operands; NE then includes the same targets.
            _expected=scrFRRaceTryResolve(_expected);
            if(is_undefined(_expected)) continue;
        }
        if(_field=="skin"||_field=="bskin") _expected=scrFRSkinResolve(_expected);
        array_push(_resolved,_expected);
    }
    _values=_resolved;
    var _found=[],_items=scrFRInstances(_target);
    _items=scrFRNTTEPetFilterItems(_target,_field,_values,_operation,_items);
    for(var _i=0;_i<array_length(_items);++_i) {
        var _item=_items[_i],_value=undefined,_match=false;
        // The snapshot is built immediately before this read and nothing in
        // this loop destroys instances. Preserve missing-field semantics.
        if(_field=="object_index") _value=scrFRObjectIndex(_item);
        else if(string_length(_field)>=6 && string_copy(_field,1,5)=="alarm")
            _value=scrFRAlarmRead(_item,real(string_delete(_field,1,5)));
        else if(_field=="bbox_right" || _field=="bbox_bottom") _value=scrFRSourceBBoxRead(_item,_field);
        else if(variable_instance_exists(_item,_field)) _value=variable_instance_get(_item,_field);
        for(var _j=0;_j<array_length(_values);++_j) {
            var _expected=_values[_j];
            switch(_operation) {
                case 0: _match=(_value==_expected); break;
                case 1: _match=(_value==_expected); break;
                // Missing fields never participate in ordered comparisons.
                case 2: _match=!is_undefined(_value)&&_value>=_expected; break;
                case 3: _match=!is_undefined(_value)&&_value>_expected; break;
                case 4: _match=!is_undefined(_value)&&_value<=_expected; break;
                case 5: _match=!is_undefined(_value)&&_value<_expected; break;
            }
            if(_match) break;
        }
        if(_operation==1) _match=!_match;
        if(_match) array_push(_found,_item);
    }
    return _found;
}
