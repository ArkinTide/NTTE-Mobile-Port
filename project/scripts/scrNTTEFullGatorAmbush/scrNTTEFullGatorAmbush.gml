// tescrapyard80..233,2761..2885 and teevents1132..1343.
function scrNTTEFullWallCrateCreate() {
    mask_index=mskIcon; sprite_index=scrNTTERefSprite("FloorCrate"); image_speed=0; depth=5
    crate_wall=[]; crate_loot=noone; ntte_crate_reorder=0; ntte_crate_masks=[]
    var _area=GameCont.area; GameCont.area=area_campfire
    for(var _wy=bbox_top;_wy<bbox_bottom;_wy+=16) for(var _wx=bbox_left;_wx<bbox_right;_wx+=16)
        array_push(crate_wall,instance_create(_wx,_wy,Wall))
    GameCont.area=_area
    for(var _i=array_length(crate_wall)-1;_i>=0;--_i) with (crate_wall[_i]) {
        sprite_index=scrNTTERefSprite("WallCrateBot"); topspr=scrNTTERefSprite("WallCrateTop"); outspr=scrNTTERefSprite("WallCrateOut")
        image_index=_i; topindex=_i; outindex=_i
    }
}
function scrNTTEFullWallCrateStep() {
    if (lockstep_stop) return;
    if (ntte_crate_reorder==0) {
        // Original fork/wait0 moves the older surrounding Walls to later
        // instance IDs, suppressing copied collision masks for one yield.
        var _old=scrNTTEFullRectInstances(bbox_left-16,bbox_top-16,bbox_right,bbox_bottom,Wall,true)
        array_sort(_old,true)
        for(var _i=0;_i<array_length(_old);++_i) if (_old[_i].id<id) with (_old[_i]) {
            var _copy=scrNTTEFullMergedNativeCopy(false)
            array_push(other.ntte_crate_masks,[_copy,_copy.mask_index])
            _copy.mask_index=mskNone; instance_destroy(id,false)
        }
        ntte_crate_reorder=1
    }
    else if (ntte_crate_reorder==1) {
        for(var _i=0;_i<array_length(ntte_crate_masks);++_i) {
            var _saved=ntte_crate_masks[_i]
            if (instance_exists(_saved[0]) && _saved[0].mask_index==mskNone) _saved[0].mask_index=_saved[1]
        }
        ntte_crate_masks=[]; ntte_crate_reorder=2
    }
    if (array_length(crate_wall)>0) {
        var _existing=scrNTTEFullInstances(crate_wall)
        if (!instance_exists(crate_loot) && crate_loot!=noone) {
            if (array_equals(crate_wall,_existing)) {
                var _loot=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,[chestprop,RadChest,Mimic,SuperMimic]),_near=noone,_distance=infinity
                for(var _i=0;_i<array_length(_loot);++_i) if (_loot[_i].id>crate_loot) {
                    var _d=point_distance(x,y,_loot[_i].x,_loot[_i].y)
                    if (_d<_distance) { _distance=_d; _near=_loot[_i] }
                }
                crate_loot=_near
            }
            if (!instance_exists(crate_loot)) {
                var _clear=instance_create(x,y,PortalClear)
                _clear.sprite_index=mask_index<0 ? sprite_index:mask_index; _clear.image_xscale=image_xscale; _clear.image_yscale=image_yscale; _clear.image_angle=image_angle
                _existing=[]
                repeat(15) { var _dust=instance_create(x,y,Dust); /* NTTE DUST LIFETIME wall-crate */ if(instance_exists(_dust)) {_dust.direction=random(360); _dust.speed=3*timescale } }
            }
        }
        if (!array_equals(crate_wall,_existing)) {
            crate_wall=_existing; snd_play_hit(sndHammer,0.3)
            if (array_length(crate_wall)==0) snd_play(sndWallBreakJungle,1.2+orandom(0.2),0.5)
        }
    }
}
function scrNTTEFullBigPipeCreate() {
    spr_idle=scrNTTERefSprite("BigPipeBottom"); spr_hurt=scrNTTERefSprite("BigPipeBottomHurt"); spr_dead=scrNTTERefSprite("BigPipeDead")
    spr_top_idle=scrNTTERefSprite("BigPipeTop"); spr_top_hurt=scrNTTERefSprite("BigPipeTopHurt")
    spr_shadow=scrNTTERefSprite("msk.BigPipe"); spr_shadow_y=5; mask_index=spr_shadow
    sprite_index=spr_idle; image_speed=0.4*timescale; image_xscale=choose(-1,1); depth=1
    snd_hurt=sndHitMetal; snd_dead=sndGeneratorBreak; friction=1000*timescale*timescale
    max_hp=110; hp=max_hp; size=4; team=team_none; spawn_count=4; spawn_delay=random_range(150,300)
    hole_inst=scrNTTEFullWorldCreateRequired("ManholeOpen",x,y+8)
    hole_inst.sprite_index=scrNTTERefSprite("BigPipeHole"); hole_inst.visible=false; hole_inst.big=true
}
// Native Gator.Create can replace itself with BuffGator before returning.
// Recover only that new native replacement; keep its authored RNG/Create path.
function scrNTTEFullBigPipeSpawnGator(_x,_y,_object) {
    var _before=_object==Gator?scrNTTEFullInstances(BuffGator):[],
        _gator=instance_create(_x,_y,_object)
    if(instance_exists(_gator)) return _gator;
    if(_object==Gator) with(BuffGator) {
        if(x==_x && y==_y && array_get_index(_before,id)<0) return id;
    }
    return noone;
}

