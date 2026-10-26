// Undergrowth1.0.3 generation, entry and finish boundaries.
function scrUGSetup() {
    goal=120;
    background_set_colour(make_color_rgb(102,78,24));
    scrNTTEFullAreaDarknessNative();
}
function scrUGBuild() {
    instance_destroy(FloorMaker,false);
    with(instance_create(10000,10000,FloorMaker)) goal=other.goal;
    var _tries=2048;
    while(instance_exists(FloorMaker) && _tries-->0) with(FloorMaker) {
        xprevious=x;yprevious=y;
        if(instance_number(Floor)>goal) {
            if(point_distance(x,y,10016,10016)>48) {
                instance_create(x,y,Floor);instance_create(x+16,y+16,RadChest);
            }
            instance_destroy();
        }
        else {
            x+=lengthdir_x(32,direction);y+=lengthdir_y(32,direction);
            scrUG_area_make_floor();
        }
    }
    if(instance_exists(FloorMaker)) throw "Undergrowth floor generator did not converge";
}
function scrUGPopulate() {scrPopulate();scrUG_area_pop_extras();}
function scrUGStart() {GameCont.ug_active=true;}
function scrUG_area_sprite(_spr) {
    switch(_spr) {
        case sprFloor1:return sprUGFloorUndergrowth;
        case sprFloor1B:return sprUGFloorUndergrowthB;
        case sprFloor1Explo:return sprUGFloorUndergrowthExplo;
        case sprWall1Top:return sprUGWallUndergrowthTop;
        case sprWall1Bot:return sprUGWallUndergrowthBot;
        case sprWall1Out:return sprUGWallUndergrowthOut;
        case sprWall1Trans:return sprUGWallUndergrowthTrans;
        case sprTopPot:return sprUGUndergrowthTopDecal;
        case sprBones:return sprUGUndergrowthDecal;
        case sprDebris1:return sprUGDebrisUndergrowth;
        case sprDetail1:return sprUGDetailUndergrowth;
    }
    return _spr;
}
function scrUGRoomStart() {
    if(!instance_exists(UGWorld)) instance_create(0,0,UGWorld);
    if(!instance_exists(UGTop)) instance_create(0,0,UGTop);
}
function scrUGAfterGeneration() {
    // Run at the real GenCont finalization boundary, after source floors and
    // chests exist. No per-frame scan of ordinary rooms.
    if(GameCont.loops>0) {
        switch(GameCont.area) {
            case area_scrapyards:
                with(Salamander) if(random(3)<1) {scrUGCreate(x,y,"Flytrap");instance_destroy(id,false);}
                break;
            case area_caves:
                with(instance_furthest(10000,10000,Floor)) scrUGCreate((bbox_left+bbox_right-1)/2,(bbox_top+bbox_bottom-1)/2,"Millipede");
                break;
            case area_palace:
                var _guardians=scrNTTEFullInstances([ExploGuardian,DogGuardian]);
                for(var _i=0;_i<array_length(_guardians);++_i) with(_guardians[_i]) if(random(8)<1) {scrUGCreate(x,y,"GoldPitcherPlant");instance_destroy(id,false);}
                break;
        }
    }
    if(GameCont.area==area_scrapyards && GameCont.subarea==3) {
        var _chest=instance_find(chestprop,0);
        if(instance_exists(_chest)) {
            var _ref=instance_nearest(_chest.x-16,_chest.y-16,Floor),_floors=scrNTTEFullInstances(Floor);
            for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
                if(mask_index==mskFloor && real(id)<real(_ref) && !place_meeting(x,y,Wall) && !place_meeting(x,y,prop) && !place_meeting(x,y,chestprop)) {
                    scrUGCreate(x+16,y+16,"FireFlower");return;
                }
            }
        }
    }
}
function scrUGFlowerStep() {
    x=xstart;y=ystart;speed=0;
    if(sprite_index==spr_hurt && image_index+image_speed>=image_number) sprite_index=spr_idle;
    if(instance_exists(prompt) && prompt.pick>=0) {
        with(GameCont) {scrNTTEFullAreaSet(207,1,loops);killenemies=true;}
        for(var _d=0;_d<360;_d+=120) with(instance_create(x+lengthdir_x(5,_d),y+lengthdir_y(5,_d),BloodStreak)) {
            sprite_index=sprUGFuelStreak;direction=_d+orandom(10);image_angle=direction;speed=5*timescale;
        }
        with(chestprop) mask_index=mskNone;
        instance_create(x,y,Portal);hp=0;
    }
    if(instance_exists(ChestOpen) && instance_exists(FXChestOpen)) {
        repeat(3) with(instance_create(x,y,Smoke)) motion_set(random(360),random(3)*timescale);
        spr_dead=spr_exit;hp=0;
    }
    if(hp<=0) {
        with(instance_create(x,y,Corpse)) {sprite_index=other.spr_dead;image_xscale=other.image_xscale;size=other.size;}
        instance_destroy();
    }
}
function scrUGEffect() {
    // The source re-arms its BackCont timer by30+random(30) logical ticks.
    // Keep a room-owned clock instead of approximating it with a frame chance.
    if(!instance_exists(UGWorld)) return;
    UGWorld.ember_left-=timescale;
    if(UGWorld.ember_left>0) return;
    UGWorld.ember_left+=30+random(30);
    var _floors=scrNTTEFullRectInstances(view_xview,view_yview,view_xview+view_width,view_yview+view_height,Floor);
    if(array_length(_floors)>0) with(_floors[irandom(array_length(_floors)-1)]) {
        var _ember=scrUGCreate(random_range(bbox_left,bbox_right-1),random_range(bbox_top,bbox_bottom-1),"Ember");
        _ember.image_speed/=2;_ember.speed/=2;
    }
}
function scrUGFinishDestination() {
    if(is_struct(scrNTTEFullValue(id,"ntte_full_pending_destination",undefined))) return;
    // Entry uses subarea0 so the next natural room is the single area207/1.
    if(subarea<1) {scrNTTEFullAreaSet(207,1,loops);return;}
    if(scr_skill_get(mut_last_wish)>0) {
        scr_skill_set(mut_last_wish,0);skillpoints++;junglevisits++;junpick=true;
    }
    if(instance_exists(UGChest)) nochest++;
    scrNTTEFullAreaSet(area_jungle,1,loops);
    ug_active=false;
}
function scrUGWorldStep() {
    if(lockstep_stop) return;
    with(Explosion) if(scrNTTEFullValue(id,"name","")=="MushroomExplosion") {x=xstart;y=ystart;speed=0;}
    // Sparse post-step camera feedback; no repeated all-enemy sorted scans.
    if(current_frame_active && instance_exists(UGEnemy)) with(Player) {
        var _near=noone,_distance=128;
        with(UGEnemy) if(name=="MillipedeSegment" && visible) {
            var _d=point_distance(x,y,other.x,other.y);
            if(_d<_distance) {_distance=_d;_near=id;}
        }
        if(instance_exists(_near)) {
            var _v=point_distance(_near.x,_near.y,_near.xprevious,_near.yprevious)/timescale;
            scrNTTEFullTrenchShake(x,y,7*(1-_distance/128)*_v/_near.maxspeed);
        }
    }
}
