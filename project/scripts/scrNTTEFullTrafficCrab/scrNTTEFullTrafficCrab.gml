// tecoast5027..5224. Original sleeping crab and alternating ten-shot sweep.
function scrNTTEFullTrafficCrabCreate() {
    spr_idle=scrNTTERefSprite("CrabIdle"); spr_walk=scrNTTERefSprite("CrabWalk")
    spr_hurt=scrNTTERefSprite("CrabHurt"); spr_dead=scrNTTERefSprite("CrabDead")
    spr_fire=scrNTTERefSprite("CrabFire"); spr_hide=scrNTTERefSprite("CrabHide")
    sprite_index=spr_idle; mask_index=mskScorpion; depth=-2; hitid=[spr_idle,"TRAFFIC CRAB"]
    active=random(8)<1; max_hp=20; raddrop=10; size=2; meleedamage=4
    walk=0; walkspeed=1; maxspeed=2.5; ntte_crab_start_angle=random(360)
    sweep_spd=10; sweep_dir=choose(-1,1); ammo=0; ntte_crab_decide=30+random(90)
}
function scrNTTEFullTrafficCrabAfterCreate() {
    spr_shadow=shd48; snd_hurt=sndSpiderHurt; snd_dead=sndPlantTBKill; snd_mele=sndGoldScorpionMelee
    gunangle=ntte_crab_start_angle; direction=gunangle; sweep_dir=right; alarm[1]=-1
}
function scrNTTEFullTrafficCrabDecision() {
    ntte_crab_decide=30+random(30); scrTarget()
    if(active) {
        if(ammo>0) {
            ntte_crab_decide=2; scrNTTEFullWorldWalk(direction,1)
            snd_play(sndOasisCrabAttack); snd_play(sndFlyFire,2+random(1),0.5)
            var _px=x+right*(4+sweep_dir*10),_py=y+4
            repeat(choose(2,3)) {
                var _shot=scr_projectile_create(_px,_py,NTTEVenomPellet,gunangle+orandom(10),10+random(2))
                _shot.creator=id; _shot.team=team; _shot.hitid=hitid
            }
            gunangle+=sweep_dir*sweep_spd
            if(--ammo<=0) {
                ntte_crab_decide=30+random(20); sprite_index=spr_idle
                scrNTTEFullWorldWalk(instance_exists(target) ? point_direction(x,y,target.x,target.y):random(360),15)
                sweep_dir*=-1
            }
        }
        else {
            ntte_crab_decide=35+random(15)
            if(instance_exists(target) && scrNTTEFullWorldTargetVisible()) {
                scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
                if(point_distance(x,y,target.x,target.y)<128) {
                    scrNTTEFullWorldWalk(gunangle+sweep_dir*random(90),1)
                    ntte_crab_decide=1; ammo=10; gunangle-=sweep_dir*sweep_spd*(ammo/2)
                    snd_play(sndScorpionFireStart,0.8); snd_play(sndGoldScorpionFire,1.5)
                }
                else scrNTTEFullWorldWalk(gunangle+random_range(20,40)*choose(-1,1),30)
            }
            else { scrNTTEFullWorldWalk(random(360),10); scrNTTEFullWorldLook(direction) }
        }
    }
    else if((instance_exists(target) && point_distance(x,y,target.x,target.y)<80) || random(instance_number(enemy))<1) {
        active=true
        if(place_meeting(x,y,hitme)) scrNTTEFullWorldWalk(random(360),4)
        snd_play_hit(sndPlantSnareTB,0.2); snd_play_hit(sndScorpionFire,0.2)
        instance_create(x+6*right,y,NTTEFullAssassinNotice)
    }
}
function scrNTTEFullTrafficCrabStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy(); return }
    ntte_crab_decide-=timescale
    if(ntte_crab_decide<=0) scrNTTEFullTrafficCrabDecision()
    if(walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    if(!active) {
        x=xstart; y=ystart; speed=0; image_index=0; canmelee=false; alarm[11]=30
    }
    if(ammo>0) { sprite_index=spr_fire; image_index=0 }
    else if(sprite_index==spr_idle || image_index+image_speed>=image_number) {
        var _sprite=active ? scrNTTEFullWorldEnemySprite():spr_hide
        if(sprite_index!=_sprite) { sprite_index=_sprite; image_index=0 }
    }
}
function scrNTTEFullTrafficCrabHurt(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        hp-=_damage; nexthurt=current_frame+6
        if(_force!=0) motion_add(is_undefined(_direction) ? 0:_direction,_force)
        snd_play_hit(snd_hurt,0.3)
        if(sprite_index!=spr_hide) { sprite_index=spr_hurt; image_index=0 }
        active=true
    }
}
function scrNTTEFullTrafficCrabDraw() {
    var _hurt=sprite_index==spr_hide && nexthurt>=current_frame+4
    if(_hurt) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if(_hurt) gpu_set_fog(false,0,0,0)
}
function scrNTTEFullTrafficCrabDeath() {
    if(hp>0) return;
    scrNTTEFullWorldPickupDrop(10,10,0)
    var _ang=random(360)
    for(var _a=_ang;_a<_ang+360;_a+=120) with(instance_create(x,y,MeleeHitWall)) {
        motion_add(_a,timescale); image_angle=direction+180; image_blend=make_color_rgb(174,58,45)
    }
}
function scrNTTEFullTrafficCrabSmoke() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0),_px=_p.x,_py=_p.y,_loops=GameCont.loops
    GameCont.loops=0; _p.x=37016; _p.y=37016
    var _crab=instance_create(37116,37016,NTTEFullTrafficCrab)
    assert(_crab.hp==20 && _crab.raddrop==10 && _crab.size==2 && _crab.meleedamage==4 && _crab.maxspeed==2.5,
        "TrafficCrab lost original20HP/10rads/size2/melee4/speed2.5")
    _crab.active=false; _crab.ntte_crab_decide=100; _crab.speed=timescale
    with(_crab) event_perform(ev_step,ev_step_normal)
    assert(_crab.speed==0 && _crab.sprite_index==_crab.spr_hide && !_crab.canmelee && _crab.alarm[11]==30,
        "Sleeping TrafficCrab failed source rooted hide/melee-disable rule")
    var _hide=_crab.sprite_index
    scrNTTEFullTrafficCrabHurt(_crab,3,0,0,_p)
    assert(_crab.hp==17 && _crab.active && _crab.sprite_index==_hide && _crab.nexthurt==current_frame+6,
        "TrafficCrab damage lost awakening or original hurt-while-hidden presentation")
    _crab.ammo=0
    with(_crab) scrNTTEFullTrafficCrabDecision()
    assert(_crab.ammo==10 && _crab.ntte_crab_decide==1,"Close visible TrafficCrab failed original ten-shot sweep preparation")
    var _start_angle=_crab.gunangle,_side=_crab.sweep_dir,_count=instance_number(NTTEVenomPellet)
    with(_crab) scrNTTEFullTrafficCrabDecision()
    assert(_crab.ammo==9 && _crab.ntte_crab_decide==2,
        "TrafficCrab sweep lost one-shot ammo/two-tick interval")
    assert(abs(_crab.gunangle-_start_angle-_side*10)*1000000<=1,
        "TrafficCrab sweep lost10degree angular progression; delta="+string(_crab.gunangle-_start_angle))
    var _new_count=instance_number(NTTEVenomPellet)-_count
    assert(_new_count>=2 && _new_count<=3,
        "TrafficCrab sweep lost2..3actual venom pellets; count="+string(_new_count))
    var _shots=scrNTTEFullInstances(NTTEVenomPellet)
    for(var _i=0;_i<array_length(_shots);++_i) if(array_get_index(_before,_shots[_i])<0)
        assert(_shots[_i].creator==_crab && _shots[_i].team==_crab.team,"Crab venom lost actual source attacker/faction")
    _crab.ammo=1
    with(_crab) scrNTTEFullTrafficCrabDecision()
    assert(_crab.ammo==0 && _crab.sweep_dir==-_side && _crab.walk==15 && _crab.ntte_crab_decide>=30,
        "TrafficCrab sweep end failed source claw switch/player chase/cooldown")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops; _p.x=_px; _p.y=_py
    scrNTTESmokeLog("FULL TRAFFIC CRAB: source20HP sleep/hide/awakening, actual ten-shot alternating2..3pellet venom sweep/faction and chase OK @"+string(30/timescale))
}
