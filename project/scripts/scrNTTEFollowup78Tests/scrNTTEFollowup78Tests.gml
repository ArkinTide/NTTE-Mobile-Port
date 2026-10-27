// Focused actual-native regressions for the eight post1.0.2 player reports.
function scrNTTEFullCatWarning78Tests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _state=scrNTTEFullCoastDrawState(),_target=false,
        _surface=surface_create(160,48),_camera=camera_create_view(0,0,160,48,0,noone,-1,-1,-1,-1),
        _visible=ds_list_create();
    ds_list_copy(_visible,global.lis_walls_visible);
    gpu_push_state();
    try {
        GameCont.area=scrNTTEFullAreaId("pizza");GameCont.subarea=1;
        var _attack=instance_create(16,16,NTTEFullCatBossAttack);
        _attack.ntte_full_lines=[{x:0,y:0,dir:0,dis:128}];_attack.direction=0;
        _attack.ntte_full_timer=15;
        for(var _variant=0;_variant<4;++_variant) {
            _attack.depth=_variant==3?9:6;
            var _floor=instance_create(64,0,_variant==2?FloorExplo:Floor);
            if(_variant==1 || _variant==3) with(_floor) {styleb=true;scrNTTEFullAreaFloorSetup(GameCont.area);}
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_fog(false,c_black,0,1);
            draw_set_alpha(1);draw_set_color(c_white);draw_clear_alpha(c_black,1);
            // Same descending depth order as the runner; exercise real warning
            // Draw against the actual area sprite, including the depth8 overlay.
            var _objects=[_floor,_attack];
            array_sort(_objects,function(_a,_b){return _b.depth-_a.depth;});
            for(var _i=0;_i<array_length(_objects);++_i) with(_objects[_i]) {
                if(id==_attack) event_perform(ev_draw,0);else draw_self();
            }
            surface_reset_target();_target=false;
            surface_save(_surface,working_directory+"ntte-cat-warning78-"+string(_variant)+"-"+string(30/timescale)+".png");
            var _seen=0;
            for(var _xx=76;_xx<=84;++_xx) for(var _yy=14;_yy<=18;++_yy) {
                var _pixel=surface_getpixel(_surface,_xx,_yy);
                if(color_get_green(_pixel)>220 && color_get_green(_pixel)>color_get_red(_pixel)+30) _seen++;
            }
            scrNTTESmokeLog("CAT WARNING78 "+json_stringify({variant:_variant,depth:_attack.depth,floor_depth:_floor.depth,green_pixels:_seen}));
            if(_variant==3) assert(_seen==0,"Delivered-depth negative control failed to hide warning behind overlay");
            else assert(_seen>0,"Cat gas warning hidden behind native floor overlay variant"+string(_variant));
            instance_destroy(_floor,false);
        }
    } finally {
        if(_target) surface_reset_target();
        var _all=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false);
        surface_free(_surface);camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset();
        scrNTTEFullAreaGeneratorRestore(_game);
        ds_list_copy(global.lis_walls_visible,_visible);ds_list_destroy(_visible);
    }
    scrNTTESmokeLog("PASS Cat gas warning actual Draw pixels above normal/styleB/exploded Pizza floors @"+string(30/timescale));
}

function scrNTTEFullPizzaSpawn78Inspect() {
    var _rows=[],_invalid=0,_floors=[],_walls=[];
    with(NTTEFullTurtleCool) {
        var _inside=position_meeting(x,y,Floor),_blocked=place_meeting(x,y,Wall);
        if(!_inside || _blocked) _invalid++;
        array_push(_rows,{x:x,y:y,startx:xstart,starty:ystart,inside:_inside,wall:_blocked,
            rat:ntte_full_become==Rat,mask:mask_index,bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom]});
    }
    with(Floor) array_push(_floors,[x,y]);with(Wall) array_push(_walls,[x,y]);
    scrNTTESmokeLog("PIZZA SPAWN78 DIAG "+json_stringify({rate:30/timescale,seed:global.ntte_pizza78_seed,
        tv:[TV.x,TV.y],watchers:_rows,floors:_floors,walls:_walls}));
    global.ntte_pizza78_invalid+=_invalid;
}
function scrNTTEFullPizzaSpawn78Tests() {
    var _seed=random_get_seed(),_oldseed=global.seed,_rng=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    global.ntte_pizza78_invalid=0;
    try {
        for(var _i=0;_i<16;++_i) {
            global.ntte_pizza78_seed=101013+97*_i;random_set_seed(global.ntte_pizza78_seed);
            scrNTTEFullPizzaNormalLifecycleSmoke(true);
        }
        assert(global.ntte_pizza78_invalid==0,"Pizza native generation placed watching turtles/rat inside or outside a boundary wall: "+string(global.ntte_pizza78_invalid));
    } finally {random_set_seed(_seed);global.seed=_oldseed;global.rng_state=_rng;}
    scrNTTESmokeLog("PASS16 actual native Pizza generations retain five watchers safely inside the den @"+string(30/timescale));
}

