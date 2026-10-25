// Original tescrapyard.mod.gml:277..517. Grounded ravens deliberately stay
// inactive until hurt; flight uses the actual shared TopObject controller.
function scrNTTEFullBoneRavenCreate() {
    spr_idle=scrNTTERefSprite("BoneRavenIdle"); spr_walk=scrNTTERefSprite("BoneRavenWalk")
    spr_hurt=scrNTTERefSprite("BoneRavenHurt"); spr_dead=scrNTTERefSprite("BoneRavenDead")
    spr_lift=scrNTTERefSprite("BoneRavenLift"); spr_land=scrNTTERefSprite("BoneRavenLand"); spr_wing=scrNTTERefSprite("BoneRavenFly")
    sprite_index=spr_idle; image_index=random(image_number); hitid=[spr_idle,"RAVEN"]; depth=-2
    mask_index=mskRat; max_hp=10; raddrop=5; size=1
    walk=0; walkspeed=0.6; maxspeed=2.5; creator=noone; top_object=noone
    active=false; failed=false; ntte_raven_decide_left=-1
}
function scrNTTEFullBoneRavenAfterCreate() {
    spr_shadow=shd24; snd_hurt=sndTurtleHurt; snd_dead=sndMutant14Hurt; alarm[1]=-1
}
function scrNTTEFullBoneRavenFly(_min,_max) {
    if (_max<0) _max=infinity
    var _floors=array_shuffle(scrNTTEFullInstances(Floor)),_x=x,_y=y
    for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
        var _d=point_distance(_x,_y,clamp(_x,bbox_left,bbox_right),clamp(_y,bbox_top,bbox_bottom))
        if (_d<_min || _d>_max || place_meeting(x,y,Wall)) continue
        var _tx=(bbox_left+bbox_right)/2+orandom((bbox_right-bbox_left)/8),_ty=(bbox_top+bbox_bottom)/2+orandom((bbox_bottom-bbox_top)/8)
        with (other) {
            top_object=scrNTTEFullTopCreate(x,y,id,0,0)
            with (top_object) { jump_time=0; jump_x=_tx; jump_y=_ty; zspeed=jump; zfriction=grav }
            scrNTTEFullWorldLook(point_direction(x,y,_tx,_ty))
            if (scrNTTEFullPortalPointSeen(x,y,-1)) {
                snd_play(sndRavenLand)
                repeat(4) {
                    var _dust=instance_create(x+orandom(8),y+random(16),Dust)
                    /* NTTE DUST LIFETIME bone-raven-land */ if(instance_exists(_dust)) {_dust.speed=random_range(3,4)*timescale; _dust.depth=depth }
                }
            }
            return true
        }
    }
    return false
}
function scrNTTEFullBoneRavenBeforeHurt() {
    if (active) return;
    active=true
    var _min=96
    scrTarget()
    if (instance_exists(target)) {
        _min+=point_distance(x,y,target.x,target.y)
        scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
    }
    scrNTTEFullBoneRavenFly(_min,_min+160)
}
function scrNTTEFullBoneRavenDecision() {
    ntte_raven_decide_left=30+random(30)
    if (failed) { scrNTTEFullBoneRavenFly(-1,-1); return }
    scrTarget()
    if (scrNTTEFullWorldTargetVisible() && point_distance(x,y,target.x,target.y)<48) {
        scrNTTEFullWorldWalk(point_direction(x,y,target.x,target.y)+180,random_range(10,30))
        scrNTTEFullWorldLook(direction+180); ntte_raven_decide_left=walk
    }
    else if (random(3)<2) {
        scrNTTEFullWorldWalk(random(360),random_range(20,60)); scrNTTEFullWorldLook(direction)
        if (random(3)<1) scrNTTEFullBoneRavenFly(96,160)
    }
}
function scrNTTEFullBoneRavenStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (ntte_raven_decide_left>0) {
        ntte_raven_decide_left-=timescale
        if (ntte_raven_decide_left<=0) { scrNTTEFullBoneRavenDecision(); return }
    }
    scrNTTEFullWorldWalkStep()
    var _end=image_index+image_speed>=image_number
    if (!instance_exists(top_object) || (top_object.speed==0 && top_object.zspeed==0)) {
        if (!active) speed=0
        if (sprite_index!=spr_chrg || _end) sprite_index=scrNTTEFullWorldEnemySprite()
        return;
    }
    ntte_raven_decide_left=max(ntte_raven_decide_left,30+timescale)
    if (top_object.zspeed<0) {
        if (sprite_exists(spr_chrg)) {
            if (sprite_index!=spr_land) {
                if (top_object.z>8) { image_index=max(2,image_index); if (_end) spr_chrg=spr_land }
            }
            else if (_end) { spr_chrg=-1; sprite_index=scrNTTEFullWorldEnemySprite() }
        }
    }
    else if (sprite_index!=spr_wing) {
        if (sprite_index!=spr_lift) spr_chrg=spr_lift
        else if (_end) { spr_chrg=spr_wing; snd_play(sndMutant14Turn,1.4+random(0.1),2) }
    }
    else if (image_index<1 && current_frame_active) {
        if (random(3)<1) snd_play(sndMutant14LowA,1.8+orandom(0.2),2)
        var _dust=instance_create(x,y,Dust); /* NTTE DUST LIFETIME bone-raven-charge */ if(instance_exists(_dust)) {_dust.direction=270; _dust.speed=2*timescale; _dust.depth=-7 }
    }
    if (sprite_exists(spr_chrg) && sprite_index!=spr_chrg) { sprite_index=spr_chrg; image_index=0 }
    if (failed) {
        top_object.jump_x+=hspeed/timescale; top_object.jump_y+=vspeed/timescale
        var _py=y+top_object.z/2,_bx=sprite_width,_by=sprite_height+top_object.z/2
        if (!(x>=view_xview-_bx+1 && x<=view_xview+view_width+_bx-1
            && _py>=view_yview-_by+1 && _py<=view_yview+view_height+_by-1)) {
            var _floor=scrNTTEFullNearestBBox(x,y,Floor)
            if (instance_exists(_floor)) {
                var _corpse=instance_create((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,Corpse)
                _corpse.sprite_index=mskNone
            }
            instance_destroy(id,false)
        }
    }
}
function scrNTTEFullBoneRavenDeath() {
    if (hp>0) return;
    if (instance_exists(top_object)) instance_destroy(top_object)
    if (instance_exists(creator)) {
        creator.num--
        var _before=scrNTTEFullInstances(Rad),_before_big=scrNTTEFullInstances(BigRad)
        scrRadDrop(x,y,raddrop)
        with (Rad) if (array_get_index(_before,id)<0) scrNTTEFullRadPathAssign(id,other.creator)
        with (BigRad) if (array_get_index(_before_big,id)<0) scrNTTEFullRadPathAssign(id,other.creator)
        raddrop=0
        if (creator.ntte_raven_reward_left>0) creator.ntte_raven_reward_left+=60
    }
}
function scrNTTEFullBoneRavenSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_r=instance_create(10080,10048,NTTEFullBoneRaven)
    assert(_r.max_hp==10*(1+GameCont.loops/20) && _r.raddrop==5 && !_r.active && !_r.failed && _r.ntte_raven_decide_left==-1,"BoneRaven source create fields changed")
    with (_r) { speed=2*timescale; scrNTTEFullBoneRavenStep() }
    assert(_r.speed==0,"Inactive grounded BoneRaven did not stay still")
    var _f=instance_create(10368,10048,Floor)
    with (_r) assert(scrNTTEFullBoneRavenFly(250,350),"BoneRaven could not fly to valid source floor distance")
    assert(instance_exists(_r.top_object) && _r.top_object.target==_r && _r.top_object.zspeed==_r.top_object.jump && _r.top_object.zfriction==_r.top_object.grav,"BoneRaven flight did not initialize the actual TopObject")
    with (_r) { scrNTTEFullBoneRavenStep() }
    assert(_r.sprite_index==_r.spr_lift && _r.ntte_raven_decide_left>=30,"BoneRaven liftoff did not suspend decisions or begin lift animation")
    _r.top_object.zspeed=1; _r.image_index=sprite_get_number(_r.spr_lift)-0.01
    with (_r) scrNTTEFullBoneRavenStep()
    assert(_r.sprite_index==_r.spr_wing,"BoneRaven lift did not transition to original wing animation")
    _r.top_object.zspeed=-1; _r.top_object.z=12; _r.image_index=sprite_get_number(_r.spr_wing)-0.01
    with (_r) scrNTTEFullBoneRavenStep()
    assert(_r.sprite_index==_r.spr_land,"BoneRaven descent did not transition to land animation")
    _r.active=false
    with (_r) scrNTTEFullBoneRavenBeforeHurt()
    assert(_r.active,"BoneRaven first hurt did not activate original escape behavior")
    var _creator=instance_create(0,0,WepSwap)
    _creator.num=2; _creator.ntte_raven_reward_left=30; _r.creator=_creator; _r.hp=0
    instance_destroy(_r)
    assert(_creator.num==1 && _creator.ntte_raven_reward_left==90,"BoneRaven death failed original creator count/time extension")
    var _claimed=0
    with (Rad) if (is_struct(scrNTTEFullValue(id,"ntte_full_rad_path",undefined)) && ntte_full_rad_path.target==_creator) _claimed++
    assert(_claimed==5,"BoneRaven did not return its5 rads through real rad_path")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD BONE RAVEN GROUNDED/REAL TOP FLIGHT/LIFT-WING-LAND/FIRST HURT/CREATOR DEATH COUNT-TIME/RAD PATH OK")
}
