// tecoast.mod.gml:751..1014, 5771..5806. Timers use original 30Hz ticks.
function scrNTTEFullDiverCreate() {
    spr_idle=scrNTTERefSprite("DiverIdle"); spr_walk=scrNTTERefSprite("DiverWalk")
    spr_hurt=scrNTTERefSprite("DiverHurt"); spr_dead=scrNTTERefSprite("DiverDead")
    spr_weap=scrNTTERefSprite("HarpoonGun"); sprite_index=spr_idle; hitid=[spr_idle,"DIVER"]
    depth=-2; mask_index=mskBandit; max_hp=10; raddrop=4; size=1
    walk=0; walkspeed=0.8; maxspeed=3; gonnafire=false; reload=0; laser=0; palm=noone
    ntte_diver_decide_left=90+irandom(90)
}

function scrNTTEFullDiverAfterCreate() {
    spr_shadow=shd24; snd_hurt=GameCont.underwater ? sndOasisHurt:sndHitMetal
    snd_dead=GameCont.underwater ? sndOasisDeath:sndAssassinDie
    gunangle=random(360); direction=gunangle; alarm[1]=-1
    if (!instance_exists(NTTEFullDiverLaserDraw)) instance_create(x,y,NTTEFullDiverLaserDraw)
}

function scrNTTEFullDiverDecision() {
    ntte_diver_decide_left=60+irandom(30)
    if (GameCont.underwater) { var _b=instance_create(x,y,Bubble); _b.speed/=3 }
    if (gonnafire) {
        gonnafire=false; scr_projectile_create(x,y,NTTEFullDiverHarpoon,gunangle,14); snd_play(sndCrossbow)
        ntte_diver_decide_left=20+random(30); reload=90+random(30); wkick=8
    }
    else {
        scrTarget()
        if (scrNTTEFullWorldTargetVisible()) {
            // Native hspeed is a physical-frame displacement; NTT uses logical speed.
            var _ts=max(timescale,0.000001)
            scrNTTEFullWorldLook(point_direction(x,y,target.x+target.hspeed/_ts,target.y+target.vspeed/_ts))
            var _dis=point_distance(x,y,target.x,target.y)
            if ((_dis>64 && _dis<320) || instance_exists(palm)) {
                if (reload<=0 && random(2)<1) {
                    ntte_diver_decide_left=12; gonnafire=true
                    snd_play(sndSniperTarget,4,0.8); snd_play(sndCrossReload,0.5,0.2); wkick=-4
                }
                else {
                    ntte_diver_decide_left=20+random(30)
                    if (random(2)<1) scrNTTEFullWorldWalk(gunangle+choose(-90,90)+orandom(10),10)
                }
            }
            else { ntte_diver_decide_left=20+irandom(30); scrNTTEFullWorldWalk(gunangle+180+orandom(30),random_range(15,30)) }
            var _pit=scrNTTERefSprite("FloorTrenchB"),_dry=[],_haspit=false
            with (Floor) { if (sprite_index==_pit) _haspit=true; else array_push(_dry,id) }
            if (_haspit) {
                var _nx=x+hspeed/_ts*4,_ny=y+vspeed/_ts*4
                var _floor=scrNTTEFullWorldNearestRectBBox(_nx,_ny,_nx,_ny,_dry)
                if (instance_exists(_floor) && !place_meeting(x,y,_floor))
                    direction=point_direction(x,y,(_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2)+orandom(20)
            }
        }
        else { scrNTTEFullWorldWalk(random(360),30); scrNTTEFullWorldLook(direction) }
    }
}

function scrNTTEFullDiverStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_diver_decide_left-=timescale
    if (ntte_diver_decide_left<=0) scrNTTEFullDiverDecision()
    scrNTTEFullWorldWalkStep(); sprite_index=scrNTTEFullWorldEnemySprite()
    if (reload>0) {
        reload-=timescale
        if (reload>=6 && reload<=12) wkick=lerp(wkick,6,1-power(1-0.6,timescale))
        else if (reload<=0) {
            ntte_diver_decide_left=max(ntte_diver_decide_left,30); wkick=-2; snd_play_hit(sndCrossReload,0.1)
            instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),WepSwap)
        }
    }
    laser=lerp(laser,gonnafire,1-power(0.7,timescale))
}

function scrNTTEFullDiverDrawWeapon() {
    if (reload<6) {
        var _ox=6-(wkick+reload),_oy=-right
        draw_sprite_ext(sprBolt,1,x+lengthdir_x(_ox,gunangle)+lengthdir_x(_oy,gunangle-90),
            y+lengthdir_y(_ox,gunangle)+lengthdir_y(_oy,gunangle-90),1,right,gunangle,image_blend,image_alpha)
    }
    draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
}

function scrNTTEFullDiverDraw() {
    var _back=gunangle<=180 || laser!=0
    if (_back) scrNTTEFullDiverDrawWeapon()
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (instance_exists(palm)) with (palm) draw_self()
    if (!_back) scrNTTEFullDiverDrawWeapon()
}

function scrNTTEFullDiverLaserEnd(_x,_y,_dir,_dis) {
    var _dx=lengthdir_x(1,_dir),_dy=lengthdir_y(1,_dir),_ex=_x+_dis*_dx,_ey=_y+_dis*_dy
    var _wall=collision_line(_x,_y,_ex,_ey,Wall,false,false)
    if (_wall) while (_dis>=1) {
        _dis/=2
        _ex+=(_wall ? -_dis:_dis)*_dx; _ey+=(_wall ? -_dis:_dis)*_dy
        _wall=collision_line(_x,_y,_ex,_ey,Wall,false,false)
    }
    return [_ex,_ey]
}

