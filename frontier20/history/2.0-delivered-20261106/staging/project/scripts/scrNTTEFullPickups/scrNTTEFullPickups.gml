// Native pickup and chest foundations, from tepickups. Shop chests depend on
// the actual shop transaction system and are registered only with that system.
// tepickups697..776. This is collectible scythe ammo; thrown single-use
// crabbones have a separate broken-bone effect and never use this object.
function scrNTTEFullBonePickupPull(_who) {
    return speed<=0 && instance_exists(_who) && (scrNTTEIsScythe(scrNTTEFullWeaponRaw(_who.wep)) || scrNTTEIsScythe(scrNTTEFullWeaponRaw(_who.bwep)));
}
function scrNTTEFullBonePickupFade() { instance_create(x,y,Dust); }
function scrNTTEFullBonePickupOpen(_opener) {
    if(instance_is(_opener,Player) && !scrNTTEIsScythe(scrNTTEFullWeaponRaw(_opener.wep)) && !scrNTTEIsScythe(scrNTTEFullWeaponRaw(_opener.bwep))) return true;
    var _num=num;
    with(instance_is(_opener,Player) ? _opener:Player) {
        scrNTTEFullGiveBoneAmmo(_num);
    }
    instance_create(x,y,Dust);
    return false;
}
function scrNTTEFullBonePickupCreate() {
    sprite_index=choose(sprNTTERefBonePickupI0,sprNTTERefBonePickupI1,sprNTTERefBonePickupI2,sprNTTERefBonePickupI3);
    image_angle=random(360); spr_open=-1; spr_fade=-1; snd_open=sndRadPickup; snd_fade=-1;
    mask_index=mskRad; ntte_full_fade_timer=scrNTTEFullPickupAlarm(150+random(30),0.25);
    pull_dis=80+60*scr_skill_get(mut_plutonium_hunger); pull_spd=12;
    on_pull=scrNTTEFullBonePickupPull; on_open=scrNTTEFullBonePickupOpen; on_fade=scrNTTEFullBonePickupFade;
    var _active=false;
    with(Player) if(other.on_pull(id)) _active=true;
    if(_active) image_index=random(image_number);
    else { shine=0; blink=0; }
}
function scrNTTEFullBonePickupTests() {
    var _p=instance_find(Player,0),_wep=_p.wep,_bwep=_p.bwep,_state=_p.ntte_state,_bones=scrNTTEFullValue(_p,"ntte_bones",0);
    _p.wep=wep_revolver; _p.bwep=wep_none;
    var _item=instance_create(_p.x,_p.y,NTTEFullBonePickup);
    with(_item) assert(!scrNTTEFullBonePickupPull(_p) && !scrNTTEFullCustomPickupOpen(_p),"Bone ammo accepted a player without scythe");
    assert(instance_exists(_item) && _item.shine==0 && _item.blink==0,"Inactive bone lost source undercover state");
    _p.wep=wep_ntte_bone_scythe; _p.ntte_state=scrNTTENewState(_p.wep); _p.ntte_bones=0;
    _item.num=3; _item.speed=1;
    with(_item) assert(!scrNTTEFullBonePickupPull(_p),"Moving bone entered attraction before it settled");
    _item.speed=0;
    with(_item) assert(scrNTTEFullBonePickupPull(_p) && scrNTTEFullCustomPickupOpen(_p),"Settled bone failed scythe-only contact");
    assert(!instance_exists(_item) && _p.ntte_state.ammo==3,"Scythe bone contact failed source count");
    _p.wep=_wep; _p.bwep=_bwep; _p.ntte_state=_state; _p.ntte_bones=_bones;
    scrNTTESmokeLog("FULL BONE PICKUP: scythe-only contact, moving/settled attraction, undercover state and actual per-weapon refill OK");
}
function scrNTTEFullCustomChestCreate() {
    sprite_index=sprAmmoChest; spr_dead=sprAmmoChestOpen; spr_open=sprFXChestOpen;
    snd_open=sndAmmoChest; nochest=0; on_step=undefined; on_open=undefined;
    ntte_full_chest_opened=false;
}
function scrNTTEFullCustomChestStep() {
    if(lockstep_stop) return;
    if(is_callable(on_step)) on_step();
    if(!instance_exists(id) || instance_exists(GenCont)) return;
    var _meet=[Player,PortalShock];
    for(var _i=0;_i<2;++_i) {
        if(place_meeting(x,y,_meet[_i])) {
            scrNTTEFullCustomChestOpen(instance_nearest(x,y,_meet[_i]));
            return;
        }
    }
}
function scrNTTEFullCustomChestOpen(_opener) {
    if(ntte_full_chest_opened || !instance_exists(_opener)) return;
    ntte_full_chest_opened=true;
    if(GameCont.crown==Crown.Hatred) {
        repeat(16) {
            var _rad=instance_create(x,y,Rad);
            with(_rad) motion_add(random(360),random_range(2,6)*timescale);
        }
        if(instance_is(_opener,Player)) scr_projectile_hit(_opener,1,0,undefined,false,HitId.CrownOfHatred);
    }
    if(is_callable(on_open)) on_open(_opener);
    if(sprite_exists(spr_dead)) {
        var _corpse=instance_create(x,y,ChestOpen); _corpse.sprite_index=spr_dead;
    }
    if(sprite_exists(spr_open)) {
        var _fx=instance_create(x,y,FXChestOpen); _fx.sprite_index=spr_open;
    }
    snd_play(snd_open);
    instance_destroy();
}
function scrNTTEFullCustomChestCleanup() {
    if(!ntte_full_chest_opened && nochest!=0 && instance_exists(GameCont)
        && (instance_exists(GenCont) || instance_exists(LevCont))) GameCont.nochest+=nochest;
}
// tepickups4775..4813: the authored red chest uses the generic chest parent.
function scrNTTEFullRedChestCreate() {
    sprite_index=scrNTTERefSprite("RedChest");spr_dead=scrNTTERefSprite("RedChestOpen")
    spr_shadow=shd16;spr_shadow_y=4;num=2;on_open=scrNTTEFullRedChestOpen
}
function scrNTTEFullRedChestOpen(_opener) {
    var _target=instance_is(_opener,Player)?_opener:instance_nearest(x,y,Player)
    instance_create(x,y,PortalClear)
    var _orb=scrNTTEFullSystemsCreate("OrchidBall",x,y)
    _orb.target=_target;_orb.type="red";_orb.time=num;_orb.creator=id
    var _enemy=instance_nearest(x,y,enemy)
    if(instance_exists(_enemy)) _orb.direction=point_direction(_orb.x,_orb.y,_enemy.x,_enemy.y)+orandom(15)
}
function scrNTTEFullPizzaStackCreate() {
    spr_idle=sprPizzaBox; spr_hurt=sprPizzaBoxHurt; spr_dead=sprPizzaBoxDead;
    snd_hurt=sndHitPlant; snd_dead=sndPizzaBoxBreak;
    max_hp=4; size=1; num=choose(1,2);
    if(random(10)<1) num=4;
}
function scrNTTEFullPizzaStackDeath() {
    if(num>=4) { snd_play(snd_dead,0.6); snd_dead=-1; }
    repeat(num) {
        instance_create(x+orandom(2*num),y+orandom(2*num),NTTEFullPizza);
        instance_create(x+orandom(4),y+orandom(4),Dust);
    }
}

