function scrNTTEFullMergedRuntimeMountTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_seed=random_get_seed()
    try {
        var _p=instance_find(Player,0)
        _p.x=47000; _p.y=47000; _p.hspeed=0; _p.vspeed=0; _p.gunangle=0; _p.accuracy=0
        _p.race=Race.Fish; _p.wep=wep_revolver; _p.bwep=wep_shotgun; _p.wepangle=1; _p.wkick=0
        _p.infammo=0; _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _count=instance_number(Player),_at={creator:_p,wep:wep_super_bazooka,direction:0,accuracy:0},
            _shot=scrNTTEFullMergedRuntimePlayerMount(_p,_at,false)
        assert(_shot.actor==_p && instance_number(Player)==_count && _p.hspeed<0 && _p.wkick==12
            && _p.wep==wep_revolver && _p.bwep==wep_shotgun && _p.ammo[Ammo.Explosives]==100,
            "Merged firing mount lost real Player recoil/kick or restored unrelated equipped slot/ammo incorrectly")
        var _old_hs=_p.hspeed,_old_vs=_p.vspeed,_old_x=_p.x,_old_y=_p.y
        var _fixed=scrNTTEFullMergedRuntimePlayerMount(_p,{creator:_p,wep:wep_super_bazooka,x:47400,y:47300,direction:90,accuracy:0},false)
        assert(_p.x==_old_x && _p.y==_old_y && _p.hspeed==_old_hs && _p.vspeed==_old_vs && _p.gunangle==0,
            "Merged explicit coordinates did not restore source creator body/motion/aim after actual fire")
        var _state=scrNTTEFullMergedRuntimeAt(_p,{creator:_p,wep:[wep_wrench],position_distance:12,position_rotation:90,direction_rotation:30,accuracy:2,team:team_enemy}),
            _mount=scrNTTEFullMergedRuntimeMountBegin(_state)
        assert(_p.wep==wep_wrench && _p.gunangle==30 && _p.x==_old_x && _p.y==_old_y-12 && _p.team==team_enemy,
            "Merged source mount resolved positional offset after aim rotation or lost same-slot weapon override")
        _p.wep=wep_screwdriver; _p.accuracy=4
        scrNTTEFullMergedRuntimeMountEnd(_mount)
        assert(_state.wep[0]==wep_screwdriver && _p.wep==wep_revolver && _p.accuracy==0 && _p.team==team_player,
            "Merged mutable weapon reference/relative accuracy/source team restoration failed")
        // Previous-position change signals intentional actual creator teleport;
        // the source mount must retain it instead of blindly restoring body.
        var _teleport=scrNTTEFullMergedRuntimeAt(_p,{creator:_p,x:47500,y:47500,wep:wep_wrench}),
            _mounted=scrNTTEFullMergedRuntimeMountBegin(_teleport)
        _p.x+=64; _p.xprevious=_p.x
        scrNTTEFullMergedRuntimeMountEnd(_mounted)
        assert(_p.x==47564,"Merged mount erased intentional creator teleport signaled through xprevious")
        _p.x=47000; _p.y=47000; _p.xprevious=_p.x; _p.yprevious=_p.y; _p.gunangle=0
        var _burst_shot=scrNTTEFullMergedRuntimePlayerMount(_p,{creator:_p,wep:wep_assault_rifle,position_distance:12,direction_rotation:30,accuracy:0},false),
            _burst=noone
        for(var _i=0;_i<array_length(_burst_shot.shots);++_i) if(instance_exists(_burst_shot.shots[_i])
            && instance_is(_burst_shot.shots[_i],projectileburst)) _burst=_burst_shot.shots[_i]
        assert(instance_exists(_burst) && _burst.creator==_p && _burst.ntte_merged_runtime_at==_burst_shot.at
            && _burst.alarm[0]>=2,"Merged actual Burst failed source mount capture/real creator/increased initial firing delay")
        _p.x=47100; _p.y=47200; _p.gunangle=90
        var _bullets=scrNTTEFullInstances(Bullet1)
        with(_burst) event_perform(ev_alarm,0)
        var _new=scrNTTEFullInstances(Bullet1),_delayed=noone
        for(var _i=0;_i<array_length(_new);++_i) if(array_get_index(_bullets,_new[_i])<0) _delayed=_new[_i]
        assert(instance_exists(_delayed) && _delayed.creator==_p && _p.x==47100 && _p.y==47200 && _p.gunangle==90,
            "Merged actual Burst wrapped event lost live Player creator or failed temporary mount restoration")
        assert(abs(_burst.x-47100)*1000000<=1 && abs(_burst.y-47188)*1000000<=1
            && abs(angle_difference(_delayed.direction,120))<=2.001,
            "Merged actual deferred handler applied its barrel offset or aim rotation twice")
        var _anchor=scrNTTEFullActorFiringAnchor(_burst)
        assert(abs(_anchor.x-47100)*1000000<=1 && abs(_anchor.y-47188)*1000000<=1
            && scrNTTEFullActorFiringAngle(_burst)==120,
            "Merged actual deferred controller mount froze source position/aim instead of following live creator")
        var _laser=scrNTTEFullMergedRuntimePlayerMount(_p,{creator:_p,wep:wep_laser_cannon,x:48000,y:48000,direction:0,accuracy:0},false),_cannon=noone
        for(var _i=0;_i<array_length(_laser.shots);++_i) if(instance_exists(_laser.shots[_i]) && _laser.shots[_i].object_index==LaserCannon) _cannon=_laser.shots[_i]
        assert(instance_exists(_cannon) && _cannon.ntte_merged_runtime_at==_laser.at,"Merged actual LaserCannon was not captured as delayed source fire")
        _p.x=47150; _p.y=47250; _p.gunangle=180
        with(_cannon) event_perform(ev_alarm,0)
        assert(_p.x==47150 && _p.y==47250 && _p.gunangle==180 && _cannon.x==48016 && _cannon.y==48000,
            "Merged actual LaserCannon lost fixed coordinate/aim mount while restoring live creator")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players); scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED RUNTIME MOUNT: actual creator recoil/kick/slots/resources, explicit vs dynamic positions, mutable weapon refs, source teleport retention, native Burst/LaserCannon delayed capture/event remount/live aim and restoration OK @"+string(30/timescale))
}
