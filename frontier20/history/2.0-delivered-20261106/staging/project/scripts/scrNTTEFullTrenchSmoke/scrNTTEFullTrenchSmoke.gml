// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// Called by the unified complete-MOD desktop harness at each 30/60/120 rate.
function scrNTTEFullTrenchUnitTests() {
    var _angler=instance_create(10080,10016,NTTEFullAngler),
        _gold=instance_create(10112,10016,NTTEFullAnglerGold)
    assert(_angler.hp==45 && _gold.hp==72,"Angler native variant parent scaled twice or changed HP")
    assert(_angler.ntte_full_hiding && _angler.mask_index==scrNTTERefSprite("msk.AnglerHidden",_angler.right<0),"Angler initial lure mask mismatched facing")
    with (_angler) { hp-=1; scrNTTEFullAnglerHurt() }
    assert(!_angler.ntte_full_hiding && _angler.ntte_full_ammo==3 && _angler.mask_index==mskFrogQueen,"Damaged hidden Angler did not emerge or charge")
    assert(_gold.ntte_full_hiding,"Ordinary Angler incorrectly woke distant/stronger gold variant")
    with (_gold) scrNTTEFullAnglerAppear()
    assert(_gold.ntte_full_ammo==5 && _gold.ntte_full_timers[1]>12,"Gold Angler original five-charge sequence changed")
    with (_angler) { ntte_full_ammo=2; scrNTTEFullAnglerDecision() }
    assert(_angler.ntte_full_ammo==1 && abs(_angler.speed-13*timescale)<0.001,"Angler rush speed/timer was not converted to native frames")
    with (_gold) { ntte_full_ammo=2; scrNTTEFullAnglerDecision() }
    assert(_gold.ntte_full_ammo==1 && abs(_gold.speed-15*timescale)<0.001,"Gold Angler rush speed mismatch")
    instance_destroy(_angler,false); instance_destroy(_gold,false); instance_destroy(projectile,false)

    var _jelly=instance_create(10080,10016,NTTEFullJelly),_elite=instance_create(10144,10016,NTTEFullJellyElite)
    assert(_jelly.hp==42 && _elite.hp==42 && _elite.raddrop==32,"Elite Jelly changed the original HP/drop values")
    assert(_jelly.ntte_full_arc_max==3 && _elite.ntte_full_arc_max==5 && _elite.ntte_full_arc_dis==144,"Jelly arc capacity/range mismatch")
    var _eels=[]
    for(var _i=0;_i<4;++_i) {
        var _eel=instance_create(10080,10016+_i,NTTEFullEel)
        _eel.ntte_full_arc=noone
        with (_eel) scrNTTEFullEelDecision()
        array_push(_eels,_eel)
    }
    assert(_jelly.ntte_full_arc_num<=3 && _elite.ntte_full_arc_num<=5,"Eel attachments exceeded jelly capacity")
    var _eel=_eels[0]
    with (_eel) scrNTTEFullEelDetach()
    _eel.ntte_full_arc=_elite; ++_elite.ntte_full_arc_num; _eel.ntte_full_arcing=1
    with (_eel) scrNTTEFullEelStep()
    assert(abs(_eel.ntte_full_elite-(30-timescale))<0.001 && instance_number(NTTEFullTrenchLightning)>0,"Elite Jelly did not electrify its attached Eel")
    instance_destroy(_elite,false)
    with (_eel) scrNTTEFullEelStep()
    assert(_eel.ntte_full_arc==noone && _eel.ntte_full_arcing==0,"Destroyed jelly left an invalid arc reference")
    instance_destroy(enemy,false); instance_destroy(projectile,false)

    var _old_water=GameCont.underwater,_player=instance_find(Player,0),_hp=_player.hp
    GameCont.underwater=true
    var _segment=instance_create(10080,10016,NTTEFullTrenchLightning)
    assert(_player.hp==_hp,"Trench lightning executed vanilla global underwater damage")
    var _elite_eel=instance_create(10120,10016,NTTEFullEel)
    _elite_eel.hp=0; _elite_eel.ntte_full_elite=30
    with (_elite_eel) scrNTTEFullEelDeath()
    assert(_player.hp==_hp,"Elite Eel death invoked vanilla global underwater lightning damage")
    assert(instance_number(NTTEFullLightningDisc)==1 && instance_number(NTTEFullTrenchLightning)>=3,
        "Elite Eel did not create its original ring plus two delayed lightning seeds")
    _segment.team=team_enemy; _segment.hitid=[sprEnemyLightning,"JELLY"]
    var _victim=instance_create(10080,10016,Bandit)
    _victim.team=team_player; _victim.hp=100; _victim.max_hp=100; _victim.nexthurt=0
    with (_victim) with (_segment) event_perform(ev_collision,hitme)
    assert(_victim.hp==98,"Native trench lightning collision damage mismatch")
    _victim.team=team_enemy; _victim.nexthurt=0
    with (_victim) with (_segment) event_perform(ev_collision,hitme)
    assert(_victim.hp==98,"Trench lightning damaged a same-team ally")
    GameCont.underwater=_old_water
    instance_destroy(enemy,false); instance_destroy(projectile,false)

    var _ring=instance_create(10080,10016,NTTEFullLightningDisc)
    _ring.creator=noone; _ring.ntte_full_follow=false; _ring.ntte_full_enemy=true; _ring.team=team_enemy
    for(var _step=0;_step<ceil(10/timescale);++_step) with (_ring) scrNTTEFullLightningDiscStep()
    assert(abs(_ring.image_xscale-1)<0.001 && _ring.sprite_index==sprEnemyLightning,"Enemy ring charge duration or native sprite changed with render rate")
    with (_ring) scrNTTEFullLightningDiscStep()
    assert(_ring.ntte_full_charge==0,"Charged enemy ring did not release")
    var _life=0
    while(instance_exists(_ring) && _life<170) {
        with (_ring) scrNTTEFullLightningDiscStep()
        _life+=timescale
    }
    assert(!instance_exists(_ring) && _life>157 && _life<162,"Ring lifetime changed with render rate")
    instance_destroy(projectile,false)
    scrNTTESmokeLog("FULL TRENCH ANGLER GOLD CHARGE JELLY EEL ARC FACTION UNDERWATER RING CT OK @"+string(30/timescale))
}

