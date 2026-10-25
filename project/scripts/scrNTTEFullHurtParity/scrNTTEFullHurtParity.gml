// Original tesewers/tedesert hurt presentation. Explicit callback arguments are
// native physical force and logical direction; raw API supplies both as zero.
function scrNTTEFullHurtParitySound(_target,_sound,_pitch=1,_gain=1,_hit=false,_at=false) {
    // Optional observer used by native pipeline tests, including uncapped runs
    // where the existing sound layer intentionally suppresses physical audio.
    if(variable_global_exists("ntte_full_hurt_sound_observer") && is_array(global.ntte_full_hurt_sound_observer))
        array_push(global.ntte_full_hurt_sound_observer,{target:_target,sound:_sound,pitch:_pitch,gain:_gain,hit:_hit,caller:id,x:x,y:y,at:_at})
    if(_at) return scrNTTEFullCoastSoundAt(x,y,_sound,_pitch,_gain)
    if(_hit) return snd_play_hit(_sound,0.2)
    return snd_play(_sound,_pitch,_gain)
}
// tetrench2926: the authored callback replaces native damage/force/presentation.
// In particular, ignored _force must not be appended by the generic hit tail.
// Keep the AI's existing velocity and restore its hidden collision coordinates.
function scrNTTEFullPitSquidHit(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        x=ntte_full_x; y=ntte_full_y
        hp-=_damage; nexthurt=current_frame+6
        scrNTTEFullHurtParitySound(id,snd_hurt,1.4+orandom(0.4),3,false,true)
        if(hp<=max_hp/2 && hp+_damage>max_hp/2) {
            scrNTTEFullHurtParitySound(id,snd_lowh,snd_lowh==sndNothing2HalfHP?0.6:1)
            ntte_full_bite=1
            if(ntte_full_ammo<=0) ntte_full_timers[2]=max(ntte_full_timers[2],45+random(15))
        }
        ntte_full_last_hp=hp
        ntte_full_x=x; ntte_full_y=y; x=0; y=0
    }
    return true
}
function scrNTTEFullHurtParityAfter(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        if(instance_is(id,NTTEBabyGator)) {
            var _fx=instance_create(x,y-z,Smoke)
            with(_fx) motion_set(_direction,timescale)
        }
        if(instance_is(id,NTTEBoneGator) && !(instance_exists(_attacker) && instance_is(_attacker,Explosion)))
            scrNTTEFullHurtParitySound(id,sndBloodHurt,0.8+orandom(0.2),0.9)
        if((instance_is(id,NTTEBabyScorpion) || instance_is(id,NTTEFullBabyScorpion))
            && (snd_hurt==sndScorpionHit || snd_hurt==sndGoldScorpionHurt))
            scrNTTEFullHurtParitySound(id,snd_hurt,1.2+random(0.3))
    }
}
// PitSquidArm owns its full hurt callback: it never receives generic local
// knockback, forwards actual force/direction to Papa through ordinary hit, and
// protects its appear/disappear animation from generic hurt presentation.
function scrNTTEFullPitSquidArmHit(_target,_damage,_direction,_force,_attacker,_hitid=HitId.None) {
    with(_target) {
        hp-=_damage
        scrNTTEFullPitSquidArmHurt(_damage,_attacker,_direction,_force,_hitid)
        snd_play_hit(snd_hurt,0.3)
        scrNTTEFullTrenchLook(_direction+180)
        if(sprite_index!=ntte_full_appear && sprite_index!=ntte_full_disappear) {
            sprite_index=spr_hurt; image_index=0
        }
    }
    return true
}

function scrNTTEFullHurtParityUnitTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _observer=variable_global_exists("ntte_full_hurt_sound_observer") ? global.ntte_full_hurt_sound_observer:undefined
    global.ntte_full_hurt_sound_observer=[]
    try {
        var _p=instance_find(Player,0),_baby=instance_create(70016,70016,NTTEBabyGator)
        _baby.hp=20;_baby.z=7;_baby.speed=timescale
        with(_p) scrNTTEFullRawHit(_baby,2,1)
        assert(_baby.hp==18 && _baby.zspeed==3 && _baby.zbounce==1,
            "Raw BabyGator hurt lost health/jump callback")
        var _smoke=noone
        with(Smoke) if(array_get_index(_before,id)<0 && x==_baby.x && y==_baby.y-_baby.z) _smoke=id
        assert(instance_exists(_smoke) && abs(_smoke.hspeed-timescale)<0.0001 && abs(_smoke.vspeed)<0.0001,
            "Raw BabyGator smoke lost source location, direction0 or logical speed1")
        var _bullet=instance_create(70144,70016,Bullet1)
        _bullet.creator=_p;_bullet.team=_p.team;_bullet.direction=270
        var _baby2=instance_create(70144,70016,NTTEBabyGator)
        _baby2.hp=20;_baby2.z=4;_baby2.speed=timescale
        with(_bullet) scr_projectile_hit(_baby2,3,2*timescale,90)
        _smoke=noone
        with(Smoke) if(array_get_index(_before,id)<0 && x==_baby2.x && y==_baby2.y-_baby2.z) _smoke=id
        assert(_baby2.hp==17 && instance_exists(_smoke) && abs(_smoke.hspeed)<0.0001 && abs(_smoke.vspeed+timescale)<0.0001,
            "Normal native hit did not preserve actual callback direction for BabyGator smoke")
        var _bone=instance_create(70272,70016,NTTEBoneGator)
        _bone.hp=40
        with(_p) scrNTTEFullRawHit(_bone,3,0)
        assert(_bone.hp==37,"Flock-like raw BoneGator hit failed to subtract damage")
        var _legacy=instance_create(70400,70016,NTTEBabyScorpion),_full=instance_create(70528,70016,NTTEFullBabyScorpion)
        _legacy.hp=20;_full.hp=20
        with(_p) { scrNTTEFullRawHit(_legacy,2,0);scrNTTEFullRawHit(_full,2,0) }
        var _blood=false,_legacy_sound=false,_full_sound=false
        for(var _i=0;_i<array_length(global.ntte_full_hurt_sound_observer);++_i) {
            var _e=global.ntte_full_hurt_sound_observer[_i]
            if(_e.target==_bone) _blood=_e.sound==sndBloodHurt && _e.pitch>=0.6 && _e.pitch<=1.0 && _e.gain==0.9
            if(_e.target==_legacy) _legacy_sound=_e.sound==_legacy.snd_hurt && _e.pitch>=1.2 && _e.pitch<=1.5
            if(_e.target==_full) _full_sound=_e.sound==_full.snd_hurt && _e.pitch>=1.2 && _e.pitch<=1.5
        }
        assert(_blood && _legacy_sound && _full_sound && _legacy.hp==18 && _full.hp==18,
            "Native raw small enemies lost additional authored hurt sound events")
        var _albino=instance_create(70656,70016,NTTEAlbinoGator)
        _albino.hp=40;_albino.ntte_albino_spirit_ready=true;_albino.ntte_albino_spirit=4
        _albino.ntte_albino_spirit_hurt=current_frame-1
        with(_p) scrNTTEFullRawHit(_albino,1,0)
        assert(_albino.hp==40 && _albino.ntte_albino_spirit==3,"Raw Albino shield was bypassed")
        var _shield_fx=noone
        with(ThrowHit) if(array_get_index(_before,id)<0 && x==_albino.x+5*_albino.right && y==_albino.y-5) _shield_fx=id
        assert(instance_exists(_shield_fx) && _shield_fx.depth==_albino.depth-1,"Albino shield FX lost authored depth")
        with(_p) scrNTTEFullRawHit(_albino,4,0)
        var _normal_sound=false,_break_sound=false
        for(var _i=0;_i<array_length(global.ntte_full_hurt_sound_observer);++_i) {
            var _e=global.ntte_full_hurt_sound_observer[_i]
            if(_e.target==_albino && _e.sound==sndFireballerFire) _normal_sound=true
            if(_e.target==_albino && _e.sound==sndSuperFireballerFire) _break_sound=true
        }
        assert(_albino.hp==40 && !_albino.ntte_albino_spirit_ready && _normal_sound && _break_sound,
            "Albino shield break lost owner/sound or double-applied health damage")
        var _cat=instance_create(70784,70016,NTTEFullCatBoss)
        _cat.hp=200;_cat.ntte_full_super_time=29;_cat.ntte_full_super_max=30;_cat.ntte_full_super_break=6;_cat.speed=0
        _p.x=_cat.x;_p.y=_cat.y+100
        with(_p) scrNTTEFullRawHit(_cat,1,0)
        assert(_cat.hp==199 && _cat.ntte_full_super_time==0 && abs(_cat.hspeed-4*timescale)<0.0001 && abs(_cat.vspeed)<0.0001,
            "Raw CatBoss charge break rebuilt direction from caller instead of source direction0")
        _cat.ntte_full_super_time=29;_cat.ntte_full_super_break=6;_cat.speed=0
        with(_bullet) scr_projectile_hit(_cat,1,0,90)
        assert(_cat.hp==198 && _cat.ntte_full_super_time==0 && abs(_cat.hspeed)<0.0001 && abs(_cat.vspeed+4*timescale)<0.0001,
            "Normal CatBoss charge break lost explicit callback direction90")
        var _parent=instance_create(70912,70016,NTTEFullPitSquid),_arm=instance_create(71040,70016,NTTEFullPitSquidArm),
            _sibling=instance_create(71168,70016,NTTEFullPitSquidArm)
        _parent.hp=200;_parent.ntte_full_last_hp=200;_parent.hspeed=1.25*timescale;_parent.vspeed=-0.75*timescale
        var _parent_hspeed=_parent.hspeed,_parent_vspeed=_parent.vspeed
        _arm.hp=10;_arm.creator=_parent;_sibling.creator=_parent
        _arm.sprite_index=_arm.ntte_full_appear;_arm.image_index=1;_arm.speed=0
        with(_p) scrNTTEFullRawHit(_arm,3,0)
        assert(_arm.hp==7 && _parent.hp==197 && _arm.creator==_parent && _sibling.nexthurt==current_frame+6
            && _arm.sprite_index==_arm.ntte_full_appear && _arm.image_index==1 && _arm.gunangle==180 && _arm.speed==0,
            "Raw arm callback lost source HP forwarding, creator, sibling hurt, appear animation or facing180")
        _arm.sprite_index=_arm.ntte_full_disappear;_arm.image_index=1;_arm.hp=7
        with(_bullet) scr_projectile_hit(_arm,2,3*timescale,90)
        assert(_arm.hp==5 && _parent.hp==195 && _arm.sprite_index==_arm.ntte_full_disappear && _arm.image_index==1
            && _arm.gunangle==270 && _arm.speed==0
            && _parent.hspeed==_parent_hspeed && _parent.vspeed==_parent_vspeed,
            "Ordinary native arm hit lost explicit direction or applied local knockback/overwrote disappear")
        with(_p) scrNTTEFullRawHit(_arm,8,0)
        assert(_arm.hp==-3 && _parent.hp==190,"Arm forwarded overkill damage beyond its pre-hit remaining health")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_hurt_sound_observer=_observer
    }
    scrNTTESmokeLog("FULL HURT PARITY: real raw/normal pipeline, smoke direction, authored sounds, Albino shield, CatBoss recoil, arm creator/HP/animation/facing OK")
}
