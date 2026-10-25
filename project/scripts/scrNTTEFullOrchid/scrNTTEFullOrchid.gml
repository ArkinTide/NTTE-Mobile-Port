// Source: objects/tepickups.mod.gml OrchidSkill_* (3873-4321).
// Native hp/max_hp/hammerhead/spirit are the recreated runner's equivalents.
function scrNTTEFullOrchidDecide() {
    var _list=[],_all=true
    for(var _skill=37;_skill>=1;--_skill) if(scrNTTEFullSkillAvailable(_skill)) {
        array_push(_list,_skill)
        if(scr_skill_get(_skill)==0) _all=false
    }
    // Fisher-Yates preserves the original uniform shuffled selection.
    for(var _i=array_length(_list)-1;_i>0;--_i) {
        var _j=irandom(_i),_tmp=_list[_i]; _list[_i]=_list[_j]; _list[_j]=_tmp
    }
    for(var _i=0;_i<array_length(_list);++_i) if(_all || scr_skill_get(_list[_i])==0) return _list[_i]
    return 0
}
function scrNTTEFullOrchidCreate() {
    color1=-1; color2=-1; flash=-1; star_scale=1
    skill=(variable_global_exists("ntte_orchid_restoring") && global.ntte_orchid_restoring) ? 0:scrNTTEFullOrchidDecide()
    num=1; type="basic"; time=0; time_max=0
    setup=true; chest=[]; spirit=[]; creator=noone
    ntte_game=instance_exists(GameCont) ? instance_find(GameCont,0):noone
    ntte_applied=false; ntte_revoke=true; persistent=true; visible=false
}
function scrNTTEFullOrchidPatience() {
    return scr_skill_get(mut_patience)!=0 ? GameCont.patienceskill:undefined
}
function scrNTTEFullOrchidRemovePatience(_last) {
    if(is_undefined(_last)) return;
    if(_last==0) { GameCont.skillpoints--; return; }
    var _timer=scrNTTEFullSystemsCreate("OrchidSkill",0,0)
    _timer.skill=_last; _timer.num=scr_skill_get(_last)
    with(_timer) instance_destroy()
}
function scrNTTEFullOrchidClone(_inst) {
    var _copy=noone
    with(_inst) _copy=scrNTTEFullMergedNativeCopy(false)
    if(!instance_exists(_copy)) return noone
    _copy.depth=_inst.depth
    // Original clone depth0 duplicates top-level arrays and structs.
    var _keys=variable_instance_get_names(_copy)
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_value=variable_instance_get(_copy,_key)
        if(is_array(_value)) variable_instance_set(_copy,_key,scrNTTEFullArrayCopy(_value))
        else if(is_struct(_value)) variable_instance_set(_copy,_key,struct_clone(_value))
    }
    return _copy
}
function scrNTTEFullArrayCopy(_array) {
    var _copy=[]; array_copy(_copy,0,_array,0,array_length(_array)); return _copy
}
function scrNTTEFullOrchidSetup() {
    setup=false
    switch(type) {
        case "basic":
            if(color1==-1) color1=make_color_rgb(255,255,80)
            if(color2==-1) color2=make_color_rgb(84,58,24)
            if(time_max==0) { if(time==0) time=600; time_max=time }
            break
        case "portal":
            if(color1==-1) color1=make_color_rgb(72,253,8)
            if(color2==-1) color2=make_color_rgb(50,72,40)
            if(time_max==0) { if(time==0) time=2; time_max=time }
            break
    }
    if(num!=0 && skill!=0) {
        var _previous=scr_skill_get(skill),_patience=scrNTTEFullOrchidPatience(),_spirit_before=[]
        if(skill==mut_strong_spirit) with(Player) array_push(_spirit_before,[id,spirit,can_spirit])
        scr_skill_set(skill,num<0 ? min(num,_previous+num):max(num,_previous+num))
        ntte_applied=true
        switch(skill) {
            case mut_scarier_face:
                with(enemy) if(id<other.id) {
                    max_hp=round(max_hp*power(0.8,other.num)); hp=round(hp*power(0.8,other.num))
                    sprite_index=spr_hurt; image_index=0
                    if(point_in_rectangle(x,y,view_xview,view_yview,view_xview+view_width,view_yview+view_height)) snd_play(snd_hurt,1,0.3)
                }
                break
            case mut_patience: scrNTTEFullOrchidRemovePatience(_patience); break
            case mut_hammerhead:
                with(Player) if(id<other.id) hammerhead+=20*other.num
                break
            case mut_strong_spirit:
                for(var _i=0;_i<array_length(_spirit_before);++_i) {
                    var _entry=_spirit_before[_i],_p=_entry[0],_left=num
                    _p.spirit=_entry[1]; _p.can_spirit=_entry[2]
                    if(_left>0) {
                        if(!_p.spirit || _previous<=0) { with(_p) scrStrongSpiritRefill(); _left-- }
                        if(_left>0) {
                            if(!variable_instance_exists(_p,"bonus_spirit")) _p.bonus_spirit=[]
                            repeat(_left) {
                                var _token={active:true}
                                array_push(spirit,_token); array_push(_p.bonus_spirit,_token)
                                snd_play(sndStrongSpiritGain)
                            }
                        }
                    }
                }
                break
            case mut_open_mind:
                if(num>0) {
                    var _choices=[]
                    with(chestprop) if(mask_index!=mskNone) array_push(_choices,id)
                    with(RadChest) if(mask_index!=mskNone) array_push(_choices,id)
                    if(array_length(_choices)) {
                        var _original=_choices[irandom(array_length(_choices)-1)]
                        repeat(num) {
                            var _clone=scrNTTEFullOrchidClone(_original)
                            array_push(chest,_clone)
                            if(instance_is(_original,RadChest)) scrNTTEFullWorldBudge(_clone,_original)
                        }
                        for(var _i=0;_i<array_length(chest);++_i) {
                            var _icon=skill>=30 ? scrNTTEFullSkillIcon(skill):[sprSkillIconHUD,skill]
                            var _a=scrNTTEAlertCreate(chest[_i].x,chest[_i].y,_icon[0],chest[_i])
                            _a.image_index=_icon[1]; _a.creator=id; _a.flash=4; _a.snd_flash=sndChest
                            _a.alert_hold=(type=="basic" ? time:300)-2*_a.blink
                        }
                    }
                }
                break
            case mut_heavy_heart: GameCont.wantheavy=(scr_skill_get(skill)==0); break
        }
    }
    if(flash==-1) flash=3
    snd_play(scr_skill_get_sound(skill),1,0.3); snd_play(sndStatueXP,0.8,0.8)
}
function scrNTTEFullOrchidStep() {
    if(lockstep_stop) return;
    if(!instance_exists(ntte_game) || !instance_exists(GameCont) || ntte_game!=instance_find(GameCont,0)) {
        ntte_revoke=false; instance_destroy(); return;
    }
    if(setup) scrNTTEFullOrchidSetup()
    if(flash>0) flash-=timescale
    if(star_scale>0) star_scale-=timescale/60
    if(scr_skill_get(skill)!=0) {
        if(time>0 && type=="basic") {
            if(!instance_exists(GenCont) && !instance_exists(LevCont)) {
                time-=min(time,timescale)
                if(time<=0) flash=2
            }
        } else if(time==0 && flash<=0) instance_destroy()
    } else { ntte_revoke=false; instance_destroy() }
    if(type=="basic") for(var _i=0;_i<array_length(chest);++_i) if(instance_exists(chest[_i])) {
        var _chest=chest[_i]
        with(NTTEAlert) if(target==_chest) _chest.visible=alert_on
    }
}
function scrNTTEFullOrchidPortalTick() {
    var _ticks=0
    with(NTTEFullOrchidSkill) if(type=="portal" && time>0) {
        time-=min(time,1);flash=2;star_scale=4/5;_ticks++;
    }
    return _ticks
}