function scrNTTEFullLairWorldUnitTests() {
    var _types=scrNTTEFullLairRoomTypes(),_keys=variable_struct_get_names(_types)
    assert(array_length(_keys)==20,"Lair lost an original room template")
    assert(_types.Boss.w==12 && _types.Boss.h==12 && !_types.Boss.layout[0][0]
        && _types.Boss.layout[0][3] && _types.SmallTriangle.layout[2][2],"Lair special floor masks changed")
    var _seed=random_get_seed()
    for(var _trial=0;_trial<12;++_trial) {
        random_set_seed(21403+_trial)
        var _rooms=scrNTTEFullLairPlan(),_start=0,_boss=0
        assert(array_length(_rooms)==6,"Lair goal100 must create four ordinary rooms plus start/boss")
        for(var _i=0;_i<array_length(_rooms);++_i) {
            var _r=_rooms[_i]
            if (_r.type=="Start") { ++_start; assert(_r.x==-1 && _r.y==-1,"Lair starting room moved away from player spawn") }
            if (_r.type=="Boss") { _boss+=1 }
            assert(_r.link<array_length(_rooms) && _r.link!=_i,"Lair corridor linked an invalid/self room")
            for(var _j=_i+1;_j<array_length(_rooms);++_j) {
                var _b=_rooms[_j]
                assert(!rectangle_in_rectangle(_r.x,_r.y,_r.x+_r.w,_r.y+_r.h,_b.x,_b.y,_b.x+_b.w,_b.y+_b.h),
                    "Lair packing left overlapping room rectangles")
            }
        }
        assert(_start==1 && _boss==1,"Lair duplicated/lost a special room")
    }
    random_set_seed(_seed)
    var _pair=scrNTTEFullCatDoorPair(10080,10016,90),_first=_pair[0],_second=_pair[1]
    assert(_first.ntte_full_partner==_second && _second.ntte_full_partner==_first,"Lair double doors did not link reciprocally")
    assert(_first.hp==15 && _second.hp==15,"CatDoor HP changed from MOD's15")
    scr_hit(_first,4)
    assert(_first.hp==11 && _second.hp==11,"Real projectile damage did not propagate to the paired door")
    var _prevent=instance_create(0,0,NTTEFullPortalPrevent); _prevent.creator=_first
    assert(scrNTTEFullPortalBlocked(),"Lair boss manhole did not prevent a premature portal")
    instance_destroy(_first,false)
    assert(!scrNTTEFullPortalBlocked() && !instance_exists(_prevent),"Destroyed boss controller left a permanent portal block")
    instance_destroy(_second,false)
    var _chair=scrNTTEFullLairPropCreate(10080,10016,"ChairSide"),_table=scrNTTEFullLairPropCreate(10112,10016,"Table"),
        _cabinet=scrNTTEFullLairPropCreate(10144,10016,"Cabinet"),_couch=scrNTTEFullLairPropCreate(10176,10016,"Couch")
    assert(_chair.hp==4 && _table.hp==8 && _cabinet.hp==20 && _couch.hp==20,"Lair furniture HP was altered by native inheritance")
    instance_destroy(_chair,false); instance_destroy(_table,false); instance_destroy(_cabinet,false); instance_destroy(_couch,false)
    scrNTTESmokeLog("FULL LAIR 12 SEEDED ROOM PLANS DOOR SHARED HP PORTAL GATE FURNITURE OK @"+string(30/timescale))
}

function scrNTTEFullTrenchPitUnitTests() {
    var _old_grid=variable_global_exists("ntte_full_trench_pit_grid") ? global.ntte_full_trench_pit_grid:-1,
        _old_dirty=variable_global_exists("ntte_full_trench_pit_dirty") ? global.ntte_full_trench_pit_dirty:false,
        _old_count=variable_global_exists("ntte_full_trench_floor_count") ? global.ntte_full_trench_floor_count:-1
    global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
    ds_grid_clear(global.ntte_full_trench_pit_grid,false)
    var _probe=instance_create(10008,10008,NTTEDesertDecor)
    _probe.mask_index=mskBandit; _probe.image_xscale=1; _probe.image_yscale=1
    var _x1=floor(_probe.bbox_left/16)*16,_y1=floor(_probe.bbox_top/16)*16,
        _x2=ceil(((_probe.bbox_right-1)+1)/16)*16,_y2=ceil(((_probe.bbox_bottom-1)+1)/16)*16
    for(var _px=_x1;_px<_x2;_px+=16) for(var _py=_y1;_py<_y2;_py+=16) scrNTTEFullTrenchPitSet(_px,_py,true)
    var _on_land=true
    with (_probe) _on_land=scrNTTEFullTrenchPitlessMeeting(x,y)
    assert(!_on_land,"Trench tentacle footprint inside the pit was incorrectly blocked")
    scrNTTEFullTrenchPitSet(_x1,_y1,false)
    with (_probe) _on_land=scrNTTEFullTrenchPitlessMeeting(x,y)
    assert(_on_land,"Trench collision checked only center and let tentacles cross a solid corner")
    assert(!scrNTTEFullTrenchPitGet(-16,10000) && !scrNTTEFullTrenchPitGet(20000,10000),"Out-of-world pit lookup did not safely return land")
    var _sink=scrNTTEFullTrenchPitSink(10016,10016,sprBigSkullDead,0,1,1,0,90,0,0.6)
    with (_sink) scrNTTEFullPitSinkStep()
    assert(_sink.image_xscale<1 && _sink.image_yscale<1 && _sink.image_blend!=c_white
        && abs(_sink.image_angle-0.6*timescale)<0.001,"Pit-sinking sprite did not darken, shrink and turn in logical time")
    var _floor=instance_create(15008,15008,Floor)
    _floor.sprite_index=scrNTTERefSprite("FloorTrenchB")
    scrNTTEFullTrenchPitRebuild()
    assert(scrNTTEFullTrenchPitGet(15008,15008) && scrNTTEFullTrenchPitGet(15039,15039)
        && !scrNTTEFullTrenchPitGet(15040,15008) && !scrNTTEFullTrenchPitGet(15008,15040),
        "32pixel floor pit rebuild extended into a third16pixel tile through inclusive/exclusive bbox confusion")
    instance_destroy(_floor,false)
    instance_destroy(_probe,false); instance_destroy(_sink,false)
    scrNTTEFullTrenchPitBatchUnitTests()
    scrNTTEFullPitlessLocalReadsTests()
    ds_grid_destroy(global.ntte_full_trench_pit_grid)
    global.ntte_full_trench_pit_grid=_old_grid; global.ntte_full_trench_pit_dirty=_old_dirty
    global.ntte_full_trench_floor_count=_old_count
    scrNTTESmokeLog("FULL TRENCH GRID FOOTPRINT BOUNDARY PIT SINK OK @"+string(30/timescale))
}

// Independent preoptimization rebuild: every valid tile immediately resets
// all five settled-object families, exactly as the old production path did.
function scrNTTEFullTrenchPitRebuildOldTests() {
    scrNTTEFullTrenchPitReset(false)
    var _pits=scrNTTERefSprite("FloorTrenchB")
    with(Floor) if(sprite_index==_pits) {
        for(var _px=bbox_left;_px<(bbox_right-1)+1;_px+=16) for(var _py=bbox_top;_py<(bbox_bottom-1)+1;_py+=16) {
            if(!position_meeting(_px+8,_py+8,Wall)) scrNTTEFullTrenchPitSet(_px,_py,true)
        }
    }
    with(Floor) if(sprite_index!=_pits) {
        for(var _px=bbox_left;_px<(bbox_right-1)+1;_px+=16) for(var _py=bbox_top;_py<(bbox_bottom-1)+1;_py+=16)
            scrNTTEFullTrenchPitSet(_px,_py,false)
    }
    global.ntte_full_trench_floor_count=instance_number(Floor)
}

