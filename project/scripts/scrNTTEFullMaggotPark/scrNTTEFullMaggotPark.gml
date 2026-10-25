// tedesert444..667 and2914..2966. Original nest and delayed burrow residents.
function scrNTTEFullBigMaggotSpawnCreate() {
    spr_idle=scrNTTERefSprite("BigMaggotSpawnIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("BigMaggotSpawnHurt"); spr_dead=scrNTTERefSprite("BigMaggotSpawnDead"); spr_chrg=scrNTTERefSprite("BigMaggotSpawnChrg")
    sprite_index=spr_idle; hitid=[spr_idle,"BIG MAGGOT NEST"]; depth=-1
    mask_index=mskLast; max_hp=42; lsthealth=42; raddrop=6; size=4
    loop_snd=-1; scorp_drop=0; ntte_maggot_nest_left=150
}
function scrNTTEFullBigMaggotSpawnAfterCreate() {
    spr_shadow=shd64B; snd_hurt=sndHitFlesh; snd_dead=sndBigMaggotDie
    alarm[0]=-1; alarm[1]=-1
    var _positions=[[-18,-14],[0,-28],[26,-16+orandom(6)]]
    for(var _i=0;_i<3;++_i) {
        var _fly=instance_create(x,y,NTTEFullFlySpin)
        _fly.target=id; _fly.target_x=(_positions[_i][0]+orandom(2))*right; _fly.target_y=_positions[_i][1]+orandom(2)
    }
    repeat(irandom_range(3,6)) instance_create(x,y,Maggot)
    var _clear=instance_create(x,y,PortalClear); _clear.sprite_index=mskScrapBoss
}
function scrNTTEFullBigMaggotSpawnHurt(_amount) {
    if (hp>1) {
        hp=max(1,hp-_amount); nexthurt=current_frame+6
        sprite_index=spr_hurt; image_index=0; snd_play_hit(snd_hurt,0.2)
    }
    else ntte_maggot_nest_left=min(ntte_maggot_nest_left,2)
    return true
}
function scrNTTEFullBigMaggotSpawnStep() {
    if (lockstep_stop) return;
    ntte_maggot_nest_left-=timescale
    if (ntte_maggot_nest_left<=0) {
        ntte_maggot_nest_left=irandom_range(15,60); scrTarget()
        if (hp>0 && (hp<=1 || (instance_exists(target) && distance_to_object(target)<64)
            || (random(3)<1 && scrNTTEFullWorldTargetVisible()))) hp-=2
    }
    x=xstart; y=ystart; speed=0
    var _near=instance_exists(Player) && distance_to_object(Player)<64
    if (_near) {
        if (!audio_is_playing(loop_snd)) loop_snd=snd_play(sndMaggotSpawnIdle)
    }
    else if (loop_snd!=-1) { audio_stop_sound(loop_snd); loop_snd=-1 }
    if (sprite_index!=spr_chrg || image_index+image_speed>=image_number) {
        sprite_index=scrNTTEFullWorldEnemySprite()
        if (image_index<1 && sprite_index==spr_idle) image_index+=random(image_speed*(_near ? 0.3:0.2))-image_speed
    }
    // Resolve actual mask overlap rather than clearing every rectangle candidate.
    with (Wall) if (place_meeting(x,y,other.id)) { instance_create(x,y,FloorExplo); instance_destroy() }
    if (lsthealth>hp) {
        if (current_frame_active) {
            lsthealth-=3
            var _loop=random(3)<GameCont.loops,_l=(24+orandom(2))*image_xscale,_d=_loop ? random(360):random_range(200,340)
            var _mag=instance_create(x+lengthdir_x(_l,_d),y+lengthdir_y(_l*0.5,_d),_loop ? FiredMaggot:Maggot)
            with (_mag) {
                x=xstart; y=ystart; kills=1; creator=other.id
                for(var _i=0;_i<=4*_loop;_i+=2) with (instance_create(x,y,Dust)) {
                    motion_add(_d+orandom(10),(2+_i)*timescale); depth=other.depth-1
                    image_blend=make_color_rgb(170,70,60); image_speed/=max(1,_i/2.5)
                }
                var _snd=audio_play_sound(_loop ? sndFlyFire:sndHitFlesh,0,false)
                audio_sound_gain(_snd,min(0.9,random_range(24,32)/(distance_to_object(Player)+1)),0)
                audio_sound_pitch(_snd,1.2+random(0.2))
            }
        }
        if (hp<=1) {
            nexthurt=current_frame+6; sprite_index=spr_hurt; image_index=0
            ntte_maggot_nest_left=1+ceil(timescale)
        }
    }
    else if (lsthealth>0) lsthealth=hp
    else { hp=lsthealth; instance_destroy() }
}
function scrNTTEFullBigMaggotSpawnDeath() {
    if (hp>0) return;
    speed/=5
    repeat(scorp_drop) instance_create(x,y,Scorpion)
    repeat(2) with (instance_create(x,y,MaggotExplosion)) creator=other.id
    repeat(irandom_range(2,3)) {
        var _fly=random(3)<max(0.01,GameCont.loops),_spawn=instance_create(x,y,_fly ? JungleFly:BigMaggot)
        _spawn.creator=id; _spawn.raddrop=4
        if (_fly && GameCont.loops<=0) {
            var _alert=scrNTTEAlertCreate(_spawn.x,_spawn.y,scrNTTERefSprite("FlyAlert"),_spawn)
            _alert.alert_hold=75; _alert.blink=20
        }
    }
    repeat(irandom_range(3,6)) instance_create(x+orandom(32),y+orandom(16),NTTEFullFlySpin)
    scrNTTEFullWorldPickupDrop(50,35,0); scrNTTEFullWorldPickupDrop(50,35,1); scrNTTEFullWorldPickupDrop(100,0); scrNTTEFullWorldPickupDrop(100,0)
}
function scrNTTEFullBigMaggotSpawnCleanup() {
    // Source stops the shared sound resource, including other nests' handles.
    audio_stop_sound(sndMaggotSpawnIdle)
}

function scrNTTEFullWantBigMaggotCreate() {
    // Source creates a real BigMaggot and changes it to BigMaggotBurrow while
    // retaining all fields. Native becomenemy identity must remain non-enemy.
    var _source=instance_create(x,y,BigMaggot),_names=variable_instance_get_names(_source)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _key=_names[_i]
        if (_key!="id" && _key!="object_index") variable_instance_set(id,_key,variable_instance_get(_source,_key))
    }
    var _builtins=["image_speed","image_xscale","image_yscale","image_blend","image_alpha","depth","friction","mask_index"]
    for(var _i=0;_i<array_length(_builtins);++_i) variable_instance_set(id,_builtins[_i],variable_instance_get(_source,_builtins[_i]))
    instance_destroy(_source,false)
    sprite_index=sprBigMaggotBurrow; mask_index=object_get_mask(BigMaggotBurrow)
    visible=false; alarm[0]=-1; alarm[1]=-1
    unburrow_check_timer=random_range(150,450)
}
function scrNTTEFullWantBigMaggotStep() {
    if (lockstep_stop) return;
    if (unburrow_check_timer>0) unburrow_check_timer-=timescale
    else {
        unburrow_check_timer=random_range(120,300)
        var _player=instance_nearest(x,y,Player)
        if ((instance_exists(_player) && point_distance(x,y,_player.x,_player.y)<160) || !instance_exists(enemy)) {
            snd_play_hit(sndBigMaggotUnburrowSand,0.2)
            sprite_index=sprBigMaggotAppear; image_index=0; visible=true; alarm[1]=12
        }
    }
    if (!visible) { sprite_index=sprBigMaggotBurrow; image_index=0 }
    else if (image_index+image_speed>=image_number) {
        with (instance_create(x,y,BigMaggot)) { x=xstart; y=ystart; right=other.right }
        instance_destroy(id,false)
    }
}

