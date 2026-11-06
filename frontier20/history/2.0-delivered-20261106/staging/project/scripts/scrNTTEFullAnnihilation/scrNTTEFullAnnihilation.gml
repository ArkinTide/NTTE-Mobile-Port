// skills/annihilation.skill.gml: type-wide, level-limited annihilation.
function scrNTTEFullPlural(_text) {
    var _length=string_length(_text)
    if(_length<=0) return _text
    var _lower=string_lower(_text),_exceptions=["deer","fish","sheep"]
    for(var _i=0;_i<3;++_i) {
        var _word=_exceptions[_i]
        if(string_copy(_lower,max(1,_length-string_length(_word)+1),string_length(_word))==_word) return _text
    }
    var _last=string_char_at(_lower,_length),_prev=string_char_at(_lower,_length-1)
    switch(_last) {
        case "s": case "x": case "z": case "h":
            if(_last!="h" || _prev=="c" || _prev=="s") _text+="e"
            break
        case "y": case "o":
            if(string_pos(_prev,"aeiou")==0) {
                if(_last=="y") _text=string_copy(_text,1,_length-1)+"i"
                _text+="e"
            }
            break
        case "f":
            if(_prev=="l") _text=string_copy(_text,1,_length-1)+"ve"
            break
        case "e":
            if(_prev=="f" && string_char_at(_lower,_length-2)=="i") _text=string_copy(_text,1,_length-2)+"ve"
            break
    }
    return _text+"s"
}

function scrNTTEFullEnemyName(_inst) {
    var _hit=scrNTTEFullValue(_inst,"hitid",undefined)
    if(is_array(_hit) && array_length(_hit)>1 && is_string(_hit[1])) return _hit[1]
    return string_upper(object_get_name(_inst.object_index))
}

function scrNTTEFullAnnihilate(_inst,_time) {
    if(!instance_exists(_inst)) return;
    scrNTTEFullSystemsInit()
    var _object=_inst.object_index,_object_name=object_get_name(_object)
    var _name=scrNTTEFullValue(_inst,"name",undefined),_entries=GameCont.annihilation_list,_found=false
    var _text=scrNTTEFullPlural(string_replace_all(string_lower(scrNTTEFullEnemyName(_inst)),"@q",""))
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _entry=_entries[_i]
        if(_entry.object_name==_object_name && _entry.name==_name) {
            if(_time>_entry.ammo) { _entry.ammo=_time; _entry.text=_text }
            _found=true
        }
    }
    if(!_found) array_push(_entries,{object_name:_object_name,name:_name,text:_text,ammo:_time})
    GameCont.annihilation_list=_entries
    with(_object) if(scrNTTEFullValue(id,"name",undefined)==_name) annihilation_check=false
    var _popup=instance_create(_inst.x,_inst.y-8,PopupText)
    _popup.mytext=scrNTTEFullEnemyDisplayName(_inst)+"# @rANNIHILATED!";_popup.ntte_translate=true
    snd_play(sndNothingSmallball,random_range(0.4,0.6),1.5)
    snd_play(sndNothingLowHP,random_range(3,4),0.4)
    var _timer=scrNTTEFullValue(GameCont,"annihilation_skill",noone)
    if(!instance_exists(_timer)) {
        _timer=scrNTTEFullSystemsCreate("OrchidSkill",0,0)
        GameCont.annihilation_skill=_timer
        _timer.skill=NTTEFullSkill.Annihilation; _timer.type="portal"; _timer.time=_time
        _timer.color1=make_color_rgb(252,56,0); _timer.color2=make_color_rgb(48,40,68)
        with(_timer) event_perform(ev_step,ev_step_normal)
    } else {
        _timer.time=max(_timer.time,_time); _timer.time_max=max(_timer.time_max,_time)
        _timer.flash=3; _timer.star_scale=4/5
    }
    scrNTTEFullAnnihilationStep()
}

function scrNTTEFullAnnihilationStep() {
    if(!instance_exists(GameCont)) return;
    var _entries=scrNTTEFullValue(GameCont,"annihilation_list",[])
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _entry=_entries[_i],_obj=asset_get_index(_entry.object_name)
        if(_obj<0) continue
        with(_obj) {
            if(scrNTTEFullValue(id,"name",undefined)!=_entry.name || scrNTTEFullValue(id,"annihilation_check",false)) continue
            annihilation_check=true
            sleep(50)
            if(variable_instance_exists(id,"raddrop")) raddrop-=ceil(raddrop/2)
            var _victim=id,_explosion=scrNTTEFullSystemsCreate("RedExplosion",x+orandom(1),y+orandom(1))
            _explosion.target=_victim
            _explosion.damage=min(_explosion.damage,max(10,hp))
            if(_explosion.team==team) _explosion.team=-1
            nexthurt=0
            with(_explosion) event_perform(ev_collision,_victim.object_index)
            if(instance_exists(_victim) && instance_is(_victim,Player)) _victim.nexthurt=current_frame+30
        }
    }
}

// Invoke only when a non-endgame portal first appears while a player exists.
// Matches tepickups.ntte_end_step, not "on new room" (different timing).
function scrNTTEFullAnnihilationPortalTick() {
    var _entries=scrNTTEFullValue(GameCont,"annihilation_list",[]),_keep=[]
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _entry=_entries[_i]
        if(_entry.ammo>0) { --_entry.ammo; if(_entry.ammo<=0) continue }
        array_push(_keep,_entry)
    }
    GameCont.annihilation_list=_keep
}

function scrNTTEFullAnnihilationText() {
    var _entries=scrNTTEFullValue(GameCont,"annihilation_list",[]),_max=array_length(_entries),_text="@rDESTROY"
    if(_max<=0) return _text
    _text+="S @sALL"
    if(_max==2) _text+="#"
    for(var _i=0;_i<_max;++_i) {
        if(_i>0 && _max>2) _text+=","
        if(_max>2 && (_i%2)==1) _text+="#"
        if(_max>1 && _i==_max-1) _text+=" @sAND"
        _text+=" @w"+scrNTTEFullAnnihilationEntryDisplay(_entries[_i])
    }
    var _timer=scrNTTEFullValue(GameCont,"annihilation_skill",noone)
    if(instance_exists(_timer)) {
        _text+="#@s"
        if(_timer.time>2) _text+="FOR THE NEXT @w"+string(_timer.time-1)+" LEVELS"
        else _text+=_timer.time>1 ? "THROUGH THE @wNEXT LEVEL":"UNTIL THE @wNEXT LEVEL"
    }
    return _text
}
