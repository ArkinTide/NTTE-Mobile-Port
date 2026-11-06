// tepickups1224..1292,1384..1554. Genuine airborne chests and animated
// guardian pedestal. Excavation and natural event binding are separate.
function scrNTTEFullBuriedVaultChestCreate() {
    sprite_index=scrNTTERefSprite("BuriedVaultChest");spr_dead=scrNTTERefSprite("BuriedVaultChestOpen")
    spr_shadow=-1;snd_open=sndBigWeaponChest;num=3+scr_skill_get(mut_open_mind)
    on_open=scrNTTEFullBuriedVaultChestOpen
}
function scrNTTEFullBuriedVaultChestOpen(_opener) {
    if(instance_is(_opener,Player)) snd_play(_opener.snd_chst)
    var _angle=random(360)
    if(num>0) for(var _dir=_angle;_dir<_angle+360;_dir+=360/num) {
        var _wrapper=instance_create(x,y,NTTEFullBackpackPickup)
        _wrapper.zfriction=0.6;_wrapper.zspeed=random_range(3,4)
        _wrapper.speed=(1.5+orandom(0.2))*timescale;_wrapper.direction=_dir
        _wrapper.target=scrNTTEFullLairChestCreate(x,y,scrNTTEFullTunnellerPool([
            [AmmoChest,1],[WeaponChest,1],[HealthChest,1],["Backpack",1],["OrchidChest",1]]))
        with(_wrapper) scrNTTEFullBackpackPickupEndStep()
    }
    snd_play(sndStatueXP,0.5+orandom(0.1));snd_play(sndExplosion,1.4+random(0.3),0.8)
    with(instance_create(x,y-2,FXChestOpen)) {
        sprite_index=sprMutant6Dead;image_index=9;image_xscale*=0.75;image_yscale=image_xscale
        image_blend=make_color_rgb(random_range(120,190),255,8)
    }
    var _lid=instance_create(x,y-2,NTTEFullBuriedVaultChestDebris)
    // num0 has no loot sectors. Keep a finite ballistic lid direction when
    // signed OpenMind cancels all goodies, avoiding a native divide by zero.
    var _offset=random_range(1/3,2/3)
    _lid.direction=num==0?_angle:_angle+(360/num)*_offset
}
function scrNTTEFullBuriedVaultPedestalSelect() {
    return scrNTTEFullTunnellerPool([["BuriedVaultChest",4],[BigWeaponChest,1],
        [ProtoChest,!instance_exists(ProtoChest)],[ProtoStatue,2*(GameCont.subarea==2)],[HostileHorror,1/5]])
}
function scrNTTEFullBuriedVaultPedestalLoot(_chest) {
    var _before=scrNTTEFullInstances(all)
    target=scrNTTEFullLairChestCreate(x,y+2,_chest)
    if(instance_exists(target)) with(target) {
        x=xstart;y=ystart
        switch(object_index) {
            case HostileHorror:
                instance_create(x,y,PortalShock);other.spawn=0
                break
            case ProtoChest:
                if(wep==wep_rusty_revolver) {
                    sprite_index=scrNTTERefSprite("ProtoChestMerge")
                    wep=scrNTTEFullWeaponNative(scrNTTEFullMergedWeaponDecide(0,3+GameCont.hard))
                }
                break
            case ProtoStatue:
                y-=12;spr_shadow=-1
                var _new=scrNTTEFullBackpackNew(_before)
                for(var _i=0;_i<array_length(_new);++_i)
                    if(instance_exists(_new[_i]) && instance_is(_new[_i],Bandit) && _new[_i].id>id) instance_destroy(_new[_i],false)
                break
            case RadChest:
                y-=4;spr_idle=sprRadChestBig;spr_hurt=sprRadChestBigHurt;spr_dead=sprRadChestBigDead
                break
        }
        var _new=scrNTTEFullBackpackNew(_before)
        for(var _i=0;_i<array_length(_new);++_i)
            if(instance_exists(_new[_i]) && instance_is(_new[_i],PortalClear) && _new[_i].id>id) instance_destroy(_new[_i])
    }
    var _rad=instance_is(target,RadChest)?30:15,
        _num=irandom_range(1,2)+floor(_rad/15)+scr_skill_get(mut_open_mind)+(_chest==ProtoStatue),_angle=random(360)
    if(_num>0) for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
        var _length=random_range(16,36),_direction=_dir+orandom(360/_num*0.4),
            _item=scrNTTEFullLairChestCreate(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),random(4)<1?"OrchidChest":RadChest)
        if(instance_is(_item,RadChest) && random(6)<1) {
            _item.spr_idle=sprRadChestBig;_item.spr_hurt=sprRadChestBigHurt;_item.spr_dead=sprRadChestBigDead
        }
    }
    scrNTTEFullRadDrop(x,y,_rad,random(360),0)
}
function scrNTTEFullBuriedVaultPedestalCreate() {
    // Source is a CrownPed only when none exists; native subtype preserves
    // its identity for CrownPickup/vault cleanup while overriding its Step.
    if(object_index==NTTEFullBuriedVaultPedestal && !instance_exists(CrownPed)) {
        instance_change(NTTEFullBuriedVaultCrownPed,true);return;
    }
    sprite_index=scrNTTERefSprite("BuriedVaultChestBase");image_speed=0.4*timescale;depth=2
    mask_index=mskSalamander;spawn=irandom_range(1,2)+GameCont.crownvisits
    spawn_time=0;spawn_inst=[];target=noone
    scrNTTEFullBuriedVaultPedestalLoot(scrNTTEFullBuriedVaultPedestalSelect())
}
function scrNTTEFullBuriedVaultPedestalStep() {
    if(lockstep_stop) return;
    if(image_speed!=0) {
        if(instance_exists(target) && place_meeting(x,y,target)
            && (!instance_is(target,ProtoChest) || target.sprite_index!=sprProtoChestOpen)
            && (!instance_is(target,ProtoStatue) || target.hp>=target.max_hp*0.7)) {
            image_index=0
            if(instance_is(target,NTTEFullBuriedVaultChest)) {target.x=x;target.y=y;target.speed=0}
        }
        else if(image_index+image_speed>=image_number) {image_speed=0;image_index=image_number-1}
    }
    else if(spawn>0) {
        if(spawn_time>0) {
            spawn_time-=timescale
            if(spawn_time<=0) {
                spawn_time=10;spawn-=1;snd_play(sndCrownGuardianAppear,1+random(0.4))
                var _near=instance_nearest(x,y,Floor),_floors=scrNTTEFullInstances(Floor),_candidates=[]
                for(var _i=0;_i<array_length(_floors);++_i) {
                    var _floor=_floors[_i]
                    if(_floor!=_near && _floor.bbox_right>=x-96 && _floor.bbox_left<x+96
                        && _floor.bbox_bottom>=y-96 && _floor.bbox_top<y+96) array_push(_candidates,_floor)
                }
                var _guardian=noone
                if(array_length(_candidates)>0) {
                    var _floor=_candidates[irandom(array_length(_candidates)-1)]
                    _guardian=instance_create((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,CrownGuardian)
                    scrNTTEFullPortalPoof()
                }
                if(instance_exists(_guardian)) {
                    _guardian.spr_idle=sprCrownGuardianAppear;_guardian.sprite_index=_guardian.spr_idle
                    scrNTTEFullWorldWallClear(_guardian)
                }
                array_push(spawn_inst,_guardian)
            }
        }
        else {
            spawn_time=30;GameCont.buried_vaults=scrNTTEFullValue(GameCont,"buried_vaults",0)+1
            scrNTTEFullPortalPoof();snd_play(sndCrownGuardianDisappear,0.7+random(0.2))
            with(MusCont) {
                var _area=GameCont.area
                try {GameCont.area=-1;event_perform(ev_alarm,11)}
                finally {GameCont.area=_area}
                alarm[3]=-1;alarm[4]=1
            }
        }
    }
    if(instance_exists(target) && instance_is(target,ProtoStatue) && target.canim>0) {
        image_index=max(0,image_number-1-0.5*target.canim);image_speed=0.4*timescale
    }
}
