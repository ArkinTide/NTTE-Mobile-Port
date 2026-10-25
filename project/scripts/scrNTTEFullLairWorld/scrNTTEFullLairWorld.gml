// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// tesewers: original furniture, lights and double-boss manhole lifecycle.
function scrNTTEFullPortalBlocked() {
    var _blocked=false
    with (NTTEFullPortalPrevent) {
        if (creator!=noone && !instance_exists(creator)) instance_destroy()
        else _blocked=true
    }
    return _blocked
}

function scrNTTEFullLairPropConfigure(_kind) {
    ntte_full_lair_prop=_kind
    var _base=_kind
    max_hp=4; size=1; depth=-1; snd_hurt=sndHitMetal; snd_dead=sndStreetLightBreak
    switch(_kind) {
        case "Cabinet": max_hp=20; snd_dead=sndSodaMachineBreak; break
        case "Couch": max_hp=20; size=3; snd_hurt=sndHitPlant; snd_dead=sndWheelPileBreak; break
        case "Table": max_hp=8; size=2; snd_dead=sndHydrantBreak; break
        case "ChairFront": case "ChairSide": break
        default: show_error("Unknown Lair furniture: "+_kind,true)
    }
    hp=max_hp; spr_idle=scrNTTERefSprite(_base+"Idle"); spr_hurt=scrNTTERefSprite(_base+"Hurt")
    spr_dead=scrNTTERefSprite(_base+"Dead"); sprite_index=spr_idle; mask_index=-1
    image_index=0; image_speed=0; spr_shadow=(_kind=="Table" ? shd32:shd24)
}

function scrNTTEFullLairPropCreate(_x,_y,_kind) {
    var _p=instance_create(_x,_y,NTTEFullLairProp)
    with (_p) scrNTTEFullLairPropConfigure(_kind)
    return _p
}

function scrNTTEFullLairPropDeath() {
    if (ntte_full_lair_prop!="Cabinet") return;
    repeat(irandom_range(8,16)) {
        var _paper=instance_create(x,y,Feather)
        _paper.sprite_index=scrNTTERefSprite("Paper"); _paper.image_index=irandom(_paper.image_number-1)
        _paper.image_speed=0; _paper.friction=0.2*timescale*timescale
        with (_paper) motion_set(random(360),random_range(2,8)*timescale)
    }
}

function scrNTTEFullLairLight(_x,_y,_big=false) {
    var _p=instance_create(_x,_y,NTTEFullCatLight)
    if (_big) _p.sprite_index=scrNTTERefSprite("CatLightBig")
    return _p
}

function scrNTTEFullCatLightCreate() {
    sprite_index=scrNTTERefSprite("CatLight"); image_speed=0
    image_xscale=0.25; image_yscale=0.25; ntte_full_light_angle=image_angle
    ntte_full_light_tick=0; image_alpha=1; depth=-100
}

function scrNTTEFullCatLightStep() {
    if (lockstep_stop) return;
    ntte_full_light_tick+=timescale
    while(ntte_full_light_tick>=1) {
        ntte_full_light_tick-=1
        image_angle=ntte_full_light_angle+orandom(1.5); visible=(random(60)>=1)
    }
}

function scrNTTEFullBigManholeCreate() {
    sprite_index=scrNTTERefSprite("BigManhole"); image_speed=0; image_index=0; depth=8
    ntte_full_phase=0; ntte_full_timers=[-1,-1]; ntte_full_released=false
    mask_index=scrNTTERefSprite("BigManholeOpen"); ntte_full_light=noone
    var _count=0,_cx=0,_cy=0,_floors=[]
    // Original floor_fill(x,y,2) uses a centered 2 x 2 normal-floor footprint.
    var _left=floor((x-32)/32)*32,_top=floor((y-32)/32)*32
    for(var _iy=0;_iy<2;++_iy) for(var _ix=0;_ix<2;++_ix) {
        var _fx=_left+32*_ix,_fy=_top+32*_iy,_f=collision_point(_fx+16,_fy+16,Floor,false,false)
        if (!instance_exists(_f)) _f=instance_create(_fx,_fy,Floor)
        _f.styleb=false; _f.sprite_index=scrNTTERefSprite("BigManholeFloor"); _f.image_index=_count
        _cx+=(_f.bbox_left+(_f.bbox_right-1)+1)/2; _cy+=(_f.bbox_top+(_f.bbox_bottom-1)+1)/2; ++_count
    }
    if (_count>0) { x=_cx/_count; y=_cy/_count; xstart=x; ystart=y }
    ntte_full_light=scrNTTEFullLairLight(x,y-48,true)
    var _prevent=instance_create(0,0,NTTEFullPortalPrevent); _prevent.creator=id
}

