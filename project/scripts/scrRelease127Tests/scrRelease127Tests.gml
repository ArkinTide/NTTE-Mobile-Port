// Run delayed excavation after exterior collision has actually been generated.
// Earlier chamber tests only exercised the empty, unfilled exterior.
function scrRelease127ChamberTests() {
    var _types=["Freak","Explo","Rhino","Vat","Popo"];
    for(var _case=0;_case<array_length(_types);++_case) {
        var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
        try {
            random_set_seed(127301+_case);GameCont.area=_case==4?area_hq:area_labs;GameCont.loops=0;
            instance_create(295500,295500,Wall);
            scrNTTEFullFloorSetAlign(32,32);
            scrNTTEFullFloorFill(296016,296016,5,5);
            scrNTTEFullFloorResetAlign();_p.x=296016;_p.y=296016;
            scrNTTESolidWallGenerate();
            assert(instance_number(NTTESolidWall)>0,"Chamber regression omitted packed exterior collision");
            var _c=instance_create(296016,296224,NTTEFullFreakChamber),_result=false;
            _c.type=_types[_case];_c.open=true;
            with(_c) {scrNTTEFullFreakChamberSetup();_result=scrNTTEFullFreakChamberOpen();}
            assert(is_struct(_result),"Packed exterior prevented delayed "+_types[_case]+" chamber excavation");
            assert(!instance_exists(_c) && array_length(_result.occupants)>0,"Chamber failed to dispose itself/spawn real occupants");
            for(var _i=0;_i<array_length(_result.walls);++_i)
                assert(_result.walls[_i].object_index!=NTTESolidWall,"Packed exterior became a moving chamber door");
            repeat(ceil(100/timescale)) {
                var _slides=scrNTTEFullInstances(NTTEFullWallSlide);
                for(var _i=0;_i<array_length(_slides);++_i) if(instance_exists(_slides[_i]))
                    with(_slides[_i]) event_perform(ev_step,ev_step_end);
            }
            var _floors=array_concat(_result.floors,_result.hall);
            for(var _i=0;_i<array_length(_floors);++_i) {
                var _f=_floors[_i];
                // HQ FloorMiddle deliberately replaces some source floors.
                if(!instance_exists(_f)) continue;
                assert(!collision_rectangle(_f.bbox_left+2,_f.bbox_top+2,_f.bbox_right-3,_f.bbox_bottom-3,NTTESolidWall,false,false),
                    "Excavated chamber retained invisible packed collision on walkable floor");
            }
            assert(!position_meeting(_result.center_x,_result.center_y,NTTESolidWall)
                && !position_meeting(_result.hall_x,_result.hall_y,NTTESolidWall),"Replaced HQ floors retained exterior collision");
            for(var _i=0;_i<array_length(_result.occupants);++_i) with(_result.occupants[_i])
                assert(!place_meeting(x,y,Wall),"Delayed chamber spawned an inaccessible enemy inside collision");
            // Actual enemy Destroy -> native guarded Corpse.Alarm0, without
            // bypassing remaining-hostile checks or forcing a portal.
            with(enemy) {hp=0;instance_destroy();}
            assert(!scr_check_enemies(),"Defeated chamber occupants remained in completion count");
            with(GameCont) {ntte_ally_portal_timer=0;scrNTTEAllyPortalStep();}
            with(Corpse) if(alarm[0]>=0) event_perform(ev_alarm,0);
            assert(instance_exists(Portal),"Cleared delayed chamber did not release the native level exit");
            scrNTTESmokeLog("PASS R127 CHAMBER "+_types[_case]+" real packed exterior/room/doors/occupants @"+string(30/timescale));
        } finally {scrNTTEFullFloorResetAlign();scrNTTEFullFloorResetStyle();scrRelease122FixtureEnd(_s);}
    }
}
function scrRelease127WallInteractionTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
    try {
        GameCont.area=area_labs;_p.x=300016;_p.y=300016;
        instance_create(300000,300000,Floor);
        var _x=300128,_y=300128,_block=scrNTTESolidWallBlock(_x,_y,256,192);
        assert(position_meeting(_x+80,_y+80,Wall) && !scrNTTESolidWallPlanPoint(_x+80,_y+80),
            "Layout probe lost distinction between authored wall and gameplay collision");
        var _fill_count=instance_number(NTTESolidWall),_seed=random_get_seed(),
            _contact=scrNTTESolidWallContact(_block,_x+83,_y+91);
        assert(_contact[0]==_x+88 && _contact[1]==_y+88 && instance_number(NTTESolidWall)==_fill_count
            && random_get_seed()==_seed,"Reading a packed wall impact point changed geometry/RNG or returned its remote centre");
        var _art=instance_create(_x+80,_y+80,Wall);
        assert(scrNTTESolidWallPlanPoint(_x+88,_y+88)
            && array_get_index(scrNTTESolidWallPlanRect(_x+80,_y+80,_x+95,_y+95),_art)>=0,
            "Layout probe ignored a real authored boundary overlapping fill");
        instance_destroy(_art,false);
        var _path=scrNTTEFullPathCreate(_x+8,_y-24,_x+232,_y+216,[Wall,InvisiWall]);
        assert(array_length(_path)>0,"Path could not route around a packed rectangle");
        for(var _i=0;_i<array_length(_path);++_i) {
            assert(!position_meeting(_path[_i][0],_path[_i][1],Wall),"Path grid marked only a packed wall origin");
            if(_i) assert(!collision_line(_path[_i-1][0],_path[_i-1][1],_path[_i][0],_path[_i][1],Wall,false,false),
                "Path crossed solid background between unblocked endpoints");
        }
        instance_destroy(_block,false);
        _block=scrNTTESolidWallBlock(_x,_y,256,192);_art=instance_create(_x+80,_y+80,Wall);
        scrWallDestroy(_art);
        assert(!position_meeting(_x+88,_y+88,Wall) && position_meeting(_x+8,_y+8,Wall)
            && position_meeting(_x+248,_y+184,Wall),"Destroying overlapping authored wall erased a whole packed block");
        var _objects=[NTTEFullCrystalHeartBullet,NTTEFullElectroPlasma,NTTEFullVenomFlak,NTTEFullTesseractArmDeath];
        for(var _case=0;_case<array_length(_objects);++_case) {
            var _bx=301120+_case*512,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
                _bullet=instance_create(_bx+104,_by+88,_objects[_case]);
            _bullet.image_xscale=2;_bullet.image_yscale=2;
            switch(_case) {
                case 0: with(_bullet) scrNTTEFullCrystalHeartBulletWall(_wall);break;
                case 1: _bullet.ntte_full_big=true;with(_bullet) scrNTTEFullElectroPlasmaWall(_wall);break;
                case 2: _bullet.charging=true;with(_bullet) scrNTTEFullVenomFlakWall(_wall);break;
                case 3: with(_bullet) scrNTTEFullTesseractArmDeathWall(_wall);break;
            }
            assert(!position_meeting(_bx+104,_by+88,Wall)
                && position_meeting(_bx+8,_by+8,Wall) && position_meeting(_bx+248,_by+184,Wall),
                "Projectile wall callback destroyed a packed origin/whole block instead of the contact tile: "+object_get_name(_objects[_case]));
            if(instance_exists(_bullet)) instance_destroy(_bullet,false);
        }
        var _bx=303680,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _ring=instance_create(_bx+96,_by+80,Bullet1);
        _ring.mask_index=mskWall;_ring.image_xscale=2;_ring.image_yscale=2;
        with(_ring) scrNTTELightRingClearWalls();
        assert(!position_meeting(_bx+104,_by+88,Wall) && !position_meeting(_bx+120,_by+104,Wall)
            && position_meeting(_bx+8,_by+8,Wall) && position_meeting(_bx+248,_by+184,Wall),
            "Area wall-break lost contacted tiles or neighbouring packed collision");
        instance_destroy(_ring,false);
        // The shared native path used by PortalClear and explosions receives
        // one packed collision; it must still clear the entire original mask.
        var _bx=306240,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _clear=instance_create(_bx+96,_by+80,PortalClear);
        _clear.sprite_index=mskWall;_clear.mask_index=mskWall;_clear.image_xscale=6;_clear.image_yscale=2;
        with(_clear) scrWallDestroy(_wall);
        for(var _dx=96;_dx<192;_dx+=16) for(var _dy=80;_dy<112;_dy+=16)
            assert(!position_meeting(_bx+_dx+8,_by+_dy+8,Wall),"Wide PortalClear left packed collision inside its tunnel");
        assert(position_meeting(_bx+8,_by+8,Wall) && position_meeting(_bx+248,_by+184,Wall),
            "Wide PortalClear erased collision beyond its real mask");
        instance_destroy(_clear,false);
        // Buried layouts must remain hidden until actual authored excavation
        // touches them; background fill alone is not an opening event.
        var _bx=304192,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _vault=instance_create(_bx+80,_by+64,NTTEFullBuriedVault),_vx=_bx+96,_vy=_by+80;
        _vault.layout=[{x:_vx,y:_vy,obj:Floor}];_vault.floor_num=-1;_vault.floor_min=-1;
        with(_vault) scrNTTEFullBuriedVaultStep();
        assert(instance_exists(_vault),"Buried room opened automatically on packed background fill");
        instance_create(_vx-16,_vy,Wall);_vault.floor_num=-1;
        with(_vault) scrNTTEFullBuriedVaultStep();
        assert(!instance_exists(_vault) && position_meeting(_vx+16,_vy+16,Floor)
            && !position_meeting(_vx+16,_vy+16,NTTESolidWall)
            && position_meeting(_bx+248,_by+184,Wall),"Real buried-room excavation failed or erased distant exterior");
        // Deferred crate reordering must never copy/move background blocks.
        var _bx=304704,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _crate=instance_create(_bx+96,_by+80,NTTEFullWallCrate),_fill=instance_number(NTTESolidWall);
        with(_crate) {scrNTTEFullWallCrateStep();scrNTTEFullWallCrateStep();}
        assert(instance_number(NTTESolidWall)==_fill && !position_meeting(_crate.x,_crate.y,NTTESolidWall)
            && position_meeting(_bx+248,_by+184,NTTESolidWall),"Wall crate cloned fill or retained unbreakable fill under its loot");
        // An existing drain relocates only actual 16px transition pieces.
        var _bx=305216,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _drain=instance_create(_bx+96,_by+80,NTTEFullSewerDrain);
        _drain.ntte_full_my_floor=instance_find(Floor,0);
        with(_drain) scrNTTEFullSewerDrainStep();
        with(_drain) assert(!place_meeting(x,y,Wall),"Sewer drain remained blocked after exposing transition tiles");
        assert(position_meeting(_bx+248,_by+184,NTTESolidWall),"Sewer drain moved an entire packed exterior block");
        var _bx=305728,_by=301120,_wall=scrNTTESolidWallBlock(_bx,_by,256,192),
            _border=instance_create(_bx,_by+64,NTTEFullLairBorder);
        _border.area=area_sewers;
        scrNTTEFullLairBorderSetupInstance(_wall);
        var _top=collision_point(_bx+8,_by+8,NTTESolidWall,false,false),
            _bottom=collision_point(_bx+8,_by+184,NTTESolidWall,false,false);
        assert(instance_exists(_top) && instance_exists(_bottom) && _top!=_bottom
            && _top.area==area_labs && _bottom.area==area_sewers && _top.topspr==-1 && _bottom.topspr==-1,
            "Mixed-area border lost biome colour/collision or gave packed fill decorative wall art");
        scrNTTESmokeLog("PASS R127 WALL INTERACTIONS authored-vs-fill planning, full-rectangle path grid,4native projectile breaks,area/wide-mask break,buried reveal,crate reorder,sewer drain,mixed-biome border @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease127AlarmTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        var _objects=[Bandit,EnemyBullet3,Debris,NTTEFullWallFake],_targets=[];
        for(var _i=0;_i<array_length(_objects);++_i) {
            var _v=instance_create(286000+128*_i,286000,_objects[_i]);
            for(var _j=0;_j<12;++_j) _v.alarm[_j]=_j mod 4==0?-1:(_j mod 4==1?0:(_j mod 4==2?1:19));
            array_push(_targets,_v);
        }
        var _block=scrNTTESolidWallBlock(286000,286400,256,256);
        scrNTTEFullAlarmTopUp(1);
        for(var _i=0;_i<array_length(_targets);++_i) {
            for(var _j=0;_j<12;++_j) {
                var _old=_j mod 4==0?-1:(_j mod 4==1?0:(_j mod 4==2?1:19));
                assert(_targets[_i].alarm[_j]==_old+(_old>0?1:0),
                    "Terrain optimization changed an active/inherited/unused enemy timer");
            }
        }
        for(var _j=0;_j<12;++_j) assert(_block.alarm[_j]==-1,"Static fill acquired an alarm");
        scrNTTESmokeLog("PASS R127 ALARM same integer compensation for enemies, projectiles, particles and terrain children @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease127PackingTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        var _x=287000,_y=287000,_w=256,_h=192,
            _block=scrNTTESolidWallBlock(_x,_y,_w,_h),_seed=random_get_seed();
        _block.area=206;_block.image_blend=make_color_rgb(91,173,211);_block.image_alpha=0.625;
        var _cells=scrNTTESolidWallSplit(_block,_x+67,_y+83,_x+70,_y+86);
        assert(array_length(_cells)==1 && instance_number(NTTESolidWall)==5,
            "One impact expanded an entire large block into tile objects");
        assert(_cells[0].ntte_fill_width==16 && _cells[0].ntte_fill_height==16 && random_get_seed()==_seed,
            "Local materialization lost tile precision or changed gameplay RNG");
        with(NTTESolidWall) assert(area==206 && image_blend==make_color_rgb(91,173,211) && image_alpha==0.625,
            "Local materialization lost biome/tint/alpha on a remainder");
        instance_destroy(_cells[0],false);
        for(var _dx=0;_dx<_w;_dx+=16) for(var _dy=0;_dy<_h;_dy+=16) {
            var _hit=position_meeting(_x+_dx+8,_y+_dy+8,Wall);
            assert(_hit!=(_dx==64 && _dy==80),"Local impact lost other collision cells or retained the broken cell");
        }
        // Carving near a remainder boundary retains real neighbouring walls.
        scrNTTESolidWallCarve(_x+160,_y+32,32,32);
        assert(!position_meeting(_x+168,_y+40,Wall) && !position_meeting(_x+184,_y+56,Wall)
            && position_meeting(_x+152,_y+40,Wall) && position_meeting(_x+200,_y+40,Wall),
            "Scripted carve failed across a locally packed remainder");
        scrNTTESmokeLog("PASS R127 PACK large-block local hit, unchanged neighbouring collision/RNG/area/tint/alpha and scripted carve @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease127RenderTests() {
    var _s=scrRelease122FixtureBegin(),_old_walls=global.lis_walls_visible,_old_floors=global.lis_floors_visible,
        _old_fill=scrNTTEFullValue(UberCont,"ntte_fill_visible",undefined),
        _walls=ds_list_create(),_floors=ds_list_create(),_actual=-1,_reference=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog();
    global.lis_walls_visible=_walls;global.lis_floors_visible=_floors;
    try {
        GameCont.area=206;
        var _x=288000,_y=288000,_floor=instance_create(_x,_y,Floor),_edge=instance_create(_x+32,_y,Wall),
            _near=scrNTTESolidWallBlock(_x+64,_y,256,128),_far=scrNTTESolidWallBlock(_x+3000,_y,256,128);
        scrNTTEWallVisibilityBuild(_x-32,_y-32,_x+160,_y+160,true);
        assert(ds_list_find_index(_walls,_edge)>=0 && ds_list_find_index(_floors,_floor)>=0
            && ds_list_find_index(_walls,_near)<0 && array_get_index(UberCont.ntte_fill_visible,_near)>=0
            && array_get_index(UberCont.ntte_fill_visible,_far)<0,
            "Visibility omitted real edge/floor or sent static fill into sprite/shadow passes");
        _actual=surface_create(192,192);_reference=surface_create(192,192);
        _camera=camera_create_view(_x-32,_y-32,192,192,0,noone,-1,-1,-1,-1);
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal);
        var _areas=[1,2,4,5,7,206,207];
        for(var _a=0;_a<array_length(_areas);++_a) for(var _t=0;_t<2;++_t) {
            _near.area=_areas[_a];_near.image_blend=_t?make_color_rgb(99,171,213):c_white;_near.image_alpha=_t?0.625:1;
            surface_set_target(_actual);camera_apply(_camera);draw_clear_alpha(c_black,0);
            draw_set_color(c_lime);draw_set_alpha(0.7);
            var _expected_color=draw_get_color(),_expected_alpha=draw_get_alpha();
            scrNTTESolidWallDraw();
            assert(draw_get_color()==_expected_color && draw_get_alpha()==_expected_alpha,"Cached fill draw leaked caller color/alpha");
            surface_reset_target();
            assert(((surface_getpixel_ext(_actual,120,48)>>24)&255)>0,
                "Wall pixel oracle did not draw any opaque fill inside the camera");
            surface_set_target(_reference);camera_apply(_camera);draw_clear_alpha(c_black,0);
            // Independent 1.2.6 renderer oracle, including multiplicative tint.
            with(_near) {
                var _base=scrAreaGetBackroundColor(area,false);
                draw_set_color(make_color_rgb(color_get_red(_base)*color_get_red(image_blend)/255,
                    color_get_green(_base)*color_get_green(image_blend)/255,color_get_blue(_base)*color_get_blue(image_blend)/255));
                draw_set_alpha(image_alpha);draw_rectangle(x,y-8,x+ntte_fill_width,y+ntte_fill_height-8,false);
            }
            surface_reset_target();
            for(var _px=0;_px<192;_px+=8) for(var _py=0;_py<192;_py+=8)
                assert(surface_getpixel_ext(_actual,_px,_py)==surface_getpixel_ext(_reference,_px,_py),
                    "Cached wall fill changed pixels after live biome/tint/alpha changes");
        }
        scrNTTEWallVisibilityBuild(_x-32,_y-32,_x+160,_y+160,false);
        assert(array_get_index(UberCont.ntte_fill_visible,_far)>=0,"Cinematic full-world visibility lost distant fill");
        instance_destroy(_near,false);
        surface_set_target(_actual);camera_apply(_camera);scrNTTESolidWallDraw();surface_reset_target();
        scrNTTESmokeLog("PASS R127 RENDER real culled edge/floor/fill lists, pixel oracle7 biomes x2 tint/alpha, live colour changes, destroyed references and cinematic @"+string(30/timescale));
    } finally {
        if(surface_get_target()==_actual || surface_get_target()==_reference) surface_reset_target();
        if(surface_exists(_actual)) surface_free(_actual);if(surface_exists(_reference)) surface_free(_reference);
        if(_camera>=0) camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog);gpu_set_blendmode(bm_normal);
        global.lis_walls_visible=_old_walls;global.lis_floors_visible=_old_floors;UberCont.ntte_fill_visible=_old_fill;
        ds_list_destroy(_walls);ds_list_destroy(_floors);scrRelease122FixtureEnd(_s);
    }
}

// Explicit silent desktop diagnostic only. Measure real engine frames and
// collision processing, rather than timing only the one-off wall generator.
function scrRelease127LabNaturalTests() {
    scrRelease123NaturalTests();
    with(Release123NaturalTest) {
        r127_labs=true;rates=[30,60,30,60,30,60];
        rows=[];chambers_seen=0;remaining_stable=0;
    }
}
function scrRelease127LabNaturalBody() {
    elapsed+=timescale;
    assert(elapsed<1500,"Laboratory native clear timed out, phase="+string(phase)
        +" enemies="+string(instance_number(enemy))+" pending="+string(instance_number(becomenemy))
        +" chambers="+string(instance_number(NTTEFullFreakChamber)));
    if(phase>0) scrNTTEFullCoastVaultRate();
    if(instance_exists(player)) {
        player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000;
        player.can_walk=false;player.can_aim=false;player.speed=0;
        // Avoid entering a clear portal during the verification hold.
        with(Portal) if(point_distance(x,y,other.player.x,other.player.y)<96) {
            var _f=instance_furthest(x,y,Floor);
            if(instance_exists(_f)) {other.player.x=_f.x+16;other.player.y=_f.y+16;}
        }
    }
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i]);
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false);
        }
        smoke_drivers=[];scrNTTEFullCoastVaultClear();
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false);
        save_set_value("options","gamepad",false);save_set_value("options","keyboard",true);
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false);save_set_value("game","tutorial",false);
        game_set_speed(rates[pass_index],gamespeed_fps);scrOptionsUpdate();scrRelease123Await(10);return;
    }
    if(phase==10) {
        UberCont.paused=false;UberCont.want_pause=false;UberCont.want_quit_to_menu=false;
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false;
        UberCont.continued_run=false;UberCont.show_leaderboards_menu=false;
        var _seed=[6123,7251,8197][pass_index div 2];
        global.is_server=true;global.index=0;global.custom_seed=_seed;global.recontinued_times=0;global.crownpick=crwn_none;
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0;
        game_directory=scratch_root+string(pass_index)+"/";directory_create(game_directory);
        for(var _i=0;_i<4;++_i) array_push(scratch_files,game_directory
            +["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"][_i]);
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={};
        if(file_exists(savegame_file)) file_delete(savegame_file);
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0);player=instance_find(Player,0);
        GameCont.area=area_labs;GameCont.subarea=1;GameCont.loops=[0,1,3][pass_index div 2];GameCont.hard=14+GameCont.loops*20;
        GameCont.proto=false;GameCont.crown=crwn_none;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.rad=-100000;
        GameCont.maxsubarea=2;GameCont.finalsubarea=false;GameCont.can_advance_stage=true;
        GameCont.levseed=_seed;GameCont.ntte_full_pending_destination=undefined;
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed);GameCont.ntte_full_source_pending_generation=undefined;
        global.rng_state[@RNGStates.Generation]=_seed;global.ntte_full_sync_generation=false;
        instance_create(0,0,GenCont);scrRelease123Await(1);return;
    }
    if(phase==1) {
        if(!scrNTTEFullCoastVaultReady() || instance_exists(LevCont)) return;
        assert(instance_number(NTTESolidWall)>0,"Laboratory natural test omitted generated exterior collision");
        chambers_seen=instance_number(NTTEFullFreakChamber);remaining_stable=0;
        // Real scheduled native Collision_Wall/Alarm, without manually invoking
        // the callback or materializing the block before engine collision.
        portal_probe_x=player.x+4096;portal_probe_y=player.y+4096;
        scrNTTESolidWallBlock(portal_probe_x,portal_probe_y,256,192);
        portal_probe=instance_create(portal_probe_x+128,portal_probe_y+96,PortalClear);
        portal_probe_started=elapsed;portal_probe_done=false;
        scrNTTESmokeLog("R127 LAB generated "+json_stringify({seed:GameCont.levseed,loops:GameCont.loops,
            rate:30/timescale,enemies:instance_number(enemy),chambers:chambers_seen,fill:instance_number(NTTESolidWall)}));
        scrRelease123Await(2);return;
    }
    if(phase==2) {
        if(!portal_probe_done && elapsed-portal_probe_started>=10) {
            assert(!instance_exists(portal_probe),"Scheduled PortalClear did not finish its native Alarm");
            for(var _dx=104;_dx<=152;_dx+=16) for(var _dy=72;_dy<=120;_dy+=16)
                assert(!position_meeting(portal_probe_x+_dx,portal_probe_y+_dy,Wall),
                    "Scheduled native PortalClear left solid collision inside its 64px opening");
            assert(position_meeting(portal_probe_x+8,portal_probe_y+8,Wall)
                && position_meeting(portal_probe_x+248,portal_probe_y+184,Wall),
                "Scheduled native PortalClear deleted distant packed collision");
            portal_probe_done=true;
            scrNTTESmokeLog("PASS R127 scheduled native PortalClear/Wall collision and Alarm @"+string(30/timescale));
        }
        // Declared controlled elimination; enemy native Step/Destroy, delayed
        // chambers, door motion, completion and portal alarms remain scheduled.
        if((elapsed mod 20)<timescale) with(enemy) if(team!=team_player) hp=0;
        if(!scr_check_enemies() && !instance_exists(NTTEFullFreakChamber) && instance_exists(Portal)) remaining_stable+=timescale;
        else remaining_stable=0;
        if(remaining_stable<60 || !portal_probe_done) return;
        array_push(rows,{seed:GameCont.levseed,loops:GameCont.loops,rate:30/timescale,
            initial_chambers:chambers_seen,clear_ticks:elapsed,portal:instance_number(Portal),draw_frames:draw_frames});
        scrNTTESmokeLog("PASS R127 LAB native generation/controlled elimination/hidden-room excavation/settled portal "+json_stringify(rows[array_length(rows)-1]));
        if(++pass_index<array_length(rates)) {scrRelease123Await(0);return;}
        scrNTTEFullCoastVaultRestore();
        scrNTTESmokeLog("PASS Release127LabNaturalTests6 scheduled laboratory scenes at30/60,loops0/1/3;not full campaign combat or phone FPS");
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
    }
}
function scrRelease127PerfStart() {
    var _o=instance_create(0,0,Release127PerfTest);
    with(_o) {
        var _keep=id;with(NTTESmokeTest) instance_deactivate_object(id);
        with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false);
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.is_level_ended=true;GameCont.underwater=false;
        UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_autopause=false;UberCont.opt_freeze=0;
        UberCont.opt_bossintro=false;UberCont.block_input_frames=100000;
        save_set_value("options","autopause",false);
        // Several separated rooms model the larger NTTE maps.
        for(var _room=0;_room<6;++_room) {
            for(var _ix=0;_ix<12;++_ix) for(var _iy=0;_iy<10;++_iy)
                instance_create(20000+(_room%3)*640+_ix*32,20000+(_room div 3)*640+_iy*32,Floor);
        }
        with(Floor) {mcr_floor_make_walls;mcr_floor_create_tops;}
        scrNTTESolidWallGenerate();
        target=scrPlayerCreate(0,Race.Fish,0);target.x=20160;target.y=20160;
        target.hp=10000;target.max_hp=10000;target.nexthurt=current_frame+100000;
        target.can_walk=false;target.can_aim=false;target.can_spec=false;
        global.is_server=true;global.index=0;phase=-1;frames=0;step_us=0;rows=[];
        wall_start=get_timer();phase_start=wall_start;begin_us=wall_start;logic_start=current_frame;
        scrNTTESmokeLog("R127 PROFILE scene floors="+string(instance_number(Floor))+" walls="+string(instance_number(Wall))+" packed="+string(instance_number(NTTESolidWall)));
    }
}
function scrRelease127PerfBegin() {
    begin_us=get_timer();
    assert(begin_us-wall_start<90000000,"Profile exceeded wall-clock limit");
    if(phase<0) scrRelease127PerfPhase();
}
function scrRelease127PerfPhase() {
    phase++;frames=0;step_us=0;draw_frames=0;phase_start=get_timer();logic_start=current_frame;
    if(phase==1 || phase==3) instance_deactivate_object(NTTESolidWall);
    else instance_activate_object(NTTESolidWall);
    var _rate=phase<2?60:(phase<4?game_speed_uncaped:30);
    UberCont.opt_framerate=_rate;game_set_speed(_rate,gamespeed_fps);
}
function scrRelease127PerfEnd() {
    step_us+=get_timer()-begin_us;frames++;
    var _elapsed=get_timer()-phase_start;
    if(_elapsed<3000000) return;
    var _row={phase:phase,packed_active:phase%2==0,frames:frames,wall_us:_elapsed,
        logic_ticks:current_frame-logic_start,fps_observed:frames*1000000/_elapsed,step_mean_us:step_us/frames,
        walls:instance_number(Wall),packed:instance_number(NTTESolidWall),draw_frames:draw_frames};
    assert(draw_frames>=frames-2,"Private desktop did not execute native Draw events");
    array_push(rows,_row);scrNTTESmokeLog("R127 PROFILE "+json_stringify(_row));
    if(phase<4) {scrRelease127PerfPhase();return;}
    for(var _i=0;_i<array_length(rows);++_i) if(rows[_i].phase==0 || rows[_i].phase==4)
        assert(abs(rows[_i].logic_ticks*1000000/rows[_i].wall_us-30)<1,
            "Dense-wall scene did not advance30 logical ticks per real second");
    scrNTTESmokeLog("PASS R127 frame profile; diagnostic desktop measurements, not Android FPS");
    scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
}

