function scrNTTEFullPopoSecurityNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=0
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=62064;_p.y=62000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.hp=_p.max_hp;_p.speed=0;_p.can_shoot=true;_p.race=Race.Fish
        var _guard=scrNTTEFullWorldCreateRequired("PopoSecurity",62000,62000)
        assert(instance_is(_guard,enemy) && _guard.team==3 && _guard.hp==95 && _guard.max_hp==95
            && _guard.mask_index==mskLilHunter && _guard.size==2 && _guard.raddrop==0
            && _guard.ntte_security_decide==60 && _guard.ntte_security_fire==-1
            && _guard.wep_list[0]==scrNTTERefSprite("PopoSecurityMinigun")
            && _guard.wep_list[1]==scrNTTERefSprite("PopoSecurityCannon"),
            "PopoSecurity required factory lost actual native enemy, source95health/team3/mask/weapon slots/60tick delay")
        // Initial source delay expires at60 logical ticks, independent of FPS.
        repeat(round(59/timescale)) with(_guard) event_perform(ev_step,ev_step_normal)
        assert(abs(_guard.ntte_security_decide-1)<=0.00001 && _guard.freeze==0,
            "Security initial decision delay or idle full-health Player freeze changed with FPS")
        // Exact danger accumulation, including simultaneous wounded and reload.
        _guard.ntte_security_decide=100;_guard.ntte_security_fire=-1
        _p.hp-=1;_p.can_shoot=false
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(abs(_guard.freeze-4*timescale)<=0.00001,"Security wounded/reloading Player must add1+3 source danger per logical tick")
        _p.hp=_p.max_hp;_p.can_shoot=true
        _guard.walk=10;_guard.speed=0;_guard.direction=0;_guard.wkick=3
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(abs(_guard.speed-0.8*timescale*timescale)<=0.00001
            && abs(_guard.wkick-(3-timescale))<=0.00001,"Security source walk acceleration/recoil attenuation lost native timescale conversion")
        _guard.speed=10*timescale
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(abs(_guard.speed-2.5*timescale)<=0.00001,"Security source walk speed2.5 cap lost native conversion")
        _guard.walk=0;_guard.speed=0;_guard.wep_index=0;_guard.spr_weap=_guard.wep_list[0]
        _guard.target=_p;_guard.ammo=2;_guard.gunangle=0;_guard.queueswap=false
        var _shots=instance_number(NTTEFullVlasmaBullet),_trails=instance_number(PlasmaTrail),_origin=_guard.x
        with(_guard) scrNTTEFullPopoSecurityAttack()
        var _list=scrNTTEFullInstances(NTTEFullVlasmaBullet),_shot=_list[array_length(_list)-1],
            _expected=2*timescale+(1-timescale)*_guard.friction/2
        assert(instance_number(NTTEFullVlasmaBullet)==_shots+1 && _shot.object_index==NTTEFullVlasmaBullet
            && _shot.team==3 && _shot.creator==_guard && _shot.target==_guard
            && _shot.sprite_index==scrNTTERefSprite("PopoVlasmaBullet")
            && _shot.damage==2 && _shot.cannon==0 && _shot.speed==0
            && abs(_shot.x-(_origin+112))<0.01 && _shot.y==_p.y
            && _shot.target_x==_guard.x && _shot.target_y==_guard.y
            && abs(_guard.hspeed-_expected)<=0.00001 && _guard.wkick==8
            && _guard.ammo==1 && _guard.ntte_security_fire==5
            && instance_number(PlasmaTrail)>=_trails+2 && instance_number(PlasmaTrail)<=_trails+3,
            "Security minigun lost actual incoming blue Vlasma/guard-target/48overshoot, source team3 damage, FT forward2 or5tick cadence")
        // Native startup/flight must converge back on the guard's gun tip.
        with(_shot) {scrNTTEFullVlasmaAnim();event_perform(ev_step,ev_step_normal)}
        var _muzzle=sprite_get_width(_guard.spr_weap)-sprite_get_xoffset(_guard.spr_weap)
        assert(abs(_shot.target_x-(_guard.x+_muzzle))<0.01 && _shot.target_y==_guard.y
            && abs(_shot.speed-0.4*timescale*timescale)<=0.00001,
            "Security actual Vlasma failed source guard gun-tip convergence or genuine native acceleration")
        _guard.ammo=0
        with(_guard) scrNTTEFullPopoSecurityAttack()
        assert(_guard.ammo>=7 && _guard.ammo<=11 && _guard.ntte_security_fire==5,
            "Security minigun source8..12 round setup changed")
        _guard.wep_index=1;_guard.spr_weap=_guard.wep_list[1];_guard.ammo=0;_guard.speed=0
        var _cannons=instance_number(NTTEFullVlasmaCannon)
        _trails=instance_number(PlasmaTrail)
        with(_guard) scrNTTEFullPopoSecurityAttack()
        _list=scrNTTEFullInstances(NTTEFullVlasmaCannon);var _cannon=_list[array_length(_list)-1]
        _expected=4*timescale+(1-timescale)*_guard.friction/2
        assert(instance_number(NTTEFullVlasmaCannon)==_cannons+1 && _cannon.creator==_guard
            && _cannon.target==_guard && _cannon.team==3 && _cannon.damage==4 && _cannon.cannon==6
            && _cannon.sprite_index==scrNTTERefSprite("PopoVlasmaCannon")
            && _guard.ammo==0 && _guard.ntte_security_fire==-1
            && abs(_guard.hspeed-_expected)<=0.00001
            && instance_number(PlasmaTrail)>=_trails+4 && instance_number(PlasmaTrail)<=_trails+7,
            "Security source cannon lost actual six-child incoming Vlasma, team3, one-shot finish, FT forward4 or muzzle trails")
        var _swap=instance_number(WepSwap)
        _guard.queueswap=true
        with(_guard) scrNTTEFullPopoSecurityDecision()
        assert(_guard.wep_index==0 && _guard.spr_weap==_guard.wep_list[0] && !_guard.queueswap
            && _guard.swap_kick==1 && _guard.ntte_security_decide==10 && instance_number(WepSwap)==_swap+1,
            "Security queued swap lost other slot, weapon sprite,10tick delay or actual native WepSwap")
        // Actual Draw event, including hurt flash and either body depth order.
        var _surf=surface_create(96,96),_matrix=matrix_get(matrix_world)
        try {
            surface_set_target(_surf);draw_clear_alpha(c_black,0)
            matrix_set(matrix_world,matrix_build(48-_guard.x,48-_guard.y,0,0,0,0,1,1,1))
            _guard.sprite_index=_guard.spr_hurt;_guard.image_index=0;_guard.gunangle=270
            with(_guard) event_perform(ev_draw,0)
            _guard.gunangle=0;with(_guard) event_perform(ev_draw,0)
        }
        finally {matrix_set(matrix_world,_matrix);surface_reset_target();surface_free(_surf)}
        // Source death requests two actual elite portals and three portraits.
        // A real distant floor guarantees native IDPDSpawn.Create's placement
        // search terminates before source repositions the backup near the guard.
        instance_create(_p.x+128,_p.y,Floor)
        var _other=instance_create(_guard.x,_guard.y+32,NTTEFullPopoSecurity)
        _other.freeze=20
        var _van=instance_create(_guard.x,_guard.y,WantVan)
        assert(instance_exists(_van),"Security death fixture requires native WantVan in supported desert")
        _van.canspawn=false
        var _spawnCount=instance_number(IDPDSpawn),_alerts=instance_number(NTTEAlert)
        scrNTTEFullPickupDropInit();_guard.hp=0
        instance_destroy(_guard)
        assert(instance_number(IDPDSpawn)==_spawnCount+2 && instance_number(NTTEAlert)==_alerts+3
            && _other.freeze==120 && _van.canspawn,
            "Actual Security death lost two real elite backup portals,3portraits, nearby security freeze+100 or van unlock")
        var _spawns=scrNTTEFullInstances(IDPDSpawn),_observed=0
        for(var _i=0;_i<array_length(_spawns);++_i) if(array_get_index(_before,_spawns[_i])<0) {
            var _spawn=_spawns[_i]
            assert(_spawn.elite && !_spawn.freak,"Security real backup must be elite/nonfreak")
            var _portraits=scrNTTEFullInstances(NTTEAlert),_found=false
            for(var _j=0;_j<array_length(_portraits);++_j) if(_portraits[_j].target==_spawn) {
                var _a=_portraits[_j]
                assert(_a.sprite_index==scrNTTERefSprite("PopoEliteAlert")
                    && _a.alert_sprite==scrNTTERefSprite("AlertIndicatorPopo") && _a.alert_hold==_spawn.alarm[0]+15
                    && _a.blink==15 && _a.flash==10 && _a.alert_x==-5 && _a.alert_y==5,
                    "Security elite portrait lost actual target/indicator/native countdown plus15/source geometry")
                _found=true
            }
            assert(_found,"Security backup portal is missing its source elite portrait");_observed+=1
        }
        assert(_observed==2,"Security death fixture did not see exact two elite backups")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL POPO SECURITY NATIVE: real required enemy95hp/team3/60tick delay, source danger/walk, incoming blue minigun8..12/5ticks and6-child cannon, actual Draw/swap/death two elite portals and portraits/freeze/van OK @"+string(30/timescale))
}