function scrNTTEFullBigManholeClang() {
    ntte_full_timers[0]=30+irandom(30)
    if (!instance_exists(Player)) return;
    if (ntte_full_phase>=3) { scrNTTEFullBigManholeRelease(); return; }
    var _clang=(ntte_full_phase<1)
    if (!_clang) with (Player) {
        if (point_distance(x,y,other.x,other.y)<180 && !collision_line(x,y,other.x,other.y,Wall,false,false)) {
            _clang=true; break
        }
    }
    if (!_clang) return;
    ++ntte_full_phase; image_speed=0.4*timescale
    repeat(irandom_range(1,3)) {
        var _p=instance_create(x,y,Debris)
        _p.sprite_index=scrNTTERefSprite("BigManholeDebris"); _p.image_index=irandom(_p.image_number-1)
        with (_p) {
            motion_set(random(360),(4+random(4))*timescale)
            x+=lengthdir_x(16,direction); y+=lengthdir_y(16,direction)
        }
    }
    repeat(irandom_range(4,12)) scrNTTEFullTrenchFX(x,y,18,random(2),Dust)
    snd_play(sndHitMetal,0.5+random(0.2)); scrNTTEFullTrenchShake(x,y,20); sleep(20)
    if (ntte_full_phase>1) {
        GameCont.ntte_full_boss_music_key="CatBat"
        with (MusCont) { alarm[2]=1; alarm[3]=-1 }
    }
}

function scrNTTEFullBigManholeStep() {
    if (lockstep_stop) return;
    for(var _i=0;_i<2;++_i) if (ntte_full_timers[_i]>0) {
        ntte_full_timers[_i]-=timescale
        if (ntte_full_timers[_i]<=0) {
            ntte_full_timers[_i]=-1
            if (_i==0) { scrNTTEFullBigManholeClang(); if (!instance_exists(id)) return; }
            else scr_camera_set_position(x-view_width/2,y-view_height/2)
        }
    }
    if (ntte_full_timers[0]<0 && ntte_full_phase==0 && instance_exists(Player)
        && !instance_exists(CorpseActive) && !scr_check_enemies() && !instance_exists(NTTECatGas)) {
        ntte_full_timers[0]=20; ntte_full_timers[1]=40
    }
    if (ntte_full_timers[1]>0) scr_camera_set_position(x-view_width/2,y-view_height/2)
    if (image_speed>0 && image_index+image_speed>=image_number) { image_index=0; image_speed=0 }
}

function scrNTTEFullBigManholeRelease() {
    ntte_full_released=true
    var _bosses=[NTTEFullBatBoss,NTTEFullCatBoss]
    if (random(2)<1) _bosses=[NTTEFullCatBoss,NTTEFullBatBoss]
    for(var _i=0;_i<2;++_i) {
        var _boss=instance_create(x,y-4,_bosses[_i]); _boss.sprite_index=_boss.spr_hurt
        _boss.image_index=_boss.image_speed*_i
    }
    var _shock=instance_create(x,y,PortalShock); _shock.sprite_index=sprPortalClear
    instance_destroy()
}

function scrNTTEFullBigManholeDeath() {
    if (!ntte_full_released) return;
    var _hole=instance_create(x,y,NTTEFullManholeOpen)
    _hole.sprite_index=scrNTTERefSprite("BigManholeOpen"); _hole.ntte_full_big=true; _hole.ntte_full_canportal=true
    with (Player) if (place_meeting(x,y,_hole)) {
        var _dir=point_direction(other.x,other.y,x,y),_force=min(1,point_distance(other.x,other.y,x,y)/24)
        var _toss=instance_create(x,y,NTTEFullPalankingToss)
        _toss.direction=_dir; _toss.speed=6*_force*timescale
        _toss.zfriction=0.6+0.4*_force; _toss.zspeed=12; _toss.creator=id
        _toss.depth=depth; _toss.mask_index=mask_index; _toss.spr_shadow_y=spr_shadow_y
    }
    var _sets=[{num:[6,12],spr:"BigManholeDebris",angle:0,speed:[2,8],offset:16},
        {num:[3,6],spr:"BigManholeDebrisChunk",angle:360,speed:[4,8],offset:8}]
    for(var _i=0;_i<2;++_i) {
        var _set=_sets[_i]
        repeat(irandom_range(_set.num[0],_set.num[1])) {
            var _p=instance_create(x,y,ScrapBossCorpse)
            _p.sprite_index=scrNTTERefSprite(_set.spr); _p.image_index=irandom(_p.image_number-1)
            _p.image_angle=random(_set.angle); _p.size=0
            with (_p) {
                motion_set(random(360),random_range(_set.speed[0],_set.speed[1])*timescale)
                x+=lengthdir_x(_set.offset,direction); y+=lengthdir_y(_set.offset,direction)
            }
        }
    }
    with (NTTEFullPortalPrevent) if (creator==other.id) instance_destroy()
    if (instance_exists(ntte_full_light)) instance_destroy(ntte_full_light)
    repeat(irandom_range(6,18)) scrNTTEFullTrenchFX(x,y,16,6+random(6),Dust)
    snd_play(sndExplosion,0.8); snd_play(sndHitMetal,0.4); scrNTTEFullTrenchShake(x,y,60); sleep(60)
    if (!variable_instance_exists(GameCont,"ntte_lairmut")) { ++GameCont.skillpoints; GameCont.ntte_lairmut=true }
}