// Frozen pre-water-optimization renderer for independent pixel comparisons.
function scrRelease127SwimOracle(_bottom,_top,_sub,_capture) {
    var _swimmers=scrNTTEFullValue(GameCont,"ntte_sea_inst",[]),_visible=[],_renderer=id
    for(var _i=0;_i<array_length(_swimmers);++_i) {
        var _v=_swimmers[_i]
        if(instance_exists(_v) && _v.wading>0 && _v.bbox_left<view_xview+view_width+24 && _v.bbox_right>view_xview-24
            && _v.bbox_top<view_yview+view_height+24 && _v.bbox_bottom>view_yview-24) array_push(_visible,_v)
    }
    ntte_coast_swimmer_count=array_length(_visible)
    if(ntte_coast_swimmer_count==0) return;
    for(var _i=0;_i<array_length(_visible);++_i) with(_visible[_i]) {
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_capture)
        draw_clear_alpha(c_black,0)
        if(scrNTTEFullCoastObjectHasDraw(object_index)) event_perform(ev_draw,0)
        else draw_self()
        var _previous_mask=mask_index
        mask_index=sprite_index
        try {
        var _bbox_bottom=bbox_bottom-1,_bbox_width=bbox_right-bbox_left,_bbox_height=bbox_bottom-bbox_top,
            _wh=2+(wading-16)*0.2,_wh_max=min(6,round(_bbox_bottom-y)-2)
        if(_wh>_wh_max && (!instance_is(id,Player) || !instance_exists(Portal))) _wh=_wh_max
        if(wading_wave>0 && (speed==0 || !instance_is(id,hitme))) _wh+=min(wading/sprite_height,2)*sin(wading_wave)
        if(wading_sink) _wh+=wading_sink
        // Source bottom screenshot accumulates each whole actual Draw event.
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_bottom)
        draw_set_alpha(wading_sink ? 1-wading_sink/abs(sprite_height):1)
        scrNTTEFullCoastSurfaceDraw(_capture); draw_set_alpha(1)
        var _cut_y=_bbox_bottom-_wh
        if(_renderer.ntte_coast_fast_swim && shader_is_compiled(shNTTECoastSwimSplit)) {
            var _swimmer=id
            with(_renderer) scrRelease127SwimTopOracle(_capture,_top,_cut_y,_wh,_bbox_bottom,_bbox_width,_bbox_height,_swimmer)
        } else {
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_sub)
        gpu_set_blendmode_ext(bm_one,bm_zero); scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
        draw_sprite_ext(scrNTTERefSprite("WaterGradient"),0,x,_cut_y,(_bbox_width+40)/128,(_bbox_height+40)/128,0,c_white,1)
        if(wading_sink && _wh>_bbox_height/1.5) {
            draw_set_alpha(wading_sink/abs(sprite_height)); draw_rectangle(_sub.x,_sub.y,_sub.x+_sub.w,_sub.y+_sub.h,false); draw_set_alpha(1)
        }
        gpu_set_blendmode(bm_normal)
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_top)
        draw_set_alpha(0.4)
        with(_renderer) scrNTTEFullCoastSurfacePresent(_sub,c_white,_cut_y)
        draw_set_alpha(1);scrNTTEFullCoastSurfaceDraw(_sub)
        }
        } finally {mask_index=_previous_mask}
    }
    var _surfaces=[_bottom,_top]
    for(var _i=0;_i<2;++_i) scrRelease127SwimUnblendOracle(_surfaces[_i],_capture)
}
function scrRelease127SwimUnblendOracle(_s,_capture) {
    // Source Unblend[2] sets blendPower=1/pow(2,2)=1/4. Copy through scratch
    // to avoid sampling the active render target. The scratch is minor quality
    // as in CoastSwimScreen, including while processing a main-quality top.
    scrNTTEFullCoastSurfaceTarget(_capture);draw_clear_alpha(c_black,0)
    gpu_set_blendmode_ext(bm_one,bm_zero)
    var _shader=scrNTTEFullSourceUnblendBegin(2)
    if(_shader) {
        scrNTTEFullCoastSurfaceDraw(_s);shader_reset()
        scrNTTEFullCoastSurfaceTarget(_s);scrNTTEFullCoastSurfaceDraw(_capture)
    }
    else {
        // Original partial-unblend copies the unchanged screen once with
        // inv-src-alpha/one, then three more times with alpha writes only.
        scrNTTEFullCoastSurfaceDraw(_s)
        scrNTTEFullCoastSurfaceTarget(_s)
        gpu_set_blendmode_ext(bm_inv_src_alpha,bm_one)
        scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_colorwriteenable(false,false,false,true)
        repeat(3) scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_colorwriteenable(true,true,true,true)
    }
    gpu_set_blendmode(bm_normal)
    return _shader;
}