function scrNTTEFullPizzaShadow78Tests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_draw=scrNTTEFullCoastDrawState(),
        _view=[view_xview,view_yview,view_width,view_height],_seed=random_get_seed(),
        _walls=global.lis_walls_visible,_list=ds_list_create(),_shadow=surface_create(128,128),
        _camera=camera_create_view(0,0,128,128,0,noone,-1,-1,-1,-1),
        _parked=scrNTTEFullInstances([GenCont,Floor,FloorExplo,Wall,TopSmall,hitme,chestprop,CampChar,
            CarThrow,CrownObject,CrownPickup,BigWeaponChest,SnowBotCar,BigDogExplo,CrystalShield,
            LilHunterFly,Yeti,SodaCan,RavenFly,NTTEFullGhost,NTTEFullBeetleChestOpen,NTTEFullCoastBoss]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    try {
        view_xview=220000;view_yview=220000;view_width=128;view_height=128;
        global.lis_walls_visible=_list;BackCont.shad=_shadow;GameCont.area=area_sewers;
        var _wall=instance_create(220032,220032,Wall),_floor=noone;
        ds_list_add(_list,_wall);
        for(var _case=0;_case<4;++_case) {
            GameCont.area=_case==0?area_sewers:scrNTTEFullAreaId("pizza");
            if(_case==2) _floor=instance_create(_wall.x,_wall.y+16,Floor);
            if(_case==3) {instance_destroy(_floor,false);_floor=instance_create(_wall.x,_wall.y+16,FloorExplo);}
            camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());shader_reset();
            gpu_set_fog(false,c_black,0,1);gpu_set_ztestenable(false);gpu_set_zwriteenable(false);
            gpu_set_alphatestenable(false);gpu_set_colorwriteenable(true,true,true,true);
            gpu_set_blendmode(bm_normal);draw_set_alpha(1);draw_set_color(c_white);
            with(BackCont) scrShadows();
            var _coverage=0;
            for(var _xx=24;_xx<64;++_xx) for(var _yy=16;_yy<64;++_yy)
                if(((int64(surface_getpixel_ext(_shadow,_xx,_yy))>>24)&255)>0) _coverage++;
            scrNTTESmokeLog("PIZZA SHADOW78 "+json_stringify({variant:_case,coverage:_coverage}));
            if(_case==1) assert(_coverage==0,"Pizza perimeter wall still cast a rectangle onto exterior void");
            else assert(_coverage>0,"Pizza shadow fix removed valid ordinary/intact/exploded-floor wall shadows");
            surface_save(_shadow,working_directory+"ntte-pizza-shadow78-"+string(_case)+"-"+string(30/timescale)+".png");
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_draw.target);++_i) surface_reset_target();
        surface_free(_shadow);camera_destroy(_camera);ds_list_destroy(_list);global.lis_walls_visible=_walls;
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3];random_set_seed(_seed);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
    }
    scrNTTESmokeLog("PASS actual scrShadows pixels exclude Pizza exterior void and retain ordinary/intact/exploded-floor shadows @"+string(30/timescale));
}

