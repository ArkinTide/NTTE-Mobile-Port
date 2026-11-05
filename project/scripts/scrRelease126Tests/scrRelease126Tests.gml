function scrRelease126FusionFire(_stock,_front=wep_revolver) {
    var _p=instance_find(Player,0),_before=scrNTTEFullMergedCaptureBegin(),
        _model=scrNTTEFullWeaponMerge(_stock,_front),_handle=scrNTTEFullWeaponNative(_model);
    _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_handle);
    _p.reload=-1;_p.can_shoot=true;_p.clicked=false;_p.wepangle=1;
    _p.infammo=30;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);
    _p.gunangle=0;_p.accuracy=0;_p.x=280000;_p.y=280000;
    _p.xprevious=_p.x;_p.yprevious=_p.y;_p.hspeed=0;_p.vspeed=0;
    _p.race=Race.Fish;_p.ntte_race_ultra=0;_p.ntte_native_race=-1;
    KeyCont.press_fire[_p.index]=true;KeyCont.hold_fire[_p.index]=true;
    with(_p) scrPlayerFiring();
    KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false;
    return scrNTTEFullMergedCaptureEnd(_before);
}
function scrRelease126FusionTests() {
    assert(variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        "Ordinary startup did not enable fusion's native collision adapter");
    var _s=scrRelease122FixtureBegin(),_frame=current_frame,
        _provider=scrNTTEFullValue(global,"ntte_full_projectile_merge_effect",undefined),
        _reg=scrNTTEFullValue(global,"ntte_full_merge_effect_registry",undefined),
        _initialized=scrNTTEFullValue(global,"ntte_full_merge_effect_initialized",false),
        _list=global.lis_walls_visible,_walls=ds_list_create();
    global.lis_walls_visible=_walls;
    try {
        global.ntte_full_projectile_merge_effect=undefined;
        global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false;
        GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[];
        GameCont.rad=1000;GameCont.underwater=false;current_frame+=10;
        var _shots=scrRelease126FusionFire(wep_ultra_crossbow),_bullets=scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1);
        assert(array_length(_bullets)>0,"Real PlayerFiring did not emit Ultra Crossbow fusion");
        var _p=_bullets[0];
        assert(_p.temerge_wall_piercing_count>0,"Ultra Crossbow fusion lost wall-breaking budget");
        _p.x=281008;_p.y=281008;_p.speed=8*timescale;_p.direction=0;
        var _wall=instance_create(281008,281000,Wall);
        with(_wall) with(_p) event_perform(ev_collision,Wall);
        assert(!instance_exists(_wall) && instance_exists(_p) && instance_exists(FloorExplo),
            "Real native fusion collision did not break wall and retain shot");
        scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        _shots=scrRelease126FusionFire(wep_bouncer_smg);_bullets=scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1);
        assert(array_length(_bullets)>0,"Real PlayerFiring did not emit Bouncer SMG fusion");
        _p=_bullets[0];_p.x=282000;_p.y=282008;_p.speed=6*timescale;_p.direction=0;_p.image_angle=0;
        _wall=instance_create(282004,282000,Wall);
        with(_wall) with(_p) event_perform(ev_collision,Wall);
        assert(instance_exists(_p) && _p.hspeed<0 && instance_exists(_wall),
            "Real native Bouncer stock callback did not reflect replacement shot");
        scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        // The reported exception occurred through this actual Player entry,
        // before any other fusion had registered the effect provider.
        global.ntte_full_projectile_merge_effect=undefined;
        global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false;
        _shots=scrRelease126FusionFire(wep_ntte_hyper_bubbler);
        _bullets=scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1);
        assert(array_length(_bullets)>0 && scrNTTEFullMergedProjectileHasEffect(_bullets[0],"hyper")
            && scrNTTEFullMergedProjectileHasEffect(_bullets[0],"explosion"),"Cold Hyper Bubble fusion lost real effects");
        scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        // Fire every distinct inherited effect family through PlayerFiring.
        // Stateful and delayed custom weapons also have dedicated suites.
        var _cases=[
            [wep_crossbow,"piercing"],[wep_toxic_bow,"toxic"],[wep_seeker_pistol,"seeking"],
            [wep_flame_shotgun,"flame"],[wep_flare_gun,"flame_trail"],[wep_hyper_slugger,"hyper"],
            [wep_slugger,"slug"],[wep_grenade_launcher,"grenade"],[wep_sticky_launcher,"sticky"],
            [wep_ultra_grenade_launcher,"pulling"],[wep_bazooka,"rocket"],[wep_nuke_launcher,"guiding"],
            [wep_laser_pistol,"laser"],[wep_lightning_cannon,"lightning_trail"],
            [wep_plasma_gun,"plasma"],[wep_devastator,"plasma_trail"],
            [wep_ntte_bubble_cannon,"explosion"],[wep_ntte_quasar_cannon,"wall_piercing"]];
        for(var _i=0;_i<array_length(_cases);++_i) {
            _shots=scrRelease126FusionFire(_cases[_i][0]);_bullets=scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1);
            assert(array_length(_bullets)>0 && scrNTTEFullMergedProjectileHasEffect(_bullets[0],_cases[_i][1]),
                "Real firing lost inherited effect "+string(_cases[_i]));
            scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        }
        // Gun Gun's native physical pickup used to fall outside projectile
        // capture entirely, despite having a source ThrownWep callback.
        _shots=scrRelease126FusionFire(wep_gun_gun);var _drops=scrNTTEFullMergedRuntimeTestShots(_shots,WepPickup);
        assert(array_length(_drops)==1 && scrNTTEFullWeaponHasMerge(_drops[0].wep)==true
            && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_drops[0].wep))==wep_revolver
            && array_length(scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1))>0,"Gun Gun stock lost retained fused weapon or front shot");
        scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        _shots=scrRelease126FusionFire(wep_hyper_slugger,wep_gun_gun);_drops=scrNTTEFullMergedRuntimeTestShots(_shots,WepPickup);
        assert(array_length(_drops)>0 && scrNTTEFullMergedProjectileHasEffect(_drops[0],"hyper"),"Gun Gun front lost inherited effect on native physical weapon");
        scrNTTEFullCavesFixtureCleanup(_s.baseline);current_frame+=100;
        _shots=scrRelease126FusionFire(wep_sticky_launcher);_bullets=scrNTTEFullMergedRuntimeTestShots(_shots,Bullet1);
        _p=_bullets[0];_p.speed=0;
        var _target=instance_create(_p.x,_p.y,Bandit);_target.hp=1000;_target.nexthurt=0;_target.team=team_enemy;
        with(_target) with(_p) event_perform(ev_collision,hitme);
        assert(instance_exists(_p) && _p.temerge_sticky_target==_target,"Actual native sticky collision failed to attach");
        _target.x+=40;var _oldx=_p.x;
        with(GameCont) event_perform(ev_step,ev_step_end);
        assert(_p.x>_oldx && _p.mask_index==mskNone,"Production EndStep did not follow sticky target");
        instance_destroy(_target,false);with(GameCont) event_perform(ev_step,ev_step_end);
        assert(_p.temerge_sticky_target==noone && _p.mask_index!=mskNone,"Sticky native release did not restore collision");
        scrNTTESmokeLog("PASS R126 FUSION actual PlayerFiring: 18 inherited effect families, cold HyperBubble, Ultra wall destruction, Bouncer reflection and native sticky follow/release @"+string(30/timescale));
    } finally {
        global.ntte_full_projectile_merge_effect=_provider;global.ntte_full_merge_effect_registry=_reg;
        global.ntte_full_merge_effect_initialized=_initialized;current_frame=_frame;
        global.lis_walls_visible=_list;ds_list_destroy(_walls);scrRelease122FixtureEnd(_s);
    }
}
function scrRelease126VineTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
    try {
        GameCont.area=area_scrapyards;GameCont.subarea=3;
        var _vine=scrUGCreate(283000,283000,"FireFlower"),_prompt=_vine.prompt,
            _enemy=instance_create(283100,283000,Bandit);
        // Exercise the native chest constructor's effects in the same level.
        instance_create(283200,283000,ChestOpen);instance_create(283200,283000,FXChestOpen);
        repeat(ceil(90/timescale)) with(_vine) event_perform(ev_step,ev_step_normal);
        assert(instance_exists(_vine) && _vine.hp==30000 && !scrUGFlowerUsable(),
            "Opening a chest removed or unlocked the live 3-3 entrance");
        instance_destroy(_enemy,false);
        assert(scrUGFlowerUsable(),"Cleared 3-3 entrance did not become usable");
        repeat(ceil(90/timescale)) with(_vine) event_perform(ev_step,ev_step_normal);
        assert(instance_exists(_vine) && _vine.prompt==_prompt,"Cleared entrance spontaneously withered after chest open");
        _prompt.pick=_p.index;with(_vine) event_perform(ev_step,ev_step_normal);
        var _destination=scrNTTEFullAreaTakeDestination();
        assert(!instance_exists(_vine) && instance_exists(Portal) && _destination.area==207,
            "Persistent entrance lost its genuine interaction/destination");
        scrNTTESmokeLog("PASS R126 VINE native Step survives open chest before/after clear, HP/lock/prompt and real interaction preserved @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease126WallsTests() {
    var _s=scrRelease122FixtureBegin(),_list=global.lis_walls_visible,_walls=ds_list_create();
    global.lis_walls_visible=_walls;
    try {
        GameCont.area=206;GameCont.subarea=2;
        for(var _xx=0;_xx<3;++_xx) for(var _yy=0;_yy<3;++_yy) instance_create(284000+_xx*32,284000+_yy*32,Floor);
        with(Floor) {mcr_floor_make_walls;mcr_floor_create_tops;}
        var _seed=random_get_seed(),_edge=instance_number(Wall),_tops=instance_number(TopSmall),_start=get_timer();
        scrNTTESolidWallGenerate();
        var _elapsed=get_timer()-_start,_fill=instance_number(NTTESolidWall);
        assert(random_get_seed()==_seed && _fill>0 && _fill<300,"Exterior fill lost packing or changed gameplay RNG");
        assert(instance_number(Wall)-_fill==_edge && instance_number(TopSmall)==_tops,"Fill replaced authored edges/transitions");
        with(NTTESolidWall) {
            assert(solid && mask_index==mskWall && !visible && topspr==-1,"Exterior acquired decoration or lost physical collision");
            assert(collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Floor,false,false)==noone,
                "Packed exterior overlaps a real floor/path");
        }
        for(var _x=283904;_x<284192;_x+=16) for(var _y=283904;_y<284192;_y+=16) {
            if(!position_meeting(_x+8,_y+8,Floor)) assert(position_meeting(_x+8,_y+8,Wall),"Visible exterior still contains a false wall gap");
        }
        var _block=instance_position(283912,283912,NTTESolidWall),_cx=_block.x,_cy=_block.y;
        instance_create(_cx,_cy,FloorExplo);
        assert(!position_meeting(_cx+8,_cy+8,Wall) && position_meeting(_cx+8,_cy+8,Floor),"Blast failed to carve packed exterior precisely");
        assert(position_meeting(_cx+40,_cy+8,Wall),"One blast removed the entire packed block");
        scrNTTEFullFloorSetAlign(32,32,0,0);
        var _floor=scrNTTEFullFloorSet(283904,284064,true);
        assert(instance_exists(_floor),"Scripted room could not carve compact collision");
        with(_floor) assert(collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall,false,false)==noone,
            "Scripted terrain carve retained phantom collision");
        scrNTTESmokeLog("R126 WALL packing blocks="+string(_fill)+" generation_us="+string(_elapsed));
        // Terrain families share collision, while retaining their own edge,
        // transition and background colors. Marine/abyss gaps remain open.
        scrNTTEFullCavesFixtureCleanup(_s.baseline);
        var _areas=[1,2,3,4,5,6,7,100,101,102,103,104,105,106,107,203,206,207,201,202,204,205];
        for(var _a=0;_a<array_length(_areas);++_a) {
            GameCont.area=_areas[_a];GameCont.subarea=1;
            for(var _i=0;_i<3;++_i) instance_create(284000+32*_i,284000,Floor);
            with(Floor) {mcr_floor_make_walls;mcr_floor_create_tops;}
            var _edges=instance_number(Wall),_trans=instance_number(TopSmall);
            scrNTTESolidWallGenerate();var _n=instance_number(NTTESolidWall),_open=array_contains([201,202,204,205],GameCont.area);
            assert((_open?_n==0:_n>0) && instance_number(Wall)-_n==_edges && instance_number(TopSmall)==_trans,
                "Solid exterior lost biome edge/transition or sealed open marine terrain: "+string(GameCont.area));
            with(NTTESolidWall) assert(area==GameCont.area && collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Floor,false,false)==noone,
                "Biome collision fill overlapped traversable terrain");
            scrNTTEFullCavesFixtureCleanup(_s.baseline);
        }
        GameCont.area=206;
        instance_create(100000,100000,Floor);instance_create(300000,300000,Floor);
        var _start=get_timer();scrNTTESolidWallGenerate();
        assert(instance_number(NTTESolidWall)<600 && get_timer()-_start<2000000,
            "Distant authored rooms caused unbounded rectangular exterior work");
        scrNTTESmokeLog("PASS R126 WALL packed static collision, unchanged edge/transition/RNG, real floor exclusion, blast and scripted room carving @"+string(30/timescale));
    } finally {global.lis_walls_visible=_list;ds_list_destroy(_walls);scrRelease122FixtureEnd(_s);}
}
function scrRelease126RedPassageTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0),_lock=lockstep_stop;
    lockstep_stop=false;
    try {
        GameCont.area=206;GameCont.subarea=1;
        for(var _i=0;_i<4;++_i) instance_create(285000+32*_i,285000,Floor);
        var _wall=instance_create(285032,285000,NTTEFullWallFake),_helper=instance_find(NTTEFullWallFakeHelper,0);
        _p.x=285040;_p.y=285008;_p.hspeed=timescale;_p.vspeed=0;
        var _x=_p.x,_y=_p.y;
        with(_wall) with(_p) event_perform(ev_collision,Wall);
        assert(instance_exists(_wall) && _p.x==_x && _p.y==_y,"Native Player collision ejects player or destroys red disguise");
        scrNTTESolidWallGenerate();
        with(NTTEFullWallFakeController) scrNTTEFullWallFakeEndStep();
        assert(_p.red_wall_fake>0 && !_helper.solid && _wall.mask_index==mskNone,
            "Original hidden-path reveal circle/helper semantics were lost");
        assert(!position_meeting(_p.x,_p.y,NTTESolidWall),"Solid exterior sealed original hidden room corridor");
        _p.x=285104;_p.y=285008;
        repeat(ceil(12/timescale)) with(NTTEFullWallFakeController) scrNTTEFullWallFakeEndStep();
        assert(_p.red_wall_fake==0 && _helper.solid,"Red reveal failed to close after leaving the disguise");
        scrNTTESmokeLog("PASS R126 RED real Player collision preserves hidden passage, static-fill exclusion and source gradual reveal/close @"+string(30/timescale));
    } finally {lockstep_stop=_lock;scrRelease122FixtureEnd(_s);}
}

