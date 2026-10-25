function scrNTTEFullTesseractArmNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),
        _source_state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection)
    if(is_struct(_source_state)) GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    try {
        current_frame=8
        var _arm=noone
        with(_owner) _arm=scrNTTEFullMergedBasicProjectileCreate(102000,102000,NTTEFullTesseractArmDeath,0,5.5)
        scrNTTESmokeLog("ARM CONSTRUCTOR DIAG "+json_stringify([
            instance_is(_arm,projectile),_arm.creator==_owner,_arm.team==_owner.team,
            _arm.sprite_index==scrNTTERefSprite("TesseractWeapon"),_arm.mask_index==mskExploder,
            _arm.damage==4,_arm.force==8,_arm.raddrop==16,_arm.typ==0,
            abs(_arm.friction-timescale*timescale/3)<=0.00001])
            +" owner="+string(_arm.creator)+" expected="+string(_owner)+" team="+string(_arm.team)
            +" expected="+string(_owner.team)+" sprite="+string(_arm.sprite_index)+" mask="+string(_arm.mask_index)
            +" damage="+string(_arm.damage)+" force="+string(_arm.force)+" rads="+string(_arm.raddrop)+" typ="+string(_arm.typ)
            +" friction="+string_format(_arm.friction,0,12)+" expected="+string_format(timescale*timescale/3,0,12))
        assert(instance_is(_arm,projectile) && _arm.creator==_owner && _arm.team==_owner.team
            && _arm.sprite_index==scrNTTERefSprite("TesseractWeapon") && _arm.mask_index==mskExploder
            && _arm.damage==4 && _arm.force==8 && _arm.raddrop==16 && _arm.typ==0
            && abs(_arm.friction-timescale*timescale/3)<=0.00001,
            "Tesseract detached arm lost source actual projectile/defaults/ownership")
        var _strike=noone
        with(_owner) _strike=scrNTTEFullMergedBasicProjectileCreate(102016,102000,NTTEFullTesseractStrike)
        _arm.strike=_strike;_arm.image_angle=73
        with(_arm) event_perform(ev_step,ev_step_normal)
        assert(_strike.xstart==_arm.x && _strike.ystart==_arm.y && _strike.image_angle==73,
            "Detached arm failed to hold its genuine active warning strike")
        var _enemy=instance_create(102032,102000,NTTEFullRedSpider),_hp=_enemy.hp
        _enemy.team=_arm.team;_enemy.nexthurt=0
        with(_enemy) with(_arm) event_perform(ev_collision,hitme)
        assert(_enemy.hp==_hp,"Detached CustomProjectile outer team gate damaged friendly enemy")
        _enemy.team=team_enemy;_enemy.nexthurt=current_frame+1
        with(_enemy) with(_arm) event_perform(ev_collision,hitme)
        assert(_enemy.hp==_hp,"Detached arm source melee immunity gate ignored enemy iframe")
        _enemy.nexthurt=0
        with(_enemy) with(_arm) event_perform(ev_collision,hitme)
        assert(_enemy.hp==_hp-4 && _enemy.nexthurt==current_frame+6,
            "Detached arm actual collision omitted source4damage/8force/authored hurt")
        var _wall=instance_create(102048,102000,Wall),_floor_count=instance_number(FloorExplo),_speed=_arm.speed
        with(_wall) with(_arm) event_perform(ev_collision,Wall)
        assert(!instance_exists(_wall) && instance_number(FloorExplo)==_floor_count+1
            && abs(_arm.speed-_speed*0.95)<=0.0001,"Detached arm actual wall callback lost95%speed/wall->FloorExplo")
        _surface=surface_create(64,64);_camera=camera_create_view(_arm.x-32,_arm.y-32,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_arm) event_perform(ev_draw,0)
        surface_reset_target()
        var _rads=instance_number(Rad)+10*instance_number(BigRad),_count=instance_number(NTTEFullRedExplosion),
            _chunks=instance_number(NTTEFullCatDoorDebris)
        _strike.ammo=4;_strike.ntte_strike_alarm=30;_arm.speed=0
        with(_arm) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_arm) && instance_number(NTTEFullRedExplosion)==_count+1
            && instance_number(NTTEFullCatDoorDebris)==_chunks+10
            && instance_number(Rad)+10*instance_number(BigRad)>=_rads+16
            && _strike.ammo==1 && _strike.ntte_strike_alarm==3,
            "Detached arm final slow-speed explosion lost ten real fragments/16rads/warning trigger")
        var _explosion=noone
        with(NTTEFullRedExplosion) if(array_get_index(_before,id)<0) _explosion=id
        assert(instance_exists(_explosion) && _explosion.mask_index==mskPopoPlasmaImpact
            && _explosion.team==_owner.team && _explosion.creator==_owner,
            "Detached arm final explosion lost source precise mask/team/ultimate creator")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        GameCont.ntte_full_source_seed=_source_state;random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL TESSERACT ARM: genuine5.5speed projectile/strict team+source iframe collision/4damage8force/actual wall->floor+95%speed/held real strike/flashDraw/slow-speed owned RedExplosion+16rads+10fragments/3tick strike activation OK @"+string(30/timescale))
}
