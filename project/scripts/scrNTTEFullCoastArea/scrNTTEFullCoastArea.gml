// areas/coast.area.gml. Maintenance draft: register only after sea/wading
// renderer hooks and all normal/subarea exit tests are integrated by root.
function scrNTTEFullCoastSetupNative() {
    goal=100; background_set_colour(scrAreaGetBackroundColor(GameCont.area))
    with(BackCont) shadow_color=c_black
    with(TopCont) darkness=false
    GameCont.ntte_pop_enemies_wait=0
}
function scrNTTEFullCoastMakeFloor() {
    var _px=x,_py=y,_out=point_distance(x,y,10000,10000)>48
    if(random(5)<1) scrNTTEFullFloorFill(_px+16,_py+16,irandom_range(4,6),irandom_range(4,6),"round")
    else scrNTTEFullFloorFill(_px+16,_py+16,2,1)
    var _turn=0
    if(random(7)<3) _turn=choose(90,-90,180)
    direction+=_turn
    if(_turn==180) {
        if(_out) instance_create(_px+16,_py+16,WeaponChest)
        if(random(2)<1 && GameCont.subarea>0) {
            var _dir=direction+180
            _px+=lengthdir_x(96,_dir); _py+=lengthdir_y(96,_dir)
            with(instance_create(_px,_py,FloorMaker)) direction=_dir+choose(-90,0,90)
            if(_out) instance_create(_px+16,_py+16,choose(AmmoChest,WeaponChest,RadChest))
        }
    }
    if(random(19+instance_number(FloorMaker))>=22) {
        if(_out) instance_create(_px+16,_py+16,AmmoChest)
        instance_destroy()
    }
    if(GameCont.loops>0 && instance_number(Floor)>GenCont.goal && GameCont.subarea==2 && GameCont.crownvisits<3) {
        with(instance_furthest(10000,10000,Floor)) with(instance_nearest(
            (x*2+10000)/3+orandom(64),(y*2+10000)/3+orandom(64),Floor)) instance_create(x+16,y+16,ProtoStatue)
    }
}
function scrNTTEFullCoastBuildNative() {
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
            else { x+=lengthdir_x(32,direction); y+=lengthdir_y(32,direction); scrNTTEFullCoastMakeFloor() }
        }
        if(instance_number(Floor)>_last) { _last=instance_number(Floor); _tries=400 }
    }
    if(instance_exists(FloorMaker)) throw "Coast source island generator did not converge"
}
function scrNTTEFullCoastPopEnemies() {
    var _px=x+16,_py=y+16
    if(GameCont.ntte_pop_enemies_wait--<=0) {
        GameCont.ntte_pop_enemies_wait=1
        if(GameCont.loops>0 && random(3)<1) {
            if(random(3)<1) {
                with(instance_nearest(x,y,prop)) {
                    var _start=random(360),_num=irandom_range(1,4)
                    for(var _ang=_start;_ang<_start+360;_ang+=360/_num) {
                        var _off=16+random(16)
                        instance_create(x+lengthdir_x(_off,_ang),y+lengthdir_y(_off,_ang),
                            choose(NTTEFullBloomingAssassinHide,NTTEFullBloomingAssassinHide,NTTEFullBloomingBush))
                    }
                }
            }
            else repeat(irandom_range(1,2)) instance_create(_px,_py,Raven)
        }
        else if(styleb) instance_create(_px+orandom(2),_py-irandom(16),NTTEFullTrafficCrab)
        else if(random(18)<max(1,GameCont.subarea)) instance_create(_px,_py,choose(NTTEFullPelican,NTTEFullPelican,NTTEFullTrafficCrab))
        else instance_create(_px,_py,choose(NTTEFullDiver,NTTEFullGull,NTTEFullGull,NTTEFullGull,NTTEFullGull))
        if(GameCont.loops>0 && random(6)<1) {
            var _dir=random(360),_dist=640+random(1080)
            for(var _i=1;_i<=4;++_i) with(instance_create(x+lengthdir_x(_dist,_dir),y+lengthdir_y(_dist,_dir),Turtle))
                snd_dead=asset_get_index("sndTurtleDead"+string(_i))
        }
    }
    else if(GameCont.subarea==3 && random(2*instance_number(NTTEFullSeal))<1) {
        if(styleb) instance_create(_px,_py,random(16)<1 ? NTTEFullSealHeavy:NTTEFullSeal)
        else repeat(4) instance_create(_px,_py,NTTEFullSeal)
    }
}
function scrNTTEFullCoastPopProps() {
    var _px=x+16,_py=y+16,_spawn=point_distance(_px,_py,10016,10016)
    if(random(12)<1) {
        if(_spawn>48) instance_create(_px,_py,!styleb && random(8)<1 ? NTTEFullBuriedCar:
            choose(NTTEFullBloomingCactus,NTTEFullBloomingCactus,NTTEFullBloomingCactus,NTTEFullPalm))
    }
    else if(GameCont.subarea==3 && random(40)<1) with(instance_create(_px+orandom(8),_py+orandom(8),NTTEFullSealMine)) {
        if(!other.styleb) {
            var _distance=24+random(16),_tries=1024
            while(distance_to_object(Floor)<_distance && _tries-->0) { x+=lengthdir_x(64,direction); y+=lengthdir_y(64,direction) }
            if(_tries<=0) throw "Coast source sea mine could not find open water"
        }
    }
}
function scrNTTEFullCoastPopExtras() {
    var _chests=scrNTTEFullInstances([WeaponChest,AmmoChest,RadChest])
    for(var _i=0;_i<array_length(_chests);++_i) instance_create(_chests[_i].x,_chests[_i].y,NTTEFullDiver)
    with(Floor) if(random(3)<1) for(var _ang=0;_ang<360;_ang+=45) {
        var _px=(bbox_left+bbox_right)/2,_py=(bbox_top+bbox_bottom)/2,
            _mx=mask_index>=0 ? mask_index:sprite_index
        if(random(2)<1 && !position_meeting(_px+lengthdir_x(sprite_get_width(_mx),_ang),
            _py+lengthdir_y(sprite_get_height(_mx),_ang),Floor)) {
            var _len=random_range(32,44),_dir=_ang+orandom(20)
            _px+=lengthdir_x(_len,_dir); _py+=lengthdir_y(_len,_dir)
            if(!position_meeting(_px,_py,Floor)) with(instance_create(_px,_py,Detail)) depth=21
        }
    }
}
function scrNTTEFullCoastPopulateNative() { scrPopulate(); scrNTTEFullCoastPopExtras() }
function scrNTTEFullCoastStart() {
    GameCont.ntte_full_active_coast=true
    if(GameCont.subarea>0) {
        // The real ordered sea passes are emitted in the same integration batch.
        scrNTTEFullCoastSeaEnsure()
        var _setup=scrNTTEFullInstances([hitme,projectile,Corpse,ChestOpen,chestprop,Debris,CrownObject]),
            _pickups=scrNTTEFullCoastPickupInstances()
        for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_setup,_pickups[_i])<0) array_push(_setup,_pickups[_i])
        for(var _i=0;_i<array_length(_setup);++_i) with(_setup[_i]) scrNTTEFullCoastWadingSetup()
        with(Wall) if(scrNTTEFullValue(id,"area",GameCont.area)==scrNTTEFullAreaId("coast")) instance_destroy(id,false)
        with(TopSmall) {
            if(random(80)<1) instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,NTTEFullCoastDecal)
            instance_destroy(id,false)
        }
        scrNTTEFullUnlockSet("race:parrot",true)
    }
    var _floors=scrNTTEFullInstances(Floor,true)
    switch(GameCont.subarea) {
        case 1:
            if(array_length(_floors)>0) with(_floors[irandom(array_length(_floors)-1)])
                with(instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,NTTEFullCoastBigDecal)) {
                    direction=random(360)
                    var _length=random_range(16,32),_tries=4096
                    while(collision_rectangle(bbox_left+20,bbox_top+6,bbox_right-21,bbox_bottom-7,Floor,false,false) && _tries-->0) {
                        x+=lengthdir_x(_length,direction); y+=lengthdir_y(_length,direction)
                    }
                    if(_tries<=0) throw "Coast source Parrot shell could not leave island floors"
                    xstart=x; ystart=y
                    var _friend=scrNTTEFullPetCreate(x,y,"Parrot")
                    _friend.perched=id; _friend.can_take=false
                }
            break
        case 2:
            if(scrNTTEFullValue(GameCont,"sunkenchests",0)<=GameCont.loops && array_length(_floors)>0)
                with(_floors[irandom(array_length(_floors)-1)]) {
                    var _treasure=scrNTTEFullLairChestCreate((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,"SunkenChest",true)
                    with(_treasure) {
                        var _distance=160+orandom(32),_dir=random(360),_tries=4096
                        while(distance_to_object(Floor)<_distance && _tries-->0) { x+=lengthdir_x(16,_dir); y+=lengthdir_y(16,_dir) }
                        if(_tries<=0) throw "Coast source treasure could not reach open water"
                    }
                }
            break
        case 3:
            with(instance_create(10016,10016,NTTEFullPalanking)) {
                var _dir=random(360),_tries=4096
                while(distance_to_object(Floor)<160 && _tries-->0) { x+=lengthdir_x(10,_dir); y+=lengthdir_y(10,_dir) }
                if(_tries<=0) throw "Coast source Palanking could not reach open water"
                scrNTTEFullWorldLook(_dir+180); xstart=x; ystart=y
            }
            break
    }
    with(RadChest) if(random(40)<1) { instance_create(x,y,NTTEFullAngler); instance_destroy(id,false) }
    var _sea=instance_find(NTTEFullCoastSea,0)
    if(instance_exists(_sea)) _sea.ntte_coast_surfaces[0].reset=true
}
function scrNTTEFullCoastFinish() {
    GameCont.ntte_visits_coast=scrNTTEFullValue(GameCont,"ntte_visits_coast",0)+1
    if(GameCont.subarea<3) GameCont.subarea++
    else { GameCont.area=scrNTTEFullAreaId("oasis"); GameCont.subarea=1 }
}
function scrNTTEFullCoastTransit() {
    GameCont.ntte_full_active_coast=false; GameCont.ntte_area_update=true
    scrNTTEFullCoastVisible(true)
    GameCont.ntte_sea_inst=[]
    with(all) if(persistent && scrNTTEFullValue(id,"wading",0)>0) { wading=0; wading_sink=0 }
}
function scrNTTEFullCoastEffect() {
    alarm[0]=irandom_range(1,60)
    var _players=[],_seen=[]
    with(Player) if(scrNTTEFullPlayerActive(id)) array_push(_players,id)
    if(array_length(_players)<=0) return;
    var _player=_players[irandom(array_length(_players)-1)]
    with(Floor) if(bbox_left<view_xview+view_width && bbox_right>view_xview
        && bbox_top<view_yview+view_height && bbox_bottom>view_yview) array_push(_seen,id)
    if(array_length(_seen)>0) with(_seen[irandom(array_length(_seen)-1)])
        instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Wind)
}
