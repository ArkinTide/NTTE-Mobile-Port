// Native-runner acceptance checks. Call Start in an isolated, fully generated
// game, then call Step each host frame. Production gameplay never invokes it.
function scrFRRaceTestsCheck(_name,_condition) {
    var _state=global.fr_race_tests;
    array_push(_state.checks,{name:_name,ok:!!_condition});
    if(!_condition) _state.ok=false;
}

function scrFRRaceTestsSaveGet(_field) { return scrFRModCallArray("mod","libSaves","save_get",["Frontier",_field]); }
function scrFRRaceTestsSaveSet(_field,_value) { return scrFRModCallArray("mod","libSaves","save_set",["Frontier",_field,_value]); }

function scrFRRaceTestsSelectMarkers() {
    var _icon=instance_create(64,64,CharSelect),_surface=-1,_camera=-1,_target=false,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _shader=shader_current(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _runs=scrFRRaceTestsSaveGet("bubbles_runs"),_visits=scrFRRaceTestsSaveGet("cyberspace_visits"),
        _finales=scrFRRaceTestsSaveGet("deeplabs_finales"),
        _enabled=scrFRModGet("mod","Frontier_Main","settingCyberspaceEnabled");
    _icon.race=19;_icon.visible=true;_icon.can=true;_icon.image_index=0;
    gpu_push_state();
    try {
        scrFRRaceTestsSaveSet("bubbles_runs",0);
        var _marker=scrNTTEFullRaceNewMarker(_icon,true);
        scrFRRaceTestsCheck("fresh owned Bubbles uses native NEW consumer and GUI hover offset",
            is_struct(_marker) && _marker.sprite==sprNew && _marker.x==64 && _marker.y==63
            && !variable_instance_exists(_icon,"mouseover"));
        _surface=surface_create(128,128);
        _camera=camera_create_view(0,0,128,128,0,noone,-1,-1,-1,-1);
        assert(surface_exists(_surface),"Frontier NEW marker surface allocation failed");
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
        gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_set_color(c_white);draw_set_alpha(1);
        draw_clear_alpha(c_black,0);
        scrFRRaceTestsCheck("fresh Bubbles NEW marker reaches actual native draw consumer",
            scrNTTEFullRaceNewMarkerDraw(_icon,true));
        surface_reset_target();_target=false;
        var _pixels=0;
        for(var _y=48;_y<80;++_y) for(var _x=48;_x<80;++_x)
            if(surface_getpixel_ext(_surface,_x,_y)>>24) _pixels++;
        scrFRRaceTestsCheck("actual Bubbles NEW draw produces visible marker pixels",_pixels>0);
        _icon.can=false;
        scrFRRaceTestsCheck("locked Bubbles does not display NEW marker",is_undefined(scrNTTEFullRaceNewMarker(_icon)));
        _icon.can=true;_icon.visible=false;
        scrFRRaceTestsCheck("hidden Bubbles does not display NEW marker",is_undefined(scrNTTEFullRaceNewMarker(_icon)));
        _icon.visible=true;scrFRRaceTestsSaveSet("bubbles_runs",1);
        scrFRRaceTestsCheck("Bubbles NEW marker clears after first run",is_undefined(scrNTTEFullRaceNewMarker(_icon)));

        _icon.race=Race.Robot;
        scrFRModSet("mod","Frontier_Main","settingCyberspaceEnabled",true);
        scrFRRaceTestsSaveSet("cyberspace_visits",0);scrFRRaceTestsSaveSet("deeplabs_finales",1);
        _marker=scrNTTEFullRaceNewMarker(_icon,true);
        scrFRRaceTestsCheck("Robot cyberspace notice keeps original dedicated artwork and eligibility",
            is_struct(_marker) && _marker.sprite==scrFRModGet("mod","Frontier_Main","sprNewRobot")
            && _marker.x==64 && _marker.y==63);
        scrFRRaceTestsSaveSet("cyberspace_visits",1);
        scrFRRaceTestsCheck("Robot notice clears after authored cyberspace visit",is_undefined(scrNTTEFullRaceNewMarker(_icon)));
        scrFRRaceTestsSaveSet("cyberspace_visits",0);scrFRRaceTestsSaveSet("deeplabs_finales",0);
        scrFRRaceTestsCheck("Robot notice requires authored Deeplabs completion",is_undefined(scrNTTEFullRaceNewMarker(_icon)));
        scrFRRaceTestsSaveSet("deeplabs_finales",1);scrFRModSet("mod","Frontier_Main","settingCyberspaceEnabled",false);
        scrFRRaceTestsCheck("Robot notice respects authored cyberspace setting",is_undefined(scrNTTEFullRaceNewMarker(_icon)));

        // Exercise the old source callbacks in their real transient binding
        // scope. The native CharSelect consumer owns their UI output now;
        // neither callback may reach legacy mouseover/alarm/world offsets.
        for(var _which=0;_which<2;++_which) {
            _icon.race=_which==0?19:Race.Robot;
            var _binding=scrFRBindingCreate("draw",scrFRScriptGet("mod","Frontier_Main",
                _which==0?"CharSelect_draw_new":"CharSelect_draw_robot"),-1,[_icon]);
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,0);
            with(_binding) scrFRBindingDraw();
            surface_reset_target();_target=false;
            scrFRRaceTestsCheck("retired source NEW overlay preserves native selector "+string(_which),
                instance_exists(_icon) && (!instance_exists(_binding) || _binding.fr_binding_expire_serial>=0));
            _pixels=0;
            for(var _y=48;_y<80;++_y) for(var _x=48;_x<80;++_x)
                if(surface_getpixel_ext(_surface,_x,_y)>>24) _pixels++;
            scrFRRaceTestsCheck("retired source NEW overlay does not duplicate native marker "+string(_which),_pixels==0);
            if(instance_exists(_binding)) instance_destroy(_binding,false);
        }
        _icon.race=Race.Fish;
        scrFRRaceTestsCheck("Frontier markers leave baseline race consumer ownership intact",!scrFRRaceSelectMarkerOwned(_icon));
    } finally {
        if(_target) surface_reset_target();
        if(_camera>=0) camera_destroy(_camera);
        gpu_pop_state();
        if(_shader<0) shader_reset();else shader_set(_shader);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        draw_set_color(_color);draw_set_alpha(_alpha);
        if(surface_exists(_surface)) surface_free(_surface);
        if(instance_exists(_icon)) instance_destroy(_icon,false);
        scrFRRaceTestsSaveSet("bubbles_runs",_runs);scrFRRaceTestsSaveSet("cyberspace_visits",_visits);
        scrFRRaceTestsSaveSet("deeplabs_finales",_finales);
        scrFRModSet("mod","Frontier_Main","settingCyberspaceEnabled",_enabled);
    }
}