// Native continuation regenerates the level; it does not serialize floor objects.
// Store timer state and stable shared-spirit identities, never stale chest/instance IDs.
function scrNTTEFullOrchidExport() {
    var _rows=[],_fields=["color1","color2","flash","star_scale","skill","num","type","time","time_max","setup","ntte_applied"]
    var _serial=scrNTTEFullValue(GameCont,"ntte_full_spirit_serial",0)
    with(NTTEFullOrchidSkill) {
        if(ntte_game!=instance_find(GameCont,0)) continue
        var _row={values:{},spirit_keys:[],annihilation:(scrNTTEFullValue(GameCont,"annihilation_skill",noone)==id)}
        for(var _i=0;_i<array_length(_fields);++_i) {
            var _key=_fields[_i]
            variable_struct_set(_row.values,_key,variable_instance_get(id,_key))
        }
        for(var _i=0;_i<array_length(spirit);++_i) {
            var _token=spirit[_i]
            if(!variable_struct_exists(_token,"ntte_token_key")) _token.ntte_token_key=++_serial
            array_push(_row.spirit_keys,_token.ntte_token_key)
        }
        array_push(_rows,_row)
    }
    GameCont.ntte_full_spirit_serial=_serial
    return {schema:1,timers:_rows}
}

function scrNTTEFullOrchidImport(_data) {
    if(!is_struct(_data) || scrNTTEFullValue(_data,"schema",0)!=1 || !is_array(scrNTTEFullValue(_data,"timers",undefined))) return false
    var _restore_before=variable_global_exists("ntte_orchid_restoring") && global.ntte_orchid_restoring
    global.ntte_orchid_restoring=true
    // Removing old timers must not revoke counts already supplied by session data.
    with(NTTEFullOrchidSkill) { ntte_revoke=false; instance_destroy() }
    GameCont.annihilation_skill=noone
    var _fields=["color1","color2","flash","star_scale","skill","num","type","time","time_max","setup","ntte_applied"]
    try {
        for(var _r=0;_r<array_length(_data.timers);++_r) {
            var _row=_data.timers[_r]
            if(!is_struct(_row) || !is_struct(scrNTTEFullValue(_row,"values",undefined))) continue
            var _timer=instance_create(0,0,NTTEFullOrchidSkill)
            for(var _i=0;_i<array_length(_fields);++_i) {
                var _key=_fields[_i]
                if(variable_struct_exists(_row.values,_key)) variable_instance_set(_timer,_key,variable_struct_get(_row.values,_key))
            }
            _timer.ntte_game=instance_find(GameCont,0); _timer.chest=[]; _timer.spirit=[]
            var _keys=scrNTTEFullValue(_row,"spirit_keys",[])
            for(var _i=0;_i<array_length(_keys);++_i) {
                var _token_key=_keys[_i],_found=undefined
                with(Player) {
                    var _tokens=scrNTTEFullValue(id,"bonus_spirit",[])
                    for(var _j=0;_j<array_length(_tokens);++_j) if(scrNTTEFullValue(_tokens[_j],"ntte_token_key",-1)==_token_key) _found=_tokens[_j]
                }
                // Keep a consumed-token placeholder: its count distinguishes this
                // timer's extra halos from its possible normal Strong Spirit grant.
                if(is_undefined(_found)) _found={active:false,ntte_token_key:_token_key}
                array_push(_timer.spirit,_found)
            }
            if(scrNTTEFullValue(_row,"annihilation",false)) GameCont.annihilation_skill=_timer
        }
    } finally { global.ntte_orchid_restoring=_restore_before }
    return true
}