function scrNTTEFullBigPipeStep() {
    if (lockstep_stop) return;
    var _hits=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,hitme),_pipe=id
    for(var _i=0;_i<array_length(_hits);++_i) {
        if(!instance_exists(_pipe)) return;
        if(!instance_exists(_hits[_i])) continue;
        with (_hits[_i]) if (id!=other.id && team!=team_none && !instance_is(id,prop) && place_meeting(x,y,other.id)) {
        motion_add(point_direction((other.bbox_left+other.bbox_right)/2,(other.bbox_top+other.bbox_bottom)/2,x,y),0.5*timescale*timescale)
        // Original CustomEnemy supplies zero contact damage unless a subtype
        // overrides it. Native enemy has no such default (e.g. BoneRaven).
        if (instance_is(id,enemy)) {
            var _melee=scrNTTEFullValue(id,"meleedamage",0)
            if (_melee>0 && size>other.size && scr_can_hit(other.id)) scr_hit(other.id,_melee,hitid)
        }
    }
    }
    if(!instance_exists(_pipe)) return;
    if (sprite_index==spr_hurt && image_index+image_speed>=image_number) { sprite_index=spr_idle; image_index=0 }
    if (!instance_exists(Portal)) {
        if (spawn_delay>0) spawn_delay-=timescale
        else if (spawn_count>0) {
            spawn_count--; spawn_delay=random_range(150,600)
            var _direction=random(360),_floors=scrNTTEFullRectInstances(bbox_left-64,bbox_top-64,bbox_right+63,bbox_bottom+63,Floor,false,true)
            if (array_length(_floors)>0) {
                var _floor=_floors[irandom(array_length(_floors)-1)]
                _direction=point_direction(x,y,(_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2)
            }
            // telib.pool subtracts random(total) from total before walking
            // weights; retain that direction so equal seeds choose the same.
            var _roll=3-random(3),_object=_roll<=1.5 ? Gator:(_roll<=2.5 ? NTTEBabyGator:BuffGator)
            repeat(_object==NTTEBabyGator ? 2:1) {
                var _gator=scrNTTEFullBigPipeSpawnGator(x,y-8,_object)
                if(!instance_exists(_gator)) continue;
                var _toss=instance_create(_gator.x,_gator.y,NTTEFullPalankingToss)
                if(!instance_exists(_toss)) continue;
                _toss.direction=_direction+orandom(10); _toss.speed=random_range(2,4)*timescale; _toss.zspeed=6
                _toss.creator=_gator; _toss.depth=_gator.depth; _toss.mask_index=_gator.mask_index; _toss.spr_shadow_y=_gator.spr_shadow_y
                var _sound=snd_play_hit_big(snd_dead,0)
                if (_sound>=0) audio_sound_pitch(_sound,0.6+orandom(0.2))
            }
            for(var _dir=0;_dir<360;_dir+=30) {
                var _dust=instance_create(x,y-12,Dust); /* NTTE DUST LIFETIME big-pipe */ if(instance_exists(_dust)) {_dust.direction=_dir; _dust.speed=4*timescale; _dust.depth=-9 }
            }
            snd_play_hit(sndSlugger,0.1)
        }
    }
    if (hp<=0) instance_destroy()
}
function scrNTTEFullBigPipeDraw() {
    draw_sprite_ext(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y,image_xscale,image_yscale,0,c_white,1)
    draw_self()
}
function scrNTTEFullBigPipeTopDraw() {
    with (NTTEFullBigPipe) if (visible) draw_sprite_ext(sprite_index==spr_hurt ? spr_top_hurt:spr_top_idle,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullBigPipeDestroy() {
    if (instance_exists(hole_inst)) {
        hole_inst.visible=true; hole_inst.big=false; hole_inst.x=x; hole_inst.y=y; hole_inst.image_xscale=image_xscale
    }
    var _corpse=scrNTTEFullCorpseDrop(id,0,0)
    if (instance_exists(_corpse)) _corpse.depth=4
}
function scrNTTEFullGatorAmbushSetup() {
    with (GenCont) if (goal>0) goal=ceil(goal*0.9)
    with (FloorMaker) if (goal>0) goal=ceil(goal*0.9)
}
function scrNTTEFullGatorAmbushCreate() {
    ntte_grate_build_count=0
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(spawn_x,spawn_y,128,Floor,6,6,"round",0,-64)
    if (is_struct(_room)) {
        var _chests=[],_all=scrNTTEFullInstances([chestprop,RadChest,Mimic,SuperMimic])
        for(var _i=0;_i<array_length(_all);++_i) with (_all[_i]) if (object_index!=RadMaggotChest && place_meeting(x,y,Floor)) array_push(_chests,id)
        var _x1=_room.x1,_x2=_room.x2,_y1=_room.y1,_y2=_room.y2
        var _corners=array_shuffle([[_x1+48,_y1+16],[_x1+16,_y1+48],[_x2-48,_y1+16],[_x2-16,_y1+48],
            [_x1+48,_y2-16],[_x1+16,_y2-48],[_x2-48,_y2-16],[_x2-16,_y2-48]])
        for(var _i=0;_i<array_length(_corners);++_i) {
            var _cx=_corners[_i][0],_cy=_corners[_i][1]
            if (!collision_rectangle(_cx-16,_cy-16,_cx+15,_cy+15,hitme,false,false)
                && !collision_rectangle(_cx-16,_cy-16,_cx+15,_cy+15,Wall,false,false) && array_length(_chests)>0) {
                var _adjacent=0
                for(var _dir=0;_dir<360;_dir+=90) {
                    var _fx=_cx+lengthdir_x(32,_dir),_fy=_cy+lengthdir_y(32,_dir)
                    if (collision_rectangle(_fx-16,_fy-16,_fx+15,_fy+15,Floor,false,false)) _adjacent++
                }
                if (_adjacent<=2) {
                    var _crate=instance_create(_cx,_cy,NTTEFullWallCrate),_at=-1,_distance=infinity
                    for(var _j=0;_j<array_length(_chests);++_j) {
                        var _d=point_distance(_cx,_cy,_chests[_j].x,_chests[_j].y)
                        if (_d<_distance) { _distance=_d; _at=_j }
                    }
                    _crate.crate_loot=_chests[_at]
                    with (_crate.crate_loot) {
                        instance_create(x,y,Pipe); x=_crate.x; y=_crate.y-4; xprevious=x; yprevious=y
                    }
                    array_delete(_chests,_at,1)
                }
            }
        }
        var _big_pipes=irandom_range(2,2),_pipe_num=irandom_range(2,4),_directions=array_shuffle([0,90,180,270])
        for(var _i=0;_i<array_length(_directions);++_i) {
            var _dir=_directions[_i]
            if (_big_pipes-->0) {
                instance_create(_room.x+lengthdir_x(96,_dir),_room.y+lengthdir_y(96,_dir),NTTEFullBigPipe)
                var _grate=scrNTTEFullFloorFill(_room.x+lengthdir_x(48,_dir),_room.y+lengthdir_y(48,_dir),
                    max(2,abs(lengthdir_x(3,_dir))),max(2,abs(lengthdir_y(3,_dir))))
                for(var _j=0;_j<array_length(_grate);++_j) with (_grate[_j]) {
                    sprite_index=scrNTTERefSprite("FloorSewerGrate"); material=3; styleb=true; depth=choose(8,9)
                }
                ntte_grate_build_count+=array_length(_grate)
            }
            else {
                var _obj=array_length(scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,Barrel))>0 ? Pipe:Barrel
                var _prop=instance_create(_room.x+lengthdir_x(96-random_range(16,40),_dir),_room.y+lengthdir_y(96-random_range(16,40),_dir),_obj)
                var _floors=scrNTTEFullRectInstances(_prop.bbox_left,_prop.bbox_top,_prop.bbox_right-1,_prop.bbox_bottom-1,Floor),_dark=false
                with (TopCont) if (variable_instance_exists(id,"darkness") && darkness) _dark=true
                for(var _j=0;_j<array_length(_floors);++_j) with (_floors[_j]) if (place_meeting(x,y,_prop)) {
                    sprite_index=scrNTTERefSprite(color_get_value(scrAreaGetBackroundColor(GameCont.area))<170 || _dark ? "FloorSewerDirt":"FloorSewerLightDirt")
                    depth=9; material=1; traction=0.45
                }
            }
        }
    }
    scrNTTEFullFloorResetAlign()
    snd_play(sndSkillPick,0.75,1.2); snd_play(sndIDPDNadeLoad,1.15)
    return _room
}
function scrNTTEFullWallCrateSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_crate=instance_create(36000,36000,NTTEFullWallCrate)
    assert(array_length(_crate.crate_wall)==4 && _crate.mask_index==mskIcon && _crate.depth==5,"WallCrate original32x32/four wall tiles/pallet changed")
    for(var _i=0;_i<4;++_i) {
        var _wall=_crate.crate_wall[_i]
        assert(_wall.sprite_index==scrNTTERefSprite("WallCrateBot") && _wall.topspr==scrNTTERefSprite("WallCrateTop")
            && _wall.outspr==scrNTTERefSprite("WallCrateOut") && _wall.image_index==_i && _wall.topindex==_i && _wall.outindex==_i,
            "WallCrate source wall indices/art changed")
    }
    with (_crate) { scrNTTEFullWallCrateStep(); scrNTTEFullWallCrateStep() }
    instance_destroy(_crate.crate_wall[0],false)
    with (_crate) scrNTTEFullWallCrateStep()
    assert(array_length(_crate.crate_wall)==3,"WallCrate did not track a genuinely broken wall")
    var _loot=instance_create(_crate.x,_crate.y,WeaponChest); _crate.crate_loot=_loot
    instance_destroy(_loot,false)
    var _clear=instance_number(PortalClear)
    with (_crate) scrNTTEFullWallCrateStep()
    assert(array_length(_crate.crate_wall)==0 && instance_number(PortalClear)==_clear+1,"WallCrate did not actually clear remaining crate when loot was taken")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD WALL CRATE FOUR ACTUAL WALLS/ORIGINAL SPRITE INDICES/DEFERRED REORDER/BROKEN TILE TRACKING/LOOT REMOVAL PORTAL CLEAR OK")
}
function scrNTTEFullBigPipeSmoke() {
    scrNTTEFullBigPipeConstructorNativeTests()
    var _snapshot=scrNTTEFullInstances(all),_pipe=instance_create(37000,37000,NTTEFullBigPipe)
    assert(_pipe.hp==110 && _pipe.size==4 && _pipe.team==team_none && _pipe.spawn_count==4
        && _pipe.spawn_delay>=150 && _pipe.spawn_delay<=300,"BigPipe source110HP/size4/neutral/four waves/initial delay changed")
    assert(instance_is(_pipe.hole_inst,NTTEFullManholeOpen) && !_pipe.hole_inst.visible && _pipe.hole_inst.big
        && _pipe.hole_inst.sprite_index==scrNTTERefSprite("BigPipeHole"),"BigPipe omitted actual hidden big ManholeOpen")
    _pipe.spawn_delay=0
    var _count=instance_number(NTTEFullPalankingToss)
    with (_pipe) scrNTTEFullBigPipeStep()
    var _spawned=instance_number(NTTEFullPalankingToss)-_count
    assert(_pipe.spawn_count==3 && _pipe.spawn_delay>=150 && _pipe.spawn_delay<=600 && _spawned>=1 && _spawned<=2,
        "BigPipe did not release actual source Gator group/delay")
    with (NTTEFullPalankingToss) if (array_get_index(_snapshot,id)<0) assert(instance_exists(creator) && zspeed==6
        && (instance_is(creator,Gator) || instance_is(creator,BuffGator) || instance_is(creator,NTTEBabyGator)),"BigPipe gators lack original airborne launch wrapper")
    // Reproduce the naturally scheduled RavenArena overlap with real actors.
    // A zero-melee CustomEnemy must still be pushed, without crashing/damage.
    var _contact=instance_create(37200,37200,NTTEFullBigPipe),_raven=instance_create(37201,37200,NTTEFullBoneRaven)
    _raven.speed=0
    with (_contact) assert(place_meeting(x,y,_raven),"BigPipe real BoneRaven regression fixture does not overlap")
    var _hp=_contact.hp
    with (_contact) scrNTTEFullBigPipeStep()
    assert(_contact.hp==_hp && _raven.speed>0,"BigPipe omitted source zero-melee actor push or applied contact damage")
    instance_destroy(_raven,false)
    // Keep the original positive contact-damage and size gates observable.
    var _dog=instance_create(37201,37200,DogGuardian)
    assert(_dog.meleedamage==6 && _dog.size==5,"BigPipe real DogGuardian source fixture changed")
    _contact.nexthurt=current_frame
    with (_contact) scrNTTEFullBigPipeStep()
    assert(_contact.hp==_hp-6,"BigPipe discarded real positive contact damage while supplying zero default")
    _contact.size=5;_contact.nexthurt=current_frame
    with (_contact) scrNTTEFullBigPipeStep()
    assert(_contact.hp==_hp-6,"BigPipe ignored original strictly larger-attacker size gate")
    var _hole=_pipe.hole_inst
    _pipe.hp=0; instance_destroy(_pipe)
    assert(instance_exists(_hole) && _hole.visible && !_hole.big && _hole.x==37000 && _hole.y==37000,"BigPipe destruction failed real Manhole reveal")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD BIG PIPE SOURCE110HP/NEUTRAL/FOUR DELAYED WAVES/ACTUAL GATOR+TOSS/REAL MANHOLE REVEAL/REAL BONERAVEN ZERO-MELEE PUSH/DOGGUARDIAN SIZE+DAMAGE GATES OK; BABY AI/NATURAL AMBUSH COMBAT SEPARATE")
}
function scrNTTEFullGatorAmbushSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_desert
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,38000,38000)
    scrNTTEFullFloorFill(38000,38000,9)
    var _event=instance_create(38000,38000,NTTEFullWorldEvent),_room=noone,_before=instance_number(NTTEFullBigPipe)
    _event.spawn_x=38016; _event.spawn_y=38016
    with (_event) _room=scrNTTEFullGatorAmbushCreate()
    assert(is_struct(_room) && _room.x2-_room.x1==192 && _room.y2-_room.y1==192,"GatorAmbush original6x6 room dimensions changed")
    assert(instance_number(NTTEFullBigPipe)==_before+2,"GatorAmbush did not create exactly two real BigPipes")
    var _grates=0
    with (Floor) if (array_get_index(_snapshot,id)<0 && sprite_index==scrNTTERefSprite("FloorSewerGrate")) {
        _grates++; assert(material==3 && styleb && (depth==8 || depth==9),"GatorAmbush grate source material/style/depth changed")
    }
    // The source's remaining Pipe/Barrel dirt pass may overwrite nearby grate
    // tiles after both corridors were built. Verify construction separately.
    assert(_event.ntte_grate_build_count==12 && _grates>0 && _grates<=12,"GatorAmbush source two3x2 grate construction changed")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD GATOR AMBUSH SOURCE6x6/EXACT TWO BIG PIPES/TWELVE GRATES/MATERIAL+STYLE OK; CHEST CORNERS/NATURAL CRIME LOOP SEPARATE")
}

