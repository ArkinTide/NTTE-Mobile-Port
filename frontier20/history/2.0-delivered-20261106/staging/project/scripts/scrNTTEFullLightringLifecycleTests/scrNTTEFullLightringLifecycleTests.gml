function scrNTTEFullLightringLifecycleTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),_skills=ds_list_create(),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),
        _projection=matrix_get(matrix_projection),_color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;current_frame=8
    try {
        _owner.x=94000;_owner.y=94000;_owner.team=team_player;_owner.gunangle=0;_owner.accuracy=0
        var _disc=noone
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc,0,10)
        assert(_disc.mask_index==mskWepPickup && _disc.sprite_index==sprLightning && _disc.depth==-3
            && _disc.image_xscale==0 && _disc.image_yscale==0 && _disc.ntte_full_charge==1
            && _disc.ntte_full_charge_speed==2 && _disc.ntte_full_segments==10 && _disc.ntte_full_shrink==1/160
            && _disc.ntte_full_maxspeed==2.5 && abs(_disc.ntte_full_rotation_speed)>=10
            && abs(_disc.ntte_full_rotation_speed)<=20 && _disc.ntte_full_super==-1,
            "Lightring actual source constructor lost zero-scale charge/segments/rotation/mask/motion")
        // Charging predicts logical motion, then subtracts raw physical motion
        // to compensate the native motion pass, and keeps previous at prediction.
        _disc.ntte_full_primary=false
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(abs(_disc.image_xscale-0.1*timescale)<0.0001 && _disc.image_yscale==_disc.image_xscale
            && abs(_disc.x-(_owner.x+10-10*timescale))<=0.008 && abs(_disc.xprevious-(_owner.x+10))<=0.008
            && abs(_disc.y-(_owner.y-4))<=0.008 && _owner.bwkick==5*_disc.image_xscale,
            "Lightring charge lost logical lead/raw stationary compensation/secondary recoil")
        _disc.image_xscale=1;_disc.image_yscale=1;_owner.wkick=2;_owner.bwkick=0
        with(_disc) event_perform(ev_step,ev_step_normal)
        var _empty=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullGunWarrantEmpty)
        assert(_disc.ntte_full_charge==0 && _owner.bwkick==-4 && _owner.wkick==2
            && array_length(_empty)==1 && _empty[0].sprite_index==sprGunWarrantDisappear
            && _empty[0].image_speed==0.4*timescale && _empty[0].image_angle==_disc.direction,
            "Lightring release lost source physical-slot recoil or true GunWarrantEmpty constructor")
        with(_empty[0]) event_perform(ev_other,ev_animation_end)
        assert(!instance_exists(_empty[0]),"GunWarrantEmpty lost original AnimationEnd destruction")
        // Source subtracts FT from logical speed without flooring at maxspeed.
        _disc.speed=2.6*timescale;_disc.ntte_full_shrink=0;_disc.ntte_full_enemy=true
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(abs(_disc.speed-(2.6-timescale)*timescale)<0.0001,
            "Lightring source slowdown gained minimum-speed clamp or wrong FT units")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc,0,10)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=1;_disc.image_yscale=1
        var _victim=instance_create(94140,94100,Bandit)
        _victim.team=team_enemy;_victim.hp=0;_victim.nexthurt=0
        var _x=_disc.x,_y=_disc.y,_hs=_disc.hspeed,_vs=_disc.vspeed,_fake=instance_number(NTTEFullTrenchLightning)
        current_frame=8+timescale
        with(_victim) with(_disc) event_perform(ev_collision,hitme)
        var _nodes=scrNTTEFullBubbleWeaponTestNew(_before,Lightning)
        assert(_disc.ntte_full_hits==1 && _victim.hp==0 && array_length(_nodes)>=1 && array_length(_nodes)<=3
            && abs(_disc.x-(_x-_hs/timescale))<=0.008 && abs(_disc.y-(_y-_vs/timescale))<=0.008
            && instance_number(NTTEFullTrenchLightning)==_fake,
            "Lightring source melee hit lost hp0 eligibility/logical backstep or real Lightning+Alarm0")
        for(var _i=0;_i<array_length(_nodes);++_i) assert(_nodes[_i].creator==_owner && _nodes[_i].team==team_player,
            "Lightring actual electrical field lost durable owner/team")
        // The source does not touch the target's iframe until lightning itself
        // collides, so two direct hit calls may emit two chains in one tick.
        with(_victim) with(_disc) event_perform(ev_collision,hitme)
        assert(_disc.ntte_full_hits==2,"Lightring invented private one-tick cooldown")
        _victim.nexthurt=current_frame+1000
        with(_victim) with(_disc) event_perform(ev_collision,hitme)
        assert(_disc.ntte_full_hits==2,"Lightring source melee gate ignored enemy iframe")
        _victim.nexthurt=0;_victim.team=team_player
        with(_victim) with(_disc) event_perform(ev_collision,hitme)
        assert(_disc.ntte_full_hits==2,"Lightring source melee gate hit friendly faction")
        _disc.ntte_full_enemy=true;_victim.team=team_enemy
        var _enemies=instance_number(EnemyLightning)
        with(_victim) with(_disc) event_perform(ev_collision,hitme)
        assert(_disc.ntte_full_hits==3 && instance_number(EnemyLightning)>_enemies,
            "Enemy Lightring source field failed actual EnemyLightning Alarm0")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=1;_disc.image_yscale=1
        _victim=instance_create(94124,94100,Bandit);_victim.team=team_enemy;_victim.hp=0;_victim.nexthurt=0
        var _neutral=instance_create(94110,94100,Bandit)
        _neutral.team=team_none;_neutral.hp=100
        var _did=false
        with(_disc) _did=scrNTTEFullLightningDiscRandomZap()
        assert(_did && _disc.ntte_full_hits==1,"Lightring random zap gained hp gate or selected neutral instead of full-array nearest enemy")
        // Actual wall collision destroys even InvisiWall directly, independent
        // of vanilla wall drop logic, using source reverse mask displacement.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc,0,2)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=2;_disc.image_yscale=2
        var _wall=instance_create(94100,94100,InvisiWall),_floors=instance_number(FloorExplo)
        with(_wall) with(_disc) event_perform(ev_collision,Wall)
        assert(!instance_exists(_wall) && instance_number(FloorExplo)>_floors,
            "Lightring source powerful wall collision retained InvisiWall or bypassed direct FloorExplo")
        // Both charging-big and release clear use reverse target masks, not a
        // guessed circle radius or modern WallDestroy exclusions.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=3;_disc.image_yscale=3
        _wall=instance_create(94100,94100,Wall)
        var _invisible=instance_create(94100,94100,InvisiWall),_reverse=false,_forward=false
        with(_wall) _reverse=place_meeting(x,y,_disc)
        with(_disc) _forward=place_meeting(x,y,_wall)
        scrNTTESmokeLog("LIGHTRING WALL DIAG "+json_stringify({ts:timescale,
            disc:[_disc.x,_disc.y,_disc.bbox_left,_disc.bbox_top,_disc.bbox_right,_disc.bbox_bottom,_disc.mask_index],
            wall:[_wall.x,_wall.y,_wall.bbox_left,_wall.bbox_top,_wall.bbox_right,_wall.bbox_bottom,_wall.mask_index],
            family:instance_is(_wall,Wall),invisible_family:instance_is(_invisible,Wall),
            walls:array_length(scrNTTEFullInstances(Wall)),forward:_forward,reverse:_reverse}))
        with(_disc) scrNTTEFullLightningDiscClearWalls(true)
        assert(!instance_exists(_wall) && instance_exists(_invisible),
            "Lightring big charge bbox/reverse-mask clear lost Wall-only family scope")
        // Force the authored near-split probability to1 by denominator.12<1;
        // unlike threshold destruction, this tests the actual instability FX
        // path and its unusual logical-speed minus raw-speed relation.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        current_frame=8
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc,0,4)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.ntte_full_enemy=true
        _disc.image_xscale=1.21;_disc.image_yscale=1.21;_disc.ntte_full_super=1.2;_disc.ntte_full_shrink=0
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_disc) && abs(_disc.speed-(4*timescale-timescale*timescale)*(1-0.02*timescale))<0.0001
            && _disc.image_xscale==1.21,
            "Super Lightring source near-split FX failed guaranteed chance or raw/logical speed displacement")
        // Super threshold destroys directly and splits five real discs; it
        // never emits the normal tiny-ring poof before the source split.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=1.2;_disc.image_yscale=1.2
        _disc.ntte_full_super=1.2;_disc.ntte_full_enemy=true
        var _hits=instance_number(LightningHit),_clear=instance_number(PortalClear)
        with(_disc) event_perform(ev_step,ev_step_normal)
        var _children=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullLightningDisc)
        assert(!instance_exists(_disc) && array_length(_children)==5
            && instance_number(LightningHit)==_hits && instance_number(PortalClear)==_clear+5,
            "Super Lightring source threshold gained normal poof or lost exact five native splits")
        for(var _i=0;_i<5;++_i) {
            var _child=_children[_i]
            assert(_child.creator==_owner && _child.team==team_player && !_child.ntte_full_follow
                && abs(_child.speed-10*timescale)<0.0001 && _child.ntte_full_super==-1
                && abs(_child.image_xscale-_child.ntte_full_charge*0.9)<0.0001,
                "Super Lightring BasicCreate split lost source owner/team/default child, instant charge or speed")
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(94100,94100,NTTEFullLightningDisc)
        _disc.ntte_full_setup=false;_disc.ntte_full_charge=0;_disc.image_xscale=0;_disc.image_yscale=0;_disc.ntte_full_enemy=true
        _hits=instance_number(LightningHit)
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_disc) && instance_number(LightningHit)==_hits+1,
            "Normal Lightring zero-scale Step lost source actual LightningHit poof")
        // Exercise the actual segmented Draw on a deterministic camera surface.
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(48,48,NTTEFullLightningDisc)
        _disc.image_xscale=2;_disc.image_yscale=2;_disc.image_index=1
        _surface=surface_create(96,96);_camera=camera_create_view(0,0,96,96,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0);gpu_set_fog(false,0,0,0)
        with(_disc) event_perform(ev_draw,0)
        surface_reset_target()
        var _pixels=0
        for(var _py=0;_py<96;++_py) for(var _px=0;_px<96;++_px)
            if(((surface_getpixel_ext(_surface,_px,_py)>>24)&255)>0) _pixels+=1
        assert(_pixels>0,"Lightring actual segmented native Draw produced no ring pixels")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL LIGHTRING LIFECYCLE: actual charge/logical+raw lead/release, source native melee/no-cache, true Lightning+EnemyLightning Alarm0/team/owner, array-nearest hp0 zap, explicit InvisiWall callback/Wall-family bbox clears, unclamped FT slow, super five-way split/no-normal-poof, cleanup and actual Draw pixels OK @"+string(30/timescale))
}