function scrFRRaceTestsClock() {
    var _frame=current_frame,_scale=timescale,_serial=FRWorld.logic_serial;
    var _render=global.fr_render_context;
    try {
        for(var _hz=30;_hz<=60;_hz+=30) {
            var _delta=30/_hz;
            global.time_scale=_delta;global.fr_render_context=false;
            current_frame=123;FRWorld.logic_serial=8700;
            var _deadline=scrFRSourceFrame()+6;
            scrFRRaceTestsCheck("clock "+string(_hz)+"Hz shares native axis",_deadline==129);
            var _visible=0;
            repeat(_hz/5) {
                global.fr_render_context=true;
                if(_deadline>scrFRSourceFrame()) _visible++;
                global.fr_render_context=false;
                current_frame+=_delta;
            }
            scrFRRaceTestsCheck("clock "+string(_hz)+"Hz six-tick hurt window",_visible==_hz/5 && _deadline<=current_frame);
            current_frame=123.5;
            scrFRRaceTestsCheck("clock "+string(_hz)+"Hz logical frame integral",scrFRSourceFrame()==123);
        }
    } finally {
        current_frame=_frame;global.time_scale=_scale;FRWorld.logic_serial=_serial;
        global.fr_render_context=_render;
    }
}

function scrFRRaceTestsObjectFamilies() {
    var _plain=instance_create(11000,11000,Slash);
    var _guitar=scrFRInstanceCreate(11100,11000,FR_OBJECT_GUITAR_SLASH);
    var _crystal=scrFRInstanceCreate(11200,11000,FR_OBJECT_INV_CRYSTAL);
    var _effect=scrFRInstanceCreate(11300,11000,FR_OBJECT_EFFECT);
    var _pickup=scrFRInstanceCreate(11400,11000,FR_OBJECT_PICKUP);
    var _pause=instance_create(11500,11000,PauseButton),_back=instance_create(11600,11000,BackButton);
    _pause.visible=false;_back.visible=false;
    var _thrown=scrWeaponPickupCreate(11700,11000,wep_revolver);
    _thrown.creator=global.fr_race_tests.players[0];_thrown.mask_index=mskPlasma;
    try {
        scrFRRaceTestsCheck("GuitarSlash query excludes ordinary Slash",
            scrFRInstanceIs(_guitar,FR_OBJECT_GUITAR_SLASH) && !scrFRInstanceIs(_plain,FR_OBJECT_GUITAR_SLASH));
        scrFRRaceTestsCheck("GuitarSlash create retains heavy slash behavior",
            _guitar.guitar && _guitar.damage==26 && _guitar.sprite_index==sprHeavySlash
            && scrFRObjectIndex(_guitar)==FR_OBJECT_GUITAR_SLASH);
        scrFRRaceTestsCheck("InvCrystal has separate native identity and original cursed art",
            scrFRObjectIndex(_crystal)==FR_OBJECT_INV_CRYSTAL && _crystal.spr_idle!=sprCrystalProp
            && sprite_exists(_crystal.spr_hurt) && sprite_exists(_crystal.spr_dead));
        scrFRRaceTestsCheck("Effect and Pickup source create/query preserve families",
            scrFRInstanceIs(_effect,FR_OBJECT_EFFECT) && scrFRInstanceIs(_pickup,FR_OBJECT_PICKUP)
            && scrFRInstanceIs(_effect,FR_OBJECT_GAME) && scrFRInstanceIs(_pickup,FR_OBJECT_GAME));
        scrFRRaceTestsCheck("Effect source logical parent is GameObject",
            scrFRObjectParent(scrFRObjectIndex(_effect))==FR_OBJECT_GAME);
        scrFRRaceTestsCheck("absent original OasisBoss query is safely empty",
            scrFRInstanceNumber(FR_OBJECT_OASIS_BOSS)==0);
        scrFRRaceTestsCheck("legacy menu family queries find real native controls",
            scrFRInstanceIs(_pause,FR_OBJECT_MENU_BUTTON) && scrFRInstanceIs(_back,FR_OBJECT_BACK_MAIN_MENU)
            && scrFRInstanceIs(_pause,FR_OBJECT_UI_BUTTON) && scrFRInstanceIs(_back,FR_OBJECT_UI_BUTTON));
        scrFRRaceTestsCheck("gameover family excludes native pause controls during a live game",
            !instance_exists(GameOver) && !scrFRInstanceIs(_pause,FR_OBJECT_GAMEOVER_BUTTON));
        scrFRRaceTestsCheck("native flying weapon reports original ThrownWep projectile family",
            _thrown.object_index==WepPickup && scrFRObjectIndex(_thrown)==FR_OBJECT_THROWN_WEP
            && scrFRInstanceIs(_thrown,projectile) && scrFRInstanceIs(_thrown,FR_OBJECT_THROWN_WEP)
            && !scrFRInstanceIs(_thrown,FR_OBJECT_PICKUP));
        _thrown.mask_index=mskWepPickup;
        scrFRRaceTestsCheck("native landed weapon returns to source pickup family",
            scrFRObjectIndex(_thrown)==WepPickup && !scrFRInstanceIs(_thrown,projectile)
            && !scrFRInstanceIs(_thrown,FR_OBJECT_THROWN_WEP) && scrFRInstanceIs(_thrown,FR_OBJECT_PICKUP));
    } finally {
        with(_plain) instance_destroy();with(_guitar) instance_destroy();
        // Avoid introducing corpse FX into later isolated test assertions.
        with(_crystal) {corpse=false;snd_dead=-1;instance_destroy();}
        with(_effect) instance_destroy();with(_pickup) instance_destroy();
        with(_pause) instance_destroy();with(_back) instance_destroy();
        with(_thrown) instance_destroy();
    }
}

