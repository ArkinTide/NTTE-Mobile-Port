function scrNTTESewerStageSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-sewer-stage-smoke") return true
    return false
}

function scrNTTESewerStageUnits() {
    var _baby=instance_create(10080,10016,NTTEBabyGator)
    assert(_baby.spr_shadow==shd16 && _baby.spr_shadow_y==1 && _baby.spr_shadow_x==0 && _baby.z==0,"Baby inherited shadow/ground anchor mismatch")
    assert(sprite_get_xoffset(_baby.spr_idle)==12 && sprite_get_yoffset(_baby.spr_idle)==12,"Original baby sprite origin was changed")
    instance_destroy(_baby,false)
    var _g1=instance_create(10064,10016,NTTEBabyGator),_g2=instance_create(10096,10016,NTTEBoneGator),_g3=instance_create(10064,10048,NTTEAlbinoGator)
    with (NTTEBabyGator) { ntte_gator_den=true; ntte_gator_awake=false }
    with (NTTEBoneGator) { ntte_gator_den=true; ntte_gator_awake=false }
    with (NTTEAlbinoGator) { ntte_gator_den=true; ntte_gator_awake=false }
    with (_g1) scrNTTESewerWakeDen()
    assert(_g1.ntte_gator_awake && _g2.ntte_gator_awake && _g3.ntte_gator_awake,"Den group did not wake together")
    assert(instance_number(NTTEAlert)==1 && NTTEAlert.sprite_index==sprNTTEGatorAlert,"Den did not use original Gator portrait")
    with (_g2) scrNTTESewerWakeDen()
    assert(instance_number(NTTEAlert)==1,"Den repeated its alert per occupant")
    instance_destroy(enemy,false); instance_destroy(NTTEAlert,false)
    var _icons=[sprNTTEBanditAlert,sprNTTEFlyAlert,sprNTTEGatorAlert,sprNTTEPetScorpionIcon]
    for(var _i=0;_i<4;++_i) for(var _side=0;_side<8;++_side) {
        var _d=45*_side,_a=scrNTTEAlertCreate(10016+lengthdir_x(10000,_d),10016+lengthdir_y(10000,_d),_icons[_i])
        with (_a) {
            var _p=scrNTTEAlertPosition(10000,10000,320,180)
            assert(_p.x+_p.l>=10000 && _p.x+_p.r<=10320 && _p.y+_p.t>=10000 && _p.y+_p.b<=10180,"Edge/corner portrait or ! clipped outside viewport")
        }
        instance_destroy(_a,false)
    }
    var _cat=instance_create(10080,10016,NTTECat),_gas=instance_create(10080,10016,ToxicGas)
    assert(_cat.hp==10 && _cat.raddrop==6 && _cat.mask_index==mskRat,"Original Cat health/drop/mask mismatch")
    _gas.team=team_none
    with (_gas) scr_hit(_cat,3)
    with (_cat) with (_gas) event_perform(ev_collision,hitme)
    assert(_cat.hp==10 && instance_exists(_gas),"Cat toxic immunity consumed gas or lost health")
    // Exercise the real sitting-to-alert decision, rather than only Hurt/Stand.
    instance_destroy(PlasmaTrail,false)
    with (_cat) {
        ntte_cat_groundsit=true; ntte_cat_cantravel=false
        scrNTTECatDecision()
        assert(ntte_cat_cantravel && !ntte_cat_groundsit,"Nearby visible player failed to wake seated Cat")
    }
    assert(instance_number(PlasmaTrail)==1 && PlasmaTrail.sprite_index==sprAssassinNotice,"Cat waking did not display existing notice sprite")
    assert(PlasmaTrail.x==_cat.x && PlasmaTrail.y==_cat.y,"Cat waking notice anchor changed")
    scrNTTESmokeLog("CAT SEATED VISIBLE TARGET NATURAL WAKE NOTICE OK @"+string(rates[stage_rate]))
    instance_destroy(PlasmaTrail,false)
    _cat.ntte_cat_ammo=0; with (_cat) scrNTTECatStopLoop()
    _cat.ntte_cat_groundsit=true
    scr_hit(_cat,2)
    assert(_cat.hp==8 && !_cat.ntte_cat_groundsit,"Cat normal damage did not wake it")
    with (_cat) scrNTTECatHide()
    assert(scr_check_enemies() && !scrNTTEAimTargetAllowed(_cat,team_player),"Underground cat did not block portal or remained aim target")
    scr_hit(_cat,5)
    assert(_cat.hp==8,"Underground cat took damage")
    with (_cat) scrNTTECatEmerge(10080,10016)
    assert(_cat.visible && _cat.ntte_cat_active && _cat.mask_index==mskRat,"Cat emerge did not restore native state")
    _cat.team=team_player; _cat.ntte_charmed=true
    var _hostile=instance_create(10112,10016,Bandit)
    with (_cat) scrTarget()
    assert(_cat.target==_hostile && !scrNTTEAimTargetAllowed(_cat,team_player),"Friendly Cat targets player or autoaim includes ally")
    with (_cat) { ntte_cat_ammo=1; scrNTTECatSpray() }
    with (NTTECatGas) assert(team==team_player && creator==_cat,"Friendly Cat spray lost faction/creator")
    instance_destroy(projectile,false); instance_destroy(enemy,false)
    _cat=instance_create(10112,10016,NTTECat)
    var _bat=instance_create(10016,10016,NTTEBat)
    instance_deactivate_object(Player)
    with (_bat) { scrNTTEBatDecision(); scrNTTEBatScreech() }
    instance_activate_object(Player)
    assert(_bat.walk>=15 && abs(angle_difference(_bat.direction,0))<=8 && _cat.ntte_cat_cantravel,"Bat did not follow/alert its same-team Cat")
    instance_destroy(enemy,false); instance_destroy(projectile,false)
    scrNTTESmokeLog("BABY ORIGINAL SHADOW/ORIGIN DEN GROUP PORTRAIT 32 EDGE CASES CAT IMMUNITY HIDE ALLY BAT LINK OK")
}