function scrNTTEFullTrenchPitBatchUnitTests() {
    var _hidden=scrNTTEFullInstances([Floor,Wall,Corpse,ChestOpen,Debris,Shell,Feather]),_created=[],
        _settled=[],_seed=random_get_seed(),_native_rng=json_stringify(global.rng_state),
        _rate=game_get_speed(gamespeed_fps),_area=GameCont.area,
        _shine_before=instance_exists(NTTEFullRedWallShine)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        GameCont.area=scrNTTEFullAreaId("trench")
        var _types=[Corpse,ChestOpen,Debris,Shell,Feather]
        for(var _t=0;_t<array_length(_types);++_t) repeat(32) {
            var _v=instance_create(14900,14900,_types[_t])
            array_push(_settled,_v);array_push(_created,_v)
            _v.ntte_full_trench_pit_checked=true
        }
        // The immediate public setter still invalidates settled-object checks,
        // whereas invalid coordinates must preserve every checked flag.
        scrNTTEFullTrenchPitSet(-16,0,true)
        for(var _i=0;_i<array_length(_settled);++_i)
            assert(_settled[_i].ntte_full_trench_pit_checked,"Out-of-grid pit write changed settled-object flags")
        scrNTTEFullTrenchPitSet(14900,14900,true)
        for(var _i=0;_i<array_length(_settled);++_i)
            assert(!_settled[_i].ntte_full_trench_pit_checked,"Immediate pit setter failed to invalidate a settled-object family")
        for(var _i=0;_i<array_length(_settled);++_i) _settled[_i].ntte_full_trench_pit_checked=true
        // No valid write previously left checked flags alone, even though the
        // grid clear itself still makes the renderer dirty.
        scrNTTEFullTrenchPitRebuild()
        for(var _i=0;_i<array_length(_settled);++_i)
            assert(_settled[_i].ntte_full_trench_pit_checked,"Empty pit rebuild gained settled-object invalidation")
        for(var _i=0;_i<128;++_i) {
            var _v=instance_create(15008+(_i mod 16)*32,15008+(_i div 16)*32,Floor)
            _v.sprite_index=scrNTTERefSprite("FloorTrenchB")
            array_push(_created,_v)
        }
        // The real Floor constructor rejects overlap. Create a genuine land
        // tile clear of the fixture, then place it over the pit to test the
        // original non-pit second pass without bypassing that constructor.
        var _land=instance_create(17000,17000,Floor),_wall=instance_create(15104,15008,Wall)
        assert(instance_exists(_land) && instance_exists(_wall),"Pit batch fixture terrain constructors did not survive")
        _land.x=15024;_land.y=15024;_land.sprite_index=scrNTTERefSprite("FloorTrench")
        array_push(_created,_land,_wall)
        var _fixture_seed=random_get_seed(),_fixture_native=json_stringify(global.rng_state),
            _before_count=instance_number(all),_old_start=get_timer()
        scrNTTEFullTrenchPitRebuildOldTests()
        var _old_us=get_timer()-_old_start,_expected=ds_grid_write(global.ntte_full_trench_pit_grid),
            _old_count=global.ntte_full_trench_floor_count
        for(var _i=0;_i<array_length(_settled);++_i) {
            assert(!_settled[_i].ntte_full_trench_pit_checked,"Old pit oracle failed to exercise settled-object flags")
            _settled[_i].ntte_full_trench_pit_checked=true
        }
        var _new_start=get_timer()
        scrNTTEFullTrenchPitRebuild()
        var _new_us=get_timer()-_new_start
        assert(ds_grid_write(global.ntte_full_trench_pit_grid)==_expected
            && global.ntte_full_trench_floor_count==_old_count && global.ntte_full_trench_pit_dirty,
            "Batched pit rebuild changed exact full-grid data, floor count or renderer invalidation")
        assert(scrNTTEFullTrenchPitGet(15008,15008) && !scrNTTEFullTrenchPitGet(15024,15024)
            && !scrNTTEFullTrenchPitGet(15112,15016),"Pit, overlapping land or wall precedence changed")
        for(var _i=0;_i<array_length(_settled);++_i)
            assert(!_settled[_i].ntte_full_trench_pit_checked,"Batched pit rebuild omitted a settled-object family")
        assert(random_get_seed()==_fixture_seed && json_stringify(global.rng_state)==_fixture_native
            && instance_number(all)==_before_count && game_get_speed(gamespeed_fps)==_rate,
            "Pit rebuild changed RNG, native streams, actors or actual frame rate")
        scrNTTESmokeLog("TRENCH PIT BATCH CPU "+json_stringify({floors:128,settled:array_length(_settled),
            old_us:_old_us,new_us:_new_us,rate:_rate,exact_full_grid:true,mobile_device_tested:false}))
    }
    finally {
        for(var _i=array_length(_created)-1;_i>=0;--_i) if(instance_exists(_created[_i])) instance_destroy(_created[_i],false)
        if(!_shine_before) instance_destroy(NTTEFullRedWallShine,false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        GameCont.area=_area;random_set_seed(_seed)
        assert(json_stringify(global.rng_state)==_native_rng,"Pit batch fixture changed native RNG streams")
    }
}

function scrNTTEFullTrenchTerrainUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area,
        _old_grid=variable_global_exists("ntte_full_trench_pit_grid") ? global.ntte_full_trench_pit_grid:-1,
        _old_dirty=variable_global_exists("ntte_full_trench_pit_dirty") ? global.ntte_full_trench_pit_dirty:false,
        _old_count=variable_global_exists("ntte_full_trench_floor_count") ? global.ntte_full_trench_floor_count:-1
    global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250); ds_grid_clear(global.ntte_full_trench_pit_grid,false)
    GameCont.area=scrNTTEFullAreaId("trench")
    var _land=instance_create(15008,15008,Floor)
    _land.sprite_index=scrNTTERefSprite("FloorTrench"); _land.styleb=false
    var _clear=instance_create(15024,15024,PortalClear)
    _clear.pit_clear=0.75; _clear.pit_smash=true; _clear.image_xscale=0.4; _clear.image_yscale=0.4
    var _xs=_clear.image_xscale,_ys=_clear.image_yscale
    scrNTTEFullTrenchOpenPits()
    var _pit=collision_point(15024,15024,Floor,false,false)
    assert(instance_exists(_pit) && _pit.sprite_index==scrNTTERefSprite("FloorTrenchB")
        && _pit.styleb && _pit.depth==9,"PitSquid smash did not replace real land with original depth9pit terrain")
    assert(scrNTTEFullTrenchPitGet(15024,15024),"Same-count floor replacement failed to dirty/rebuild the pit grid")
    assert(_clear.image_xscale==_xs && _clear.image_yscale==_ys,"Pit clear pass leaked temporary collision scaling")
    var _chunk=instance_create(15120,15024,NTTEFullTrenchFloorChunk)
    _chunk.ntte_full_z=0; _chunk.ntte_full_zspeed=8; _chunk.ntte_full_zfriction=0.3
    with (_chunk) scrNTTEFullTrenchFloorChunkStep()
    assert(abs(_chunk.ntte_full_z-8*timescale)<0.001 && abs(_chunk.ntte_full_zspeed-(8-0.3*timescale))<0.001,
        "Squid floor chunk launch gravity changed with render rate")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    ds_grid_destroy(global.ntte_full_trench_pit_grid)
    global.ntte_full_trench_pit_grid=_old_grid; global.ntte_full_trench_pit_dirty=_old_dirty; global.ntte_full_trench_floor_count=_old_count
    GameCont.area=_area
    scrNTTESmokeLog("FULL TRENCH SQUID REAL FLOOR SMASH SAME COUNT PIT INVALIDATION ORIGINAL CHUNK GRAVITY OK @"+string(30/timescale))
}

