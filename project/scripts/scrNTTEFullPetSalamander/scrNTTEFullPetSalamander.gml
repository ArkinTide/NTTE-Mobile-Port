function scrNTTEFullPetSalamanderImpactSmoke(_x,_y) {
    repeat(5) with(scrNTTEFullPetEffect(_x,_y,[direction+orandom(20),4],Smoke)) friction*=2
}
function scrNTTEFullPetSalamanderWallBonkSmoke(_x,_y) {
    with(scrNTTEFullNearestBBox(_x,_y,Wall)) {
        var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
        var _dir=point_direction(_cx,_cy,_x,_y)
        repeat(5) with(scrNTTEFullPetEffect(_cx+lengthdir_x(8,_dir),_cy+lengthdir_y(8,_dir),[_dir,random_range(3,4)],Smoke)) {
            image_index=irandom(image_number-1)
            image_xscale/=1.5;image_yscale/=1.5;friction*=3;depth=-4
        }
    }
}

function scrNTTEFullPetSalamanderChargeSpark() {
    var _spark=scrNTTEFullPetEffect([x-13*right*image_xscale,2*image_xscale],y+random(4*image_yscale),random(random(1)),FireFly)
    if(instance_exists(_spark)) { _spark.sprite_index=scrNTTERefSprite("FlameSpark"); _spark.depth=depth-1 }
}
// Source petlib.Salamander (1360..1907). Native input/speed/HP adapters are
// explicit: raw controller input is saved before the native active is masked.
function scrNTTEFullPetEffect(_x,_y,_motion,_object) {
    with(instance_create(
        (is_array(_x) ? (_x[0]+orandom(_x[1])) : _x),
        (is_array(_y) ? (_y[0]+orandom(_y[1])) : _y),
        _object)) {
        var _face=(image_angle==direction || (speed==0 && (object_index==AcidStreak || object_index==BloodStreak)))
        if(is_array(_motion)) motion_add(_motion[0],_motion[1]*timescale)
        else motion_add(random(360),_motion*timescale)
        if(_face) image_angle=direction
        return id
    }
    return noone
}
function scrNTTEFullPetSalamanderCreate() {
    spr_idle=scrNTTERefSprite("PetSalamanderIdle"); spr_walk=scrNTTERefSprite("PetSalamanderWalk")
    spr_hurt=scrNTTERefSprite("PetSalamanderHurt"); spr_chrg=scrNTTERefSprite("PetSalamanderChrg")
    spr_icon=scrNTTERefSprite("PetSalamanderIcon"); spr_shadow_y=-2; depth=-3; mask_index=mskAlly
    dash=false; dash_max=3; dash_add=dash_max/20; dash_charge=0; dash_charging=false
    dash_direction=direction; right_delay=0; mount=false; mount_y=0; prompt_mount_time=-1
    prompt_mount_text=["MOUNT","DISMOUNT"]
    prompt_mount=scrNTTEFullPromptCreate(id,prompt_mount_text[0]); prompt_mount.depth=1
    prompt_mount.image_xscale=2; prompt_mount.image_yscale=2
    prompt_mount.on_meet=method(prompt_mount,function(_player) {
        return creator==_player || (instance_exists(creator) && scrNTTEFullValue(creator,"leader",noone)==_player)
    })
    stat.tossed=scrNTTEFullValue(stat,"tossed",0)
    hooks={anim:method(id,scrNTTEFullPetSalamanderAnim),step:method(id,scrNTTEFullPetSalamanderStep),alarm:method(id,scrNTTEFullPetSalamanderAlarm),cleanup:method(id,scrNTTEFullPetSalamanderCleanup),endstep:method(id,scrNTTEFullPetSalamanderEndStep)}
}
function scrNTTEFullPetSalamanderAnim() {
    if(dash_charge>0 && !dash) {
        sprite_index=dash_charge<dash_max ? spr_chrg:spr_hurt
        if(dash_charge<dash_max) image_index=sprite_get_number(spr_chrg)*(dash_charge/dash_max)
    } else sprite_index=speed>0 ? spr_walk:spr_idle
}
function scrNTTEFullPetSalamanderRider(_player) {
    var _rider=noone
    with(NTTEFullPet) if(pet=="Salamander" && mount && leader==_player && visible && portal_angle==0) _rider=id
    return _rider
}
function scrNTTEFullPetSalamanderPlayerBegin() {
    var _pet=scrNTTEFullPetSalamanderRider(id)
    if(!instance_exists(_pet)) return;
    // Suppress all native direct-button paths as well as scrPowers. Merely
    // setting can_spec leaves Crystal/Steroids/Fish direct paths active.
    ntte_salamander_input={hold:KeyCont.hold_spec[index],press:KeyCont.press_spec[index],can:can_spec,pet:_pet}
    _pet.ntte_spec_hold=ntte_salamander_input.hold; _pet.ntte_spec_press=ntte_salamander_input.press
    _pet.ntte_spec_frame=current_frame
    can_spec=false; KeyCont.hold_spec[index]=false; KeyCont.press_spec[index]=false
}
// Restore only the masked input on early native exits. Running the full End
// adapter during faint/visibility locks would also apply mounted dash motion.
function scrNTTEFullPetSalamanderPlayerRestoreInput() {
    var _input=scrNTTEFullValue(id,"ntte_salamander_input",undefined)
    if(!is_struct(_input)) return undefined;
    KeyCont.hold_spec[index]=_input.hold; KeyCont.press_spec[index]=_input.press; can_spec=_input.can
    ntte_salamander_input=undefined
    return _input;
}
function scrNTTEFullPetSalamanderPlayerEnd() {
    var _input=scrNTTEFullPetSalamanderPlayerRestoreInput()
    if(!is_struct(_input)) return;
    var _pet=_input.pet
    if(instance_exists(_pet) && _pet.mount && _pet.leader==id) {
        if(_pet.dash) {
            direction=angle_lerp(direction,_pet.dash_direction,1-power(0.8,timescale))
            speed=friction+maxspeed+(2+2*_pet.dash_charge)*timescale
            nexthurt=max(nexthurt,current_frame+6)
            angle=1.5*(hspeed/timescale)*-clamp((vspeed/timescale+1)/2,-1,1)
        } else if(_pet.dash_charge>0) speed=clamp(speed,timescale,2*timescale)
        if(sprite_index==spr_walk) sprite_index=spr_idle
        friction=(speed<maxspeed ? 0.45:0.2)*timescale*timescale
    }
}
function scrNTTEFullPetSalamanderToggleMount() {
    mount=!mount; mount_y=0; prompt_mount_time=mount ? 0:-1
    if(instance_exists(prompt_mount)) {
        prompt_mount.text=prompt_mount_text[mount]; prompt_mount.creator=mount ? leader:id
        prompt_mount.pick=-1
    }
    if(instance_exists(leader)) {
        if(mount) { KeyCont.activeforever[leader.index]=false;with(ButtonActive) rogue_touch=-1; }
        leader.vspeed=-3*timescale
        if(mount) { leader.x=lerp(leader.x,x,0.5); leader.y=lerp(leader.y,y,0.5) }
    }
    repeat(3) {
        var _fx=scrNTTEFullPetEffect(x,y,1.5,Smoke)
        /* NTTE NATIVE EFFECT LIFETIME salamander-mount-smoke */ if(instance_exists(_fx)) {_fx.image_xscale/=1.2; _fx.image_yscale/=1.2 }
    }
    if(mount) {
        repeat(5) scrNTTEFullPetEffect(x,y,3,Dust)
        snd_play(sndSalamanderCharge,1.3+random(0.2)); snd_play(sndSalamanderFire,1+orandom(0.2),0.5)
    } else snd_play(sndSalamanderEndFire,1+random(0.2),1.2)
}
function scrNTTEFullPetSalamanderCombat(_mover) {
    var _pet=id,_range=8
    with(projectile) if(team!=_mover.team && scrNTTEFullValue(id,"typ",1)!=0 && damage>0 && mask_index!=mskNone
        && !instance_is(id,Grenade) && distance_to_object(_mover)<=_range) {
        var _px=x,_py=y
        with(_mover) {
            var _flame=scr_projectile_create(_px,_py,Flame,random(360),1)
            /* NTTE NATIVE EFFECT LIFETIME salamander-water-block-flame */ if(instance_exists(_flame)) {_flame.sprite_index=sprSalamanderBullet }
        }
        instance_create(x,y,Smoke); snd_play_hit(sndBurn,0.2); instance_destroy()
    }
    var _targets=ds_list_create()
    collision_rectangle_list(_mover.bbox_left+_mover.hspeed-6,_mover.bbox_top+_mover.vspeed-6,
        _mover.bbox_right+_mover.hspeed+6,_mover.bbox_bottom+_mover.vspeed+6,hitme,false,true,_targets,false)
    for(var _i=0;_i<ds_list_size(_targets);++_i) {
        var _target=_targets[| _i]
        if(!instance_exists(_target) || _target.team==_mover.team || _target.mask_index==mskNone) continue
        var _damage=10+ceil(10*dash_charge)
        scr_projectile_hit(_target,_damage,instance_is(_target,prop) ? 0:speed*2/3,direction)
        if(!instance_exists(_target)) continue
        if(_target.hp<=0 && _target.size>0 && !instance_is(_target,prop))
            snd_play(sndBigBanditMeleeHit,max(0.2,0.7-_target.size/10)+random(0.1),0.8)
        if(_target.hp>0) {
            if((1+_target.size>dash_charge && !instance_is(_target,prop)) || _target.max_hp>_damage) {
                sprite_index=spr_hurt; image_index=0
                dash_direction=point_direction(_target.x,_target.y,x,y); dash_charge=0
                _mover.direction=dash_direction; _mover.speed/=3
                scrNTTEFullPetSalamanderImpactSmoke(_target.x,_target.y)
            } else if(instance_is(_target,enemy) && (_target.size==1 || instance_is(_target,BanditBoss)) && _target.team!=team_player
                && random(12)<(_target.speed/timescale)*(1+0.5*scr_skill_get(mut_throne_butt))) {
                var _toss=instance_create(_target.x,_target.y,NTTEFullPalankingToss)
                _toss.direction=_target.direction; _toss.speed=_target.speed; _toss.zspeed=5; _toss.zfriction=2/3
                _toss.creator=_target; _toss.depth=_target.depth; _toss.mask_index=_target.mask_index
                _toss.spr_shadow_y=scrNTTEFullValue(_target,"spr_shadow_y",0)
                _toss.explo=scr_skill_get(mut_throne_butt); _toss.team=_mover.team
                with(_target) {
                    if(!place_meeting(x+lengthdir_x(96,direction),y+lengthdir_y(96,direction),Floor)) _toss.speed/=10
                    hp=max(hp,1); canfly=true
                    for(var _a=0;_a<12;++_a) alarm[_a]=-1
                }
                stat.tossed+=1
            }
        }
    }
    ds_list_destroy(_targets)
    with(_mover) if(place_meeting(x+hspeed,y+vspeed,Wall)) {
        var _last_speed=speed
        if(place_meeting(x+hspeed,y,Wall)) hspeed*=-0.1
        if(place_meeting(x,y+vspeed,Wall)) vspeed*=-0.1
        _pet.dash_direction=direction
        if(_pet.dash_charge>=1) {
            _pet.dash_charge=max(1,_pet.dash_charge-_pet.dash_add*4)
            scrNTTEFullPetSalamanderWallBonkSmoke(x,y)
            snd_play(sndSalamanderHurt,1.4+random(0.2),lerp(0.3,0.8,1-speed/max(0.001,_last_speed)))
        }
    }
}
function scrNTTEFullPetSalamanderStep() {
    var _prompt=prompt_mount
    if(instance_exists(_prompt)) {
        if((_prompt.pick>=0 && instance_exists(leader)) || (mount && !instance_exists(leader))) scrNTTEFullPetSalamanderToggleMount()
        if(prompt_mount_time>0) {
            prompt_mount_time=max(0,prompt_mount_time-timescale)
            if(prompt_mount_time<=2) {
                _prompt.text=prompt_mount_text[mount]
                if(prompt_mount_time>0) _prompt.text="@(color:"+string(merge_color(c_black,c_white,(prompt_mount_time-1)/2))+")"+_prompt.text
                else snd_play(sndSalamanderEndFire,1.5+orandom(0.1))
            }
        }
        _prompt.visible=prompt_mount_time!=0 && instance_exists(leader)
        if(prompt_mount_time==0 && instance_exists(leader) && leader.can_pick && KeyCont.press_pick[leader.index]
            && !instance_exists(scrNTTEFullPromptWinner(leader))) {
            var _near_weapon=false
            with(leader) _near_weapon=place_meeting(x,y,WepPickup)
            if(!_near_weapon) { prompt_mount_time=40; snd_play(sndAppear,1+orandom(0.1),0.8) }
        }
    }
    var _mover=mount && instance_exists(leader) ? leader:id
    if((dash_charge>0 || dash_charging) && portal_angle==0) {
        var _before=dash_charge
        dash_charge=min(dash_charge+dash_add*(dash_charging ? 1:-1)*timescale,dash_max)
        if(dash) {
            _mover.direction=angle_lerp(_mover.direction,dash_direction,1-power(0.8,timescale))
            var _max=instance_is(_mover,Player) ? _mover.maxspeed:maxspeed*timescale
            _mover.speed=_mover.friction+_max+(2+2*dash_charge)*timescale
            direction=_mover.direction; speed=_mover.speed
            if(instance_is(_mover,Player)) _mover.nexthurt=max(_mover.nexthurt,current_frame+6)
            scrNTTEFullPetSalamanderCombat(_mover)
            if(current_frame_active) {
                if(dash_charge<1) scrNTTEFullPetEffect(x,y,[direction+orandom(30),3],Smoke)
                else {
                    var _flame=scr_projectile_create(x,y,Flame,direction+orandom(20),random_range(3,4)); /* NTTE NATIVE EFFECT LIFETIME salamander-water-trail-flame */ if(instance_exists(_flame)) {_flame.sprite_index=sprSalamanderBullet }
                    if(irandom(4)==0) {
                        var _ground=instance_create(x+orandom(8),y+orandom(8),GroundFlame)
                        _ground.alarm[0]=25+random(15); _ground.image_blend=merge_color(_ground.image_blend,c_orange,random(0.25))
                    }
                }
            }
        } else {
            _mover.speed=clamp(_mover.speed,timescale,2*timescale); speed=_mover.speed
            if(instance_is(_mover,Player)) {
                if(KeyCont.moving[_mover.index]) dash_direction=angle_lerp(dash_direction,_mover.direction,1-power(0.5,timescale))
                else {
                    dash_direction=_mover.gunangle
                    _mover.direction=angle_lerp(_mover.direction,dash_direction+180,1-power(0.8,timescale)); direction=_mover.direction
                }
            }
            if(_before<dash_max) {
                snd_play(sndSalamanderEndFire,lerp(0.8,2,dash_charge/dash_max),1.4)
                if(dash_charge>=dash_max) snd_play(sndSalamanderCharge,1+orandom(0.05),1.8)
            } else if(!dash_charging) {
                dash=true; dash_charge=dash_max; direction=dash_direction; _mover.direction=direction
                scr_screenshake(dash_charge*5); snd_play(sndFiretrap,2+orandom(0.2),2)
            }
            if(random(12)<dash_charge*timescale) {
                if(random(3)<2) { var _fx=instance_create(x,y,Smoke); with(_fx) { motion_add(other.dash_direction+180,timescale); hspeed+=other.hspeed; vspeed+=other.vspeed } }
                scrNTTEFullPetSalamanderChargeSpark()
            }
        }
        if(dash_charge<=0) right_delay=max(right_delay,15)
    } else {
        if(dash) { dash=false; if(instance_exists(leader)) leader.angle=0 }
        dash_charge=0; dash_direction=direction
    }
    if(mount && instance_exists(leader) && portal_angle==0) {
        if(!dash) {
            var _hold=KeyCont.hold_spec[leader.index],_press=KeyCont.press_spec[leader.index]
            if(scrNTTEFullValue(id,"ntte_spec_frame",-1)==current_frame) { _hold=ntte_spec_hold; _press=ntte_spec_press }
            dash_charging=dash_charging ? _hold:_press
        }
        if(leader.race==Race.Frog && !KeyCont.moving[leader.index]) leader.speed=speed
        var _last_mask=leader.mask_index; leader.mask_index=-1
        var _offset=2+floor(round(leader.bbox_bottom-leader.y)/2)*2
        leader.mask_index=_last_mask; mount_y=lerp(mount_y,_offset,1-power(0.75,timescale))
        var _yadd=0
        while(abs(mount_y-_yadd)>0.001) {
            var _add=clamp(mount_y-_yadd,-1,1),_blocked=false,_mount_sign=sign(mount_y)
            with(leader) _blocked=place_meeting(x,y+_yadd+_mount_sign,Wall)
            if(_blocked) break
            _yadd+=_add
        }
        if(_yadd!=mount_y) { mount_y=_yadd; leader.vspeed-=1.8*(KeyCont.moving[leader.index] ? 1/3:1)*sign(_yadd)*timescale }
        x=leader.x; y=leader.y+mount_y
        hspeed=leader.hspeed; vspeed=leader.vspeed
        if(random(60)<timescale) instance_create(x,y,Smoke)
    } else dash_charging=false
    if(right_delay>0) right_delay-=timescale
    else if(!dash && dash_charge>0) right=lengthdir_x(1,dash_direction)>=0 ? 1:-1
    else if(hspeed!=0) right=hspeed>=0 ? 1:-1
}
function scrNTTEFullPetSalamanderEndStep() {
    if(mount && instance_exists(leader) && portal_angle==0) { x=leader.x; y=leader.y+mount_y }
}
function scrNTTEFullPetSalamanderAlarm(_dir,_dis) {
    if(!mount && !dash && dash_charge<=0) {
        if(instance_exists(leader)) {
            if(_dis>24) {
                if(!is_undefined(path_dir)) { scrNTTEFullPetWalk(path_dir+orandom(20),8); right=lengthdir_x(1,direction)>=0 ? 1:-1; return walk }
                scrNTTEFullPetWalk(_dir+orandom(10),10); right=lengthdir_x(1,direction)>=0 ? 1:-1; return walk+random(5)
            }
        } else { scrNTTEFullPetWalk(random(360),15); right=lengthdir_x(1,direction)>=0 ? 1:-1 }
    }
    return 30
}
function scrNTTEFullPetSalamanderCleanup() {
    if(instance_exists(prompt_mount)) instance_destroy(prompt_mount,false)
    if(instance_exists(leader)) leader.angle=0
}
function scrNTTEFullPetSalamanderTests() {
    scrNTTEFullPetEffectAdditiveTests()
    scrNTTEFullPetEffectFaceSourceTests()
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[])
    var _x=_p.x,_y=_p.y,_speed=_p.speed,_direction=_p.direction,_can=_p.can_spec,_angle=_p.angle,_nh=_p.nexthurt
    var _hold=KeyCont.hold_spec[_p.index],_press=KeyCont.press_spec[_p.index]
    _p.ntte_pet=[]; _p.x=12000; _p.y=12000
    var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Salamander"); scrNTTEFullPetTake(_pet,_p)
    scrNTTEFullPetSalamanderMountSparkSourceTests(_pet)
    scrNTTEFullPetSalamanderCombatSourceTests(_pet)
    var _mount_prompt=_pet.prompt_mount
    assert(_pet.pet=="Salamander" && _pet.dash_max==3 && _pet.dash_add==0.15
        && is_callable(_pet.hooks.endstep) && _mount_prompt.on_meet(_p),"Salamander original constructor/mount prompt failed")
    with(_pet) scrNTTEFullPetSalamanderToggleMount()
    assert(_pet.mount && _mount_prompt.creator==_p && _pet.prompt_mount_time==0,"Salamander did not hide and transfer mount prompt to rider")
    KeyCont.hold_spec[_p.index]=true; KeyCont.press_spec[_p.index]=true; _p.can_spec=true
    with(_p) scrNTTEFullPetSalamanderPlayerBegin()
    assert(!_p.can_spec && !KeyCont.hold_spec[_p.index] && !KeyCont.press_spec[_p.index]
        && _pet.ntte_spec_press && _pet.ntte_spec_hold,"Mounted Salamander did not capture input and suppress native direct actives")
    with(_p) scrNTTEFullPetSalamanderPlayerEnd()
    assert(_p.can_spec && KeyCont.hold_spec[_p.index] && KeyCont.press_spec[_p.index],"Salamander left native controller input disabled")
    _pet.dash_charging=true
    repeat(ceil(20/timescale)+2) with(_pet) scrNTTEFullPetSalamanderStep()
    assert(abs(_pet.dash_charge-3)<0.001 && !_pet.dash,"Salamander charge timing differs from 20 logical frames")
    KeyCont.hold_spec[_p.index]=false; KeyCont.press_spec[_p.index]=false
    _pet.ntte_spec_hold=false; _pet.ntte_spec_press=false
    with(_pet) scrNTTEFullPetSalamanderStep()
    with(_pet) scrNTTEFullPetSalamanderStep()
    assert(_pet.dash && _pet.dash_charge==3,"Fully charged Salamander did not dash upon active release")
    with(_p) { scrNTTEFullPetSalamanderPlayerBegin(); scrNTTEFullPetSalamanderPlayerEnd() }
    assert(_p.speed>_p.maxspeed+7*timescale && _p.nexthurt>=current_frame+6,"Dash was clamped by native player speed or lost invulnerability")
    // Real hostile projectile scan: damaging rounds melt, same-team rounds and
    // grenades survive. This exercises ownership rather than a status flag.
    var _enemy_round=instance_create(_p.x,_p.y,Bullet1),_ally_round=instance_create(_p.x,_p.y,Bullet1)
    var _grenade=instance_create(_p.x,_p.y,Grenade)
    _enemy_round.team=team_enemy; _ally_round.team=_p.team; _grenade.team=team_enemy
    _pet.x=_p.x; _pet.y=_p.y
    with(_pet) scrNTTEFullPetSalamanderCombat(_p)
    assert(!instance_exists(_enemy_round) && instance_exists(_ally_round) && instance_exists(_grenade),"Salamander projectile melting ignored faction/grenade exclusions")
    instance_destroy(_ally_round,false); instance_destroy(_grenade,false)
    // Surviving large bodies stop charge and rebound; allies take no damage.
    var _enemy=instance_create(_p.x+_p.hspeed,_p.y+_p.vspeed,Bandit)
    var _ally=instance_create(_enemy.x,_enemy.y,Bandit)
    _enemy.hp=200; _enemy.max_hp=200; _enemy.team=team_enemy; _enemy.size=4
    _ally.hp=200; _ally.team=_p.team
    _pet.dash_charge=3
    with(_pet) scrNTTEFullPetSalamanderCombat(_p)
    assert(_enemy.hp==160 && _ally.hp==200 && _pet.dash_charge==0,"Salamander 40 damage bash/large-body rebound/friendly exclusion failed")
    instance_destroy(_enemy,false); instance_destroy(_ally,false)
    with(_pet) scrNTTEFullPetSalamanderToggleMount()
    assert(!_pet.mount && _mount_prompt.creator==_pet && _pet.prompt_mount_time==-1,"Salamander dismount did not restore prompt owner")
    instance_destroy(_pet)
    assert(!instance_exists(_mount_prompt),"Salamander leaked mount prompt on cleanup")
    _p.ntte_pet=_old_pets; _p.x=_x; _p.y=_y; _p.speed=_speed; _p.direction=_direction; _p.can_spec=_can; _p.angle=_angle; _p.nexthurt=_nh
    KeyCont.hold_spec[_p.index]=_hold; KeyCont.press_spec[_p.index]=_press
    scrNTTESmokeLog("SYSTEMS PET SALAMANDER: real mount/captured native input/charge/release/dash/invulnerability/projectile melting/40-damage bash/faction/rebound/dismount cleanup OK")
}

