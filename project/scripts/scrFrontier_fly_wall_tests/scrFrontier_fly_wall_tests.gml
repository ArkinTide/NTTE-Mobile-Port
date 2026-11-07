// Real native physics/End Step acceptance on isolated terrain at both rates.
function scrFRFlyWallTestsStart(_driver) {
    _driver.fr_fly_wall={round:-1,ticks:0,rows:[],flies:[],wrappers:[],anchors:[],
        before:scrNTTEFullInstances(all),area:GameCont.area,rate:UberCont.opt_framerate,
        seed:random_get_seed(),rates:[30,60],landed:[]};
    scrFRFlyWallTestsRound(_driver);
}
function scrFRFlyWallTestsRound(_driver) {
    var _s=_driver.fr_fly_wall;
    if(++_s.round>=array_length(_s.rates)) return;
    var _rate=_s.rates[_s.round];
    save_set_value("options","framerate",_rate);save_set_value("options","autopause",false);
    scrOptionsUpdate();scrNTTEFullRateApply();
    assert(game_get_speed(gamespeed_fps)==_rate,"Fly landing fixture did not apply the native requested rate");
    GameCont.area=area_desert;
    var _x=186000+_s.round*4000,_y=186000;
    for(var _ix=0;_ix<6;++_ix) for(var _iy=0;_iy<4;++_iy)
        instance_create(_x+_ix*32,_y+_iy*32,Floor);
    _s.wall_witnesses=[];
    for(var _ix=0;_ix<12;++_ix) array_push(_s.wall_witnesses,instance_create(_x+_ix*16,_y-16,Wall));
    _s.flies=[];_s.wrappers=[];_s.anchors=[];_s.landed=[];_s.ticks=0;
    for(var _i=0;_i<4;++_i) {
        random_set_seed(74510+_i);
        var _top=scrNTTEFullTopCreate(_x+240+_i*32,_y-240,JungleFly,0,16),_fly=_top.target;
        assert(instance_exists(_top) && instance_exists(_fly) && _top.fr_fly_wall_descent
            && !_top.canmove && _top.zfriction>0 && _fly.mask_index==mskNone,
            "Actual wall-top JungleFly did not enter its reachable low-gravity descent");
        var _contact=false;with(_top) _contact=place_meeting(x+mask_x,y+mask_y,Floor);
        assert(_contact,"Elevated JungleFly landing anchor has no real native floor contact");
        _fly.direction=_i*90;_fly.speed=4*timescale;
        array_push(_s.flies,_fly);array_push(_s.wrappers,_top);
        array_push(_s.anchors,[_top.x,_top.y]);array_push(_s.landed,false);
    }
    _s.ordinary=instance_create(_x+80,_y+80,JungleFly);
    assert((_s.ordinary[$ "ntte_full_top_object"]??noone)==noone,
        "Fly descent repair wrapped an ordinary flying map enemy");
    _s.ordinary_start=[_s.ordinary.x,_s.ordinary.y];
    var _barrel=scrNTTEFullTopCreate(_x+400,_y-240,Barrel,0,0);
    assert(!(_barrel[$ "fr_fly_wall_descent"]??false),"Fly descent repair changed an explicitly placed prop");
    scrNTTESmokeLog("NTUF FLY LANDING real native start rate="+string(_rate));
}
function scrFRFlyWallTestsStep(_driver) {
    var _s=_driver.fr_fly_wall;
    if(_s.round>=array_length(_s.rates)) return true;
    _s.ticks++;
    var _all=true;
    for(var _i=0;_i<array_length(_s.flies);++_i) {
        var _fly=_s.flies[_i],_top=_s.wrappers[_i];
        assert(instance_exists(_fly) && _fly.hp>0,"Wall-spawned JungleFly vanished instead of landing");
        if(instance_exists(_top)) {
            _all=false;
            assert(!_top.canmove && _top.zfriction>0
                && point_distance(_top.x,_top.y,_s.anchors[_i][0],_s.anchors[_i][1])<1,
                "Native JungleFly sideways flight carried its elevated anchor away from the landing");
        } else if(!_s.landed[_i]) {
            var _floor=false;with(_fly) _floor=place_meeting(x,y,Floor) && !place_meeting(x,y,Wall);
            assert(_floor && _fly.mask_index!=mskNone && _fly.spr_shadow!=-1
                && (_fly[$ "ntte_full_top_object"]??noone)==noone,
                "Actual JungleFly landing did not restore free floor, damage mask and shadow");
            _s.landed[_i]=true;
        }
    }
    assert(_s.ticks<180,"Wall-spawned JungleFly never completed its actual low-gravity landing");
    if(!_all || _s.ticks<40) return false;
    for(var _i=0;_i<array_length(_s.wall_witnesses);++_i)
        assert(instance_exists(_s.wall_witnesses[_i]),"Fly landing destroyed a wall instead of using its free floor destination");
    assert(instance_exists(_s.ordinary) && _s.ordinary.mask_index!=mskNone
        && (_s.ordinary[$ "ntte_full_top_object"]??noone)==noone,
        "Wall landing repair suppressed an ordinary native fly's free-flight collision");
    array_push(_s.rows,{rate:_s.rates[_s.round],real_source_ticks:_s.ticks,landed:array_length(_s.flies),
        ordinary_fly_alive:instance_exists(_s.ordinary),anchors:_s.anchors});
    scrNTTEFullMergedRuntimeTestCleanup(_s.before);
    scrFRFlyWallTestsRound(_driver);
    if(_s.round<array_length(_s.rates)) return false;
    GameCont.area=_s.area;random_set_seed(_s.seed);
    save_set_value("options","framerate",_s.rate);scrOptionsUpdate();scrNTTEFullRateApply();
    var _file=file_text_open_write(working_directory+"frontier-fly-wall-landing.json");
    file_text_write_string(_file,json_stringify({rows:_s.rows,physical_device_tested:false}));file_text_close(_file);
    scrNTTESmokeLog("PASS NTUF actual JungleFly wall-top landing/restored collision at30/60Hz "+json_stringify(_s.rows));
    return true;
}