function scrNTTEFullSecretWeapon78Tests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_hidden=scrNTTEFullInstances([GenCont,WepPickup,WeaponChest]),
        _seed=random_get_seed(),_rng=[],_tutorial=UberCont.showtutorial,_mode=UberCont.hardmode,
        _native=global.ntte_full_progress,_stop=lockstep_stop;
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i]);
    try {
        UberCont.showtutorial=false;UberCont.hardmode=false;
        with(Player) {race=Race.Fish;wep=wep_revolver;bwep=wep_none;}
        GameCont.area=area_sewers;GameCont.subarea=1;GameCont.hard=4;GameCont.loops=0;GameCont.crown=crwn_none;
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};
        scrNTTEFullSecretWeaponInit();
        var _pool=GameCont.ntte_weapon_spawn[0].wep;
        assert(array_get_index(_pool,wep_grenade_launcher)>=0 && array_get_index(_pool,wep_hyper_launcher)>=0
            && array_get_index(_pool,wep_shotgun)<0 && array_get_index(_pool,wep_ntte_bubble_rifle)>=0,
            "Original secret entrance explosive type/name/whitelist pool diverged");
        // Actual native box opening, several source RNG draws and cursed boxes.
        for(var _case=0;_case<12;++_case) {
            scrNTTEFullSecretWeaponInit();
            GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_case+1);GameCont.ntte_source_wepdrops=0;
            var _old=scrNTTEFullInstances(WepPickup),_box=instance_create(200000+64*_case,200000,WeaponChest),_drop=noone;
            _box.curse=_case mod 2;
            with(_box) event_perform(ev_collision,PortalShock);
            with(WepPickup) if(array_get_index(_old,id)<0) _drop=id;
            if(instance_exists(_drop)) with(_drop) event_perform(ev_step,ev_step_normal);
            assert(!instance_exists(_box) && instance_exists(_drop) && _drop.roll && _drop.ntte_secret_processed
                && array_get_index(_pool,scrNTTEFullWeaponRaw(_drop.wep))>=0 && _drop.curse==_case mod 2
                && array_length(GameCont.ntte_weapon_spawn)==1,
                "Actual2-1 normal/cursed chest did not provide one source-eligible explosive weapon");
        }
        // Source roll=true also belongs to real random enemy drops, rather
        // than to discarded/thrown inventory. Test that native producer.
        scrNTTEFullSecretWeaponInit();
        var _old=scrNTTEFullInstances(WepPickup),_enemy=instance_create(200900,200000,Bandit),_drop=noone;
        with(_enemy) scrDrop(0,100);
        with(WepPickup) if(array_get_index(_old,id)<0) _drop=id;
        assert(instance_exists(_drop) && _drop.roll,"Native random enemy drop lost its source roll marker");
        with(_drop) event_perform(ev_step,ev_step_normal);
        assert(array_get_index(_pool,scrNTTEFullWeaponRaw(_drop.wep))>=0
            && array_length(GameCont.ntte_weapon_spawn)==1,"Actual2-1 random enemy drop skipped the secret-entry guarantee");
        scrNTTEFullSecretWeaponInit();GameCont.area=area_desert;GameCont.subarea=1;
        var _early=scrWeaponPickupCreate(201000,200000,wep_grenade_launcher,true);
        with(_early) event_perform(ev_step,ev_step_normal);
        assert(array_length(GameCont.ntte_weapon_spawn)==1,"Earlier natural explosive drop failed to satisfy guarantee");
        GameCont.area=area_sewers;
        var _later=scrWeaponPickupCreate(201032,200000,wep_wrench,true);
        with(_later) {roll=true;scrNTTEFullSecretWeaponPickup();}
        assert(_later.wep==wep_wrench,"Consumed guarantee rerolled another weapon");
        scrNTTEFullSecretWeaponInit();
        var _held=scrWeaponPickupCreate(201064,200000,wep_shotgun,false);
        with(_held) event_perform(ev_step,ev_step_normal);
        assert(_held.wep==wep_shotgun && array_length(GameCont.ntte_weapon_spawn)==2,
            "Non-random dropped inventory weapon was replaced by the secret guarantee");
        GameCont.subarea=2;
        with(_held) {ntte_secret_processed=false;roll=true;scrNTTEFullSecretWeaponPickup();}
        assert(_held.wep==wep_shotgun && array_length(GameCont.ntte_weapon_spawn)==2,"Secret guarantee fired on the wrong subarea");
        // Original screwdriver rule skips the first opened chest at3-1.
        GameCont.area=area_scrapyards;GameCont.subarea=1;GameCont.hard=5;
        var _first=scrWeaponPickupCreate(201100,200000,wep_shotgun,true),_open=instance_create(201100,200000,ChestOpen);
        _open.sprite_index=sprWeaponChestOpen;
        with(_first) {roll=true;scrNTTEFullSecretWeaponPickup();}
        assert(_first.wep==wep_shotgun && GameCont.ntte_weapon_spawn[1].open==0,
            "Original3-1 screwdriver guarantee did not skip one actual open chest");
        var _second=scrWeaponPickupCreate(201132,200000,wep_shotgun,true);
        with(_second) {roll=true;scrNTTEFullSecretWeaponPickup();}
        assert(string_pos("SCREWDRIVER",wep_name[_second.wep])>0 && array_length(GameCont.ntte_weapon_spawn)==1,
            "Original3-1 second eligible pickup did not supply a screwdriver");
        // Preview executes the real box collision, so preserve guarantee state
        // even when its temporary explosive satisfied or replaced the roll.
        GameCont.area=area_sewers;GameCont.hard=4;
        scrNTTEFullSecretWeaponInit();var _pending=json_stringify(GameCont.ntte_weapon_spawn);
        instance_create(201200,200000,WeaponChest);scrNTTEFullBiggestWeaponChestLevelStart();
        assert(json_stringify(GameCont.ntte_weapon_spawn)==_pending,"Biggest chest preview consumed a real secret-entry guarantee");
        assert(json_parse(json_stringify(GameCont.ntte_weapon_spawn))[0].area==area_sewers,
            "Guarantee state is not native save-compatible");
        // Same-frame collision before the pickup's first Step must transfer
        // the guaranteed weapon, rather than replacing a destroyed pickup.
        scrNTTEFullSecretWeaponInit();lockstep_stop=false;
        var _p=instance_find(Player,0),_instant=scrWeaponPickupCreate(201300,200000,wep_shotgun,false);
        _instant.roll=true;_instant.autopick=true;_instant.speed=0;
        _p.x=_instant.x;_p.y=_instant.y;_p.wep=wep_revolver;_p.bwep=wep_none;
        _p.can_pick=true;_p.curse=0;
        with(_instant) with(_p) event_perform(ev_collision,WepPickup);
        assert(!instance_exists(_instant) && array_get_index(_pool,scrNTTEFullWeaponRaw(_p.wep))>=0
            && array_length(GameCont.ntte_weapon_spawn)==1,
            "Pre-Step actual Player collision transferred the original non-explosive weapon");
    } finally {
        var _all=scrNTTEFullInstances(all);
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false);
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);
        global.rng_state=_rng;global.ntte_full_progress=_native;random_set_seed(_seed);
        UberCont.showtutorial=_tutorial;UberCont.hardmode=_mode;
        lockstep_stop=_stop;
    }
    scrNTTESmokeLog("PASS source secret-entry pools,12 actual2-1 boxes, earlier natural satisfaction, one-shot/wrong-area/dropped-inventory exclusions,3-1 skip and actual preview rollback @"+string(30/timescale));
}

