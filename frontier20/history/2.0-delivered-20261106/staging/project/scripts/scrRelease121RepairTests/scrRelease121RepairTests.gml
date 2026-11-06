function scrRelease121PlantHealingTests() {
    var _before=scrNTTEFullInstances(all);
    try {
        var _names=["PitcherPlant","GoldPitcherPlant"];
        for(var _i=0;_i<2;++_i) for(var _green=0;_green<2;++_green) {
            var _plant=scrUGCreate(52000+160*_i,52000+160*_green,_names[_i]);
            _plant.hp=_plant.max_hp-3;_plant.nextfire=current_frame;
            var _expl=instance_create(_plant.x,_plant.y,_green?GreenExplosion:Explosion);
            _expl.x=(_plant.bbox_left+_plant.bbox_right-1)/2;
            _expl.y=(_plant.bbox_top+_plant.bbox_bottom-1)/2;_expl.image_index=1;
            _expl.damage=7;_expl.team=_plant.team;_expl.creator=noone;
            var _effects=instance_number(UGPlantHeal);
            with(_plant) scrUGStep();
            assert(_plant.hp==_plant.max_hp && _plant.nextfire==current_frame+6,
                "Plant native Step failed same-team source explosion heal/clamp/cooldown "+string([_plant.hp,_plant.max_hp,_plant.nextfire,current_frame,lockstep_stop]));
            assert(instance_number(UGPlantHeal)==_effects+1,"Plant healing popup missing or duplicated");
            var _fx=instance_find(UGPlantHeal,instance_number(UGPlantHeal)-1);
            // Find by owner; effect lists can use a different native order.
            with(UGPlantHeal) if(creator==_plant) _fx=id;
            assert(_fx.creator==_plant && _fx.x==_plant.x && _fx.y==_plant.bbox_top
                && _fx.depth==_plant.depth-1 && _fx.sprite_index==(_green?sprUGHealFireUltra:sprUGHealFire),
                "Plant source healing art/origin/owner/depth lost");
            with(_plant) scrUGStep();
            assert(instance_number(UGPlantHeal)==_effects+1,"Plant ignored six-tick healing cooldown");
            with(_fx) event_perform(ev_other,ev_animation_end);
            assert(!instance_exists(_fx),"Healing effect leaked after its animation");
            _plant.hp=1;_plant.nextfire=current_frame;_expl.team=team_player;
            with(_plant) scrUGStep();
            assert(_plant.hp==1,"Plant healed from an opposing-team explosion");
            _expl.team=_plant.team;_expl.creator=_plant;
            with(_plant) scrUGStep();
            assert(_plant.hp==1,"Plant healed from its own explosion");
            instance_destroy(_expl,false);instance_destroy(_plant,false);
        }
        scrNTTESmokeLog("PASS Release121 real normal/gold plant native Step explosion heal, green art, source owner/origin, cooldown/team/self exclusions and finite effect @"+string(30/timescale));
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);}
}
function scrRelease121GoldStorageTests() {
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_queue=scrNTTEFullAreaGeneratorSnapshot(NTTEFullUnlockCont),
        _map=UberCont.saveData,_private=ds_map_create(),_progress=global.ntte_full_progress,
        _cache=scrNTTEFullValue(global,"ntte_full_loadout_weapon_cache",undefined),_dir=game_directory,_mywep=my_player.cwep,
        _scratch=working_directory+"gold121-"+string(get_timer())+"/";
    ds_map_copy(_private,_map);UberCont.saveData=_private;directory_create(_scratch);game_directory=_scratch;
    try {
        UberCont.custom=false;global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};
        global.ntte_full_loadout_weapon_cache={};
        save_set_value("achievement",string(Achievement.GOOD_FIND),1);
        var _p=instance_find(Player,0),_weapons=[wep_ntte_golden_trident,wep_ntte_golden_teleport_gun,wep_ntte_golden_tunneller];
        _p.race=Race.Fish;_p.bwep=wep_none;_p.extra_weps=[];
        for(var _i=0;_i<array_length(_weapons);++_i) {
            _p.wep=_weapons[_i];scrPlayerTryUnlockGoldenWeapons(_p);
            var _queued=array_length(NTTEFullUnlockCont.unlock),_data=scrNTTEFullUnlockGet("loadout:wep:"+string(Race.Fish)+":main");
            // The same carried raw weapon can acquire a native physical wrapper
            // and mutable state when firing, then lose pointer identity at load.
            _p.wep=scrNTTEFullWeaponNative({wep:_weapons[_i]});
            var _state=scrNTTEFullWeaponNativeState(_p.wep);_state.charge=19;_state.reload=7;
            repeat(3) {
                UberCont.saving=0;UberCont.draw_unlock=false;
                scrNTTEFullLoadoutWeaponGenerationStart();scrPlayerTryUnlockGoldenWeapons(_p);
                assert(UberCont.saving==0 && !UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued,
                    "Same NTTE golden raw-to-physical transition re-saved/notified at room start");
                assert(scrNTTEFullUnlockGet("loadout:wep:"+string(Race.Fish)+":main")==_data,
                    "Transient golden state overwrote its permanent starting template");
            }
            assert(scrNTTEFullProgressSave() && scrNTTEFullProgressLoad(),"Golden progress disk round-trip failed");
            global.ntte_full_loadout_weapon_cache={};
            _p.wep=scrNTTEFullWeaponNativeCopy(_p.wep);UberCont.saving=0;
            scrNTTEFullLoadoutWeaponGenerationStart();scrPlayerTryUnlockGoldenWeapons(_p);
            assert(UberCont.saving==0 && array_length(NTTEFullUnlockCont.unlock)==_queued,
                "Reloaded NTTE golden template used process identity for ownership");
        }
        var _first=scrNTTEFullWeaponMerge(wep_golden_machinegun,wep_golden_shotgun);
        _p.wep=scrNTTEFullWeaponNative(_first);scrPlayerTryUnlockGoldenWeapons(_p);
        var _queued=array_length(NTTEFullUnlockCont.unlock);
        _p.wep=scrNTTEFullWeaponNativeCopy(_p.wep);_first=scrNTTEFullWeaponModel(_p.wep);
        _first.temerge.fire_frame=999;_first.temerge.last_cost=9;UberCont.saving=0;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(UberCont.saving==0 && array_length(NTTEFullUnlockCont.unlock)==_queued,"Copied golden fusion cooldown caused repeated storage");
        scrNTTEFullWeaponSetMergedPart(_first,wep_golden_crossbow);
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(array_length(NTTEFullUnlockCont.unlock)==_queued+1,"A genuinely changed golden fusion failed its first stored notification");
        scrNTTESmokeLog("PASS Release121 three NTTE golds raw/physical/state/copy/disk reload room providers, transient fusion state and actual changed fusion notification @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_queue);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber);
        UberCont.saveData=_map;ds_map_destroy(_private);game_directory=_dir;my_player.cwep=_mywep;
        global.ntte_full_progress=_progress;global.ntte_full_loadout_weapon_cache=_cache;
    }
}
function scrRelease121BatchRenderTests() {
    var _before=scrNTTEFullInstances(all),_state=scrNTTEFullCoastDrawState(),_shader=shader_current(),
        _surface=-1,_camera=-1,_target=false,_buffer=-1;
    gpu_push_state();
    try {
        var _batch=instance_create_depth(56000,56000,8,DPDecorBatch),
            _sprites=[sprDetail1,sprDPDetailDesertB,sprDPDetailDesertMudB,sprDPDetailDesertMudBig,
                sprDPSnowFloorDesertB,sprDPDesertScorch,sprDPTrenchScorch];
        for(var _i=0;_i<array_length(_sprites);++_i) {
            var _spr=_sprites[_i];
            for(var _j=0;_j<sprite_get_number(_spr);++_j)
                array_push(_batch.dp_rows,{sprite:_spr,index:_j,x:56024+(_i%4)*56+(_j%3)*4,
                    y:56032+(_i div 4)*64+(_j div 3)*4,scale:(_j%2==0?1:-1),color:c_white,alpha:1});
        }
        with(_batch) scrDPBatchBuild();
        _surface=surface_create(256,192);_camera=camera_create_view(56000,56000,256,192,0,noone,-1,-1,-1,-1);
        _buffer=buffer_create(256*192*4,buffer_fixed,1);
        var _hashes=[];
        for(var _draw=0;_draw<3;++_draw) {
            if(_draw==2) with(_batch) scrDPBatchBuild(false);
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            draw_set_alpha(1);draw_clear_alpha(make_color_rgb(40,48,32),1);
            if(_draw==0) for(var _i=0;_i<array_length(_batch.dp_rows);++_i) {
                var _r=_batch.dp_rows[_i];draw_sprite_ext(_r.sprite,_r.index,_r.x,_r.y,_r.scale,1,0,_r.color,_r.alpha);
            } else with(_batch) scrDPBatchDraw();
            surface_save(_surface,working_directory+"ntte-detailsplus121-"+string(_draw)+"-"+string(30/timescale)+".png");
            surface_reset_target();_target=false;buffer_get_surface(_buffer,_surface,0);
            array_push(_hashes,buffer_md5(_buffer,0,buffer_get_size(_buffer)));
        }
        assert(_hashes[0]==_hashes[1] && _hashes[0]==_hashes[2],"Batched Details+ pixel output differs from native sprite frames/trim/flip/overlap "+string(_hashes));
        with(_batch) scrDPBatchBuild();
        var _groups=array_length(_batch.dp_groups);assert(_groups<array_length(_batch.dp_rows),"Static sprite draw calls were not coalesced");
        repeat(12) with(_batch) scrDPBatchBuild();
        assert(array_length(_batch.dp_groups)==_groups,"Batch rebuild accumulated buffers");
        instance_destroy(_batch,false);assert(!instance_exists(_batch),"Batch cleanup did not remove the renderer");
        scrNTTESmokeLog("PASS Release121 batched Details+ exact native pixel oracle across trimmed/flipped/multiframe/overlapping sprites; bounded buffers and cleanup @"+string(30/timescale));
    } finally {
        if(_target) surface_reset_target();if(surface_exists(_surface)) surface_free(_surface);
        if(_camera>=0) camera_destroy(_camera);if(buffer_exists(_buffer)) buffer_delete(_buffer);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}
function scrRelease121TerrainSignature() {
    var _rows=[];
    with(Wall) if(x>=60000) array_push(_rows,["Wall",x,y,sprite_index,image_index,visible,l,w,r,h]);
    with(FloorExplo) if(x>=60000) array_push(_rows,["FloorExplo",x,y,sprite_index,image_index]);
    with(TopSmall) if(x>=60000) array_push(_rows,["TopSmall",x,y,sprite_index,image_index]);
    for(var _i=0;_i<array_length(_rows);++_i) _rows[_i]=json_stringify(_rows[_i]);
    array_sort(_rows,true);
    return json_stringify(_rows);
}
function scrRelease121TerrainTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _list=global.lis_walls_visible,_fixture=ds_list_create();global.lis_walls_visible=_fixture;
    try {
        GameCont.area=area_desert;GameCont.underwater=false;
        for(var _case=0;_case<4;++_case) {
            var _signatures=[],_rng=[];
            for(var _oracle=0;_oracle<2;++_oracle) {
                random_set_seed(121086+_case);ds_list_clear(_fixture);
                for(var _xx=0;_xx<18;++_xx) for(var _yy=0;_yy<18;++_yy)
                    instance_create(60000+16*_xx,60000+16*_yy,Wall);
                instance_create(60032,60032,Floor);
                instance_create(60128+16*_case,60128+16*(_case%2),_oracle?TerrainBlastOracle121:FloorExplo);
                array_push(_signatures,scrRelease121TerrainSignature());array_push(_rng,random_get_seed());
                scrNTTEFullMergedRuntimeTestCleanup(_before);
            }
            assert(_signatures[0]==_signatures[1] && _rng[0]==_rng[1],
                "Local blast update changed native wall masks/visibility/geometry/RNG case "+string(_case));
        }
        scrNTTESmokeLog("PASS Release121 real FloorExplo constructors match independent original oracle wall geometry/visibility/masks/top tiles and RNG @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);random_set_seed(_seed);
        global.lis_walls_visible=_list;ds_list_destroy(_fixture);
    }
}
function scrRelease121MegaGrenadeTests() {
    var _before=scrNTTEFullInstances(all);
    try {
        var _grenade=scrUG_mega_grenade_launcher_MegaGrenade_create(62000,62000),
            _slash=instance_create(62000,62000,Slash);
        _grenade.team=team_enemy;_grenade.direction=180;_grenade.speed=2*timescale;
        _grenade.mask_index=mskPlayer;_slash.mask_index=mskPlayer;
        _slash.team=team_player;_slash.direction=0;_slash.image_angle=0;
        with(_grenade) scrUGStep();
        assert(instance_exists(_grenade) && _grenade.team==team_player && _grenade.direction==0,
            "Mega Grenade actual melee detection/deflection failed after GuitarSlash native mapping");
        scrNTTESmokeLog("PASS Release121 real Mega Grenade native Step melee reflection without missing-object access @"+string(30/timescale));
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);}
}
function scrRelease121PizzaRatInspect() {
    // Actual drain terrain is created on its first normal Step, after the
    // room-start watcher placement checked by the earlier spawn regression.
    with(NTTEFullSewerDrain) event_perform(ev_step,ev_step_normal);
    for(var _stage=0;_stage<2;++_stage) {
        with(NTTEFullTurtleCool) event_perform(ev_step,ev_step_end);
        with(Rat) event_perform(ev_step,ev_step_end);
        with(NTTEFullTurtleCool) if(ntte_full_become==Rat) {
            if(place_meeting(x,y,Wall) || place_meeting(x,y,InvisiWall) || !position_meeting(x,y,Floor))
                array_push(global.pizza121_invalid,{seed:global.ntte_pizza78_seed,stage:_stage,x:x,y:y,neutral:true});
        }
        with(Rat) if(place_meeting(x,y,Wall) || place_meeting(x,y,InvisiWall) || !position_meeting(x,y,Floor))
            array_push(global.pizza121_invalid,{seed:global.ntte_pizza78_seed,stage:_stage,x:x,y:y,neutral:false});
        if(_stage==0) with(NTTEFullTurtleCool) {ntte_full_patience=0;event_perform(ev_step,ev_step_normal);}
    }
}
function scrRelease121PizzaRatTests() {
    var _seed=random_get_seed(),_oldseed=global.seed,_rng=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    global.pizza121_invalid=[];global.ntte_pizza78_invalid=0;
    try {
        var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont);
        try {
            GameCont.area=scrNTTEFullAreaId("pizza");
            for(var _xx=-1;_xx<=1;++_xx) for(var _yy=-1;_yy<=1;++_yy)
                instance_create(64000+32*_xx,64000+32*_yy,Floor);
            // First native spawn is valid. Later entrance terrain and impact
            // motion can leave it embedded after its normal Step guard ran.
            for(var _kind=0;_kind<2;++_kind) {
                var _npc=instance_create(64016,64016,NTTEFullTurtleCool);
                _npc.ntte_full_become=Rat;_npc.xprevious=_npc.x;_npc.yprevious=_npc.y;
                var _wall=instance_create(_npc.x,_npc.y,_kind?InvisiWall:Wall),_hp=_npc.hp;
                with(_npc) assert(place_meeting(x,y,_wall),"Late-terrain negative control did not embed the rat");
                with(_npc) event_perform(ev_step,ev_step_end);
                with(_npc) assert(!place_meeting(x,y,Wall) && !place_meeting(x,y,InvisiWall)
                    && position_meeting(x,y,Floor) && hp==_hp,"Neutral Pizza rat did not recover without damage");
                with(_npc) {ntte_full_patience=0;event_perform(ev_step,ev_step_normal);}
                assert(instance_is(_npc,Rat) && _npc.ntte_full_pizza_watcher,"Pizza rat conversion lost its scoped collision guard");
                _npc.x=_wall.x;_npc.y=_wall.y;_npc.xprevious=_wall.x;_npc.yprevious=_wall.y;
                _hp=_npc.hp;with(_npc) event_perform(ev_step,ev_step_end);
                with(_npc) assert(!place_meeting(x,y,Wall) && !place_meeting(x,y,InvisiWall) && hp==_hp,
                    "Hostile Pizza rat remained embedded or was killed");
                var _ordinary=instance_create(_wall.x,_wall.y,Rat);
                with(_ordinary) event_perform(ev_step,ev_step_end);
                with(_ordinary) assert(place_meeting(x,y,_wall) && hp>0,"Scoped Pizza guard changed unrelated enemies");
                instance_destroy(_ordinary,false);instance_destroy(_wall,false);instance_destroy(_npc,false);
            }
        } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);}
        for(var _i=0;_i<16;++_i) {
            global.ntte_pizza78_seed=101013+97*_i;random_set_seed(global.ntte_pizza78_seed);
            scrNTTEFullPizzaNormalLifecycleSmoke(true,false,scrRelease121PizzaRatInspect);
            assert(instance_number(DPDecorBatch)==0 && instance_number(DPStaticDecor)==0 && instance_number(DPStatueDecor)==0,
                "Native area cleanup retained Details+ decorations from the old terrain");
        }
        assert(!array_length(global.pizza121_invalid),"Pizza rat blocked after actual drain terrain/conversion "+json_stringify(global.pizza121_invalid));
        scrNTTESmokeLog("PASS Release121 late-wall/impact neutral and hostile Pizza rat recovery, unrelated enemies retained;16 real generations plus first drain terrain and conversion @"+string(30/timescale));
    } finally {random_set_seed(_seed);global.seed=_oldseed;global.rng_state=_rng;}
}