// tepickups::CustomPickup. Standalone object: the native HPPickup has its own
// healing/attraction collision events and cannot serve as this generic parent.
function scrNTTEFullPickupAlarm(_time,_decay=0.2) {
    _time/=1+GameCont.loops*_decay;
    if(scrCrownCheck(crwn_haste)) _time/=3;
    return _time;
}
function scrNTTEFullCustomPickupCreate() {
    sprite_index=sprAmmo; mask_index=mskPickup;
    spr_open=sprSmallChestPickup; spr_fade=sprSmallChestFade;
    image_speed=0.4*timescale; shine=0.1; friction=0.2*timescale*timescale;
    snd_open=sndAmmoPickup; snd_fade=sndPickupDisappear;
    num=1; blink=30; ntte_full_fade_timer=scrNTTEFullPickupAlarm(200+random(30));
    pull_dis=40+30*scr_skill_get(mut_plutonium_hunger); pull_spd=6;
    on_step=undefined; on_pull=function(_player) { return true; };
    on_open=undefined; on_fade=undefined;
}
function scrNTTEFullPickupEffect(_object,_sprite) {
    if(!sprite_exists(_sprite)) return noone;
    var _fx=instance_create(x,y,_object);
    _fx.sprite_index=_sprite; _fx.image_xscale=image_xscale;
    _fx.image_yscale=image_yscale; _fx.image_angle=image_angle;
    return _fx;
}
function scrNTTEFullCustomPickupOpen(_opener) {
    if(!instance_exists(_opener)) return false;
    // Original callback's true return explicitly keeps the item in the world.
    if(is_callable(on_open) && on_open(_opener)==true) return false;
    if(!instance_exists(id)) return true;
    scrNTTEFullPickupEffect(SmallChestPickup,spr_open);
    snd_play(snd_open); instance_destroy();
    return true;
}
function scrNTTEFullCustomPickupStep() {
    if(lockstep_stop) return;
    if(image_index<1 && shine!=1) image_index-=image_speed*(1-random(shine));
    if(ntte_full_fade_timer>0) {
        ntte_full_fade_timer=max(0,ntte_full_fade_timer-timescale);
        if(ntte_full_fade_timer<=0) {
            if(blink>=0) { blink-=1; ntte_full_fade_timer=2; visible=!visible; }
            else {
                if(is_callable(on_fade)) on_fade();
                if(!instance_exists(id)) return;
                scrNTTEFullPickupEffect(SmallChestFade,spr_fade);
                snd_play_hit(snd_fade,0.1); instance_destroy(); return;
            }
        }
    }
    if(is_callable(on_step)) on_step();
    if(!instance_exists(id)) return;
    if(is_callable(on_pull)) {
        var _nearest=noone,_dis=instance_exists(Portal)?infinity:pull_dis;
        with(Player) {
            var _d=point_distance(x,y,other.x,other.y);
            if(_d<_dis && other.on_pull(id)) { _dis=_d; _nearest=id; }
        }
        if(instance_exists(_nearest)) {
            var _d=point_direction(x,y,_nearest.x,_nearest.y);
            var _nx=x+lengthdir_x(pull_spd*timescale,_d),_ny=y+lengthdir_y(pull_spd*timescale,_d);
            if(place_free(_nx,y)) x=_nx;
            if(place_free(x,_ny)) y=_ny;
        }
    }
    // Native pickups have separate roots. Include each real family explicitly.
    if(mask_index==mskPickup) {
        var _families=[AmmoPickup,HPPickup,RogueAmmo,NTTEFullCustomPickup];
        for(var _fi=0;_fi<array_length(_families);++_fi) {
            var _family=_families[_fi];
            with(_family) if(id!=other.id && mask_index==mskPickup && place_meeting(x,y,other.id)) {
                if(!instance_is(id,NTTEFullCustomPickup)) motion_add(point_direction(other.x,other.y,x,y)+orandom(10),0.8*timescale);
                with(other) motion_add(point_direction(other.x,other.y,x,y)+orandom(10),0.8*timescale);
            }
        }
    }
    if(place_meeting(x+hspeed,y+vspeed,Wall)) {
        if(place_meeting(x+hspeed,y,Wall)) hspeed=-hspeed;
        if(place_meeting(x,y+vspeed,Wall)) vspeed=-vspeed;
    }
    var _openers=[Player,Portal];
    for(var _i=0;_i<2;++_i) {
        var _list=ds_list_create();
        instance_place_list(x,y,_openers[_i],_list,false);
        for(var _j=0;_j<ds_list_size(_list);++_j) {
            if(scrNTTEFullCustomPickupOpen(_list[|_j])) break;
        }
        ds_list_destroy(_list);
        if(!instance_exists(id)) return;
    }
}
function scrNTTEFullCustomPickupSmoke() {
    var _p=instance_find(Player,0),_px=_p.x,_py=_p.y;
    var _item=instance_create(10000,10000,NTTEFullCustomPickup),_x=_item.x;
    _p.x=10024; _p.y=10000;
    _item.on_pull=function(_who) { return false; };
    with(_item) scrNTTEFullCustomPickupStep();
    assert(_item.x==_x,"CustomPickup ignored attraction rejection callback");
    _item.on_pull=function(_who) { return true; };
    with(_item) scrNTTEFullCustomPickupStep();
    assert(abs(_item.x-_x-6*timescale)<0.001,"CustomPickup attraction speed did not use logical time");
    _x=_item.x;
    _item.on_pull=function(_who) { return false; };
    with(_p) scrEyesTelekinesis();
    assert(_item.x==_x,"Eyes ignored custom pickup attraction predicate");
    _item.on_pull=undefined;
    with(_p) scrEyesTelekinesis();
    assert(abs(_item.x-_x-(1+scr_skill_get(mut_throne_butt))*timescale)<0.001,"Eyes did not pull generic pickup through native ability path");
    _item.on_open=method(_item,function(_who) { ntte_full_test_opener=_who; return true; });
    with(_item) scrNTTEFullCustomPickupOpen(_p);
    assert(instance_exists(_item) && _item.ntte_full_test_opener==_p,"CustomPickup keep callback consumed item or lost opener");
    _item.on_open=undefined;
    var _before=instance_number(SmallChestPickup);
    with(_item) scrNTTEFullCustomPickupOpen(_p);
    assert(!instance_exists(_item) && instance_number(SmallChestPickup)==_before+1,"CustomPickup did not consume/create source open FX");
    _item=instance_create(10080,10080,NTTEFullCustomPickup);
    _item.on_pull=undefined; _item.ntte_full_fade_timer=2; _item.blink=0;
    repeat(round(2/timescale)) with(_item) scrNTTEFullCustomPickupStep();
    assert(instance_exists(_item) && _item.blink==-1 && !_item.visible,"CustomPickup last blink duration changed");
    _before=instance_number(SmallChestFade);
    repeat(round(2/timescale)) with(_item) scrNTTEFullCustomPickupStep();
    assert(!instance_exists(_item) && instance_number(SmallChestFade)==_before+1,"CustomPickup fade duration or effect changed");
    _p.x=_px; _p.y=_py;
    scrNTTEFullPickupAudioLifetimeTests()
    scrNTTESmokeLog("PASS generic pickup attraction/rejection, keep callback, consume FX and timed blink/fade @"+string(30/timescale));
}
function scrNTTEFullPickupFoundationSmoke() {
    var _before=instance_number(NTTEFullPizza),_pizza=instance_create(10080,10080,NTTEFullPizza),
        _native=instance_create(10080,10080,HPPickup);
    assert(_pizza.num==ceil(_native.num/2) && _pizza.sprite_index==sprSlice,"Pizza slice changed native half-heal rule");
    instance_destroy(_pizza,false); instance_destroy(_native,false);
    var _box=instance_create(10080,10080,NTTEFullPizzaStack);
    assert(_box.hp==4 && _box.size==1 && _box.spr_idle==sprPizzaBox,"Pizza stack native prop setup mismatches source");
    _box.num=4;
    instance_destroy(_box);
    assert(instance_number(NTTEFullPizza)==_before+4,"Pizza stack did not drop its exact configured slices");
    instance_destroy(NTTEFullPizza,false);
    var _chest=instance_create(10080,10080,NTTEFullPizzaChest),_normal=instance_create(10080,10080,HealthChest);
    assert(_chest.num==ceil(_normal.num/2) && _chest.spr_dead==sprPizzaChestOpen,"Pizza chest changed half-heal rule");
    instance_destroy(_chest,false); instance_destroy(_normal,false);
    _chest=instance_create(10080,10080,NTTEFullCustomChest);
    _chest.on_open=function(_opener) { ntte_full_test_opened_by=_opener; };
    _chest.sprite_index=sprAmmoChest; _chest.spr_dead=sprAmmoChestOpen;
    var _opened=instance_number(ChestOpen),_fx=instance_number(FXChestOpen),_player=instance_find(Player,0);
    with(_chest) scrNTTEFullCustomChestOpen(_player);
    assert(!instance_exists(_chest) && instance_number(ChestOpen)==_opened+1 && instance_number(FXChestOpen)==_fx+1,
        "Custom chest opening did not create original shell and burst");
    scrNTTESmokeLog("PASS pizza half-heal chest/slice, four-slice prop death, custom chest opening lifecycle @"+string(30/timescale));
}