// teevents730..896. Shared chest_create level-start modifiers remain an
// integration dependency; this emits the actual native BigWeaponChest.
function scrNTTEFullMaggotParkEvent(_spawnx,_spawny) {
    var _x=_spawnx,_y=_spawny,_num=3,_angle=random(360),_nest_dis=28,_w=5
    var _start=scrNTTEFullFloorRoomStart(_spawnx,_spawny,160,Floor)
    if (is_struct(_start)) { _x=_start.x; _y=_start.y }
    var _rad=instance_furthest(_spawnx,_spawny,RadChest)
    if (instance_exists(_rad)) {
        var _floor=scrNTTEFullWorldNearestRectBBox(_x,_y,_x,_y,Floor)
        if (instance_exists(_floor)) {
            var _fx=(_floor.bbox_left+_floor.bbox_right)/2,_fy=(_floor.bbox_top+_floor.bbox_bottom)/2
            if (point_distance(_fx,_fy,_spawnx,_spawny)>=160) { _x=_fx; _y=_fy }
        }
        instance_destroy(_rad,false)
    }
    var _snapshot=scrNTTEFullInstances(Floor,true)
    scrNTTEFullFloorSetAlign(32,32); scrNTTEFullFloorSetStyle(true)
    var _room=scrNTTEFullFloorRoomCreate(_x,_y,_w,_w,"round",point_direction(_spawnx,_spawny,_x,_y),0,-32)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y
        for(var _dir=_angle;_dir<_angle+360;_dir+=120) {
            var _fx=_cx+lengthdir_x(_w*16-32,_dir),_fy=_cy+lengthdir_y(_w*16-32,_dir),_off=0
            for(var _size=3;_size>0;--_size) {
                var _dis=_size*16,_doff=round((_dir+_off)/90)*90
                _fx+=lengthdir_x(_dis,_doff); _fy+=lengthdir_y(_dis,_doff)
                scrNTTEFullFloorFill(_fx,_fy,_size)
                _fx+=lengthdir_x(_dis,_doff); _fy+=lengthdir_y(_dis,_doff); _off+=orandom(60)
            }
        }
        var _oldchest=instance_nearest(_cx,_cy,WeaponChest)
        if (instance_exists(_oldchest)) {
            instance_create(_oldchest.x,_oldchest.y,Cactus)
            with (PortalClear) if (x==_oldchest.x && y==_oldchest.y) instance_destroy(id,false)
            instance_destroy(_oldchest,false)
            var _chest=instance_create(_cx,_cy,BigWeaponChest); _chest.depth=-1
        }
        for(var _d=_angle;_d<_angle+360;_d+=120) {
            var _l=_nest_dis+random(12)
            instance_create(round(_cx+lengthdir_x(_l,_d)),round(_cy+lengthdir_y(_l,_d)),NTTEFullBigMaggotSpawn)
        }
        var _small=irandom_range(5,6),_burrows=irandom_range(3,4),_props=irandom_range(1,3)
        var _newfloors=[],_floors=scrNTTEFullInstances(Floor,true)
        for(var _i=0;_i<array_length(_floors);++_i) if (array_get_index(_snapshot,_floors[_i])<0) array_push(_newfloors,_floors[_i])
        _newfloors=array_shuffle(_newfloors)
        for(var _i=0;_i<array_length(_newfloors);++_i) with (_newfloors[_i]) {
            var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2
            if (!place_meeting(x,y,hitme)) {
                if (_small>0) {
                    --_small
                    var _nest=instance_create(_fx,_fy,MaggotSpawn)
                    with (_nest) {
                        x=xstart; y=ystart
                        move_contact_solid(point_direction(_cx,_cy,x,y)+orandom(120),random(16))
                        var _mag=instance_create(x,y,Maggot),_fly=instance_create(_mag.x,_mag.y,NTTEFullFlySpin)
                        _fly.target=_mag; _fly.target_x=orandom(8); _fly.target_y=-random(4)
                    }
                }
                else if (_burrows>0) {
                    --_burrows; instance_create(_fx,_fy,NTTEFullWantBigMaggot)
                    if (random(3)<1) instance_create(_fx+orandom(4),_fy+orandom(4),BonePile)
                    else with (instance_create(_fx+orandom(4),_fy+orandom(4),Corpse)) {
                        sprite_index=sprMSpawnDead; image_xscale=choose(-1,1); size=2
                    }
                    instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),NTTEFullFlySpin)
                }
                else if (_props>0) {
                    --_props
                    with (instance_create(_fx,_fy,Cactus)) instance_create(x+orandom(8),y+orandom(8),NTTEFullFlySpin)
                }
            }
            else {
                var _cacti=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right,bbox_bottom,Cactus)
                for(var _j=0;_j<array_length(_cacti);++_j) with (_cacti[_j]) event_perform(ev_create,0)
            }
        }
        // Original resource-level volume applies to all nest idle handles.
        audio_sound_gain(sndMaggotSpawnIdle,0.4,0)
    }
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    return _room
}

function scrNTTEFullMaggotParkEventSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_oldarea=GameCont.area
    GameCont.area=area_desert
    scrNTTEFullFloorSetAlign(32,32,28000,28000); scrNTTEFullFloorFill(28000,28000,11)
    // Farthest can include the native level's older chests. Place this target
    // beyond every other fixture so the original farthest selection is real.
    var _weapon=instance_create(28000,28000,WeaponChest),_rad=instance_create(1000000,1000000,RadChest)
    var _room=scrNTTEFullMaggotParkEvent(28000,28000)
    assert(is_struct(_room) && _room.x2-_room.x1==160 && _room.y2-_room.y1==160,"MaggotPark lost original5x5 rounded core")
    assert(!instance_exists(_rad) && !instance_exists(_weapon),"MaggotPark failed to replace native old Rad/Weapon chests")
    var _nests=0,_fly=0
    with (NTTEFullBigMaggotSpawn) if (array_get_index(_snapshot,id)<0) _nests++
    with (NTTEFullFlySpin) if (array_get_index(_snapshot,id)<0) _fly++
    assert(_nests==3 && _fly>=9,"MaggotPark lost its three large nests and attached flies")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_oldarea
    scrNTTESmokeLog("FULL WORLD MAGGOT PARK5x5ROUND CORE/THREE NESTS+FLIES/TENDRILS/NATIVE CHEST REPLACEMENT OK")
}

