// tescrapyard747..1248. Source physical artifact collection,120tick sequential
// merging, real area-unfolding HeartBullets and native ultimate chest unlock.
function scrNTTEFullQuestPartList(_weapon,_state=undefined) {
    var _parts=scrNTTEFullCrabboneParts(_weapon),_out=[]
    for(var _i=0;_i<array_length(_parts);++_i) {
        var _part=scrNTTEFullCrabbonePartIndex(_parts[_i],_i==0?_state:undefined)
        if(_part>=0 && array_get_index(_out,_part)<0) array_push(_out,_part)
    }
    return _out
}
function scrNTTEFullLockedQuestPromptMeet(_player) {
    return instance_exists(creator) && creator.is_unlockable && instance_exists(_player) && !instance_exists(enemy)
        && array_length(scrNTTEFullQuestPartList(_player.wep,scrNTTEFullValue(_player,"ntte_state",undefined)))>=4
}
function scrNTTEFullLockedQuestCreate() {
    sprite_index=scrNTTERefSprite("HugeQuestChest");spr_shadow=shd64;spr_shadow_y=6;depth=-1
    max_merge_delay=120;merge_delay=max_merge_delay;is_unlockable=false;is_playing_music=false
    prompt=scrNTTEFullPromptCreate(id,"UNLOCK",mskShield)
    prompt.on_meet=scrNTTEFullLockedQuestPromptMeet
}
function scrNTTEFullLockedQuestSparkle(_x,_y,_part,_depth) {
    var _sparkle=instance_create(_x,_y,NTTEFullVaultFlowerSparkle)
    _sparkle.sprite_index=scrNTTERefSprite("QuestSparkle");_sparkle.depth=_depth
    switch(_part) {
        case 0:_sparkle.sprite_index=scrNTTERefSprite("AllyLaserCharge");break
        case 1:_sparkle.sprite_index=scrNTTERefSprite("ElectroPlasmaTrail");break
        case 2:_sparkle.sprite_index=sprIDPDPortalCharge;break
        case 3:_sparkle.sprite_index=sprLaserCharge;break
    }
    return _sparkle
}
// A pickup can occupy several logical tiles when it already contains merged
// parts. Source snapshots are indexed by the actual hub controller order0..3.
function scrNTTEFullLockedQuestCollect(_floors) {
    var _pool=[[],[],[],[]],_pickups=scrNTTEFullInstances(WepPickup),_targets=array_create(array_length(_floors),noone)
    for(var _i=0;_i<array_length(_pickups);++_i) if(_pickups[_i].visible) {
        var _parts=scrNTTEFullCrabboneParts(_pickups[_i].wep)
        for(var _j=0;_j<array_length(_parts);++_j) {
            var _part=scrNTTEFullCrabbonePartIndex(_parts[_j],_j==0?scrNTTEFullValue(_pickups[_i],"ntte_state",undefined):undefined),_exists=false
            if(_part<0 || _part>=4) continue
            for(var _k=0;_k<array_length(_floors);++_k) if(_floors[_k].part_index==_part) { _exists=true;break }
            if(_exists) array_push(_pool[_part],_pickups[_i])
        }
    }
    for(var _part=0;_part<4;++_part) if(array_length(_pool[_part])>0) {
        for(var _f=0;_f<array_length(_floors);++_f) if(_floors[_f].part_index==_part) {
            var _floor=_floors[_f],_near=noone,_dis=8
            for(var _p=0;_p<array_length(_pool[_part]);++_p) {
                var _pickup=_pool[_part][_p],_distance=point_distance(_pickup.x,_pickup.y,_floor.x,_floor.y)
                if(_distance<_dis) { _near=_pickup;_dis=_distance }
            }
            if(instance_exists(_near)) {
                for(var _j=0;_j<4;++_j) if(array_get_index(_pool[_j],_near)>=0)
                    for(var _k=0;_k<array_length(_floors);++_k) if(_floors[_k].part_index==_j) _targets[_k]=_near
            }
            else for(var _p=0;_p<array_length(_pool[_part]);++_p) {
                var _pickup=_pool[_part][_p]
                if(collision_line(_pickup.x,_pickup.y,_floor.x,_floor.y,Wall,false,false)) continue
                var _canMove=true
                for(var _j=0;_j<4;++_j) if(_j!=_part && abs(_j-1.5)<=abs(_part-1.5) && array_get_index(_pool[_j],_pickup)>=0) { _canMove=false;break }
                if(_canMove) with(_pickup) {
                    var _len=random_range(2,3),_offset=20*sin(((current_frame+_f*75)/300)*2*pi),
                        _dir=point_direction(x,y,_floor.x,_floor.y)+_offset,
                        _hs=lengthdir_x(_len,_dir)*timescale,_vs=lengthdir_y(_len,_dir)*timescale
                    if(place_free(x+_hs,y)) hspeed=_hs
                    if(place_free(x,y+_vs)) vspeed=_vs
                    image_angle+=_offset/10*timescale
                    if((current_frame%2)<timescale && random(5)<1) with(instance_create(x,y,Dust)) depth=other.depth+1
                }
            }
        }
    }
    return _targets
}
function scrNTTEFullLockedQuestPickupFade(_pickup) {
    with(_pickup) {
        scrNTTEFullChickenBFx(x,y)
        with(instance_create(x,y,BoltTrail)) {
            sprite_index=other.sprite_index;image_index=1;image_speed=0;image_angle=other.image_angle
        }
    }
}
function scrNTTEFullLockedQuestHeartBalls(_pickup) {
    var _parts=scrNTTEFullQuestPartList(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined))
    for(var _i=0;_i<array_length(_parts);++_i) {
        var _part=_parts[_i],_dir=_pickup.image_angle+180+360*_i/array_length(_parts),
            _heart=instance_create(_pickup.x,_pickup.y,NTTEFullCrystalHeartBullet)
        _heart.direction=_dir;_heart.depth=-3
        switch(_part) {
            case 0:_heart.area=area_vault;_heart.area_goal=2;_heart.area_chest=[RadChest];break
            case 1:_heart.area=area_palace;_heart.area_goal=12;_heart.area_chest=[AmmoChest];break
            case 2:_heart.area=area_hq;_heart.area_goal=8;_heart.area_chest=[IDPDChest];break
            case 3:_heart.area=scrNTTEFullAreaId("red");_heart.area_goal=10;_heart.area_chest=[HealthChest];break
        }
        repeat(4) {
            with(instance_create(_pickup.x,_pickup.y,Smoke)) { motion_set(_dir,3*timescale);depth=-4 }
            var _sparkle=scrNTTEFullLockedQuestSparkle(_pickup.x+orandom(6),_pickup.y+orandom(6),_part,-3)
            with(_sparkle) motion_add(_dir+orandom(5),random_range(2,3)*timescale)
        }
    }
    return array_length(_parts)>=4
}
function scrNTTEFullLockedQuestMerge(_one,_two) {
    scrNTTEFullLockedQuestPickupFade(_two);scrNTTEFullLockedQuestPickupFade(_one)
    var _ammo=max(_one.ammo,_two.ammo),_curse=max(_one.curse,_two.curse),
        _model=scrNTTEFullWeaponMerge(_one.wep,_two.wep),
        _pickup=scrWeaponPickupCreate(lerp(_one.x,_two.x,0.5),lerp(_one.y,_two.y,0.5),_model)
    _pickup.ammo=_ammo;_pickup.curse=_curse;_pickup.image_angle=point_direction(_pickup.x,_pickup.y,x,y+32)+orandom(5)
    _pickup.image_index=1
    with(instance_create(_pickup.x,_pickup.y,BoltTrail)) {
        sprite_index=_pickup.sprite_index;image_index=1;image_speed=0;image_angle=_pickup.image_angle
    }
    snd_play(sndCrystalRicochet,1.5,1.5);snd_play(sndCrownGuardianAppear,0.8,1.5)
    if(scrNTTEFullLockedQuestHeartBalls(_pickup)) is_unlockable=true
    instance_destroy(_one);instance_destroy(_two)
    if(!is_playing_music) { is_playing_music=true;with(MusCont) { alarm[4]=1;alarm[3]=-1 } }
    return _pickup
}
function scrNTTEFullLockedQuestGlow(_one,_two,_scale) {
    var _glow=instance_create(0,0,NTTEFullQuestMergingGlow)
    _glow.depth=-3;_glow.targets=[_one,_two];_glow.scale=_scale
}
function scrNTTEFullLockedQuestMergeStep() {
    if(instance_exists(enemy) || instance_exists(NTTEFullCrystalHeartBullet)) {
        if(is_playing_music) with(MusCont) if(alarm[1]>0) alarm[1]=-1
        return;
    }
    if(is_playing_music) { is_playing_music=false;with(MusCont) alarm[1]=1 }
    if(distance_to_object(Player)>=128 && merge_delay>=max_merge_delay) return;
    var _floors=scrNTTEFullInstances(NTTEFullQuestFloorCont),_targets=scrNTTEFullLockedQuestCollect(_floors)
    if(array_length(_targets)<4 || array_get_index(_targets,noone)>=0) { merge_delay=max_merge_delay;return }
    if(merge_delay>0) merge_delay-=timescale
    var _pairs=[[0,1],[2,3],[1,2]]
    for(var _i=0;_i<array_length(_pairs);++_i) {
        var _a=_pairs[_i][0],_b=_pairs[_i][1]
        if(_targets[_a]!=_targets[_b]) {
            var _scale=1-clamp((merge_delay-3)/(max_merge_delay-(3+max_merge_delay/3)),0,1)
            if(_scale>0) {
                scrNTTEFullLockedQuestGlow(_floors[_a],_floors[_b],_scale)
                if(_scale<1) {
                    var _snd=snd_play(sndCrownGuardianAppear,lerp(0.8,1.8,_scale),1)
                    if(audio_is_playing(_snd)) audio_sound_set_track_position(_snd,0.2*_scale)
                    _snd=snd_play(sndHover,lerp(2,1.2,_scale),0.5)
                    if(audio_is_playing(_snd)) audio_sound_set_track_position(_snd,0.15*_scale)
                }
            }
            if(merge_delay<=0) { merge_delay=max_merge_delay;scrNTTEFullLockedQuestMerge(_targets[_a],_targets[_b]) }
            break
        }
    }
}
function scrNTTEFullLockedQuestUnlock(_player) {
    var _ok=false
    if(instance_exists(prompt)) with(prompt) _ok=scrNTTEFullLockedQuestPromptMeet(_player)
    if(!_ok) return false
    instance_create(x,y,NTTEFullHugeQuestChest)
    snd_play(sndHammerHeadEnd,0.7);snd_play(sndStatueCharge,0.7)
    for(var _dir=0;_dir<360;_dir+=360/16) {
        var _dust=instance_create(clamp(x+lengthdir_x(bbox_right-bbox_left,_dir),bbox_left,bbox_right),
            clamp(y+lengthdir_y(bbox_bottom-bbox_top,_dir),bbox_top,bbox_bottom),Dust)
        with(_dust) { motion_set(_dir,timescale);depth=other.depth-sign(y-other.y) }
    }
    var _part=scrNTTEFullWeaponModel(_player.wep),_parts=[_part],_angle=random(360)
    while(scrNTTEFullWeaponHasMerge(_part)!=false) {
        var _front=scrNTTEFullWeaponMergedPart(_part)
        variable_struct_remove(_part,"temerge")
        scrNTTEFullWeaponNativeRefresh(scrNTTEFullWeaponNative(_part))
        array_push(_parts,_front);_part=_front
    }
    for(var _i=array_length(_parts)-1;_i>=0;--_i) {
        var _dir=_angle+360*_i/array_length(_parts),_bone=scrNTTEFullCrabboneQuestBreak(_player,_parts[_i],_dir)
        if(instance_exists(_bone)) with(_bone) {
            scrNTTEFullTrenchShake(x,y,4)
            with(instance_create(x,y,MeleeHitWall)) { motion_add(_dir,timescale);image_angle=direction+180 }
        }
    }
    with(_player) { wep=wep_none;ntte_state=undefined;scrSwapWeps(false);clicked=false;swapmove=1;drawempty=30 }
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    instance_destroy(id,false)
    return true
}
function scrNTTEFullLockedQuestStep() {
    if(random(30)<timescale) scrNTTEFullLockedQuestSparkle(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),-1,depth-1)
    var _players=scrNTTEFullInstances(Player)
    if(place_meeting(x,y,Player)) for(var _i=0;_i<array_length(_players);++_i) with(_players[_i])
        if(place_meeting(x,y,other.id)) scrNTTEFullNativeMotionAddFT(id,point_direction(other.x,other.y,x,y),1)
    scrNTTEFullLockedQuestMergeStep()
    if(instance_exists(prompt)) {
        prompt.visible=is_unlockable;var _pick=prompt.pick,_player=noone
        with(Player) if(index==_pick) _player=id
        if(instance_exists(_player)) scrNTTEFullLockedQuestUnlock(_player)
    }
}
function scrNTTEFullLockedQuestGlowDraw() {
    if(scale>0) {
        var _x=0,_y=0,_num=0,_blend=gpu_get_blendmode()
        gpu_set_blendmode(bm_add)
        for(var _i=0;_i<array_length(targets);++_i) if(instance_exists(targets[_i])) {
            var _target=targets[_i].target
            if(instance_exists(_target)) with(_target) {
                var _alpha=image_alpha;image_alpha*= other.scale;draw_self();image_alpha=_alpha
            }
            _x+=targets[_i].x;_y+=targets[_i].y;_num+=1
        }
        gpu_set_blendmode(bm_normal)
        if(_num>0) {
            _x/=_num;_y/=_num
            for(var _i=0;_i<array_length(targets);++_i) if(instance_exists(targets[_i]) && random(3)<timescale) {
                var _sparkle=scrNTTEFullLockedQuestSparkle(targets[_i].x+orandom(16),targets[_i].y+orandom(16),targets[_i].part_index,depth+1)
                with(_sparkle) motion_add(point_direction(x,y,_x,_y),random_range(0.5,1)*timescale)
            }
            var _s=(1+random(0.2))*scale
            draw_sprite_ext(scrNTTERefSprite("CrystalHeartBullet"),0,_x,_y,_s,_s,current_frame,c_white,1)
            gpu_set_blendmode(bm_add)
            draw_sprite_ext(scrNTTERefSprite("CrystalHeartBullet"),0,_x,_y,_s*2,_s*2,current_frame,c_white,0.1*scale)
        }
        gpu_set_blendmode(_blend)
    }
    instance_destroy()
}
