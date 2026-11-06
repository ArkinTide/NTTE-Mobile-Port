// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// Original tetrench EelSkull / WantEel / Vent / decal mine.
function scrNTTEFullEelSkullCreate() {
    spr_idle=scrNTTERefSprite("EelSkullIdle"); spr_hurt=scrNTTERefSprite("EelSkullHurt"); spr_dead=scrNTTERefSprite("EelSkullDead")
    sprite_index=spr_idle; snd_hurt=sndOasisHurt; snd_dead=sndOasisDeath
    ntte_full_bone_drop_done=false
}

function scrNTTEFullEelSkullDeath() {
    // ted esert EndStep applies this to BigSkull children as well. Use a local
    // hook until the general bone-pile hook is present, with a duplicate guard.
    if (hp<=0 && !ntte_full_bone_drop_done) {
        ntte_full_bone_drop_done=true
        var _bone=instance_create(x,y,WepPickup); scrNTTEFullBoneDropVisual(_bone)
        with (_bone) motion_add(random(360),3*timescale)
        repeat(2) instance_create(x+orandom(3),y+orandom(3),Dust)
    }
}

function scrNTTEFullVentCreate() {
    spr_idle=scrNTTERefSprite("VentIdle"); spr_hurt=scrNTTERefSprite("VentHurt"); spr_dead=scrNTTERefSprite("VentDead")
    sprite_index=spr_idle; spr_shadow=mskNone; depth=-2; snd_hurt=sndOasisHurt; snd_dead=sndOasisExplosionSmall
}

function scrNTTEFullVentStep() {
    if (hp<=0) { instance_destroy(); return; }
    if (random(5)<timescale) {
        var _bubble=instance_create(x,y,Bubble)
        _bubble.friction=0.2*timescale*timescale
        with (_bubble) motion_set(90+orandom(5),random_range(4,7)*timescale)
    }
}

function scrNTTEFullWantEelCreate() {
    sprite_index=scrNTTERefSprite("WantEel"); image_xscale=choose(-1,1); image_speed=0.4*timescale; visible=false; depth=1000
    mask_index=mskRat; friction=0.4*timescale*timescale; walk=0; target=noone
    ntte_full_walkspeed=0.6; ntte_full_maxspeed=2.4; ntte_full_pit_height=0; elite=10
    ntte_full_timers=[-1,irandom_range(150,600),-1,-1]
    var _prevent=instance_create(0,0,NTTEFullPortalPrevent); _prevent.creator=id
}

function scrNTTEFullWantEelActivate() {
    ntte_full_timers[1]=30+random(60); scrTarget()
    if (instance_exists(target) && !visible) {
        var _eels=instance_number(NTTEFullEel),_active=0
        with (NTTEFullWantEel) if (visible) _active+=1
        if ((random(3)<1 || _eels<=1) && _eels+_active<=6+4*GameCont.loops) {
            var _floors=[],_land=[],_pits=scrNTTERefSprite("FloorTrenchB"),_pit=noone,_tx=target.x,_ty=target.y
            with (Floor) {
                if (sprite_index==_pits) array_push(_floors,id)
                else array_push(_land,id)
            }
            _floors=array_shuffle(_floors); _land=array_shuffle(_land)
            // NTTE WANT EEL FIRST MATCH pit: original with(array) break exits candidate iteration.
            for(var _i=0;_i<array_length(_floors);++_i) {
                with (_floors[_i]) {
                    if (!scrNTTEFullTrenchPitlessMeeting(x,y)
                        && point_distance((bbox_left+(bbox_right-1)+1)/2,(bbox_top+(bbox_bottom-1)+1)/2,_tx,_ty)<160) {
                        _pit=id
                    }
                }
                if(instance_exists(_pit)) break
            }
            // NTTE WANT EEL FIRST MATCH land: create one pit at the first legal shuffled floor.
            if (!instance_exists(_pit)) for(var _i=0;_i<array_length(_land);++_i) {
                with (_land[_i]) {
                    if (point_distance((bbox_left+(bbox_right-1)+1)/2,(bbox_top+(bbox_bottom-1)+1)/2,_tx,_ty)<160) {
                        var _clear=instance_create(choose(bbox_left,(bbox_right-1)+1),choose(bbox_top,(bbox_bottom-1)+1),PortalClear)
                        _clear.pit_clear=0.75; _clear.pit_smash=true; snd_play_hit(sndOasisExplosionSmall,0.2)
                        _pit=id
                    }
                }
                if(instance_exists(_pit)) break
            }
            if (instance_exists(_pit)) {
                x=(_pit.bbox_left+(_pit.bbox_right-1)+1)/2; y=(_pit.bbox_top+(_pit.bbox_bottom-1)+1)/2
                xprevious=x; yprevious=y; visible=true; ntte_full_timers[2]=30
            }
        }
    }
    if (visible) {
        ntte_full_timers[1]=20+random(20)
        scrNTTEFullTrenchWalk((instance_exists(target) && scrTargetIsVisible(target)) ? point_direction(x,y,target.x,target.y)+orandom(30):random(360),random_range(20,60))
        if (hspeed!=0) image_xscale=abs(image_xscale)*sign(hspeed)
    }
}

