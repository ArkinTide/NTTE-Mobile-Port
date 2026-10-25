// teevents213..727, tepickups353..407. Shared source chest modifiers are used
// rather than creating unmodified replacement loot.
function scrNTTEFullBackpackerCreate() {
    var _type=irandom(array_length(scrNTTERefSprite("BackpackerIdle"))-1)
    spr_idle=scrNTTERefSprite("BackpackerIdle",_type); spr_hurt=scrNTTERefSprite("BackpackerHurt",_type); spr_dead=mskNone
    sprite_index=spr_idle; mask_index=mskBandit; max_hp=5; size=1; depth=-1; wep="crabbone"
}
function scrNTTEFullBackpackerAfterCreate() { spr_shadow_y=-2; snd_hurt=sndHitRock; snd_dead=sndHitRock; raddrop=2; team=team_enemy }
function scrNTTEFullBackpackerDeath() {
    if (hp>0) return;
    if (wep!=wep_none) { var _bone=scrWeaponPickupCreate(x,y,wep); _bone.ammo=true }
    repeat(8) {
        var _dust=instance_create(x+orandom(4),y+orandom(4),Dust)
        // BEGIN NTTE BACKPACKER CONSTRUCTOR EFFECT LIFETIME
        with (_dust) { direction=random(360); speed=random(4)*timescale }
        // END NTTE BACKPACKER CONSTRUCTOR EFFECT LIFETIME
    }
    repeat(6) {
        var _pickup=scrNTTEFullWorldCreateRequired("BonePickup",x,y)
        with (_pickup) motion_add(random(360),(2+random(3))*timescale)
    }
}
function scrNTTEFullWorldNearestRectPoint(_x1,_y1,_x2,_y2,_objects) {
    var _all=scrNTTEFullInstances(_objects),_near=noone,_distance=infinity,_center_distance=infinity,_cx=(_x1+_x2)/2,_cy=(_y1+_y2)/2
    for(var _i=0;_i<array_length(_all);++_i) with (_all[_i]) {
        var _d=point_distance(x,y,clamp(x,_x1,_x2),clamp(y,_y1,_y2)),_c=point_distance(x,y,_cx,_cy)
        if (_d<_distance || (_d==_distance && _c<_center_distance)) { _near=id; _distance=_d; _center_distance=_c }
    }
    return _near
}
function scrNTTEFullBlockedRoomSetup() {
    var _dummy=GameCont.subarea<3 && scrNTTEFullValue(GameCont,"ntte_bigbandit_spawn",0)<=0
    var _roll=(5+_dummy)-random(5+_dummy)
    type=_roll<=2 ? "Chest":(_roll<=3 ? "Scorpion":(_roll<=4 ? "Maggot":(_roll<=5 ? "Skull":"Dummy")))
    dummy_spawn=1; dummy_music=false; dummy_target=noone; dummy_retry=0
}
function scrNTTEFullBlockedRoomEntrance(_room,_w,_h) {
    var _cx=_room.x,_cy=_room.y,_ow=_w*16,_oh=_h*16,_floor_dis=32
    var _angle=round(point_direction(_room.xstart,_room.ystart,_room.x,_room.y)/90)*90
    for(var _dir=_angle;_dir<_angle+360;_dir+=90) {
        var _x=_room.x+lengthdir_x(_ow+_floor_dis+1,_dir),_y=_room.y+lengthdir_y(_oh+_floor_dis+1,_dir)
        var _ox=abs(lengthdir_x(_ow+1,_dir-90)),_oy=abs(lengthdir_y(_oh+1,_dir-90))
        var _touch=scrNTTEFullRectInstances(_x-_ox,_y-_oy,_x+_ox,_y+_oy,Floor)
        if (array_length(_touch)==0) continue
        var _side=_dir mod 180==0,_door_dis=(_side ? _h:_w)*32,_door_w=(_side ? _floor_dis:_door_dis)/32,_door_h=(_side ? _door_dis:_floor_dis)/32
        var _dx=_room.x+lengthdir_x(_ow+_floor_dis-8,_dir),_dy=_room.y+lengthdir_y(_oh+_floor_dis-8,_dir)
        _cx+=lengthdir_x(_floor_dis/2-8,_dir); _cy+=lengthdir_y(_floor_dis/2-8,_dir)
        scrNTTEFullFloorFill(_x-lengthdir_x(_floor_dis/2+1,_dir),_y-lengthdir_y(_floor_dis/2+1,_dir),_door_w,_door_h)
        var _jx=_room.x+orandom(1),_jy=_room.y+orandom(1),_near=scrNTTEFullWorldNearestRectBBox(_jx,_jy,_jx,_jy,_touch),_barrel=noone
        if (instance_exists(_near)) {
            var _walls=scrNTTEFullRectInstances(_near.bbox_left,_near.bbox_top,_near.bbox_right-1,_near.bbox_bottom-1,Wall)
            for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) if (place_meeting(x,y,_near)) {
                var _debris=scrNTTEFullInstances(Debris); instance_create(x,y,FloorExplo)
                with (Debris) if (array_get_index(_debris,id)<0) instance_destroy(id,false)
                instance_destroy()
            }
            _barrel=instance_create((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,Barrel)
            with (_barrel) { size=2; move_contact_solid(point_direction(x,y,_dx,_dy)+orandom(60),8); xprevious=x; yprevious=y }
        }
        var _wall=[]
        for(var _dis=8;_dis<_door_dis;_dis+=16) {
            var _new=instance_create(_dx+lengthdir_x(_dis-_door_dis/2,_dir-90)-8,_dy+lengthdir_y(_dis-_door_dis/2,_dir-90)-8,Wall)
            with (_new) if (!position_meeting((bbox_left+bbox_right)/2+lengthdir_x(16,_dir),(bbox_top+bbox_bottom)/2+lengthdir_y(16,_dir),Wall)) array_push(_wall,id)
        }
        if (array_length(_wall)>0) {
            var _start=instance_exists(_barrel) ? array_get_index(_wall,scrNTTEFullWorldNearestRectBBox(_barrel.x,_barrel.y,_barrel.x,_barrel.y,_wall)):irandom(array_length(_wall)-1)
            for(var _i=0;_i<array_length(_wall);++_i) {
                var _v=_wall[(_start+_i) mod array_length(_wall)],_others=[]
                for(var _j=0;_j<array_length(_wall);++_j) if (_wall[_j]!=_v) array_push(_others,_wall[_j])
                _others=scrNTTEFullRectInstances(_v.bbox_left-1,_v.bbox_top-1,_v.bbox_right,_v.bbox_bottom,_others)
                var _nx=(_v.bbox_left+_v.bbox_right)/2+orandom(1),_ny=(_v.bbox_top+_v.bbox_bottom)/2+orandom(1)
                var _next=scrNTTEFullWorldNearestRectBBox(_nx,_ny,_nx,_ny,_others)
                if (instance_exists(_next)) {
                    var _wx=(_v.bbox_left+_v.bbox_right+_next.bbox_left+_next.bbox_right)/4,_wy=(_v.bbox_top+_v.bbox_bottom+_next.bbox_top+_next.bbox_bottom)/4
                    var _pair=[_v,_next]
                    for(var _j=0;_j<2;++_j) with (_pair[_j]) {
                        sprite_index=scrNTTERefSprite("Wall1BotRubble"); topspr=scrNTTERefSprite("Wall1TopRubble"); outspr=scrNTTERefSprite("Wall1OutRubble")
                        image_index=round(point_direction((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,_wx,_wy)/90); topindex=image_index; outindex=image_index
                    }
                    break
                }
            }
        }
        if (instance_exists(_barrel)) {
            var _bros=scrNTTEFullRectInstances(_barrel.bbox_left,_barrel.bbox_top,_barrel.bbox_right-1,_barrel.bbox_bottom-1,[chestprop,hitme])
            for(var _i=0;_i<array_length(_bros);++_i) with (_bros[_i]) if (id!=_barrel && place_meeting(x,y,_barrel) && scrNTTEFullWorldBudge(id,_barrel)) { xstart=x; ystart=y }
        }
        if (random(3)<1) break
    }
    return [_cx,_cy]
}
function scrNTTEFullBlockedRoomCreate() {
    var _w=2,_h=2,_before=scrNTTEFullInstances(all)
    switch(type) {
        case "Chest": case "Dummy":
            var _size=6; _w=1+irandom(_size-1); _h=1+irandom(_size-_w)
            if (type=="Chest") { _w=irandom_range(1,_w); _h=irandom_range(1,_h) }
            break
        case "Maggot": _w=irandom_range(2,3); _h=_w; scrNTTEFullFloorSetStyle(true); break
        case "Scorpion":
            if (random(4)<1) { _w=1; _h=_w }
            else { _w=irandom_range(2,3); _h=irandom_range(2,3) }
            break
        case "Skull": _w=irandom_range(2,3)+(random(3)<1); _h=irandom_range(2,3); break
    }
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(spawn_x,spawn_y,32,Floor,_w,_h,"",0,32)
    if (is_struct(_room)) {
        var _decal=_room.floors
        if (array_length(_decal)>0) {
            var _tile=_decal[irandom(array_length(_decal)-1)]
            instance_create((_tile.bbox_left+_tile.bbox_right)/2,(_tile.bbox_top+_tile.bbox_bottom)/2,TopDecalDesert)
        }
        var _center=scrNTTEFullBlockedRoomEntrance(_room,_w,_h),_cx=_center[0],_cy=_center[1]
        switch(type) {
            case "Chest":
                if ((_room.x!=_cx) ^^ (_room.y!=_cy)) {
                    if (_w>_h) _cx=_room.x+(_w-_h)*16*sign(_room.x-_cx)
                    if (_h>_w) _cy=_room.y+(_h-_w)*16*sign(_room.y-_cy)
                }
                var _chests=[],_all=scrNTTEFullInstances([chestprop,RadChest,Mimic,SuperMimic])
                for(var _i=0;_i<array_length(_all);++_i) with (_all[_i]) {
                    if (object_index!=RadMaggotChest && place_meeting(x,y,Floor) && !position_meeting(x,y,PortalClear)) array_push(_chests,id)
                }
                var _near=scrNTTEFullWorldNearestRectPoint(_room.x1,_room.y1,_room.x2,_room.y2,_chests)
                if (instance_exists(_near)) {
                    instance_create(_near.x,_near.y,Cactus)
                    var _bandits=scrNTTEFullRectInstances(_near.bbox_left,_near.bbox_top,_near.bbox_right-1,_near.bbox_bottom-1,Bandit)
                    for(var _i=0;_i<array_length(_bandits);++_i) with (_bandits[_i]) if (place_meeting(x,y,_near)) { x=_cx; y=_cy; xprevious=x; yprevious=y }
                    with (_near) { x=_cx; y=_cy; xprevious=x; yprevious=y }
                }
                break
            case "Maggot":
                var _obj=choose(BonePile,MaggotSpawn,RadMaggotChest,AmmoChest,WeaponChest)
                var _num=((_obj==chestprop||object_is_ancestor(_obj,chestprop)||_obj==RadChest||object_is_ancestor(_obj,RadChest)) ? 1+scr_skill_get(mut_open_mind):1)
                repeat(max(0,_num)) scrNTTEFullLairChestCreate(_cx+orandom(4),_cy+orandom(4),_obj,true)
                repeat(irandom_range(3,5)) instance_create(_room.x+orandom(1),_room.y+orandom(1),BigMaggot)
                repeat(irandom_range(6,8)) instance_create(_room.x+orandom(1),_room.y+orandom(1),Maggot)
                for(var _i=0;_i<array_length(_decal);++_i) with (_decal[_i]) {
                    var _fly=instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),NTTEFullFlySpin)
                    if(random(2)<1) { _fly.target=instance_nearest(_fly.x,_fly.y,Maggot); _fly.target_x=orandom(8); _fly.target_y=-random(4) }
                }
                break
            case "Scorpion":
                instance_create(_cx,_cy,NTTEFullBabyScorpionGold)
                if (_w>1 || _h>1) { instance_create(_cx,_cy,GoldScorpion); if (random(2)<((_w-2)+(_h-2))) instance_create(_cx,_cy,Scorpion); instance_create(_cx+orandom(_w*8),_cy+orandom(_h*8),NTTEFullBackpacker) }
                instance_create(_cx,_cy,TopDecalDesert)
                for(var _i=0;_i<array_length(_decal);++_i) with (_decal[_i]) instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Detail)
                break
            case "Skull":
                scrNTTEFullBlockedRoomSkull(_room,_w,_h,_cx,_cy,_before)
                break
            case "Dummy":
                var _target=instance_create(_cx,_cy,TutorialTarget); _target.max_hp=8; _target.hp=8; _target.team=team_enemy
                dummy_target=_target
                repeat(4) with (instance_create(_cx,_cy,TopDecalDesert)) if (place_meeting(x,y,TopPot)) instance_destroy()
                var _walls=[],_all=scrNTTEFullInstances([Wall,TopSmall])
                for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0 && _all[_i].sprite_index!=scrNTTERefSprite("Wall1BotRubble")) array_push(_walls,_all[_i])
                var _angle=random(360)
                for(var _dir=_angle;_dir<_angle+360;_dir+=random_range(30,45)*((max(_w,_h)<=1) ? 2:1)) {
                    var _dis=random(28),_near=scrNTTEFullWorldNearestRectBBox(_cx+lengthdir_x(_w*16+_dis,_dir),_cy+lengthdir_y(_h*16+_dis,_dir),_cx+lengthdir_x(_w*16+_dis,_dir),_cy+lengthdir_y(_h*16+_dis,_dir),_walls)
                    if (instance_exists(_near)) scrNTTEFullWallEnemyCreateAt((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2)
                }
                break
        }
        x=_cx; y=_cy
    }
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    return _room
}
function scrNTTEFullBlockedRoomSkull(_room,_w,_h,_cx,_cy,_before) {
    var _can_skull=true,_boss_object=asset_get_index("NTTEFullCoastBossBecome")
    if (object_exists(_boss_object)) with (_boss_object) if (_can_skull) {
        _can_skull=false; xstart=_cx+orandom(4); ystart=_cy+orandom(4)
        part=min(part+1,sprite_get_number(spr_idle)-2)
        with (Detail) if (array_get_index(_before,id)<0) instance_destroy()
        var _last=GameCont.area; GameCont.area=201
        repeat(1+irandom(max(_w,_h))) instance_create(random_range(_room.x1+4,_room.x2-4),random_range(_room.y1+4,_room.y2-8),Detail)
        GameCont.area=_last
    }
    if (_can_skull) {
        instance_create(_cx,_cy,NTTEFullCowSkull)
        var _can_tent=true,_floors=array_shuffle(_room.floors)
        for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
            var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2,_fw=bbox_right-bbox_left,_side=sign(_fx-_room.x)
            if (_side==0) _side=choose(-1,1)
            if (_can_tent && !place_meeting(x+_fw*_side,y,Floor)) {
                _can_tent=false
                with (instance_create(_fx+(_fw/2-irandom_range(3,5))*_side,_fy-random(2),NTTEFullBanditTent)) {
                    spr_idle=scrNTTERefSprite("BanditTentWallIdle"); spr_hurt=scrNTTERefSprite("BanditTentWallHurt"); spr_dead=scrNTTERefSprite("BanditTentWallDead"); image_xscale=-_side
                }
                if (random(3)<1) with (instance_create(_cx+orandom(8),_cy+orandom(8),NTTEFullBanditHiker)) can_path=false
            }
            else if (random(4)<1 && !place_meeting(x,y,hitme)) instance_create(_fx,_fy,Cactus)
        }
    }
}
// Original PC gml_Object_WantBoss_Alarm_0, VA009f3eb0..009f5fa1.
// Dummy calls this once while its actual Players occupy the authored 112px ray.
// Epsilon's ordinary Alarm uses an OLD x/y viewport rectangle and 100..124px
// Floor adjacency instead; that is not the native dependency NTTE was authored
// against. Keep this adaptation local to the NTTE Dummy call, not ordinary AI.
function scrNTTEFullBlockedRoomWantBossAlarm() {
    scrTarget()
    if (instance_exists(target)) {
        // PC uses the selected player's synchronized view center. Epsilon's
        // single local camera is the corresponding native view provider.
        x=view_xview+view_width/2; y=view_yview+view_height/2
        var _tx=target.x,_ty=target.y
        // PC iterates GameCont.lisWalls. Epsilon has no such cached list;
        // native with(Wall) supplies the corresponding actual live geometry.
        with (Wall) {
            var _distance=point_distance(x,y,_tx,_ty)
            if (_distance>110 && _distance<120 && !collision_line(x,y,_tx,_ty,Wall,true,true)
                && ((!place_free(x-16,y) && !place_free(x+16,y))
                    || (!place_free(x,y+16) && !place_free(x,y-16)))) instance_create(x,y,CanSpawnBoss)
        }
        if (instance_exists(CanSpawnBoss)) {
            // Preserve the PC call order: candidate x then y (random60), and
            // native instance_create evaluates spawn y then x (random4).
            var _choose_x=_tx+random(60)-30,_choose_y=_ty+random(60)-30
            with (instance_nearest(_choose_x,_choose_y,CanSpawnBoss)) {
                var _spawn_y=y+random(4)-2,_spawn_x=x+random(4)-2
                instance_create(_spawn_x,_spawn_y,BanditBoss)
            }
            with (CanSpawnBoss) instance_destroy()
            number--
            if (!number) instance_destroy()
        }
    }
    alarm[0]=1
}
function scrNTTEFullBlockedRoomStep() {
    if (lockstep_stop || type!="Dummy") return;
    if (instance_exists(WantBoss)) {
        if (dummy_spawn>0) {
            var _retry=scrNTTEFullValue(id,"dummy_retry",0)
            if (_retry>0) { dummy_retry=max(0,_retry-timescale); return }
            // Native TutorialTarget.Create moves up to12px away from its
            // authored center. That movement is not a broken target.
            if (!instance_exists(dummy_target)) {
                var _walls=[],_players=[]
                with (Wall) if ((!place_free(x-16,y) && !place_free(x+16,y)) || (!place_free(x,y+16) && !place_free(x,y-16))) {
                    if (array_length(scrNTTEFullRectInstances(bbox_left-1,bbox_top-1,bbox_right,bbox_bottom,TopSmall))>0) array_push(_walls,id)
                }
                var _px=x+orandom(16),_py=y+orandom(16),_near=scrNTTEFullWorldNearestRectBBox(_px,_py,_px,_py,_walls)
                var _trace=os_type==os_windows && scrNTTEFullSmokeEnabled()
                if(_trace) ntte_dummy_spawn_trace={wall_count:array_length(_walls),wall:_near,
                    wall_xy:instance_exists(_near)?[_near.x,_near.y]:[],want_before:[],want_after:[],players:[]}
                if (instance_exists(_near)) with (_near) {
                    for(var _dir=0;_dir<360;_dir+=4) {
                        var _fx=x+lengthdir_x(112,_dir),_fy=y+lengthdir_y(112,_dir)
                        if (!collision_line(x,y,_fx,_fy,Wall,true,true)) {
                            with (Player) { array_push(_players,[id,x,y]); x=_fx; y=_fy }
                            break
                        }
                    }
                }
                var _before=scrNTTEFullInstances(BanditBoss)
                if(_trace) for(var _i=0;_i<array_length(_players);++_i) {
                    var _p=_players[_i][0]
                    array_push(ntte_dummy_spawn_trace.players,{id:_p,before:[_players[_i][1],_players[_i][2]],moved:[_p.x,_p.y]})
                }
                with (WantBoss) {
                    var _last_sub=GameCont.subarea,_last_alarm=alarm[0]
                    if(_trace) array_push(other.ntte_dummy_spawn_trace.want_before,
                        {id:id,xy:[x,y],target:target,alarm0:alarm[0],number:number,enemies:enemies,losthope:losthope})
                    scrNTTEFullBlockedRoomWantBossAlarm()
                    GameCont.subarea=_last_sub
                    if (instance_exists(id)) {
                        if(_trace) array_push(other.ntte_dummy_spawn_trace.want_after,
                            {id:id,xy:[x,y],target:target,alarm0:alarm[0],number:number,enemies:enemies,losthope:losthope})
                        alarm[0]=_last_alarm
                    }
                }
                for(var _i=0;_i<array_length(_players);++_i) {
                    var _pos=_players[_i]
                    if (instance_exists(_pos[0])) { _pos[0].x=_pos[1]; _pos[0].y=_pos[2] }
                }
                var _spawned=false
                with (BanditBoss) if (array_get_index(_before,id)<0) {
                    _spawned=true
                    var _target=instance_nearest(x,y,Player)
                    if (instance_exists(_target)) scrNTTESewerLook(point_direction(x,y,_target.x,_target.y))
                    hitid=[sprTargetIdle,"BANDIT AMBUSH"]
                    GameCont.ntte_bigbandit_spawn=scrNTTEFullValue(GameCont,"ntte_bigbandit_spawn",0)+1
                }
                // No candidate wall means the native spawn may fail. Retry
                // without consuming the event or arming a false win jingle.
                if (_spawned) { dummy_spawn--; dummy_music=true; GameCont.proto=true }
                else dummy_retry=30 // Avoid scanning every wall on each rendered frame.
            }
        }
        else if (dummy_music && GameCont.subarea!=3 && !instance_exists(BanditBoss)) {
            dummy_music=false; with (MusCont) alarm[1]=1
        }
    }
    else if (instance_exists(Portal) && position_meeting(x,y,TutorialTarget)) {
        var _targets=scrNTTEFullRectInstances(x,y,x,y,TutorialTarget)
        for(var _i=0;_i<array_length(_targets);++_i) with (_targets[_i]) if (position_meeting(other.x,other.y,id)) hp=0
    }
}
function scrNTTEFullBackpackerSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_seed=random_get_seed(),_stop=lockstep_stop,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    try {
        lockstep_stop=false
        assert(!scrNTTEFullCrabboneIs("crabbone") && !scrNTTEFullBoneWeaponMetadataHas("crabbone")
            && scrNTTEFullBoneWeaponMetadata("crabbone","name","unhandled")=="unhandled"
            && !scrNTTEFullCrabboneIs("unknown original module"),
            "Native numeric bone predicates coerced a source module string into a numeric range")
        assert(scrNTTEFullWeaponNative("crabbone")==wep_ntte_bone
            && scrNTTEFullWeaponNative(wep_ntte_bone)==wep_ntte_bone,
            "Native inventory boundary did not resolve original crabbone module and preserve numeric ID")
        var _unknown_rejected=false
        try {scrNTTEFullWeaponNative("unknown original module")}
        catch(_error) {_unknown_rejected=true}
        assert(_unknown_rejected,"Native inventory silently replaced an unknown original weapon module")
        var _cases=["crabbone",wep_ntte_bone,wep_ntte_ancient_artifact,wep_none]
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _before=scrNTTEFullInstances(all),_weapons=instance_number(WepPickup),
                _pickups=instance_number(NTTEFullBonePickup),_b=instance_create(40000+64*_i,40000,NTTEFullBackpacker)
            assert(_b.max_hp==5 && _b.hp==5 && _b.raddrop==2 && _b.team==team_enemy && _b.wep=="crabbone"
                && _b.mask_index==mskBandit,"Backpacker source5HP/2rads/team/bone weapon changed")
            if(_i>0) _b.wep=_cases[_i]
            _b.hp=0
            // Actual inherited prop Begin Step performs Destroy; the source
            // death callback is never invoked directly by this regression.
            with(_b) event_perform(ev_step,ev_step_begin)
            var _expected=_cases[_i]==wep_none?0:1,_drop=noone
            assert(!instance_exists(_b) && instance_number(WepPickup)==_weapons+_expected
                && instance_number(NTTEFullBonePickup)==_pickups+6,
                "Actual Backpacker BeginStep/Destroy omitted exact weapon/six source BonePickups")
            with(WepPickup) if(array_get_index(_before,id)<0) _drop=id
            if(_expected>0) {
                var _raw=_i<2?wep_ntte_bone:wep_ntte_ancient_artifact,
                    _name=_i<2?loc("NTTE:Bone","BONE"):"ANCIENT ARTIFACT",
                    _sprite=_i<2?scrNTTERefSprite("Bone"):scrNTTERefSprite("QuestArtifact",0)
                assert(instance_exists(_drop) && _drop.wep==_raw && is_numeric(_drop.wep) && _drop.ammo
                    && _drop.name==_name && _drop.sprite_index==_sprite
                    && scr_weapon_get_name(_drop.wep)==_name && scr_weapon_get_sprite(_drop.wep)==_sprite,
                    "Actual Backpacker string/numeric/artifact drop lost native weapon/name/art/ammo")
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        var _weapons=instance_number(WepPickup),_pickups=instance_number(NTTEFullBonePickup),
            _b=instance_create(40320,40000,NTTEFullBackpacker)
        instance_destroy(_b)
        assert(instance_number(WepPickup)==_weapons && instance_number(NTTEFullBonePickup)==_pickups,
            "Nonlethal Backpacker removal incorrectly granted lethal source loot")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        lockstep_stop=_stop;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WORLD BACKPACKER SOURCE5HP/2RADS/TEAM, actual native prop BeginStep/Destroy for source-string bone/numeric bone/numeric artifact/no-weapon, exact real pickup names/art/ammo+six BonePickups, nonlethal exclusion and typed module boundary OK")
}
function scrNTTEFullBlockedRoomSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_desert; scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,41000,41000)
    scrNTTEFullFloorFill(41000,41000,9)
    var _event=instance_create(41000,41000,NTTEFullWorldEvent)
    _event.spawn_x=41016; _event.spawn_y=41016; _event.type="Maggot"
    with (_event) var _room=scrNTTEFullBlockedRoomCreate()
    assert(is_struct(_room) && array_length(scrNTTEFullInstances(BigMaggot))>=3 && array_length(scrNTTEFullInstances(Maggot))>=6,
        "BlockedRoom Maggot branch omitted source big/small maggot population")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD BLOCKED ROOM MAGGOT TYPE/CONNECTED ROOM/POPULATION BRANCH OK; CHEST/SCORPION/SKULL/DUMMY BRANCHES SEPARATE")
}