// Real native Gator replacement and complete delayed BigPipe waves.
function scrNTTEFullBigPipeConstructorNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _stop=lockstep_stop,_particles=UberCont.opt_prtcls,
        _parked=scrNTTEFullInstances(Portal)
    assert(instance_exists(Player),"BigPipe replacement regression requires a real Player")
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    try {
        GameCont.hard=30;random_set_seed(41703);lockstep_stop=false;UberCont.opt_prtcls=false;
        var _old=instance_create(37400,37400,BuffGator),
            _upgraded=scrNTTEFullBigPipeSpawnGator(37400,37400,Gator)
        assert(instance_exists(_upgraded) && instance_is(_upgraded,BuffGator) && _upgraded!=_old,
            "BigPipe failed to recover the fresh BuffGator from native Gator.Create self-destruction")
        var _pipe=instance_create(37600,37600,NTTEFullBigPipe),_count=instance_number(NTTEFullPalankingToss)
        repeat(8) {
            _pipe.spawn_count=1;_pipe.spawn_delay=0;
            with(_pipe) scrNTTEFullBigPipeStep();
            assert(instance_exists(_pipe) && _pipe.spawn_count==0,"BigPipe hard30 wave failed after native constructor replacement")
        }
        var _total=instance_number(NTTEFullPalankingToss)-_count
        assert(_total>=8 && _total<=16,"BigPipe changed authored one-or-two actors per wave")
        with(NTTEFullPalankingToss) if(array_get_index(_before,id)<0) {
            assert(instance_exists(creator) && zspeed==6,
                "BigPipe created a launch wrapper around a destroyed native Gator")
        }
        scrNTTESmokeLog("BIG PIPE CONSTRUCTOR actual native hard30 Gator-to-BuffGator replacement/same-position old actor exclusion/eight complete waves/valid toss creators/disabled Dust Create OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);global.rng_state=_rng;random_set_seed(_seed)
        lockstep_stop=_stop;UberCont.opt_prtcls=_particles
    }
}
