function scrNTTEFullElectroPlasmaTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
    try {
        current_frame=8;_owner.x=82000;_owner.y=82000;_owner.team=team_player
        var _shot=noone
        with(_owner) _shot=scrNTTEFullMergedBasicProjectileCreate(82100,82100,NTTEFullElectroPlasma,0,5)
        assert(_shot.damage==3 && _shot.knockback_speed==3*timescale && _shot.typ==2
            && _shot.mask_index==mskEnemyBullet1 && _shot.ntte_bloom==0.1 && _shot.depth==-3
            && abs(_shot.image_index-(1-0.4*timescale))<0.0001,
            "ElectroPlasma source constructor lost force/type/mask/bloom/animation")
        var _victim=instance_create(_shot.x,_shot.y+8,Bandit)
        _victim.team=team_enemy;_victim.hp=30;_victim.nexthurt=current_frame+1000
        _victim.speed=0;_victim.friction=0.2*timescale*timescale
        var _sx=_shot.x,_sy=_shot.y,_hs=_shot.hspeed,_vs=_shot.vspeed
        if(timescale<1) current_frame=8+timescale
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(_victim.hp==27 && abs(angle_difference(_victim.direction,270))<0.0001
            && abs(_victim.speed-(3*timescale+(1-timescale)*_victim.friction/2))<0.0001
            && abs(_shot.x-(_sx-_hs/timescale*0.8))<=0.008
            && abs(_shot.y-(_sy-_vs/timescale*0.8))<=0.008
            && abs(_shot.image_xscale-0.95)<0.0001,
            "ElectroPlasma actual hit gained frame/enemy-iframe gate, directional push, physical backstep or wrong shrink")
        _victim.hp=0;_shot.image_xscale=1;_shot.image_yscale=1
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(_victim.hp==0 && _shot.image_xscale==1,"Electro NP lost hp>0 gate")
        _victim.hp=30;_victim.team=_shot.team
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(_victim.hp==30 && _shot.image_xscale==1,"Electro NP hit friendly unit")
        _owner.team=team_enemy;_owner.hp=10;_owner.nexthurt=current_frame+1000
        with(_owner) with(_shot) event_perform(ev_collision,hitme)
        assert(_owner.hp==10 && _shot.image_xscale==1,"Electro NP ignored Player iframe")
        _owner.team=team_player
        var _wall=instance_create(82200,82100,InvisiWall)
        with(_wall) with(_shot) event_perform(ev_collision,Wall)
        assert(instance_exists(_wall) && abs(_shot.image_xscale-0.97)<0.0001,
            "Normal Electro wall hit gained phase gate or broke wall")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _shot=scrNTTEFullMergedBasicProjectileCreate(82100,82100,NTTEFullElectroPlasma,0,5)
        var _anchor=instance_create(82120,82100,Bandit)
        _anchor.hspeed=2*timescale;_anchor.vspeed=timescale
        _shot.ntte_full_tether_inst=_anchor;_shot.ntte_full_tether=0
        current_frame=8
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(!_shot.ntte_full_setup && abs(_shot.ntte_full_tether-0.2*timescale)<0.0001
            && abs(_shot.ntte_full_tether_x-(_anchor.x+_anchor.hspeed))<=0.008
            && abs(_shot.ntte_full_tether_y-(_anchor.y+_anchor.vspeed))<=0.008,
            "Source Electro setup/ramp or physical endpoint prediction changed")
        _shot.ntte_full_tether=1.01
        var _nodes=instance_number(NTTEFullTrenchLightning)
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(instance_number(NTTEFullTrenchLightning)>_nodes,"Established Electro tether produced no actual lightning")
        _anchor.x=_shot.x+500
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(_shot.ntte_full_tether==0,"Electro out-of-range tether failed untether")
        // Source no-anchor setup uses -1, separately from broken tether0.
        _shot.ntte_full_setup=true;_shot.ntte_full_tether_inst=noone
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(_shot.ntte_full_tether==-1,"Unlinked Electro setup failed source -1 sentinel")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _shot=scrNTTEFullMergedBasicProjectileCreate(82100,82100,NTTEFullElectroPlasmaBig,0,6)
        assert(_shot.damage==6 && _shot.knockback_speed==2*timescale && _shot.typ==1
            && _shot.ntte_full_big_zap==5 && _shot.ntte_full_big_friction==20,
            "Electro cannon constructor lost source damage/force/type/timers")
        _shot.ntte_full_big_zap=timescale;_shot.ntte_full_big_friction=timescale
        with(_shot) event_perform(ev_step,ev_step_normal)
        var _coils=scrNTTEFullInstances(NTTEFullTeslaCoil)
        assert(array_length(_coils)==1 && _coils[0].creator==_shot && _coils[0].damage==6
            && _coils[0].ntte_full_purple && _coils[0].ntte_full_offx==0
            && _coils[0].ntte_full_offy==0 && _coils[0].ntte_full_range==64
            && _shot.ntte_full_big_zap>=5 && _shot.ntte_full_big_zap<=10
            && _shot.ntte_full_big_friction==-1
            && abs(_shot.friction-0.3*timescale*timescale)<0.0001,
            "Cannon timers lost actual TeslaCoil owner/damage/range or logical friction")
        _wall=instance_create(82200,82100,InvisiWall)
        var _floors=instance_number(FloorExplo)
        with(_wall) with(_shot) event_perform(ev_collision,Wall)
        assert(!instance_exists(_wall) && instance_number(FloorExplo)>_floors,
            "Electro cannon wall failed direct FloorExplo replacement including InvisiWall")
        // Actual Destroy event must emit fifteen real balls, cyclic tether and
        // three true PlasmaImpact descendants, retaining inherited creator.
        instance_destroy(_shot)
        var _balls=scrNTTEFullInstances(NTTEFullElectroPlasma),_impacts=scrNTTEFullInstances(NTTEFullElectroPlasmaImpact)
        assert(array_length(_balls)==15 && array_length(_impacts)==3,
            "Cannon actual death lost source 5*3 ball fan or3 impacts")
        for(var _i=0;_i<15;++_i) {
            var _ball=_balls[_i]
            assert(_ball.creator==_owner && _ball.team==team_player
                && array_get_index(_balls,_ball.ntte_full_tether_inst)>=0
                && _ball.speed>=4*timescale && _ball.speed<=5.4*timescale,
                "Cannon death child lost BasicCreate owner/team/speed or actual cyclic link")
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _shot=scrNTTEFullMergedBasicProjectileCreate(82100,82100,NTTEFullElectroPlasma,0,0.2)
        _shot.friction=0.3*timescale*timescale
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_shot) && instance_number(NTTEFullElectroPlasmaImpact)==1,
            "Electro logical speed/friction lifetime changed at high physical frame rates")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _smokes=instance_number(Smoke),_impact=instance_create(82100,82100,NTTEFullElectroPlasmaImpact)
        assert(_impact.team==team_player && _impact.creator==noone && _impact.hitid==HitId.None
            && _impact.damage==2 && _impact.knockback_speed==8*timescale
            && _impact.mask_index==mskBullet1 && _impact.image_speed==0.4*timescale
            && instance_number(Smoke)==_smokes+3,
            "ElectroImpact lost exact original PlasmaImpact team/creator/force/Smoke constructor")
        _victim=instance_create(_impact.x,_impact.y+8,Bandit)
        _victim.team=team_enemy;_victim.hp=20;_victim.speed=0;_victim.nexthurt=0
        _victim.friction=0.2*timescale*timescale;_impact.direction=0
        current_frame=8+timescale
        with(_victim) with(_impact) event_perform(ev_collision,hitme)
        assert(_victim.hp==18 && abs(angle_difference(_victim.direction,0))<0.0001
            && abs(_victim.speed-(16*timescale-_victim.friction*(1/timescale-1)))<0.0001,
            "ElectroImpact inherited source directional FT8/speed_min16/phase-free hit changed")
        with(_victim) with(_impact) event_perform(ev_collision,hitme)
        assert(_victim.hp==18,"ElectroImpact original scrMeleeCanHit ignored target iframe")
        _victim.hp=0;_victim.nexthurt=0
        with(_victim) with(_impact) event_perform(ev_collision,hitme)
        assert(_victim.hp==-2,"ElectroImpact added hp>0 gate to original melee eligibility")
        with(_impact) event_perform(ev_other,ev_animation_end)
        assert(!instance_exists(_impact),"ElectroImpact lost original animation-end destruction")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL ELECTRO LIFECYCLE: actual NP/radialFT/logical backstep, wall shrink/direct replacement, setup/endpoint/ramp/arc/untether, native coil timers, cannon cyclic death/logical lifetime and original inherited PlasmaImpact constructor/melee/FT8/min16 OK")
}