function scrNTTEFullManholeCreate() {
    var _palette=scrNTTERefSprite("PizzaManhole")
    sprite_index=_palette[irandom(array_length(_palette)-1)]
    image_index=0; image_speed=0; depth=5; mask_index=mskWepPickup
    contact=false; area=scrNTTEFullAreaId("pizza"); subarea=0; ntte_full_loops=GameCont.loops
    var _floors=scrNTTEFullRectInstances(x,y,x,y,Floor,false,true)
    for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
        switch(sprite_index) {
            case sprFloor2: image_index=choose(0,2,4,5); break
            case sprFloor101: break
            default: image_index=0
        }
    }
}

function scrNTTEFullManholeStep() {
    if (lockstep_stop) return;
    if (visible) {
        if (GameCont.underwater && random(4)<timescale) {
            var _bubble=instance_create(x,y,Bubble)
            with (_bubble) motion_set(90+orandom(5),(4+random(3))*timescale)
            _bubble.friction=0.2*timescale*timescale
        }
        if (place_meeting(x,y,Explosion) || (contact && place_meeting(x,y,Player))) {
            var _open=true
            // Source enemy_boss honors an explicit custom boss flag; native
            // Epsilon bosses express that same status through bossenemy ancestry.
            with (enemy) if (variable_instance_exists(id,"boss") ? boss : scrEnemyIsBoss(id)) { _open=false; break }
            if (_open) { image_index+=timescale; if (image_index>=image_number-1) instance_destroy() }
        }
    }
    else if (instance_exists(Portal)) {
        visible=true; snd_play(sndPillarBreak,0.7+random(0.1),8)
        repeat(3) scrNTTEFullTrenchFX(x,y,0,2,Smoke)
    }
}

function scrNTTEFullManholeDeath() {
    var _hole=instance_create(x,y,NTTEFullManholeOpen)
    _hole.sprite_index=sprite_index; _hole.image_index=_hole.image_number-1
    _hole.mask_index=mskExploder; _hole.ntte_full_canportal=true
    sleep(50); scrNTTEFullTrenchShake(x,y,20)
    if (GameCont.underwater) repeat(10+irandom(10)) {
        var _bubble=instance_create(x,y,Bubble)
        with (_bubble) motion_set(random(360),(1+random(2))*timescale)
    }
    if (area==scrNTTEFullAreaId("pizza")) {
        var _angle=random(360)
        for(var _direction=_angle;_direction<_angle+360;_direction+=120) {
            var _streak=scrNTTEFullSystemsCreate("WaterStreak",x,y)
            _streak.direction=_direction+orandom(20); _streak.speed=(4+random(1))*timescale
            _streak.image_angle=_streak.direction; _streak.image_blend=c_orange
        }
    }
    else if (area==scrNTTEFullAreaId("trench")) {
        repeat(5+irandom(5)) { var _debris=instance_create(x,y,Debris); with (_debris) motion_set(random(360),(3+random(5))*timescale) }
        snd_play(sndPillarBreak,0.8,1.2); snd_play(sndOasisPortal,1,0.3); snd_play(sndSnowTankShoot,0.6,0.3)
    }
    // BEGIN NTTE MANHOLE FINAL PIZZA DESTINATION
    // Original area_set immediately changes GameCont to Pizza0; its next
    // area_finish increments0 to1. This mobile bridge queues a final target.
    var _destination_subarea=(area==scrNTTEFullAreaId("pizza") && subarea==0)?1:subarea
    scrNTTEFullAreaSet(area,_destination_subarea,ntte_full_loops)
    // END NTTE MANHOLE FINAL PIZZA DESTINATION
    // BEGIN NTTE OASIS CRACK PENDING ENTRY FINISH
    // Carry intent only; the genuine RoomEnd owns source finish side effects.
    var _entry_source=scrNTTEFullValue(id,"ntte_full_source_entry_finish",undefined)
    var _entry_pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    if (is_struct(_entry_source) && is_struct(_entry_pending)) {
        if (scrNTTEFullValue(_entry_source,"origin","")=="oasis_crack"
            && GameCont.area==scrNTTEFullAreaId("oasis")
            && area==scrNTTEFullAreaId("trench") && subarea==1
            && scrNTTEFullValue(_entry_source,"area",-1)==area
            && scrNTTEFullValue(_entry_source,"subarea",-1)==0
            && scrNTTEFullValue(_entry_pending,"area",-1)==area
            && scrNTTEFullValue(_entry_pending,"subarea",-1)==subarea
            && scrNTTEFullValue(_entry_pending,"loops",-1)==ntte_full_loops
            && GameCont.loops==ntte_full_loops) {
            _entry_pending.ntte_full_source_entry_finish={origin:"oasis_crack",
                area:area,subarea:0,loops:ntte_full_loops,
                from_area:GameCont.area,from_subarea:GameCont.subarea}
        }
    }
    // Native Sewers Manhole originally makes live Pizza0 before RoomEnd.
    if (is_struct(_entry_pending) && GameCont.area==area_sewers
        && area==scrNTTEFullAreaId("pizza") && subarea==0
        && scrNTTEFullValue(_entry_pending,"area",-1)==area
        && scrNTTEFullValue(_entry_pending,"subarea",-1)==1
        && scrNTTEFullValue(_entry_pending,"loops",-1)==ntte_full_loops
        && GameCont.loops==ntte_full_loops) {
        _entry_pending.ntte_full_source_entry_finish={origin:"pizza_manhole",
            area:area,subarea:0,loops:ntte_full_loops,
            from_area:GameCont.area,from_subarea:GameCont.subarea}
    }
    // END NTTE OASIS CRACK PENDING ENTRY FINISH
    GameCont.killenemies=true
    instance_create(x,y,Portal)
    snd_stop(sndPortalOpen)
}