function scrNTTEFullPopup78Draw(_popup) {
    var _draw=scrNTTEFullCoastDrawState(),_top=scrNTTEFullAreaGeneratorSnapshot(TopCont),
        _surface=surface_create(view_width,view_height),_target=false,
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1);
    gpu_push_state();
    try {
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_fog(false,c_black,0,1);
        gpu_set_blendmode(bm_normal);draw_clear_alpha(c_black,1);
        with(TopCont) event_perform(ev_draw,0);
        surface_reset_target();_target=false;
        assert(_popup.mytext=="BLESSED!" && _popup.image_xscale>0,"Native popup Alarm2/TopCont.Draw lost blessing text");
    } finally {
        if(_target) surface_reset_target();surface_free(_surface);camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
        if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
        scrNTTEFullAreaGeneratorRestore(_top);
    }
    scrNTTESmokeLog("PASS actual Gator blessing PopupText Alarm2 and TopCont.Draw");
}
function scrNTTEFullMergedChinese78Tests() {
    var _lang=global.language_current,_small=global.language_font_default,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_target=false,
        _surface=surface_create(512,128),_camera=camera_create_view(0,0,512,128,0,noone,-1,-1,-1,-1);
    gpu_push_state();
    try {
        global.language_current=global.language_store[$ "Simplified Chinese"];
        global.language_font_default=fntCJK;
        assert(loc("Weapons",69,"Name","POP GUN")=="砰砰枪"
            && loc("Weapons",71,"Name","POP RIFLE")=="砰砰步枪","Player-approved Pop Gun/Rifle terminology was not installed");
        var _model=scrNTTEFullWeaponMerge(wep_ntte_guarded_artifact,69),_name=scrNTTEFullMergedName(_model),
            _shown=scrNTTEFullWeaponNameDisplay(_name);
        scrNTTESmokeLog("MERGED ZH78 "+json_stringify({canonical:_name,shown:_shown}));
        assert(string_pos("GUARDED",_shown)==0 && string_pos("POP",_shown)==0 && string_pos("ARTIFACT",_shown)==0,
            "Dynamic artifact/Pop Gun name remained in English after component subtitle was localized");
        assert(scrNTTEFullWeaponNameDisplay("@rGUARDED @qPOP @(color:123)ARTIFACT")
            =="@r守卫 @q砰砰 @(color:123)组件","Dynamic title translation altered rich-text control tags");
        var _models=[_model,scrNTTEFullWeaponMerge(wep_golden_shotgun,
            scrNTTEFullWeaponMerge(wep_grenade_launcher,wep_crossbow))];
        for(var _i=0;_i<array_length(_models);++_i) {
            var _wep=_models[_i],_saved=json_stringify(_wep),_canonical=scrNTTEFullMergedName(_wep);
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_fog(false,c_black,0,1);
            gpu_set_blendmode(bm_normal);draw_set_alpha(1);draw_set_color(c_white);draw_clear_alpha(c_black,1);
            var _layout=scrNTTEFullDrawMergedPickupTitle(_wep,view_width/2,100,_canonical),
                _glyphs=font_get_info(_layout.font).glyphs,_cjk=0;
            surface_reset_target();_target=false;
            assert(_layout.font==fntCJK && _layout.title==scrNTTEFullWeaponNameDisplay(_canonical)
                && _layout.subtitle==scrNTTEFullMergedPickupSubtitle(_wep)
                && _layout.subtitle_scale<=0.75,"Actual dynamic pickup title/subtitle lost Chinese font or layout");
            var _text=_layout.title+_layout.subtitle;
            for(var _ch=1;_ch<=string_length(_text);++_ch) {
                var _char=string_char_at(_text,_ch);
                if(ord(_char)>127) {_cjk++;assert(is_struct(_glyphs[$ _char]),"Dynamic weapon title missing compiled Chinese glyph: "+_char);}
            }
            assert(_cjk>0 && json_stringify(_wep)==_saved,"Dynamic localized title modified the canonical weapon model");
            var _ink=0;
            for(var _xx=0;_xx<512;++_xx) for(var _yy=0;_yy<128;++_yy)
                if(surface_getpixel(_surface,_xx,_yy)!=c_black) _ink++;
            assert(_ink>0,"Actual localized merged pickup title drew no pixels");
            surface_save(_surface,working_directory+"ntte-merged-chinese78-"+string(_i)+"-"+string(30/timescale)+".png");
            global.language_current=global.language_store[$ "English"];
            assert(scrNTTEFullWeaponNameDisplay(_canonical)==_canonical,"Chinese fragment fallback changed English titles");
            global.language_current=global.language_store[$ "Simplified Chinese"];
        }
    } finally {
        if(_target) surface_reset_target();surface_free(_surface);camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
        global.language_current=_lang;global.language_font_default=_small;
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);
    }
    scrNTTESmokeLog("PASS dynamic/nested merged Chinese actual title/subtitle Draw, compiled glyphs, Pop Gun terms, rich tags and unchanged English/model @"+string(30/timescale));
}