function scrFRRaceTestsViewInput() {
    var _state=global.fr_race_tests,_p=_state.players[0],_q=_state.players[1];
    var _a=_p.index,_b=_q.index,_index=global.index;
    var _directions=[KeyCont.dir_fire[_a],KeyCont.dir_fire[_b]],_distances=[KeyCont.dis_fire[_a],KeyCont.dis_fire[_b]];
    var _object=scrFRViewValue("object",_index),_pan=scrFRViewValue("pan",_index),_shake=scrFRViewValue("shake",_index);
    var _values=variable_global_exists("fr_view_values")?global.fr_view_values:undefined;
    var _samples=variable_global_exists("fr_input_samples")?global.fr_input_samples:undefined;
    var _frame=current_frame,_box=scrFRLetterbox();
    try {
        global.fr_input_samples=array_create(INPUT_MAX_PLAYERS,undefined);
        KeyCont.dir_fire[_a]=0;KeyCont.dis_fire[_a]=64;
        KeyCont.dir_fire[_b]=90;KeyCont.dis_fire[_b]=96;
        var _aimA=scrFRMousePoint(_a),_aimB=scrFRMousePoint(_b);
        scrFRRaceTestsCheck("per-player aim uses native touch/controller direction and distance",
            abs(_aimA[0]-(_p.x+64))<.001 && abs(_aimA[1]-_p.y)<.001
            && abs(_aimB[0]-_q.x)<.001 && abs(_aimB[1]-(_q.y-96))<.001);
        var _delta=scrFRMouseDelta(0,_a);
        current_frame+=1;KeyCont.dis_fire[_a]=72;
        scrFRRaceTestsCheck("source mouse delta has one stable sample per native frame",
            _delta==0 && scrFRMouseDelta(0,_a)==8 && scrFRMouseDelta(0,_a)==8);
        global.index=_a;
        scrFRViewSet("object",_a,_p);scrFRViewSet("pan",_a,.75);scrFRViewSet("shake",_a,3);
        scrFRViewSet("object",_b,_q);scrFRViewSet("pan",_b,.25);scrFRViewSet("shake",_b,7);
        scrFRRaceTestsCheck("active camera adapter writes native BackCont fields",
            BackCont.ntte_full_view_object==_p && BackCont.ntte_full_view_pan_factor==.75 && BackCont.shake==3);
        scrFRRaceTestsCheck("remote camera settings retain independent source slot values",
            scrFRViewValue("object",_b)==_q && scrFRViewValue("pan",_b)==.25 && scrFRViewValue("shake",_b)==7);
        scrFRRaceTestsCheck("source camera arrays read native shared camera coordinates",
            scrFRViewCoordinate(0,_a)==view_xview && scrFRViewCoordinate(1,_b)==view_yview);
        scrFRRaceTestsCheck("mobile menu pointer maps GUI extents to native camera extents",
            abs(scrFRMouseGuiToWorld(0,gui_w)-(view_xview+view_width))<.001
            && abs(scrFRMouseGuiToWorld(1,gui_h/2)-(view_yview+view_height/2))<.001);
        scrFRLetterbox(!_box);
        scrFRRaceTestsCheck("game_letterbox uses actual native boolean",scrFRLetterbox()==!_box);
    } finally {
        global.index=_index;current_frame=_frame;
        KeyCont.dir_fire[_a]=_directions[0];KeyCont.dir_fire[_b]=_directions[1];
        KeyCont.dis_fire[_a]=_distances[0];KeyCont.dis_fire[_b]=_distances[1];
        BackCont.ntte_full_view_object=_object;BackCont.ntte_full_view_pan_factor=_pan;BackCont.shake=_shake;
        global.fr_view_values=_values;global.fr_input_samples=_samples;scrFRLetterbox(_box);
    }
}

