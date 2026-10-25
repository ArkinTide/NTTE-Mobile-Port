// crowns/crime.crown.gml + ntte.game_start crown-of-crime segment.
function scrNTTEFullCrimeAlert(_x,_y,_time,_blink) {
    var _target=noone,_distance=infinity
    with(CrownObject) if(visible && point_in_rectangle(x,y,_x-160,_y-128,_x+160,_y+128)) {
        var _d=point_distance(x,y,_x,_y)
        if(_d<_distance) { _distance=_d; _target=id }
    }
    if(!instance_exists(_target)) _target=instance_nearest(_x,_y,Player)
    if(!instance_exists(_target)) return []
    var _alerts=scrNTTEFullValue(_target,"ntte_crime_alert",[]),_valid=array_length(_alerts)==2
    for(var _i=0;_i<array_length(_alerts);++_i) _valid=_valid && instance_exists(_alerts[_i])
    if(!_valid) {
        for(var _i=0;_i<array_length(_alerts);++_i) if(instance_exists(_alerts[_i])) instance_destroy(_alerts[_i])
        _alerts=[scrNTTEAlertCreate(_target.x,_target.y,scrNTTERefSprite("CrimeBountyAlert"),_target),
            scrNTTEAlertCreate(_target.x,_target.y,scrNTTERefSprite("CrimeBountyFillAlert"),_target)]
        _target.ntte_crime_alert=_alerts
        _alerts[1].target_y=_alerts[0].target_y
        _alerts[0].flash=6; _alerts[1].flash=6
    }
    for(var _i=1;_i>=0;--_i) with(_alerts[_i]) {
        image_index=clamp(scrNTTEFullValue(GameCont,_i==0 ? "ntte_crime_active":"ntte_crime_bounty",0),0,image_number-1)
        image_speed=0; visible=true; depth=_i==0 ? -7:-9
        alert_sprite=-1; alert_age=0; alert_hold=_time; blink=_blink; alert_on=true; snd_flash=sndAppear
    }
    return _alerts
}

function scrNTTEFullCrimeAreaStart(_normal_area,_ambush_active,_spawn_x,_spawn_y) {
    if(scrNTTEFullCrownKey(GameCont.crown)!="crime") return;
    var _bounty=scrNTTEFullValue(GameCont,"ntte_crime_bounty",0)
    var _active=scrNTTEFullValue(GameCont,"ntte_crime_active",false)
    GameCont.ntte_crime_active=false
    if(_bounty>0 && _active && _normal_area) {
        GameCont.ntte_crime_enemy_count=_bounty
        GameCont.ntte_crime_enemy_delay=random_range(300,450)
        if(!_ambush_active) {
            var _alerts=scrNTTEFullCrimeAlert(_spawn_x,_spawn_y,120,30)
            for(var _i=0;_i<array_length(_alerts);++_i) _alerts[_i].snd_flash=sndSkillPick
        }
    }
    if(_bounty>0 && (!_active || _ambush_active)) {
        GameCont.ntte_crime_bounty=_ambush_active ? 0:max(0,_bounty-1)
        var _alerts=scrNTTEFullCrimeAlert(_spawn_x,_spawn_y,120,30)
        if(array_length(_alerts)==2) {
            var _old=scrNTTEAlertCreate(_spawn_x,_spawn_y,scrNTTERefSprite("CrimeBountyFillAlert"),_alerts[1].target)
            _old.target_y=_alerts[1].target_y; _old.image_index=clamp(_bounty,0,_old.image_number-1)
            _old.alert_sprite=-1; _old.depth=_alerts[1].depth+1
            _alerts[1].flash+=30; _alerts[1].snd_flash=sndIcicleBreak
        }
    } else scrNTTEFullCrimeAlert(_spawn_x,_spawn_y,90,10)
}

function scrNTTEFullCrimePool() {
    // Original weights and progression gates. Do not replace mod enemies with Gator.
    var _r=random(7+3*(GameCont.hard>=4)+3*(GameCont.hard>=6)+2*(GameCont.hard>=8))
    if(_r<5) return "Gator"
    _r-=5; if(_r<2) return "BabyGator"
    _r-=2
    if(GameCont.hard>=4) { if(_r<3) return "BuffGator"; _r-=3 }
    if(GameCont.hard>=6) { if(_r<3) return "BoneGator"; _r-=3 }
    return "AlbinoGator"
}