function scrRelease127SwimTopOracle(_capture,_top,_cut_y,_wh,_bottom,_bw,_bh,_actor) {
    if(!variable_instance_exists(id,"ntte_coast_swim_uniforms")) {
        ntte_coast_swim_uniforms={};
        var _names=["captureRect","gradientRect","gradientUV","sinkFactor","whiteRow"];
        for(var _i=0;_i<array_length(_names);++_i)
            ntte_coast_swim_uniforms[$ _names[_i]]=shader_get_uniform(shNTTECoastSwimSplit,_names[_i]);
        ntte_coast_swim_uniforms.sampler=shader_get_sampler_index(shNTTECoastSwimSplit,"gradientTex");
    }
    var _u=ntte_coast_swim_uniforms;
    var _gradient=scrNTTERefSprite("WaterGradient"),_uv=sprite_get_uvs(_gradient,0),
        _sx=(_bw+40)/128,_sy=(_bh+40)/128,
        _sink=(_actor.wading_sink && _wh>_bh/1.5)?1-_actor.wading_sink/abs(_actor.sprite_height):1;
    scrNTTEFullCoastSurfaceTarget(_top);
    shader_set(shNTTECoastSwimSplit);
    texture_set_stage(_u.sampler,sprite_get_texture(_gradient,0));
    shader_set_uniform_f(_u.captureRect,_capture.x,_capture.y,_capture.w,_capture.h);
    shader_set_uniform_f(_u.gradientRect,
        _actor.x-sprite_get_xoffset(_gradient)*_sx,_cut_y-sprite_get_yoffset(_gradient)*_sy,
        sprite_get_width(_gradient)*_sx,sprite_get_height(_gradient)*_sy);
    shader_set_uniform_f(_u.gradientUV,_uv[0],_uv[1],_uv[2],_uv[3]);
    shader_set_uniform_f(_u.sinkFactor,_sink);
    shader_set_uniform_f(_u.whiteRow,1);
    draw_set_alpha(0.4);
    draw_surface_part_ext(_capture.surf,0,(_cut_y-_capture.y)*_capture.scale-_capture.scale/_top.scale,
        _capture.w*_capture.scale,_capture.scale/_top.scale,_capture.x,_cut_y,
        1/_capture.scale,_top.scale/_capture.scale,c_white,0.4);
    shader_set_uniform_f(_u.whiteRow,0);
    draw_set_alpha(1);scrNTTEFullCoastSurfaceDraw(_capture);shader_reset();
}

