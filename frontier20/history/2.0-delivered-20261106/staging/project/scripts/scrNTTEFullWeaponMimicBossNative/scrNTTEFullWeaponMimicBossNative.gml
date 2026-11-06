// tegeneral3714..4240 and ntte657..704. The boss shares the actual Weapon
// pet animation/loadout/fire code, but retains its own hostile AI and stats.
function scrNTTEFullWeaponMimicBecomeCreate() {
    bskin=0;sprite_index=scrNTTERefSprite("PetWeaponChst")
    type=choose(Ammo.None,Ammo.Bullets,Ammo.Shells,Ammo.Bolts,Ammo.Explosives,Ammo.Energy)
    prompt=scrNTTEFullPromptCreate(id,"BATTLE",mskWepPickup,0,-1)
    switch(GameCont.crown) {
        case crwn_none:curse=false;break
        case crwn_curses:curse=chance(2,3);break
        default:curse=chance(1,7)
    }
}
function scrNTTEFullWeaponMimicBecomeCleanup() {
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    prompt=noone
}
function scrNTTEFullWeaponMimicBecomeStep() {
    if(lockstep_stop) return;
    if(bskin==!(curse>0)) {
        bskin=curse>0;sprite_index=scrNTTERefSprite(bskin?"PetWeaponCursedChst":"PetWeaponChst")
    }
    if(!instance_exists(prompt) || prompt.pick<0) return;
    var _player=noone,_index=prompt.pick
    with(Player) if(index==_index) _player=id
    if(!scrNTTEFullPlayerActive(_player)) return;
    var _boss=instance_create(x,y,NTTEFullPetWeaponBoss)
    _boss.type=type;_boss.curse=curse
    with(_boss) motion_add(point_direction(_player.x,_player.y,x,y),3*timescale)
    GameCont.nochest=0;scrNTTEFullPortalPoof();instance_destroy()
}
function scrNTTEFullWeaponMimicBossCreate() {
    boss=true;depth=-2
    spr_idle=scrNTTERefSprite("PetWeaponIdle");spr_walk=scrNTTERefSprite("PetWeaponWalk")
    spr_hurt=scrNTTERefSprite("PetWeaponHurt");spr_dead=scrNTTERefSprite("PetWeaponDead")
    spr_icon=scrNTTERefSprite("PetWeaponIcon");sprite_index=spr_idle;bskin=0
    hitid=[spr_idle,"WEAPON MIMIC"];mask_index=mskFreak;max_hp=scrNTTEFullSewerBossHP(120)
    size=1;walk=0;walkspeed=2;maxspeed=3;intro=false;corpse=false;prompt=noone
    history=[];path=[];path_delay=0;cover_x=x;cover_y=y;cover_peek=false;cover_delay=0
    stat_battle=true;pet="Weapon";mod_type="mod";mod_name="petlib"
    var _statKey="pet:Weapon.petlib.mod"
    if(!is_struct(scrNTTEFullValue(global.ntte_full_progress.stats,_statKey)))
        variable_struct_set(global.ntte_full_progress.stats,_statKey,{found:0,owned:0})
    stat=variable_struct_get(global.ntte_full_progress.stats,_statKey)
    var _hp=max_hp
    scrNTTEFullPetWeaponCreate();max_hp=_hp
    sprite_index=spr_hide;scrNTTEFullPetSetSkin(id,bskin)
    ntte_mimic_alarm1=60;ntte_mimic_alarm2=reload
    bossname=hitid[1];col=c_red
    // These are actual CustomEnemy defaults used by the shared pet methods.
    leader=noone;revive=noone;ntte_weapon_mimic_boss=true;my_health=max_hp
}
function scrNTTEFullWeaponMimicBossAfterCreate() {
    // Epsilon enemy applies its own loop health scale; source boss_hp already
    // included the complete multiplayer/loop calculation.
    max_hp=scrNTTEFullSewerBossHP(120);hp=max_hp;my_health=hp
    corpse=false;canmelee=false;spr_shadow=shd24;spr_shadow_y=-1
    snd_hurt=sndMimicHurt;snd_dead=sndMimicDead
    alarm[1]=-1;alarm[2]=-1
}
function scrNTTEFullWeaponMimicBossTarget() {
    scrTarget()
    target_visible=instance_exists(target) && target.team!=team
        && !collision_line(x,y,target.x,target.y,Wall,false,false)
    if(!instance_exists(target)) return false
    target_direction=point_direction(x,y,target.x,target.y)
    target_distance=point_distance(x,y,target.x,target.y)
    return true
}
function scrNTTEFullWeaponMimicBossCover(_coverX,_coverY,_fromX,_fromY) {
    var _dis=point_distance(_coverX,_coverY,_fromX,_fromY)
    if(_dis<shootdis_min || _dis>shootdis_max) return false
    if(!collision_line(_coverX,_coverY,_fromX,_fromY,Wall,false,false)
        || position_meeting(_coverX,_coverY,Wall)) return false
    var _l=16,_d=round(point_direction(_coverX,_coverY,_fromX,_fromY)/90)*90
    if(position_meeting(_coverX+lengthdir_x(_l,_d),_coverY+lengthdir_y(_l,_d),Wall)
        || position_meeting(_coverX+lengthdir_x(_l,_d-90),_coverY+lengthdir_y(_l,_d-90),Wall)
        || position_meeting(_coverX+lengthdir_x(_l,_d+90),_coverY+lengthdir_y(_l,_d+90),Wall)) {
        if(!collision_line(_coverX+lengthdir_x(_l,_d-90),_coverY+lengthdir_y(_l,_d-90),_fromX,_fromY,Wall,false,false)
            || !collision_line(_coverX-lengthdir_x(_l,_d-90),_coverY-lengthdir_y(_l,_d-90),_fromX,_fromY,Wall,false,false)) return true
    }
    return false
}
function scrNTTEFullWeaponMimicBossDecision() {
    ntte_mimic_alarm1=10+random(30)
    if(sprite_index==spr_hide || sprite_index==spr_spwn) return;
    if(!scrNTTEFullWeaponMimicBossTarget()) { sprite_index=spr_hide;image_index=0;return }
    var _tx=target.x,_ty=target.y,_targetDir=target_direction,_pathX=undefined,_pathY=undefined
    switch(type) {
        case Ammo.None:
            if(target_visible) { scrNTTEFullWorldWalk(_targetDir+choose(-60,60),5+random(10));ntte_mimic_alarm1=walk }
            else { _pathX=_tx;_pathY=_ty }
            var _self=id
            with(projectile) if(typ==1 && team!=_self.team) {
                if(abs(angle_difference(_self.gunangle,point_direction(_self.x,_self.y,x,y)))<60
                    && point_distance(_self.x,_self.y,x,y)<96) { _self.direction+=180;break }
            }
            break
        case Ammo.Shells:
            if(target_visible) { scrNTTEFullWorldWalk(gunangle+orandom(60),20);ntte_mimic_alarm1=walk }
            else { _pathX=_tx;_pathY=_ty }
            break
        case Ammo.Bolts:
            if(cover_delay>0 || scrNTTEFullWeaponMimicBossCover(cover_x,cover_y,_tx,_ty)) {
                if(point_distance(x,y,cover_x,cover_y)>8 || cover_peek) {
                    if(!collision_line(x,y,cover_x,cover_y,Wall,false,false)) {
                        scrNTTEFullWorldWalk(point_direction(x,y,cover_x,cover_y),cover_peek?random_range(5,10):1)
                        ntte_mimic_alarm1=cover_peek?random_range(walk,30):walk;cover_peek=false
                    }
                    else { _pathX=cover_x;_pathY=cover_y }
                }
                else {
                    cover_peek=true;gunangle_goal=_targetDir;ntte_mimic_alarm1=15;ntte_mimic_alarm2=15-random(3)
                    var _l=16,_d=round(point_direction(cover_x,cover_y,_tx,_ty)/90)*90,
                        _left=!collision_line(cover_x+lengthdir_x(_l,_d-90),cover_y+lengthdir_y(_l,_d-90),_tx,_ty,Wall,false,false),
                        _right=!collision_line(cover_x-lengthdir_x(_l,_d-90),cover_y-lengthdir_y(_l,_d-90),_tx,_ty,Wall,false,false),
                        _side=sign(_right-_left)
                    scrNTTEFullWorldWalk(_d+90*(_side==0?choose(-1,1):_side),4)
                    if(_right || _left) cover_delay=random_range(60,90)
                }
            }
            else {
                cover_x=_tx;cover_y=_ty;cover_peek=false;cover_delay=30
                scrNTTEFullWorldWalk(point_direction(_tx,_ty,x,y),15);ntte_mimic_alarm1=walk
                var _coverDisMax=undefined,_targetDisMin=undefined,
                    _floors=scrNTTEFullRectInstances(_tx-shootdis_max,_ty-shootdis_max,_tx+shootdis_max,_ty+shootdis_max,Floor)
                for(var _i=0;_i<array_length(_floors);++_i) {
                    var _floor=_floors[_i]
                    for(var _x=_floor.bbox_left;_x<_floor.bbox_right;_x+=16)
                    for(var _y=_floor.bbox_top;_y<_floor.bbox_bottom;_y+=16) {
                        var _cx=_x+8,_cy=_y+8,_coverDis=point_distance(_cx,_cy,x,y),_targetDis=point_distance(_cx,_cy,_tx,_ty)
                        if((is_undefined(_coverDisMax) || _coverDis<_coverDisMax)
                            && (is_undefined(_targetDisMin) || _targetDis>_targetDisMin)
                            && scrNTTEFullWeaponMimicBossCover(_cx,_cy,_tx,_ty)) {
                            _coverDisMax=_coverDis;_targetDisMin=_targetDis;cover_x=_cx;cover_y=_cy
                        }
                    }
                }
            }
            break
        case Ammo.Energy:
            if(target_visible) {
                if(target_distance<shootdis_max) { if(chance(1,3)) scrNTTEFullWorldWalk(random(360),random_range(5,20)) }
                else { scrNTTEFullWorldWalk(gunangle,20);ntte_mimic_alarm1=walk }
            }
            else { _pathX=_tx;_pathY=_ty }
            break
        default:
            if(target_visible) {
                if(target_distance<shootdis_max*2/3)
                    scrNTTEFullWorldWalk(_targetDir+90*sign(angle_difference(direction,_targetDir)),15)
                else scrNTTEFullWorldWalk(gunangle,20)
                ntte_mimic_alarm1=walk
            }
            else { _pathX=_tx;_pathY=_ty }
    }
    if(is_numeric(_pathX) && is_numeric(_pathY)) {
        if(path_delay<=0 && !scrNTTEFullPathReaches(path,_pathX,_pathY,Wall)) {
            path=scrNTTEFullPathShrink(scrNTTEFullPathCreate(x,y,_pathX,_pathY,Wall),Wall,2);path_delay=30
        }
        var _pathDir=scrNTTEFullPathDirection(path,x,y,Wall)
        if(!is_undefined(_pathDir)) {
            scrNTTEFullWorldWalk(_pathDir,random_range(1,5));ntte_mimic_alarm1=walk
            if(!target_visible) {
                if(abs(angle_difference(gunangle_goal,_pathDir))>60) gunangle_goal=_pathDir+orandom(60)
                if(target_distance<64) {
                    ntte_mimic_alarm1+=random(random(random(30)))
                    gunangle_goal+=angle_difference(_targetDir,gunangle_goal)/2
                }
            }
        }
        else path=[]
    }
    else path=[]
}
function scrNTTEFullWeaponMimicBossShoot() {
    ntte_mimic_alarm2=30
    if(sprite_index==spr_spwn || !scrNTTEFullWeaponMimicBossTarget()
        || !target_visible || target_distance>=shootdis_max || abs(angle_difference(gunangle,target_direction))>=30) return;
    for(var _hand=0;_hand<2;++_hand) {
        var _b=_hand==0?"":"b",_wep=variable_instance_get(id,_b+"wep"),_reload=variable_instance_get(id,_b+"reload"),
            _can=variable_instance_get(id,_b+"can_shoot"),_shot=false
        if(_can<=0 && _wep!=wep_none && _reload<=0) {
            if((!scrNTTEFullWeaponMimicLaserSight(_wep) && target_distance>=shootdis_min)
                || variable_instance_get(id,_b+"wep_laser")>=1) {
                _shot=true;_can=1
                var _load=scr_weapon_get_load(_wep)
                if(scr_weapon_is_auto(_wep) || _load<=10) _can+=floor(random(30)/_load)
                if(type==Ammo.Explosives || _wep==wep_jackhammer) _can+=irandom(ceil(3*(1-hp/max_hp)))
                ntte_mimic_alarm2=30+_can*_load
                switch(type) {
                    case Ammo.None:ntte_mimic_alarm2+=15+30*(_wep==wep_jackhammer);break
                    case Ammo.Shells:
                        _reload=9
                        var _alert=scrNTTEAlertCreate(x,y,spr_icon,id)
                        _alert.alert_x-=1;_alert.alert_hold=_reload+5;_alert.blink=10;_alert.flash=2;_alert.snd_flash=sndShotReload
                        break
                    case Ammo.Energy:ntte_mimic_alarm2+=random(30);break
                }
            }
        }
        variable_instance_set(id,_b+"reload",_reload);variable_instance_set(id,_b+"can_shoot",_can)
        if(_shot) break
    }
}
function scrNTTEFullWeaponMimicLaserSight(_wep) {
    // Actual NTT scrWepLaserSight disassembly: type3, except original ID18
    // (Disc Gun). Epsilon uses symbolic IDs for those same native weapons.
    var _model=scrNTTEFullWeaponModel(_wep),_stock=scrNTTEFullWeaponRaw(_model),
        _sight=scr_weapon_get_type(_stock)==Ammo.Bolts && _stock!=wep_disc_gun && _stock!=wep_ntte_net_launcher
    // temerge1080..1094 queries its macro again after assigning the front
    // into _wep: recurse only when that front itself has a merge. Preserve
    // this source condition, including inactive(-1) merges and empty parts.
    if(scrNTTEFullWeaponHasMerge(_model)!=false) {
        if(_model.temerge.is_part) return false
        if(!_sight) {
            var _front=scrNTTEFullWeaponMergedPart(_model)
            if(scrNTTEFullWeaponHasMerge(_front)!=false) return scrNTTEFullWeaponMimicLaserSight(_front)
        }
    }
    return _sight
}
function scrNTTEFullWeaponMimicSharedAnim() {
    if(sprite_index==spr_hide && instance_is(id,NTTEFullPetWeaponBoss)
        && scrNTTEFullWeaponMimicBossTarget()) {
        sprite_index=spr_spwn;image_index=0
    }
    scrNTTEFullPetWeaponAnim()
}
function scrNTTEFullWeaponMimicSharedFire(_actor,_wep,_angle,_accuracy,_consume,_remaining=0) {
    if(!instance_is(_actor,NTTEFullPetWeaponBoss)) return scrNTTEFullActorFire(_actor,_wep,_angle,_accuracy,_consume)
    var _muts=[mut_long_arms,mut_recycle_gland,mut_shotgun_shoulders,mut_bolt_marrow,mut_boiling_veins,mut_laser_brain],
        _old=[],_result=undefined
    for(var _i=0;_i<array_length(_muts);++_i) {
        array_push(_old,scr_skill_get(_muts[_i]));scr_skill_set(_muts[_i],0)
    }
    try { _result=scrNTTEFullActorFire(_actor,_wep,_angle,_accuracy,_consume) }
    finally { for(var _i=0;_i<array_length(_muts);++_i) scr_skill_set(_muts[_i],_old[_i]) }
    for(var _i=0;_i<array_length(_result.shots);++_i) {
        var _shot=_result.shots[_i]
        if(!instance_exists(_shot) || (!instance_is(_shot,projectile) && !instance_is(_shot,LaserCannon))) continue
        _shot.hitid=_actor.hitid;_shot.speed*=power(0.8,scr_skill_get(mut_euphoria))
        if((_shot.object_index==Bullet2 || _shot.object_index==EnemyBullet3)
            && string_pos("SHOTGUN",string_upper(scr_weapon_get_name(_wep)))>0) _shot.speed*=0.8
        else if(_shot.object_index==Bolt) {
            // Source explicitly leaves the native Bolt in place and also
            // creates a DiverHarpoon carrying every mutable original field.
            var _copy=instance_create(_shot.x,_shot.y,NTTEFullDiverHarpoon)
            scrNTTEFullWeaponMimicCopy(_shot,_copy)
        }
        else if(instance_is(_shot,Grenade) && _shot.alarm[0]>0) {
            scrNTTEFullWeaponMimicGrenadeTime(_shot,_remaining,scr_weapon_get_load(_wep))
        }
        scrNTTEFullWeaponMimicProjectileSetup(_shot,_actor)
    }
    return _result
}
function scrNTTEFullWeaponMimicGrenadeTime(_shot,_remaining,_load) {
    // NTT alarm2 is an absolute countdown to the flash animation. Epsilon
    // flash_at is instead the remaining-fuse threshold checked by Draw.
    var _fuse=_shot.alarm[0],_lead=_shot.flash_at,_waiting=_fuse>_lead
    _shot.alarm[0]=_fuse+_remaining*_load
    if(_waiting) _shot.flash_at=min(_shot.alarm[0]-1,_lead+40*(TopCont.darkness!=0))
}
function scrNTTEFullWeaponMimicCopy(_source,_target) {
    var _names=variable_instance_get_names(_source),
        _readonly=["id","object_index","bbox_left","bbox_right","bbox_top","bbox_bottom","image_number",
            "sprite_xoffset","sprite_yoffset","sprite_height","sprite_width"]
    for(var _i=0;_i<array_length(_names);++_i) if(array_get_index(_readonly,_names[_i])<0)
        variable_instance_set(_target,_names[_i],variable_instance_get(_source,_names[_i]))
    // Modern variable_instance_get_names excludes built-in instance fields.
    _target.x=_source.x;_target.y=_source.y;_target.xstart=_source.xstart;_target.ystart=_source.ystart
    _target.xprevious=_source.xprevious;_target.yprevious=_source.yprevious
    _target.direction=_source.direction;_target.speed=_source.speed;_target.friction=_source.friction
    _target.gravity=_source.gravity;_target.gravity_direction=_source.gravity_direction
    _target.sprite_index=_source.sprite_index;_target.image_index=_source.image_index;_target.image_speed=_source.image_speed
    _target.image_xscale=_source.image_xscale;_target.image_yscale=_source.image_yscale;_target.image_angle=_source.image_angle
    _target.image_blend=_source.image_blend;_target.image_alpha=_source.image_alpha
    _target.mask_index=_source.mask_index;_target.depth=_source.depth;_target.visible=_source.visible
    for(var _i=0;_i<12;++_i) _target.alarm[_i]=_source.alarm[_i]
}
function scrNTTEFullWeaponMimicBossStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy();return }
    my_health=hp
    if(ntte_mimic_alarm1>0) {
        ntte_mimic_alarm1-=timescale
        if(ntte_mimic_alarm1<=0) { scrNTTEFullWeaponMimicBossDecision();return }
    }
    if(ntte_mimic_alarm2>0) {
        ntte_mimic_alarm2-=timescale
        if(ntte_mimic_alarm2<=0) { scrNTTEFullWeaponMimicBossShoot();return }
    }
    if(path_delay>0) path_delay-=timescale
    if(cover_delay>0) cover_delay-=timescale
    if(walk>0) { walk-=timescale;speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    scrNTTEFullWeaponMimicSharedAnim();scrNTTEFullPetWeaponStep()
    if(!intro && sprite_index!=spr_hide && sprite_index!=spr_spwn) {
        intro=true;scrNTTEFullBossIntro(curse>0?"PetWeaponCursed":"PetWeapon")
        snd_play(curse>0?sndBigCursedChest:sndBigWeaponChest)
    }
    var _self=id
    with(LaserCannon) if(creator==_self) time=1+floor(abs(angle_difference(_self.gunangle,_self.gunangle_goal))/4)
    if(!instance_exists(Player) && stat_battle) {
        stat_battle=false;stat.battle[1]+=1;ntte_mimic_alarm1=max(ntte_mimic_alarm1,60)
    }
}
function scrNTTEFullWeaponMimicBossHurtDirection(_direction) {
    if(type==Ammo.None || type==Ammo.Shells) _direction+=180+orandom(90)
    return _direction
}
function scrNTTEFullWeaponMimicBossHurt(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        _direction=scrNTTEFullWeaponMimicBossHurtDirection(_direction)
        hp-=_damage;nexthurt=current_frame+6
        sprite_index=spr_hurt;image_index=0;snd_play_hit(snd_hurt,0.3)
        if(_force!=0) motion_add(_direction,_force)
    }
    return true
}
function scrNTTEFullWeaponMimicBossDeath() {
    with(MusCont) alarm[1]=1
    if(stat_battle) { stat_battle=false;stat.battle[0]+=1 }
    var _pet=scrNTTEFullPetCreate(x,y,"Weapon")
    _pet.direction=direction;_pet.speed=speed;_pet.wep=wep;_pet.bwep=bwep;_pet.curse=curse
    _pet.hp=hp
}
function scrNTTEFullWeaponMimicArenaLevelStart(_normal_area=undefined) {
    // Reuse the original level_start snapshot through all early constructors.
    if(is_undefined(_normal_area)) _normal_area=GameCont.hard>1 && instance_number(enemy)>instance_number(HostileHorror)
    if(!_normal_area) return noone
    if(!chance(GameCont.nochest-4,4)) return noone
    var _chest=instance_furthest(10016,10016,WeaponChest)
    if(!instance_exists(_chest)) return noone
    var _become=instance_create(_chest.x,_chest.y,NTTEFullPetWeaponBecome)
    _become.curse=max(_become.curse,_chest.curse)
    var _room=scrNTTEFullFloorRoomCreate(_become.x,_become.y,1,1,"",random(360),0,0)
    if(is_struct(_room)) {
        _become.x=_room.x;_become.y=_room.y
        switch(_become.type) {
            case Ammo.None:scrNTTEFullFloorFill(_room.x,_room.y,3);break
            case Ammo.Bullets:scrNTTEFullFloorFill(_room.x,_room.y,5,5,"round");break
            case Ammo.Shells:scrNTTEFullFloorFill(_room.x,_room.y,3,3,"round");break
            case Ammo.Bolts:
                scrNTTEFullFloorFill(_room.x,_room.y,3,3,"round");scrNTTEFullFloorFill(_room.x,_room.y,5,5,"ring");break
            case Ammo.Explosives:scrNTTEFullFloorFill(_room.x,_room.y,5,1);scrNTTEFullFloorFill(_room.x,_room.y,1,5);break
            case Ammo.Energy:scrNTTEFullFloorFill(_room.x,_room.y,5,5,"ring");break
        }
    }
    instance_create(_become.x,_become.y,PortalClear)
    var _xstart=_become.xstart,_ystart=_become.ystart
    with(PortalClear) if(xstart==_xstart && ystart==_ystart) instance_destroy()
    instance_destroy(_chest,false)
    return _become
}