// Source telib.fx: native constructors, additive velocity and original facing.
// This first regression isolates Smoke/Dust cases whose facing stays inactive.
function scrNTTEFullPetEffectAdditiveSourceReference(_x,_y,_motion,_object) {
    with(instance_create(_x,_y,_object)) {
        var _initial_speed=speed
        var _face=(image_angle==direction || (speed==0 && (object_index==AcidStreak || object_index==BloodStreak)))
        if(is_array(_motion)) motion_add(_motion[0],_motion[1]*timescale)
        else motion_add(random(360),_motion*timescale)
        if(_face) image_angle=direction
        return {fx:id,initial_speed:_initial_speed,face:_face}
    }
    return {fx:noone,initial_speed:0,face:false}
}
function scrNTTEFullPetEffectAdditiveCleanup(_before) {
    var _now=scrNTTEFullInstances(all)
    for(var _i=array_length(_now)-1;_i>=0;--_i)
        if(array_get_index(_before,_now[_i])<0 && instance_exists(_now[_i])) instance_destroy(_now[_i],false)
}
function scrNTTEFullPetEffectAdditiveCapture(_before) {
    var _now=scrNTTEFullInstances(all),_created=[],_rows=[],_tail=[]
    for(var _i=0;_i<array_length(_now);++_i)
        if(array_get_index(_before,_now[_i])<0) array_push(_created,_now[_i])
    array_sort(_created,true)
    var _fields=["object_index","x","y","xprevious","yprevious","xstart","ystart","hspeed","vspeed","speed","direction","sprite_index","mask_index","image_angle","image_index","image_speed","image_xscale","image_yscale","image_blend","image_alpha","visible","persistent","depth","friction","gravity","gravity_direction"]
    var _optional=["growspeed","rot","waterbubble"]
    for(var _i=0;_i<array_length(_created);++_i) {
        var _v=_created[_i],_row=[]
        for(var _j=0;_j<array_length(_fields);++_j) array_push(_row,variable_instance_get(_v,_fields[_j]))
        for(var _j=0;_j<array_length(_optional);++_j) {
            var _has=variable_instance_exists(_v,_optional[_j])
            array_push(_row,_has)
            if(_has) array_push(_row,variable_instance_get(_v,_optional[_j]))
        }
        with(_v) for(var _j=0;_j<12;++_j) array_push(_row,alarm[_j])
        array_push(_rows,_row)
    }
    repeat(6) array_push(_tail,random(1))
    return {rows:_rows,tail:_tail}
}
function scrNTTEFullPetEffectAdditiveExact(_expected,_actual,_where) {
    assert(is_array(_expected) && is_array(_actual) && array_length(_expected)==array_length(_actual),"PetEffect source array shape differs at "+_where)
    for(var _i=0;_i<array_length(_expected);++_i) {
        if(is_array(_expected[_i]) || is_array(_actual[_i]))
            scrNTTEFullPetEffectAdditiveExact(_expected[_i],_actual[_i],_where+"/"+string(_i))
        else assert(_expected[_i]==_actual[_i],"PetEffect source exact value differs at "+_where+"/"+string(_i)+": expected="+string(_expected[_i])+", actual="+string(_actual[_i]))
    }
}
function scrNTTEFullPetEffectAdditiveTrials(_generation) {
    assert(os_type==os_windows && scrNTTESmokeEnabled() && instance_exists(GameCont)
        && instance_exists(GenCont)==_generation,"PetEffect source test needs the actual native desktop context")
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed()
    var _area=GameCont.area,_underwater=GameCont.underwater,_particles=UberCont.opt_prtcls
    var _objects=[Smoke,Dust],_motions=[2.75,[37,3.25]],_conditions=_generation?[true]:[true,false]
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    try {
        GameCont.area=area_desert;GameCont.underwater=false
        for(var _pi=0;_pi<array_length(_conditions);++_pi)
        for(var _oi=0;_oi<array_length(_objects);++_oi)
        for(var _mi=0;_mi<array_length(_motions);++_mi)
        for(var _si=0;_si<array_length(_seeds);++_si) {
            UberCont.opt_prtcls=_conditions[_pi]
            var _object=_objects[_oi],_motion=_motions[_mi],_trial_seed=_seeds[_si]
            var _live=_conditions[_pi] && !_generation
            var _where="rate="+string(30/timescale)+",generation="+string(_generation)+",particles="+string(_conditions[_pi])+",object="+object_get_name(_object)+",motion="+string(_mi)+",seed="+string(_trial_seed)
            random_set_seed(_trial_seed)
            var _source=scrNTTEFullPetEffectAdditiveSourceReference(150000,150064,_motion,_object)
            var _expected=scrNTTEFullPetEffectAdditiveCapture(_before)
            assert(instance_exists(_source.fx)==_live && array_length(_expected.rows)==(_live?1:0),"Source native constructor live/dead precondition failed at "+_where)
            if(_live) {
                assert(_source.initial_speed>0,"Source constructor did not supply nonzero additive-motion witness at "+_where)
                assert(!_source.face,"Narrow additive fixture must keep source facing inactive at "+_where)
            }
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            random_set_seed(_trial_seed)
            var _actual_fx=scrNTTEFullPetEffect(150000,150064,_motion,_object)
            var _actual=scrNTTEFullPetEffectAdditiveCapture(_before)
            assert(instance_exists(_actual_fx)==_live && array_length(_actual.rows)==(_live?1:0),"Production native constructor live/dead result differs at "+_where)
            scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/newborn-fields")
            scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
            scrNTTESmokeLog("PET EFFECT ADDITIVE SOURCE EXACT "+_where+", RNG6="+json_stringify(_actual.tail))
            scrNTTEFullPetEffectAdditiveCleanup(_before)
        }
        scrNTTESmokeLog("SYSTEMS PET EFFECT ADDITIVE: real Smoke/Dust scalar+array x8seeds, exact newborn fields/RNG6; generation="+string(_generation)+" @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        GameCont.area=_area;GameCont.underwater=_underwater;UberCont.opt_prtcls=_particles
        random_set_seed(_seed)
    }
}
function scrNTTEFullPetEffectAdditiveTests() {scrNTTEFullPetEffectAdditiveTrials(false)}
function scrNTTEFullPetEffectGenerationSafetyTests() {scrNTTEFullPetEffectAdditiveTrials(true)}

// Independent source-literal telib.fx oracle, evaluated by the native VM.
function scrNTTEFullPetEffectFaceSourceReference(_x,_y,_motion,_object) {
    with(instance_create((is_array(_x)?_x[0]+orandom(_x[1]):_x),
        (is_array(_y)?_y[0]+orandom(_y[1]):_y),_object)) {
        var _face=(image_angle==direction || (speed==0 && (object_index==AcidStreak || object_index==BloodStreak)))
        if(is_array(_motion)) motion_add(_motion[0],_motion[1]*timescale)
        else motion_add(random(360),_motion*timescale)
        if(_face) image_angle=direction
        return id
    }
    return noone
}
function scrNTTEFullPetEffectFaceSourceTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_area=GameCont.area
    var _underwater=GameCont.underwater,_particles=UberCont.opt_prtcls
    var _objects=[AcidStreak,LaserCharge],_motions=[2.75,[37,3.25]]
    var _xs=[150000,[150000,6]],_ys=[150064,[150064,6]]
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    assert(os_type==os_windows && scrNTTESmokeEnabled() && !instance_exists(GenCont),"Face oracle requires isolated native desktop context")
    try {
        GameCont.area=area_desert;GameCont.underwater=false;UberCont.opt_prtcls=true
        for(var _o=0;_o<2;++_o) for(var _m=0;_m<2;++_m)
        for(var _c=0;_c<2;++_c) for(var _s=0;_s<8;++_s) {
            var _where="rate="+string(30/timescale)+",object="+object_get_name(_objects[_o])+",motion="+string(_m)+",coordinates="+string(_c)+",seed="+string(_seeds[_s])
            random_set_seed(_seeds[_s])
            var _fx=scrNTTEFullPetEffectFaceSourceReference(_xs[_c],_ys[_c],_motions[_m],_objects[_o])
            assert(instance_exists(_fx) && _fx.image_angle==_fx.direction,"Source native facing precondition missing")
            var _expected=scrNTTEFullPetEffectAdditiveCapture(_before)
            assert(array_length(_expected.rows)==1,"Source oracle did not create one real effect")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            random_set_seed(_seeds[_s])
            _fx=scrNTTEFullPetEffect(_xs[_c],_ys[_c],_motions[_m],_objects[_o])
            assert(instance_exists(_fx),"Production native facing effect absent")
            var _actual=scrNTTEFullPetEffectAdditiveCapture(_before)
            scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/fields")
            scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
        }
        scrNTTESmokeLog("SYSTEMS PET EFFECT FACE source literal: native AcidStreak/LaserCharge scalar+array motion, numeric+randomized coordinates,64 exact fields/facing/RNG6 comparisons @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        GameCont.area=_area;GameCont.underwater=_underwater;UberCont.opt_prtcls=_particles;random_set_seed(_seed)
    }
}
function scrNTTEFullPetTwinsSparkSourceReference(_white) {
    if(_white) {
        with(scrNTTEFullPetEffectFaceSourceReference([x,6],[y,6],[90,random_range(0.2,0.5)],LaserCharge)) {
            sprite_index=other.spr_fx_star;image_index=choose(0,irandom(image_number-1))
            depth=other.depth-1;alarm[0]=random_range(15,30)
        }
    } else {
        with(instance_create(x+orandom(6),y+orandom(6),LaserCharge)) {
            sprite_index=other.spr_fx_star;depth=other.depth-1;alarm[0]=random_range(10,20)
            motion_set(random(360),random(1)*timescale);image_speed=0.4*timescale
        }
    }
}
function scrNTTEFullPetTwinsSparkSourceTests(_pet) {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed()
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    assert(instance_exists(_pet) && instance_exists(_pet.partner),"Twins source test lacks actual partner")
    try {
        for(var _skin=0;_skin<2;++_skin) for(var _s=0;_s<8;++_s) {
            var _target=_pet.bskin==_skin?_pet:_pet.partner,_white=_skin==1
            var _where="rate="+string(30/timescale)+",skin="+string(_skin)+",seed="+string(_seeds[_s])
            assert(_target.bskin==_skin,"Real Twins skins do not match source precondition")
            random_set_seed(_seeds[_s])
            with(_target) scrNTTEFullPetTwinsSparkSourceReference(_white)
            var _expected=scrNTTEFullPetEffectAdditiveCapture(_before)
            assert(array_length(_expected.rows)==1 && _expected.rows[0][0]==LaserCharge
                && _expected.rows[0][13]==(_white?90:0),"Source white facing/red direct motion distinction missing")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            random_set_seed(_seeds[_s])
            with(_target) {if(_white) scrNTTEFullPetTwinsWhiteSpark();else scrNTTEFullPetTwinsRedSpark()}
            var _actual=scrNTTEFullPetEffectAdditiveCapture(_before)
            scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/fields")
            scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
        }
        scrNTTESmokeLog("SYSTEMS TWINS SPARK source white fx/facing and red direct-create/alarm-before-motion:16 genuine newborn fields/RNG6 comparisons @"+string(30/timescale))
    } finally {scrNTTEFullPetEffectAdditiveCleanup(_before);random_set_seed(_seed)}
}

function scrNTTEFullPetSalamanderMountSourceReference() {
    mount=!mount;mount_y=0;prompt_mount_time=mount?0:-1
    prompt_mount.text=prompt_mount_text[mount];prompt_mount.creator=mount?leader:id
    if(instance_exists(leader)) {
        leader.vspeed=-3*timescale
        if(mount) {leader.x=lerp(leader.x,x,0.5);leader.y=lerp(leader.y,y,0.5)}
    }
    repeat(3) with(scrNTTEFullPetEffectFaceSourceReference(x,y,1.5,Smoke)) {image_xscale/=1.2;image_yscale/=1.2}
    if(mount) {
        repeat(5) scrNTTEFullPetEffectFaceSourceReference(x,y,3,Dust)
        snd_play(sndSalamanderCharge,1.3+random(0.2));snd_play(sndSalamanderFire,1+orandom(0.2),0.5)
    } else snd_play(sndSalamanderEndFire,1+random(0.2),1.2)
}
function scrNTTEFullPetSalamanderSparkSourceReference() {
    with(scrNTTEFullPetEffectFaceSourceReference([x-13*right*image_xscale,2*image_xscale],y+random(4*image_yscale),random(random(1)),FireFly)) {
        sprite_index=scrNTTERefSprite("FlameSpark");depth=other.depth-1
    }
}
function scrNTTEFullPetSalamanderMountSourceState(_pet) {
    var _p=_pet.leader,_prompt=_pet.prompt_mount
    return [_pet.mount,_pet.mount_y,_pet.prompt_mount_time,_p.x,_p.y,_p.vspeed,_prompt.text,_prompt.creator,_prompt.pick]
}
function scrNTTEFullPetSalamanderMountSparkSourceTests(_pet) {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_p=_pet.leader,_prompt=_pet.prompt_mount
    var _saved_pet=scrNTTEFullAreaGeneratorSnapshot(_pet),_saved_player=scrNTTEFullAreaGeneratorSnapshot(_p),_saved_prompt=scrNTTEFullAreaGeneratorSnapshot(_prompt)
    var _area=GameCont.area,_underwater=GameCont.underwater,_particles=UberCont.opt_prtcls
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106],_scales=[0.7,1.4],_sides=[-1,1]
    assert(os_type==os_windows && scrNTTESmokeEnabled() && !instance_exists(GenCont),"Mount source oracle requires isolated native context")
    try {
        GameCont.area=area_desert;GameCont.underwater=false;UberCont.opt_prtcls=true
        for(var _mode=0;_mode<2;++_mode) for(var _s=0;_s<8;++_s) {
            var _expected=undefined,_state=undefined
            for(var _impl=0;_impl<2;++_impl) {
                scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_player);scrNTTEFullAreaGeneratorRestore(_saved_prompt)
                _pet.x=150000;_pet.y=150064;_pet.mount=_mode==1;_prompt.pick=-1
                _p.x=150032;_p.y=150096;_p.vspeed=2*timescale
                random_set_seed(_seeds[_s])
                with(_pet) {if(_impl==0) scrNTTEFullPetSalamanderMountSourceReference();else scrNTTEFullPetSalamanderToggleMount()}
                var _actual=scrNTTEFullPetEffectAdditiveCapture(_before),_actual_state=scrNTTEFullPetSalamanderMountSourceState(_pet)
                var _where="rate="+string(30/timescale)+",mount="+string(_mode)+",seed="+string(_seeds[_s])
                if(_impl==0) {
                    assert(array_length(_actual.rows)==(_mode==0?8:3),"Original mount effects missing")
                    _expected=_actual;_state=_actual_state
                } else {
                    scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/mount-fields")
                    scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/mount-RNG6")
                    scrNTTEFullPetEffectAdditiveExact(_state,_actual_state,_where+"/owner-prompt-state")
                }
                scrNTTEFullPetEffectAdditiveCleanup(_before)
            }
        }
        for(var _side=0;_side<2;++_side) for(var _scale=0;_scale<2;++_scale) for(var _s=0;_s<8;++_s) {
            scrNTTEFullAreaGeneratorRestore(_saved_pet)
            _pet.x=150000;_pet.y=150064;_pet.right=_sides[_side];_pet.image_xscale=_scales[_scale];_pet.image_yscale=1.25;_pet.depth=-3
            random_set_seed(_seeds[_s])
            with(_pet) scrNTTEFullPetSalamanderSparkSourceReference()
            var _expected=scrNTTEFullPetEffectAdditiveCapture(_before)
            assert(array_length(_expected.rows)==1 && _expected.rows[0][0]==FireFly && _expected.rows[0][9]>0,"Source FireFly randomized motion missing")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            random_set_seed(_seeds[_s])
            with(_pet) scrNTTEFullPetSalamanderChargeSpark()
            var _actual=scrNTTEFullPetEffectAdditiveCapture(_before)
            var _where="rate="+string(30/timescale)+",side="+string(_sides[_side])+",xscale="+string(_scales[_scale])+",seed="+string(_seeds[_s])
            scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/spark-fields")
            scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/spark-RNG6")
            scrNTTEFullPetEffectAdditiveCleanup(_before)
        }
        scrNTTESmokeLog("SYSTEMS SALAMANDER MOUNT+SPARK source literal:48 comparisons, real owner/prompt, two mount states, spark sides/scales, exact newborn fields/state/RNG6 @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_player);scrNTTEFullAreaGeneratorRestore(_saved_prompt)
        GameCont.area=_area;GameCont.underwater=_underwater;UberCont.opt_prtcls=_particles;random_set_seed(_seed)
    }
}

