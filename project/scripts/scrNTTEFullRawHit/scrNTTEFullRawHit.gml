// Original NTT scrRawHit / projectile_hit_raw, recovered read-only from 9940.
// Native targets skip projectile checks and PlayerProcTakeDamage, but still
// receive scrHurt's six-frame presentation. Original CustomEnemy/CustomHitme
// targets instead call their MOD hurt callback with force=0,direction=0.
function scrNTTEFullRawHitCustom(_target) {
    if(!variable_global_exists("ntte_full_raw_hurt_classes")) scrNTTEFullRawHitInit()
    for(var _i=0;_i<array_length(global.ntte_full_raw_hurt_classes);++_i)
        if(instance_is(_target,global.ntte_full_raw_hurt_classes[_i])) return true
    return false
}
function scrNTTEFullRawHitNative(_target,_damage,_sound) {
    with(_target) {
        hp-=_damage
        nexthurt=current_frame+6
        // Original Turret keeps its firing animation when hit. Other native
        // objects use their hurt sprite, even when damage is zero/negative.
        if(!instance_is(id,Turret) || sprite_index!=spr_fire) {
            sprite_index=spr_hurt; image_index=0
        }
        if(_sound!=0) {
            if(instance_is(id,Player)) snd_play(snd_hurt)
            else if(_sound==2) snd_play_hit_big(snd_hurt,0.2)
            else snd_play_hit(snd_hurt,0.2)
        }
    }
}
function scrNTTEFullRawHit(_target,_damage,_sound=0) {
    if(!instance_exists(_target)) return false
    if(instance_is(_target,Player)) {
        var _last=scrNTTEFullValue(id,"hitid",undefined)
        if(is_array(_last) || is_numeric(_last)) _target.ntte_last_hit=_last
    }
    if(!scrNTTEFullRawHitCustom(_target)) {
        scrNTTEFullRawHitNative(_target,_damage,_sound)
        return true
    }
    if(instance_is(_target,NTTEFullPet)) {
        // A MOD on_hurt callback owns both damage and presentation; the raw
        // API's sound selector does not override it. Preserve caller as other.
        _target.ntte_pet_hit_source=id
        var _handled=false
        with(_target) {
            var _hook=scrNTTEFullValue(hooks,"hurt",undefined)
            if(!visible || (instance_exists(other.id) && instance_is(other.id,Corpse))) return true
            if(max_hp<=0) return true
            if(instance_exists(other.id) && instance_is(other.id,Debris)) return true
            if(is_callable(_hook)) _handled=_hook(_damage,0,0)
            if(!_handled) { hp-=_damage; nexthurt=current_frame+6; sprite_index=spr_hurt; image_index=0; snd_play_hit(snd_hurt,0.2) }
        }
        return true
    }
    // Reuse the authored native MOD callbacks, with raw-hit parameters rather
    // than ordinary projectile/player damage checks. See integrate_raw_hit.py.
    return scr_hit(_target,_damage,HitId.None,true)
}