function scrNTTEFullPizzaPropHurt78Tests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_frame=current_frame;
    try {
        var _kinds=["Cabinet","Couch","Table","ChairFront","ChairSide"];
        for(var _i=0;_i<array_length(_kinds);++_i) {
            var _prop=scrNTTEFullLairPropCreate(210000+64*_i,210000,_kinds[_i]);
            scr_hit(_prop,1,HitId.None,true);
            assert(_prop.hp==_prop.max_hp-1 && _prop.sprite_index==_prop.spr_hurt,
                "Furniture native hit did not enter the real hurt sprite");
            var _speed=_prop.image_speed;
            // Delivered zero-speed negative control remains on the white frame.
            _prop.image_speed=0;
            repeat(ceil(10/timescale)) with(_prop) {image_index+=image_speed;event_perform(ev_step,ev_step_begin);}
            assert(_prop.sprite_index==_prop.spr_hurt,"Frozen-hurt negative control did not reproduce original stuck frame");
            _prop.image_speed=_speed;
            repeat(ceil(10/timescale)) with(_prop) {image_index+=image_speed;event_perform(ev_step,ev_step_begin);}
            assert(_prop.sprite_index==_prop.spr_idle && _prop.hp==_prop.max_hp-1,
                "Furniture hurt animation never restored its textured idle sprite: "+_kinds[_i]);
        }
    } finally {
        var _all=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false);
        random_set_seed(_seed);current_frame=_frame;
    }
    scrNTTESmokeLog("PASS five Pizza/Lair furniture native damage + white-frame negative control + restored animation/texture @"+string(30/timescale));
}

function scrNTTEFullQuestDrop78Tests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _seed=random_get_seed(),_mode=UberCont.hardmode,_custom=UberCont.custom;
    try {
        UberCont.hardmode=false;UberCont.custom=false;GameCont.hard=20;GameCont.crown=crwn_none;
        with(Player) {wep=wep_ntte_bone;bwep=wep_revolver;ntte_state=scrNTTENewState(wep_ntte_bone);}
        for(var _i=0;_i<4;++_i) {
            var _alias=wep_ntte_ancient_artifact+_i;
            assert(scr_weapon_get_area(_alias)==-1,"Quest alias entered ordinary random weapon/reward pools when carrying a bone");
            var _actual=scrNTTEFullCrabboneCreateModel(_i);
            assert(scrNTTEFullCrabbonePartIndex(_actual)==_i && scr_weapon_get_name(_actual)==wep_name[_alias],
                "Authored hidden quest component lost its legitimate identity/metadata");
        }
        var _excluded=[];
        for(var _w=0;_w<=maxwep;++_w) if(_w!=wep_ntte_bone
            && !(_w>=wep_ntte_ancient_artifact && _w<=wep_ntte_missing_artifact)) array_push(_excluded,_w);
        for(var _i=0;_i<32;++_i) {
            var _drop=scrNTTEFullWeaponDecide(0,20,false,_excluded),
                _merge=scrNTTEFullWeaponMerge(_drop,wep_shotgun);
            assert(_drop==wep_ntte_bone && scrNTTEFullWeaponRaw(_merge)==wep_ntte_bone
                && scrNTTEFullCrabbonePartIndex(_merge)==-1,
                "Ordinary randomized bone reward was promoted into a secret component or component fusion");
        }
    } finally {
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);
        UberCont.hardmode=_mode;UberCont.custom=_custom;random_set_seed(_seed);
    }
    scrNTTESmokeLog("PASS four secret-component aliases excluded from natural/absolute fusion-reward pools; authored hidden parts and ordinary bone merges preserved @"+string(30/timescale));
}

