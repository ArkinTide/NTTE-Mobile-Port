// areas/oasis.area.gml. Actual FloorMaker topology and native population chain.
// Registration/RoomEnd/environment alarm hooks remain centralized at root.
function scrNTTEFullOasisSetupNative() {
    goal=130; background_set_colour(scrAreaGetBackroundColor(GameCont.area))
    with(BackCont) shadow_color=scrAreaGetShadowColor(GameCont.area)
    with(TopCont) darkness=false
    GameCont.underwater=true
}
function scrNTTEFullOasisMakeFloor() {
    var _px=x,_py=y,_out=point_distance(x,y,10000,10000)>48
    instance_create(_px,_py,Floor)
    if(random(3)<1) scrNTTEFullFloorFill(_px+16,_py+16,3,3,"round")
    var _turn=0
    if(random(4)<1) _turn=choose(90,90,-90,-90,180)
    direction+=_turn
    if(_turn==180 && _out) instance_create(_px+16,_py+16,WeaponChest)
    if(random(19+instance_number(FloorMaker))>=20) {
        if(_out) instance_create(_px+16,_py+16,AmmoChest)
        instance_destroy()
    }
    // This is independent of the dead-end branch in the original source.
    if(random(5)<1) instance_create(_px,_py,FloorMaker)
}
function scrNTTEFullOasisBuildNative() {
    instance_destroy(FloorMaker,false)
    with(instance_create(10000,10000,FloorMaker)) goal=other.goal
    var _tries=400,_last=instance_number(Floor)
    while(instance_exists(FloorMaker) && _tries-->0) {
        with(FloorMaker) {
            xprevious=x; yprevious=y
            if(instance_number(Floor)>goal) {
                if(point_distance(x,y,10016,10016)>48) {
                    instance_create(x,y,Floor); instance_create(x+16,y+16,RadChest)
                }
                instance_destroy()
            }
            else { x+=lengthdir_x(32,direction); y+=lengthdir_y(32,direction); scrNTTEFullOasisMakeFloor() }
        }
        if(instance_number(Floor)>_last) { _last=instance_number(Floor); _tries=400 }
    }
    if(instance_exists(FloorMaker)) throw "Oasis source generator did not converge"
}
function scrNTTEFullOasisPopEnemies() {
    var _px=x+16,_py=y+16
    if(random(2)>=1) return;
    var _top=random(2)<1 // Source consumes this roll even though unused.
    if(random(2)<1) {
        if(!styleb && random(4)<3) {
            if(GameCont.loops>0 && random(2)<1) repeat(irandom_range(1,4)) instance_create(_px,_py,Freak)
            repeat(irandom_range(1,4)) instance_create(_px,_py,BoneFish)
        }
        else repeat(irandom_range(1,4)) instance_create(_px,_py,NTTEFullPuffer)
    }
    else if(GameCont.loops>0 && random(3)<1) instance_create(_px,_py,choose(Necromancer,Ratking))
    else if(random(5)<1) instance_create(_px,_py,NTTEFullDiver)
    else if(!styleb) { if(random(2)<1) instance_create(_px,_py,Crab) }
    else instance_create(_px,_py,NTTEFullHammerShark)
}
function scrNTTEFullOasisPopProps() {
    if(random(14)<1 && point_distance(x,y,10000,10000)>96
        && !place_meeting(x,y,NOWALLSHEREPLEASE) && !place_meeting(x,y,hitme)) {
        instance_create(x+choose(0,16),y+choose(0,16),Wall); instance_create(x,y,NOWALLSHEREPLEASE)
    }
    else if(random(10)<1) {
        var _px=x+16,_py=y+16
        if(random(40)<1 && !place_meeting(x-32,y,Wall) && !place_meeting(x+32,y,Wall)) instance_create(_px,_py,Anchor)
        else if(point_distance(_px,_py,10016,10016)>96) instance_create(_px,_py,choose(LightBeam,LightBeam,WaterPlant,WaterPlant,WaterMine,WaterMine,OasisBarrel))
    }
}
function scrNTTEFullOasisPopExtras() {
    scrNTTEFullFloorBones(scrNTTEFullInstances(Floor,true),2,1/9)
    var _chests=scrNTTEFullInstances([WeaponChest,AmmoChest,RadChest])
    for(var _i=0;_i<array_length(_chests);++_i) instance_create(_chests[_i].x,_chests[_i].y,NTTEFullDiver)
}
function scrNTTEFullOasisPopulateNative() { scrPopulate(); scrNTTEFullOasisPopExtras() }
function scrNTTEFullOasisStart() {
    GameCont.ntte_full_active_oasis=true
    with(RadChest) if(random(40)<1) { instance_create(x,y,NTTEFullAngler); instance_destroy(id,false) }
    var _floors=scrNTTEFullInstances(Floor,true)
    if(GameCont.subarea==1 && array_length(_floors)>0 && instance_exists(Player)) {
        var _shuffled=array_shuffle(_floors),_shrine_created=false
        for(var _i=0;_i<array_length(_shuffled);++_i) {
            with(_shuffled[_i]) {
                var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
                if(point_distance(_cx,_cy,10016,10016)>48 && !place_meeting(x,y,prop)
                    && !place_meeting(x,y,chestprop) && !place_meeting(x,y,Wall)) {
                    instance_create(_cx,_cy,NTTEFullOasisPetBecome); _shrine_created=true;
                }
            }
            // The original breaks its shuffled-array iteration. A break in
            // with(single_id) only exits that with, leaving the for running.
            if(_shrine_created) break;
        }
    }
    var _near=scrNTTEFullWorldNearestRectBBox(10016,10016,10016,10016,_floors)
    if(instance_exists(_near)) {
        var _manhole=instance_create((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,NTTEFullManhole)
        _manhole.sprite_index=scrNTTERefSprite("Crack"); _manhole.visible=false; _manhole.contact=true
        // AreaSet stores the final native destination; NTT's source0 advances
        // once during RoomEnd, whereas our pending destination skips that step.
        _manhole.area=scrNTTEFullAreaId("trench"); _manhole.subarea=1
        // BEGIN NTTE OASIS CRACK SOURCE ENTRY FINISH
        // Original Crack sets Trench0 before RoomEnd selects current-area finish.
        _manhole.ntte_full_source_entry_finish={origin:"oasis_crack",area:scrNTTEFullAreaId("trench"),subarea:0}
        // END NTTE OASIS CRACK SOURCE ENTRY FINISH
    }
    if(scrNTTEFullValue(GameCont,"sunkenchests",0)<=GameCont.loops && array_length(_floors)>0) {
        var _floor=_floors[irandom(array_length(_floors)-1)],
            _room=scrNTTEFullFloorRoomCreate((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,3,3,"round",random(360),[30,60],64)
        var _chest=scrNTTEFullLairChestCreate(_room.x,_room.y,"SunkenChest",true)
        _chest.skeal=true; instance_create(_chest.x,_chest.y-8,LightBeam)
        var _safety=instance_create(_room.x1,_room.y1,NTTEFullSunkenRoom)
        _safety.image_xscale=3; _safety.image_yscale=3; _safety.floors=_room.floors
        for(var _i=0;_i<array_length(_room.floors);++_i) with(_room.floors[_i]) {
            instance_create(random_range(bbox_left,bbox_right-1),random_range(bbox_top,bbox_bottom-1),Detail)
            scrNTTEFullFloorBones(id,2,1/4)
        }
    }
    var _tops=scrNTTEFullInstances([TopSmall,Wall])
    for(var _i=0;_i<array_length(_tops);++_i) with(_tops[_i]) if(random(300)<1)
        scrNTTEFullTopCreate(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),random(1.25)<1 ? OasisBarrel:Anchor,-1,-1)
}
function scrNTTEFullOasisFinish() {
    GameCont.ntte_visits_oasis=scrNTTEFullValue(GameCont,"ntte_visits_oasis",0)+1
    GameCont.area=area_scrapyards; GameCont.subarea=3
}
function scrNTTEFullOasisTransit() { GameCont.ntte_full_active_oasis=false }
function scrNTTEFullOasisEffect() {
    // Called from the actual environment controller Alarm0 at source30..50tick cadence.
    alarm[0]=irandom_range(30,50)
    if(random(4)<1 && instance_exists(NTTEFullPet)) with(NTTEFullPet) instance_create(x,y,Bubble)
    if(random(4)<1 && instance_exists(Player)) with(Player) instance_create(x,y,Bubble)
    else {
        var _active=[]
        with(Player) if(scrNTTEFullPlayerActive(id)) array_push(_active,id)
        if(array_length(_active)>0) {
            var _player=_active[irandom(array_length(_active)-1)],_seen=[]
            var _floors=scrNTTEFullInstances(Floor)
            for(var _i=0;_i<array_length(_floors);++_i) {
                var _f=_floors[_i]
                // Epsilon uses one shared native camera for active players.
                // Source instances_seen tests the complete floor rectangle.
                if(_f.bbox_left<view_xview+view_width && _f.bbox_right>view_xview
                    && _f.bbox_top<view_yview+view_height && _f.bbox_bottom>view_yview) array_push(_seen,_f)
            }
            if(array_length(_seen)>0) with(_seen[irandom(array_length(_seen)-1)])
                instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Bubble)
        }
    }
}
