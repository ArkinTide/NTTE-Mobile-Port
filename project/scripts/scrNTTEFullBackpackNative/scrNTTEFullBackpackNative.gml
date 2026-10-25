// tepickups54..358 Backpack,2704..2770 CursedAmmoChest. Genuine merged
// weapons, independently armed native Allies and airborne reward wrappers.
function scrNTTEFullBackpackCreate() {
    sprite_index=scrNTTERefSprite("Backpack");spr_dead=scrNTTERefSprite("BackpackOpen")
    spr_shadow=shd16;spr_shadow_y=2;snd_open=choose(sndMenuASkin,sndMenuBSkin)
    num=2;raddrop=8;ally=0
    curse=scrCrownCheck(crwn_curses)?random(3)<2:(GameCont.crown==0?false:random(7)<1)
    if(curse>0) {sprite_index=scrNTTERefSprite("BackpackCursed");spr_dead=scrNTTERefSprite("BackpackCursedOpen")}
    on_step=scrNTTEFullBackpackStep;on_open=scrNTTEFullBackpackOpen
}
function scrNTTEFullBackpackStep() {
    if(random(20)<curse*timescale) with(instance_create(x+orandom(8),y+orandom(8),Curse)) depth=other.depth-1
}
function scrNTTEFullBackpackNew(_before) {
    var _now=scrNTTEFullInstances(all),_new=[]
    for(var _i=0;_i<array_length(_now);++_i) if(array_get_index(_before,_now[_i])<0) array_push(_new,_now[_i])
    return _new
}
function scrNTTEFullBackpackAmmoCollect(_opener) {
    var _who=instance_is(_opener,Player)?_opener:instance_nearest(x,y,Player),_num=ntte_full_ammo_num
    with(scr_ultra_get(Race.CoopUltra,1)?Player:_who) {
        var _type=scrAmmoDecideType(id,false),_amount=round(typ_ammo[_type]*_num)
        if(scrCrownCheck(crwn_haste)) _amount+=1
        scrPlayerGiveAmmo(id,_type,_amount,true)
    }
    instance_create(x,y,SmallChestPickup);snd_play(sndAmmoPickup);instance_destroy()
}
function scrNTTEFullSourceAmmoPickupCreate() {
    // Source caller configures num/cursed after creation. Keep the native
    // AmmoPickup motion, attraction, collisions and fade lifecycle, without
    // replacing this configured instance during a native random curse roll.
    sprite_index=sprAmmo;mask_index=mskPickup;friction=0.2*timescale*timescale;blink=30
    alarm[0]=ceil((200+random(30))/(1+GameCont.loops/5)*scrCustomModePickupTimeMult())
    if(scrCrownCheck(crwn_haste)) alarm[0]/=3
    image_speed=0;ntte_full_ammo_num=1;cursed=false
    scrNTTEFullParrotChestWatch(id,true)
}
function scrNTTEFullBackpackSetAmmo(_item,_curse,_num,_time) {
    if(!instance_exists(_item)) return noone
    _item.sprite_index=sprCursedAmmo;_item.cursed=_curse;_item.ntte_full_ammo_num=_num
    _item.alarm[0]=_time
    return _item
}
function scrNTTEFullBackpackWrap(_target,_direction) {
    if(!instance_exists(_target)) return noone
    var _wrapper=instance_create(_target.x,_target.y,NTTEFullBackpackPickup)
    _wrapper.direction=_direction;_wrapper.target=_target
    with(_wrapper) scrNTTEFullBackpackPickupEndStep()
    return _wrapper
}
function scrNTTEFullBackpackOpen(_opener) {
    GameCont.ntte_backpack_opened=true
    snd_play(sndPickupDisappear,1+orandom(0.4),2)
    if(curse>0) snd_play(sndCursedChest)
    var _angle=random(360)
    for(var _direction=_angle;_direction<_angle+360;_direction+=360/max(1,ally)) {
        var _count=1+scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)
        if(_count>0) {
            // Optional defpack-tools integration is absent in this standalone
            // port, so source takes its ordinary real merged-weapon branch.
            var _weapon=scrNTTEFullMergedWeaponDecide(0,max(1,GameCont.hard-1)+2*curse)
            repeat(_count) {
                var _debrisAngle=random(360),_parts=irandom_range(2,3)
                for(var _partAngle=_debrisAngle;_partAngle<_debrisAngle+360;_partAngle+=360/_parts) {
                    var _part=instance_create(x,y,Shell)
                    with(_part) {
                        sprite_index=scrNTTERefSprite("BackpackDebris");image_index=irandom(image_number-1);image_speed=0
                        image_xscale=choose(-1,1);image_angle=orandom(10)
                        scrNTTEFullNativeMotionAddFT(id,_partAngle+orandom(70),3)
                    }
                }
            }
            if(ally>0) {
                var _creator=instance_is(_opener,Player)?_opener:instance_nearest(x,y,Player),
                    _friend=instance_create(x,y,NTTEFullCrystalAlly)
                with(_friend) {
                    scrNTTEFullNativeMotionAddFT(id,_direction,3);creator=_creator
                    sprite_index=sprAllyIdle
                    var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("AllyAlert"),id)
                    if(instance_exists(_alert)) _alert.flash=6+random(3)
                    sprite_index=spr_idle
                }
                if(_weapon!=wep_none) {
                    var _controller=instance_create(_friend.x,_friend.y,NTTEFullCrystalFireWeapon)
                    _controller.creator=_friend;_controller.wep=scrNTTEFullWeaponNative(_weapon)
                }
                _count-=1
            }
            if(_weapon!=wep_none && _count>0) repeat(_count) {
                var _pickup=scrWeaponPickupCreate(x,y,_weapon,true)
                _pickup.curse=curse;_pickup.ammo=true
            }
        }
    }
    _angle=random(360)
    var _pickups=ceil(num*power(1.4,scr_skill_get(mut_rabbit_paw)))
    if(_pickups>0) for(var _dir=_angle;_dir<_angle+360;_dir+=360/_pickups) {
        var _before=scrNTTEFullInstances(all)
        with(instance_create(x,y,Dust)) depth=other.depth
        if(ally<=0 && random(40)<1) {
            var _bandit=instance_create(x,y,Bandit)
            _bandit.sprite_index=_bandit.spr_hurt
            var _alert=scrNTTEAlertCreate(_bandit.x,_bandit.y,scrNTTERefSprite("BanditAlert"),_bandit)
            if(instance_exists(_alert)) _alert.flash=6+random(3)
        }
        else {
            scrNTTEFullPickupDropBody(100/scrNTTEFullPickupChanceMultiplier(),0)
            var _forAlly=ally>0,_rogue=false,_red=false,
                _player=instance_is(_opener,Player)?_opener:instance_nearest(x,y,Player)
            if(instance_exists(_player)) {
                _rogue=_player.race==Race.Rogue
                _red=scrNTTEFullRedAmmoWeaponCost(_player.wep)>0 || scrNTTEFullRedAmmoWeaponCost(_player.bwep)>0
            }
            var _new=scrNTTEFullBackpackNew(_before)
            for(var _i=0;_i<array_length(_new);++_i) {
                var _item=_new[_i]
                if(!instance_exists(_item)) continue
                switch(_item.object_index) {
                    case AmmoPickup:
                        if(_forAlly) {instance_create(_item.x,_item.y,HPPickup);instance_destroy(_item,false)}
                        else if(random(4)<_rogue) {instance_create(_item.x,_item.y,RogueAmmo);instance_destroy(_item,false)}
                        else if(random(4)<_red) {instance_create(_item.x,_item.y,NTTEFullRedAmmoPickup);instance_destroy(_item,false)}
                        else if(curse>scrNTTEFullValue(_item,"cursed",false))
                            scrNTTEFullBackpackSetAmmo(_item,curse,1+0.5*curse,scrNTTEFullPickupAlarm(200+random(30),0.2)/(1+2*curse))
                        break
                    case AmmoChest:
                        if(_forAlly) {instance_create(_item.x,_item.y,HealthChest);instance_destroy(_item,false)}
                        else if(random(4)<_rogue) {scrNTTEFullLairChestCreate(_item.x,_item.y,RogueChest);instance_destroy(_item,false)}
                        else if(random(4)<_red) {scrNTTEFullLairChestCreate(_item.x,_item.y,"RedAmmoChest");instance_destroy(_item,false)}
                        else if(curse>0) {scrNTTEFullLairChestCreate(_item.x,_item.y,"CursedAmmoChest");instance_destroy(_item,false)}
                        break
                }
            }
        }
        var _new=scrNTTEFullBackpackNew(_before)
        for(var _i=0;_i<array_length(_new);++_i) {
            var _item=_new[_i]
            if(!instance_exists(_item)) continue
            if(instance_is(_item,AmmoPickup) || instance_is(_item,HPPickup) || instance_is(_item,RogueAmmo)
                || instance_is(_item,NTTEFullCustomPickup) || instance_is(_item,chestprop) || instance_is(_item,hitme))
                scrNTTEFullBackpackWrap(_item,_dir)
        }
    }
    var _rads=raddrop+scrPlayerCountRace(Race.Melting)
    if(_rads>0) repeat(_rads) with(instance_create(x,y,Rad)) scrNTTEFullNativeMotionAddFT(id,random(360),random_range(3,5))
    if(scr_skill_get(mut_strong_spirit)>0) with(instance_is(_opener,Player)?_opener:Player) {
        if(!can_spirit) {
            can_spirit=true
            // Epsilon's persistent ready-state array uses its own native name.
            if(variable_instance_exists(GameCont,"canspirit")) GameCont.canspirit[index]=false
            with(instance_create(x,y,StrongSpiritRefill)) creator=other.id
            snd_play(sndStrongSpiritGain)
        }
    }
}
function scrNTTEFullCursedAmmoChestCreate() {
    var _loaded=scr_ultra_get(Race.Steroids,UltraSkill.GetLoaded)>0
    sprite_index=scrNTTERefSprite(_loaded?"CursedAmmoChestSteroids":"CursedAmmoChest")
    spr_dead=scrNTTERefSprite(_loaded?"CursedAmmoChestSteroidsOpen":"CursedAmmoChestOpen")
    snd_open=sndAmmoChest;num=_loaded?20:10;on_step=scrNTTEFullCursedAmmoChestStep;on_open=scrNTTEFullCursedAmmoChestOpen
}
function scrNTTEFullCursedAmmoChestStep() {
    if(random(12)<timescale) with(instance_create(x+orandom(4),y-2+orandom(4),Curse)) depth=other.depth-1
}
function scrNTTEFullCursedAmmoChestOpen(_opener) {
    snd_play(sndCursedChest);instance_create(x,y,PortalClear);instance_create(x,y,ReviveFX)
    repeat(num) {
        var _wrapper=instance_create(x+orandom(4),y+orandom(4),NTTEFullBackpackPickup),
            _item=instance_create(_wrapper.x,_wrapper.y,NTTEFullSourceAmmoPickup)
        _wrapper.target=_item
        scrNTTEFullBackpackSetAmmo(_item,true,1.5,scrNTTEFullPickupAlarm(120+random(30),0.2))
        with(_wrapper) {
            var _scale=random_range(1.5,2)
            speed*=_scale;zspeed*=_scale-0.5
            with(instance_create(x,y,Curse)) {
                depth=other.depth-1;scrNTTEFullNativeMotionAddFT(id,other.direction,random(_scale))
            }
            scrNTTEFullBackpackPickupEndStep()
        }
    }
}
