function scrNTTEFullQualityConsumerPixels(_surface) {
    var _stride=max(1,floor(min(surface_get_width(_surface),surface_get_height(_surface))/64))
    for(var _y=0;_y<surface_get_height(_surface);_y+=_stride) for(var _x=0;_x<surface_get_width(_surface);_x+=_stride)
        if(((int64(surface_getpixel_ext(_surface,_x,_y))>>24)&255)>0) return 1
    return 0
}
function scrNTTEFullQualityConsumerState(_output,_label,_before) {
    assert(real(surface_get_target())==real(_output) && draw_get_color()==_before.color && draw_get_alpha()==_before.alpha,
        _label+" lost caller target/color/alpha: checks="+string([real(surface_get_target())==real(_output),draw_get_color()==_before.color,draw_get_alpha()==_before.alpha])
        +" target="+string_format(real(surface_get_target()),1,12)+" expected="+string_format(real(_output),1,12)
        +" color="+string(draw_get_color())+" expectedColor="+string(_before.color)
        +" alpha="+string_format(draw_get_alpha(),1,12)+" beforeAlpha="+string_format(_before.alpha,1,12)
        +" math_epsilon="+string_format(math_get_epsilon(),1,12))
}
function scrNTTEFullQualityConsumersNativeDrawTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_state=scrNTTEFullCoastDrawState(),
        _seed=random_get_seed(),_vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _override=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _graph={nodes:[]},_output=-1,_camera=-1,_p=instance_find(Player,0),
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,Bones,enemy,prop,chestprop,GenCont,Menu,NTTEDesertDecor,
            NTTEFullTopObject,NTTEFullPet,NTTEFullPetWebDraw,NTTEFullAnglerTrailDraw,NTTEFullRedWallShine,
            NTTEFullWallFakeController,NTTEFullWallFakeDrawBot,NTTEFullWallFakeDrawTop,
            NTTEFullWallFakeRevealBot,NTTEFullWallFakeRevealTop])
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_graph)
    var _progress={instances:[],containers:_graph.nodes}
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        GameCont.area=206;GameCont.subarea=1;GameCont.hard=0;GameCont.loops=0
        view_xview=300000;view_yview=300000;view_width=128;view_height=128
        _p.x=view_xview+40;_p.y=view_yview+40;_p.ntte_pet=[];_p.bskin=200;_p.roll=10;_p.visible=true
        _p.xprevious=_p.x-8;_p.yprevious=_p.y
        _output=surface_create(128,128);_camera=camera_create_view(view_xview,view_yview,128,128,0,noone,-1,-1,-1,-1)
        surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(c_blue,1)
        var _pickup=instance_create(view_xview+64,view_yview+80,WepPickup),
            _grounded=instance_create(_pickup.x,_pickup.y,NTTEFullWepPickupGrounded),
            _door=instance_create(view_xview+64,view_yview+64,NTTEFullCatDoor),
            _shield=instance_create(view_xview+80,view_yview+80,NTTEFullClamShield),
            _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Spider")
        _pickup.sprite_index=sprRadChest;_pickup.image_index=0
        _grounded.target=_pickup;_grounded.target_x=0;_grounded.target_y=96
        _grounded.image_xscale=1;_grounded.image_yscale=1;_grounded.image_angle=0
        _shield.creator=_p;_p.gunshine=0
        scrNTTEFullPetTake(_pet,_p)
        with(_pet) {web_list=[];scrNTTEFullPetSpiderWebAdd(x-24,y-24);scrNTTEFullPetSpiderWebAdd(x+24,y-24);scrNTTEFullPetSpiderWebAdd(x,y+24);}
        var _web=instance_find(NTTEFullPetWebDraw,0),_angler=instance_create(view_xview+96,view_yview+96,NTTEFullAngler)
        _angler.ntte_full_hiding=false;_angler.ntte_full_ammo=1;_angler.sprite_index=_angler.spr_idle
        _angler.visible=true;_angler.xprevious=_angler.x-6;_angler.yprevious=_angler.y
        scrNTTEFullAnglerTrailEnsure()
        var _trail=instance_find(NTTEFullAnglerTrailDraw,0),_wall=instance_create(view_xview+32,view_yview+56,NTTEFullWallFake),
            _fake=instance_find(NTTEFullWallFakeDrawBot,0),_shine=instance_find(NTTEFullRedWallShine,0)
        _wall.topspr=scrNTTERefSprite("WallRedTop");_wall.topindex=0;_wall.image_speed=0
        NTTEFullWallFakeController.ntte_wall_fake_reveal_visible=true;_p.red_wall_fake=1
        _shine.visible=true;_shine.ntte_shine_walls=[_wall];_shine.ntte_shine_tops=[];_shine.ntte_shine_wave=6.5
        draw_set_color(c_aqua);draw_set_alpha(0.7)
        var _draw_state=scrNTTEFullCoastDrawState()
        for(var _pass=0;_pass<2;++_pass) {
            variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:main",_pass)
            global.ntte_full_minor_quality=_pass==0?1.25:5.25
            var _main=scrNTTEFullVisualQuality("main"),_minor=global.ntte_full_minor_quality
            with(_grounded) scrNTTEFullGroundedWeaponDraw()
            scrNTTEFullQualityConsumerState(_output,"Grounded",_draw_state)
            assert(surface_get_width(_grounded.ntte_full_surface)==scrNTTEFullQualitySurfaceSize(64,_main)
                && scrNTTEFullQualityConsumerPixels(_grounded.ntte_full_surface)==0,"Grounded failed main quality or actual below-ground clipping")
            _grounded.target_y=-16
            with(_grounded) scrNTTEFullGroundedWeaponDraw()
            assert(scrNTTEFullQualityConsumerPixels(_grounded.ntte_full_surface)>0,"Grounded surface clipped its above-ground pickup")
            _grounded.target_y=96
            with(_door) event_perform(ev_draw,0)
            scrNTTEFullQualityConsumerState(_output,"CatDoor",_draw_state)
            assert(surface_get_width(_door.ntte_door_surface)==scrNTTEFullQualitySurfaceSize(2*max(abs(_door.sprite_width),abs(_door.sprite_height)),_main)
                && scrNTTEFullQualityConsumerPixels(_door.ntte_door_surface)>0,"CatDoor failed main quality/extruded cached layers")
            var _angle=_door.ntte_door_last_angle
            _door.ntte_full_open_angle+=0.5
            with(_door) event_perform(ev_draw,0)
            assert(_door.ntte_door_last_angle==_angle,"CatDoor lost source >1degree cache threshold")
            _door.ntte_full_open_angle+=2
            with(_door) event_perform(ev_draw,0)
            assert(_door.ntte_door_last_angle==_door.ntte_full_open_angle,"CatDoor failed actual opening cache refresh")
            with(_shield) event_perform(ev_draw,0)
            scrNTTEFullQualityConsumerState(_output,"ClamShield",_draw_state)
            var _num=_shield.image_number,_off=_num/7*_shield.image_xscale,
                _width=2*(_off+max(abs(_shield.sprite_height),abs(_shield.sprite_width)+ceil((_num-1)*2/3*_shield.image_xscale)))
            assert(surface_get_width(_shield.ntte_clam_surface)==scrNTTEFullQualitySurfaceSize(_width,_main)
                && scrNTTEFullQualityConsumerPixels(_shield.ntte_clam_surface)>0,"ClamShield failed main-quality real 3D/shine surface")
            var _angle=_shield.ntte_clam_last_angle
            _shield.image_angle+=0.5
            with(_shield) event_perform(ev_draw,0)
            assert(_shield.ntte_clam_last_angle==_angle,"ClamShield lost >1degree source cache threshold")
            _p.gunshine+=1
            with(_shield) event_perform(ev_draw,0)
            assert(_shield.ntte_clam_last_shine==_p.gunshine,"ClamShield failed shine-dependent cache refresh")
            with(_web) event_perform(ev_draw,0)
            scrNTTEFullQualityConsumerState(_output,"PetWeb",_draw_state)
            assert(surface_get_width(_web.ntte_web_surface)==scrNTTEFullQualitySurfaceSize(128,_main)
                && scrNTTEFullQualityConsumerPixels(_web.ntte_web_surface)>0,"PetWeb failed main quality/real triangle-mask tiled web")
            with(_trail) event_perform(ev_draw,0)
            scrNTTEFullQualityConsumerState(_output,"AnglerTrail",_draw_state)
            assert(surface_get_width(_trail.ntte_angler_trail)==scrNTTEFullQualitySurfaceSize(256,_minor)
                && scrNTTEFullQualityConsumerPixels(_trail.ntte_angler_trail)>0,"AnglerTrail failed minor quality/actual continuous enemy+rolling Fish stamps")
            with(_shine) scrNTTEFullRedWallShineDraw()
            scrNTTEFullQualityConsumerState(_output,"RedWallShine",_draw_state)
            assert(surface_get_width(_shine.ntte_shine_mask)==scrNTTEFullQualitySurfaceSize(256,_minor)
                && surface_get_width(_shine.ntte_shine_surface)==scrNTTEFullQualitySurfaceSize(128,_minor),"RedWallShine failed independent actual mask/sweep quality resize")
            with(_fake) event_perform(ev_draw,0)
            scrNTTEFullQualityConsumerState(_output,"RedWallFake",_draw_state)
            assert(surface_get_width(_fake.ntte_wall_fake_mask)==scrNTTEFullQualitySurfaceSize(256,_minor)
                && surface_get_width(_fake.ntte_wall_fake_surface)==scrNTTEFullQualitySurfaceSize(128,_minor)
                && _fake.ntte_wall_fake_scale==_minor,"RedWallFake failed minor mask/circle/screenshot scaling")
        }
        var _door_surface=_door.ntte_door_surface
        instance_destroy(_door)
        assert(!surface_exists(_door_surface),"CatDoor actual CleanUp leaked cached surface")
    }
    finally {
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_state.target);++_i) surface_reset_target()
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        if(surface_exists(_output)) surface_free(_output)
        if(_camera>=0) camera_destroy(_camera)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_progress)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh;global.ntte_full_minor_quality=_override;random_set_seed(_seed)
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("FULL QUALITY CONSUMERS actual7renderers/main+minor fractions5.25 resize/Grounded clipping/CatDoor+Clam source cache/Spider triangle web/Angler persistent trail+Fish/Red mask+shine+capture/caller state/real CatDoor cleanup OK @"+string(30/timescale))
}