function scrFRRaceTestsCampfire() {
    var _state=global.fr_race_tests,_p=_state.players[0],_q=_state.players[1];
    var _before=scrNTTEFullInstances(all),_area=GameCont.area,_seed=random_get_seed();
    var _runs=scrFRRaceTestsSaveGet("bubbles_runs"),_shake=UberCont.opt_shake;
    var _chars=scrFRModGet("mod","campfire","chars"),_players_parked=false;
    try {
        scrFRRaceTestsCheck("source campfire initializes after its Bubbles race is visible",
            is_array(_chars) && array_contains(_chars,"bubbles")
            && scrFRModCallArray("race","bubbles","race_cf",[])
            && scrFRModCallArray("race","bubbles","race_cf_corpse",[]));
        scrFRRaceTestsCheck("native local co-op slots share a host UID",
            scrFRPlayerIsActive(_p.index) && scrFRPlayerIsActive(_q.index)
            && !is_undefined(scrFRPlayerUID(_p.index))
            && scrFRPlayerUID(_p.index)==scrFRPlayerUID(_q.index));

        // Run the original campfire helpers against a real native CampChar.
        // The selecting binding destroys itself at the end, as authored; do
        // not call it in FRWorld or the test driver's own lifetime scope.
        var _camp=scrFRModCallArray("mod","campfire","campchar_create",["bubbles",11400,11400]);
        scrFRModCallArray("mod","campfire","campchar_sprites",["bubbles"]);
        scrFRRaceTestsCheck("source campfire creates native Bubbles with all authored animation strips",
            instance_exists(_camp) && _camp.object_index==CampChar && _camp.race==19 && _camp.campfire_char
            && _camp.mask_index==mskPlayerMenu && _camp.sprite_index==scrFRRaceVar("sprCampfireMenu")
            && _camp.spr_noslct==scrFRRaceVar("sprCampfireMenu")
            && _camp.spr_slcted==scrFRRaceVar("sprCampfireSlct")
            && _camp.spr_slcting==scrFRRaceVar("sprCampfireTo")
            && _camp.spr_deslcting==scrFRRaceVar("sprCampfireFrom"));
        var _player_count=instance_number(Player),_binding;
        _camp.image_index=_camp.image_number-.01;
        _binding=instance_create(0,0,FRCustomObject);
        with(_binding) scrFRModCallArray("mod","campfire","campchar_select",[]);
        scrFRRaceTestsCheck("original campfire selection enters Bubbles transition without a false local co-op camera player",
            !instance_exists(_binding) && _camp.sprite_index==scrFRRaceVar("sprCampfireTo")
            && instance_number(Player)==_player_count && UberCont.opt_shake==_shake);
        _camp.image_index=_camp.image_number-.01;
        _binding=instance_create(0,0,FRCustomObject);
        with(_binding) scrFRModCallArray("mod","campfire","campchar_select",[]);
        scrFRRaceTestsCheck("original campfire selection completes the authored selected animation",
            !instance_exists(_binding) && _camp.sprite_index==scrFRRaceVar("sprCampfireSlct"));

        // Supply terrain for the source's own placement search around its
        // authored zero origin. The callback must create the corpse itself;
        // no corpse flags, sprites or completion fields are injected here.
        GameCont.area=area_campfire;
        for(var _yy=-192;_yy<=192;_yy+=32) for(var _xx=-192;_xx<=192;_xx+=32)
            instance_create(_xx,_yy,Floor);
        instance_create(0,0,CampfireOff);
        instance_deactivate_object(_p);instance_deactivate_object(_q);_players_parked=true;
        scrFRModCallArray("mod","campfire","level_start",[]);
        var _corpses=scrFRMatching(Corpse,"campfire_corpse",true);
        scrFRRaceTestsCheck("original loop campfire creates the actual Bubbles corpse with imported death artwork",
            array_length(_corpses)==1 && _corpses[0].sprite_index==scrFRRaceVar("sprDead",0)
            && _corpses[0].image_speed==0 && point_distance(_corpses[0].x,_corpses[0].y,0,0)>=16
            && point_distance(_corpses[0].x,_corpses[0].y,0,0)<=192);
        instance_activate_object(_p);instance_activate_object(_q);_players_parked=false;
        scrFRModCallArray("mod","campfire","level_start",[]);
        scrFRRaceTestsCheck("original campfire corpse excludes a currently living Bubbles player",
            array_length(scrFRMatching(Corpse,"campfire_corpse",true))==1);
        GameCont.area=_area;
        scrFRModCallArray("mod","campfire","level_start",[]);
        scrFRRaceTestsCheck("original campfire removes its corpse outside campfire without starting a Bubbles run",
            array_length(scrFRMatching(Corpse,"campfire_corpse",true))==0
            && scrFRRaceTestsSaveGet("bubbles_runs")==_runs);
    } finally {
        GameCont.area=_area;random_set_seed(_seed);UberCont.opt_shake=_shake;
        if(_players_parked) {instance_activate_object(_p);instance_activate_object(_q);}
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}

function scrFRRaceTestsGuardian() {
    var _state=global.fr_race_tests,_p=_state.players[0],_q=_state.players[1];
    var _before=scrNTTEFullInstances(all),_scale=timescale,_tick=FRWorld.logic_tick;
    var _visible=_p.visible,_direction=_p.direction;
    var _pet=instance_create(_p.x+96,_p.y+32,NTTEFullPet);
    with(_pet) {
        pet="Guardian";scrNTTEFullPetGuardianCreate();hp=max_hp;
        leader=_p;team=_p.team;visible=true;sprite_index=spr_idle;direction=37;
    }
    var _foreign=instance_create(_p.x+192,_p.y,NTTEFullPet);
    with(_foreign) {
        pet="Guardian";scrNTTEFullPetGuardianCreate();hp=max_hp;
        leader=_q;team=_q.team;visible=true;sprite_index=spr_idle;speed=20*timescale;
    }
    try {
        _p.visible=true;_p.direction=217;
        for(var _hz=30;_hz<=60;_hz+=30) {
            global.time_scale=30/_hz;
            FRWorld.logic_tick=true;
            _pet.speed=5*timescale;
            var _count=array_length(scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble"));
            // Enter the production Player -> owned Guardian -> Active path.
            // Directly invoking the source callback would conceal a missing
            // consumer hook or reversed Player/pet callback scope.
            with(_p) scrNTTEFullPetGuardianPlayerActive();
            scrFRRaceTestsCheck("Guardian "+string(_hz)+"Hz source speed threshold",
                array_length(scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble"))==_count);
            _pet.speed=6*timescale;
            with(_p) scrNTTEFullPetGuardianPlayerActive();
            var _bubbles=scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble");
            scrFRRaceTestsCheck("Guardian "+string(_hz)+"Hz actual owned-pet consumer emits once",
                array_length(_bubbles)==_count+1);
            if(array_length(_bubbles)>_count) {
                var _bubble=_bubbles[array_length(_bubbles)-1];
                scrFRRaceTestsCheck("Guardian "+string(_hz)+"Hz source other retains pet position/direction/team",
                    _bubble.x==_pet.x && _bubble.y==_pet.y && _bubble.team==_pet.team
                    && abs(angle_difference(_bubble.direction,_pet.direction))<=80
                    && _bubble.damage==5 && abs(_bubble.speed-3*timescale)<.001
                    && _bubble.lifeTime==75 && sprite_exists(_bubble.sprite_index)
                    && !is_undefined(_bubble.on_projectile) && !is_undefined(_bubble.on_step));
            }
            FRWorld.logic_tick=false;
            with(_p) scrNTTEFullPetGuardianPlayerActive();
            scrFRRaceTestsCheck("Guardian "+string(_hz)+"Hz render-only sample does not repeat source emission",
                array_length(scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble"))==_count+1);
        }
        FRWorld.logic_tick=true;
        var _count=array_length(scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble"));
        _p.visible=false;
        with(_p) scrNTTEFullPetGuardianPlayerActive();
        _p.visible=true;_pet.visible=false;
        with(_p) scrNTTEFullPetGuardianPlayerActive();
        _pet.visible=true;_pet.hp=0;
        with(_p) scrNTTEFullPetGuardianPlayerActive();
        scrFRRaceTestsCheck("Guardian invisible leader, hidden pet and dead pet remain filtered",
            array_length(scrFRMatching(FRCustomSlash,"name","bubbles_guardianBubble"))==_count);
    } finally {
        global.time_scale=_scale;FRWorld.logic_tick=_tick;
        _p.visible=_visible;_p.direction=_direction;
        var _after=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_after);++_i)
            if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false);
    }
}

function scrFRRaceTestsPets() {
    var _state=global.fr_race_tests,_p=_state.players[0],_q=_state.players[1];
    var _before=scrNTTEFullInstances(all),_existing_pets=scrNTTEFullInstances(NTTEFullPet);
    var _players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _pickups=scrNTTEFullAreaGeneratorSnapshot(WepPickup),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont);
    var _skill=scrFRSkillResolve("AugmentCompassion"),_owned=scrFRGetSkill(_skill),_seed=random_get_seed();
    var _cyber=scrFRModGet("area","cyberspace","settingCyberspaceEnabled");
    var _stats=["bubbles_kills","bubbles_loops","bubbles_time","bubbles_bubbles","bubbles_best_kills","bubbles_best_area"],_saved_stats=[];
    var _vars=["lastKills","lastLoop","lastTime","lastBubbles"],_saved_vars=[];
    for(var _i=0;_i<array_length(_stats);++_i) array_push(_saved_stats,scrFRRaceTestsSaveGet(_stats[_i]));
    for(var _i=0;_i<array_length(_vars);++_i) array_push(_saved_vars,scrFRRaceVar(_vars[_i]));
    // Keep any map-authored pets out of this isolated source-callback fixture.
    for(var _i=0;_i<array_length(_existing_pets);++_i) instance_deactivate_object(_existing_pets[_i]);
    try {
        var _fish=scrNTTEFullPetCreate(_q.x+32,_q.y,"Slaughter");_fish.leader=_q;_fish.team=_q.team;
        var _otherfish=scrNTTEFullPetCreate(_p.x+32,_p.y,"Slaughter");_otherfish.leader=_p;_otherfish.team=_p.team;
        var _unowned=scrNTTEFullPetCreate(_p.x+64,_p.y,"Slaughter");
        var _cuz=scrNTTEFullPetCreate(_p.x+96,_p.y,"Cuz");_cuz.leader=_p;_cuz.team=_p.team;
        with(_cuz) scrNTTEFullPetCuzStep();
        var _sourcepet=instance_create(_p.x+128,_p.y,FRCustomHitme);
        _sourcepet.name="NTTEPet";_sourcepet.pet="Fixture";_sourcepet.leader=noone;
        var _decoy=instance_create(_p.x+160,_p.y,FRCustomHitme);_decoy.name="fr_pet_selector_fixture";
        var _pets=scrFRMatching(FRCustomHitme,"name","NTTEPet");
        scrFRRaceTestsCheck("source pet tag includes native and genuine custom pets exactly once",
            array_length(_pets)==5 && array_contains(_pets,real(_fish.id)) && array_contains(_pets,real(_cuz.id))
            && array_contains(_pets,real(_sourcepet.id)) && !array_contains(_pets,real(_decoy.id)));
        scrFRRaceTestsCheck("source native-pet equivalence does not broaden generic or unrelated CustomHitme queries",
            !array_contains(scrFRInstances(FRCustomHitme),real(_fish.id))
            && !array_contains(scrFRMatching(FRCustomHitme,"name","fr_pet_selector_fixture"),real(_fish.id))
            && !array_contains(scrFRMatchingNE(FRCustomHitme,"name","NTTEPet"),real(_fish.id)));

        scrFRSetSkill(_skill,1);
        scrFRSkillHooks("step");
        var _drones=scrFRMatching(FRCustomSlash,"name","fr_compassiondrone");
        scrFRRaceTestsCheck("owned Hyperion source step attaches real native-pet drones",
            array_length(_drones)==3 && instance_exists(_fish.fr_augmentCompassion)
            && _fish.fr_augmentCompassion.owner==real(_fish.id)
            && _fish.fr_augmentCompassion.prevOwnerHealth==_fish.hp
            && instance_exists(_cuz.fr_augmentCompassion)
            && !instance_exists(_unowned.fr_augmentCompassion));
        scrFRSkillHooks("step");
        scrFRRaceTestsCheck("Hyperion source step retains one drone per owned native pet",
            array_length(scrFRMatching(FRCustomSlash,"name","fr_compassiondrone"))==array_length(_drones));

        with(_q) scrFRRaceCall("level_start");
        scrFRRaceTestsCheck("Bubbles B original level_start reskins only its own native Slaughter",
            (_fish[$ "fr_skeletonized"]??false) && is_array(_fish.bskin)
            && _fish.spr_idle==scrFRModGet("mod","Frontier_Objects","sprSlaughterBIdle")
            && !(_otherfish[$ "fr_skeletonized"]??false) && !(_unowned[$ "fr_skeletonized"]??false));
        var _late=scrNTTEFullPetCreate(_q.x+64,_q.y,"Slaughter");_late.leader=_q;_late.team=_q.team;
        scrFRModCallArray("mod","Frontier_Objects","SlaughterBSkinner_create",[_q.x,_q.y]);
        var _skinners=scrFRMatching(FRCustomObject,"name","fr_slaughterskinner");
        assert(array_length(_skinners)>0,"Authored Slaughter skin controller did not construct itself");
        with(_skinners[array_length(_skinners)-1]) scrFRActorCallback("on_step");
        scrFRRaceTestsCheck("authored Slaughter skin controller reaches newly adopted native pet",
            (_late[$ "fr_skeletonized"]??false) && _late.spr_idle==_fish.spr_idle
            && !(_otherfish[$ "fr_skeletonized"]??false));

        scrFRModSet("area","cyberspace","settingCyberspaceEnabled",true);
        GameCont.fr_visitedCyberspace=false;
        var _controllers=array_length(scrFRMatching(FRCustomObject,"name","fr_bluescreenController"));
        with(_p) scrFRModCallArray("area","cyberspace","cyberspace_revive",[index]);
        scrFRRaceTestsCheck("cyberspace source revive respects native Cuz retained leader slot",
            _cuz.leader_index==_p.index && !GameCont.fr_visitedCyberspace
            && array_length(scrFRMatching(FRCustomObject,"name","fr_bluescreenController"))==_controllers);
        var _controller=scrFRModCallArray("area","cyberspace","BluescreenController_create",[_p.x,_p.y]),
            _portals=scrNTTEFullInstances(Portal);
        scrFRModCallArray("area","cyberspace","bluescreen_accept",[_controller]);
        var _after=scrNTTEFullInstances(Portal),_portal=noone;
        for(var _i=0;_i<array_length(_after);++_i) if(!array_contains(_portals,_after[_i])) _portal=_after[_i];
        scrFRRaceTestsCheck("cyberspace original accept carries native pets into its real portal",
            instance_exists(_portal) && GameCont.area==scrFRAreaResolve("cyberspace")
            && _fish.x==_portal.x && _fish.y==_portal.y
            && _cuz.x==_portal.x && _cuz.y==_portal.y
            && _unowned.x==_portal.x && _unowned.y==_portal.y
            && _sourcepet.x==_portal.x && _sourcepet.y==_portal.y);
    } finally {
        scrFRSetSkill(_skill,_owned);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_pickups);scrNTTEFullAreaGeneratorRestore(_back);
        for(var _i=0;_i<array_length(_stats);++_i) scrFRRaceTestsSaveSet(_stats[_i],_saved_stats[_i]);
        for(var _i=0;_i<array_length(_vars);++_i) scrFRModSet("race","bubbles",_vars[_i],_saved_vars[_i]);
        scrFRModSet("area","cyberspace","settingCyberspaceEnabled",_cyber);
        var _after=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_after);++_i)
            if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false);
        for(var _i=0;_i<array_length(_existing_pets);++_i) instance_activate_object(_existing_pets[_i]);
        random_set_seed(_seed);
    }
}