function scrNTTEFullWantEelStep() {
    if (lockstep_stop) return;
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) { scrNTTEFullWantEelActivate(); return; }
    if (_due[2]) {
        scrTarget()
        if (instance_exists(target) && point_distance(x,y,target.x,target.y)<96) instance_create(x,y,NTTEFullAssassinNotice)
        return;
    }
    if (!visible) { walk=0; return; }
    if (walk>0) { walk-=timescale; speed+=ntte_full_walkspeed*timescale*timescale }
    speed=min(speed,ntte_full_maxspeed*timescale)
    if (random(30)<timescale) {
        var _spark=instance_create(x+orandom(6),y+orandom(6),NTTEFullPitSpark); _spark.ntte_full_tentacle_visible=false
    }
    ntte_full_pit_height+=0.02*timescale
    if (ntte_full_pit_height>=1) instance_destroy()
}

function scrNTTEFullWantEelEndStep() {
    if (lockstep_stop || !visible) return;
    if (scrNTTEFullTrenchPitlessMeeting(x,y)) {
        x=xprevious; y=yprevious
        if (scrNTTEFullTrenchPitlessMeeting(x+hspeed,y)) hspeed*=-1
        if (scrNTTEFullTrenchPitlessMeeting(x,y+vspeed)) vspeed*=-1
        if (hspeed!=0) image_xscale=abs(image_xscale)*sign(hspeed)
        speed*=0.5
    }
}

function scrNTTEFullWantEelDraw() {
    if (visible) draw_sprite_ext(sprite_index,image_index,x,y+12*(1-ntte_full_pit_height),image_xscale*ntte_full_pit_height,
        image_yscale*ntte_full_pit_height,image_angle,image_blend,image_alpha)
}

function scrNTTEFullWantEelDeath() {
    var _eel=instance_create(x,y,NTTEFullEel)
    _eel.direction=direction; _eel.speed=speed; _eel.walk=walk; _eel.ntte_full_elite=elite
    _eel.right=image_xscale; _eel.ntte_full_timers[1]=30
    repeat(3+irandom(4)) instance_create(x,y,Bubble)
    repeat(1+irandom(2)) instance_create(x,y,PortalL)
    with (NTTEFullPortalPrevent) if (creator==other.id) instance_destroy()
}

function scrNTTEFullTopDecalWaterMineStep() {
    if (instance_exists(creator)) { x=creator.x; y=creator.y; return; }
    if (place_meeting(x,y,FloorExplo)) {
        var _mine=instance_create(x,y,WaterMine)
        if (instance_exists(_mine)) { _mine.hp=0; _mine.spr_dead=scrNTTERefSprite("TrenchMineDead") }
        // telib wall_clear is a mask intersection over real Wall objects.
        with (Wall) if (place_meeting(x,y,other.id)) scrWallDestroy(id)
    }
    instance_destroy()
}
