function scrFRSkillResolve(_skill) {
    if(!is_string(_skill)) return _skill;
    var _name=_skill;
    if(string_pos("skill:",_name)==1) _name=string_delete(_name,1,6);
    var _resolved=global.fr_skill_ids[$ _name];
    if(is_undefined(_resolved)) {
        var _native=scrNTTEFullSkillId(_name);
        if(_native>=0) return _native;
    }
    assert(!is_undefined(_resolved),"Unknown Frontier skill "+_name);
    return _resolved;
}

function scrFRSkillKey(_skill) {
    if(!variable_global_exists("fr_skill_keys")) return undefined;
    if(is_string(_skill)) _skill=scrFRSkillResolve(_skill);
    return global.fr_skill_keys[$ string(_skill)];
}

function scrFRSkillsInit() {
    if(!variable_global_exists("fr_skill_keys")) return;
    var _ids=variable_struct_get_names(global.fr_skill_keys);
    for(var _i=0;_i<array_length(_ids);++_i) {
        var _id=real(_ids[_i]),_key=global.fr_skill_keys[$ _ids[_i]];
        skill_name[_id]=scrFRWeaponProperty(_key,"skill_name",_key);
        skill_text[_id]=scrFRWeaponProperty(_key,"skill_text","");
        skill_msnd[_id]=scrFRWeaponProperty(_key,"skill_sound",sndMut);
        skill_tips[_id]=scrFRWeaponProperty(_key,"skill_tip","");
        maxskill=max(maxskill,_id);
    }
    if(instance_exists(GameCont) && !variable_instance_exists(GameCont,"fr_skills")) GameCont.fr_skills={};
}

function scrFRGetSkill(_skill) {
    // NTT permits queries for skills supplied by an absent optional mod.
    // Read as unowned; strict resolution is retained for mutation writes.
    if(is_string(_skill)) {
        var _name=_skill;
        if(string_pos("skill:",_name)==1) _name=string_delete(_name,1,6);
        if(is_undefined(global.fr_skill_ids[$ _name]) && scrNTTEFullSkillId(_name)<0) return 0;
    }
    _skill=scrFRSkillResolve(_skill);
    if(!instance_exists(GameCont)) return 0;
    var _key=scrFRSkillKey(_skill);
    if(is_undefined(_key)) return scr_skill_get(_skill);
    var _values=scrNTTEFullValue(GameCont,"fr_skills",{});
    return _values[$ string(_skill)]??0;
}

function scrFRSetSkill(_skill,_value) {
    _skill=scrFRSkillResolve(_skill);
    var _key=scrFRSkillKey(_skill);
    if(is_undefined(_key)) return scr_skill_set(_skill,_value);
    if(!instance_exists(GameCont)) return 0;
    if(!variable_instance_exists(GameCont,"fr_skills")) GameCont.fr_skills={};
    var _old=GameCont.fr_skills[$ string(_skill)]??0;
    if(_old==_value) return _value;
    GameCont.fr_skills[$ string(_skill)]=_value;
    var _index=ds_list_find_index(GameCont.skills,_skill);
    if(_value>0 && _index<0) ds_list_add(GameCont.skills,_skill);
    if(_value<=0 && _index>=0) ds_list_delete(GameCont.skills,_index);
    var _callback=global.fr_module_scripts[$ _key][$ (_value>0?"skill_take":"skill_lose")];
    if(!is_undefined(_callback)) with(GameCont) scrFRInvokeHere(_callback,[_value]);
    return _value;
}

function scrFRSkillAt(_index) {
    if(!instance_exists(GameCont) || _index<0 || _index>=ds_list_size(GameCont.skills)) return undefined;
    var _id=GameCont.skills[| _index],_key=scrFRSkillKey(_id);
    return is_undefined(_key)?_id:string_delete(_key,1,6);
}

function scrFRSkillActive(_skill) {
    _skill=scrFRSkillResolve(_skill);
    return global.fr_skill_pool[$ string(_skill)]??true;
}
function scrFRSkillSetActive(_skill,_value) {
    _skill=scrFRSkillResolve(_skill);
    global.fr_skill_pool[$ string(_skill)]=_value;return _value;
}

function scrFRSkillAvailable(_skill) {
    if(!scrFRSkillActive(_skill) || scrFRGetSkill(_skill)>0) return false;
    var _key=scrFRSkillKey(_skill);
    return !is_undefined(_key) && scrFRWeaponProperty(_key,"skill_avail",true);
}

function scrFRSkillIcon(_skill,_button=false) {
    var _key=scrFRSkillKey(_skill);
    if(is_undefined(_key)) return [sprSkillIconHUD,0];
    if(!_button) return [scrFRWeaponProperty(_key,"skill_icon",sprSkillIconHUD),0];
    var _old=sprite_index,_frame=image_index;
    var _callback=global.fr_module_scripts[$ _key][$ "skill_button"];
    if(is_undefined(_callback)) return [scrFRWeaponProperty(_key,"skill_icon",sprSkillIconHUD),0];
    scrFRInvokeHere(_callback,[]);
    var _result=[sprite_index,image_index];
    sprite_index=_old; image_index=_frame;
    return _result;
}

function scrFRSkillHooks(_hook,_args=[]) {
    if(!instance_exists(GameCont)) return;
    if(_hook=="game_start") {
        if(variable_global_exists("fr_loading_save") && global.fr_loading_save) return;
        // Unowned Surgery rolls and per-run pickup counters initialize when
        // a run begins. Ordinary mutation callbacks still require ownership.
        var _all=variable_struct_get_names(global.fr_skill_keys);
        for(var _i=0;_i<array_length(_all);++_i) {
            var _callback=global.fr_module_scripts[$ global.fr_skill_keys[$ _all[_i]]][$ _hook];
            if(!is_undefined(_callback)) with(GameCont) scrFRInvokeHere(_callback,_args);
        }
        return;
    }
    var _skills=scrNTTEFullValue(GameCont,"fr_skills",{}),_ids=variable_struct_get_names(_skills);
    for(var _i=0;_i<array_length(_ids);++_i) {
        if(_skills[$ _ids[_i]]<=0) continue;
        var _key=scrFRSkillKey(real(_ids[_i]));
        var _callback=global.fr_module_scripts[$ _key][$ _hook];
        if(!is_undefined(_callback)) with(GameCont) {
            if(string_pos("draw",_hook)==1) scrFRInvokeDraw(id,_callback,_args);
            else scrFRInvokeHere(_callback,_args);
        }
    }
}