// Player context. The native spirit flag is the ready halo; can_spirit is recharge eligibility.
function scrNTTEFullBonusSpiritStep() {
    if(!variable_instance_exists(id,"bonus_spirit") || !array_length(bonus_spirit)) return;
    if(hp<=0 && scrNTTEFullPlayerActive(id) && (!scr_skill_get(mut_strong_spirit) || !spirit)) {
        for(var _i=array_length(bonus_spirit)-1;_i>=0;--_i) {
            var _token=bonus_spirit[_i]
            if(scrNTTEFullValue(_token,"active",true)) {
                hp=1; spirit_index=0.4; nexthurt=max(nexthurt,current_frame+10)
                _token.active=false; _token.sprite_index=sprStrongSpirit; _token.image_index=0
                snd_play(sndStrongSpiritLost); break
            }
        }
    }
    with(StrongSpiritRefill) if(creator==other.id && visible) {
        visible=false
        array_push(other.bonus_spirit,{active:false,sprite_index:sprite_index,image_index:image_index})
    }
    for(var _i=array_length(bonus_spirit)-1;_i>=0;--_i) {
        var _token=bonus_spirit[_i]
        if(!variable_struct_exists(_token,"active")) _token.active=true
        if(!variable_struct_exists(_token,"sprite_index")) _token.sprite_index=_token.active ? sprStrongSpiritRefill:sprStrongSpirit
        if(!variable_struct_exists(_token,"image_index")) _token.image_index=0
        if(_token.active && scrNTTEFullValue(_token,"halo",false)) continue
        if(_token.active || _token.sprite_index!=mskNone) {
            _token.image_index+=0.4*timescale
            if(_token.image_index>=sprite_get_number(_token.sprite_index)) {
                // Native runner stores the stationary halo in StrongSpirit frame0.
                _token.sprite_index=_token.active ? sprStrongSpirit:mskNone; _token.image_index=0
                if(_token.active) _token.halo=true
            }
        } else array_delete(bonus_spirit,_i,1)
    }
    if(!variable_instance_exists(id,"bonus_spirit_bend")) { bonus_spirit_bend=0; bonus_spirit_bend_spd=0 }
    var _count=array_length(bonus_spirit)+(scr_skill_get(mut_strong_spirit)>0 && spirit)
    bonus_spirit_bend_spd+=(hspeed/max(timescale,0.00001))/(3*max(1,_count))
    bonus_spirit_bend_spd+=0.1*(0-bonus_spirit_bend)*timescale
    bonus_spirit_bend+=bonus_spirit_bend_spd*timescale
    bonus_spirit_bend_spd-=bonus_spirit_bend_spd*0.15*timescale
}
function scrNTTEFullBonusSpiritDraw() {
    if(!visible || !variable_instance_exists(id,"bonus_spirit") || !array_length(bonus_spirit)) return;
    var _bend=scrNTTEFullValue(id,"bonus_spirit_bend",0),_dir=90,_x=x,_y=y+sin(current_frame*0.1)
    if(scr_skill_get(mut_strong_spirit)>0 && spirit) { _x+=lengthdir_x(7,_dir); _y+=lengthdir_y(7,_dir); _dir+=_bend }
    for(var _i=0;_i<array_length(bonus_spirit);++_i) {
        var _token=bonus_spirit[_i]
        draw_sprite_ext(scrNTTEFullValue(_token,"sprite_index",mskNone),scrNTTEFullValue(_token,"image_index",0),_x,_y,1,1,_dir-90,c_white,1)
        _x+=lengthdir_x(7,_dir); _y+=lengthdir_y(7,_dir); _dir+=_bend
    }
}
function scrNTTEFullOrchidDestroy() {
    if(!ntte_revoke || !instance_exists(ntte_game) || !instance_exists(GameCont)) return;
    var _last=scr_skill_get(skill),_patience=scrNTTEFullOrchidPatience(),_health=[]
    with(Player) array_push(_health,[id,hp,spirit,can_spirit])
    if(skill==mut_last_wish) scr_skill_set(skill,0)
    scr_skill_set(skill,_last<0 ? min(0,_last-num):max(0,_last-num))
    for(var _i=0;_i<array_length(_health);++_i) {
        var _entry=_health[_i],_p=_entry[0]
        if(instance_exists(_p)) _p.hp=min(max(_entry[1],_p.hp),_p.max_hp)
        if(skill==mut_strong_spirit) { _p.spirit=_entry[2]; _p.can_spirit=_entry[3] }
    }
    snd_play(sndMutHover,0.5+random(0.2),3); snd_play(sndCursedReminder,1+random_range(-0.1,0.1),3)
    snd_play(sndStatueHurt,0.7+random(0.1),0.4)
    with(NTTEAlert) if(scrNTTEFullValue(id,"creator",noone)==other.id) {
        flash=1; blink=1; alert_age=0; alert_hold=1; alert_on=true
    }
    for(var _i=0;_i<array_length(chest);++_i) if(instance_exists(chest[_i])) instance_destroy(chest[_i],false)
    switch(skill) {
        case mut_throne_butt:
            if(scr_skill_get(skill)<=0) with(Player) if(roll!=0) snd_stop(sndFishTB)
            break
        case mut_scarier_face:
            if(num!=0) with(enemy) if(id<other.id) {
                max_hp=round(max_hp/power(0.8,other.num)); hp=round(hp/power(0.8,other.num))
                sprite_index=spr_hurt; image_index=0
                instance_create(x,y,HealFX)
                snd_play(sndHPPickup,1.5,0.3)
            }
            break
        case mut_patience: scrNTTEFullOrchidRemovePatience(_patience); break
        case mut_hammerhead:
            with(Player) if(id<other.id && hammerhead>0) hammerhead=max(0,hammerhead-20*other.num)
            break
        case mut_strong_spirit:
            for(var _i=0;_i<array_length(spirit);++_i) {
                var _token=spirit[_i]
                if(scrNTTEFullValue(_token,"active",true)) {
                    _token.active=false; _token.sprite_index=sprStrongSpirit; _token.image_index=0
                    snd_play(sndStrongSpiritLost)
                }
            }
            if(num-array_length(spirit)>0) with(Player) if(id<other.id && spirit) {
                if(scr_skill_get(mut_strong_spirit)>0) spirit=false
                var _fx=instance_create(x,y,StrongSpiritRefill); _fx.sprite_index=sprStrongSpirit; _fx.creator=id
                snd_play(sndStrongSpiritLost)
            }
            break
        case mut_heavy_heart: GameCont.wantheavy=(scr_skill_get(skill)==0); break
    }
}

