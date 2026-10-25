// parrot.race.gml 605..827, translated into the native player/input model.
function scrNTTEFullParrotGameStart() {
    feather_ammo_get+=feather_num
    if(!variable_instance_exists(id,"ntte_pet")) ntte_pet=[]
    var _pet=scrNTTEFullPetCreate(x,y,"Parrot")
    _pet.leader=id; _pet.visible=false; _pet.persistent=true; _pet.stat_found=false
    scrNTTEFullPetSetSkin(_pet,bskin); array_push(ntte_pet,_pet)
}
function scrNTTEFullParrotPlayerStep() {
    if(race!=NTTEFullRace.Parrot) return;
    while(feather_ammo_get>0) {
        feather_ammo_get-=1
        var _f=scrNTTEFullParrotFeatherNew(x+orandom(16),y+orandom(16),id,id)
        _f.speed*=3
    }
    if(can_spec && scrNTTEFullPlayerActive(id)) {
        var _self=id,_limit=scrNTTEFullRaceUltraGet(id,1) ? feather_ammo_max:feather_num,_feathers=[],_all_returning=true
        with(NTTEFullParrotFeather) if(index==_self.index && (creator==_self || creator==noone)) {
            array_push(_feathers,id)
            if(target!=_self) _all_returning=false
        }
        var _held=KeyCont.hold_spec[index],_press=_held && (KeyCont.press_spec[index] || (array_length(_feathers)>0 && _all_returning))
        if(_press || !_held) {
            if(_press && array_length(_feathers)<_limit) {
                with(NTTEFullParrotFeather) if(index== -1 && creator==_self && target==_self && array_length(_feathers)<_limit) {
                    index=_self.index; array_push(_feathers,id)
                }
            }
            var _recalled=[]
            for(var _i=0;_i<array_length(_feathers);++_i) with(_feathers[_i]) {
                if(stick) {
                    if(array_get_index(_recalled,target)<0) array_push(_recalled,target)
                    stick=false; stick_wait=3; motion_add(random(360),6*timescale)
                    var _charm=scrNTTEFullValue(target,"ntte_charm",undefined)
                    if(is_struct(_charm) && (_charm.time>=0 || _charm.feather)) {
                        _charm.time-=min(_charm.time,stick_time)
                        if(_charm.time<=0) {
                            var _snd=snd_play(sndBigMaggotUnburrowSand,random_range(1.2,1.4),2.5)
                            if(_snd>=0) audio_sound_set_track_position(_snd,0.7)
                            snd_play(sndNTTEOriginalPlantPower,random_range(1.3,1.4),1.2)
                        }
                    }
                }
                target=creator
            }
            // A recalled feather charm cannot outlive its last attached
            // feather. Reconcile residual time after all detachments, and
            // let the ordinary next Begin Step perform source uncharm FX.
            for(var _i=0;_i<array_length(_recalled);++_i) {
                var _target=_recalled[_i],_charm=scrNTTEFullValue(_target,"ntte_charm",undefined),_attached=false
                if(!is_struct(_charm) || !_charm.charmed || !_charm.feather || _charm.index!=index) continue
                with(NTTEFullParrotFeather) if(stick && target==_target) {_attached=true;break;}
                if(!_attached) _charm.time=0
            }
        }
        if(_held) {
            var _targets=[],_aimx=x+lengthdir_x(192,gunangle),_aimy=y+lengthdir_y(192,gunangle)
            with(enemy) if(team!=_self.team && size<6 && mask_index!=mskNone
                && x>=view_xview-16 && y>=view_yview-16 && x<=view_xview+game_screen_width+16 && y<=view_yview+game_screen_height+16) array_push(_targets,id)
            with(FrogEgg) if(team!=_self.team && size<6 && mask_index!=mskNone
                && x>=view_xview-16 && y>=view_yview-16 && x<=view_xview+game_screen_width+16 && y<=view_yview+game_screen_height+16 && array_get_index(_targets,id)<0) array_push(_targets,id)
            for(var _i=0;_i<array_length(_feathers);++_i) if(_feathers[_i].target!=id) {
                var _index=array_get_index(_targets,_feathers[_i].target)
                if(_index>=0) _targets[_index]=noone
            }
            array_sort(_feathers,false)
            var _owned=[]
            for(var _i=0;_i<array_length(_feathers);++_i) if(_feathers[_i].creator==id && array_length(_owned)<_limit) array_push(_owned,_feathers[_i])
            _feathers=_owned
            if(_press && feather_ammo>0 && array_length(_feathers)<_limit) {
                var _tx=x,_ty=y,_count=0,_best=infinity
                for(var _i=0;_i<array_length(_targets);++_i) if(instance_exists(_targets[_i])) {
                    var _t=_targets[_i],_bx=clamp(_aimx,_t.bbox_left,_t.bbox_right+1),_by=clamp(_aimy,_t.bbox_top,_t.bbox_bottom+1)
                    var _dis=point_distance(_aimx,_aimy,_bx,_by)
                    if(_dis<_best) { _best=_dis; _tx=_t.x; _ty=_t.y }
                }
                while(feather_ammo>0 && array_length(_feathers)<_limit) {
                    feather_ammo-=1
                    var _f=scrNTTEFullParrotFeatherNew(((_count%3)==0 ? _tx:x)+orandom(4),((_count%3)==0 ? _ty:y)+orandom(4),id,id,index)
                    array_push(_feathers,_f); _count+=1
                }
                if(_count>0) snd_play(sndSharpTeeth,3+random(3),0.4)
            }
            if(array_length(_feathers)>0) {
                var _ordered=[]
                for(var _i=0;_i<array_length(_targets);++_i) if(instance_exists(_targets[_i])) {
                    var _t=_targets[_i]
                    var _dis=point_distance(_aimx,_aimy,clamp(_aimx,_t.bbox_left,_t.bbox_right+1),clamp(_aimy,_t.bbox_top,_t.bbox_bottom+1))
                    array_push(_ordered,[_t,_dis])
                }
                array_sort(_ordered,function(_a,_b) { return sign(_a[1]-_b[1]) })
                var _ready=[]
                for(var _i=0;_i<array_length(_feathers);++_i) if(_feathers[_i].target==id) array_push(_ready,_feathers[_i])
                array_sort(_ready,false)
                for(var _group=0;_group<_limit/feather_num;++_group) {
                    var _target=_group<array_length(_ordered) ? _ordered[_group][0]:id
                    for(var _i=_group*feather_num;_i<min((_group+1)*feather_num,array_length(_ready));++_i) {
                        _ready[_i].target=_target; _ready[_i].stick_wait=max(_ready[_i].stick_wait,3)
                    }
                }
            } else if(KeyCont.press_spec[index]) snd_play(sndMutant0Cnfm,3+orandom(0.2),2)
        }
    }
    if(hp<=0 && can_die && feather_ammo>0) repeat(feather_ammo) {
        var _f=instance_create(x,y,Feather)
        _f.image_blend=c_gray; _f.sprite_index=scrNTTEFullRaceSprite(race,"Feather",bskin,sprChickenFeather)
    }
}
// parrot.ntte_end_step: restore half of received damage using feathered
// allies' health, with original shuffle/remainder and low-health limits.
function scrNTTEFullParrotFlockEnd() {
    if(race!=NTTEFullRace.Parrot) return;
    var _allies=[],_self=id
    if(scrNTTEFullRaceUltraGet(id,2) && variable_instance_exists(GameCont,"ntte_charm_instance_list")) {
        var _list=GameCont.ntte_charm_instance_list
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) {
            var _inst=_list[_i],_vars=scrNTTEFullValue(_inst,"ntte_charm",undefined)
            if(scrNTTEFullValue(_inst,"hp",0)>0 && is_struct(_vars) && _vars.charmed && _vars.index==index) array_push(_allies,_inst)
        }
        var _count=array_length(_allies)
        if(_count>0) {
            if(sprite_index==spr_hurt && hp<ntte_charm_flock_hp) {
                ntte_charm_flock_hp=ceil(lerp(ntte_charm_flock_hp,hp,0.5))
                for(var _i=_count-1;_i>0;--_i) { var _j=irandom(_i),_swap=_allies[_i]; _allies[_i]=_allies[_j]; _allies[_j]=_swap }
                var _raw=(ntte_charm_flock_hp-hp)/_count
                for(var _i=0;_i<_count;++_i) {
                    var _damage=(_i/_count<frac(_raw)) ? ceil(_raw):floor(_raw)
                    if(_damage>0) {
                        var _ally=_allies[_i]
                        hp+=min(_damage,max(0,_ally.hp))
                        scrNTTEFullRawHit(_ally,_damage,1)
                        if(!instance_exists(_ally) || _ally.hp<=0) _allies[_i]=noone
                    }
                }
            }
            ntte_charm_flock_hud_hp=0; ntte_charm_flock_hud_hp_max=0
            for(var _i=0;_i<array_length(_allies);++_i) if(instance_exists(_allies[_i])) {
                ntte_charm_flock_hud_hp+=_allies[_i].hp; ntte_charm_flock_hud_hp_max+=_allies[_i].max_hp
            }
        } else ntte_charm_flock_hud_hp=0
    } else ntte_charm_flock_hud_hp=0
    ntte_charm_flock_hp=hp
    if(ntte_charm_flock_hud_hp!=ntte_charm_flock_hud_hp_lst) ntte_charm_flock_hud_hp_lst+=clamp(ntte_charm_flock_hud_hp-ntte_charm_flock_hud_hp_lst,-0.5*timescale,0.5*timescale)
    ntte_charm_flock_hud_hp_lst=clamp(ntte_charm_flock_hud_hp_lst,ntte_charm_flock_hud_hp,ntte_charm_flock_hud_hp_max)
    var _hud=ntte_charm_flock_hud_hp>0 ? 1:0
    if(ntte_charm_flock_hud!=_hud) {
        if(abs(_hud-ntte_charm_flock_hud)>0.01) _hud=lerp(ntte_charm_flock_hud,_hud,1-power(2/3,timescale))
        ntte_charm_flock_hud=_hud
    }
}

