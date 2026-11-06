// Explicitly invoked desktop smoke harness; mobile never enables this path.
global.ntte_smoke_active=false

function scrNTTESmokeEnabled() {
    if (os_type!=os_windows) return false
    if(scrNTTEFullSmokeEnabled()) return true
    if (scrNTTESewerStageSmokeEnabled() || scrNTTEBatSmokeEnabled() || scrNTTEAlbinoSmokeEnabled()) return true
    for(var _i=1;_i<=parameter_count();++_i) {
        if (parameter_string(_i)=="--ntte-smoke" || parameter_string(_i)=="--ntte-desert-smoke" || parameter_string(_i)=="--ntte-ally-smoke" || parameter_string(_i)=="--ntte-sewer-smoke" || parameter_string(_i)=="--ntte-weapon-fix-smoke") return true
    }
    return false
}

function scrNTTESmokeStart() {
    if (!scrNTTESmokeEnabled()) return false
    global.ntte_smoke_active=true
    if (!instance_exists(NTTESmokeTest)) instance_create(0,0,NTTESmokeTest)
    return true
}

function scrNTTESmokeLog(_text) {
    var _f=file_text_open_append(working_directory+"ntte-smoke.txt")
    file_text_write_string(_f,_text)
    file_text_writeln(_f)
    file_text_close(_f)
    show_debug_message("NTTE SMOKE "+_text)
}

function scrNTTESmokeInput() {
    KeyCont.press_fire[index]=true
    KeyCont.hold_fire[index]=true
    clicked=false
    var _max=scrNTTEChargeMax(wep)
    if (_max>0) {
        ntte_state.charge=0
        repeat(ceil(_max/timescale)) scrPlayerFiring(true)
        assert(ntte_state.charge>=_max,"NTTE hold did not fully charge")
        KeyCont.press_fire[index]=false
        KeyCont.hold_fire[index]=false
        scrPlayerFiring(true)
        assert(ntte_state.charge==0,"NTTE release retained charge")
    }
    else scrPlayerFiring(true)
    assert(reload>0,"NTTE player firing did not reach attack: "+string(wep))
    KeyCont.press_fire[index]=false
    KeyCont.hold_fire[index]=false
}

function scrNTTESmokeSave() {
    var _p=instance_find(Player,0)
    _p.ntte_last_harpoon=123456
    _p.ntte_state=scrNTTENewState(_p.wep)
    _p.ntte_state.charge=5
    var _savedweapon=_p.wep,_buf=buffer_create(65535,buffer_grow,1)
    scrSavegamePlayers(_buf,false)
    instance_destroy(_p,false)
    buffer_seek(_buf,buffer_seek_start,0)
    scrSavegamePlayers(_buf,true)
    buffer_delete(_buf)
    _p=instance_find(Player,0)
    assert(instance_exists(_p) && _p.wep==_savedweapon,"NTTE player save/load lost weapon")
    assert(_p.ntte_state.charge==0 && _p.ntte_state.outstanding==0,"NTTE player save/load kept transient charge")
    assert(_p.ntte_last_harpoon==noone,"NTTE player save/load kept stale harpoon handle")
    scrNTTESmokeLog("PLAYER SAVE/LOAD OK")
}

