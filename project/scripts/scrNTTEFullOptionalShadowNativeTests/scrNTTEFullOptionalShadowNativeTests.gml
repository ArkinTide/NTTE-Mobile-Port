function scrNTTEFullOptionalShadowNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_seed=random_get_seed(),
        _draw=scrNTTEFullCoastDrawState(),_stop=lockstep_stop,
        _walls=global.lis_walls_visible,_vx=view_xview,_vy=view_yview,
        _parked=scrNTTEFullInstances([GenCont,hitme,chestprop,CampChar,CarThrow,CrownObject,CrownPickup,
            BigWeaponChest,SnowBotCar,BigDogExplo,CrystalShield,LilHunterFly,Yeti,SodaCan,RavenFly,
            NTTEFullGhost,NTTEFullBeetleChestOpen,NTTEFullCoastBoss]),_shadow=-1,_list=-1
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        GameCont.area=area_caves;GameCont.loops=0;GameCont.hard=0;lockstep_stop=false
        view_xview=0;view_yview=0
        _list=ds_list_create();global.lis_walls_visible=_list
        _shadow=surface_create(view_width,view_height);BackCont.shad=_shadow
        // The actual new Caves prop retains its source -1. This is the
        // reported route: the native hitme family enumerates the live prop.
        var _crystal=instance_create(32,32,NTTEFullBigCrystalProp),
            _palm=instance_create(64,32,NTTEFullPalm)
        assert(_crystal.spr_shadow==-1 && _palm.spr_shadow==-1,
            "Actual NTTE Caves/Coast constructors lost source no-shadow sentinel")
        assert(instance_is(_crystal,hitme) && instance_is(_palm,hitme),
            "Regression did not reach native hitme shadow enumeration")
        with(BackCont) event_perform(ev_step,ev_step_end)
        assert(surface_exists(_shadow) && _crystal.spr_shadow==-1 && _palm.spr_shadow==-1,
            "Actual BackCont End Step changed source no-shadow art")
        // Also exercise native dynamic chest shadow and a deleted runtime
        // sprite handle; the remaining valid native shadow must still render.
        var _chest=instance_create(96,32,WeaponChest),_bandit=instance_create(128,32,Bandit)
        _chest.spr_shadow=-1;_bandit.spr_shadow=shd24
        _crystal.visible=false;_palm.visible=false
        with(BackCont) event_perform(ev_step,ev_step_end)
        var _painted=false
        for(var _x=116;_x<141;++_x) for(var _y=24;_y<45;++_y)
            if(((int64(surface_getpixel_ext(_shadow,_x,_y))>>24)&255)>0) _painted=true
        assert(_painted,"Skipping absent shadows suppressed valid native enemy shadows")
        var _expired=sprite_duplicate(shd24)
        _chest.spr_shadow=_expired;sprite_delete(_expired)
        with(BackCont) event_perform(ev_step,ev_step_end)
        assert(!sprite_exists(_chest.spr_shadow) && _bandit.spr_shadow==shd24,
            "Expired optional shadow regression changed source actor data")
        // Genuine FirePit trap builds an invisible collision wall whose top
        // and outer art are both -1. Native shadow and wall-top passes must
        // preserve this source sentinel without attempting a sprite draw.
        var _trap=instance_create(192,80,NTTEFullTrapSpin),
            _wall=instance_position(_trap.x-8,_trap.y-8,Wall)
        assert(instance_exists(_wall) && _wall.outspr==-1 && _wall.topspr==-1,
            "Actual FirePit trap failed source invisible collision wall")
        ds_list_add(_list,_wall)
        with(BackCont) event_perform(ev_step,ev_step_end)
        var _sub=instance_create(0,0,SubTopCont)
        with(_sub) event_perform(ev_draw,0)
        assert(instance_exists(_wall) && _wall.outspr==-1 && _wall.topspr==-1,
            "Native wall/shadow drawing changed source FirePit collision geometry")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_draw.target);++_i) surface_reset_target()
        if(surface_exists(_shadow)) surface_free(_shadow)
        if(ds_exists(_list,ds_type_list)) ds_list_destroy(_list)
        global.lis_walls_visible=_walls
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        view_xview=_vx;view_yview=_vy;lockstep_stop=_stop;random_set_seed(_seed)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
    }
    scrNTTESmokeLog("OPTIONAL SHADOW: actual Caves BigCrystalProp/Coast Palm/native chest -1 and deleted sprite through real BackCont End Step, valid enemy shadow pixels retained OK @"+string(30/timescale))
}