function scrNTTEFullManholeOpenCreate() {
    sprite_index=scrNTTERefSprite("ManholeOpen"); image_speed=0; depth=5
    mask_index=-1; ntte_full_canportal=false; ntte_full_portal=noone; ntte_full_big=false
}

function scrNTTEFullManholeOpenStep() {
    if (lockstep_stop) return;
    // NTT's Pickup parent is split into these native Epsilon object families.
    var _groups=[AmmoPickup,HPPickup,Rad,WepPickup,NTTEPickup,chestprop,ChestOpen,Corpse],
        _distance=4+min((bbox_right-1)-bbox_left+1,(bbox_bottom-1)-bbox_top+1)/2
    if (ntte_full_big && !place_meeting(x,y,Portal)) array_push(_groups,hitme)
    for(var _i=array_length(_groups)-1;_i>=0;--_i) {
        var _obj=_groups[_i],_oy=(_obj==hitme ? -8:0),_list=ds_list_create()
        y+=_oy
        var _bx=(bbox_left+(bbox_right-1)+1)/2,_by=(bbox_top+(bbox_bottom-1)+1)/2
        collision_rectangle_list(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1),_obj,false,true,_list,false)
        for(var _j=0;_j<ds_list_size(_list);++_j) {
            var _v=_list[| _j]
            if (!instance_exists(_v) || !place_meeting(x,y,_v)) continue
            with (_v) {
                var _d=point_direction(_bx,_by,x,y)
                if (other.ntte_full_big && instance_is(id,Player) && point_distance(_bx,_by,x,y)<_distance) {
                    var _tx=_bx+lengthdir_x(_distance,_d),_ty=_by+lengthdir_y(_distance,_d)
                    if (place_free(_tx,_ty)) { x=_tx; y=_ty; xprevious=x; yprevious=y }
                    else if (place_free(_tx,y)) { x=_tx; xprevious=x }
                    else if (place_free(x,_ty)) { y=_ty; yprevious=y }
                    direction+=angle_difference(_d,direction)*(1-power(11/12,timescale))
                }
                else if (speed<3*timescale && (!variable_instance_exists(id,"size") || size<4) && !instance_is(id,crystaltype)) {
                    if (friction>0 && object_index!=Rad) motion_add(_d,friction+0.4*timescale*timescale)
                    else { x+=lengthdir_x(2.6,_d)*timescale; y+=lengthdir_y(2.6,_d)*timescale }
                }
            }
        }
        ds_list_destroy(_list); y-=_oy
    }
    if (!ntte_full_canportal) return;
    if (!instance_exists(ntte_full_portal)) with (Portal) {
        if (object_index==Portal && type==1 && endgame>=100 && image_alpha>=1) {
            other.ntte_full_portal=id; image_alpha=0; mask_index=other.sprite_index; x=other.x; y=other.y
            break
        }
    }
    if (instance_exists(ntte_full_portal)) with (PortalL) {
        if (place_meeting(x,y,other.ntte_full_portal)) instance_destroy()
    }
}