function scrNTTEFullSewerBossUnitTests() {
    var _bat=instance_create(10080,10016,NTTEFullBatBoss),_cat=instance_create(10144,10016,NTTEFullCatBoss)
    assert(_bat.hp==200 && _cat.hp==200,"Paired sewer boss HP received an extra native enemy scaling pass")
    assert(_bat.spr_shadow==shd64 && _bat.spr_shadow_y==12 && _cat.spr_shadow==shd48 && _cat.spr_shadow_y==3,"Sewer boss inherited shadow anchors mismatch")
    _bat.ntte_full_timers[0]=-1; _cat.ntte_full_timers[0]=-1
    _cat.ntte_full_super_time=29
    scr_hit(_cat,1)
    assert(_cat.ntte_full_super_time==0 && _cat.ntte_full_super_break==5 && _cat.ntte_full_timers[1]>=40,"Actual hit did not interrupt Cat super charge")
    _cat.ntte_full_super_time=20; _cat.ntte_full_super_break=0
    scr_hit(_cat,1)
    assert(_cat.ntte_full_super_time==20,"Exhausted Cat super-break limit allowed a permanent stun lock")
    var _gas=instance_create(_cat.x,_cat.y,NTTECatGas),_hp=_cat.hp
    with (_gas) scr_hit(_cat,5)
    assert(_cat.hp==_hp,"Cat boss did not retain original toxic immunity")
    instance_destroy(projectile,false)
    scr_hit(_bat,101)
    assert(_bat.hp==99 && instance_number(NTTEBatScreech)==6,"Bat half-health threshold did not make center plus five extra screeches")
    instance_destroy(projectile,false)
    with (_bat) scrNTTEFullBatBossMorph()
    assert(!_bat.ntte_full_active && _bat.mask_index==mskNone && instance_number(NTTEFullBatCloud)==3+2*GameCont.loops,"Bat morph count or invulnerable state mismatch")
    var _cloud=instance_find(NTTEFullBatCloud,0)
    _cloud.ntte_full_saved_hp=12
    instance_destroy(_cloud,true)
    var _child=instance_find(NTTEBat,0)
    assert(instance_exists(_child) && _child.creator==_bat && _child.hp==12 && !_child.givekill,"Morph cloud failed to preserve child ownership/health/kill accounting")
    with (_bat) scrNTTEFullBatBossMorph()
    assert(_bat.ntte_full_active && _bat.visible && instance_number(NTTEBat)==0 && instance_number(NTTEFullBatCloud)==0,"Bat reappearance did not clean its morph minions")
    _bat.hp=100; _bat.ntte_full_last_hp=100
    _cat.hp=0
    with (_cat) scrNTTEFullCatBossDeath()
    _cat.hp=1
    assert(_bat.max_hp==250 && _bat.hp==100 && instance_number(NTTEFullBossHealController)==1,"Partner death gave an unconditional immediate heal")
    var _control=instance_find(NTTEFullBossHealController,0)
    assert(array_length(_control.ntte_full_rads)==15 && _control.ntte_full_heal==4,"Partner death changed original 24-rad split or per-rad heal rounding")
    with (_control) {
        for(var _i=0;_i<array_length(ntte_full_rads);++_i) ntte_full_rads[_i].speed=0
        scrNTTEFullBossHealControllerStep()
        for(var _i=0;_i<array_length(ntte_full_rads);++_i) {
            var _r=ntte_full_rads[_i]
            if (instance_exists(_r)) { _r.x=_bat.x; _r.y=_bat.y }
        }
        scrNTTEFullBossHealControllerStep()
    }
    assert(_bat.hp==160 && _bat.raddrop==48,"Arriving partner rads did not transfer their actual healing/radiation values")
    instance_destroy(_bat,false); instance_destroy(_cat,false)
    instance_destroy(NTTEFullBossHealController,false); instance_destroy(projectile,false)
    scrNTTESmokeLog("FULL SEWER BOSSES HALFHP MORPH CHILD OWNERSHIP CAT INTERRUPT TOXIN DELAYED RAD HEAL OK @"+string(30/timescale))
}

// Exercise real damage hooks and projectile state, rather than only checking
// field initialization. The caller uses a clean encounter with one real Player.
function scrNTTEFullTrenchBossWeaponUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_player=instance_find(Player,0),_player_hp=_player.hp,
        _water=GameCont.underwater
    GameCont.underwater=true
    var _first=instance_create(10080,10016,NTTEFullElectroPlasma),
        _second=instance_create(10112,10016,NTTEFullElectroPlasma)
    _first.creator=_player; _first.team=team_player; _first.speed=2*timescale; _first.friction=0
    _first.ntte_full_tether_inst=_second
    _second.creator=_player; _second.team=team_player; _second.speed=2*timescale; _second.friction=0
    for(var _step=0;_step<ceil(6/timescale);++_step) with (_first) scrNTTEFullElectroPlasmaStep()
    assert(_first.ntte_full_tether>=1 && instance_number(NTTEFullTrenchLightning)>0,"Electroplasma never completed its original5tick tether charge")
    var _arc=instance_find(NTTEFullTrenchLightning,0)
    assert(_arc.creator==_player && _arc.team==team_player && _arc.damage==7,"Electroplasma tether lost creator/faction/base damage")
    assert(_player.hp==_player_hp,"Electroplasma invoked vanilla global underwater damage")
    _second.x=10300
    with (_first) scrNTTEFullElectroPlasmaStep()
    assert(_first.ntte_full_tether==0,"Electroplasma did not dissolve an out-of-range tether")

    var _beam=instance_create(10080,10112,NTTEFullQuasarBeam),_victim=instance_create(10112,10112,Bandit)
    _beam.creator=_player; _beam.team=team_player; _beam.ntte_full_follow=false
    _victim.hp=100; _victim.max_hp=100; _victim.nexthurt=0; _victim.size=1
    with (_beam) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==76,"Quasar initial blast was not24damage at original unit scale")
    _beam.ntte_full_blast=false
    with (_beam) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==76,"Quasar damaged one target twice in its6tick target window")
    _beam.ntte_full_hit_time=6-timescale/2
    with (_beam) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==76,"Quasar target window reopened before6logical ticks")
    _beam.ntte_full_hit_time=6
    with (_beam) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==64,"Quasar failed to reopen target window at exactly6logical ticks")
    _victim.team=team_player; _beam.ntte_full_hit_time=12
    // Source trace snapshots opposing teams; source Hit itself has ONLY its
    // private6/3tick map. These are intentionally two different contracts.
    _victim.x=_beam.x+20;_victim.y=_beam.y;_beam.ntte_full_distance=120
    with(_beam) scrNTTEFullQuasarBeamLine()
    assert(_victim.hp==64,"Quasar source trace snapshot damaged same-team target")
    with(_victim) with(_beam) event_perform(ev_collision,hitme)
    assert(_victim.hp==64,"Quasar original CustomProjectile outerteam Collision damaged same-team target")
    with (_beam) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==52,"Quasar direct source Hit gained team gate outside private target map")
    _beam.ntte_full_shrink_delay=0; _beam.ntte_full_shrink=0.05; _beam.ntte_full_max_distance=0
    var _scale=_beam.image_yscale
    with (_beam) scrNTTEFullQuasarBeamStep()
    assert(abs(_beam.image_yscale-(_scale-0.05*timescale))<0.001,"Quasar shrink did not follow logical tick rate")

    var _boss=instance_create(10176,10208,NTTEFullPitSquid),_initial=scrNTTEFullSewerBossHP(340)
    assert(_boss.hp==_initial && _boss.x==0 && _boss.y==0 && _boss.ntte_full_x==10176
        && _boss.ntte_full_y==10208 && _boss.mask_index==mskNone,"PitSquid hidden root/real position or340HP scaling changed")
    var _arm=instance_create(10112,10208,NTTEFullPitSquidArm),_sibling=instance_create(10144,10208,NTTEFullPitSquidArm)
    _arm.creator=_boss; _sibling.creator=_boss; _arm.hp=10; _arm.max_hp=10
    with (_beam) scr_hit(_arm,20)
    assert(_arm.hp==-10 && _boss.hp==_initial-10,"Tentacle overkill forwarded more than the arm's remaining health")
    assert(_sibling.nexthurt==current_frame+6,"Tentacle damage failed to share boss iframe window with sibling arms")
    _boss.hp=ceil(_boss.max_hp/2)+1; _boss.ntte_full_ammo=0; _boss.ntte_full_timers[2]=0
    with (_beam) scr_hit(_boss,2)
    assert(_boss.ntte_full_bite==1 && _boss.ntte_full_timers[2]>=45,"Actual PitSquid half-health hit did not start bite and attack pause")
    GameCont.underwater=_water
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTESmokeLog("FULL TRENCH ELECTRO TETHER OWNER UNDERWATER QUASAR6TICK WINDOW SOURCE TRACE TEAM FILTER / DIRECT MAP-ONLY HIT SQUID ARM OVERKILL HALFHP OK @"+string(30/timescale))
}

function scrNTTEFullTrenchPropsUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_want=instance_create(10080,10016,NTTEFullWantEel)
    assert(!_want.visible && _want.elite==10 && _want.ntte_full_timers[1]>=150 && _want.ntte_full_timers[1]<=600,
        "Waiting Eel initial hidden state/delay/elite duration changed")
    var _gate=noone
    with (NTTEFullPortalPrevent) if (creator==_want) _gate=id
    assert(instance_exists(_gate),"Waiting Eel failed to hold the exit portal")
    _want.elite=150; _want.visible=true; _want.ntte_full_pit_height=0.98; _want.ntte_full_timers[1]=-1
    var _elapsed=0
    while(instance_exists(_want) && _elapsed<3) {
        with (_want) scrNTTEFullWantEelStep()
        _elapsed+=timescale
    }
    assert(!instance_exists(_want) && !instance_exists(_gate),"Risen Eel retained its placeholder or portal prevent")
    var _eel=instance_nearest(10080,10016,NTTEFullEel)
    assert(instance_exists(_eel) && _eel.ntte_full_elite==150 && _eel.ntte_full_timers[1]==30,
        "Eel Grave lost elite duration or initial decision delay during emergence")
    var _before=instance_number(WepPickup),_skull=instance_create(10144,10016,NTTEFullEelSkull)
    assert(_skull.hp==50 && _skull.size==2 && _skull.sprite_index==scrNTTERefSprite("EelSkullIdle"),"Eel skull lost original native BigSkull stats")
    _skull.hp=0
    with (_skull) { scrNTTEFullEelSkullDeath(); scrNTTEFullEelSkullDeath() }
    assert(instance_number(WepPickup)==_before+1,"Eel skull bone drop duplicated or did not happen")
    var _bone=instance_nearest(_skull.x,_skull.y,WepPickup)
    assert(_bone.wep==wep_ntte_bone,"Eel skull produced the wrong bone weapon")
    var _vent=instance_create(10176,10016,NTTEFullVent)
    assert(_vent.hp==12 && _vent.size==1 && _vent.spr_shadow==mskNone,"Trench vent original12HP or shadow setup changed")
    var _spark=instance_create(10208,10016,NTTEFullPitSpark),_rotation=_spark.ntte_full_tentacle.rotation,
        _right=_spark.ntte_full_tentacle.right,_life=_spark.ntte_full_life
    with (_spark) scrNTTEFullPitSparkStep()
    assert(abs(_spark.ntte_full_life-(_life-timescale))<0.001
        && abs(_spark.ntte_full_tentacle.rotation-(_rotation+_right*7*timescale))<0.001,"Pit spark timer/rotation changed with render rate")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTESmokeLog("FULL TRENCH WAIT EEL REAL EMERGENCE PORTAL GATE ELITE150 SKULL SINGLE BONE VENT SPARK CLOCK OK @"+string(30/timescale))
}

function scrNTTEFullLairPopulationUnitTests() {
    var _crown=GameCont.crown,_norad=GameCont.noradch
    GameCont.crown=Crown.Love; GameCont.noradch=2
    var _native_chest=scrNTTEFullLairChestCreate(38016,38016,HealthChest,false)
    assert(instance_is(_native_chest,AmmoChest),"Native typed HealthChest asset bypassed original Crown of Love replacement")
    assert(GameCont.noradch==2,"Non-level chest creation leaked native rad-chest counter override")
    instance_destroy(_native_chest,false)
    var _native_prop=scrNTTEFullLairCreate(38048,38016,Tires)
    assert(instance_is(_native_prop,Tires),"Native typed prop asset was incorrectly treated as a mod object name")
    instance_destroy(_native_prop,false)
    GameCont.crown=_crown; GameCont.noradch=_norad
    var _templates=scrNTTEFullLairRoomTypes(),_cases=["Start","SmallClutter","SmallPillars","SmallTriangle","LargeRing","SmallAtrium"],
        _seed=random_get_seed()
    for(var _trial=0;_trial<array_length(_cases);++_trial) {
        var _snapshot=scrNTTEFullInstances(all),_kind=_cases[_trial],
            _r=scrNTTEFullLairRoomNew(10,10,_kind,_templates),_walls=instance_number(Wall),
            _enemies=instance_number(enemy),_props=instance_number(NTTEFullLairProp),_rugs=instance_number(Carpet)
        random_set_seed(198301+_trial)
        scrNTTEFullLairPopulateRoom(_r)
        switch(_kind) {
            case "Start": assert(instance_number(Carpet)==_rugs+1,"Original start room lost its SewerRug"); break
            case "SmallClutter": assert(instance_number(NTTEFullLairProp)>=_props+2 && instance_number(NTTEFullLairProp)<=_props+4,
                "SmallClutter changed original2..4furniture density"); break
            case "SmallPillars": assert(instance_number(Wall)==_walls+4 && instance_number(enemy)==_enemies+1,
                "SmallPillars changed four wall coordinates or one encounter spawn"); break
            case "SmallTriangle": assert(instance_number(Wall)==_walls+3 && instance_number(enemy)>=_enemies+1
                && instance_number(enemy)<=_enemies+2,"SmallTriangle changed diagonal wall count or enemy range"); break
            case "LargeRing": assert(instance_number(Wall)==_walls+4 && instance_number(enemy)==_enemies+4,
                "LargeRing did not retain four independent corner encounters"); break
            case "SmallAtrium": assert(instance_number(Wall)==_walls+16 && instance_number(enemy)>=_enemies+5
                && instance_number(enemy)<=_enemies+10,"SmallAtrium lost source inclusive360degree fifth spawn group or16walls"); break
        }
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    }
    random_set_seed(_seed)
    scrNTTEFullLairPlacementRegression()
    scrNTTESmokeLog("FULL LAIR ORIGINAL START RUG CLUTTER DENSITY PILLAR TRIANGLE RING ATRIUM POPULATION OK @"+string(30/timescale))
}

