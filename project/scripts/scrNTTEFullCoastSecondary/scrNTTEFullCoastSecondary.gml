// tecoast.mod.gml BloomingAssassinHide, Palm, and Creature original branches.
function scrNTTEFullBloomingAssassinHideCreate() {
    spr_idle=scrNTTERefSprite("BloomingAssassinHide"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("BloomingAssassinHurt"); spr_dead=scrNTTERefSprite("BloomingAssassinDead")
    sprite_index=spr_idle; hitid=[scrNTTERefSprite("BloomingAssassinIdle"),"BLOOMING ASSASSIN"]
    max_hp=12; raddrop=10; size=1; depth=1; mask_index=-1
    ntte_bloom_hide_decide=90+random(90); ntte_bloom_hide_become=random_range(1500,3000)
}

function scrNTTEFullBloomingAssassinHideAfterCreate() {
    spr_shadow=shd24; snd_hurt=sndJungleAssassinHurt; snd_dead=sndJungleAssassinDead
    image_speed=0.4*timescale
}

function scrNTTEFullBloomingAssassinHideHurt() { ntte_bloom_hide_become=min(ntte_bloom_hide_become,1) }

function scrNTTEFullBloomingAssassinHideBecome() {
    var _inst=instance_create(x,y,NTTEFullBloomingAssassin)
    var _keys=["x","y","xstart","ystart","xprevious","yprevious","hspeed","vspeed","friction","sprite_index","image_index","image_speed","image_xscale","image_yscale","image_angle","image_blend","image_alpha","spr_shadow","spr_shadow_x","spr_shadow_y","hitid","snd_hurt","snd_dead","max_hp","hp","raddrop","size","team","right","nexthurt","canmelee","meleedamage"]
    for(var _i=0;_i<array_length(_keys);++_i) variable_instance_set(_inst,_keys[_i],variable_instance_get(id,_keys[_i]))
    if(is_struct(scrNTTEFullValue(id,"ntte_charm",undefined)) && ntte_charm.charmed) {
        _inst.ntte_charm=ntte_charm
        scrNTTEFullParrotCharmRegisterCopy(_inst)
    }
    repeat(4) { var _fx=instance_create(x,y,choose(Dust,Feather)); /* NTTE DUST LIFETIME blooming-replace */ if(instance_exists(_fx)) {_fx.sprite_index=sprLeaf; } with (_fx) motion_add(random(360),(1+random(2))*timescale) }
    instance_destroy(id,false)
    return _inst
}

function scrNTTEFullBloomingAssassinHideStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_bloom_hide_decide-=timescale; ntte_bloom_hide_become-=timescale
    if (ntte_bloom_hide_decide<=0) {
        ntte_bloom_hide_decide=30+random(60); scrTarget()
        if (instance_exists(target)) {
            var _d=point_distance(x,y,target.x,target.y)
            if (_d<32 || (_d<128 && random(2)<1)) {
                ntte_bloom_hide_become=min(ntte_bloom_hide_become,1)
                motion_add(point_direction(x,y,target.x,target.y),4*timescale); scrNTTEFullWorldLook(direction)
            }
        }
    }
    if (ntte_bloom_hide_become<=0) { scrNTTEFullBloomingAssassinHideBecome(); return }
    x=xstart; y=ystart; speed=0; sprite_index=scrNTTEFullWorldEnemySprite()
    if (place_meeting(x,y,Player)) ntte_bloom_hide_decide=min(ntte_bloom_hide_decide,1)
    if (image_index<1) {
        image_index+=random(image_speed/max(timescale,0.000001)*0.05)-image_speed/max(timescale,0.000001)
        if (image_index>=1 && scrNTTEFullPortalPointSeen(x,y,-1)) snd_play(sndJungleAssassinPretend)
    }
}

function scrNTTEFullPalmCreate() {
    spr_idle=scrNTTERefSprite("PalmIdle"); spr_hurt=scrNTTERefSprite("PalmHurt"); spr_dead=scrNTTERefSprite("PalmDead")
    sprite_index=spr_idle; mask_index=mskStreetLight; max_hp=30; size=2; depth=-7; target=noone
}

function scrNTTEFullPalmAfterCreate() {
    spr_shadow=-1; snd_hurt=sndHitRock; snd_dead=sndHitPlant
    if (random(8)<1) scrNTTEFullPalmFortify()
}

function scrNTTEFullPalmFortify() {
    spr_idle=scrNTTERefSprite("PalmFortIdle"); spr_hurt=scrNTTERefSprite("PalmFortHurt"); sprite_index=spr_idle
    depth=-4; snd_dead=sndGeneratorBreak
    target=instance_create(x,y,NTTEFullDiver)
    target.depth=depth-1; target.mask_index=mskNone; target.canfly=true; target.palm=id
    team=target.team; max_hp+=target.max_hp; hp+=target.hp
    instance_create(x,y-24,PortalClear)
}

function scrNTTEFullPalmStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (instance_exists(target)) with (target) {
        x=other.x; y=other.y-46; xprevious=x; yprevious=y; speed=0; walk=0
        if (sprite_index==spr_walk) sprite_index=spr_idle
    }
}

function scrNTTEFullPalmDeath() {
    if (hp>0) return;
    if (instance_exists(target)) with (target) {
        mask_index=-1; hp=0; vspeed=5*timescale; motion_add(other.direction,clamp(-other.hp/4,0,6)*timescale)
    }
    repeat(15) {
        var _leaf=instance_create(x+orandom(15),y-30+orandom(10),Feather)
        _leaf.sprite_index=sprLeaf; _leaf.image_yscale=random_range(1,3)
        with (_leaf) { motion_add(270,2*timescale); motion_add(point_direction(other.x,other.y,x,y),(1+random(1))*timescale) }
    }
}

