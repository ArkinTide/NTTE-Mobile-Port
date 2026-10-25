// teOasis original Puffer and YetiCrab. Original CRAB TANK has constructor only;
// it is intentionally not presented here as a finished boss AI.
function scrNTTEFullPufferCreate() {
    ntte_full_puffer=true
    spr_idle=scrNTTERefSprite("PufferIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("PufferHurt"); spr_dead=scrNTTERefSprite("PufferDead")
    spr_chrg=scrNTTERefSprite("PufferChrg"); ntte_puffer_fire=scrNTTERefSprite("PufferFire")
    spr_fire=ntte_puffer_fire[0][0]; sprite_index=spr_idle; hitid=[spr_idle,"PUFFER"]
    depth=-2; mask_index=mskFreak; max_hp=10; raddrop=4; size=1
    walk=0; walkspeed=0.8; maxspeed=3; meleedamage=2; blow=0
    ntte_puffer_decide_left=40+random(80)
}

function scrNTTEFullPufferAfterCreate() {
    spr_shadow=shd16; spr_shadow_y=7
    snd_hurt=sndOasisHurt; snd_dead=sndOasisDeath; snd_mele=sndOasisMelee
    direction=random(360); alarm[1]=-1
}

function scrNTTEFullPufferDecision() {
    ntte_puffer_decide_left=20+random(30)
    if (blow>0) return;
    scrTarget()
    if (instance_exists(target)) {
        var _d=point_direction(x,y,target.x,target.y)
        if (random(2)<1 && point_distance(x,y,target.x,target.y)<256 && scrNTTEFullWorldTargetVisible()) {
            ntte_puffer_decide_left=30
            scrNTTEFullWorldWalk(_d,8); scrNTTEFullWorldLook(direction+180)
            sprite_index=spr_chrg; image_index=0
            repeat(3) instance_create(x,y,Dust)
            snd_play(sndOasisCrabAttack,0.8); snd_play(sndBouncerBounce,0.6+orandom(0.2),2)
        }
        else scrNTTEFullWorldWalk(_d+orandom(20),ntte_puffer_decide_left)
    }
    else scrNTTEFullWorldWalk(random(360),10)
}

function scrNTTEFullPufferStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_puffer_decide_left-=timescale
    if (ntte_puffer_decide_left<=0) scrNTTEFullPufferDecision()
    scrNTTEFullWorldWalkStep()
    if (sprite_index!=spr_fire) {
        if (sprite_index!=spr_chrg) sprite_index=scrNTTEFullWorldEnemySprite()
        else if (image_index+image_speed>=image_number) blow=1
    }
    if (blow>0) {
        blow-=0.03*timescale
        motion_add(direction+10*sin(current_frame/6),2*timescale*timescale)
        scrNTTEFullWorldLook(direction+180)
        if (random(4)<3*timescale) {
            var _d=direction+180,_bubble=instance_create(x+lengthdir_x(8,_d),y+lengthdir_y(8,_d),Bubble)
            with (_bubble) motion_add(_d,3*timescale)
            snd_play(sndRoll,1.2+random(0.4),0.6)
        }
        var _level=clamp(floor(blow*array_length(ntte_puffer_fire)),0,array_length(ntte_puffer_fire)-1),_back=direction>180
        spr_fire=ntte_puffer_fire[_level][_back]; sprite_index=spr_fire
    }
    else if (sprite_index==spr_fire) sprite_index=spr_idle
}

function scrNTTEFullPufferDraw() {
    var _flash=sprite_index!=spr_hurt && nexthurt>=current_frame+4
    if (_flash) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (_flash) gpu_set_fog(false,0,0,0)
}