function scrNTTEFullParrotFlockTests() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0)
    var _saved={race:_p.race,ultra:scrNTTEFullValue(_p,"ntte_race_ultra",0),hp:_p.hp,max_hp:_p.max_hp,
        sprite:_p.sprite_index,image:_p.image_index,next:_p.nexthurt}
    var _old_list=scrNTTEFullValue(GameCont,"ntte_charm_instance_list",[]),_old_vars=scrNTTEFullValue(GameCont,"ntte_charm_instance_vars",[])
    _p.race=NTTEFullRace.Parrot; _p.ntte_race_ultra=2; _p.hp=12; _p.max_hp=12
    with(_p) scrNTTEFullRaceCreate()
    GameCont.ntte_charm_instance_list=[]; GameCont.ntte_charm_instance_vars=[]
    var _one=instance_create(68336,68016,Bandit),_two=instance_create(68400,68016,NTTEBat)
    _one.hp=10; _one.max_hp=10; _two.hp=10; _two.max_hp=10
    var _vars=scrNTTEFullParrotCharm(_one,true); _vars.index=_p.index
    _vars=scrNTTEFullParrotCharm(_two,true); _vars.index=_p.index
    var _foreign=instance_create(68464,68016,Bandit)
    _foreign.hp=20; _foreign.max_hp=20
    _vars=scrNTTEFullParrotCharm(_foreign,true); _vars.index=_p.index+1
    _p.hp=6; _p.sprite_index=_p.spr_hurt
    var _stress=_two.ntte_bat_stress
    with(GameCont) event_perform(ev_step,ev_step_end)
    assert(_p.hp==9 && _one.hp+_two.hp==17 && _foreign.hp==20,
        "Parrot Flock real end-step hook lost half-damage rounding, remainder or owner filtering")
    assert(_two.ntte_bat_stress==_stress+10-_two.hp && _p.ntte_charm_flock_hp==9
        && _p.ntte_charm_flock_hud_hp==17 && _p.ntte_charm_flock_hud_hp_max==20,
        "Parrot Flock bypassed custom ally hurt or counted another player's allies")
    var _health=_one.hp+_two.hp
    with(_p) scrNTTEFullParrotFlockEnd()
    assert(_p.hp==9 && _one.hp+_two.hp==_health,"Parrot Flock paid the same received damage twice")
    _p.ntte_charm_flock_hp=12; _p.hp=6; _p.sprite_index=_p.spr_idle
    with(_p) scrNTTEFullParrotFlockEnd()
    assert(_p.hp==6 && _one.hp+_two.hp==_health,"Parrot Flock restored non-hurt health costs")
    _one.hp=1; _two.hp=1; _p.ntte_charm_flock_hp=12; _p.hp=4; _p.sprite_index=_p.spr_hurt
    with(_p) scrNTTEFullParrotFlockEnd()
    assert(_p.hp==6 && _one.hp<=0 && _two.hp<=0 && _p.ntte_charm_flock_hud_hp==0,
        "Parrot Flock created extra HP from dying allies or retained their HUD health")
    _p.ntte_race_ultra=0; _p.hp=4; _p.ntte_charm_flock_hp=12
    with(_p) scrNTTEFullParrotFlockEnd()
    assert(_p.hp==4 && _p.ntte_charm_flock_hud_hp==0,"Parrot Flock activated without Ultra B")
    _p.race=_saved.race; _p.ntte_race_ultra=_saved.ultra; _p.hp=_saved.hp; _p.max_hp=_saved.max_hp
    _p.sprite_index=_saved.sprite; _p.image_index=_saved.image; _p.nexthurt=_saved.next
    GameCont.ntte_charm_instance_list=_old_list; GameCont.ntte_charm_instance_vars=_old_vars
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS PARROT FLOCK: actual global end-step dispatch, exact half-damage/remainder, owner filter, custom Bat raw hurt, one-shot accounting, hurt-only gate, low-health ally cap/death and Ultra B gate OK")
}