function scrNTTEFullDiverLaserDraw() {
    draw_set_color(c_white)
    with (NTTEFullDiver) if (laser!=0) {
        var _a=0.8*laser,_width=(1+random(0.5))*laser,_end=scrNTTEFullDiverLaserEnd(x,y-1.5,gunangle,1000)
        draw_set_alpha(_a); draw_line_width(x-1,y-2.5,_end[0]-1,_end[1]-1,_width)
        draw_set_alpha(0.2*_a); gpu_set_blendmode(bm_add)
        draw_line_width(x-1,y-2.5,_end[0]+lengthdir_x(2,gunangle)-1,_end[1]+lengthdir_y(2,gunangle)-1,_width*2)
        gpu_set_blendmode(bm_normal)
    }
    draw_set_alpha(1)
}

function scrNTTEFullDiverHarpoonCreate() {
    sprite_index=sprBolt; mask_index=mskBolt; image_speed=timescale; image_angle=direction
    damage=4; force=8; typ=2; ntte_harpoon_life=-1
}

function scrNTTEFullDiverHarpoonStep() {
    if (lockstep_stop) return;
    if (ntte_harpoon_life>=0) { ntte_harpoon_life-=timescale; if (ntte_harpoon_life<=0) instance_destroy() }
}

function scrNTTEFullDiverHarpoonEndStep() {
    if (lockstep_stop) return;
    var _trail=instance_create(x,y,BoltTrail)
    _trail.image_xscale=point_distance(x,y,xprevious,yprevious); _trail.image_angle=point_direction(x,y,xprevious,yprevious)
}

function scrNTTEFullDiverHarpoonHit(_who) {
    if (lockstep_stop || speed<=0 || !scr_can_hit(_who)) return;
    scr_projectile_hit(_who,damage,force*timescale)
    // NTT projectile_hit_np's fourth argument follows existing native venom compatibility.
    with (_who) nexthurt=max(nexthurt,current_frame+40)
    var _stick=instance_create(x,y,BoltStick); _stick.sprite_index=sprite_index; _stick.image_angle=image_angle; _stick.target=_who
    instance_destroy()
}

function scrNTTEFullDiverHarpoonWall() {
    if (lockstep_stop || speed<=0) return;
    speed=0; snd_play_hit(sndBoltHitWall,0.1); move_contact_solid(direction,16); instance_create(x,y,Dust)
    ntte_harpoon_life=30; typ=0
}

function scrNTTEFullDiverSmoke() {
    var _oa=GameCont.area,_ol=GameCont.loops,_water=GameCont.underwater,_p=instance_find(Player,0)
    var _px=_p.x,_py=_p.y; GameCont.loops=0; GameCont.underwater=true
    _p.x=10016; _p.y=10048
    var _d=instance_create(10112,10048,NTTEFullDiver)
    assert(_d.hp==10 && _d.raddrop==4 && _d.snd_hurt==sndOasisHurt,"Diver source stats/underwater sound changed")
    assert(instance_number(NTTEFullDiverLaserDraw)==1,"Diver laser layer duplicated")
    var _d2=instance_create(10112,10080,NTTEFullDiver)
    assert(instance_number(NTTEFullDiverLaserDraw)==1,"Second Diver duplicated global laser draw")
    instance_destroy(_d2,false)
    _d.gonnafire=true; _d.gunangle=180
    with (_d) scrNTTEFullDiverDecision()
    var _h=instance_find(NTTEFullDiverHarpoon,0)
    assert(instance_exists(_h) && _h.damage==4 && _h.force==8 && _h.creator==_d && _h.team==_d.team,"Diver harpoon damage/creator/faction lost")
    assert(!_d.gonnafire && _d.reload>=90 && _d.reload<120 && _d.wkick==8,"Diver original firing/reload state changed")
    with (_h) scrNTTEFullDiverHarpoonWall()
    assert(_h.speed==0 && _h.typ==0 && _h.ntte_harpoon_life==30,"Diver harpoon wall stick state changed")
    repeat(ceil(30/timescale)) if (instance_exists(_h)) with (_h) scrNTTEFullDiverHarpoonStep()
    assert(!instance_exists(_h),"Diver harpoon wall lifetime changed")
    _d.ntte_diver_decide_left=1000; _d.reload=timescale; _d.gonnafire=true
    with (_d) scrNTTEFullDiverStep()
    assert(_d.wkick==-2 && _d.laser>0 && _d.ntte_diver_decide_left>=30,"Diver reload completion/laser timing changed")
    var _end=scrNTTEFullDiverLaserEnd(10080,10048,0,20)
    assert(abs(_end[0]-10100)<0.01 && abs(_end[1]-10048)<0.01,"Unobstructed laser endpoint changed")
    instance_destroy(_d,false); instance_destroy(NTTEFullDiverLaserDraw,false)
    _p.x=_px; _p.y=_py; GameCont.area=_oa; GameCont.loops=_ol; GameCont.underwater=_water
    scrNTTESmokeLog("FULL WORLD DIVER FIRING/RELOAD/FACTION + HARPOON WALL30 + SINGLE LASER LAYER/ENDPOINT OK")
}