function scrNTTESmokeStep() {
    if (room!=romGame || !instance_exists(UberCont)) return;
    if (phase==0) {
        instance_destroy(MainMenu,false)
        instance_destroy(SpiralCont,false)
        if (!instance_exists(GameCont)) instance_create(0,0,GameCont)
        GameCont.area=area_desert
        GameCont.subarea=1
        GameCont.rad=10000
        UberCont.opt_autopause=false
        UberCont.opt_freeze=0
        global.is_server=true
        global.index=0
        if (!instance_exists(BackCont)) instance_create(0,0,BackCont)
        if (!instance_exists(Player)) {
            my_player.race=Race.Fish
            scrCreatePlayers(0)
        }
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        scr_camera_set_position(10016,10016,fa_center,fa_middle)
        phase=1
        scrNTTESmokeLog("BOOT OK")
    }
    if(scrNTTEFullSmokeEnabled()) { scrNTTEFullSmokeStep(); return; }
    if (scrNTTESewerStageSmokeEnabled()) { scrNTTESewerStageSmokeStep(); return; }
    if (scrNTTEBatSmokeEnabled()) { scrNTTEBatSmokeStep(); return; }
    if (scrNTTEAlbinoSmokeEnabled()) { scrNTTEAlbinoSmokeStep(); return; }
    if (scrNTTEAllySmokeEnabled()) { scrNTTEAllySmokeStep(); return; }
    if (scrNTTEDesertSmokeEnabled()) { scrNTTEDesertSmokeStep(); return; }
    if (scrNTTESewerSmokeEnabled()) { scrNTTESewerSmokeStep(); return; }
    if (scrNTTEWeaponFixSmokeEnabled()) { scrNTTEWeaponFixSmokeStep(); return; }
    if (!instance_exists(Player)) { scrNTTESmokeLog("FAIL player lost"); game_end(); return; }
    with (Player) {
        hp=10000
        max_hp=10000
        lsthealth=10000
        nexthurt=current_frame+100
        x=10016
        y=10016
        speed=0
        can_walk=false
        can_aim=false
        gunangle=0
        drawempty=30
    }
    var _p=instance_find(Player,0)
    if (tick==0) {
        if (weapon_id>wep_ntte_last) {
            if (++pass_index>=3) {
                scrNTTESmokeSave()
                scrNTTESmokeLog("PASS all 45 entries x 2 logical rates; primary/secondary, charge, collisions, cleanup, state JSON")
                game_end()
                return;
            }
            weapon_id=wep_ntte_rogue_carbine
        }
        UberCont.opt_framerate=rates[pass_index]
        game_set_speed(rates[pass_index],gamespeed_fps)
        with (hitme) if (!instance_is(id,Player)) instance_destroy(id,false)
        for(var _i=-1;_i<=1;++_i) {
            with (instance_create(10016+48+_i*24,10016,Dummy)) { hp=20; max_hp=20 }
        }
        with (_p) {
            race=Race.Steroids
            wep=other.weapon_id
            bwep=wep_ntte_rogue_carbine
            ntte_state=scrNTTENewState(wep)
            bntte_state=scrNTTENewState(bwep)
            ntte_bones=55
            ntte_red_ammo=9
            ammo=array_create(Ammo.NUM_AMMO_TYPES,999)
            if (scrNTTEIsScythe(wep)) ntte_state.ammo=55
            ntte_state.charge=0
            can_shoot=true
            reload=0
            GameCont.rad=10000
            scrNTTESmokeLog("FIRE "+string(other.rates[other.pass_index])+" "+string(wep)+" "+scr_weapon_get_name(wep))
            scrNTTESmokeInput()
        }
        tick+=timescale
        return;
    }
    var _oldtick=tick
    tick+=timescale
    if (_oldtick<5 && tick>=5) with (_p) {
        var _s=ntte_state
        scrSwapWeps(false)
        scrSwapWeps(false)
        assert(ntte_state==_s,"NTTE swap lost state")
        // Also exercise the secondary firing path used by Steroids.
        scrSwapWeps(false)
        bwep=wep
        wep=other.weapon_id
        ntte_state=scrNTTENewState(wep)
        ntte_state.charge=0
        scrFire(wep,true,false)
        scrSwapWeps(false)
    }
    if (_oldtick<12 && tick>=12) {
        with (NTTEAttack) {
            if (kind==NTTEKind.Net || kind==NTTEKind.Portal || kind==NTTEKind.Tunnel) scrNTTEAttackExpire()
        }
        with (_p) if (is_struct(ntte_state)) {
            var _json=json_stringify(ntte_state),_copy=json_parse(_json)
            if (is_struct(_copy)) {
                _copy=scrNTTEStateRestored(_copy)
                assert(_copy.outstanding==0 && _copy.charge==0,"NTTE restored transient state")
            }
        }
    }
    if (tick>=18) {
        instance_destroy(NTTEAttack,false)
        instance_destroy(NTTESwing,false)
        instance_destroy(NTTEBeam,false)
        instance_destroy(NTTECoil,false)
        instance_destroy(NTTEShield,false)
        instance_destroy(NTTESalvo,false)
        instance_destroy(NTTELightningDisc,false)
        instance_destroy(NTTEVenomPellet,false)
        instance_destroy(NTTERogueCarbineBurst,false)
        with (hitme) if (variable_instance_exists(id,"ntte_bubble")) assert(!instance_exists(ntte_bubble),"Bubble cleanup retained target")
        scrNTTESmokeLog("OK "+string(weapon_id)+" @"+string(rates[pass_index]))
        weapon_id+=1
        tick=0
    }
}
