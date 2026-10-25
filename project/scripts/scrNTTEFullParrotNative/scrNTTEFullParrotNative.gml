// Original parrot.race.gml::ParrotChester and tepikcups setup callbacks.
// The watcher survives destruction of its source just long enough to inspect
// the real ChestOpen/SmallChestPickup effect, so vanished/expired loot gives
// no feathers. A real player still receives physical, homing feathers.
function scrNTTEFullParrotChestWatch(_source,_small=false,_num=undefined) {
    if(!instance_exists(_source)) return noone
    if(_small && _source.mask_index!=mskPickup) return noone
    if(variable_instance_exists(_source,"ntte_parrot_chester") && instance_exists(_source.ntte_parrot_chester)) return _source.ntte_parrot_chester
    var _watch=instance_create(_source.x,_source.y,NTTEFullParrotChester)
    _watch.creator=_source; _watch.small=_small
    if(is_undefined(_num)) {
        if(_small) _num=ceil(scr_skill_get(mut_throne_butt))
        else {
            _num=6
            switch(_source.object_index) {
                case WeaponChest:if(scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)>0) _num*=2; break
                case AmmoChest:
                case AmmoChestMystery:if(scr_ultra_get(Race.Steroids,UltraSkill.GetLoaded)>0) _num*=2; break
                case IDPDChest:_num*=2; break
                case BigWeaponChest:
                case CursedBigChest:_num*=3; break
                case GiantWeaponChest:
                case GiantAmmoChest:_num*=6; break
            }
        }
    }
    _watch.num=_num
    _source.ntte_parrot_chester=_watch
    return _watch
}
function scrNTTEFullParrotChesterCreate() {
    creator=noone; small=false; num=6; ntte_reward_done=false; ntte_reward_sounds=[]
}
function scrNTTEFullParrotChesterStep() {
    if(!ntte_reward_done) {
        if(instance_exists(creator)) { x=creator.x; y=creator.y; return }
        ntte_reward_done=true
        if(num>0 && position_meeting(x,y,small ? SmallChestPickup:ChestOpen)) {
            var _targets=[]
            // Ordinary chests reward every Parrot in co-op. Small pickups
            // reward only their nearest collecting player, unless portaled.
            if(small && !place_meeting(x,y,Portal)) {
                var _p=instance_nearest(x,y,Player)
                if(instance_exists(_p) && _p.race==NTTEFullRace.Parrot) array_push(_targets,_p)
            } else with(Player) if(race==NTTEFullRace.Parrot) array_push(_targets,id)
            for(var _t=0;_t<array_length(_targets);++_t) {
                var _target=_targets[_t]
                for(var _i=0;_i<num;++_i) {
                    var _f=scrNTTEFullParrotFeatherNew(x,y,_target,_target)
                    _f.stick_wait=3; _f.speed*=max(1,power(max(0,num-6),1/5))
                    array_push(ntte_reward_sounds,_i*(4/num)+irandom(irandom(1)))
                }
            }
        }
    }
    for(var _i=array_length(ntte_reward_sounds)-1;_i>=0;--_i) {
        if(ntte_reward_sounds[_i]<=0) {
            snd_play(sndBouncerSmg,3+random(0.2),0.2+random(0.1))
            array_delete(ntte_reward_sounds,_i,1)
        } else ntte_reward_sounds[_i]-=timescale
    }
    if(array_length(ntte_reward_sounds)==0) instance_destroy()
}
// The native HUD starts17pixels to the right of NTT's original 5px HP bar.
// All authored spacing, group ordering, fills and exact source sprites remain.
function scrNTTEFullParrotHUD(_p) {
    if(scrNTTEFullValue(_p,"race",-1)!=NTTEFullRace.Parrot) return;
    var _font=draw_get_font(),_halign=draw_get_halign(),_valign=draw_get_valign(),_color=draw_get_color()
    var _feathers=[],_targets=[],_fill=array_create(ceil(_p.feather_ammo_max/_p.feather_num),0)
    with(NTTEFullParrotFeather) if(index==_p.index && (creator==_p || creator==noone)) array_push(_feathers,id)
    for(var _f=0;_f<array_length(_feathers);++_f) {
        var _feather=_feathers[_f],_pos=array_get_index(_targets,_feather.target)
        if(_pos<0) {
            _pos=array_length(_targets)
            if(_feather.target==_p) {
                while(_pos<array_length(_fill) && _fill[_pos]>=_p.feather_num) _pos+=1
            } else if(_pos<array_length(_fill)) {
                array_push(_targets,_feather.target)
                for(var _j=array_length(_fill)-1;_j>_pos;--_j) _fill[_j]=_fill[_j-1]
                _fill[_pos]=0
            }
        }
        if(_pos<array_length(_fill)) _fill[_pos]+=1
    }
    var _active=instance_exists(_p) && KeyCont.hold_spec[_p.index] && _p.can_spec && scrNTTEFullPlayerActive(_p)
    var _sprite=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"FeatherHUD",_p.bskin)
    for(var _i=0;_i<array_length(_fill);++_i) {
        var _ammo=clamp(((_p.feather_ammo+array_length(_feathers))/_p.feather_num)-_i,0,1)
        var _amount=clamp(_fill[_i]/_p.feather_num,0,1),_x=116+5*_i,_y=11
        if((_ammo>0 && (_i<1 || scrNTTEFullRaceUltraGet(_p,1))) || _amount>0) {
            _x-=1
            if((!_active || _amount<=0) && _ammo>_amount) { _amount=_ammo; _y+=1 }
        }
        draw_set_color(c_white); draw_sprite(_sprite,0,_x,_y)
        if(_ammo>_amount) draw_sprite_ext(_sprite,lerp(1,sprite_get_number(_sprite)-1,_ammo),_x,_y,1,1,0,make_color_hsv(178,85,153),1)
        if(_amount>0) draw_sprite(_sprite,lerp(1,sprite_get_number(_sprite)-1,_amount),_x,_y)
    }
    if(_p.ntte_charm_flock_hud>0) scrNTTEFullParrotFlockHUD(_p)
    draw_set_font(_font); draw_set_halign(_halign); draw_set_valign(_valign); draw_set_color(_color)
}
function scrNTTEFullParrotFlockHUD(_p) {
    var _hp=max(0,_p.hp),_max=max(0,_p.max_hp),_last=max(0,_p.lsthealth)
    var _chp=max(0,_p.ntte_charm_flock_hud_hp),_cmax=max(0,_p.ntte_charm_flock_hud_hp_max),_clast=max(0,_p.ntte_charm_flock_hud_hp_lst)
    var _color=scrNTTEFullValue(scr_playerinstance_find(_p.index),"color",c_red)
    if(!_color) _color=make_color_rgb(191,22,46)
    var _charm=make_color_hsv(color_get_hue(_color),min(255,color_get_saturation(_color)*1.5),color_get_value(_color)*2/3)
    var _x=22,_y=7,_w=83,_h=7,_portion=floor(_w*0.35*_p.ntte_charm_flock_hud)
    draw_set_halign(fa_center); draw_set_valign(fa_middle)
    draw_set_color(c_black); draw_rectangle(_x,_y,_x+_w,_y+_h,false)
    var _x1=_x,_x2=_x+_portion-1
    if(_x1<_x2) {
        if(_clast>_chp && _cmax>0) {
            draw_set_color(merge_color(_charm,make_color_rgb(21,27,42),2/3))
            draw_rectangle(_x1,_y,lerp(_x1,_x2,clamp(_clast/_cmax,0,1)),_y+_h,false)
        }
        if(_chp>0 && _cmax>0) {
            draw_set_color(_clast!=_chp ? c_white:_charm)
            draw_rectangle(_x1,_y,lerp(_x1,_x2,clamp(_chp/_cmax,0,1)),_y+_h,false)
        }
        var _text="+"+string(_chp)
        draw_set_font(fntM1); if(string_width(_text)>=_x2-_x1) draw_set_font(fntSmall)
        draw_set_color(c_white); scrNTTEFullDrawText(ceil(lerp(_x1,_x2,0.5)),_y+1+floor(_h/2),_text)
    }
    _x1=_x+_portion+1; _x2=_x+_w
    if(_x1<_x2) {
        if(_last>_hp && _max>0) {
            draw_set_color(merge_color(_color,make_color_rgb(21,27,42),2/3))
            draw_rectangle(_x1,_y,lerp(_x1,_x2,clamp(_last/_max,0,1)),_y+_h,false)
        }
        if(_hp>0 && _max>0) {
            var _hurt=instance_exists(_p) && _p.sprite_index==_p.spr_hurt && _p.image_index<1 && !instance_exists(Portal)
            draw_set_color(((_hurt || _last<_hp) && scrNTTEFullPlayerActive(_p)) ? c_white:_color)
            draw_rectangle(_x1,_y,lerp(_x1,_x2,clamp(_hp/_max,0,1)),_y+_h,false)
        }
        if(_last>=_hp || sin(_p.wave)>0) {
            var _text=string(_hp)+"/"+string(_max)
            draw_set_font(fntM1); if(string_width(_text)>=_x2-_x1) draw_set_font(fntSmall)
            draw_set_color(c_white); scrNTTEFullDrawText(ceil(lerp(_x1,_x2,0.5))+round(4*(1-_p.ntte_charm_flock_hud)),_y+1+floor(_h/2),_text)
        }
    }
    draw_set_color(c_white); draw_line_width(_x+_portion,_y-2,_x+_portion,_y+_h,1)
}
function scrNTTEFullParrotChestTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all)
    var _old={x:_p.x,y:_p.y,race:_p.race,skin:_p.bskin,ultra:scrNTTEFullValue(_p,"ntte_race_ultra",0)}
    _p.x=78000; _p.y=78000; _p.race=NTTEFullRace.Parrot; _p.bskin=1; _p.ntte_race_ultra=0
    var _chest=instance_create(_p.x,_p.y,chestprop),_watch=scrNTTEFullParrotChestWatch(_chest)
    assert(instance_exists(_watch) && _watch.creator==_chest && _watch.num==6 && !_watch.small,
        "Parrot ordinary chest watcher/source amount")
    assert(scrNTTEFullParrotChestWatch(_chest)==_watch,"Parrot attached duplicate chest watchers")
    _chest.x+=11; _chest.y-=7
    with(_watch) scrNTTEFullParrotChesterStep()
    assert(_watch.x==_chest.x && _watch.y==_chest.y,"Parrot chest watcher does not follow its actual moving source")
    var _cx=_chest.x,_cy=_chest.y
    instance_destroy(_chest,false)
    var _open=instance_create(_cx,_cy,ChestOpen)
    // Native ChestOpen has no default sprite: real chest collisions assign
    // their spr_dead after creation. Reproduce that actual open-effect mask.
    _open.sprite_index=sprHealthChestOpen
    var _feather_before=scrNTTEFullInstances(NTTEFullParrotFeather)
    with(_watch) scrNTTEFullParrotChesterStep()
    var _feathers=scrNTTEFullInstances(NTTEFullParrotFeather),_num=0
    for(var _i=0;_i<array_length(_feathers);++_i) if(array_get_index(_feather_before,_feathers[_i])<0 && _feathers[_i].creator==_p) {
        _num+=1
        assert(_feathers[_i].target==_p && _feathers[_i].bskin==1 && _feathers[_i].stick_wait==3,
            "Parrot chest feathers lost actual recipient, B-skin or pickup delay")
    }
    assert(_num==6,"Parrot opened ordinary chest did not issue exactly six physical feathers per Parrot")
    if(instance_exists(_watch)) with(_watch) scrNTTEFullParrotChesterStep()
    assert(instance_number(NTTEFullParrotFeather)==array_length(_feathers),"Parrot chest watcher paid reward twice")
    instance_destroy(_open,false)
    var _expired=instance_create(_p.x+300,_p.y,chestprop)
    _watch=scrNTTEFullParrotChestWatch(_expired); instance_destroy(_expired,false)
    var _count=instance_number(NTTEFullParrotFeather)
    with(_watch) scrNTTEFullParrotChesterStep()
    assert(!instance_exists(_watch) && instance_number(NTTEFullParrotFeather)==_count,
        "Parrot expired/vanished chest incorrectly rewarded feathers")
    var _pickup=instance_create(_p.x,_p.y,HPPickup)
    _watch=scrNTTEFullParrotChestWatch(_pickup,true)
    _watch.num=2
    assert(_watch.small,"Parrot ThroneButt pickup did not create a small-effect watcher")
    instance_destroy(_pickup,false)
    var _fx=instance_create(_p.x,_p.y,SmallChestPickup)
    _count=instance_number(NTTEFullParrotFeather)
    with(_watch) scrNTTEFullParrotChesterStep()
    assert(instance_number(NTTEFullParrotFeather)==_count+2,"Parrot nearby pickup did not grant its actual ThroneButt feather count")
    instance_destroy(_fx,false)
    // A pickup collected by another character must not send its reward to a
    // more distant Parrot, unlike a full chest's shared co-op reward.
    _pickup=instance_create(_p.x+100,_p.y,HPPickup)
    _watch=scrNTTEFullParrotChestWatch(_pickup,true); _watch.num=2
    var _other=instance_create(_pickup.x,_pickup.y,Player)
    _other.race=Race.Fish
    instance_destroy(_pickup,false)
    _fx=instance_create(_other.x,_other.y,SmallChestPickup)
    _count=instance_number(NTTEFullParrotFeather)
    with(_watch) scrNTTEFullParrotChesterStep()
    assert(instance_number(NTTEFullParrotFeather)==_count,"Parrot stole another character's small-pickup feathers")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
    _p.x=_old.x; _p.y=_old.y; _p.race=_old.race; _p.bskin=_old.skin; _p.ntte_race_ultra=_old.ultra
    scrNTTESmokeLog("SYSTEMS PARROT CHESTS: real source tracking/open detection, exact physical feather rewards, skin/owner, no double payout/expiry reward and nearest small-pickup ownership OK")
}

// BEGIN PARROT ABILITY TOGGLE INPUT
// All physical inputs share the native latch, feather AI and HUD hold_spec.
function scrNTTEFullParrotToggleInput(_index) {
    var _pinst=scr_playerinstance_find(_index),_p=noone
    with(Player) if(index==_index) _p=id
    if(scrNTTEFullMountedAbilityRaw(_p)) { KeyCont.activeforever[_index]=false;return; }
    if(!instance_exists(_p) || is_undefined(_pinst) || _p.race!=NTTEFullRace.Parrot || !scr_player_pref(_pinst,"parrot")) return;
    var _press=KeyCont.press_spec[_index],_active=KeyCont.activeforever[_index]
    if(!scrGameIsPaused() && _press) {
        _active=!_active;KeyCont.activeforever[_index]=_active
    }
    KeyCont.hold_spec[_index]=_active
    KeyCont.press_spec[_index]=_press && _active && !scrGameIsPaused()
    KeyCont.release_spec[_index]=_press && !_active && !scrGameIsPaused()
}