// Exercise real pickup expiry, including the intentional silent (-1) sound.
function scrNTTEFullPickupAudioLifetimeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_frame=current_frame,
        _stop=lockstep_stop,_volume=UberCont.opt_sndvol,_spatial=UberCont.opt_3Dsound,
        _custom=global.custom_sounds
    try {
        lockstep_stop=false;UberCont.opt_sndvol=1
        var _classes=[NTTEFullBonePickup,NTTEFullCustomPickup]
        for(var _mode=0;_mode<2;++_mode) {
            UberCont.opt_3Dsound=_mode==1
            for(var _i=0;_i<array_length(_classes);++_i) {
                var _base=scrNTTEFullInstances(all),_item=instance_create(190000,190000,_classes[_i]),
                    _timer=_item.ntte_full_fade_timer,_blink=_item.blink,_ticks=0
                _item.on_pull=undefined
                assert(_timer>0 && (_i!=0 || _item.snd_fade==-1),"Pickup lifetime fixture lost source timer/silent bone sound")
                while(instance_exists(_item) && _ticks<700/timescale) {
                    with(_item) event_perform(ev_step,ev_step_normal)
                    current_frame+=timescale;_ticks++
                }
                assert(!instance_exists(_item),"Real pickup did not expire through its registered Step")
                assert(_ticks*timescale>=_timer,"Pickup was removed before its original lifetime elapsed")
                var _dust=0,_fade=0
                with(Dust) if(array_get_index(_base,id)<0) _dust++
                with(SmallChestFade) if(array_get_index(_base,id)<0) _fade++
                assert(_i==0?(_dust==1 && _fade==0):(_dust==0 && _fade==1),
                    "Silent/ordinary pickup expiry lost its exact source effects")
                scrNTTESmokeLog("PICKUP NATURAL EXPIRY "+object_get_name(_classes[_i])+" 3D="+string(_mode)
                    +" timer="+string(_timer)+" blink="+string(_blink)+" steps="+string(_ticks)+" effects="+string(_dust)+"/"+string(_fade))
                scrNTTEFullMergedRuntimeTestCleanup(_base)
            }
            assert(snd_play_hit(-1,0.1)==-1,"Silent hit audio must return no voice")
            // Resource-pack substitutions are checked after mapping, too.
            global.custom_sounds={}
            global.custom_sounds[$ string(sndPickupDisappear)]=-1
            assert(snd_play_hit(sndPickupDisappear,0.1)==-1,"Mapped silent hit audio reached the native playback API")
            global.custom_sounds=_custom
            var _voice=snd_play_hit(sndPickupDisappear,0)
            assert(_voice>=0 && audio_is_playing(_voice),"Valid pickup sound stopped playing after the silent-sound fix")
            audio_stop_sound(_voice)
        }
    } finally {
        global.custom_sounds=_custom
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        current_frame=_frame;lockstep_stop=_stop;UberCont.opt_sndvol=_volume;UberCont.opt_3Dsound=_spatial
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("PICKUP AUDIO source bone/ordinary complete lifetimes, 2D/3D silent and mapped-silent rejection, valid audio playback @"+string(30/timescale))
}
