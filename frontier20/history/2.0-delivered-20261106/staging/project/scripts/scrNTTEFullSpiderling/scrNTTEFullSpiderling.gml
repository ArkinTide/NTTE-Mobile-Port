// tecaves.mod.gml:3113..3280. Native Crystal combines NTT's CrystalProp /
// InvCrystal native object identities; full NTTE red/white crystals are separate.
function scrNTTEFullSpiderlingCreate() {
    curse=GameCont.area==area_cursed_caves
    var _name=curse ? "InvSpiderling":"Spiderling"
    spr_idle=scrNTTERefSprite(_name+"Idle"); spr_walk=scrNTTERefSprite(_name+"Walk")
    spr_hurt=scrNTTERefSprite(_name+"Hurt"); spr_dead=scrNTTERefSprite(_name+"Dead"); spr_hatch=scrNTTERefSprite(_name+"Hatch")
    sprite_index=spr_idle; hitid=[spr_idle,"SPIDERLING"]; depth=-2; mask_index=mskMaggot
    max_hp=4; raddrop=2; size=0; meleedamage=0; walk=0; walkspeed=0.8; maxspeed=3
    ntte_spiderling_hatch_left=irandom_range(60,150); ntte_spiderling_decide_left=irandom_range(20,40)
    var _p=instance_nearest(x,y,Player)
    if (instance_exists(_p)) ntte_spiderling_hatch_left+=point_distance(x,y,_p.x,_p.y)
}

function scrNTTEFullSpiderlingAfterCreate() {
    spr_shadow=shd16; spr_shadow_y=2; nexthurt=current_frame+15; direction=random(360)
    snd_hurt=sndSpiderHurt; snd_dead=sndSpiderDead
    if (curse>0) { snd_hurt=choose(sndHitFlesh,sndBanditHit,sndFastRatHit); snd_dead=choose(sndEnemyDie,sndBanditDie,sndFastRatDie) }
    alarm[0]=-1; alarm[1]=-1
}

function scrNTTEFullSpiderlingDecision() {
    ntte_spiderling_decide_left=10+irandom(10); scrTarget()
    var _near=instance_nearest(x,y,Crystal)
    if (instance_exists(_near) && (!instance_exists(target) || point_distance(x,y,_near.x,_near.y)<point_distance(x,y,target.x,target.y))) target=_near
    if (curse>0) repeat(curse) instance_create(x,y,Curse)
    if (instance_exists(target) && point_distance(x,y,target.x,target.y)<96 && scrNTTEFullWorldTargetVisible()) {
        scrNTTEFullWorldWalk(point_direction(x,y,target.x,target.y)+orandom(20),14); scrNTTEFullWorldLook(direction)
        if (instance_is(target,prop)) { direction+=orandom(60); ntte_spiderling_decide_left*=random_range(1,2) }
    }
    else { scrNTTEFullWorldWalk(direction+orandom(20),12); scrNTTEFullWorldLook(direction) }
}

function scrNTTEFullSpiderlingHatch() {
    var _adult=instance_create(x,y,curse>0 ? InvSpider:Spider)
    _adult.x=x; _adult.y=y; _adult.creator=id; _adult.right=right; _adult.alarm[1]=10+random(10)
    scrNTTEFullWorldBudge(_adult,Wall)
    for(var _d=0;_d<360;_d+=60) {
        var _l=random(8),_smoke=instance_create(x+lengthdir_x(_l,_d),y+lengthdir_y(_l,_d),Smoke)
        with (_smoke) {
            motion_add(_d+orandom(20),(1+random(1.5))*timescale); depth=-3
            var _dust=instance_create(x,y,Dust)
            with (_dust) { motion_add(other.direction+orandom(90),2*timescale); depth=other.depth }
        }
    }
    for(var _d=direction;_d<direction+360;_d+=120) {
        var _debris=instance_create(x,y,NTTEFullCatDoorDebris)
        with (_debris) {
            sprite_index=other.spr_hatch; image_index=irandom(image_number-1); direction=_d+orandom(30); speed+=(1+random(4))*timescale
        }
    }
    snd_play_hit(sndHitRock,0.3); snd_play_hit(sndBouncerBounce,0.5); snd_play(sndCocoonBreak,2+random(1),0.8)
    // Hatch is replacement, not a kill: no corpse, radiation, drops or death proc.
    instance_destroy(id,false)
}

function scrNTTEFullSpiderlingStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_spiderling_hatch_left-=timescale
    if (ntte_spiderling_hatch_left<=0) { scrNTTEFullSpiderlingHatch(); return }
    ntte_spiderling_decide_left-=timescale
    if (ntte_spiderling_decide_left<=0) scrNTTEFullSpiderlingDecision()
    scrNTTEFullWorldWalkStep(); sprite_index=scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullSpiderlingDeath() {
    if (hp>0) return;
    scrNTTEFullWorldPickupDrop(15,0)
    var _chance=2/3*curse
    if (random(1)<_chance) {
        speed=min(timescale,speed)
        repeat(3*max(1,_chance)) {
            var _child=instance_create(x,y,NTTEFullSpiderling)
            _child.sprite_index=_child.spr_hurt; _child.ntte_spiderling_hatch_left=ceil(ntte_spiderling_hatch_left/2)
            _child.curse=curse/2; _child.givekill=givekill; _child.raddrop=0
        }
    }
}

function scrNTTEFullSpiderlingSmoke() {
    var _area=GameCont.area,_loops=GameCont.loops
    GameCont.area=area_caves; GameCont.loops=0
    var _s=instance_create(10080,10048,NTTEFullSpiderling)
    assert(_s.hp==4 && _s.raddrop==2 && _s.size==0 && _s.nexthurt==current_frame+15,"Spiderling original stats/immunity changed")
    var _before=instance_number(Spider),_kills=GameCont.kills
    with (_s) { ntte_spiderling_hatch_left=timescale; scrNTTEFullSpiderlingStep() }
    assert(!instance_exists(_s) && instance_number(Spider)==_before+1 && GameCont.kills==_kills,"Spiderling hatch counted as a kill or failed adult replacement")
    var _adult=instance_find(Spider,instance_number(Spider)-1)
    assert(_adult.alarm[1]>=10 && _adult.alarm[1]<20,"Spiderling adult initial attack delay changed")
    instance_destroy(_adult,false)
    GameCont.area=area_cursed_caves
    _s=instance_create(10080,10048,NTTEFullSpiderling)
    assert(_s.curse && _s.spr_idle==scrNTTERefSprite("InvSpiderlingIdle"),"CursedSpiderling used normal art")
    _before=instance_number(InvSpider)
    with (_s) scrNTTEFullSpiderlingHatch()
    assert(!instance_exists(_s) && instance_number(InvSpider)==_before+1,"CursedSpiderling hatched a normal spider")
    instance_destroy(InvSpider,false)
    GameCont.area=_area; GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD SPIDERLING15IMMUNITY/HATCH NO KILL/ADULT DELAY + CURSED ART/ADULT TYPE OK")
}