function scrNTTEFullMaggotParkEntitiesSmoke() {
    var _nest=instance_create(10080,10048,NTTEFullBigMaggotSpawn),_frame=current_frame
    assert(_nest.hp==42 && _nest.lsthealth==42 && _nest.scorp_drop==0 && _nest.size==4,"BigMaggot nest original42HP/size4/defaults changed")
    var _old=instance_number(Maggot)
    with (_nest) scrNTTEFullBigMaggotSpawnHurt(1000)
    assert(_nest.hp==1,"BigMaggot nest did not clamp lethal projectile damage to1HP")
    current_frame=0
    with (_nest) scrNTTEFullBigMaggotSpawnStep()
    assert(_nest.lsthealth==39 && instance_number(Maggot)==_old+1,"BigMaggot nest did not shed one larva per3lost HP at30Hz")
    if (timescale<1) {
        current_frame=timescale
        with (_nest) scrNTTEFullBigMaggotSpawnStep()
        assert(_nest.lsthealth==39 && instance_number(Maggot)==_old+1,"Nest larva loss multiplied on fractional physical frames")
    }
    current_frame=_frame; instance_destroy(_nest,false)
    var _burrow=instance_create(10080,10048,NTTEFullWantBigMaggot),_player=instance_find(Player,0)
    assert(!instance_is(_burrow,enemy) && instance_is(_burrow,BigMaggotBurrow) && !_burrow.visible && _burrow.hp==22 && _burrow.mask_index==object_get_mask(BigMaggotBurrow),"WantBigMaggot lost native burrow/non-enemy identity or copied state")
    _burrow.x=_player.x; _burrow.y=_player.y; _burrow.unburrow_check_timer=0
    with (_burrow) scrNTTEFullWantBigMaggotStep()
    assert(_burrow.visible && _burrow.sprite_index==sprBigMaggotAppear && _burrow.alarm[1]==12,"WantBigMaggot failed near-player unburrow")
    _burrow.image_index=sprite_get_number(sprBigMaggotAppear)-0.1; _old=instance_number(BigMaggot)
    with (_burrow) scrNTTEFullWantBigMaggotStep()
    assert(!instance_exists(_burrow) && instance_number(BigMaggot)==_old+1,"WantBigMaggot did not become a real native BigMaggot after appear")
    instance_destroy(BigMaggot,false); instance_destroy(Maggot,false); instance_destroy(NTTEFullFlySpin,false)
    scrNTTESmokeLog("FULL WORLD BIG MAGGOT NEST42HP/LETHAL CLAMP/3HP LARVA30HZ + WANT NONENEMY/NEAR PLAYER/TRUE BIG MAGGOT TRANSITION OK")
}