function scrFRRaceTestsStart() {
    assert(scrFREnabled() && instance_exists(GameCont) && !instance_exists(GenCont),"Frontier race tests require a generated game");
    var _a=INPUT_MAX_PLAYERS-2,_b=INPUT_MAX_PLAYERS-1;
    assert(!instance_exists(scrFRPlayerFind(_a)) && !instance_exists(scrFRPlayerFind(_b)),"Race test slots already in use");
    global.fr_race_tests={done:false,ok:true,checks:[],phase:0,
        serial:scrFRLogicSerial(),first_id:real(instance_create(0,0,FRMarker)),
        indices:[_a,_b],old_instances:[global.playerinstance_list[_a],global.playerinstance_list[_b]],
        unlock:scrFRRaceTestsSaveGet("unlock_bubbles"),skin_unlock:scrFRRaceTestsSaveGet("unlock_bubbles_bskin"),
        runs:scrFRRaceTestsSaveGet("bubbles_runs"),ultras:scrNTTEFullArrayCopy(GameCont.ultra_got[19]),
        ultra_hud:scrNTTEFullArrayCopy(GameCont.ultra_hud),players:[],enemy:noone,
        last_time:scrFRRaceVar("lastTime"),last_kills:scrFRRaceVar("lastKills"),
        last_loop:scrFRRaceVar("lastLoop"),last_bubbles:scrFRRaceVar("lastBubbles")};
    var _state=global.fr_race_tests;
    scrFRRaceTestsClock();
    scrFRRaceUnlockSet(true);scrFRRaceUnlockSet(true,1);
    global.playerinstance_list[_a]=new PlayerInstance(_a);
    global.playerinstance_list[_b]=new PlayerInstance(_b);
    var _p=scrPlayerCreate(_a,19,0),_q=scrPlayerCreate(_b,19,1);
    global.playerinstance_list[_a].race=19;global.playerinstance_list[_b].race=19;
    _state.players=[_p,_q];
    _p.x=10016;_p.y=10016;_q.x=10272;_q.y=10016;
    with(_p) {hp=10000;max_hp=10000;lsthealth=10000;can_walk=false;can_spec=false;can_shoot=false;visible=false;}
    with(_q) {hp=10000;max_hp=10000;lsthealth=10000;can_walk=false;can_spec=false;can_shoot=false;visible=false;}
    var _enemy=instance_create(_p.x+6,_p.y,FRCustomEnemy);
    _enemy.hp=10000;_enemy.max_hp=10000;_enemy.meleedamage=6;
    _enemy.sprite_index=sprBanditIdle;_enemy.visible=false;_enemy.speed=0;
    // The passive uses bbox distance, not physical contact. Overlapping the
    // real native collision masks causes an actual melee hit and knockback,
    // correctly taking both entities out of the passive's ten-pixel range.
    _enemy.x=_p.bbox_right+9+(_enemy.x-_enemy.bbox_left);
    with(_enemy) assert(distance_to_object(_p)<10 && !place_meeting(x,y,_p),
        "Bubbles contact fixture must remain near without native melee knockback");
    _state.enemy=_enemy;
    scrFRRaceTestsObjectFamilies();scrFRRaceTestsViewInput();scrFRRaceTestsSelectMarkers();scrFRRaceTestsCampfire();scrFRRaceTestsGuardian();scrFRRaceTestsPets();
    scrFRRaceTestsCheck("Bubbles identity and native roster",Race.NUM_ALL_RACE_TYPES==20 && scrRaceGetNumericID("bubbles")==19 && scrRaceGetStringID(19)=="bubbles");
    scrFRRaceTestsCheck("canonical module race and skin references resolve to native identities",
        scrFRRaceResolve("race:bubbles")==19 && scrFRRaceResolve("race:fish")==Race.Fish
        && scrFRSkinResolve("skin:FreakFish")==207);
    scrFRRaceTestsCheck("Bubbles original availability",scr_race_is_unlocked(19) && scr_race_is_skin_unlocked(19,1));
    scrFRRaceTestsCheck("Bubbles native create",_p.race==19 && _p.bubbles_bubbleCharge==100 && _q.bubbles_bubbleCharge==100);
    scrFRRaceTestsCheck("Bubbles A/B body art",_p.spr_idle==scrFRRaceVar("sprIdle",0) && _q.spr_idle==scrFRRaceVar("sprIdle",1));
    scrFRRaceTestsCheck("Bubbles menus use original strips",sprite_get_number(scrNTTEFullSkinMenuSprite(19,0,sprBigPortrait))==2 && scr_race_get_skin_subimage(19,1)==1);
    scrFRRaceTestsCheck("Bubbles unlocked skin button art",scrNTTEFullSkinMenuSprite(19,1,sprLoadoutSkin)==scrFRRaceVar("sprSkinIcon",1));
    scrFRRaceTestsCheck("Bubbles voice",_p.snd_hurt==scrFRRaceVar("sndBubblesHurt"));
    scrFRRaceTestsCheck("Bubbles game_start once per new player",scrFRRaceTestsSaveGet("bubbles_runs")==_state.runs+2);
    var _runs=scrFRRaceTestsSaveGet("bubbles_runs");
    scrFRRaceEventAll("game_start");scrFRRaceEventAll("game_start");
    scrFRRaceTestsCheck("Bubbles repeated world notification does not restart",scrFRRaceTestsSaveGet("bubbles_runs")==_runs);
    _state.time_begin=scrFRRaceVar("lastTime");
    return _state;
}

