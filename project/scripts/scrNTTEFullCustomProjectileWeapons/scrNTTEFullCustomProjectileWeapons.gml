// Original weps/harpoon launcher.wep.gml22..50 and net launcher22..36.
// These physical sources use the complete original object implementations.
function scrNTTEFullCustomProjectileGunSound(_asset,_random_pitch,_fade) {
    var _channel=snd_play_gun(_asset,_random_pitch)
    // NTT's API signature maps sound_play_gun to snd_play_gun_ext; its third
    // argument is background-emitter fade, including authored negative values.
    // It does not change the gun channel's own gain.
    if(!scr_test_is_fps_uncapped()) with(UberCont) {
        mainvol=_fade
        audio_emitter_gain(mainsound,mainvol)
    }
    return _channel
}
function scrNTTEFullMergedRedBulletSetupUnbound(_list,_unused=undefined) {
    throw "RedBullet source must bind its per-shot annihilation info before replacement setup"
}
function scrNTTEFullMergedRedBulletHitUnbound() {
    throw "RedBullet source must bind its per-shot annihilation info before replacement hit"
}
function scrNTTEFullHarpoonLauncherFire() {
    var _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullHarpoon,gunangle+orandom(3*accuracy),22)
    if(instance_exists(_shot) && instance_exists(_shot.creator)) {
        var _owner=_shot.creator,_rope=scrNTTEFullValue(_owner,"harpoon_rope",undefined)
        if(!is_struct(_rope) || !instance_exists(scrNTTEFullValue(_rope,"link1",noone))
            || scrNTTEFullValue(_rope,"broken",true)) _rope=scrNTTEFullHarpoonRope(_shot,_owner)
        else {
            array_push(_shot.rope,_rope)
            _rope.break_timer=60;_rope.link2=_shot;_rope=undefined
        }
        _owner.harpoon_rope=_rope
    }
    scrNTTEFullCustomProjectileGunSound(sndCrossbow,0.2,0.3)
    var _sound=scrNTTEFullCustomProjectileGunSound(sndNadeReload,0,0.3)
    if(_sound>=0) audio_sound_pitch(_sound,0.8)
    scr_weapon_post(gunangle,6,8,-20)
    return _shot
}
function scrNTTEFullNetLauncherFire() {
    var _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullNetNade,gunangle+orandom(5*accuracy),16)
    snd_play(sndGrenade)
    snd_play(sndFlakCannon,1.75+random(0.25))
    snd_play(sndNadeReload,0.8)
    scr_weapon_post(gunangle,6,8,-20)
    return _shot
}
function scrNTTEFullCustomProjectileWeaponTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _p=instance_find(Player,0),_seed=random_get_seed()
    try {
        _p.x=8000;_p.y=8000;_p.gunangle=0;_p.accuracy=0;_p.infammo=1
        _p.wep=wep_ntte_harpoon_launcher;_p.ntte_state=scrNTTENewState(_p.wep)
        var _first_before=scrNTTEFullInstances(NTTEFullHarpoon)
        with(_p) scrFire(wep_ntte_harpoon_launcher,false)
        var _first=noone,_second=noone
        with(NTTEFullHarpoon) if(array_get_index(_first_before,id)<0) _first=id
        assert(instance_exists(_first) && _first.creator==_p && _first.team==_p.team
            && abs(_first.speed-22*timescale)<0.0001 && _first.damage==8,
            "Actual Harpoon Launcher did not create its original physical projectile with native metadata")
        var _rope=_p.harpoon_rope
        assert(is_struct(_rope) && _rope.link1==_first && _rope.link2==_p
            && array_get_index(_first.rope,_rope)>=0,
            "First actual Harpoon Launcher shot did not connect back to its real creator")
        with(_p) scrFire(wep_ntte_harpoon_launcher,false)
        with(NTTEFullHarpoon) if(id!=_first && array_get_index(_first_before,id)<0) _second=id
        assert(instance_exists(_second) && _rope.link1==_first && _rope.link2==_second
            && _rope.break_timer==60 && is_undefined(_p.harpoon_rope)
            && array_get_index(_second.rope,_rope)>=0,
            "Second actual Harpoon Launcher shot did not transfer the creator endpoint to the new harpoon")
        _p.wep=wep_ntte_net_launcher;_p.ntte_state=scrNTTENewState(_p.wep)
        var _nets=instance_number(NTTEFullNetNade)
        with(_p) scrFire(wep_ntte_net_launcher,false)
        assert(instance_number(NTTEFullNetNade)==_nets+1,"Actual Net Launcher still emitted the old generic attack")
        var _net=instance_find(NTTEFullNetNade,_nets)
        assert(_net.creator==_p && _net.team==_p.team && _net.damage==10
            && abs(_net.speed-16*timescale)<0.0001,
            "Actual Net Launcher lost source projectile speed, damage, creator or team")
        _p.wep=wep_ntte_annihilator;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ntte_state.charge=scrNTTEChargeMax(_p.wep);_p.ntte_red_ammo=100
        scrNTTEFullRedWeaponState(_p.ntte_state);_p.ntte_state.chrg=-1
        var _red_count=instance_number(NTTEFullRedBullet)
        with(_p) scrFire(wep_ntte_annihilator,false)
        assert(instance_number(NTTEFullRedBullet)==_red_count+1,
            "Charged actual Annihilator still emitted the old generic red attack")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL CUSTOM PROJECTILE WEAPONS: real scrFire Harpoon first-owner/second-shot endpoint transfer and Net physical source ownership/damage/speed OK @"+string(30/timescale))
}
