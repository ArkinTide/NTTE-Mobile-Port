function scrNTTEFullCrystalBrainNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _source_state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    if(is_struct(_source_state)) GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    try {
        GameCont.loops=0;GameCont.area=206;current_frame=8;_p.x=100160;_p.y=100000;_p.team=team_player
        var _brain=instance_create(100000,100000,NTTEFullCrystalBrain)
        scrNTTESmokeLog("BRAIN CONSTRUCTOR DIAG hp="+string(_brain.hp)+" max="+string(_brain.max_hp)
            +" rads="+string(_brain.raddrop)+" size="+string(_brain.size)+" melee="+string(_brain.meleedamage)
            +" clones="+string(_brain.clone_max)+" teleport="+string(_brain.teleport)+" corpse="+string(_brain.corpse)
            +" alarm="+string(_brain.ntte_brain_alarm)+" mask="+string(_brain.mask_index)+" expected="+string(mskBanditBoss)
            +" shadow="+string(_brain.spr_shadow)+" expected="+string(shd32)+" shadowy="+string(_brain.spr_shadow_y)
            +" friction="+string(_brain.friction)+" expected="+string(0.1*timescale*timescale))
        scrNTTESmokeLog("BRAIN CONSTRUCTOR BOOL DIAG "+json_stringify([
            _brain.hp==80,_brain.max_hp==80,_brain.raddrop==20,_brain.size==3,_brain.meleedamage==4,
            _brain.clone_max==3,!_brain.teleport,!_brain.corpse,_brain.ntte_brain_alarm==90,
            _brain.mask_index==mskBanditBoss,_brain.spr_shadow==shd32,_brain.spr_shadow_y==6,
            abs(_brain.friction-0.1*timescale*timescale)<=0.00001])
            +" friction_precise="+string_format(_brain.friction,0,12)+" diff="+string_format(abs(_brain.friction-0.1*timescale*timescale),0,12))
        assert(_brain.hp==80 && _brain.max_hp==80 && _brain.raddrop==20 && _brain.size==3
            && _brain.meleedamage==4 && _brain.clone_max==3 && !_brain.teleport && !_brain.corpse
            && _brain.ntte_brain_alarm==90 && _brain.mask_index==mskBanditBoss
            && _brain.spr_shadow==shd32 && _brain.spr_shadow_y==6
            && abs(_brain.friction-0.1*timescale*timescale)<=0.00001,
            "CrystalBrain actual constructor lost source health/clones/mask/shadow/friction/timer")
        _brain.speed=0;_brain.walk=0
        with(_brain) event_perform(ev_step,ev_step_normal)
        assert(abs(_brain.speed-0.4*timescale)<=0.0001,"CrystalBrain lost source minimum hover speed")
        _brain.speed=10*timescale
        with(_brain) event_perform(ev_step,ev_step_normal)
        assert(abs(_brain.speed-1.2*timescale)<=0.0001,"CrystalBrain lost source maximum hover speed")
        // First visible decision always clones: no existing clone weight.
        var _clone_count=instance_number(NTTEFullCrystalClone)
        with(_brain) event_perform(ev_alarm,1)
        assert(instance_number(NTTEFullCrystalClone)==_clone_count+1 && !_brain.teleport,
            "CrystalBrain visible first decision failed real clone controller or warped after cloning")
        var _clone=noone
        with(NTTEFullCrystalClone) if(creator==_brain) _clone=id
        assert(instance_exists(_clone) && _clone.team==_brain.team,"CrystalBrain clone lost creator/source team")
        // Actual clone constructor chooses a real enemy and copies native AI.
        var _source=instance_create(100032,100000,NTTEFullRedSpider)
        _clone.clone=[_source]
        with(_clone) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_clone.target) && instance_is(_clone.target,NTTEFullRedSpider)
            && _clone.target!=_source && _clone.target.hp==ceil(_source.hp/2),
            "Brain-owned actual clone failed native enemy copy/half-health source behavior")
        // Damaged brain uses genuine normal floors80..160px from its target,
        // excluding nearer exploded-floor children and real wall overlaps.
        var _normal=instance_create(100064,99984,Floor),_explo=instance_create(100128,99984,FloorExplo)
        _brain.hp=79;_brain.teleport=true;_brain.teleport_x=_brain.x;_brain.teleport_y=_brain.y
        _brain.sprite_index=_brain.spr_disappear;_brain.image_index=_brain.image_number-1
        with(_brain) event_perform(ev_step,ev_step_normal)
        assert(_brain.x==0 && _brain.y==0 && _brain.canfly,
            "Brain teleport did not move collision body off-map while retaining authored visual coordinates")
        with(_brain) event_perform(ev_alarm,1)
        assert(!_brain.teleport && !_brain.canfly && _brain.sprite_index==_brain.spr_appear
            && abs(_brain.x-(_normal.bbox_left+_normal.bbox_right)/2)<=0.008
            && abs(_brain.y-(_normal.bbox_top+_normal.bbox_bottom)/2)<=0.008,
            "Brain rematerialization lost source normal-floor distance filter/actual destination/appear artwork")
        // Kill through actual enemy destruction, then run every real15tick
        // death stage and inspect the final source corpse+pickup+rad chain.
        var _kills=GameCont.kills,_rads=instance_number(Rad)+9*instance_number(BigRad)
        _brain.hp=0;_brain.speed=3*timescale
        instance_destroy(_brain)
        assert(GameCont.kills==_kills+1,"Brain actual enemy death did not count precisely one kill")
        var _death=noone
        with(NTTEFullCrystalBrainDeath) if(array_get_index(_before,id)<0) _death=id
        assert(instance_exists(_death) && _death.raddrop==20 && _death.size==3
            && _death.speed==2*timescale && _death.ntte_brain_death_alarm==15 && _death.throes>=2 && _death.throes<=3,
            "Brain actual death lost staged object/inherited source fields/deferred rads")
        var _throes=_death.throes
        repeat(round(15/timescale)) with(_death) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_death) && _death.throes==_throes-1 && _death.sprite_index==-1,
            "Brain death first real logical15tick throe failed fragmentation")
        var _desperation=noone
        with(NTTEFullCrystalClone) if(creator==_death) _desperation=id
        assert(instance_exists(_desperation) && _desperation.time==150 && _desperation.team==_death.team,
            "Brain death throe omitted genuine150tick desperation clone")
        for(var _i=0;_i<array_length(_desperation.clone);++_i) assert(_desperation.clone[_i].size<3
            && is_undefined(scrNTTEFullValue(_desperation.clone[_i],"intro",undefined)),
            "Brain desperation clone included source size>=3/intro-gated enemy")
        _surface=surface_create(64,64);_camera=camera_create_view(_death.x-32,_death.y-32,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_death) event_perform(ev_draw,0)
        surface_reset_target()
        repeat(_throes) if(instance_exists(_death)) {
            repeat(round(15/timescale)) if(instance_exists(_death)) with(_death) event_perform(ev_step,ev_step_normal)
        }
        assert(!instance_exists(_death),"Brain death did not finish after all source15tick throes")
        var _corpse=noone
        with(Corpse) if(array_get_index(_before,id)<0 && sprite_index==scrNTTERefSprite("CrystalBrainDead")) _corpse=id
        assert(instance_exists(_corpse) && _corpse.image_index==3
            && instance_number(Rad)+9*instance_number(BigRad)>=_rads+20,
            "Brain final staged destruction omitted frame3 corpse/deferred20rads")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        GameCont.ntte_full_source_seed=_source_state
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL CRYSTAL BRAIN: source80HP/hover cap/real clone+native enemy copy/teleport normal-floor distance/appear art/staged real15tick throes/desperation clone/actual fragment Draw/final corpse+deferred20rads OK @"+string(30/timescale))
}