// Capture real Draw events with restored actor state before each renderer.
function scrRelease127WaterCapture(_sea,_actors,_snapshot,_oracle,_output,_camera) {
    scrNTTEFullAreaGeneratorRestore(_snapshot);
    GameCont.ntte_sea_inst=_actors;
    with(_sea) {
        for(var _i=4;_i<8;++_i) {
            var _s=ntte_coast_surfaces[_i];_s.x=view_xview;_s.y=view_yview;
            scrNTTEFullCoastSurfaceTarget(_s);draw_clear_alpha(c_black,0);
        }
        gpu_set_blendmode(bm_normal);shader_reset();gpu_set_fog(false,0,0,0);draw_set_color(c_white);draw_set_alpha(1);
        if(_oracle) scrRelease127SwimOracle(ntte_coast_surfaces[4],ntte_coast_surfaces[5],ntte_coast_surfaces[6],ntte_coast_surfaces[7]);
        else scrNTTEFullCoastSwimCapture(ntte_coast_surfaces[4],ntte_coast_surfaces[5],ntte_coast_surfaces[6],ntte_coast_surfaces[7]);
        if(ntte_coast_target_active) {surface_reset_target();ntte_coast_target_active=false;}
    }
    surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(make_color_rgb(42,145,205),1);
    with(_sea) {scrNTTEFullCoastSurfacePresent(ntte_coast_surfaces[4]);scrNTTEFullCoastSurfacePresent(ntte_coast_surfaces[5]);}
    surface_reset_target();
    var _state=[];
    for(var _i=0;_i<array_length(_actors);++_i) with(_actors[_i])
        array_push(_state,[x,y,mask_index,speed,scrNTTEFullValue(id,"wave",0),scrNTTEFullValue(id,"wkick",0),scrNTTEFullValue(id,"bwkick",0)]);
    return json_stringify(_state);
}
function scrRelease127WaterTests() {
    var _fixture=scrRelease122FixtureBegin(),_state=scrNTTEFullCoastDrawState(),
        _vx=view_xview,_vy=view_yview,_quality=UberCont.opt_scaling,_p=instance_find(Player,0),
        _options=scrNTTEFullAreaGeneratorSnapshot(GameCont),_parked=scrNTTEFullInstances([NTTEFullCoastSea,NTTEFullCoastSeaTop,NTTEFullCoastSeaVisible]),
        _oldopt=scrNTTEFullOptionRaw("shaders"),_camera=-1,_outputs=[],_buffers=[];
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    try {
        view_xview=310000;view_yview=310000;UberCont.opt_scaling=2;
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.lastarea=GameCont.area;GameCont.ntte_full_active_coast=true;
        var _sea=scrNTTEFullCoastSeaEnsure(),_crab=instance_create(view_xview+130,view_yview+96,NTTEFullTrafficCrab),
            _corpse=instance_create(view_xview+130,view_yview+96,Corpse),_pickup=instance_create(view_xview+130,view_yview+96,WepPickup),
            _bandit=instance_create(view_xview+130,view_yview+96,Bandit);
        _crab.sprite_index=_crab.spr_idle;_crab.active=true;_crab.speed=0;_corpse.sprite_index=_p.sprite_index;
        _pickup.wep=wep_revolver;_pickup.sprite_index=sprRevolver;
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1);
        for(var _i=0;_i<2;++_i) {
            array_push(_outputs,surface_create(view_width,view_height));
            array_push(_buffers,buffer_create(view_width*view_height*4,buffer_fixed,1));
        }
        var _profiles=[[1,1,true,1],[2,1,true,1],[2.75,1.25,true,1],[1/3,2,false,1],[2,1,false,0],[5.25,5.25,true,1]],_total=0,_maxdelta=0;
        for(var _profile=0;_profile<array_length(_profiles);++_profile) {
            var _q=_profiles[_profile];_sea.ntte_coast_fast_swim=_q[2];_sea.ntte_coast_opaque_output=(_profile==3);
            variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",_q[3]);
            with(_sea) for(var _i=4;_i<8;++_i)
                scrNTTEFullCoastSurfaceEnsure(ntte_coast_surfaces[_i],view_width,view_height,(_i==5 || _i==6)?_q[0]:_q[1]);
            for(var _case=0;_case<13;++_case) {
                scrNTTEFullAreaGeneratorRestore(_fixture.players);
                _p.x=view_xview+130.25;_p.y=view_yview+96.5;_p.is_me=true;_p.wep=wep_revolver;_p.bwep=wep_shotgun;
                _p.wkick=3;_p.bwkick=4;_p.swapanim=2;_p.drawempty=0;_p.race=Race.Fish;
                _p.right=1;_p.wepflip=1;_p.bwepflip=1;_p.image_xscale=1;_p.image_yscale=1;
                var _actors=[_p];
                switch(_case) {
                    case 1:_p.wep=wep_crossbow;_p.gunangle=12;break;
                    case 2:_p.race=Race.Steroids;_p.gunangle=77;break;
                    case 3:_p.race=Race.Eyes;KeyCont.hold_spec[_p.index]=true;break;
                    case 4:_actors=[_crab];_crab.image_angle=63;_crab.image_xscale=1.7;_crab.image_yscale=0.8;break;
                    case 5:_actors=[_corpse];_corpse.image_angle=127;break;
                    case 6:_actors=[_pickup];_pickup.image_angle=42;_pickup.image_index=2;_pickup.ammo=true;break;
                    case 7:_actors=[_bandit];break;
                    case 8:_p.wading_sink=4;break;
                    case 9:_p.wading_sink=18;break;
                    case 10:_p.x=view_xview+1;_p.y=view_yview+2;break;
                    case 11:_actors=[_p,_crab,_corpse,_pickup];break;
                    case 12:_p.drawempty=2;break;
                }
                for(var _i=0;_i<array_length(_actors);++_i) with(_actors[_i]) {
                    scrNTTEFullCoastWadingSetup();wading=20;wading_wave=0.6;wading_sink=(_case==8?4:(_case==9?18:0));visible=true;image_alpha=1;
                }
                if(_profile==0 && _case==0) scrNTTESmokeLog("R127 WATER INPUT "+json_stringify({stop:lockstep_stop,sprite:_p.sprite_index,alpha:_p.image_alpha,
                    faint:_p.fainted,right:_p.right,visible:_p.visible,position:[_p.x,_p.y],bounds:[_p.bbox_left,_p.bbox_top,_p.bbox_right,_p.bbox_bottom],view:[view_xview,view_yview,view_width,view_height]}));
                var _snapshot=scrNTTEFullAreaGeneratorSnapshot(_actors),_native="";
                for(var _pass=0;_pass<2;++_pass) {
                    var _result=scrRelease127WaterCapture(_sea,_actors,_snapshot,_pass==0,_outputs[_pass],_camera);
                    if(_pass==0) _native=_result;else assert(_native==_result,"Regional water renderer changed native Draw side effects");
                    buffer_get_surface(_buffers[_pass],_outputs[_pass],0);
                }
                var _delta=0,_signal=0,_bad=0,_bg=surface_getpixel_ext(_outputs[0],view_width-1,view_height-1);
                for(var _at=0;_at<view_width*view_height*4;_at+=4) {
                    var _a=buffer_peek(_buffers[0],_at,buffer_u32),_b=buffer_peek(_buffers[1],_at,buffer_u32);
                    if(_a!=_bg) _signal++;
                    if(_a!=_b) for(var _channel=0;_channel<4;++_channel) {
                        var _d=abs(((_a>>(_channel*8))&255)-((_b>>(_channel*8))&255));
                        _delta=max(_delta,_d);if(_d>4) _bad++;
                    }
                }
                scrNTTESmokeLog("R127 WATER PIXELS "+json_stringify({profile:_profile,scene:_case,max_delta:_delta,signal:_signal,bad:_bad,swimmers:_sea.ntte_coast_swimmer_count,
                    background:_bg,body:surface_getpixel_ext(_outputs[0],130,96),buffer:buffer_peek(_buffers[0],(96*view_width+130)*4,buffer_u32)}));
                if(_bad || !_signal) {surface_save(_outputs[0],working_directory+"ntte-r127-water-oracle.png");surface_save(_outputs[1],working_directory+"ntte-r127-water-actual.png");}
                assert(_signal>8 && _bad==0,"Water crop lost native artwork, sight, waterline, edge, overlap or sink; profile="+string(_profile)+" case="+string(_case));
                _maxdelta=max(_maxdelta,_delta);_total++;
                if(_profile==0 && _case==0) {
                    var _full=view_width*view_height*6;
                    assert(_sea.ntte_coast_swim_blit_pixels<_full*0.25,"Single swimmer still copies the full screen per pass");
                    scrNTTESmokeLog("R127 WATER WORK "+json_stringify({rate:30/timescale,full_screen_pixels:_full,regional_pixels:_sea.ntte_coast_swim_blit_pixels}));
                }
            }
        }
        // Identical actual Draws, alternating old/new order and GPU readback
        // fence. Desktop measurements are not physical Android FPS results.
        var _crowd=[];
        for(var _i=0;_i<24;++_i) {
            var _a=instance_create(view_xview+40+(_i mod 8)*40,view_yview+40+(_i div 8)*40,NTTEFullTrafficCrab);
            _a.wading=20;_a.wading_wave=0;_a.wading_sink=0;array_push(_crowd,_a);
        }
        _sea.ntte_coast_fast_swim=true;_sea.ntte_coast_opaque_output=false;
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",1);
        with(_sea) for(var _i=4;_i<8;++_i) scrNTTEFullCoastSurfaceEnsure(ntte_coast_surfaces[_i],view_width,view_height,5.25);
        _p.x=view_xview+130.25;_p.y=view_yview+96.5;_p.drawempty=0;_p.race=Race.Fish;_p.wep=wep_revolver;
        _p.wading=20;_p.wading_wave=0;_p.wading_sink=0;_p.right=1;_p.visible=true;
        for(var _load=0;_load<2;++_load) {
            var _actors=_load?_crowd:[_p],_snapshot=scrNTTEFullAreaGeneratorSnapshot(_actors),_old=[],_new=[];
            for(var _sample=0;_sample<7;++_sample) for(var _phase=0;_phase<2;++_phase) {
                var _oracle=((_sample+_phase) mod 2)==0,_started=get_timer();
                scrRelease127WaterCapture(_sea,_actors,_snapshot,_oracle,_outputs[0],_camera);
                surface_getpixel(_outputs[0],1,1);
                if(_oracle) array_push(_old,get_timer()-_started);else array_push(_new,get_timer()-_started);
            }
            var _s=_sea.ntte_coast_surfaces[7],_full=(2*array_length(_actors)+4)*surface_get_width(_s.surf)*surface_get_height(_s.surf);
            scrNTTESmokeLog("R127 WATER TIMING "+json_stringify({rate:30/timescale,quality:5.25,swimmers:array_length(_actors),
                old:scrNTTEPerfTimingSummary(_old),regional:scrNTTEPerfTimingSummary(_new),
                full_screen_pixels:_full,regional_pixels:_sea.ntte_coast_swim_blit_pixels,physical_android:false}));
            if(!_load) assert(_sea.ntte_coast_swim_blit_pixels<_full*0.25,"Phone-density single swimmer still copies whole screens");
        }
        GameCont.ntte_sea_inst=[];
        with(_sea) scrNTTEFullCoastSwimCapture(ntte_coast_surfaces[4],ntte_coast_surfaces[5],ntte_coast_surfaces[6],ntte_coast_surfaces[7]);
        assert(_sea.ntte_coast_swimmer_count==0 && _sea.ntte_coast_swim_blit_pixels==0,"Dry shore still executes swimmer composites");
        scrNTTESmokeLog("PASS R127 WATER actual native Draw frozen oracle scenes="+string(_total)+" delta="+string(_maxdelta)+"; visible positive control, side effects, cropped pixel work, empty shore and fenced load timing @"+string(30/timescale));
    } finally {
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_state.target);++_i) surface_reset_target();
        for(var _i=0;_i<array_length(_outputs);++_i) if(surface_exists(_outputs[_i])) surface_free(_outputs[_i]);
        for(var _i=0;_i<array_length(_buffers);++_i) if(buffer_exists(_buffers[_i])) buffer_delete(_buffers[_i]);
        if(_camera>=0) camera_destroy(_camera);
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",_oldopt);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        draw_set_color(_state.color);draw_set_alpha(_state.alpha);if(_state.shader>=0) shader_set(_state.shader);else shader_reset();
        view_xview=_vx;view_yview=_vy;UberCont.opt_scaling=_quality;
        scrRelease122FixtureEnd(_fixture);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
    }
}