function scrNTTEFullPufferDeath() {
    if (hp>0) return;
    scrNTTEFullWorldPickupDrop(30,0)
    var _n=3
    if (blow>0) _n*=ceil(blow*4)
    if (sprite_index==spr_chrg) _n+=image_index
    if (_n>3) { snd_play(sndOasisExplosionSmall,1+random(0.2)); snd_play(sndOasisExplosion,0.8+random(0.4),_n/15) }
    while (_n-->0) {
        var _b=instance_create(x,y,Bubble)
        with (_b) {
            motion_add(random(360),_n/2*timescale); hspeed+=other.hspeed/3; vspeed+=other.vspeed/3; friction*=2
        }
    }
}

function scrNTTEFullYetiCrabCreate() {
    spr_idle=scrNTTERefSprite("YetiCrabIdle"); spr_walk=spr_idle; spr_hurt=spr_idle; spr_dead=spr_idle
    spr_weap=mskNone; sprite_index=spr_idle; hitid=[spr_idle,"YETI CRAB"]; mask_index=mskFreak; depth=-2
    max_hp=12; raddrop=3; size=1; walk=0; walkspeed=1; maxspeed=4; meleedamage=2; is_king=0
    ntte_yeti_decide_left=20+irandom(10)
    // Native replacement for source fork() tears coroutine; no blocking wait.
    ntte_yeti_tears=0; ntte_yeti_tear_left=-1
}

function scrNTTEFullYetiCrabAfterCreate() {
    spr_shadow=shd24; spr_shadow_y=6
    snd_hurt=sndScorpionHit; snd_dead=sndScorpionDie; snd_mele=sndScorpionMelee
    direction=random(360); alarm[1]=-1
}

function scrNTTEFullYetiCrabDecision() {
    ntte_yeti_decide_left=30+random(10); scrTarget()
    var _td=instance_exists(target) ? point_direction(x,y,target.x,target.y):0
    var _dis=instance_exists(target) ? point_distance(x,y,target.x,target.y):infinity
    if (is_king==0) {
        // Original search includes all CustomEnemy with is_king=1. All current
        // native kings are YetiCrabs; predicate preserves future custom kings.
        var _king=noone,_best=infinity
        with (enemy) if (variable_instance_exists(id,"is_king") && is_king==1) {
            var _kd=point_distance(x,y,other.x,other.y)
            if (_kd<_best) { _best=_kd; _king=id }
        }
        if (instance_exists(_king)) {
            if (_best>16 && _dis<_best) {
                scrNTTEFullWorldWalk(point_direction(x,y,_king.x,_king.y)+orandom(5),5)
                ntte_yeti_decide_left=5+random(5)
            }
            else if (scrNTTEFullWorldTargetVisible()) scrNTTEFullWorldWalk(_td+orandom(10),30)
            else scrNTTEFullWorldWalk(random(360),30)
        }
        else if (scrNTTEFullWorldTargetVisible()) {
            ntte_yeti_tears=irandom_range(4,10); ntte_yeti_tear_left=random_range(1,3)
            scrNTTEFullWorldWalk(_td+orandom(10),30)
        }
        else scrNTTEFullWorldWalk(random(360),30)
    }
    else scrNTTEFullWorldWalk(_td+orandom(10),30)
    scrNTTEFullWorldLook(direction)
}

function scrNTTEFullYetiCrabStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_yeti_decide_left-=timescale
    if (ntte_yeti_decide_left<=0) scrNTTEFullYetiCrabDecision()
    if (ntte_yeti_tears>0) {
        ntte_yeti_tear_left-=timescale
        while (ntte_yeti_tear_left<=0 && ntte_yeti_tears>0) {
            instance_create(x,y,NTTEFullSweat); --ntte_yeti_tears; ntte_yeti_tear_left+=random_range(1,3)
        }
    }
    scrNTTEFullWorldWalkStep(); sprite_index=scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullFakeDustAfterCreate() {
    sprite_index=sprDust; image_index=random(image_number)
    motion_set(random(360),random(2)*timescale); friction=0.3*timescale*timescale
    image_xscale=0.8; image_yscale=image_xscale; growspeed=random(0.005)-0.025
}