function scrFRRaceTestsBehavior() {
    var _state=global.fr_race_tests,_p=_state.players[0],_q=_state.players[1];
    var _enemy=_state.enemy;
    var _contact={player:real(_p.id),enemy:real(_enemy.id),player_x:_p.x,player_y:_p.y,
        enemy_x:_enemy.x,enemy_y:_enemy.y,meleedamage:_enemy.meleedamage,
        base_contact_damage:_enemy[$ "base_contact_damage"]??undefined,
        reduced_enemies:_p.bubbles_reducedEnemies,ultra_a:scrFRUltraGet(19,1),
        ultra_b:scrFRUltraGet(19,2)};
    with(_p) _contact.nearest=instance_nearest(x,y,enemy);
    with(_enemy) _contact.distance=distance_to_object(_p);
    scrNTTESmokeLog("FRONTIER RACE CONTACT "+json_stringify(_contact));
    scrFRRaceTestsCheck("Bubbles natural Player EndStep contact passive",_enemy.meleedamage==4 && _enemy.base_contact_damage==6);
    var _elapsed=scrFRLogicSerial()-_state.serial,_time=scrFRRaceVar("lastTime")-_state.time_begin;
    scrFRRaceTestsCheck("Bubbles natural 30Hz step timer has no double dispatch",_time>=(_elapsed-1)*2/30-0.001 && _time<=(_elapsed+1)*2/30+0.001);
    var _idx=_p.index,_hold=KeyCont.hold_spec[_idx],_press=KeyCont.press_spec[_idx];
    try {
        KeyCont.hold_spec[_idx]=true;KeyCont.press_spec[_idx]=true;
        _p.can_spec=true;_p.bubbles_bubbleCharge=100;_p.bubbles_bubbleCooldown=0;
        var _before=scrFRRaceVar("lastBubbles");
        with(_p) scrFRRaceCall("step");
        scrFRRaceTestsCheck("Bubbles active drains charge from native input",_p.bubbles_bubbleCharge<100 && _p.bubbles_bubbleCharge>0);
        scrFRRaceTestsCheck("Bubbles active invokes original spray",scrFRRaceVar("lastBubbles")==_before+1);
        var _bubbles=scrFRMatching(FRCustomSlash,"name","bubbles_bubbleProjectile");
        scrFRRaceTestsCheck("Bubbles active builds original projectile",array_length(_bubbles)>0);
        KeyCont.hold_spec[_idx]=false;KeyCont.press_spec[_idx]=false;_p.can_spec=false;
        scrFRUltraSet(19,1,1);
        with(_p) scrFRRaceCall("step");
        var _orbitals=scrFRMatching(scrFRMatching(FRCustomSlash,"name","bubbles_ultraOrbital"),"ownerid",_p);
        scrFRRaceTestsCheck("Bubbles Ultra A creates exactly three owned orbitals",array_length(_orbitals)==3);
        scrFRRaceTestsCheck("Bubbles Ultra A native state and HUD",scr_ultra_get(19,1)==1 && array_contains(GameCont.ultra_hud,57));
        scrFRUltraSet(19,2,1);
        if(array_length(_bubbles)>0) {
            var _bubble=_bubbles[0],_shot=instance_create(_bubble.x,_bubble.y,EnemyBullet1);
            _shot.team=team_enemy;_shot.typ=1;_shot.speed=0;
            // Native collision scope gives on_projectile the actual other.
            with(_shot) with(_bubble) {
                scrNTTESmokeLog("FRONTIER RACE NULLIFY BEFORE "+json_stringify({
                    self_id:real(id),self_value:string(self),other_id:real(other.id),
                    scope_equals_self:id==self,scope_equals_self_id:id==self.id,
                    source_other:scrFROther(other),callback:string(on_projectile),
                    other_typ:other.typ,charges:ultra_b_charges,ultra:scrFRUltraGet(19,2)}));
                scrFRActorCallback("on_projectile");
            }
            scrNTTESmokeLog("FRONTIER RACE NULLIFY AFTER "+json_stringify({
                shot_exists:instance_exists(_shot),bubble_exists:instance_exists(_bubble),
                charges:_bubble[$ "ultra_b_charges"]??undefined}));
            scrFRRaceTestsCheck("Bubbles Ultra B absorbs hostile projectile",!instance_exists(_shot) && _bubble.ultra_b_charges==1);
            with(_bubble) instance_destroy();
            scrFRRaceTestsCheck("Bubbles Ultra B pop releases original burst",array_length(scrFRMatching(FRCustomProjectile,"name","bubbles_ProjectileBurst"))>0);
        }
        scrFRRaceTestsCheck("Bubbles Ultra art",sprite_exists(scrFRRaceUltraSprite(1)) && sprite_exists(scrFRRaceUltraSprite(2,true)));
        var _hp=_p.hp,_charge=_p.bubbles_bubbleCharge;
        scrFRPlayerSetSkin(_p.index,1);
        scrFRRaceTestsCheck("Bubbles skin change refreshes body without resetting ability",_p.spr_idle==scrFRRaceVar("sprIdle",1) && _p.hp==_hp && _p.bubbles_bubbleCharge==_charge);
        _p.bubbles_reducedEnemies=[987654321];_p.bubbles_bubbleCooldown=7;
        var _runs=scrFRRaceTestsSaveGet("bubbles_runs");
        with(_p) {scrFRRacePlayerAfterLoad();scrFRRaceEnsureGameStart();}
        scrFRRaceTestsCheck("Bubbles continue rebinds assets without starting run",_p.spr_idle==scrFRRaceVar("sprIdle",1) && _p.snd_hurt==scrFRRaceVar("sndBubblesHurt") && scrFRRaceTestsSaveGet("bubbles_runs")==_runs);
        scrFRRaceTestsCheck("Bubbles continue clears stale enemy IDs only",array_length(_p.bubbles_reducedEnemies)==0 && _p.bubbles_bubbleCharge==_charge && _p.bubbles_bubbleCooldown==7);
        with(_q) scrPlayerRaceChange(Race.Robot,0);
        for(var _skin=208;_skin<=211;++_skin) {
            scrFRPlayerSetSkin(_q.index,_skin);
            with(_q) scrFRSkinEnsureGameStart();
            var _key=scrFRSkinKey(_skin);
            scrFRRaceTestsCheck("hidden skin in-run transform "+_key,_q.bskin==_skin && _q.spr_idle==scrFRModGet("skin",_key,"sprIdle"));
            scrFRRaceTestsCheck("hidden skin identity roundtrip "+_key,scrFRSkinResolve(_key)==_skin && scrFRPlayerSkin(_q.index)==_key);
        }
        with(_q) scrPlayerRaceChange(Race.Fish,0);
        scrFRPlayerSetSkin(_q.index,207);
        scrFRRaceTestsCheck("FreakFish hidden in-run transformation",_q.bskin==207 && _q.spr_idle==scrFRModGet("skin","FreakFish","sprIdle"));
        with(_q) scrPlayerRaceChange(Race.Robot,208);
        _q.fr_skin_started_game=noone;
        with(_q) scrFRSkinEnsureGameStart();
        scrFRRaceTestsCheck("bluescreen new-run restores original Robot skin",_q.bskin==0 && _q.spr_idle==sprMutant8Idle);
        scrFRRaceTestsCheck("hidden transformation skins excluded from loadout",!array_contains(scrNTTEFullSkinSlots(Race.Robot),208) && !array_contains(scrNTTEFullSkinSlots(Race.Fish),207));
        scrFRRaceTestsCheck("optional turret skin is not falsely registered",!scrFRModLoaded("skin","turret"));
    } finally {
        KeyCont.hold_spec[_idx]=_hold;KeyCont.press_spec[_idx]=_press;
        _p.can_spec=false;
    }
    // Keep the original reduction tracking intact for a natural distance exit.
    _p.bubbles_reducedEnemies=[_enemy];_enemy.x+=400;
    _state.serial=scrFRLogicSerial();_state.phase=1;
}

