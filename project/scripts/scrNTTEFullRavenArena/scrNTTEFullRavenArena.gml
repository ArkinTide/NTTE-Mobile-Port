// teevents1659..1851. Source audience is TopRaven, not BoneRaven.
function scrNTTEFullRavenArenaSetup() { inst_top=[]; inst_idle=[] }
function scrNTTEFullWorldWeaponDecide(_min,_max,_gold,_exclude) {
    if (!variable_global_exists("ntte_full_weapon_decide") || !is_callable(global.ntte_full_weapon_decide))
        throw "Original NTTE weapon_decide is not integrated"
    // Calling a global function-valued field binds self to global in modern
    // GML. Keep the actual event controller, including native area callbacks.
    var _provider=global.ntte_full_weapon_decide
    return _provider(_min,_max,_gold,_exclude,self)
}
function scrNTTEFullRavenArenaCreate() {
    var _w=6+ceil(GameCont.loops/2.5),_h=_w,_floor_dis=GameCont.subarea==3 ? -16:0
    var _tops=[],_idle=[],_wep_dis=random(12),_wep_dir=random(360)
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(spawn_x,spawn_y,32,Floor,_w,_h,"round",60,_floor_dis)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y
        repeat(3) instance_create(_cx,_cy,TopDecalScrapyard)
        for(var _x=_room.x1;_x<_room.x2;_x+=16) for(var _y=_room.y1;_y<_room.y2;_y+=16) {
            var _px=_x+8,_py=_y+8
            if ((_px<_room.x1+64 || _px>_room.x2-64) && (_py<_room.y1+64 || _py>_room.y2-64)) {
                var _sx=(_x<=_room.x1 || _x>=_room.x2-16) ? sign(_px-_cx):0
                var _sy=(_y<=_room.y1 || _y>=_room.y2-16) ? sign(_py-_cy):0
                if ((_sx!=0 || _sy!=0) && position_meeting(_px+16*_sx,_py+16*_sy,Wall)) {
                    var _cornerx=_px<_cx ? _room.x1:_room.x2-32,_cornery=_py<_cy ? _room.y1:_room.y2-32
                    if (!collision_rectangle(_cornerx,_cornery,_cornerx+31,_cornery+31,Floor,false,false)) instance_create(_x,_y,Wall)
                }
            }
        }
        with (Wall) if (place_meeting(x,y,Floor) && !collision_line(_cx,_cy,(bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,Wall,false,true)) {
            if (random(4)<1) {
                var _top=scrNTTEFullTopCreate((bbox_left+bbox_right)/2+orandom(2),y-8+orandom(2),NTTEFullTopRaven,0,0)
                array_push(_tops,_top)
            }
        }
        var _angle=random(360),_num=3+ceil(GameCont.loops/4)
        for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
            var _prop=scrNTTEFullTopCreate(_cx,_cy,(GameCont.loops>0 && random(2)<1) ? MeleeFake:Tires,_dir+orandom(40),16)
            if (instance_exists(_prop) && instance_exists(_prop.target)) with (_prop.target) {
                var _top=scrNTTEFullTopCreate(x,y+1,NTTEFullTopRaven,0,0)
                _top.z+=max(0,(sprite_get_bbox_bottom(spr_idle)+1-sprite_get_bbox_top(spr_idle))-5)
                array_push(_tops,_top)
                var _count=3+ceil(GameCont.loops/2)
                for(var _d=_dir;_d<_dir+360;_d+=360/_count) {
                    // Both coordinates intentionally use lengthdir_x in source.
                    _top=scrNTTEFullTopCreate(x+lengthdir_x(24,_d),y+lengthdir_x(24,_d),NTTEFullTopRaven,_d+orandom(40),-1)
                    array_push(_tops,_top)
                }
            }
        }
        if (instance_exists(scrNTTEFullWorldEventGet("FirePit"))) {
            scrNTTEFullWorldCreateRequired("TrapSpin",_cx,_cy); _wep_dis+=32
        }
        else {
            if (instance_exists(BecomeScrapBoss)) {
                var _dog=instance_nearest(_cx,_cy,BecomeScrapBoss); _dog.x=_cx; _dog.y=_cy; _wep_dis+=48
            }
            if (!instance_exists(BecomeScrapBoss) || GameCont.loops>0) {
                var _objects=[choose(Raven,Salamander,Exploder),choose(Sniper,MeleeFake)]
                _angle=random(360); _num=4*(1+GameCont.loops)
                if (GameCont.loops>0) array_push(_objects,choose(NTTEFullPelican,BuffGator))
                for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
                    var _index=array_length(_idle)
                    if (_index>=array_length(_objects)) _index=irandom(array_length(_objects)-1)
                    var _new=instance_create(_cx,_cy,_objects[_index])
                    if (instance_exists(_new)) with (_new) {
                        array_push(_idle,id)
                        move_contact_solid(_dir+orandom(20),random_range(16,64))
                        if (random(60)<GameCont.loops) repeat(3+GameCont.loops) array_push(_idle,scrNTTEFullMergedNativeCopy(false))
                    }
                }
            }
        }
        var _gx=_cx+lengthdir_x(_wep_dis,_wep_dir),_gy=_cy+lengthdir_y(_wep_dis,_wep_dir)
        var _ground=scrNTTEFullWorldCreateRequired("WepPickupGrounded",_gx,_gy),_excluded=[]
        with (Player) { array_push(_excluded,wep); array_push(_excluded,bwep) }
        var _weapon=scrNTTEFullWorldWeaponDecide(2,1+GameCont.hard,false,_excluded)
        _ground.target=scrWeaponPickupCreate(_gx,_gy,_weapon,true)
        _ground.target.ammo=true; _ground.target.roll=true
    }
    scrNTTEFullFloorResetAlign()
    inst_top=_tops; inst_idle=_idle
    for(var _i=0;_i<array_length(inst_top);++_i) if (instance_exists(inst_top[_i])) inst_top[_i].jump_time=-1
    return _room
}
function scrNTTEFullRavenArenaStep() {
    var _kept=[]
    for(var _i=0;_i<array_length(inst_idle);++_i) {
        var _inst=inst_idle[_i]
        if (!instance_exists(_inst) || _inst.sprite_index==_inst.spr_hurt) continue
        array_push(_kept,_inst)
        with (_inst) {
            if (variable_instance_exists(id,"walk")) { if (walk>0) walk-=4*timescale }
            else direction=point_direction(x,y,other.x,other.y)+angle_difference(direction,point_direction(x,y,other.x,other.y))*power(1-0.04,timescale)
        }
    }
    inst_idle=_kept
    if (array_length(inst_top)>0) {
        var _p=instance_nearest(x,y,Player)
        if (instance_exists(_p) && point_distance(x,y,_p.x,_p.y)<96) {
            var _time=60
            for(var _i=0;_i<array_length(inst_top);++_i) if (instance_exists(inst_top[_i])) with (inst_top[_i]) if (jump_time<0) {
                jump_time=_time*(128/point_distance(x,y,other.x,other.y))
                _time+=random_range(15+2400/_time,60)
            }
            inst_idle=[]; inst_top=[]
        }
    }
}
function scrNTTEFullRavenArenaControlSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_p=instance_find(Player,0),_px=_p.x,_py=_p.y
    var _event=instance_create(30000,30000,NTTEFullWorldEvent)
    with (_event) scrNTTEFullRavenArenaSetup()
    var _enemy=instance_create(30024,30000,Raven); _enemy.walk=20; _enemy.sprite_index=_enemy.spr_idle
    _event.inst_idle=[_enemy]
    var _r=instance_create(30128,30000,NTTEFullTopRaven),_top=scrNTTEFullTopCreate(_r.x,_r.y,_r,0,0)
    _top.jump_time=-1; _event.inst_top=[_top]
    _p.x=30200; _p.y=30000
    with (_event) scrNTTEFullRavenArenaStep()
    assert(abs(_enemy.walk-(20-4*timescale))<=0.00001 && _top.jump_time==-1 && array_length(_event.inst_idle)==1,"RavenArena did not hold enemies/negative spectator jump_time while player far")
    _enemy.sprite_index=_enemy.spr_hurt
    with (_event) scrNTTEFullRavenArenaStep()
    assert(array_length(_event.inst_idle)==0,"RavenArena did not release a hurt idle opponent")
    _p.x=30000; _p.y=30000
    var _distance=point_distance(_top.x,_top.y,_event.x,_event.y)
    with (_event) scrNTTEFullRavenArenaStep()
    assert(abs(_top.jump_time-60*128/_distance)<=0.00001 && array_length(_event.inst_top)==0,"RavenArena did not stagger audience source60*128/distance or clear controller queue")
    _p.x=_px; _p.y=_py
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD RAVEN ARENA IDLE HOLD/HURT RELEASE/PLAYER96RADIUS/SOURCE DISTANCE-STAGGERED SPECTATOR FLIGHT OK; ARENA BUILD AND WEAPON SELECTION SEPARATE")
}
function scrNTTEFullRavenArenaBuilderSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area,_loops=GameCont.loops,_subarea=GameCont.subarea
    GameCont.area=area_scrapyards; GameCont.loops=0; GameCont.subarea=1
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,34000,34000)
    scrNTTEFullFloorFill(34000,34000,9)
    var _event=instance_create(34000,34000,NTTEFullWorldEvent),_room=noone
    _event.spawn_x=34016; _event.spawn_y=34016
    with (_event) { scrNTTEFullRavenArenaSetup(); _room=scrNTTEFullRavenArenaCreate() }
    assert(is_struct(_room) && _room.x2-_room.x1==192 && _room.y2-_room.y1==192
        && array_length(_room.floors)==32,"RavenArena original loop0 rounded6x6 room changed")
    assert(array_length(_event.inst_top)>=12,"RavenArena omitted original3x4 back-row spectators")
    for(var _i=0;_i<array_length(_event.inst_top);++_i) {
        var _top=_event.inst_top[_i]
        assert(instance_exists(_top) && _top.type==RavenFly && _top.jump_time==-1
            && instance_is(_top.target,NTTEFullTopRaven),"RavenArena spectator is not an actual held RavenFly TopRaven")
    }
    if (!instance_exists(BecomeScrapBoss)) assert(array_length(_event.inst_idle)==4,"RavenArena source loop0 four opponents changed")
    var _grounds=scrNTTEFullInstances(NTTEFullWepPickupGrounded),_newgrounds=[]
    for(var _i=0;_i<array_length(_grounds);++_i) if (array_get_index(_snapshot,_grounds[_i])<0) array_push(_newgrounds,_grounds[_i])
    assert(array_length(_newgrounds)==1,"RavenArena did not create exactly one source grounded weapon")
    var _ground=_newgrounds[0],_weapon=_ground.target
    assert(instance_exists(_weapon) && instance_is(_weapon,WepPickup) && _weapon.ammo && _weapon.roll,
        "RavenArena grounded reward omitted actual pickup/ammo/roll")
    with (Player) assert(_weapon.wep!=wep && _weapon.wep!=bwep,"RavenArena reward ignored held-weapon exclusions")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_area; GameCont.loops=_loops; GameCont.subarea=_subarea
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD RAVEN ARENA ACTUAL6x6ROUND/32FLOORS/BACKROW RAVENFLY TOPS/FOUR OPPONENTS/REAL GROUNDED EXCLUSION REWARD OK; FIREPIT COMBINATION SEPARATE")
}
