function scrNTTEFullRedRenderOpaqueSamples(_surface) {
    var _count=0
    for(var _x=4;_x<256;_x+=8) for(var _y=4;_y<256;_y+=8)
        if(((int64(surface_getpixel_ext(_surface,_x,_y))>>24)&255)>0) {_count+=1}
    return _count
}
function scrNTTEFullRedWorldRenderNativeTests() {
    scrNTTEFullProjectileBloomNativeTests()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_tick=current_frame,_source_state=scrNTTEFullSourceSeedState(),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog(),_vx=129872,_vy=129872
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    try {
        GameCont.area=206;GameCont.loops=0;UberCont.opt_bossintro=false;current_frame=8
        var _boss=instance_create(130000,130000,NTTEFullTesseract)
        _boss.image_xscale=1.25;_boss.image_yscale=0.75;_boss.image_index=2
        _surface=surface_create(256,256);_camera=camera_create_view(0,0,256,256,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        draw_set_alpha(1);draw_set_color(c_white)
        scrNTTEFullWorldExtraShadowDraw(_vx,_vy)
        assert(scrNTTEFullRedRenderOpaqueSamples(_surface)>5,
            "Actual shadow dispatcher omitted source complete layered Tesseract Draw with empty spr_shadow")
        assert(_boss.x==130000 && _boss.y==130000 && _boss.image_xscale==1.25 && _boss.image_yscale==0.75,
            "Source full boss-shadow draw leaked temporary view-local position/0.9scale")
        // The parentless staged death requires the same layered Draw shadow.
        _boss.visible=false
        var _death=instance_create(130000,130000,NTTEFullTesseractDeath)
        _death.image_xscale=1.125;_death.image_yscale=0.875;_death.throes=1;_death.image_index=2
        draw_clear_alpha(c_black,0);scrNTTEFullWorldExtraShadowDraw(_vx,_vy)
        assert(scrNTTEFullRedRenderOpaqueSamples(_surface)>5 && _death.x==130000 && _death.y==130000
            && _death.image_xscale==1.125 && _death.image_yscale==0.875,
            "Actual parentless death shadow lost fragmented-layer geometry or failed position/scale restoration")
        surface_reset_target()
        // Actual world-space additive bloom invokes the original event for
        // portal and multi-layer heart-orb art, then restores source fields.
        var _portal=instance_create(130048,130000,NTTEFullWarpPortal),
            _orb=instance_create(129952,130000,NTTEFullCrystalHeartBullet),
            _slash=instance_create(130000,129952,NTTEFullRedSlash),_shank=instance_create(130000,130048,NTTEFullRedShank)
        _portal.image_xscale=0.6;_portal.image_yscale=0.7;_portal.image_alpha=0.8
        _orb.image_xscale=1.125;_orb.image_yscale=0.875;_orb.image_alpha=0.7
        camera_destroy(_camera);_camera=camera_create_view(_vx,_vy,256,256,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        scrDrawBloom()
        assert(scrNTTEFullRedRenderOpaqueSamples(_surface)>5 && _portal.image_xscale==0.6
            && _portal.image_yscale==0.7 && _portal.image_alpha==0.8 && _orb.image_xscale==1.125
            && _orb.image_yscale==0.875 && _orb.image_alpha==0.7,
            "Actual additive bloom omitted source Red entities or leaked scale/alpha into gameplay")
        surface_reset_target()
        // Source gray192px Tesseract halo and black64px core must remain
        // separate. Both callbacks are reached through the actual dispatcher.
        _boss.visible=true
        var _heart=instance_create(130000,130000,NTTEFullCrystalHeart)
        camera_destroy(_camera);_camera=camera_create_view(0,0,256,256,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        draw_set_alpha(1);draw_set_color(c_white)
        scrNTTEFullWorldDarkDraw(false,_vx,_vy)
        var _core=((int64(surface_getpixel_ext(_surface,228,128))>>24)&255)
        draw_clear_alpha(c_black,0);scrNTTEFullWorldDarkDraw(true,_vx,_vy)
        var _halo=((int64(surface_getpixel_ext(_surface,228,128))>>24)&255)
        assert(_core==0 && _halo>0,"Actual darkness passes lost source Tesseract64px core/192px gray halo")
        surface_reset_target()
        // Isolate the source CrystalHeart sinusoidal polygon in both passes.
        instance_destroy(_boss,false)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        scrNTTEFullWorldDarkDraw(false,_vx,_vy)
        assert(scrNTTEFullRedRenderOpaqueSamples(_surface)>1,
            "Actual native black darkness pass omitted source CrystalHeart15-vertex distorted opening")
        surface_reset_target()
    }
    finally {
        if(_surface>=0 && surface_get_target()==_surface) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog);gpu_set_blendmode(bm_normal)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_music)
        GameCont.ntte_full_source_seed=_source_state;random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL RED WORLD RENDER: actual extra-shadow dispatcher/layered boss+fragmented-death0.9shadow/view-local restore/actual additive native bloom/portal+heart-orb field restoration/Red melee+staged death glow/actual darkness64core192halo/CrystalHeart sinusoidal opening OK @"+string(30/timescale))
}
function scrNTTEFullProjectileBloomNativeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_actual=-1,_reference=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog()
    try {
        _actual=surface_create(128,128);_reference=surface_create(128,128)
        _camera=camera_create_view(193936,193936,128,128,0,noone,-1,-1,-1,-1)
        var _pellet=instance_create(194000,194000,NTTEVenomPellet),
            _empty=instance_create(194032,194032,BulletHit),
            _shell=instance_create(194032,193968,EnemyBullet3)
        _empty.sprite_index=-1
        scrNTTEFullPetTwinsTeam(_shell,team_player)
        assert(_shell.object_index==Bullet2 && variable_instance_exists(_shell,"bonus") && !_shell.bonus,
            "Reflected EnemyBullet3 lacks source explicit bonus=false for native shell/bloom callbacks")
        _shell.sprite_index=-1
        _pellet.image_index=1;_pellet.image_xscale=1.25;_pellet.image_yscale=0.75;_pellet.image_alpha=0.8
        surface_set_target(_actual);camera_apply(_camera);shader_reset();gpu_set_fog(false,0,0,0)
        draw_clear_alpha(c_black,0);scrDrawBloom();surface_reset_target()
        surface_set_target(_reference);camera_apply(_camera);draw_clear_alpha(c_black,0);gpu_set_blendmode(bm_add)
        with(_pellet) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha*0.2)
        gpu_set_blendmode(bm_normal);surface_reset_target()
        var _painted=0
        for(var _x=32;_x<96;_x+=2) for(var _y=32;_y<96;_y+=2) {
            var _a=surface_getpixel_ext(_actual,_x,_y),_r=surface_getpixel_ext(_reference,_x,_y)
            assert(_a==_r,"Venom additive bloom differs from authored0.2 pass or was drawn twice")
            if(((int64(_a)>>24)&255)>0) _painted++
        }
        assert(_painted>0 && _pellet.image_xscale==1.25 && _pellet.image_yscale==0.75 && _pellet.image_alpha==0.8,
            "Real small venom projectile bloom is empty or altered gameplay drawing fields")
        surface_save(_actual,working_directory+"ntte-venom-bloom-"+string(30/timescale)+".png")
        instance_destroy(_pellet,false)
        var _ball=instance_create(194000,194000,NTTEFullSmallLastBall)
        surface_set_target(_actual);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_ball) event_perform(ev_draw,0)
        scrDrawBloom();surface_reset_target()
        surface_set_target(_reference);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_ball) {
            draw_self();gpu_set_blendmode(bm_add)
            draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha*0.1)
        }
        gpu_set_blendmode(bm_normal);surface_reset_target()
        for(var _x=32;_x<96;_x+=2) for(var _y=32;_y<96;_y+=2)
            assert(surface_getpixel_ext(_actual,_x,_y)==surface_getpixel_ext(_reference,_x,_y),
                "SmallLastBall drew its source halo twice between native Draw and bloom")
    } finally {
        if(surface_get_target()==_actual || surface_get_target()==_reference) surface_reset_target()
        if(surface_exists(_actual)) surface_free(_actual)
        if(surface_exists(_reference)) surface_free(_reference)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog);gpu_set_blendmode(bm_normal)
        scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed)
    }
    scrNTTESmokeLog("PROJECTILE BLOOM actual dispatcher: venom pixel-equivalent source0.2, invalid sprite skipped, reflected shell bonus initialized @"+string(30/timescale))
}