function scrFRRaceTestsFinish() {
    var _state=global.fr_race_tests;
    if(instance_exists(_state.enemy)) {
        scrFRRaceTestsCheck("Bubbles leaving enemy restores contact damage",_state.enemy.meleedamage==6);
        instance_destroy(_state.enemy,false);
    }
    // These tests require an isolated case; remove only the source-owned
    // bubble projectiles born after this case started, with no death effects.
    with(FRCustomSlash) if(id>_state.first_id && string_pos("bubbles_",self[$ "name"]??"")==1) instance_destroy(id,false);
    with(FRCustomProjectile) if(id>_state.first_id && string_pos("bubbles_",self[$ "name"]??"")==1) instance_destroy(id,false);
    for(var _i=0;_i<array_length(_state.players);++_i) {
        var _p=_state.players[_i];if(instance_exists(_p)) instance_destroy(_p,false);
        global.playerinstance_list[_state.indices[_i]]=_state.old_instances[_i];
    }
    GameCont.ultra_got[19]=_state.ultras;GameCont.ultra_hud=_state.ultra_hud;
    scrFRRaceTestsSaveSet("unlock_bubbles",_state.unlock);
    scrFRRaceTestsSaveSet("unlock_bubbles_bskin",_state.skin_unlock);
    scrFRRaceTestsSaveSet("bubbles_runs",_state.runs);
    scrFRModSet("race","bubbles","lastTime",_state.last_time);
    scrFRModSet("race","bubbles","lastKills",_state.last_kills);
    scrFRModSet("race","bubbles","lastLoop",_state.last_loop);
    scrFRModSet("race","bubbles","lastBubbles",_state.last_bubbles);
    _state.done=true;
    return _state;
}

function scrFRRaceTestsStep() {
    var _state=global.fr_race_tests;
    if(_state.done || !scrFRReadyTick()) return _state;
    var _elapsed=scrFRLogicSerial()-_state.serial;
    if(_state.phase==0 && _elapsed>=6) scrFRRaceTestsBehavior();
    else if(_state.phase==1 && _elapsed>=2) return scrFRRaceTestsFinish();
    return _state;
}