// ntte.mod4612..4825: newest source type, longest remaining timer of that type.
function scrNTTEFullOrchidHUDState(_skill) {
    if(!instance_exists(GameCont) || !instance_exists(NTTEFullOrchidSkill) || scr_skill_get(_skill)==0) return undefined
    var _timers=scrNTTEFullInstances(NTTEFullOrchidSkill),_state=undefined,
        _patience=scrNTTEFullOrchidPatience(),_game=instance_find(GameCont,0)
    array_sort(_timers,false)
    for(var _i=0;_i<array_length(_timers);++_i) {
        var _timer=_timers[_i]
        if(_timer.ntte_game!=_game || (_timer.skill!=_skill
            && !(_skill==_patience && _timer.skill==mut_patience))) continue
        if(is_undefined(_state)) _state={type:undefined,time:0,time_max:0,color1:c_white,color2:c_dkgray,flash:false,star_scale:0,count:0}
        if(is_undefined(_state.type) || (_timer.type==_state.type && _timer.time>_state.time)) {
            _state.type=_timer.type;_state.time=_timer.time;_state.time_max=_timer.time_max
            _state.color1=_timer.color1;_state.color2=_timer.color2
        }
        _state.flash=_state.flash || _timer.flash>0
        _state.star_scale=max(_state.star_scale,_timer.star_scale);_state.count++
    }
    return _state
}
function scrNTTEFullOrchidHUD(_skill,_spr,_img,_x,_y) {
    if(!sprite_exists(_spr)) return;
    var _state=scrNTTEFullOrchidHUDState(_skill),_fog=gpu_get_fog()
    try {
        if(!is_undefined(_state)) {
            if(_state.flash) gpu_set_fog(true,c_white,0,0)
            if(_state.time!=0 && _state.time_max>0) {
                var _uvs=sprite_get_uvs(_spr,_img),
                    _x1=max(sprite_get_bbox_left(_spr),_uvs[4]),
                    _y1=max(sprite_get_bbox_top(_spr),_uvs[5]),
                    _x2=min(sprite_get_bbox_right(_spr)+1,_uvs[4]+_uvs[6]*sprite_get_width(_spr)),
                    _y2=min(sprite_get_bbox_bottom(_spr)+1,_uvs[5]+_uvs[7]*sprite_get_height(_spr)),
                    _spent=1-_state.time/_state.time_max
                if(!_state.flash) gpu_set_fog(true,_state.color2,0,0)
                for(var _dir=0;_dir<360;_dir+=90)
                    draw_sprite(_spr,_img,_x+lengthdir_x(1,_dir),_y+lengthdir_y(1,_dir))
                if(!_state.flash) gpu_set_fog(true,_state.color1,0,0)
                for(var _dir=0;_dir<360;_dir+=90) {
                    var _dx=lengthdir_x(1,_dir),_dy=lengthdir_y(1,_dir),
                        _top=max(_y1,lerp(_y1-1,_y2+1,_spent)-_dy),_height=_y2+1-_top
                    if(_x2>_x1 && _height>0) draw_sprite_part(_spr,_img,_x1,_top,_x2-_x1,_height,
                        _x+_x1-sprite_get_xoffset(_spr)+_dx,_y+_top-sprite_get_yoffset(_spr)+_dy)
                }
                if(_state.star_scale>0) {
                    var _wave=current_frame+ds_list_find_index(GameCont.skills,_skill)*1000,
                        _scale=max(0,(1.1+0.1*sin(_wave/15))*_state.star_scale)
                    draw_sprite_ext(scrNTTERefSprite("PetOrchidBall"),_wave,_x,_y,_scale,_scale,_wave/10,c_white,1)
                }
                if(!_state.flash) gpu_set_fog(_fog)
            }
        }
        draw_sprite(_spr,_img,_x,_y)
        gpu_set_fog(_fog)
        if(scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined)==_skill)
            draw_sprite(scrNTTERefSprite("SkillRerollHUDSmall"),0,_x+((_skill==scrNTTEFullOrchidPatience())?-4:5),_y+5)
    }
    finally {gpu_set_fog(_fog)}
}
