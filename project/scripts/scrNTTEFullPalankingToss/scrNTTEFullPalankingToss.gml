// Exact tecoast.mod.gml:2916..3050, shared by CatHoleBig and Salamander pet.
// Caller sets creator and the creator's original mask/depth/shadow offset.
function scrNTTEFullPalankingTossCreate() {
    direction=random(360); friction=0.1*timescale*timescale
    creator=noone; z=0; zspeed=8; zfriction=0.5; explo=0; team=team_player; hitid=HitId.None
    depth=-2; mask_index=mskPlayer; spr_shadow_y=0
    ntte_toss_cleaned=false
}

function scrNTTEFullPalankingTossCleanup() {
    if (ntte_toss_cleaned) return;
    ntte_toss_cleaned=true
    if (instance_exists(creator)) with (creator) {
        mask_index=other.mask_index; depth=other.depth
        if (variable_instance_exists(id,"spr_shadow_y")) spr_shadow_y=other.spr_shadow_y
        if (variable_instance_exists(id,"angle")) angle=0
        else image_angle=0
        if (instance_is(id,enemy) && place_meeting(x,y,Floor)) canfly=false
    }
}

function scrNTTEFullPalankingTossEndStep() {
    if (lockstep_stop) return;
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    if (instance_exists(creator) && (z>0 || zspeed>0)) {
        if (instance_is(creator,Player)) { hspeed+=creator.hspeed/10*timescale; vspeed+=creator.vspeed/10*timescale }
        speed=clamp(speed,2*timescale,6*timescale)
        with (creator) {
            x=other.x; y=other.y-other.z; mask_index=mskNone; depth=-9
            if (instance_is(id,enemy)) canfly=true
            if (variable_instance_exists(id,"spr_shadow_y")) spr_shadow_y=other.spr_shadow_y+other.z
            var _a=point_direction(0,0,other.hspeed/timescale,-other.zspeed)-90
            if (variable_instance_exists(id,"angle")) angle=_a
            else image_angle=_a
            if (current_frame%1<timescale && instance_is(id,Player)) {
                var _dust=instance_create(x+orandom(4),y+orandom(4),Dust)
                /* NTTE DUST LIFETIME palanking-toss-trail */ if(instance_exists(_dust)) {_dust.coast_water=false; _dust.depth=depth }
            }
        }
        return;
    }
    scrNTTEFullPalankingTossCleanup()
    if (instance_exists(creator)) {
        var _c=creator
        if (instance_is(_c,hitme) && (place_meeting(_c.x,_c.y,Floor) || GameCont.area!=scrNTTEFullAreaId("coast"))) scr_projectile_hit(_c,1)
        with (_c) {
            if (!place_meeting(x,y,Floor) || place_meeting(x,y,Wall)) {
                if (!place_meeting(x,y,Floor)) {
                    var _near=noone,_best=infinity
                    with (Floor) {
                        var _px=clamp(other.x,bbox_left,bbox_right),_py=clamp(other.y,bbox_top,bbox_bottom),_d=point_distance(other.x,other.y,_px,_py)
                        if (_d<_best) { _best=_d; _near=id }
                    }
                    if (instance_exists(_near) && collision_line(x,y,(_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,Wall,false,false)) scrNTTEFullTopCreate(x,y,id,0,0)
                }
                instance_create(x,y,PortalClear)
            }
        }
    }
    if (explo>0) {
        var _explosion=instance_create(x,y,Explosion)
        with (_explosion) {
            team=other.team; hitid=HitId.Salamander
            for(var _i=0;_i<12*other.explo;++_i) {
                var _flame=instance_create(x,y,Flame)
                with (_flame) {
                    motion_add(random(360),(_i/6+random_range(1.5,2.5))*timescale)
                    hitid=other.hitid; team=other.team; depth=other.depth-1
                }
            }
        }
        snd_play_hit_big(sndFlameCannonEnd,0.3); snd_play_hit(sndExplosion,0.1); sleep(40)
    }
    var _size=instance_exists(creator) && variable_instance_exists(creator,"size") ? creator.size:0
    repeat(5+_size) {
        var _dust=instance_create(x,y,Dust)
        with (_dust) { motion_add(random(360),3*timescale); motion_add(other.direction,timescale) }
    }
    instance_destroy()
}

function scrNTTEFullPalankingTossSmoke() {
    var _p=instance_find(Player,0),_ox=_p.x,_oy=_p.y,_ohp=_p.hp,_onh=_p.nexthurt,_oa=_p.angle
    var _mask=_p.mask_index,_depth=_p.depth,_shadow=_p.spr_shadow_y
    var _t=instance_create(10080,10048,NTTEFullPalankingToss)
    _t.creator=_p; _t.mask_index=_mask; _t.depth=_depth; _t.spr_shadow_y=_shadow
    _t.direction=0; _t.speed=6*timescale; _t.zspeed=12; _t.zfriction=0.8
    with (_t) scrNTTEFullPalankingTossEndStep()
    assert(_p.mask_index==mskNone && _p.depth==-9 && _p.y==_t.y-_t.z && _p.spr_shadow_y==_shadow+_t.z,"PalankingToss failed airborne position/mask/depth/shadow")
    with (_t) { z=0; zspeed=-1; scrNTTEFullPalankingTossEndStep() }
    assert(!instance_exists(_t) && _p.mask_index==_mask && _p.depth==_depth && _p.spr_shadow_y==_shadow && _p.angle==0,"PalankingToss landing failed original state restore")
    // Destroy/Cleanup must restore too, but must never apply landing twice.
    _t=instance_create(10080,10048,NTTEFullPalankingToss)
    _t.creator=_p; _t.mask_index=_mask; _t.depth=_depth; _t.spr_shadow_y=_shadow
    with (_t) scrNTTEFullPalankingTossEndStep()
    instance_destroy(_t)
    assert(_p.mask_index==_mask && _p.depth==_depth,"PalankingToss destruction left Player intangible/airborne")
    _p.x=_ox; _p.y=_oy; _p.hp=_ohp; _p.nexthurt=_onh; _p.angle=_oa
    scrNTTESmokeLog("FULL WORLD PALANKING TOSS AIRBORNE/SHADOW/MASK/DEPTH + LANDING/CLEANUP RESTORE OK")
}