function scrNTTEFullLairPlacementRegression() {
    var _state=scrNTTEFullVanillaFixtureBegin()
    try {
        GameCont.area=scrNTTEFullAreaId("lair");GameCont.ntte_full_lair_rooms=[]
        for(var _ix=0;_ix<12;++_ix) for(var _iy=0;_iy<12;++_iy)
            instance_create(97000+32*_ix,97000+32*_iy,Floor)
        var _wall=instance_create(97096,97096,Wall),_body=instance_create(97104,97104,Bandit),
            _origin=[_body.xstart,_body.ystart],_hp=_body.hp,_rads=_body.raddrop,_count=1,_free=noone
        repeat(23) {
            _free=instance_create(97200+32*(_count mod 4),97200+32*(_count div 4),Bandit)
            _count++
        }
        var _free_pos=[_free.x,_free.y],
            _seed=random_get_seed(),_wall_count=instance_number(Wall),_corpses=instance_number(Corpse)
        with(_body) assert(place_meeting(x,y,Wall),"Lair placement fixture did not reproduce an overlapping real enemy mask")
        scrNTTEFullLairPopExtras()
        with(_body) assert(!place_meeting(x,y,Wall) && place_meeting(x,y,Floor),
            "Actual Lair population tail left an ordinary ground enemy inside a wall")
        assert(_body.xstart==_origin[0] && _body.ystart==_origin[1]
            && _body.xprevious==_body.x && _body.yprevious==_body.y,
            "Lair final placement changed source spawn provenance or left stale motion history")
        assert(_free.x==_free_pos[0] && _free.y==_free_pos[1] && _body.hp==_hp && _body.raddrop==_rads
            && instance_number(enemy)==24 && instance_exists(_wall) && instance_number(Wall)==_wall_count
            && instance_number(Corpse)==_corpses && random_get_seed()==_seed,
            "Lair one-time placement altered an already safe enemy, combat values, counts, terrain or RNG")
    }
    finally {scrNTTEFullVanillaFixtureEnd(_state)}
    scrNTTESmokeLog("LAIR ENEMY PLACEMENT actual population tail resolves wall overlap once through source nearest-space search; safe enemies/spawn origins/HP/rads/walls/counts/RNG preserved @"+string(30/timescale))
}

function scrNTTEFullTrenchNativeEffectsUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_fish=instance_create(10560,10560,FishA)
    assert(_fish.sprite_index==sprFishA && abs(_fish.image_speed-0.4*timescale)<0.001,
        "Recovered FishA lost original sprite/0.4logical animation speed")
    with (_fish) event_perform(ev_other,ev_animation_end)
    assert(!instance_exists(_fish),"Original FishA failed to disappear at animation end")
    var _delay=instance_create(10560,10560,ToxicDelay),_gases=instance_number(ToxicGas)
    assert(_delay.alarm[0]==7 && _delay.creator==noone && _delay.team==team_none,
        "Recovered ToxicDelay initial7tick delay/owner/faction changed")
    _delay.creator=id; _delay.team=team_player
    with (_delay) event_perform(ev_alarm,0)
    assert(instance_number(ToxicGas)==_gases+14 && instance_exists(_delay),
        "Original ToxicDelay did not produce exactly14clouds or wrongly destroyed itself")
    with (ToxicGas) if (creator==other.id) assert(team==team_none,"ToxicDelay propagated faction absent in original Alarm0")
    var _owner=scrNTTEFixTestDummy(10624,10560,team_player),
        _target=scrNTTEFixTestDummy(10688,10560,team_enemy),
        _ally=scrNTTEFixTestDummy(10656,10560,team_player),
        _coil=scr_projectile_create(_owner.x,_owner.y,NTTEFullTeslaCoil,0,0)
    _coil.creator=_owner; _coil.team=team_player; _coil.ntte_full_offx=0; _coil.ntte_full_offy=0
    _coil.ntte_full_purple=true; _coil.damage=6
    var _guard=0
    while(_coil.ntte_full_target_delay>=0 && _guard<8) { with (_coil) scrNTTEFullTeslaCoilStep(); ++_guard }
    assert(_coil.target==_target,"Original TeslaCoil selected a friendly unit or missed opposing unit in range")
    var _nodes=0
    with (NTTEFullTrenchLightning) if (creator==_owner) {
        ++_nodes
        assert(team==team_player && damage==14 && sprite_index==scrNTTERefSprite("ElectroPlasmaTether"),
            "Purple Tesla arc lost owner/faction or floor(6*7/3)damage")
    }
    assert(_nodes>0,"Original TeslaCoil emitted no actual lightning nodes")
    var _parts=scrNTTEFullTrenchArc(10816,10560,10880,10560,0,_target,true),
        _trails=scrNTTEFullTrenchLightningDisappear(_parts)
    assert(array_length(_trails)==array_length(_parts),"Lightning disappearance lost source segment count")
    for(var _i=0;_i<array_length(_parts);++_i) assert(!instance_exists(_parts[_i]) && instance_exists(_trails[_i])
        && _trails[_i].object_index==BoltTrail,"Enemy lightning retained damaging collision after disappearance")
    var _big=scr_projectile_create(10912,10560,NTTEFullElectroPlasmaBig,0,6)
    assert(_big.damage==6 && _big.typ==1 && _big.ntte_full_big==1 && _big.mask_index==mskPlasma
        && _big.ntte_full_big_zap==5 && _big.ntte_full_big_friction==20,"Original ElectroPlasma cannon configuration changed")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTESmokeLog("FULL ORIGINAL FISHA TOXIC14CLOUD OWNER TESLA PURPLE14 FRIENDLY TARGET DISAPPEAR CANNON CONFIG OK @"+string(30/timescale))
}

function scrNTTEFullTrenchPickupMultiplierUnitTests() {
    assert(instance_number(Player)==1,"Pickup multiplier test needs one actual fixture player")
    var _p=instance_find(Player,0),_hp=_p.hp,_maxhp=_p.max_hp,_wep=_p.wep,_bwep=_p.bwep,
        _ammo=_p.ammo[Ammo.Bullets],_cap=scrAmmoGetTypeCapacity(Ammo.Bullets),_crown=GameCont.crown,
        _paw=0.4*scr_skill_get(mut_rabbit_paw)
    _p.wep=wep_revolver; _p.bwep=wep_revolver; _p.hp=8; _p.max_hp=8
    GameCont.crown=Crown.None
    _p.ammo[Ammo.Bullets]=_cap
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(0.3+_paw))<0.001,"Original full-ammo two-slot need must be.15+.15")
    _p.hp=2
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(0.6+_paw))<0.001,"Missing health failed original max(.15,.4*.75)per-slot weight")
    _p.hp=8; _p.ammo[Ammo.Bullets]=0
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(1.6+_paw))<0.001,"Original low-ammo multiplier must use.8per-slot")
    _p.ammo[Ammo.Bullets]=_cap*0.2
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(1+_paw))<0.001,"20percent exact ammo boundary changed original strict comparison")
    _p.ammo[Ammo.Bullets]=_cap*0.6
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(1+_paw))<0.001,"60percent exact ammo boundary changed original strict comparison")
    _p.ammo[Ammo.Bullets]=_cap; GameCont.crown=Crown.Risk
    assert(abs(scrNTTEFullPickupChanceMultiplier()-1.5*(0.3+_paw))<0.001,"Healthy Crown of Risk failed1.5multiplier including RabbitPaw")
    _p.hp=2
    assert(abs(scrNTTEFullPickupChanceMultiplier()-0.5*(0.6+_paw))<0.001,"Hurt Crown of Risk failed.5multiplier")
    _p.wep=0; _p.bwep=0; _p.hp=8; GameCont.crown=Crown.None
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(1+_paw))<0.001,"Empty weapon slots changed original.5need each")
    _p.hp=0
    assert(abs(scrNTTEFullPickupChanceMultiplier()-(1.2+_paw))<0.001,"Zero-health original per-slot.6fallback changed")
    _p.hp=_hp; _p.max_hp=_maxhp; _p.wep=_wep; _p.bwep=_bwep; _p.ammo[Ammo.Bullets]=_ammo; GameCont.crown=_crown
    scrNTTESmokeLog("FULL ORIGINAL PICKUP MULTIPLIER HEALTH AMMO20 60BOUNDARIES RABBITPAW RISK EMPTY SLOTS OK @"+string(30/timescale))
}

function scrNTTEFullSewerTransitionsUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_player=instance_find(Player,0)
    var _px=_player.x,_py=_player.y,_area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops
    var _pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    var _target=scrNTTEFullAreaSet("pizza",0,_loops+1)
    assert(GameCont.area==_area && GameCont.subarea==_subarea && GameCont.loops==_loops,
        "Manhole area_set changed the active world before its real Portal transition")
    assert(_target.area==scrNTTEFullAreaId("pizza") && _target.subarea==0 && _target.loops==_loops+1,
        "Manhole pending destination lost original area/subarea/loop")
    assert(scrNTTEFullAreaTakeDestination()==_target && is_undefined(scrNTTEFullAreaTakeDestination()),
        "Portal destination was lost or consumed more than once")
    GameCont.ntte_full_pending_destination=_pending
    var _floor=scrNTTEFullFloorSet(28000,28000,true),_manhole=instance_create(28016,28016,NTTEFullManhole)
    var _palette=scrNTTERefSprite("PizzaManhole")
    assert(array_get_index(_palette,_manhole.sprite_index)>=0 && _manhole.depth==5 && !_manhole.contact,
        "Regular Manhole did not retain original PizzaManhole palette or opening mode")
    var _bubble=instance_create(28016,28016,SteroidsTB)
    _bubble.creator=_manhole; _manhole.x+=4; _manhole.y-=3
    with (_bubble) event_perform(ev_step,ev_step_end)
    assert(_bubble.x==_manhole.x && _bubble.y==_manhole.y && _bubble.sprite_index==sprSteroidsTB,
        "Original SteroidsTB failed real creator-follow or native sprite")
    with (_bubble) event_perform(ev_other,ev_animation_end)
    assert(!instance_exists(_bubble),"Original SteroidsTB did not expire at animation end")
    var _tv=instance_create(28100,28016,TV),_turtle=instance_create(28032,28016,NTTEFullTurtleCool)
    assert(_turtle.hp==15 && _turtle.max_hp==15 && _turtle.team==team_none && _turtle.size==4,
        "Neutral TurtleCool changed original health/faction/size")
    var _gates=0
    with (NTTEFullPortalPrevent) if (creator==_turtle) _gates+=1
    assert(_gates==1,"Neutral TurtleCool must hold the original portal gate")
    with (_turtle) { ntte_full_patience=0; hp=12; scrNTTEFullTurtleCoolStep() }
    assert(instance_exists(_turtle) && _turtle.object_index==Turtle && _turtle.hp==_turtle.max_hp-3,
        "Angered neutral TurtleCool failed actual native Turtle conversion or lost damage")
    var _gates=0
    with (NTTEFullPortalPrevent) if (creator==_turtle) _gates+=1
    assert(_gates==0,"Angered TurtleCool retained the neutral portal blocker")
    var _ground=instance_create(28200,28016,NTTEFullWepPickupGrounded)
    _ground.target=scrWeaponPickupCreate(_ground.x,_ground.y,wep_grenade_launcher,true)
    var _weapon=_ground.target
    with (_ground) scrNTTEFullGroundedWeaponEndStep()
    assert(_weapon.image_alpha==0 && _weapon.speed==0 && _weapon.x==_ground.x && _weapon.y==_ground.y-8,
        "Grounded weapon did not hold a real hidden WepPickup")
    var _tipx=_ground.x+_ground.target_x,_tipy=_ground.y+_ground.target_y
    with (_ground) instance_destroy()
    scrNTTESmokeLog("GROUNDED RELEASE DEBUG "+json_stringify({exists:instance_exists(_weapon),alpha:_weapon.image_alpha,
        x:_weapon.x,y:_weapon.y,tipx:_tipx,tipy:_tipy,holder:instance_exists(_ground)}))
    assert(instance_exists(_weapon) && _weapon.image_alpha==1 && abs(_weapon.x-_tipx)<0.002 && abs(_weapon.y-_tipy)<0.002,
        "Grounded weapon release lost its actual target or transformed tip position")
    var _rubble=instance_create(28300,28016,NTTEFullPizzaRubble)
    assert(_rubble.hp==40 && _rubble.mask_index==scrNTTERefSprite("msk.PizzaRubble") && _rubble.depth==-7,
        "PizzaRubble initial damageable obstacle changed")
    var _saved=scrWeaponPickupCreate(28340,28000,wep_revolver)
    _rubble.ntte_full_saved=[_saved]; _saved.alarm[0]=1
    with (_rubble) scrNTTEFullPizzaRubbleStep()
    assert(_saved.x==_rubble.x && _saved.y==_rubble.y+16 && _saved.alarm[0]>=90,
        "Cave-in rubble failed to retain a real pickup or protect its lifetime")
    var _reveal=scrNTTEFullFloorReveal(28000,28000,28031,28031,10)
    _reveal.time+=3
    assert(instance_exists(_reveal.creator) && _reveal.creator.list[array_length(_reveal.creator.list)-1]==_reveal
        && _reveal.time==13 && _reveal.time_max==10 && _reveal.oy==-8,
        "Floor reveal lost mutable shared record, delay, or original vertical offset")
    var _tunnel=scrNTTEFullFloorTunnel(28400,28000,28464,28000)
    assert(_tunnel.sprite_index==sprBoltTrail && _tunnel.image_xscale==64 && _tunnel.image_yscale==16
        && _tunnel.image_angle==0,"Floor tunnel replaced the real32px-wide PortalClear rectangle")
    var _drain=instance_create(28500,28000,NTTEFullSewerDrain)
    assert(_drain.hp==40 && _drain.mask_index==scrNTTERefSprite("msk.SewerDrain") && _drain.ntte_full_hallway_size==160,
        "SewerDrain changed original40HP/mask/hallway length")
    with (_drain) scrNTTEFullSewerDrainHold()
    assert(_drain.x==round(_drain.xstart/16)*16-16 && _drain.y==round(_drain.ystart/16)*16,
        "SewerDrain lost original grid anchor")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    _player.x=_px; _player.y=_py
    scrNTTESmokeLog("FULL SEWER REAL DESTINATION FISHA FOLLOW TURTLE CONVERSION PORTAL GATE GROUNDED TIP RUBBLE HOLD REVEAL TUNNEL DRAIN CONFIG OK @"+string(30/timescale))
}