function scrNTTEFullRawHitTests() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0)
    var _saved={hp:_p.hp,next:_p.nexthurt,sprite:_p.sprite_index,image:_p.image_index,damage:_p.totdamagetaken}
    _p.hp=10; _p.nexthurt=current_frame+1000
    scrNTTEFullRawHit(_p,3,0)
    assert(_p.hp==7 && _p.nexthurt==current_frame+6 && _p.totdamagetaken==_saved.damage,
        "NTT raw hit entered ordinary player invulnerability/damage procs")
    scrNTTEFullRawHit(_p,-2,0)
    assert(_p.hp==9,"NTT raw negative damage was clamped or ignored")
    var _bandit=instance_create(68016,68016,Bandit)
    _bandit.hp=10; _bandit.team=_p.team; _bandit.nexthurt=current_frame+1000
    scrNTTEFullRawHit(_bandit,4,0)
    assert(_bandit.hp==6 && _bandit.sprite_index==_bandit.spr_hurt && _bandit.image_index==0
        && _bandit.nexthurt==current_frame+6,"NTT raw hit applied team/i-frame filtering or lost hurt presentation")
    var _bot=instance_create(68144,68016,Turret)
    _bot.sprite_index=_bot.spr_fire; _bot.image_index=2; _bot.hp=10
    scrNTTEFullRawHit(_bot,1,0)
    assert(_bot.hp==9 && _bot.sprite_index==_bot.spr_fire && _bot.image_index==2,"NTT raw hit interrupted firing Turret")
    var _bat=instance_create(68272,68016,NTTEBat),_stress=_bat.ntte_bat_stress
    _bat.hp=10
    assert(scrNTTEFullRawHitCustom(_bat),"Original custom Bat was mistaken for a native raw-hit target")
    scrNTTEFullRawHit(_bat,3,0)
    assert(_bat.hp==7 && _bat.ntte_bat_stress==_stress+3,"NTT raw hit bypassed original MOD Bat hurt callback")
    scrNTTEFullRawHit(_bat,-2,0)
    assert(_bat.hp==9 && _bat.ntte_bat_stress==_stress+1,
        "Signed custom raw Bat hit failed to restore health and subtract its authored stress")
    var _baby=instance_create(68400,68016,NTTEBabyGator)
    _baby.hp=10;_baby.speed=timescale;_baby.zspeed=0;_baby.zbounce=0
    scrNTTEFullRawHit(_baby,0,0)
    assert(_baby.hp==10 && _baby.zspeed==3 && _baby.zbounce==1 && _baby.nexthurt==current_frame+6,
        "Zero custom raw hit skipped BabyGator's moving jump or six-frame presentation")
    var _albino=instance_create(68528,68016,NTTEAlbinoGator)
    _albino.hp=40;_albino.ntte_albino_spirit=3;_albino.ntte_albino_spirit_ready=true
    _albino.ntte_albino_spirit_hurt=current_frame-1
    scrNTTEFullRawHit(_albino,-2,0)
    assert(_albino.hp==40 && _albino.ntte_albino_spirit==5,
        "Signed raw Albino hit bypassed original spirit arithmetic and shield callback")
    _albino.ntte_albino_spirit_hurt=current_frame+6
    scrNTTEFullRawHit(_albino,-1,0)
    assert(_albino.hp==40 && _albino.ntte_albino_spirit==6,
        "Raw Albino temporary shield guard discarded pre-guard signed spirit bookkeeping")
    _p.hp=_saved.hp; _p.nexthurt=_saved.next; _p.sprite_index=_saved.sprite; _p.image_index=_saved.image
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS RAW HIT: native team/i-frame bypass, no player damage proc, signed damage, six-frame hurt, firing Turret and custom Bat on_hurt dispatch OK")
}

function scrNTTEFullRawHitInit() {
    global.ntte_full_raw_hurt_classes=[NTTEAlbinoGator, NTTEBabyGator, NTTEBabyScorpion, NTTEBat, NTTEBoneGator, NTTECat, NTTEFullAngler, NTTEFullBabyScorpion, NTTEFullBatBoss, NTTEFullBigMaggotSpawn, NTTEFullBigPipe, NTTEFullBloomingAssassinHide, NTTEFullBoneRaven, NTTEFullCatBoss, NTTEFullCatDoor, NTTEFullCoastBoss, NTTEFullCoastBossBecome, NTTEFullCreature, NTTEFullCrystalBat, NTTEFullCrystalBrain, NTTEFullCrystalHeart, NTTEFullDiver, NTTEFullEel, NTTEFullGull, NTTEFullHammerShark, NTTEFullJelly, NTTEFullMortar, NTTEFullPalanking, NTTEFullPelican, NTTEFullPet, NTTEFullPetWeaponBoss, NTTEFullPitSquid, NTTEFullPitSquidArm, NTTEFullPizzaRubble, NTTEFullPopoSecurity, NTTEFullPortalGuardian, NTTEFullPuffer, NTTEFullRedSpider, NTTEFullSawTrap, NTTEFullSeal, NTTEFullSealHeavy, NTTEFullSealMine, NTTEFullSewerDrain, NTTEFullSpiderling, NTTEFullTesseract, NTTEFullTopRaven, NTTEFullTrafficCrab, NTTEFullTurtleCool, NTTEFullYetiCrab, NTTESilverScorpion];
}