function scrNTTEFullCreatureCreate() {
    spr_idle=scrNTTERefSprite("CreatureIdle"); spr_walk=spr_idle; spr_hurt=scrNTTERefSprite("CreatureHurt")
    spr_bott=scrNTTERefSprite("CreatureBott"); spr_foam=scrNTTERefSprite("CreatureFoam"); sprite_index=spr_idle
    image_speed=0.4*timescale; depth=-3; mask_index=spr_foam; snd_hurt=sndOasisBossHurt
    friction=0.4*timescale*timescale; max_hp=999999999; hp=max_hp; size=8; team=team_enemy; target=noone
    right=choose(-1,1); walk=0; walkspeed=1.2; maxspeed=2.6; canwade=false; scared=false; wkick=0; gunangle=0
    ntte_creature_decide=30
}

function scrNTTEFullCreatureDecision() {
    ntte_creature_decide=30
    var _best=infinity
    with (Player) if (!collision_line(x,y,other.x,other.y,Floor,false,false)) {
        var _d=point_distance(x,y,other.x,other.y)
        if (_d<_best) { _best=_d; other.target=id }
    }
    if (!scared) {
        if (instance_exists(target)) {
            var _d=point_direction(x,y,target.x,target.y)
            if (point_distance(x,y,target.x,target.y)>128) scrNTTEFullWorldWalk(_d,random_range(20,30))
            else if (random(4)<1) instance_create(x+65*right,y-24,HealFX)
            scrNTTEFullWorldLook(_d)
        }
        else { scrNTTEFullWorldWalk(direction+random(20),random_range(20,30)); scrNTTEFullWorldLook(direction) }
    }
    else {
        if (instance_exists(target)) scrNTTEFullWorldWalk(point_direction(x,y,target.x,target.y)+180,ntte_creature_decide)
        else {
            target=instance_nearest(x,y,Player)
            if (instance_exists(target)) scrNTTEFullWorldWalk(point_direction(x,y,target.x,target.y)+180,random_range(20,30))
        }
        scrNTTEFullWorldLook(direction)
    }
}

function scrNTTEFullCreatureStep() {
    if (lockstep_stop) return;
    ntte_creature_decide-=timescale
    if (ntte_creature_decide<=0) scrNTTEFullCreatureDecision()
    if (sprite_index==spr_hurt && !scared) { scared=true; instance_create(x+65*right,y-24,NTTEFullAssassinNotice) }
    if (distance_to_object(Floor)<64) {
        var _f=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Floor)
        if (instance_exists(_f)) motion_add(point_direction((_f.bbox_left+_f.bbox_right+1)/2,(_f.bbox_top+_f.bbox_bottom+1)/2,x,y),3*timescale*timescale)
    }
    with (Player) if (place_meeting(x,y,other.id)) motion_add(point_direction(other.x,other.y,x,y),3*timescale*timescale)
    scrNTTEFullWorldWalkStep(); sprite_index=scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullCoastSecondarySmoke() {
    var _loops=GameCont.loops; GameCont.loops=0
    var _hide=instance_create(10080,10048,NTTEFullBloomingAssassinHide)
    assert(_hide.hp==12 && _hide.raddrop==10 && _hide.depth==1,"Hidden assassin source stats changed")
    _hide.hp=7; _hide.team=team_player; _hide.right=-1; _hide.hspeed=2*timescale
    var _assassin=noone
    with (_hide) _assassin=scrNTTEFullBloomingAssassinHideBecome()
    assert(!instance_exists(_hide) && _assassin.hp==7 && _assassin.team==team_player && _assassin.right==-1 && _assassin.hspeed==2*timescale,"Hidden assassin transition lost source state")
    instance_destroy(_assassin,false)
    var _palm=instance_create(10080,10048,NTTEFullPalm)
    if (!instance_exists(_palm.target)) with (_palm) scrNTTEFullPalmFortify()
    var _diver=_palm.target
    assert(_palm.hp==40 && _diver.palm==_palm && _diver.mask_index==mskNone,"Palm fort did not combine health/hold Diver")
    with (_palm) scrNTTEFullPalmStep()
    assert(_diver.x==_palm.x && _diver.y==_palm.y-46 && _diver.speed==0,"Palm fort occupant attachment changed")
    _palm.hp=-8
    with (_palm) scrNTTEFullPalmDeath()
    assert(_diver.hp==0 && _diver.vspeed==5*timescale,"Palm death failed to drop and kill occupant")
    instance_destroy(_palm,false); instance_destroy(_diver,false); instance_destroy(NTTEFullDiverLaserDraw,false)
    var _c=instance_create(25000,25000,NTTEFullCreature)
    assert(!instance_is(_c,enemy) && _c.hp==999999999 && _c.size==8,"Sea Creature must not count as hostile encounter")
    _c.sprite_index=_c.spr_hurt
    with (_c) scrNTTEFullCreatureStep()
    assert(_c.scared,"Sea Creature did not become scared when hurt")
    instance_destroy(_c,false); GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD HIDDEN ASSASSIN STATE TRANSFER + PALM40HP/DIVER ATTACH/DEATH + NON-ENEMY CREATURE SCARED OK")
}