function scrNTTEFullTrenchQuasarVariantsUnitTests() {
    var _snapshot=scrNTTEFullInstances(all),_ring=scr_projectile_create(12000,12000,NTTEFullQuasarRing,0,0)
    _ring.ntte_full_ring_timer=-1; _ring.ntte_full_max_distance=1000
    assert(_ring.ntte_full_ring && !_ring.ntte_full_follow && _ring.ntte_full_shrink_delay==120
        && _ring.ntte_full_start==-1 && _ring.ntte_full_stop==-1 && _ring.mask_index==mskExploder,
        "Original Quasar cannon lost ring configuration")
    // Build actual ring vertices within view for independent closure check.
    var _vx=view_xview,_vy=view_yview
    view_xview=11840; view_yview=11840
    with (_ring) scrNTTEFullQuasarBeamLine()
    var _line=_ring.ntte_full_line,_n=array_length(_line)
    assert(_n==34,"Quasar ring must retain16segments plus original closing vertex pair")
    assert(_line[0].x==_line[_n-2].x && _line[0].y==_line[_n-2].y
        && _line[1].xoff==_line[_n-1].xoff,"Quasar ring failed to close its actual triangle strip")
    var _victim=scrNTTEFixTestDummy(12256,12000,team_enemy)
    _victim.hp=100; _ring.team=team_player; _ring.ntte_full_blast=false
    with (_ring) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==88,"Quasar ring normal hit changed12damage")
    _ring.ntte_full_hit_time=3-timescale/2
    with (_ring) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==88,"Quasar ring reopened its hit window before3logical ticks")
    _ring.ntte_full_hit_time=3
    with (_ring) scrNTTEFullQuasarBeamHit(_victim)
    assert(_victim.hp==76,"Quasar ring failed to reopen its original3tick damage window")
    with (_ring) scrNTTEFullQuasarRingEmit()
    assert(array_length(_ring.ntte_full_ring_lasers)==1,"Quasar ring did not emit a real child beam")
    var _child=_ring.ntte_full_ring_lasers[0]
    assert(instance_exists(_child) && !_child.visible && !_child.ntte_full_follow && _child.ntte_full_start==-1
        && _child.image_xscale==0 && _child.image_yscale==0 && _child.ntte_full_shrink_delay<=120,
        "Quasar child did not retain invisible managed draw or original zero-scale emergence")
    var _ultra=scr_projectile_create(12320,12000,NTTEFullUltraQuasarBeam,0,0)
    assert(_ultra.damage==24 && _ultra.ntte_full_ultra && _ultra.ntte_full_turn_factor==1/50
        && _ultra.sprite_index==scrNTTERefSprite("UltraQuasarBeam"),"Ultra quasar lost original24damage or turn factor")
    with (_ring) instance_destroy()
    assert(!instance_exists(_child),"Quasar ring cleanup leaked its invisible child beam")
    view_xview=_vx; view_yview=_vy
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTESmokeLog("FULL QUASAR RING CLOSED34VERTEX STRIP THREE TICK HIT EMIT MANAGED CHILD ULTRA24 CLEANUP OK @"+string(30/timescale))
}

function scrNTTEFullPitlessOriginalReads(_x,_y) {
    var _ox=x,_oy=y
    x=_x;y=_y
    var _x1=floor(bbox_left/16),_y1=floor(bbox_top/16),
        _x2=ceil(((bbox_right-1)+1)/16),_y2=ceil(((bbox_bottom-1)+1)/16)
    x=_ox;y=_oy
    for(var _px=_x1;_px<_x2;++_px) for(var _py=_y1;_py<_y2;++_py)
        if(!scrNTTEFullTrenchPitGet(_px*16,_py*16)) return true
    return false
}
function scrNTTEFullPitlessLocalReadsTests() {
    var _saved=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _grid=ds_grid_create(16,15),_probe=instance_create(50000,50000,NTTEDesertDecor),
        _rate=game_get_speed(gamespeed_fps),_seed=random_get_seed(),_rng=json_stringify(global.rng_state),
        _masks=[mskBandit,mskLaserCrystal,sprPortalClear,mskNone],_scales=[0.5,1,2,-1],
        _coords=[[64,64],[0,0],[-8,17],[255,239],[288,64],[83.75,60.25]],_cases=0
    try {
        global.ntte_full_trench_pit_grid=_grid
        for(var _mode=0;_mode<4;++_mode) {
            ds_grid_clear(_grid,_mode!=0)
            if(_mode==2) {_grid[# 4,4]=false;_grid[# 3,6]=false;_grid[# 8,2]=false;}
            if(_mode==3) global.ntte_full_trench_pit_grid=-1
            for(var _m=0;_m<array_length(_masks);++_m)
            for(var _s=0;_s<array_length(_scales);++_s)
            for(var _angle=0;_angle<2;++_angle)
            for(var _c=0;_c<array_length(_coords);++_c) {
                _probe.mask_index=_masks[_m];_probe.image_xscale=_scales[_s];_probe.image_yscale=abs(_scales[_s])
                _probe.image_angle=_angle*37;_probe.x=_coords[_c][0];_probe.y=_coords[_c][1]
                var _x=_probe.x,_y=_probe.y,_expected=false,_actual=false,_tx=_x+32.125,_ty=_y-16.75
                with(_probe) _expected=scrNTTEFullPitlessOriginalReads(_tx,_ty)
                with(_probe) _actual=scrNTTEFullTrenchPitlessMeeting(_tx,_ty)
                assert(_actual==_expected && _probe.x==_x && _probe.y==_y,
                    "Pitless footprint result/position changed: "+json_stringify([_mode,_m,_s,_angle,_c]))
                _cases++
            }
            global.ntte_full_trench_pit_grid=_grid
        }
        ds_grid_clear(_grid,true)
        _probe.mask_index=sprPortalClear;_probe.image_xscale=2;_probe.image_yscale=2
        _probe.image_angle=0;_probe.x=120;_probe.y=120
        var _iterations=4000,_old=false,_new=false,_start=get_timer()
        for(var _i=0;_i<_iterations;++_i) with(_probe) _old=scrNTTEFullPitlessOriginalReads(x,y)
        var _old_us=get_timer()-_start;_start=get_timer()
        for(var _i=0;_i<_iterations;++_i) with(_probe) _new=scrNTTEFullTrenchPitlessMeeting(x,y)
        var _new_us=get_timer()-_start
        assert(_new==_old && !_new && random_get_seed()==_seed && json_stringify(global.rng_state)==_rng
            && game_get_speed(gamespeed_fps)==_rate,"Pitless local reads changed RNG/rate or missed all-water footprint")
        scrNTTESmokeLog("PITLESS LOCAL READS "+json_stringify({cases:_cases,iterations:_iterations,
            old_mean_cpu_us:_old_us/_iterations,new_mean_cpu_us:_new_us/_iterations,
            actual_rate:_rate,mobile_device_tested:false}))
    }
    finally {
        global.ntte_full_trench_pit_grid=_saved
        if(ds_exists(_grid,ds_type_grid)) ds_grid_destroy(_grid)
        if(instance_exists(_probe)) instance_destroy(_probe,false)
    }
}
