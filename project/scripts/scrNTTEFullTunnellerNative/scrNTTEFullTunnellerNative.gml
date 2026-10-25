// Original tunneller.wep.gml. Physical RedFireCharge state and genuine
// FireBurst descendants preserve the held weapon, ownership and delayed shots.
function scrNTTEFullTunnellerGold(_weapon,_state=undefined) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    // A genuine merged/native fire mounts this physical part as its raw type
    // so legacy scrFire can execute. Gold lives on the original source LWO,
    // whose identity is scoped by the shared state-fire context.
    if(variable_global_exists("ntte_full_merged_state_fire") && is_struct(global.ntte_full_merged_state_fire)) {
        var _part=global.ntte_full_merged_state_fire.part
        if(scrNTTEFullWeaponRaw(_part)==scrNTTEFullWeaponRaw(_weapon)) _model=_part
    }
    return scrNTTEFullWeaponRaw(_weapon)==wep_ntte_golden_tunneller
        || scrNTTEFullValue(_model,"gold",false)!=0 || scrNTTEFullValue(_state,"gold",false)!=0
}
function scrNTTEFullTunnellerChargeTick(_state,_primary=true) {
    scrNTTEFullRedWeaponState(_state)
    var _load=scrNTTEFullValue(id,"reloadspeed",1)*timescale
    _state.chrg=(_state.chrg_num<_state.chrg_max)?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_state.chrg_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_state.chrg_max
    }
    else if((current_frame%12)<timescale) gunshine=2
    _state.charge=_state.chrg_num;reload=min(reload,_load)
    var _charge=_state.chrg_num/_state.chrg_max,_kick=-8*_charge
    if(wkick!=_kick) scr_weapon_post(gunangle,8*_charge*timescale,0,_kick)
    if((current_frame%5)<timescale) {
        var _distance=random(16)-wkick,_angle=gunangle+wepangle*(1-wkick/20)
        scrNTTEFullCrystalBrainEffect(x+lengthdir_x(_distance,_angle),y+lengthdir_y(_distance,_angle))
    }
    if(_state.chrg==1) {
        scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,0.4+0.2*_charge,0.5,1.55)
        snd_play(sndCrystalTB,1/(1-0.25*_charge),1)
        if(_charge>=1) {
            snd_play(sndGoldUnlock,2.5+orandom(0.2));snd_play(sndCrystalJuggernaut,2)
            var _angle=gunangle+wepangle,_fx=instance_create(x+lengthdir_x(24,_angle),y+lengthdir_y(24,_angle),PlasmaTrail)
            _fx.sprite_index=sprThrowHit;_fx.image_speed=0.4*timescale;_fx.image_angle=random(360)
            _fx.image_blend=scrAreaGetBackroundColor(scrNTTEFullAreaId("red"));_fx.depth=depth-1
            var _fx2=instance_create(_fx.x,_fx.y,PlasmaTrail)
            _fx2.sprite_index=_fx.sprite_index;_fx2.image_speed=timescale;_fx2.image_angle=_fx.image_angle;_fx2.depth=_fx.depth-1
            scrNTTEFullTrenchShake(x,y,10);sleep(5)
        }
    }
    scrNTTEFullRedFireChargeRefresh(_state,_primary)
}
function scrNTTEFullTunnellerInput(_weapon,_primary) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState()),
        _held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index]
    if(!scrNTTEFullEntanglerCanCharge() && _state.chrg_num<=0) return false
    if(_held && scrNTTEFullEntanglerCanCharge() && (can_shoot || _state.chrg_num>0)) {
        scrNTTEFullWeaponDropFire(_weapon);scrNTTEFullTunnellerChargeTick(_state,_primary)
        return true
    }
    if((!_held || !scrNTTEFullEntanglerCanCharge()) && _state.chrg_num>0) {
        scrNTTEFullRedWeaponCharging(_state,-1);scrFire(_weapon,true,_primary)
        scrNTTEFullRedWeaponCharging(_state,0)
    }
    return true
}
function scrNTTEFullTunnellerPool(_entries) {
    // telib.pool starts at total-random(total), then subtracts in source order.
    // This matters for deterministic seeded rewards, not only probabilities.
    var _total=0
    for(var _i=0;_i<array_length(_entries);++_i) _total+=_entries[_i][1]
    var _roll=_total-random(_total)
    for(var _i=0;_i<array_length(_entries);++_i) {
        _roll-=_entries[_i][1]
        if(_roll<=0) return _entries[_i][0]
    }
    return undefined
}
function scrNTTEFullTunnellerRewards(_bullet) {
    with(_bullet) {
        area_chest=[]
        if(random(5)<3) {
            var _type="normal"
            if(random(10)<1) _type=scrNTTEFullTunnellerPool([
                ["mutation",1],["orchid",scrNTTEFullUnlockGet("orchid:seen",false)],
                ["lair",scrNTTEFullUnlockGet("crown:crime",false)]])
            switch(_type) {
                case "mutation":area_chest=[scrNTTEFullTunnellerPool([["SpiritChest",1],["HammerHeadChest",1]])];break
                case "orchid":area_chest_pos="random";area_chest=array_create(irandom_range(1,4),"OrchidChest");break
                case "lair":area_chest=scrNTTEFullTunnellerPool([
                    [["CatChest","BatChest"],2],[["CatChest","RatChest"],1],[["BatChest","RatChest"],1]]);break
                default:area_chest=[scrNTTEFullTunnellerPool([
                    [AmmoChest,5],[WeaponChest,5],["Backpack",3],["BonusAmmoChest",2],["BonusHealthChest",2]])];break
            }
        }
        if(random(15)<1) array_push(area_chest,"RedAmmoChest")
        if(!array_length(area_chest)) array_push(area_chest,RadChest)
        var _mind=round(scr_skill_get(mut_open_mind)),_originalCount=array_length(area_chest)
        repeat(abs(_mind)) {
            if(_mind>0) array_push(area_chest,area_chest[irandom(_originalCount-1)])
            else if(_originalCount>0) {array_delete(area_chest,irandom(_originalCount-1),1);_originalCount-=1}
            else break
        }
    }
}
function scrNTTEFullRedShankCreate() {
    sprite_index=scrNTTERefSprite("RedShank");damage=10;force=6;knockback_speed=6*timescale
}
function scrNTTEFullTunnellerBurstOne(_weapon,_primary,_burst,_context) {
    // Delayed shots use the original physical weapon's captured gold flag;
    // later changes to held-slot charge cannot turn them into chaos balls.
    var _skill=scr_skill_get(mut_long_arms),_distance=10*_skill,_angle=gunangle,
        _shot=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(_distance,_angle),y+lengthdir_y(_distance,_angle),
            NTTEFullRedShank,_angle+orandom(10*accuracy),lerp(3,6,_skill))
    _shot.primary=_primary
    var _gold=_context.gold
    if(_gold) _shot.sprite_index=scrNTTERefSprite("RedShankGold")
    scrNTTEFullRedWeaponGunSound(_gold?sndGoldScrewdriver:sndScrewdriver,0.2,0.6)
    scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,1+random(0.5),0.4,1.5)
    scr_weapon_post(_angle,8,2,-9);scrNTTEFullNativeMotionAddFT(id,_angle,3)
    return _shot
}
function scrNTTEFullTunnellerFire(_weapon,_primary=true) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState())
    if(_state.chrg>=0 && scrNTTEFullEntanglerCanCharge()) {
        scrNTTEFullTunnellerChargeTick(_state,_primary)
        return noone
    }
    var _owner=scrNTTEFullRedWeaponOwner(),_gold=scrNTTEFullTunnellerGold(_weapon,_state),_shot=noone
    if(_state.chrg_num>=_state.chrg_max && scrNTTEFullEntanglerCanCharge(_owner)) {
        _owner.ntte_red_ammo-=1
        var _skill=scr_skill_get(mut_laser_brain)
        _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullCrystalHeartBullet,gunangle+orandom(4*accuracy),4)
        _shot.primary=_primary;_shot.image_xscale+=0.15*_skill;_shot.image_yscale+=0.15*_skill
        _shot.area_goal=irandom_range(8,12)+4*_gold;_shot.area_chaos=random(2)<1
        scrNTTEFullTunnellerRewards(_shot)
        with(instance_create(_shot.x,_shot.y,ThrowHit)) image_blend=scrAreaGetBackroundColor(_shot.area)
        var _pitch=random_range(0.8,1.2)
        snd_play(sndHyperCrystalSearch,(_skill>0?1.2:1.4)*_pitch)
        snd_play(_gold?sndGoldPlasmaUpg:sndUltraGrenade,_pitch);snd_play(sndGammaGutsKill,1.4*_pitch)
        scrNTTEFullRedWeaponSound(_skill>0?sndDevastatorUpg:sndDevastator,0.8*_pitch,1,0.6)
        scr_weapon_post(gunangle,24,12,12);scrNTTEFullNativeMotionAddFT(id,gunangle+180,4)
        move_contact_solid(gunangle+180,4)
        if(_skill>0) with(instance_create(x,y,LaserBrain)) creator=other.id
        sleep(20)
    }
    else {
        var _context={gold:_gold}
        // weapon_burst is1 while charging/full, otherwise3. A partial release
        // is uncharged by fire_init and therefore emits the source three stabs.
        scrNTTEFullNativeFireBurstStart(_weapon,3,4,_primary,scrNTTEFullTunnellerBurstOne,_context,4)
        _shot=scrNTTEFullTunnellerBurstOne(_weapon,_primary,1,_context)
    }
    return _shot
}

// tecaves CrystalHeartBullet_hit: NP ignores enemy immunity and its fourth
// argument is player freeze10, not an enemy ten-tick immunity timer.
function scrNTTEFullCrystalHeartNativeHit(_target) {
    if(lockstep_stop || !scrNTTEFullNativeProjectileCanHitNP(_target)
        || (!instance_is(_target,Player) && !current_frame_active)) return;
    if(_target.team!=team && _target.nexthurt<=current_frame) {x-=hspeed;y-=vspeed}
    var _divisor=instance_is(creator,Player)?power(2,1+scr_skill_get(mut_laser_brain)):2
    speed=min(speed,maxspeed/_divisor*timescale)
    scrNTTEFullNativeProjectileHitNP(_target,damage,12,10)
    snd_play(sndGammaGutsProc,0.8+random(0.4),1.5);scrNTTEFullTrenchShake(x,y,4)
}