function scrNTTESewerStageVisual() {
    var _surface=surface_create(320,180)
    surface_set_target(_surface); draw_clear_alpha(make_color_rgb(77,66,53),1)
    var _baby=instance_create(10000,10000,NTTEBabyGator)
    with (_baby) {
        x=80; y=90; gunangle=0; right=1; image_index=0
        draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y)
        scrNTTESewerDraw()
        x=240; y=90; z=10
        draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y)
        scrNTTESewerDraw()
    }
    instance_destroy(_baby,false)
    var _a=scrNTTEAlertCreate(-1000,90,sprNTTEGatorAlert)
    with (_a) { flash=0; scrNTTEAlertDraw(0,0,320,180) }
    instance_destroy(_a,false)
    _a=scrNTTEAlertCreate(1000,90,sprNTTEBanditAlert)
    with (_a) { flash=0; scrNTTEAlertDraw(0,0,320,180) }
    instance_destroy(_a,false)
    surface_reset_target()
    surface_save(_surface,working_directory+"sewer-stage-visual.png"); surface_free(_surface)
}

function scrNTTESewerStageSmokeStep() {
    if (!variable_instance_exists(id,"stage_rate")) { stage_rate=0; stage_tick=0; stage_phase=0 }
    with (Player) {
        hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0; x=10016; y=10016; race=Race.Fish
    }
    if (stage_tick==0 && stage_phase==0) {
        scrNTTEDesertSmokeClear(); instance_destroy(Explosion,false)
        UberCont.opt_framerate=rates[stage_rate]; game_set_speed(rates[stage_rate],gamespeed_fps)
        GameCont.area=area_sewers; GameCont.hard=8; GameCont.rad=10000
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        scrNTTESewerStageUnits()
        if (stage_rate==0) scrNTTESewerStageVisual()
        stage_baby=instance_create(10048,10064,NTTEBabyGator)
        stage_baby.hp=1000; stage_baby.max_hp=1000; stage_baby.ntte_gator_timer=1000
        // Keep the simultaneous neutral Cat gas from restarting this isolated
        // kick/landing check. Gas damage is exercised separately below.
        stage_baby.nexthurt=current_frame+1000; stage_baby.kick_invul=current_frame+1000
        stage_baby.zspeed=3; stage_baby.zbounce=1; stage_max_z=0
        stage_cat=instance_create(10080,10016,NTTECat)
        with (stage_cat) { scrNTTECatStand(); ntte_cat_ammo=10; ntte_cat_timer=4; gunangle=90 }
        stage_alert=scrNTTEAlertCreate(10048,10048,sprNTTEGatorAlert)
    }
    stage_tick+=timescale
    if (stage_phase==0) {
        stage_baby.nexthurt=current_frame+1000
        stage_max_z=max(stage_max_z,stage_baby.z)
        if (stage_tick>=40) {
            assert(stage_baby.z==0 && stage_max_z>6 && stage_max_z<=14 && stage_baby.spr_shadow==shd16,"Baby failed to land on original shadow at native FPS: "+string([stage_baby.z,stage_max_z,stage_baby.spr_shadow,shd16,stage_baby.zspeed,stage_baby.zbounce,stage_baby.hp,stage_baby.x,stage_baby.y]))
            assert(stage_cat.ntte_cat_shots==10 && stage_cat.ntte_cat_ammo==0 && stage_cat.ntte_cat_loop==-1,"Cat failed ten-shot/twenty-gas spray or loop cleanup")
            assert(instance_number(NTTECatGas)>0,"Cat spray emitted no gas")
            with (NTTECatGas) assert(team==team_none && creator==other.stage_cat && damage==3,"Hostile ground Cat gas damage/owner/neutral rule mismatch")
            assert(instance_exists(stage_alert) && stage_alert.flash<=0,"Alert lifetime/flash mismatch")
            scrNTTESmokeLog("LIVE BABY KICK/LAND CAT TEN SHOT SPRAY AND PORTRAIT FLASH OK @"+string(rates[stage_rate]))
            instance_destroy(enemy,false); instance_destroy(projectile,false)
            stage_hole=instance_create(10080,10064,NTTECatHole)
            stage_cat=instance_create(10080,10064,NTTECat)
            with (stage_cat) { scrNTTECatStand(); ntte_cat_timer=1000 }
            stage_hole.target=stage_cat; stage_hole.image_index=1; stage_hole.image_speed=0.4*timescale
            stage_phase=1; stage_tick=0
        }
    }
    else if (stage_phase==1 && stage_tick>=16) {
        assert(!stage_cat.ntte_cat_active && !stage_cat.visible && stage_cat.mask_index==mskNone,"Native CatHole failed to capture Cat")
        stage_hole2=instance_create(10080,10096,NTTECatHole)
        with (stage_cat) { assert(scrNTTECatReserveHole(true),"Underground Cat could not reserve exit"); ntte_cat_timer=1000 }
        stage_phase=2; stage_tick=0
        scrNTTESmokeLog("LIVE CAT ENTERS MANHOLE OK @"+string(rates[stage_rate]))
    }
    else if (stage_phase==2 && stage_tick>=5) {
        assert(stage_cat.ntte_cat_active && stage_cat.visible && point_distance(stage_cat.x,stage_cat.y,stage_hole2.x,stage_hole2.y)<24,"Native CatHole failed to release Cat at second cover")
        with (stage_cat) scrNTTECatHide()
        instance_destroy(NTTECatHole,false)
        stage_phase=3; stage_tick=0
        scrNTTESmokeLog("LIVE CAT EXITS SECOND MANHOLE OK @"+string(rates[stage_rate]))
    }
    else if (stage_phase==3 && stage_tick>=3) {
        assert(stage_cat.ntte_cat_active && stage_cat.visible,"Cat stranded after structural hole removal")
        // Player-blocked cover must clear its reservation after closing.
        var _cover=instance_create(10016,10016,NTTECatHole)
        _cover.image_index=1; _cover.image_speed=0.4*timescale; _cover.target=stage_cat
        with (_cover) scrNTTECatHoleStep()
        assert(_cover.image_index>=6 && _cover.target==noone,"Player-blocked cover retained stale Cat reservation")
        instance_destroy(_cover,false)
        stage_phase=4; stage_tick=0
    }
    else if (stage_phase==4 && stage_tick>=95) {
        assert(!instance_exists(stage_alert),"Original ninety-tick hold plus blinking alert did not expire")
        instance_destroy(enemy,false); instance_destroy(projectile,false); instance_destroy(Explosion,false)
        var _result=scrNTTESewerPopulate(NTTESewerEvent.Cats)
        assert(_result==NTTESewerEvent.Cats && instance_number(NTTECat)==3 && instance_number(NTTECatHole)==3 && instance_number(NTTEBat)==1,"CATS connected encounter missing members")
        with (NTTECat) assert(!place_meeting(x,y,Wall) && place_meeting(x,y,Floor),"Cat encounter spawned outside native walkable floor")
        instance_deactivate_object(id); scrCleanupAreaInstances(); instance_activate_object(id)
        assert(instance_number(NTTEAlert)==0 && instance_number(NTTECatHole)==0 && instance_number(NTTECat)==0,"Native area cleanup retained alerts/Cats/holes")
        scrNTTESmokeLog("CAT HOLE FALLBACK/BLOCKED COVER ALERT EXPIRY CATS GENERATION CLEANUP OK @"+string(rates[stage_rate]))
        if (++stage_rate>=3) {
            scrNTTESmokeLog("PASS SEWER STAGE 30/60/120: Baby grounded/kicked, original portraits and all viewport edges, Cat gas, underground recovery, friendly/Bat interaction and connected encounter")
            game_end(); return;
        }
        stage_phase=0; stage_tick=0
    }
}