// Independent literal branches from petlib.Salamander, not production helpers.
function scrNTTEFullPetSalamanderImpactLiteral(_mover,_target) {
    var _damage=10+ceil(10*dash_charge)
    scr_projectile_hit(_target,_damage,speed*2/3,direction)
    assert(instance_exists(_target) && _target.hp>0,"Salamander impact oracle requires surviving body")
    sprite_index=spr_hurt;image_index=0
    dash_direction=point_direction(_target.x,_target.y,x,y);dash_charge=0
    _mover.direction=dash_direction;_mover.speed/=3
    with(_target) repeat(5) with(scrNTTEFullPetEffectFaceSourceReference(x,y,[other.direction+orandom(20),4],Smoke)) friction*=2
}
function scrNTTEFullPetSalamanderWallLiteral(_mover) {
    var _pet=id
    with(_mover) if(place_meeting(x+hspeed,y+vspeed,Wall)) {
        var _last=speed
        if(place_meeting(x+hspeed,y,Wall)) hspeed*=-0.1
        if(place_meeting(x,y+vspeed,Wall)) vspeed*=-0.1
        _pet.dash_direction=direction
        if(_pet.dash_charge>=1) {
            _pet.dash_charge=max(1,_pet.dash_charge-_pet.dash_add*4)
            var _near=noone,_best=infinity,_px=x,_py=y
            with(Wall) {
                var _d=distance_to_point(_px,_py)
                if(_d<_best) {_best=_d;_near=id}
            }
            with(_near) {
                var _dir=point_direction(bbox_center_x,bbox_center_y,other.x,other.y)
                repeat(5) with(scrNTTEFullPetEffectFaceSourceReference(bbox_center_x+lengthdir_x(8,_dir),bbox_center_y+lengthdir_y(8,_dir),[_dir,random_range(3,4)],Smoke)) {
                    image_index=irandom(image_number-1)
                    image_xscale/=1.5;image_yscale/=1.5;friction*=3;depth=-4
                }
            }
            snd_play(sndSalamanderHurt,1.4+random(0.2),lerp(0.3,0.8,1-speed/max(0.001,_last)))
        }
    }
}
function scrNTTEFullPetSalamanderCombatSourceState(_pet,_mover,_target) {
    var _v=[_pet.sprite_index,_pet.image_index,_pet.dash_direction,_pet.dash_charge,_pet.stat.tossed,
        _pet.x,_pet.y,_pet.direction,_pet.speed,_pet.hspeed,_pet.vspeed,
        _mover.x,_mover.y,_mover.direction,_mover.speed,_mover.hspeed,_mover.vspeed]
    if(instance_exists(_target)) array_push(_v,_target.hp,_target.max_hp,_target.x,_target.y,_target.direction,_target.speed,_target.hspeed,_target.vspeed)
    return _v
}
function scrNTTEFullPetSalamanderCombatSourceTests(_pet) {
    var _p=_pet.leader
    assert(os_type==os_windows && scrNTTESmokeEnabled() && !instance_exists(GenCont) && !instance_exists(FloorMaker)
        && instance_exists(_p),"Salamander collision oracle needs native desktop leader/context")
    var _before=scrNTTEFullInstances(all),_rng=random_get_seed(),_particles=UberCont.opt_prtcls
    var _saved_pet=scrNTTEFullAreaGeneratorSnapshot(_pet),_saved_p=scrNTTEFullAreaGeneratorSnapshot(_p),_saved_game=scrNTTEFullAreaGeneratorSnapshot(GameCont)
    var _park=[],_types=[hitme,projectile,Wall,InvisiWall]
    for(var _i=0;_i<array_length(_types);++_i) {
        var _ids=scrNTTEFullInstances(_types[_i])
        for(var _j=0;_j<array_length(_ids);++_j)
            if(_ids[_j]!=_pet && _ids[_j]!=_p && array_get_index(_park,_ids[_j])<0) array_push(_park,_ids[_j])
    }
    for(var _i=0;_i<array_length(_park);++_i) instance_deactivate_object(_park[_i])
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    try {
        for(var _mode=0;_mode<2;++_mode) for(var _mounted=0;_mounted<2;++_mounted)
        for(var _opt=0;_opt<2;++_opt) for(var _s=0;_s<8;++_s) {
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_p);scrNTTEFullAreaGeneratorRestore(_saved_game)
            GameCont.area=area_desert;GameCont.underwater=false;UberCont.opt_prtcls=_opt==0
            _pet.x=150000;_pet.y=150064;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
            _pet.mount=_mounted==1;_pet.dash=true;_pet.dash_charge=3;_pet.direction=37;_pet.speed=8*timescale
            _p.x=_pet.x+3;_p.y=_pet.y+2;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.direction=37;_p.speed=8*timescale
            var _mover=_mounted==1?_p:_pet,_target=noone
            if(_mode==0) {
                _target=instance_create(_mover.x+_mover.hspeed,_mover.y+_mover.vspeed,Bandit)
                _target.hp=200;_target.max_hp=200;_target.size=4;_target.team=team_enemy
                var _hits=ds_list_create()
                collision_rectangle_list(_mover.bbox_left+_mover.hspeed-6,_mover.bbox_top+_mover.vspeed-6,
                    _mover.bbox_right+_mover.hspeed+6,_mover.bbox_bottom+_mover.vspeed+6,hitme,false,true,_hits,false)
                var _found=0
                for(var _i=0;_i<ds_list_size(_hits);++_i) if(_hits[|_i]==_target) _found++
                ds_list_destroy(_hits)
                assert(_found==1 && _target.team!=_mover.team,"Salamander genuine hostile collision witness missing")
            } else {
                var _wall=instance_create(_mover.x+2,_mover.y-8,Wall)
                _wall.image_xscale=1.5;_wall.image_yscale=1.25
                with(_mover) assert(place_meeting(x+hspeed,y+vspeed,Wall),"Salamander actual native wall collision absent")
                assert((_wall.bbox_left+_wall.bbox_right)/2!=_wall.x,"Salamander wall bbox-center witness missing")
            }
            var _case=scrNTTEFullInstances(all),_sp=scrNTTEFullAreaGeneratorSnapshot(_pet),_sm=scrNTTEFullAreaGeneratorSnapshot(_p)
            var _sg=scrNTTEFullAreaGeneratorSnapshot(GameCont),_st=instance_exists(_target)?scrNTTEFullAreaGeneratorSnapshot(_target):undefined
            var _expected=undefined,_state=undefined
            for(var _impl=0;_impl<2;++_impl) {
                scrNTTEFullPetEffectAdditiveCleanup(_case)
                scrNTTEFullAreaGeneratorRestore(_sp);scrNTTEFullAreaGeneratorRestore(_sm);scrNTTEFullAreaGeneratorRestore(_sg)
                if(!is_undefined(_st)) scrNTTEFullAreaGeneratorRestore(_st)
                random_set_seed(_seeds[_s])
                with(_pet) {
                    if(_impl==1) scrNTTEFullPetSalamanderCombat(_mover)
                    else if(_mode==0) scrNTTEFullPetSalamanderImpactLiteral(_mover,_target)
                    else scrNTTEFullPetSalamanderWallLiteral(_mover)
                }
                var _actual=scrNTTEFullPetEffectAdditiveCapture(_case),_a_state=scrNTTEFullPetSalamanderCombatSourceState(_pet,_mover,_target)
                var _where="rate="+string(30/timescale)+",mode="+string(_mode)+",mounted="+string(_mounted)+",particles="+string(_opt==0)+",seed="+string(_seeds[_s])
                var _smoke=0
                for(var _i=0;_i<array_length(_actual.rows);++_i) if(_actual.rows[_i][0]==Smoke) _smoke++
                assert(_smoke==(_opt==0?5:0),"Salamander native Smoke lifetime/count differs at "+_where)
                if(_mode==0) assert(_target.hp==160 && _pet.dash_charge==0,"Salamander original 40 damage/rebound changed")
                else assert(_pet.dash_charge==max(1,3-_pet.dash_add*4),"Salamander original wall charge reduction changed")
                if(_impl==0) {_expected=_actual;_state=_a_state}
                else {
                    scrNTTEFullPetEffectAdditiveExact(_state,_a_state,_where+"/collision-state")
                    scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/native-newborn-fields")
                    scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
                    scrNTTESmokeLog("SALAMANDER COMBAT SOURCE EXACT "+_where+",state="+json_stringify(_a_state)+",RNG6="+json_stringify(_actual.tail))
                }
            }
        }
        scrNTTESmokeLog("SYSTEMS SALAMANDER COMBAT SOURCE: native Combat vs independent original branches; impact/wall x mounted/unmounted x particles on/off x8 seeds @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_p);scrNTTEFullAreaGeneratorRestore(_saved_game)
        for(var _i=0;_i<array_length(_park);++_i) instance_activate_object(_park[_i])
        UberCont.opt_prtcls=_particles;random_set_seed(_rng)
    }
}
