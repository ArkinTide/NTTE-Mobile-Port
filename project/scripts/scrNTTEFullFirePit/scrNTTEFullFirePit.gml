// tescrapyard2473..2625 and teevents1858..1960.
function scrNTTEFullTrapSpinCreate() {
    sprite_index=scrNTTERefSprite("TrapSpin"); image_speed=0
    hitid=HitId.FireTrap; loop_snd=-1; mask_index=mskExploder; friction=0.4*timescale*timescale
    hp=1000000000000000; rotspeed=1.5*choose(-1,1); size=3; team=team_enemy; fire=false; canrot=false
    ntte_trap_flame_left=300; ntte_trap_rotate_left=-1
    var _wall=instance_create(x-8,y-8,Wall)
    _wall.image_alpha=0; _wall.visible=false; _wall.topspr=-1; _wall.outspr=-1
    instance_create(_wall.x,_wall.y,TrapScorchMark)
}
function scrNTTEFullTrapSpinActivate() {
    if (fire<=0) { fire=true; ntte_trap_rotate_left=90; snd_play_hit_big(sndFiretrap,0.2) }
}
function scrNTTEFullTrapSpinStep() {
    if (lockstep_stop) return;
    if (ntte_trap_flame_left>0) {
        ntte_trap_flame_left-=timescale
        if (ntte_trap_flame_left<=0) { ntte_trap_flame_left=-1; scrNTTEFullTrapSpinActivate(); return }
    }
    if (ntte_trap_rotate_left>0) {
        ntte_trap_rotate_left-=timescale
        if (ntte_trap_rotate_left<=0) { ntte_trap_rotate_left=-1; if (!instance_exists(Portal)) canrot=true; return }
    }
    if (instance_exists(Portal)) { fire=false; ntte_trap_flame_left=30 }
    if (canrot) {
        var _last=image_angle; image_angle+=rotspeed*timescale
        var _now=rotspeed>0 ? floor(image_angle/90):ceil(image_angle/90),_old=rotspeed>0 ? floor(_last/90):ceil(_last/90)
        if (_now!=_old) { image_angle=_now*90; canrot=false; ntte_trap_rotate_left=30 }
    }
    if (fire!=false) {
        if (current_frame%(1/fire)<timescale) repeat(ceil(fire*timescale)) {
            for(var _dir=image_angle;_dir<image_angle+360;_dir+=90) scr_projectile_create(x+lengthdir_x(12,_dir),y+lengthdir_y(12,_dir),TrapFire,_dir,6)
        }
        if (!audio_is_playing(loop_snd)) {
            var _seed=random_get_seed(); loop_snd=snd_play(sndFlamerLoop,1+orandom(0.1),3); random_set_seed(_seed)
        }
    }
    else if (audio_is_playing(loop_snd)) audio_stop_sound(loop_snd)
    if (!position_meeting(x,y,Wall)) instance_destroy()
}
function scrNTTEFullTrapSpinDraw() {
    for(var _i=0;_i<image_number;++_i) draw_sprite_ext(sprite_index,_i,x,y-_i,image_xscale,image_yscale,image_angle,image_blend,abs(image_alpha))
}
function scrNTTEFullTrapSpinTopDraw() {
    with (NTTEFullTrapSpin) if (visible) draw_sprite_ext(sprite_index,image_number-1,x,y-(image_number-1),image_xscale,image_yscale,image_angle,image_blend,abs(image_alpha))
}
function scrNTTEFullTrapSpinCleanup() { if (audio_is_playing(loop_snd)) audio_stop_sound(loop_snd) }
function scrNTTEFullTrapSpinDestroy() {
    scrNTTEFullTrapSpinCleanup()
    with (FloorExplo) if (x==other.x-8 && y==other.y-8) {
        var _a=other.image_angle
        x=other.x+lengthdir_x(-8,_a)+lengthdir_x(-8,_a-90)
        y=other.y+lengthdir_y(-8,_a)+lengthdir_y(-8,_a-90); image_angle=_a
        break
    }
    repeat(3) {
        instance_create(x,y,Debris)
        var _dust=instance_create(x,y,Dust); /* NTTE DUST LIFETIME trap-spin-death */ if(instance_exists(_dust)) {_dust.speed=2*timescale }
    }
}
function scrNTTEFullFirePitSetup() { ntte_firepit_steam_bound=true }
function scrNTTEFullFirePitCleanup() { ntte_firepit_steam_bound=false }
// Root calls this at the end of native RainSplash/Create, reproducing the
// original setup binding. Cleanup/unbound events no longer emit steam.
function scrNTTEFullFirePitRainSetup(_splash) {
    var _event=scrNTTEFullWorldEventGet("FirePit")
    if (!instance_exists(_event) || !scrNTTEFullValue(_event,"ntte_firepit_steam_bound",false)) return;
    with (_splash) {
        var _steam=instance_create(x,y,Breath)
        _steam.image_yscale=choose(-1,1); _steam.image_angle=random(90)
        with (_steam) if (!place_meeting(x,y+8,Floor)) depth=-8
    }
}
function scrNTTEFullFirePitCreate() {
    var _num=floor(array_length(scrNTTEFullInstances(Floor,true))/30),_walls=array_shuffle(scrNTTEFullInstances(Wall)),_arena=scrNTTEFullWorldEventGet("RavenArena")
    for(var _i=0;_i<array_length(_walls) && _num>0;++_i) with (_walls[_i]) {
        if (!place_meeting(x,y,Floor) || point_distance((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,other.spawn_x,other.spawn_y)<=64) continue
        if (array_length(scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Trap,true))>0) continue
        var _spawn=true
        if (instance_exists(_arena)) {
            var _fs=_arena.floors
            for(var _j=0;_j<array_length(_fs);++_j) if (instance_exists(_fs[_j])) with (_fs[_j]) if (place_meeting(x,y,other.id)) { _spawn=false; break }
        }
        if (_spawn) { _num--; instance_create(x,y,Trap) }
    }
    if (!instance_exists(_arena)) {
        var _cx=0,_cy=0,_count=0
        with (Floor) if (object_index==Floor) { _cx+=(bbox_left+bbox_right)/2; _cy+=(bbox_top+bbox_bottom)/2; _count++ }
        if (_count>0) {
            _cx/=_count; _cy/=_count; scrNTTEFullFloorSetAlign(32,32)
            var _room=scrNTTEFullFloorRoomCreate(_cx,_cy,4,4,"",point_direction(x,y,_cx,_cy),30,-32)
            if (is_struct(_room)) instance_create(_room.x,_room.y,NTTEFullTrapSpin)
            scrNTTEFullFloorResetAlign()
        }
    }
    with (Floor) if (object_index==Floor && random(4)<1) {
        var _scorch=instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Scorchmark)
        _scorch.sprite_index=scrNTTERefSprite("FirePitScorch"); _scorch.image_index=irandom(_scorch.image_number-1)
        _scorch.image_speed=0; _scorch.image_angle=random(360)
    }
}
function scrNTTEFullTrapSpinSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_t=instance_create(32000,32000,NTTEFullTrapSpin)
    assert(_t.ntte_trap_flame_left==300 && !_t.fire && !_t.canrot && abs(_t.rotspeed)==1.5,"TrapSpin original300tick warmup/rotation fields changed")
    var _wall=instance_position(_t.x-8,_t.y-8,Wall)
    assert(instance_exists(_wall) && !_wall.visible && _wall.topspr==-1 && _wall.outspr==-1,"TrapSpin did not create its actual invisible wall")
    _t.ntte_trap_flame_left=timescale
    with (_t) scrNTTEFullTrapSpinStep()
    assert(_t.fire && _t.ntte_trap_rotate_left==90 && !_t.canrot,"TrapSpin warmup failed original90tick pre-rotation flame stage")
    _t.ntte_trap_rotate_left=timescale
    with (_t) scrNTTEFullTrapSpinStep()
    assert(_t.canrot,"TrapSpin90tick timer did not enable rotation")
    _t.rotspeed=1.5; _t.image_angle=90-timescale
    with (_t) scrNTTEFullTrapSpinStep()
    assert(_t.image_angle==90 && !_t.canrot && _t.ntte_trap_rotate_left==30,"TrapSpin did not stop exactly at source90degree boundary for30ticks")
    instance_destroy(_wall,false)
    _t.ntte_trap_flame_left=-1; _t.ntte_trap_rotate_left=-1
    with (_t) scrNTTEFullTrapSpinStep()
    assert(!instance_exists(_t),"TrapSpin survived destruction of original support wall")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD TRAP SPIN INVISIBLE WALL/300WARMUP/90FLAME STAGE/90DEGREE STOP/30PAUSE/SUPPORT DESTRUCTION OK; FIREPIT NATURAL STEAM HOOK SEPARATE")
}