function scrNTTEFullCrimeStep() {
    // Original crown callbacks run only while this crown is equipped. Keep
    // queued bounty state dormant if the crown is replaced in a vault.
    if(!instance_exists(GameCont) || scrNTTEFullCrownKey(GameCont.crown)!="crime") return;
    if(instance_exists(GenCont) || instance_exists(LevCont)) return;
    if(scrNTTEFullValue(GameCont,"ntte_crime_enemy_delay",0)>0) {
        var _tick=GameCont.ntte_crime_enemy_delay<300
        if(!_tick) with(Player) {
            var _near=instance_nearest(x,y,enemy)
            if(instance_exists(_near) && !collision_line(x,y,_near.x,_near.y,Wall,false,false)) _tick=true
        }
        if(_tick) GameCont.ntte_crime_enemy_delay-=timescale
        if(instance_number(enemy)<8) GameCont.ntte_crime_enemy_delay=min(GameCont.ntte_crime_enemy_delay,30)
        return;
    }
    if(scrNTTEFullValue(GameCont,"ntte_crime_enemy_count",0)<=0) return;
    --GameCont.ntte_crime_enemy_count
    GameCont.ntte_crime_enemy_delay=random_range(120,180)
    var _dark=false
    with(TopCont) if(scrNTTEFullValue(id,"darkness",false)) _dark=true
    var _x=10016,_y=10016,_distance=_dark ? 8:160,_direction=random(360)
    var _anchor=instance_nearest(_x,_y,instance_exists(CrownObject) ? CrownObject:Player)
    if(instance_exists(_anchor)) {
        var _player=instance_nearest(_anchor.x,_anchor.y,Player)
        if(instance_exists(_player)) {
            _x=_player.x; _y=_player.y
            var _query_x=_x+orandom(96),_query_y=_y+orandom(96),_wall=noone,_best=infinity
            // Nearest bbox, matching telib.instance_nearest_bbox (not nearest origin).
            with(Wall) {
                var _dx=max(bbox_left-_query_x,0,_query_x-bbox_right)
                var _dy=max(bbox_top-_query_y,0,_query_y-bbox_bottom)
                var _d=_dx*_dx+_dy*_dy
                if(_d<_best) { _best=_d; _wall=id }
            }
            if(instance_exists(_wall)) _direction=point_direction(_x,_y,(_wall.bbox_left+_wall.bbox_right+1)/2,(_wall.bbox_top+_wall.bbox_bottom+1)/2)
        }
        var _notice=instance_create(_anchor.x+lengthdir_x(4,_direction),_anchor.y+8+lengthdir_y(4,_direction),BulletHit)
        _notice.sprite_index=sprAssassinNotice; _notice.image_angle=0
        _notice.hspeed=_anchor.hspeed; _notice.vspeed=_anchor.vspeed
        with(_notice) motion_add(_direction,2*timescale)
        _notice.friction=0.2*timescale*timescale; _notice.depth=-9
        repeat(3) {
            var _smoke=instance_create(_anchor.x,_anchor.y,Smoke)
            // Smoke can synchronously destroy itself when particles are disabled.
            if(instance_exists(_smoke)) {
                _smoke.image_xscale/=2; _smoke.image_yscale/=2
                _smoke.hspeed+=_anchor.hspeed/2; _smoke.vspeed+=_anchor.vspeed/2
            }
        }
        snd_play(sndIDPDNadeAlmost,0.8)
    }
    scrNTTEFullPortalPoof()
    for(var _i=0;_i<2;++_i) {
        var _name=scrNTTEFullCrimePool()
        var _top=scrNTTEFullTopCreate(_x,_y,_name,_i==0 ? _direction:random(360),_i==0 ? _distance:(_dark ? 0:-1))
        assert(instance_exists(_top),"Crime TopCreate returned no live wrapper for "+_name+" wave-index="+string(_i)+" result="+string(_top))
        _top.jump_time=1; _top.idle_time=0; _x=_top.x; _y=_top.y
        var _target=_top.target
        if(instance_exists(_target)) {
            if(_name=="BabyGator") repeat(1+irandom(1+GameCont.loops)) {
                var _baby=scrNTTEFullTopCreate(_target.x,_target.y,"BabyGator",random(360),-1)
                assert(instance_exists(_baby),"Crime sibling TopCreate returned no live BabyGator wrapper result="+string(_baby))
                _baby.jump_time=1
            }
            repeat(3) {
                var _dust=instance_create(_target.x+orandom(8),_target.y+orandom(8),Dust)
                // Coast sea / underwater / disabled particles can consume Dust in Create.
                if(instance_exists(_dust)) _dust.depth=_target.depth-1
            }
        }
        with(_top) if(_dark && place_meeting(x,y,Wall)) {
            z=0
            with(target) {
                motion_add(_direction+180,3*timescale)
                scrNTTESewerLook(_direction+180+orandom(30))
                if(alarm[1]>60) alarm[1]*=0.5
                snd_play(snd_dead,random_range(0.4,0.8),3)
            }
        }
    }
    if(_dark) {
        var _clear=instance_create(_x,_y,PortalClear)
        _clear.image_xscale=1/3; _clear.image_yscale=1/3
        with(_clear) motion_add(_direction+180,2.5*timescale)
    }
}
