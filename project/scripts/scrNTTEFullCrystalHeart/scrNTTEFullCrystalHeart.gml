// tecaves1325..1978. Heart contact warp and actual three-way unfolding shots.
function scrNTTEFullCrystalHeartCreate() {
    spr_idle=scrNTTERefSprite("CrystalHeartIdle"); spr_walk=spr_idle; spr_hurt=scrNTTERefSprite("CrystalHeartHurt"); spr_dead=scrNTTERefSprite("CrystalHeartDead")
    hitid=[spr_idle,"CRYSTAL HEART"]; sprite_index=spr_idle; depth=-3; mask_index=mskLaserCrystal
    max_hp=50; raddrop=0; meleedamage=0; size=5; walk=0; walkspeed=0.3; maxspeed=2; area=scrNTTEFullAreaId("red"); subarea=1; loops=GameCont.loops; white=false; tesseract=false
    ntte_heart_timer=30
}
function scrNTTEFullCrystalHeartAfterCreate() {
    spr_shadow=shd24; spr_shadow_y=4; snd_hurt=sndHyperCrystalHurt; snd_dead=sndHyperCrystalDead; snd_mele=sndHyperCrystalSearch
    canmelee=false; friction=0.1*timescale*timescale; alarm[1]=-1
}
function scrNTTEFullCrystalHeartDecision() {
    ntte_heart_timer=random_range(30,60); scrNTTEFullWorldWalk(random(360),random_range(10,40))
}
function scrNTTEFullCrystalHeartContact(_player) {
    if (!scr_can_hit(_player)) return;
    scr_projectile_hit(_player,meleedamage,timescale)
    snd_play_hit(snd_mele,0.1); hp=min(hp,0)
    if (!is_undefined(area)) {
        GameCont.killenemies=true
        var _warp=instance_create(x,y,NTTEFullWarpPortal)
        _warp.area=area; _warp.subarea=subarea; _warp.loops=loops
        with (_warp) scrNTTEFullWarpPortalStep()
        if (audio_exists(snd_dead)) {
            var _sound=snd_play(snd_dead,1.3+random(0.3))
            if (_sound>=0) audio_sound_set_track_position(_sound,0.4+random(0.1))
            snd_dead=-1
        }
    }
}
function scrNTTEFullCrystalHeartStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (ntte_heart_timer>0) {
        ntte_heart_timer-=timescale
        if (ntte_heart_timer<=0) { scrNTTEFullCrystalHeartDecision(); return }
    }
    if (wkick!=0) wkick=approach(wkick,0,timescale)
    if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale); sprite_index=scrNTTEFullWorldEnemySprite()
    if (white) {
        if (random(20)<timescale) {
            var _fx=instance_create(x+orandom(6),y+orandom(12),LaserCharge)
            with (_fx) { motion_set(90,random_range(0.2,0.5)*timescale); sprite_index=sprSpiralStar; image_index=choose(0,random(image_number)); depth=other.depth-1; alarm[0]=random_range(15,30) }
        }
        if (random(25)<timescale) with (instance_create(x+orandom(6),y+orandom(12),BulletHit)) {
            sprite_index=sprThrowHit; image_xscale=0.2+random(0.3); image_yscale=image_xscale; depth=other.depth-1
        }
    }
    else if (random(5)<timescale) with (instance_create(x,y,Dust)) {
        move_contact_solid(random(360),random_range(16,48)); sprite_index=sprLaserCharge; image_index=random(image_number)
        direction=point_direction(x,y,other.x,other.y); speed=random_range(1,2)*timescale; hspeed+=other.hspeed; vspeed+=other.vspeed; friction/=2
    }
    if (!canmelee && alarm[11]<0 && place_meeting(x,y,Player)) {
        var _players=scrNTTEFullInstances(Player)
        for(var _i=0;_i<array_length(_players);++_i) if (_players[_i].team!=team && place_meeting(x,y,_players[_i])) scrNTTEFullCrystalHeartContact(_players[_i])
    }
}
function scrNTTEFullCrystalHeartDeath() {
    instance_create(x,y,PortalClear)
    var _chests=[AmmoChest,WeaponChest,RadChest]
    for(var _i=0;_i<array_length(_chests);++_i) {
        var _bullet=scr_projectile_create(x,y,NTTEFullCrystalHeartBullet,direction+_i/array_length(_chests)*360+orandom(4),4)
        if (_i==0 && tesseract) {
            _bullet.area=scrNTTEFullAreaId("red"); _bullet.subarea=3; _bullet.area_goal=irandom_range(5,10)
            _bullet.area_chest=[_chests[_i],AmmoChest,AmmoChest,WeaponChest,WeaponChest,"RedChest"]; _bullet.area_chest_pos="random"
        }
        else { _bullet.area_chest=[_chests[_i]]; _bullet.area_chaos=white }
    }
    if (white) repeat(16) with (instance_create(x+orandom(4),y+orandom(4),Dust)) {
        motion_add(point_direction(other.x,other.y,x,y),5*timescale); sprite_index=sprSpiralStar; image_index=choose(0,random(image_number))
        image_xscale*=random_range(1,5); image_yscale=image_xscale; depth=-7
    }
    sleep(100); scrNTTEFullUnlockSet("crown:red",true)
}
function scrNTTEFullWorldAreaSecret(_area) {
    if (_area>=201 && _area<=206) return array_get_index([scrNTTEFullAreaId("pizza"),scrNTTEFullAreaId("lair"),scrNTTEFullAreaId("red")],_area)>=0
    return _area>=100
}
function scrNTTEFullCrystalHeartBulletCreate() {
    sprite_index=scrNTTERefSprite("CrystalHeartBullet"); spr_dead=scrNTTERefSprite("CrystalHeartBulletHit")
    spr_ring=scrNTTERefSprite("CrystalHeartBulletRing"); spr_trail=scrNTTERefSprite("CrystalHeartBulletTrail"); image_speed=0.4*timescale; area_color=c_white
    mask_index=mskFlakBullet; friction=0.4*timescale*timescale; maxspeed=12; damage=3; knockback_speed=12*timescale; typ=0
    area=scrNTTEFullAreaId("red"); subarea=0; loops=GameCont.loops; area_seed=random_get_seed()+random(0); area_goal=irandom_range(8,16)
    area_chest=[]; area_chest_pos="furthest"; area_chaos=false; big=false; setup=true; ntte_heart_bullet_timer=12; ntte_heart_trail_clock=0
    temerge_can_delete=false; deflected=false
}
function scrNTTEFullCrystalHeartBulletSetup() {
    setup=false
    if (area_chaos) {
        var _pick=[(scrNTTEFullWorldAreaSecret(GameCont.area) || GameCont.subarea<=0) ? GameCont.lastarea:GameCont.area,area]
        if (random(2)<1) {
            _pick=[_pick[0]]
            while(loops>0) {
                loops=ceil(loops-1)
                if (random(2)<1) {
                    switch(_pick[irandom(array_length(_pick)-1)]) {
                        case area_desert: _pick=[area_sewers,area_scrapyards]; break
                        case area_sewers: _pick=[area_caves]; break
                        case area_scrapyards: _pick=[area_sewers,area_city]; break
                        case area_caves: _pick=[area_labs]; break
                        case area_city: _pick=[area_labs,area_palace]; break
                        case area_labs: _pick=[area_sewers,area_caves]; break
                        case area_palace: _pick=[area_scrapyards,area_labs]; break
                        case 201: _pick=[area_scrapyards,area_jungle]; break
                        case 202: _pick=[area_sewers,area_labs]; break
                        case 205: _pick=[area_sewers,area_caves]; break
                    }
                }
                else break
            }
        }
        area=_pick[irandom(array_length(_pick)-1)]
        if (loops>0 && GameCont.subarea==3 && array_get_index([area_desert,area_scrapyards,area_city],area)>=0) subarea=3
    }
    if (!big) {
        var _max=scrAreaGetMaxSubarea(area)
        if (area==scrNTTEFullAreaId("red") ? subarea==3:(subarea==_max && (_max>1 || (loops>0 && !scrNTTEFullWorldAreaSecret(area))))) {
            friction*=4/3; maxspeed*=2/3; damage+=floor(damage/2); big=true; ntte_heart_bullet_timer+=4
        }
    }
    if (big) {
        sprite_index=scrNTTERefSprite(area==scrNTTEFullAreaId("red") ? "CrystalHeartBulletBigRed":"CrystalHeartBulletBig")
        spr_ring=scrNTTERefSprite("CrystalHeartBulletBigRing"); spr_trail=scrNTTERefSprite("CrystalHeartBulletBigTrail")
    }
    if (area==area_hq) area_color=make_color_rgb(0,255,255)
    else {
        var _color=scrAreaGetBackroundColor(area)
        area_color=make_color_hsv(color_get_hue(_color),color_get_saturation(_color),lerp(color_get_value(_color),255,0.5))
    }
}
function scrNTTEFullCrystalHeartBulletStep() {
    if (lockstep_stop) return;
    if (setup) scrNTTEFullCrystalHeartBulletSetup()
    if (ntte_heart_bullet_timer>0) {
        ntte_heart_bullet_timer-=timescale
        if (ntte_heart_bullet_timer<=0) { friction=-maxspeed/30*timescale*timescale; if (typ==0) typ=1; return }
    }
    if (deflected && hitid==HitId.Shield && area!=area_hq) {
        area=area_hq; subarea=min(subarea,2); area_chaos=false; array_push(area_chest,choose(IDPDChest,"BonusAmmoChest","BonusHealthChest"))
        scrNTTEFullCrystalHeartBulletSetup()
    }
    if (friction<0 && speed==0) speed-=friction
    speed=min(speed,maxspeed*timescale)
    if ((area==scrNTTEFullAreaId("red") || area==area_hq) && random(3)<2*timescale) {
        var _fx=instance_create(x+orandom(6),y+orandom(6),area==area_hq ? IDPDPortalCharge:LaserCharge)
        with (_fx) { speed=random(1)*timescale; alarm[0]=5+random(15) }
    }
    if (current_frame_active) {
        with (instance_create(x,y,DiscTrail)) {
            sprite_index=other.spr_trail; image_blend=other.area_color; image_angle=other.image_angle+orandom(120); image_xscale=other.image_xscale; image_yscale=other.image_yscale
        }
    }
    if (!place_meeting(x,y,Floor)) instance_destroy()
}
function scrNTTEFullCrystalHeartBulletHit(_target) {
    scrNTTEFullCrystalHeartNativeHit(_target)
}
function scrNTTEFullCrystalHeartBulletWall(_wall) {
    if (lockstep_stop || !instance_exists(_wall)) return;
    if (min(image_xscale,image_yscale)>0.85) {
        image_xscale-=0.05; image_yscale-=0.05
        var _sound=snd_play(sndGammaGutsProc,0.8+random(0.4),1.5)
        with (_wall) { instance_create(x,y,FloorExplo); instance_destroy() }
        if (_sound>=0) audio_stop_sound(_sound+1)
    }
    else instance_destroy()
}
function scrNTTEFullCrystalHeartNewInstances(_objects,_generation,_normal=false) {
    var _all=scrNTTEFullInstances(_objects,_normal),_out=[]
    for(var _i=0;_i<array_length(_all);++_i) if (real(_all[_i])>real(_generation)) array_push(_out,_all[_i])
    return _out
}
function scrNTTEFullCrystalHeartAreaSetup() {
    // The shared synchronous generator binds setup to its real GenCont.
    var _context=global.ntte_full_heart_generation_context
    with (GenCont) { goal=_context.goal; safedist=0 }
    with (FloorMaker) { goal=_context.goal; direction=round(_context.angle/90)*90 }
    random_set_seed(_context.seed)
}
function scrNTTEFullCrystalHeartPopulation() {
    // Only unfolding Heart balls opt out of the normal level's safe spawn
    // radius. Their source setup sets safedist=0 on the actual generator.
    return variable_global_exists("ntte_full_heart_generation_context")
        && is_struct(global.ntte_full_heart_generation_context)
        && instance_exists(GenCont)
        && scrNTTEFullValue(GenCont,"ntte_full_set_area",true)==false
        && scrNTTEFullValue(GenCont,"safedist",-1)==0
}
function scrNTTEFullCrystalHeartBulletDestroy() {
    snd_play(sndGammaGutsKill,0.8+random(0.3),3); snd_play(sndNothing2Beam,0.7+random(0.2),3); snd_play(sndHyperCrystalSearch,0.6+random(0.3),1.5)
    with (instance_create(x,y,BulletHit)) sprite_index=other.spr_dead
    with (instance_create(x,y,ThrowHit)) { image_blend=other.area_color; image_speed=0.5*timescale; depth=0 }
    scrNTTEFullTrenchShake(x,y,20,true); sleep(50)
    var _old=variable_global_exists("ntte_full_heart_generation_context") ? global.ntte_full_heart_generation_context:undefined,_generation=noone
    global.ntte_full_heart_generation_context={goal:area_goal,angle:direction,seed:area_seed}
    try { _generation=scrNTTEFullAreaGenerate(area,subarea,loops,x,y,false,0,scrNTTEFullCrystalHeartAreaSetup) }
    finally { global.ntte_full_heart_generation_context=_old }
    if (_generation==noone || is_undefined(_generation)) return;
    var _chests=scrNTTEFullCrystalHeartNewInstances([RadChest,chestprop,Mimic,SuperMimic],_generation)
    for(var _i=0;_i<array_length(_chests);++_i) instance_destroy(_chests[_i],false)
    var _enemies=scrNTTEFullCrystalHeartNewInstances(enemy,_generation)
    for(var _i=0;_i<array_length(_enemies);++_i) with (_enemies[_i]) if (canmelee) { canmelee=false; alarm[11]=30 }
    for(var _i=0;_i<array_length(area_chest);++_i) {
        var _chest=area_chest[_i],_cx=x,_cy=y,_pos=area_chest_pos,_minimum=-1,_random_selected=false,
            _floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
        // NTTE CRYSTAL HEART FIRST RANDOM CHEST CANDIDATE ONLY
        for(var _j=0;_j<array_length(_floor) && !_random_selected;++_j) with (_floor[_j]) {
            if (!place_meeting(x,y,Wall) && !place_meeting(x,y,prop) && !place_meeting(x,y,chestprop)) {
                var _can=true,_enemies=scrNTTEFullInstances(enemy)
                for(var _k=0;_k<array_length(_enemies);++_k) if (_enemies[_k].size>1 && place_meeting(x,y,_enemies[_k])) { _can=false; break }
                if (_can) {
                    var _x=(bbox_left+bbox_right)/2,_y=(bbox_top+bbox_bottom)/2
                    if (_pos=="random") { _cx=_x; _cy=_y; _random_selected=true; break }
                    else {
                        var _distance=point_distance(other.x,other.y,_x,_y)
                        if (_distance>_minimum) { _minimum=_distance; _cx=_x; _cy=_y }
                    }
                }
            }
        }
        var _new=scrNTTEFullLairChestCreate(_cx,_cy,_chest,true)
        if (instance_exists(_new)) {
            var _crystals=scrNTTEFullInstances([Crystal,NTTEFullBigCrystalProp,NTTEFullCrystalPropRed,NTTEFullCrystalPropWhite])
            with (_new) for(var _j=0;_j<array_length(_crystals);++_j) if (place_meeting(x,y,_crystals[_j])) instance_destroy(_crystals[_j],false)
        }
    }
    if (area==scrNTTEFullAreaId("red")) {
        var _floors=scrNTTEFullCrystalHeartNewInstances(Floor,_generation)
        for(var _i=0;_i<array_length(_floors);++_i) _floors[_i].depth=8
    }
    var _old_tiles=[],_new_tiles=[],_tops=scrNTTEFullCrystalHeartNewInstances(TopSmall,_generation)
    for(var _i=0;_i<array_length(_tops);++_i) {
        if (random(5)<1) array_push(_old_tiles,_tops[_i]); else array_push(_new_tiles,_tops[_i])
    }
    // Source iteration is a snapshot: newly promoted neighbours are not revisited.
    var _old_snapshot=[]
    array_copy(_old_snapshot,0,_old_tiles,0,array_length(_old_tiles))
    for(var _i=0;_i<array_length(_old_snapshot);++_i) {
        var _tile=_old_snapshot[_i],_x=(_tile.bbox_left+_tile.bbox_right)/2,_y=(_tile.bbox_top+_tile.bbox_bottom)/2
        for(var _dir=0;_dir<360;_dir+=90) {
            var _point_x=_x+lengthdir_x(16,_dir),_point_y=_y+lengthdir_y(16,_dir)
            for(var _j=array_length(_new_tiles)-1;_j>=0;--_j) if (collision_point(_point_x,_point_y,_new_tiles[_j],false,false)) {
                array_push(_old_tiles,_new_tiles[_j]); array_delete(_new_tiles,_j,1)
            }
        }
    }
    for(var _i=0;_i<array_length(_old_tiles);++_i) if (instance_exists(_old_tiles[_i])) with (_old_tiles[_i]) event_perform(ev_create,0)
    var _area=GameCont.area; GameCont.area=area
    for(var _i=0;_i<array_length(_new_tiles);++_i) if (instance_exists(_new_tiles[_i])) with (_new_tiles[_i]) {
        var _ox=floor(random_range(bbox_left,bbox_right+8)/8)*8,_oy=floor(random_range(bbox_top,bbox_bottom+8)/8)*8
        for(var _x=_ox-8;_x<_ox+8;_x+=8) for(var _y=_oy-8;_y<_oy+8;_y+=8) {
            var _meeting=false
            for(var _j=0;_j<array_length(_new_tiles);++_j) if (collision_point(_x,_y,_new_tiles[_j],false,false)) { _meeting=true; break }
            if (!_meeting) scrNTTEFullTopTinyCreate(_x,_y)
        }
    }
    GameCont.area=_area
    for(var _i=0;_i<array_length(_new_tiles);++_i) if (instance_exists(_new_tiles[_i])) with (_new_tiles[_i]) instance_create(x+choose(-16,0),y+choose(-16,0),Top)
    var _reveal=scrNTTEFullCrystalHeartNewInstances([Floor,Wall,TopSmall],_generation)
    for(var _i=0;_i<array_length(_reveal);++_i) if (array_get_index(_old_tiles,_reveal[_i])<0) {
        var _tile=_reveal[_i],_record=scrNTTEFullFloorReveal(_tile.bbox_left,_tile.bbox_top,_tile.bbox_right-1,_tile.bbox_bottom-1,6)
        _record.time_max*=1.3
    }
    _area=GameCont.area; GameCont.area=area
    if (subarea==0) {
        var _remove=scrNTTEFullCrystalHeartNewInstances(PizzaEntrance,_generation)
        for(var _i=0;_i<array_length(_remove);++_i) instance_destroy(_remove[_i],false)
        var _crowns=scrNTTEFullCrystalHeartNewInstances(CrownPickup,_generation)
        for(var _i=0;_i<array_length(_crowns);++_i) with (_crowns[_i]) {
            var _num=2,_floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
            for(var _j=0;_j<array_length(_floor) && _num>0;++_j) with (_floor[_j]) {
                var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
                if (point_distance(_cx,_cy,other.x,other.y)<96 && place_free(x,y)) { instance_create(_cx,_cy,CrownGuardian); if (--_num<=0) break }
            }
            instance_destroy(id,false)
        }
        _remove=scrNTTEFullCrystalHeartNewInstances(CrownPed,_generation)
        for(var _i=0;_i<array_length(_remove);++_i) instance_destroy(_remove[_i],false)
    }
    if (loops<=0 || GameCont.subarea!=3 || !instance_exists(enemy)) {
        var _remove=scrNTTEFullCrystalHeartNewInstances(WantBoss,_generation)
        for(var _i=0;_i<array_length(_remove);++_i) instance_destroy(_remove[_i],false)
    }
    switch(area) {
        case area_labs:
            if (loops>0 && !array_length(scrNTTEFullCrystalHeartNewInstances(TechnoMancer,_generation))) {
                var _floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
                for(var _i=0;_i<array_length(_floor);++_i) {
                    var _tile=_floor[_i],_cx=(_tile.bbox_left+_tile.bbox_right)/2,_cy=(_tile.bbox_top+_tile.bbox_bottom)/2
                    if (point_distance(_cx,_cy,x,y)>64) {
                        var _tech=instance_create(_cx,_cy,TechnoMancer)
                        repeat(6) instance_create(_tech.x+orandom(60),_tech.y+orandom(60),PortalClear)
                        break
                    }
                }
            }
            break
        case area_hq:
            if (subarea!=3) {
                var _guards=big,_portals=2,_floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
                for(var _i=0;_i<array_length(_floor);++_i) {
                    var _tile=_floor[_i],_cx=(_tile.bbox_left+_tile.bbox_right)/2,_cy=(_tile.bbox_top+_tile.bbox_bottom)/2
                    if (_guards>0) { _guards--; scrNTTEFullWorldCreateRequired("PopoSecurity",_cx,_cy) }
                    else if (_portals>0) {
                        _portals--
                        with (instance_create(_cx,_cy,IDPDSpawn)) { x=xstart; y=ystart; move_contact_solid(random(360),8) }
                    }
                    else break
                }
            }
            break
    }
    GameCont.area=_area
    if (instance_exists(enemy)) scrNTTEFullPortalPoof()
    instance_create(x,y,PortalClear)
}
function scrNTTEFullCrystalHeartSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops,_unlock=scrNTTEFullUnlockGet("crown:red",false)
    GameCont.loops=0
    var _heart=instance_create(71016,71016,NTTEFullCrystalHeart)
    assert(_heart.max_hp==50 && _heart.raddrop==0 && _heart.meleedamage==0 && !_heart.canmelee && _heart.size==5 && _heart.ntte_heart_timer==30,"CrystalHeart source stats/original CustomEnemy defaults/wander timer changed")
    var _num=instance_number(NTTEFullCrystalHeartBullet)
    _heart.hp=0
    with (_heart) scrNTTEFullCrystalHeartStep()
    assert(!instance_exists(_heart) && instance_number(NTTEFullCrystalHeartBullet)==_num+3,"Real CrystalHeart death failed to unfold three separate area projectiles")
    var _bullets=scrNTTEFullInstances(NTTEFullCrystalHeartBullet),_chests=[AmmoChest,WeaponChest,RadChest]
    for(var _i=0;_i<3;++_i) {
        var _bullet=_bullets[_num+_i]
        assert(array_length(_bullet.area_chest)==1 && _bullet.area_chest[0]==_chests[_i] && !_bullet.area_chaos,"CrystalHeart three unfolded source chest rewards changed")
    }
    assert(scrNTTEFullUnlockGet("crown:red",false),"CrystalHeart real death failed Red Crown unlock")
    var _floor=instance_create(72000,72000,Floor),_bullet=instance_create(72016,72016,NTTEFullCrystalHeartBullet)
    with (_bullet) scrNTTEFullCrystalHeartBulletSetup()
    assert(!_bullet.big && _bullet.damage==3 && _bullet.maxspeed==12 && _bullet.ntte_heart_bullet_timer==12,"Ordinary unfolding bullet source size/damage/speed/delay changed")
    repeat(round(12/timescale)) with (_bullet) scrNTTEFullCrystalHeartBulletStep()
    assert(_bullet.typ==1 && _bullet.friction<0,"Unfolding bullet did not become deflectable/accelerate after12logical ticks")
    _bullet.deflected=true; _bullet.hitid=HitId.Shield; _bullet.area_chest=[AmmoChest]
    with (_bullet) scrNTTEFullCrystalHeartBulletStep()
    assert(_bullet.area==area_hq && _bullet.area_color==make_color_rgb(0,255,255) && !_bullet.area_chaos && array_length(_bullet.area_chest)==2,"Shielder reflection omitted original HQ destination/cyan tint/extra police chest")
    var _big=instance_create(72016,72016,NTTEFullCrystalHeartBullet)
    _big.subarea=3
    with (_big) scrNTTEFullCrystalHeartBulletSetup()
    assert(_big.big && _big.maxspeed==8 && _big.damage==4 && _big.ntte_heart_bullet_timer==16 && _big.sprite_index==scrNTTERefSprite("CrystalHeartBulletBigRed"),"Tesseract/boss unfolding bullet source large form/speed/damage/delay changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops; scrNTTEFullUnlockSet("crown:red",_unlock)
    scrNTTESmokeLog("FULL WORLD CRYSTAL HEART SOURCE50HP+0CONTACT DEFAULTS/REAL DEATH THREE DISTINCT CHESTS/RED CROWN UNLOCK/12TICK ACCELERATION+DEFLECTABILITY/SHIELDER HQ+CYAN+EXTRA CHEST/16TICK LARGE RED FORM OK")
}
function scrNTTEFullCrystalHeartContactSmoke() {
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),_px=_player.x,_py=_player.y,_direction=_player.direction,
        _visible=_player.visible,_health=_player.hp,_hurt=_player.nexthurt,_kill=scrNTTEFullValue(GameCont,"killenemies",0)
    _player.x=73016; _player.y=73016; _player.visible=true; _player.nexthurt=0
    var _heart=instance_create(_player.x,_player.y,NTTEFullCrystalHeart)
    with (_heart) scrNTTEFullCrystalHeartContact(_player)
    assert(_heart.hp<=0 && GameCont.killenemies==true && !_player.visible,"CrystalHeart contact omitted source death/native kill-all request/immediate player grab")
    assert(_player.hp==_health && instance_exists(NTTEFullWarpPortal),"Original zero-damage CrystalHeart contact lost warp or damaged player")
    var _warp=instance_find(NTTEFullWarpPortal,0)
    assert(instance_exists(_warp.portal) && instance_is(_warp.portal,BigPortal) && _warp.portal.image_alpha==0 && _warp.area==scrNTTEFullAreaId("red"),"CrystalHeart warp omitted actual invisible native BigPortal/source red destination")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    _player.x=_px; _player.y=_py; _player.direction=_direction; _player.visible=_visible; _player.hp=_health; _player.nexthurt=_hurt; GameCont.killenemies=_kill
    scrNTTESmokeLog("FULL WORLD CRYSTAL HEART ACTUAL CONTACT/ZERO DAMAGE/30HZ KILLENEMIES REQUEST/IMMEDIATE HIDDEN PLAYER/REAL INVISIBLE BIG PORTAL+RED TARGET OK; ROOM RESTART REQUIRES DEVICE REGRESSION")
}
function scrNTTEFullCrystalHeartUnfoldSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops
    var _floor=instance_create(74000,74000,Floor),_bullet=instance_create(74016,74016,NTTEFullCrystalHeartBullet)
    _bullet.area=area_desert; _bullet.subarea=1; _bullet.loops=0; _bullet.area_goal=8; _bullet.area_chest=[AmmoChest]; _bullet.direction=0
    var _old_floor=instance_number(Floor),_old_chest=instance_number(AmmoChest)
    instance_destroy(_bullet)
    assert(!instance_exists(_bullet) && instance_number(Floor)>_old_floor+3,"Actual unfolding bullet destruction failed source synchronous native destination terrain generation")
    assert(instance_number(AmmoChest)>=_old_chest+1,"Actual unfolding tunnel omitted its source destination ammo chest")
    assert(GameCont.area==_area && GameCont.subarea==_subarea && GameCont.loops==_loops,"Unfolding tunnel leaked temporary source area into active world")
    assert(instance_exists(NTTEFullFloorReveal),"Unfolding source terrain reveal controller missing")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD REAL CRYSTAL HEART BULLET DESTRUCTION/NATIVE IN-ROOM GENERATION/CHEST REPLACEMENT+FURTHEST AMMO REWARD/TOP TOPOLOGY+REVEAL/ACTIVE AREA PRESERVATION OK")
}