function scrNTTEFullRoadmapLoop78Tests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_draw=scrNTTEFullCoastDrawState(),
        _surface=surface_create(192,64),_camera=camera_create_view(0,0,192,64,0,noone,-1,-1,-1,-1),_target=false;
    gpu_push_state();
    try {
        GameCont.waypoints=4;GameCont.waypnt=[area_desert,area_palace,area_desert,area_desert];
        GameCont.waysub=[3,3,1,2];GameCont.waylps=[0,0,1,1];
        var _map=scrNTTEFullRoadmapData();
        assert(!_map[3].showline && _map[4].showline,"New loop drew a full-width return segment instead of restarting its progression");
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_fog(false,c_black,0,1);
        gpu_set_blendmode(bm_normal);draw_clear_alpha(c_black,1);draw_set_alpha(1);
        scrNTTEFullRoadmapDraw(10,32,4);
        surface_reset_target();_target=false;
        surface_save(_surface,working_directory+"ntte-roadmap-loop78-"+string(30/timescale)+".png");
        var _ahead=surface_getpixel(_surface,110,33),_done=surface_getpixel(_surface,15,33),
            _red=make_color_hsv(0,200,200),_yellow=make_color_hsv(39,200,200);
        assert(_ahead==_red && _done==_yellow,
            "Actual roadmap pixels painted unfinished loop stages with current-loop yellow: "+string(_ahead)+"/"+string(_done));
        // A crown room after the new loop must preserve the same reset boundary.
        GameCont.waypnt[3]=area_vault;GameCont.waysub[3]=1;
        _map=scrNTTEFullRoadmapData();
        assert(!_map[3].showline,"Entering a crown vault resurrected the cross-loop return segment");
        _map=scrNTTEFullRoadmapData([[area_palace,3,1],[area_desert,1,2],[201,1,2],[201,2,2]]);
        assert(!_map[2].showline && _map[3].showline && _map[4].showline
            && _map[4].loops==2,"Later loops or same-loop Coast detours lost the roadmap reset/connecting path");
    } finally {
        if(_target) surface_reset_target();surface_free(_surface);camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
        scrNTTEFullAreaGeneratorRestore(_game);
    }
    scrNTTESmokeLog("PASS new-loop reset geometry, crown-room history and actual red/yellow roadmap pixels @"+string(30/timescale));
}

