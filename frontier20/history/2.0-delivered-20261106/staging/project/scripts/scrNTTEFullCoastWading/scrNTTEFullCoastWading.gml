// areas/coast.area.gml461..916. Maintenance draft: integrate real draw-pass
// visibility hooks before enabling this source; water objects are deliberately
// hidden during ordinary engine drawing and drawn by the actual sea passes.
function scrNTTEFullCoastActive() {
    var _area=scrNTTEFullAreaId("coast")
    return scrNTTEFullValue(GameCont,"ntte_full_active_coast",false) && (GameCont.area==_area || GameCont.lastarea==_area)
}
// telib6383: nearest local listener, source inverse-distance emitter limits.
function scrNTTEFullCoastSoundAt(_x,_y,_sound,_pitch=1,_volume=1,_fade=64,_falloff=1) {
    if(variable_global_exists("ntte_full_coast_sound_observer") && is_array(global.ntte_full_coast_sound_observer))
        array_push(global.ntte_full_coast_sound_observer,{x:_x,y:_y,sound:_sound,pitch:_pitch,gain:_volume,fade:_fade,falloff:_falloff})
    if(!audio_exists(_sound) || scr_test_is_fps_uncapped()) return -1
    _sound=custom_sound_check(_sound)
    var _lx=view_xview+view_width/2,_ly=view_yview+view_height/2,_nearest=infinity
    with(Player) if(scr_player_is_local(index)) {
        var _distance=point_distance(x,y,_x,_y)
        if(_distance<_nearest) { _nearest=_distance; _lx=x; _ly=y }
    }
    audio_stop_sound(_sound)
    return audio_play_sound_at(_sound,_lx-_x,_ly-_y,0,_fade,320,_falloff,false,0,UberCont.opt_sndvol*_volume,0,_pitch)
}
function scrNTTEFullCoastWadingSetup() {
    if(!variable_instance_exists(id,"wading")) wading=0
    if(!variable_instance_exists(id,"wading_wave")) wading_wave=0
    if(!variable_instance_exists(id,"wading_sink")) wading_sink=0
    if(!variable_instance_exists(id,"canwade")) canwade=true
}
function scrNTTEFullCoastPickupInstances() {
    return scrNTTEFullInstances([Rad,BigRad,HPPickup,AmmoPickup,RogueAmmo,WepPickup,NTTEFullCustomPickup])
}
function scrNTTEFullCoastBeginStep() {
    if(!scrNTTEFullCoastActive()) { scrNTTEFullCoastVisible(true); return }
    if(instance_exists(Player)) {
        with(projectile) if(speed>0 && distance_to_object(Player)>1000 && distance_to_object(Floor)>1000) instance_destroy()
        with(Player) alarm[10]=max(alarm[10],90)
    }
    // A native RoomEnd can occur before the following EndStep. Dispose of a
    // stale support list before allocating this frame's actual collision floors.
    var _old=scrNTTEFullValue(GameCont,"ntte_coast_ultrabolt_floors",[])
    for(var _i=0;_i<array_length(_old);++_i) if(instance_exists(_old[_i])) instance_destroy(_old[_i],false)
    GameCont.ntte_coast_ultrabolt_floors=[]
    with(UltraBolt) if(!place_meeting(x,y,Floor)) {
        var _fix=instance_create(0,0,Floor)
        if(!instance_exists(_fix)) throw "Coast UltraBolt source support floor allocation failed"
        _fix.mask_index=sprBoltTrail; _fix.x=x; _fix.y=y; _fix.xprevious=x; _fix.yprevious=y
        _fix.visible=false; _fix.creator=id
        array_push(GameCont.ntte_coast_ultrabolt_floors,_fix)
    }
}
// Preserve the original native membership loops. The bucket experiment was
// withdrawn after real30/60 timing showed regressions at typical loads.
function scrNTTEFullCoastWadingStep() {
    // Run after actual projectiles' Step events; BeginStep's real native floor
    // must remain alive until UltraBolt has performed its floor collision.
    var _fixes=scrNTTEFullValue(GameCont,"ntte_coast_ultrabolt_floors",[])
    for(var _i=0;_i<array_length(_fixes);++_i) if(instance_exists(_fixes[_i])) instance_destroy(_fixes[_i],false)
    GameCont.ntte_coast_ultrabolt_floors=[]
    if(!scrNTTEFullCoastActive()) return;
    var _pickups=scrNTTEFullCoastPickupInstances(),_objects=scrNTTEFullInstances([hitme,projectile,Corpse,ChestOpen,chestprop,Debris])
    for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_objects,_pickups[_i])<0) array_push(_objects,_pickups[_i])
    for(var _i=0;_i<array_length(_objects);++_i) with(_objects[_i]) scrNTTEFullCoastWadingSetup()
    // Push actual damageable units, pickups and chests back to the islands.
    if(instance_exists(Floor)) {
        var _push=scrNTTEFullInstances([hitme,chestprop])
        for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_push,_pickups[_i])<0) array_push(_push,_pickups[_i])
        for(var _i=0;_i<array_length(_push);++_i) with(_push[_i]) {
            var _is_pickup=scrNTTEFullIsPickup(id),_is_chest=instance_is(id,chestprop),_is_hit=instance_is(id,hitme),
                _eligible=(_is_hit && visible && wading>=80) || (_is_pickup && wading>=80) || (_is_chest && wading>=192)
            if(!_eligible) continue
            var _near=instance_nearest(x,y,Portal),_portal_ok=!instance_exists(_near),_ordinary=false
            with(Portal) if(endgame<100) _ordinary=true
            var _player=instance_is(id,Player)
            if(!_portal_ok) _portal_ok=distance_to_object(Portal)>96 && (!_player || _ordinary)
            if(!_portal_ok || (_is_hit && (team==team_none || instance_is(id,prop)))) continue
            var _floor=instance_nearest(x-16,y-16,Floor),_dir=point_direction(x,y,_floor.x,_floor.y),
                _accel=_player ? (3+(wading-80)/16)*timescale*timescale:friction*3
            motion_add(_dir,_accel)
            if(_player && wading>120) {
                var _finished=false
                with(Portal) if(endgame>=100) _finished=true
                if(!_finished) {
                    var _distance=(wading-120)/10*timescale
                    x+=lengthdir_x(_distance,_dir); y+=lengthdir_y(_distance,_dir)
                    if(random(2)<timescale) instance_create(x,y,Dust)
                }
            }
        }
    }
    var _sea=scrNTTEFullInstances([Debris,Corpse,ChestOpen,chestprop,WepPickup,CrownObject,Grenade,hitme,NTTEFullClamShield])
    for(var _i=0;_i<array_length(_pickups);++_i) if(_pickups[_i].mask_index==mskPickup && array_get_index(_sea,_pickups[_i])<0)
        array_push(_sea,_pickups[_i])
    var _swimming=[]
    for(var _i=0;_i<array_length(_sea);++_i) with(_sea[_i]) {
        scrNTTEFullCoastWadingSetup()
        if(depth>20 || !visible || !canwade) continue
        var _distance=distance_to_object(Floor),_logical_speed=speed/timescale
        if(_distance>4 && depth>=-5) {
            if(wading<=0) {
                y+=2
                if(distance_to_object(Floor)<=4) y-=2
                repeat(irandom_range(4,8)) instance_create(x,y,NTTEFullSweat)
                scrNTTEFullCoastSoundAt(x,y,choose(sndOasisChest,sndOasisMelee),1.5+random(0.5))
            }
            wading=_distance; visible=false
            if(random(20)<min(_logical_speed,4)) with(instance_create(x,y,Dust))
                motion_add(other.direction+orandom(10),3*timescale)
            if(wading_sink) {
                wading_sink+=0.3*timescale
                if(wading>30) y+=0.3*timescale
                if(wading_sink>=abs(sprite_height) && !persistent) { instance_destroy(); continue }
            }
            else if(wading>sprite_height) {
                wading_wave+=0.1*(timescale+_logical_speed)
                var _bob=min(wading/sprite_height,2)*cos(wading_wave)/10*timescale
                if(speed==0) y+=_bob
                else if(instance_is(id,hitme)) {
                    if(!instance_is(id,Player) || !scr_skill_get(mut_extra_feet)) {
                        var _length=_bob*(1+1.5*_logical_speed),_dir=direction-90
                        x+=lengthdir_x(_length,_dir); y+=lengthdir_y(_length,_dir)
                    }
                }
                else y+=_bob*(1+1.5*_logical_speed)
            }
            else if(wading_wave) wading_wave=0
        }
        else if(wading>0) {
            wading=0; wading_sink=0; y-=2
            if(distance_to_object(Floor)>4) y+=2
            repeat(irandom_range(5,9)) with(instance_create(x,y,NTTEFullSweat)) motion_set(other.direction,other.speed)
            scrNTTEFullCoastSoundAt(x,y,choose(sndOasisChest,sndOasisMelee),1+random(0.25))
            if(instance_is(id,Player)) scrNTTEFullFootprintGive(20,scrAreaGetBackroundColor(GameCont.area),0.5)
        }
        if(wading>0) array_push(_swimming,id)
    }
    GameCont.ntte_sea_inst=_swimming
    with(Corpse) if(scrNTTEFullValue(id,"wading",0)>30 && wading_sink==0 && speed==0 && image_speed==0 && size<3) wading_sink=1
    with(Player) if(scrNTTEFullValue(id,"wading",0)>0) {
        if(roll==0 && !scr_skill_get(mut_extra_feet)) friction=timescale*timescale
        var _nearest=instance_nearest(x,y,Portal)
        if(instance_exists(_nearest)) {
            if(_nearest.endgame>=100) {
                if(wading>120 || !instance_exists(Floor)) {
                    if(_nearest.type==1) { _nearest.x=x; _nearest.y=y; _nearest.xstart=x; _nearest.ystart=y }
                    else instance_create(x,y,Portal)
                }
            }
            else if(wading_sink>=0) wading_sink+=0.6*timescale
        }
    }
    with(Shell) if(!position_meeting(x,y,Floor)) y+=sin((x+y+current_frame)/10)*0.1*timescale
    with(Explosion) if(random(5)<timescale) {
        var _length=random_range(24,48),_dir=random(360)
        with(instance_create(x+lengthdir_x(_length,_dir),y+lengthdir_y(_length,_dir),RainSplash))
            if(place_meeting(x,y,Floor)) instance_destroy()
    }
    with(Portal) if(!visible && endgame<100 && !place_meeting(xstart,ystart,Floor)) {
        var _radius=5+image_index
        x=xstart+cos(current_frame)*_radius; y=ystart+sin(current_frame)*_radius
        if(current_frame_active) instance_create(x,y,choose(NTTEFullSweat,NTTEFullSweat,Bubble))
        if(!variable_instance_exists(id,"coast_portal_sound")) { coast_portal_sound=true; snd_play(sndOasisPortal) }
    }
}
function scrNTTEFullCoastVisible(_visible) {
    var _sea=scrNTTEFullValue(GameCont,"ntte_sea_inst",[])
    for(var _i=0;_i<array_length(_sea);++_i) if(instance_exists(_sea[_i])) _sea[_i].visible=_visible
}
