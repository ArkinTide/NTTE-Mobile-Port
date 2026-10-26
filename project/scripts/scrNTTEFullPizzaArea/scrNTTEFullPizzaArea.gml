// areas/pizza.area.gml. An8x6 den, shared source door/drain/social systems.
function scrNTTEFullPizzaSetupNative() {
    goal=50; safespawn=0; turtle_den={cols:0,rows:0,cols_max:8,rows_max:6}
    background_set_colour(scrAreaGetBackroundColor(GameCont.area)); scrNTTEFullAreaDarknessNative()
    // The original temporarily invokes native Pizza room_start solely for
    // unlocks. Dispatch that same native unlock function with a saved area.
    var _area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops
    GameCont.area=area_pizza_sewers; GameCont.subarea=1; GameCont.loops=0
    scrUnlocksArea()
    GameCont.area=_area; GameCont.subarea=_subarea; GameCont.loops=_loops
}
function scrNTTEFullPizzaMakeFloor() {
    var _den=GenCont.turtle_den,_scale=goal/(_den.cols_max*_den.rows_max+2)
    if(_den.cols<=0) { x=xstart-48; instance_create(xstart,ystart-32,Floor) }
    if(_den.rows<=0) y=ystart-64
    direction=90; styleb=false; instance_create(x,y,Floor)
    _den.rows++
    if(_den.rows>=_den.rows_max*_scale) {
        x+=32; _den.rows=0; _den.cols++
        if(_den.cols>=_den.cols_max*_scale) instance_destroy()
    }
}
function scrNTTEFullPizzaBuildNative() {
    instance_destroy(FloorMaker,false)
    with(instance_create(10000,10000,FloorMaker)) goal=other.goal
    var _tries=512
    while(instance_exists(FloorMaker) && _tries-->0) with(FloorMaker) {
        xprevious=x; yprevious=y
        // Native scrMakeFloor moves32px before each source area callback.
        x+=lengthdir_x(32,direction); y+=lengthdir_y(32,direction)
        scrNTTEFullPizzaMakeFloor()
    }
    if(instance_exists(FloorMaker)) throw "Pizza den source builder did not terminate"
}
function scrNTTEFullPizzaPopEnemies() { /* Source pizza has no area_pop_enemies. */ }
function scrNTTEFullPizzaPopProps() {
    var _px=x+16,_py=y+16,_west=!position_meeting(x-16,y,Floor),_east=!position_meeting(x+48,y,Floor),
        _north=!position_meeting(x,y-16,Floor),_south=!position_meeting(x,y+48,Floor)
    if(!_north && !_south && !_west && _east) repeat(irandom_range(1,4)) {
        var _kind=irandom(2),_xx=_px+orandom(4),_yy=_py+orandom(4)
        if(_kind==0) instance_create(_xx,_yy,NTTEFullPizza)
        else if(_kind==1) instance_create(_xx,_yy,PizzaBox)
        else instance_create(_xx,_yy,NTTEFullPizzaChest)
    }
    if(random(30)<1) scrNTTEFullAreaTopDecalCreate(_px,_py)
}
function scrNTTEFullPizzaPopExtras() {
    var _x1=infinity,_y1=infinity,_x2=-infinity,_y2=-infinity
    // Epsilon finalizes its native spawn at10016,10016; NTT calls that spawn_y.
    with(Floor) if(y<10016-32) {
        _x1=min(_x1,bbox_left); _y1=min(_y1,bbox_top); _x2=max(_x2,bbox_right); _y2=max(_y2,bbox_bottom)
    }
    var _floor=instance_nearest(lerp(_x1,_x2,0.8),_y1,Floor)
    if(!instance_exists(_floor)) throw "Pizza source den has no upper floors"
    scrNTTEFullPizzaDrainCreate(_floor.x,_floor.y)
    _floor=instance_nearest(lerp(_x1,_x2,0.5)-16,lerp(_y1,_y2,0.3),Floor)
    instance_create(_floor.x,_floor.y-16,NTTEFullPizzaTV)
    with(Floor) {
        if(!place_meeting(x-32,y,Floor) && !place_meeting(x,y-32,Floor)) instance_create(x,y,Wall)
        else if(!place_meeting(x+32,y,Floor) && !place_meeting(x,y-32,Floor)) instance_create(x+16,y,Wall)
        else if(!place_meeting(x-32,y,Floor) && !place_meeting(x,y+32,Floor)) instance_create(x,y+16,Wall)
        else if(!place_meeting(x+32,y,Floor) && !place_meeting(x,y+32,Floor)) instance_create(x+16,y+16,Wall)
    }
}
function scrNTTEFullPizzaPopulateNative() { scrPopulate(); scrNTTEFullPizzaPopExtras() }
function scrNTTEFullPizzaWatcherPlace() {
    // Food is placed over a whole Floor bbox, including its wall-adjacent
    // edge. A watcher born there can overlap the perimeter and be pushed out
    // when it becomes hostile. Correct only these initial Pizza NPC positions.
    if(!place_meeting(x,y,Wall) && position_meeting(x,y,Floor)) return;
    var _wantx=x,_wanty=y,_best=infinity,_bestx=x,_besty=y,_found=false;
    with(Floor) {
        var _cx=clamp(_wantx,bbox_left+10,bbox_right-10),
            _cy=clamp(_wanty,bbox_top+10,bbox_bottom-10);
        with(other) if(!place_meeting(_cx,_cy,Wall) && position_meeting(_cx,_cy,Floor)) {
            var _distance=point_distance(_wantx,_wanty,_cx,_cy);
            if(_distance<_best) {_best=_distance;_bestx=_cx;_besty=_cy;_found=true;}
        }
    }
    if(_found) {x=_bestx;y=_besty;xprevious=x;yprevious=y;xstart=x;ystart=y;}
}
function scrNTTEFullPizzaStart() {
    GameCont.ntte_full_active_pizza=true
    var _wall=instance_find(Wall,0)
    if(instance_exists(_wall)) with(_wall) if(place_meeting(x,y,Floor) && abs(point_distance(10016,10016,x,y)-48)<12) instance_destroy()
    with(Floor) if(place_meeting(x,y,PizzaBox) || place_meeting(x,y,HealthChest) || place_meeting(x,y,HPPickup)) {
        styleb=true; scrNTTEFullAreaFloorSetup(GameCont.area)
    }
    with(HPPickup) alarm[0]*=2
    instance_create(10016,10016,NTTEFullPizzaManholeCover)
    var _near=scrNTTEFullWorldNearestRectBBox(10016,10016,10016,10016,Floor)
    if(instance_exists(_near)) {
        var _doors=scrNTTEFullCatDoorPair(_near.x+16,_near.y-16,90)
        // Original door_create advances both leaves immediately to bind their
        // source support walls and opening masks before player input resumes.
        for(var _i=0;_i<array_length(_doors);++_i) with(_doors[_i]) event_perform(ev_step,ev_step_normal)
    }
    with(TV) {
        x+=random(32); xstart=x
        var _rug=scrNTTEFullLairCreate(x,y+16,"SewerRug")
        with(_rug) {
            var _steps=12
            while(!collision_circle(x,y,24,Wall,false,false) && _steps-->0) y+=4
            var _colors=[1,2,4],_dir=random(360)
            for(var _i=0;_i<array_length(_colors);++_i) with(instance_create(x,y,NTTEFullTurtleCool)) {
                move_contact_solid(_dir+orandom(10),20+random(4))
                snd_dead=asset_get_index("sndTurtleDead"+string(_colors[_i])); scrNTTESewerLook(_dir+180); _dir+=120
            }
        }
        with(instance_create(x+orandom(4),y+orandom(4),NTTEFullTurtleCool)) {
            move_contact_solid(random(180),random_range(12,64))
            spr_idle=sprRatIdle; spr_walk=sprRatWalk; spr_hurt=sprRatHurt; spr_dead=sprRatDead; sprite_index=spr_idle
            snd_hurt=sndRatHit; snd_dead=sndRatDie; ntte_full_become=Rat; right=1
        }
        var _food=scrNTTEFullInstances([PizzaBox,HealthChest,HPPickup])
        if(array_length(_food)>0) with(_food[irandom(array_length(_food)-1)]) with(instance_create(x+orandom(4),y+orandom(4),NTTEFullTurtleCool)) {
            snd_dead=sndTurtleDead3; right=1
        }
    }
    with(NTTEFullTurtleCool) scrNTTEFullPizzaWatcherPlace();
    var _chests=scrNTTEFullInstances([chestprop,RadChest])
    for(var _i=0;_i<array_length(_chests);++_i) scrNTTEFullLairLight(_chests[_i].x,_chests[_i].y-28)
    with(PizzaBox) { instance_create(x,y,NTTEFullPizzaStack); instance_destroy(id,false) }
}
function scrNTTEFullPizzaFinish() {
    GameCont.ntte_visits_pizza=scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)+1
    if(GameCont.subarea<1) GameCont.subarea++
    else { GameCont.area=area_scrapyards; GameCont.subarea=1 }
}
function scrNTTEFullPizzaTransit() { GameCont.ntte_full_active_pizza=false }
function scrNTTEFullPizzaEffect() {
    alarm[0]=irandom_range(1,120)
    var _players=[]
    with(Player) if(scrNTTEFullPlayerActive(id)) array_push(_players,id)
    if(array_length(_players)<=0) return;
    var _player=_players[irandom(array_length(_players)-1)],_seen=[]
    with(Floor) if(bbox_left<view_xview+view_width && bbox_right>view_xview
        && bbox_top<view_yview+view_height && bbox_bottom>view_yview) array_push(_seen,id)
    if(array_length(_seen)>0) with(_seen[irandom(array_length(_seen)-1)])
        with(instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom)-8,Drip)) sprite_index=sprCheeseDrip
}
function scrNTTEFullPizzaSpiralSetup() {
    // Original NTT's types are1-based: Normal1/Proto2/IDPD3/Venuz4.
    // Original Create009cc1d6 and Step009cf4b1/009d0527 establish that the
    // MOD's `4 // Void` is the star branch represented by Epsilon's Venuz3.
    type=SpiralType.Venuz; instance_destroy(Spiral)
    repeat(round(30/timescale)) {
        event_perform(ev_step,ev_step_normal)
        with(Spiral) event_perform(ev_step,ev_step_normal)
        with(SpiralStar) event_perform(ev_step,ev_step_normal)
    }
    with(SpiralStar) if(random(30)<1) {
        sprite_index=sprSlice; image_index=0; image_xscale*=2/3; image_yscale*=2/3; image_angle=random(360)
        repeat(round(irandom(10)/timescale)) event_perform(ev_step,ev_step_normal)
    }
    with(instance_create(x,y,SpiralDebris)) {
        sprite_index=scrNTTERefSprite("Manhole"); image_index=5; turnspeed*=2/3
        repeat(round(irandom_range(8,12)/timescale)) event_perform(ev_step,ev_step_normal)
    }
}