// A pixel oracle for the actual ground-shadow pass, including a negative
// control using unchanged ordinary shadows and the same Pizza artwork.
function scrNTTEFullPizzaShadow104Pixels(_surface) {
    return json_parse(scrNTTEParrotPerchPixels77(_surface));
}
function scrNTTEFullPizzaShadow104Compare(_actual,_reference,_vx,_vy,_width,_height) {
    var _inside=0,_outside=0;
    for(var _yy=0;_yy<_height;++_yy) for(var _xx=0;_xx<_width;++_xx) {
        var _i=_yy*_width+_xx,_a=(_actual[_i]>>24)&255,_b=(_reference[_i]>>24)&255;
        if(_b==0 && _a==0) continue;
        var _floor=position_meeting(_vx+_xx+0.5,_vy+_yy+0.5,Floor)
            || position_meeting(_vx+_xx+0.5,_vy+_yy+0.5,FloorExplo);
        if(_floor) {
            assert(_a==_b,"Pizza clipping changed valid floor-shadow coverage: "+string([_xx,_yy,_a,_b]));
            if(_a>0) _inside++;
        } else {
            assert(_a==0,"Pizza wall shadow still paints exterior background: "+string([_xx,_yy,_a]));
            if(_b>0) _outside++;
        }
    }
    return {inside:_inside,negative_control_spill:_outside};
}
function scrNTTEFullPizzaShadow104Tests(_area_key="pizza") {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_draw=scrNTTEFullCoastDrawState(),
        _view=[view_xview,view_yview,view_width,view_height],_seed=random_get_seed(),
        _walls=global.lis_walls_visible,_list=ds_list_create(),_shadow=surface_create(128,128),
        _camera=camera_create_view(0,0,128,128,0,noone,-1,-1,-1,-1),
        _parked=scrNTTEFullInstances([GenCont,Floor,FloorExplo,Wall,TopSmall,hitme,chestprop,CampChar,
            CarThrow,CrownObject,CrownPickup,BigWeaponChest,SnowBotCar,BigDogExplo,CrystalShield,
            LilHunterFly,Yeti,SodaCan,RavenFly,NTTEFullGhost,NTTEFullBeetleChestOpen,NTTEFullCoastBoss]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    try {
        view_xview=220000;view_yview=220000;view_width=128;view_height=128;
        global.lis_walls_visible=_list;BackCont.shad=_shadow;GameCont.area=scrNTTEFullAreaId(_area_key);
        var _wall=instance_create(220032,220032,Wall),_spills=0,_retained=0;
        for(var _case=0;_case<6;++_case) {
            instance_destroy(Floor,false);instance_destroy(FloorExplo,false);
            if(_case==0) instance_create(_wall.x+8,_wall.y+16,Floor);
            if(_case==1) instance_create(_wall.x-24,_wall.y+16,Floor);
            if(_case==2) instance_create(_wall.x,_wall.y+24,Floor);
            if(_case==3) instance_create(_wall.x+12,_wall.y+18,FloorExplo);
            if(_case==4) {instance_create(_wall.x+8,_wall.y+16,Floor);instance_create(_wall.x-24,_wall.y-16,Floor);}
            _wall.outindex=_case mod sprite_get_number(_wall.outspr);
            ds_list_clear(_list);ds_list_add(_list,_wall);
            camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());shader_reset();
            gpu_set_fog(false,c_black,0,1);gpu_set_ztestenable(false);gpu_set_zwriteenable(false);
            gpu_set_alphatestenable(false);gpu_set_colorwriteenable(true,true,true,true);gpu_set_texfilter(false);
            gpu_set_blendmode(bm_normal);draw_set_alpha(1);draw_set_color(c_white);
            // Non-Pizza area keeps the original path while the actual wall's
            // Pizza sprite and subimage remain unchanged.
            GameCont.area=area_sewers;with(BackCont) scrShadows();
            var _reference=scrNTTEFullPizzaShadow104Pixels(_shadow);
            GameCont.area=scrNTTEFullAreaId(_area_key);with(BackCont) scrShadows();
            var _actual=scrNTTEFullPizzaShadow104Pixels(_shadow),
                _result=scrNTTEFullPizzaShadow104Compare(_actual,_reference,view_xview,view_yview,128,128);
            _spills+=_result.negative_control_spill;_retained+=_result.inside;
            scrNTTESmokeLog("PIZZA SHADOW104 "+json_stringify({variant:_case,result:_result}));
            surface_save(_shadow,working_directory+"ntte-pizza-shadow104-"+string(_case)+"-"+string(30/timescale)+".png");
        }
        assert(_spills>0 && _retained>0,"Shadow edge fixture failed to exercise both real void spill and retained ground shadows");
        // Entity shadows use their original pass after the wall clipping.
        ds_list_clear(_list);var _enemy=instance_create(220096,220096,Bandit);
        _enemy.spr_shadow=shd24;_enemy.visible=true;
        GameCont.area=area_sewers;with(BackCont) scrShadows();
        var _actor_reference=scrNTTEFullPizzaShadow104Pixels(_shadow);
        GameCont.area=scrNTTEFullAreaId(_area_key);with(BackCont) scrShadows();
        var _actor_actual=scrNTTEFullPizzaShadow104Pixels(_shadow),_actor_coverage=0;
        for(var _i=0;_i<array_length(_actor_actual);++_i) {
            assert(_actor_actual[_i]==_actor_reference[_i],"Pizza clipping changed an ordinary actor shadow pixel");
            if(((_actor_actual[_i]>>24)&255)>0) _actor_coverage++;
        }
        assert(_actor_coverage>0,"Actor shadow fixture is empty: "+string([_enemy.x,_enemy.y,_enemy.spr_shadow,_enemy.visible]));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_draw.target);++_i) surface_reset_target();
        surface_free(_shadow);camera_destroy(_camera);ds_list_destroy(_list);global.lis_walls_visible=_walls;
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3];random_set_seed(_seed);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
    }
    scrNTTESmokeLog("PASS PIZZA SHADOW104 actual pixels six intact/broken/corner/void cases, unchanged ordinary shadow negative control, actor shadows retained @"+string(30/timescale));
}
function scrNTTEFullPizzaShadow104NaturalInspect() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _draw=scrNTTEFullCoastDrawState(),_view=[view_xview,view_yview,view_width,view_height],
        _walls=global.lis_walls_visible,_list=ds_list_create(),_shadow=surface_create(384,320),
        _scene=surface_create(384,320),_camera=camera_create_view(0,0,384,320,0,noone,-1,-1,-1,-1),
        _parked=scrNTTEFullInstances([hitme,chestprop,CampChar,CarThrow,CrownObject,CrownPickup,BigWeaponChest,
            SnowBotCar,BigDogExplo,CrystalShield,LilHunterFly,Yeti,SodaCan,RavenFly,NTTEFullGhost,NTTEFullBeetleChestOpen,NTTEFullCoastBoss]),
        _stop=lockstep_stop,_bloom=UberCont.opt_bloom,_active=false,_own_sub=false,_sub=noone;
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    try {
        view_xview=9896;view_yview=9864;view_width=384;view_height=320;
        global.lis_walls_visible=_list;with(Wall) ds_list_add(_list,id);BackCont.shad=_shadow;
        camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());shader_reset();
        gpu_set_fog(false,c_black,0,1);gpu_set_ztestenable(false);gpu_set_zwriteenable(false);
        gpu_set_alphatestenable(false);gpu_set_colorwriteenable(true,true,true,true);gpu_set_texfilter(false);
        gpu_set_blendmode(bm_normal);draw_set_alpha(1);draw_set_color(c_white);
        GameCont.area=area_sewers;with(BackCont) scrShadows();
        var _reference=scrNTTEFullPizzaShadow104Pixels(_shadow);
        GameCont.area=scrNTTEFullAreaId("pizza");with(BackCont) scrShadows();
        var _actual=scrNTTEFullPizzaShadow104Pixels(_shadow),
            _result=scrNTTEFullPizzaShadow104Compare(_actual,_reference,view_xview,view_yview,384,320);
        assert(_result.negative_control_spill>0 && _result.inside>0,"Natural Pizza failed to cover exterior and interior shadow pixels");
        scrNTTESmokeLog("PIZZA SHADOW104 NATURAL "+json_stringify({seed:global.ntte_pizza78_seed,rate:30/timescale,result:_result,walls:ds_list_size(_list)}));
        surface_save(_shadow,working_directory+"ntte-pizza-shadow104-natural-"+string(global.ntte_pizza78_seed)+"-"+string(30/timescale)+".png");
        // Render the genuine native ground + side/top-wall passes for visual
        // review of the generated perimeter, not only a one-wall fixture.
        surface_set_target(_scene);_active=true;camera_set_view_pos(_camera,view_xview,view_yview);camera_apply(_camera);
        draw_clear_alpha(scrAreaGetBackroundColor(GameCont.area),1);
        with(Floor) draw_self();lockstep_stop=false;UberCont.opt_bloom=false;
        with(BackCont) event_perform(ev_draw,0);with(Wall) if(visible) draw_self();
        if(!instance_exists(SubTopCont)) {_sub=instance_create(0,0,SubTopCont);_own_sub=true;}
        assert(instance_exists(SubTopCont),"Natural Pizza composition omitted the native wall-top pass");
        with(SubTopCont) event_perform(ev_draw,0);
        surface_reset_target();_active=false;
        surface_save(_scene,working_directory+"ntte-pizza-shadow104-scene-"+string(global.ntte_pizza78_seed)+"-"+string(30/timescale)+".png");
    } finally {
        if(_active) surface_reset_target();if(_own_sub) instance_destroy(_sub,false);
        surface_free(_shadow);surface_free(_scene);camera_destroy(_camera);ds_list_destroy(_list);
        global.lis_walls_visible=_walls;scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3];
        lockstep_stop=_stop;UberCont.opt_bloom=_bloom;
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
    }
}
function scrNTTEFullPizzaShadow104NaturalTests() {
    var _seed=random_get_seed(),_oldseed=global.seed,_rng=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));global.ntte_pizza78_invalid=0;
    try {
        for(var _i=0;_i<3;++_i) {
            global.ntte_pizza78_seed=101013+97*_i;random_set_seed(global.ntte_pizza78_seed);
            scrNTTEFullPizzaNormalLifecycleSmoke(true,true);
        }
    } finally {random_set_seed(_seed);global.seed=_oldseed;global.rng_state=_rng;}
    scrNTTESmokeLog("PASS PIZZA SHADOW104 NATURAL three real generated levels, pixel-clipped perimeter and native wall composition @"+string(30/timescale));
}
