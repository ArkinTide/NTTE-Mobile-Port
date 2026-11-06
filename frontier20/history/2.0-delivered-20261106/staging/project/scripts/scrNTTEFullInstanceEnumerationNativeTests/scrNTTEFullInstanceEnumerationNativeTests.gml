// Independent literal preoptimization oracle, including recursive old calls.
function scrNTTEFullInstanceEnumerationOld(_object,_normal=false) {
    var _out=[]
    if (is_array(_object)) {
        for(var _i=0;_i<array_length(_object);++_i) {
            var _part=scrNTTEFullInstanceEnumerationOld(_object[_i],_normal)
            for(var _j=0;_j<array_length(_part);++_j) if (array_get_index(_out,_part[_j])<0) array_push(_out,_part[_j])
        }
    }
    else if (object_exists(_object) || _object==all) {
        var _n=instance_number(_object)
        for(var _i=0;_i<_n;++_i) {
            var _v=instance_find(_object,_i)
            if (instance_exists(_v) && (!_normal || _v.object_index==Floor)) array_push(_out,_v)
        }
    }
    else if (instance_exists(_object) && (!_normal || _object.object_index==Floor)) array_push(_out,_object)
    return _out
}

// TEST-ONLY iteration candidate. Production keeps its existing enumeration
// until ordered identity and mutation/lifetime cases pass in the real Runner.
// This measures whether repeated native instance_find scans explain slow
// generated maps; no speedup is assumed from the source change alone.
function scrNTTEFullInstanceEnumerationWithCandidate(_object,_normal=false) {
    var _out=[]
    if(is_array(_object)) {
        for(var _i=0;_i<array_length(_object);++_i) {
            var _part=scrNTTEFullInstanceEnumerationWithCandidate(_object[_i],_normal)
            if(_i==0) _out=_part
            else for(var _j=0;_j<array_length(_part);++_j)
                if(array_get_index(_out,_part[_j])<0) array_push(_out,_part[_j])
        }
    }
    else if(object_exists(_object) || _object==all) {
        var _n=instance_number(_object)
        for(var _i=0;_i<_n;++_i) {
            var _v=instance_find(_object,_i)
            if(instance_exists(_v) && (!_normal || _v.object_index==Floor)) array_push(_out,_v)
        }
    }
    else if(instance_exists(_object) && (!_normal || _object.object_index==Floor)) array_push(_out,_object)
    return _out
}

function scrNTTEFullInstanceEnumerationCheck(_input,_normal,_label) {
    var _inputBytes=json_stringify(_input),_rng=random_get_seed(),
        _nativeRng=json_stringify(global.rng_state),_count=instance_number(all),_started=get_timer()
    scrNTTESmokeLog("INSTANCE ENUMERATION CASE BEGIN "+json_stringify({label:_label,normal:_normal,
        all:_count,tops:instance_number(TopSmall),floors:instance_number(Floor),walls:instance_number(Wall)}))
    var _oldStarted=get_timer(),_expected=scrNTTEFullInstanceEnumerationOld(_input,_normal),_oldFinished=get_timer(),
        _actual=scrNTTEFullInstances(_input,_normal),_newFinished=get_timer()
    assert(array_length(_actual)==array_length(_expected),"Enumeration count diverged: "+_label)
    for(var _i=0;_i<array_length(_expected);++_i)
        assert(_actual[_i]==_expected[_i] && typeof(_actual[_i])==typeof(_expected[_i]),
            "Enumeration ordered ID/type diverged: "+_label+"/"+string(_i))
    var _candidateStarted=get_timer(),_candidate=scrNTTEFullInstanceEnumerationWithCandidate(_input,_normal),
        _candidateFinished=get_timer()
    assert(array_length(_candidate)==array_length(_expected),"Test-only with candidate count diverged: "+_label)
    for(var _i=0;_i<array_length(_expected);++_i)
        assert(_candidate[_i]==_expected[_i] && typeof(_candidate[_i])==typeof(_expected[_i]),
            "Test-only with candidate ordered ID/type diverged: "+_label+"/"+string(_i))
    assert(json_stringify(_input)==_inputBytes && random_get_seed()==_rng
        && json_stringify(global.rng_state)==_nativeRng && instance_number(all)==_count,
        "Enumeration mutated input/RNG/native streams/instances: "+_label)
    // A returned collection must own its storage, even for a first nested
    // array of direct instance IDs. Mutating it must not edit caller arrays.
    if(array_length(_actual)) {
        _actual[@ 0]=noone
        assert(json_stringify(_input)==_inputBytes,"Enumeration output aliases caller input: "+_label)
        var _again=scrNTTEFullInstances(_input,_normal)
        for(var _i=0;_i<array_length(_expected);++_i)
            assert(_again[_i]==_expected[_i],"Enumeration output mutation contaminated subsequent call: "+_label)
    }
    if(array_length(_candidate)) {
        _candidate[@ 0]=noone
        assert(json_stringify(_input)==_inputBytes,"Test-only with output aliases caller input: "+_label)
        var _again=scrNTTEFullInstanceEnumerationWithCandidate(_input,_normal)
        for(var _i=0;_i<array_length(_expected);++_i)
            assert(_again[_i]==_expected[_i],"Test-only with output contaminated subsequent call: "+_label)
    }
    scrNTTESmokeLog("INSTANCE ENUMERATION CASE END "+json_stringify({label:_label,normal:_normal,
        oldMs:(_oldFinished-_oldStarted)/1000,newMs:(_newFinished-_oldFinished)/1000,
        testOnlyWithMs:(_candidateFinished-_candidateStarted)/1000,
        elapsedMs:(get_timer()-_started)/1000,returned:array_length(_expected),all:instance_number(all)}))
}

function scrNTTEFullInstanceEnumerationNativeTests() {
    var _seed=random_get_seed(),_area=GameCont.area,_created=[],_tops=[],_floors=[],_walls=[],_bones=[],
        _shineBefore=instance_exists(NTTEFullRedWallShine),_beforeCount=instance_number(all)
    scrNTTESmokeLog("INSTANCE ENUMERATION FIXTURE ENTRY "+json_stringify({rate:30/timescale,
        all:_beforeCount,tops:instance_number(TopSmall),floors:instance_number(Floor),walls:instance_number(Wall),
        enemies:instance_number(enemy),players:instance_number(Player),shine:_shineBefore}))
    try {
        // Real constructor families at an isolated location. No custom
        // instance factory, parent reassignment, or global test callback.
        GameCont.area=area_desert
        for(var _i=0;_i<1536;++_i) {
            var _v=instance_create(260000+(_i mod 48)*16,260000+(_i div 48)*16,TopSmall)
            array_push(_created,_v);array_push(_tops,_v)
        }
        for(var _i=0;_i<16;++_i) {
            var _v=instance_create(264000+_i*32,260000,Floor)
            array_push(_created,_v);array_push(_floors,_v)
            _v=instance_create(264000+_i*16,264000,Wall)
            array_push(_created,_v);array_push(_walls,_v)
            _v=instance_create(264000+_i*16,268000,Bones)
            array_push(_created,_v);array_push(_bones,_v)
        }
        assert(array_length(_tops)==1536 && instance_exists(_tops[1535]) && instance_exists(_floors[0])
            && instance_exists(_walls[0]) && instance_exists(_bones[0]),"Enumeration fixture native constructors did not survive")
        var _p=instance_find(Player,0),_numericTop=real(_tops[0]),_numericFloor=real(_floors[0]),_numericPlayer=real(_p)
        assert(instance_exists(_p) && instance_is(_p,hitme),"Enumeration parent-child fixture requires a real Player in hitme")
        assert(instance_exists(_numericTop) && instance_exists(_numericFloor) && instance_exists(_numericPlayer),
            "Enumeration mixed-handle fixture requires valid numeric instance IDs")
        scrNTTESmokeLog("INSTANCE ENUMERATION MIXED HANDLES "+json_stringify({typed:_tops[0],numeric:_numericTop,
            typedType:typeof(_tops[0]),numericType:typeof(_numericTop),
            typedFindNumeric:array_get_index([_tops[0]],_numericTop),numericFindTyped:array_get_index([_numericTop],_tops[0])}))
        var _cases=[
            TopSmall,Floor,Wall,all,_tops[0],_floors[0],_p,noone,[],[[]],
            _numericTop,_numericFloor,_numericPlayer,999999999,
            [_numericTop,_tops[0],TopSmall],[_tops[0],_numericTop,TopSmall],
            [TopSmall,_numericTop,_tops[0]],[[_numericTop],[_tops[0],_numericTop],TopSmall],
            [_numericFloor,_floors[0],Floor],[_floors[0],_numericFloor,Floor],
            [[_numericPlayer,Player],[_p,hitme,_numericPlayer]],
            [TopSmall,TopPot,Bones],[Wall,InvisiWall],[TopSmall,TopSmall,Bones],
            [hitme,Player],[Player,hitme,Player],[all,TopSmall,Floor,all],
            [[],TopSmall,Bones],[[[]],TopSmall],
            [[_tops[0],_tops[1],_tops[0]],[_tops[1],_tops[2]],_tops[0]],
            [[TopSmall,[Bones,TopSmall]],[],[Floor,_floors[0],Floor],noone],
            [_floors[0],_tops[0],Floor,all],[[noone],[],[_p,hitme,Player]]]
        for(var _normal=0;_normal<2;++_normal)
            for(var _i=0;_i<array_length(_cases);++_i)
                scrNTTEFullInstanceEnumerationCheck(_cases[_i],_normal==1,string(_i)+"/normal"+string(_normal))
        // Standalone direct-instance input arrays remain reusable after the
        // result is mutated; constructors consume RNG before these checks.
        scrNTTEFullInstanceEnumerationCheck(_tops,false,"large direct instance array")
        scrNTTEFullInstanceEnumerationCheck([_tops,_bones,_floors,_walls],false,"large nested direct instance arrays")
        // Actual native removal/reinsertion changes iteration chains. Preserve
        // the independent old oracle after every operation rather than sorting
        // IDs or accepting an unordered set with the same members.
        var _gone=_tops[17],_topsBefore=instance_number(TopSmall),_allBefore=instance_number(all)
        instance_destroy(_gone,false)
        assert(!instance_exists(_gone) && instance_number(TopSmall)==_topsBefore-1
            && instance_number(all)==_allBefore-1,"Native destruction did not remove exactly the selected iteration entry")
        for(var _i=0;_i<array_length(_created);++_i) if(_created[_i]==_gone) _created[@ _i]=noone
        scrNTTEFullInstanceEnumerationCheck([TopSmall,Floor,all],false,"destroyed native iteration entry")
        scrNTTEFullInstanceEnumerationCheck(_gone,false,"direct destroyed handle")
        scrNTTEFullInstanceEnumerationCheck(real(_gone),false,"direct destroyed numeric handle")
        scrNTTEFullInstanceEnumerationCheck([_gone,TopSmall,_gone],false,"nested destroyed handles")
        scrNTTEFullInstanceEnumerationCheck([real(_gone),_gone,TopSmall],false,"mixed destroyed handles")
        scrNTTEFullInstanceEnumerationCheck([_gone,TopSmall,_gone],true,"normal filter destroyed handles")
        var _allBefore=instance_number(all),_inserted=instance_create(260000,259968,TopSmall)
        array_push(_created,_inserted)
        assert(instance_exists(_inserted) && instance_number(all)==_allBefore+1,
            "Native create-after-removal did not insert the tracked actor")
        scrNTTEFullInstanceEnumerationCheck([TopSmall,all],false,"new native actor after removed iteration entry")
        var _inactive=_tops[23],_topsBefore=instance_number(TopSmall),_allBefore=instance_number(all)
        instance_deactivate_object(_inactive)
        try {
            assert(!instance_exists(_inactive) && instance_number(TopSmall)==_topsBefore-1
                && instance_number(all)==_allBefore-1,"Native deactivation did not hide exactly the selected iteration entry")
            scrNTTEFullInstanceEnumerationCheck(TopSmall,false,"deactivated native iteration entry")
            scrNTTEFullInstanceEnumerationCheck(all,false,"all with deactivated entry")
            scrNTTEFullInstanceEnumerationCheck([_inactive,TopSmall],false,"direct inactive entry")
            scrNTTEFullInstanceEnumerationCheck([real(_inactive),_inactive,TopSmall],false,"mixed inactive handles")
        }
        finally {instance_activate_object(_inactive)}
        assert(instance_exists(_inactive) && instance_number(TopSmall)==_topsBefore
            && instance_number(all)==_allBefore,"Native reactivation failed or leaked an inactive actor")
        scrNTTEFullInstanceEnumerationCheck(TopSmall,false,"reactivated native iteration entry")
        scrNTTEFullInstanceEnumerationCheck([real(_inactive),_inactive,TopSmall],false,"mixed reactivated handles")
        with(_p) {
            var _scopeSelf=self,_scopeOther=other
            scrNTTEFullInstanceEnumerationCheck([Player,hitme,all],false,"nested native with caller context")
            assert(self==_scopeSelf && other==_scopeOther,"Enumeration candidate leaked nested with self/other context")
        }
        scrNTTESmokeLog("FULL INSTANCE ENUMERATION: independent literal old recursive oracle ordered IDs/types, object/parent-child/repeated/nested/empty/direct/noone/all/normalFloor,mixed numeric+typed handles both orders/destroyed/inactive/reactivated,1536 real TopSmall/input-output ownership/RNG/native streams unchanged OK @"+string(30/timescale))
    }
    finally {
        for(var _i=array_length(_created)-1;_i>=0;--_i)
            if(instance_exists(_created[_i])) instance_destroy(_created[_i],false)
        // Real terrain constructors ensure this controller if absent. Keep
        // an inherited controller and remove only one created by the fixture.
        if(!_shineBefore) instance_destroy(NTTEFullRedWallShine,false)
        GameCont.area=_area;random_set_seed(_seed)
        assert(instance_number(all)==_beforeCount,"Enumeration fixture leaked native instances")
    }
}

// Literal old rectangle query: the oracle never calls either new query helper.
function scrNTTEFullRectInstancesOld(_x1,_y1,_x2,_y2,_objects,_positions=false,_normal=false) {
    var _src=scrNTTEFullInstanceEnumerationOld(_objects,_normal),_out=[]
    for(var _i=0;_i<array_length(_src);++_i) {
        var _v=_src[_i]
        if(_positions ? (_v.x>=_x1 && _v.y>=_y1 && _v.x<=_x2 && _v.y<=_y2)
            : ((_v.bbox_right-1)>=_x1 && (_v.bbox_bottom-1)>=_y1 && _v.bbox_left<=_x2 && _v.bbox_top<=_y2)) array_push(_out,_v)
    }
    return _out
}
function scrNTTEFullRectInstancesOracleCheck(_rect,_objects,_positions,_normal,_label) {
    var _input=json_stringify(_objects),_seed=random_get_seed(),_native=json_stringify(global.rng_state),
        _count=instance_number(all),_start=get_timer(),
        _old=scrNTTEFullRectInstancesOld(_rect[0],_rect[1],_rect[2],_rect[3],_objects,_positions,_normal),
        _middle=get_timer(),
        _actual=scrNTTEFullRectInstances(_rect[0],_rect[1],_rect[2],_rect[3],_objects,_positions,_normal),_end=get_timer()
    assert(array_length(_old)==array_length(_actual),"Rect query count differs: "+_label)
    for(var _i=0;_i<array_length(_old);++_i)
        assert(_actual[_i]==_old[_i] && typeof(_actual[_i])==typeof(_old[_i]),
            "Rect query ordered ID/type differs: "+_label+"/"+string(_i))
    assert(json_stringify(_objects)==_input && random_get_seed()==_seed
        && json_stringify(global.rng_state)==_native && instance_number(all)==_count,
        "Rect query mutated input/RNG/instances: "+_label)
    if(array_length(_actual)) {
        _actual[@ 0]=noone
        assert(json_stringify(_objects)==_input,"Rect query output aliases caller input: "+_label)
    }
    return {oldMs:(_middle-_start)/1000,newMs:(_end-_middle)/1000,hits:array_length(_old)}
}
function scrNTTEFullQueryFixtureCleanup(_before) {
    var _keep={}
    for(var _i=0;_i<array_length(_before);++_i) _keep[$ string(real(_before[_i]))]=true
    with(all) if(!variable_struct_exists(_keep,string(real(id)))) instance_destroy(id,false)
}
function scrNTTEFullRectInstancesNativeTests() {
    var _before=scrNTTEFullInstanceEnumerationOld(all),_seed=random_get_seed(),_area=GameCont.area,
        _native=[];array_copy(_native,0,global.rng_state,0,array_length(global.rng_state))
    try {
        GameCont.area=area_desert
        var _tops=[]
        for(var _i=0;_i<24;++_i) array_push(_tops,instance_create(300000+(_i mod 8)*16,300000+(_i div 8)*16,TopSmall))
        var _floor=instance_create(304000,304000,Floor),_explo=instance_create(304064,304000,FloorExplo),
            _blank=instance_create(307000.25,307000.75,NTTEFullWorldFinalize),_player=instance_find(Player,0)
        assert(instance_exists(_blank) && _blank.sprite_index<0 && _blank.mask_index<0,
            "Rect no-sprite fixture unexpectedly has a collision sprite")
        _tops[2].image_xscale=-1.5;_tops[2].image_yscale=0.75;_tops[2].image_angle=13
        var _inputs=[TopSmall,Floor,[Floor,FloorExplo],hitme,[hitme,Player],
            [real(_floor),_floor,Floor],[Floor,_floor,real(_floor)],
            [[_tops[0],TopSmall],[_tops[0],noone]],_blank,real(_blank),[[_blank],[]],all],
            _rects=[[500000,500000,500001,500001],[299000,299000,308000,308000],
                [_floor.bbox_left,_floor.bbox_top,_floor.bbox_left,_floor.bbox_top],
                [_floor.bbox_right-1,_floor.bbox_bottom-1,_floor.bbox_right-1,_floor.bbox_bottom-1],
                [_floor.bbox_right,_floor.bbox_bottom,_floor.bbox_right,_floor.bbox_bottom],
                [_blank.x,_blank.y,_blank.x,_blank.y],
                [304031.5,303999.5,304032.5,304000.5],[304032,304032,303999,303999]],
            _emptyOld=0,_emptyNew=0,_hitOld=0,_hitNew=0,_emptyQueries=0,_hitQueries=0
        for(var _normal=0;_normal<2;++_normal) for(var _positions=0;_positions<2;++_positions)
            for(var _i=0;_i<array_length(_inputs);++_i) for(var _j=0;_j<array_length(_rects);++_j) {
                var _sample=scrNTTEFullRectInstancesOracleCheck(_rects[_j],_inputs[_i],_positions==1,_normal==1,
                    string([_normal,_positions,_i,_j]))
                if(_sample.hits) {_hitOld+=_sample.oldMs;_hitNew+=_sample.newMs;_hitQueries++}
                else {_emptyOld+=_sample.oldMs;_emptyNew+=_sample.newMs;_emptyQueries++}
            }
        var _inactive=_tops[3]
        instance_deactivate_object(_inactive)
        try {
            scrNTTEFullRectInstancesOracleCheck(_rects[1],[TopSmall,real(_inactive),_inactive],false,false,"inactive mixed handles")
            scrNTTEFullRectInstancesOracleCheck(_rects[1],all,false,false,"inactive all")
        }
        finally {instance_activate_object(_inactive)}
        scrNTTEFullRectInstancesOracleCheck(_rects[1],[TopSmall,real(_inactive),_inactive],false,false,"reactivated mixed handles")
        instance_destroy(_inactive,false)
        scrNTTEFullRectInstancesOracleCheck(_rects[1],[real(_inactive),_inactive,TopSmall],false,false,"destroyed mixed handles")
        with(_player) {
            var _self=self,_other=other
            scrNTTEFullRectInstancesOracleCheck([x-1,y-1,x+1,y+1],[Player,hitme,all],true,false,"nested caller scope")
            assert(self==_self && other==_other,"Rect existential query leaked self/other scope")
        }
        scrNTTESmokeLog("RECT MIXED QUERY CPU "+json_stringify({emptyQueries:_emptyQueries,hitQueries:_hitQueries,
            emptyOldMs:_emptyOld,emptyNewMs:_emptyNew,hitOldMs:_hitOld,hitNewMs:_hitNew,
            device_timing:false,rate:30/timescale}))
        // A large, genuinely empty spatial query exercises the intended fast
        // rejection. A nearby hit still uses the unchanged ordered old path.
        for(var _i=24;_i<1536;++_i) array_push(_tops,instance_create(300000+(_i mod 48)*16,300000+(_i div 48)*16,TopSmall))
        var _largeEmpty=scrNTTEFullRectInstancesOracleCheck(_rects[0],TopSmall,false,false,"1535 tops empty"),
            _largeHit=scrNTTEFullRectInstancesOracleCheck([299999,299999,300016,300016],TopSmall,false,false,"1535 tops nonempty")
        scrNTTESmokeLog("RECT LARGE QUERY CPU "+json_stringify({empty:_largeEmpty,nonempty:_largeHit,rate:30/timescale}))
        scrNTTESmokeLog("PASS RECT exact independent old oracle arrays/parent-child/normal/direct numeric+typed/no-sprite position+bbox/fractional+edge+reversed rectangles/inactive+reactivated+destroyed/ordered IDs+types/input+RNG unchanged @"+string(30/timescale))
    }
    finally {
        scrNTTEFullQueryFixtureCleanup(_before)
        GameCont.area=_area;global.rng_state=_native;random_set_seed(_seed)
    }
}

// Literal pre-cache room builder. Common FloorFill still invokes the same real constructors.
function scrNTTEFullFloorRoomCreateOld(_x,_y,_w,_h,_type,_dir_start,_dir_off,_floor_dis) {
    var _move=true,_distance=16,_ow=_w*16,_oh=_h*16,_sx=_x,_sy=_y
    if (!is_array(_dir_off)) _dir_off=[_dir_off]
    while (array_length(_dir_off)<2) array_push(_dir_off,0)
    while (_move) {
        var _x1=_x-_ow,_y1=_y-_oh,_x2=_x+_ow,_y2=_y+_oh
        var _fs=scrNTTEFullRectInstancesOld(_x1-_floor_dis,_y1-_floor_dis,_x2+_floor_dis-1,_y2+_floor_dis-1,Floor,false,true)
        if (_type=="round" && _floor_dis<=0) {
            for(var _i=array_length(_fs)-1;_i>=0;--_i) {
                var _f=_fs[_i]
                if (((_f.bbox_right-1)<_x1+32 || _f.bbox_left>=_x2-32) && ((_f.bbox_bottom-1)<_y1+32 || _f.bbox_top>=_y2-32)) array_delete(_fs,_i,1)
            }
        }
        _move=false
        if (array_length(_fs)) {
            if (_floor_dis<=0) _move=true
            else for(var _i=0;_i<array_length(_fs);++_i) {
                var _f=_fs[_i],_fx=clamp(_x,_f.bbox_left,(_f.bbox_right-1)+1),_fy=clamp(_y,_f.bbox_top,(_f.bbox_bottom-1)+1)
                var _fd=_type=="round"
                    ? min(point_distance(_fx,_fy,clamp(_fx,_x1+32,_x2-32),clamp(_fy,_y1,_y2)),point_distance(_fx,_fy,clamp(_fx,_x1,_x2),clamp(_fy,_y1+32,_y2-32)))
                    : point_distance(_fx,_fy,clamp(_fx,_x1,_x2),clamp(_fy,_y1,_y2))
                if (_fd<_floor_dis) { _move=true; break }
            }
            if (_move) {
                var _d=round((_dir_start+random_range(_dir_off[0],_dir_off[1])*choose(-1,1))/90)*90
                _x+=round(lengthdir_x(_distance,_d)); _y+=round(lengthdir_y(_distance,_d))
            }
        }
    }
    var _before=array_length(scrNTTEFullInstanceEnumerationOld(Floor,true)),_floors=scrNTTEFullFloorFill(_x,_y,_w,_h,_type),_after=array_length(scrNTTEFullInstanceEnumerationOld(Floor,true))
    var _x1=_x,_y1=_y,_x2=_x,_y2=_y
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i]
        if (!instance_exists(_f)) continue
        var _fx1=_f.bbox_left,_fy1=_f.bbox_top,_fx2=(_f.bbox_right-1),_fy2=(_f.bbox_bottom-1)
        if (_i==0) { _x1=_fx1; _y1=_fy1; _x2=_fx2+1; _y2=_fy2+1 }
        _x1=min(_x1,_fx1); _y1=min(_y1,_fy1); _x2=max(_x2,_fx2+1); _y2=max(_y2,_fy2+1)
        if (_floor_dis<=0 && _after==_before+array_length(_floors)) {
            var _walls=scrNTTEFullRectInstancesOld(_fx1-1,_fy1,_fx2+1,_fy2,Wall)
            var _vertical=scrNTTEFullRectInstancesOld(_fx1,_fy1-1,_fx2,_fy2+1,Wall)
            _walls=array_concat(_walls,_vertical)
            for(var _j=0;_j<array_length(_walls);++_j) if (instance_exists(_walls[_j])) with (_walls[_j]) {
                if (place_meeting(x,y,Floor)) {
                    var _decor=scrNTTEFullRectInstancesOld(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1),[Bones,TopPot])
                    for(var _k=0;_k<array_length(_decor);++_k) with (_decor[_k]) if (place_meeting(x,y,other.id)) instance_destroy(id,false)
                    instance_destroy(id,false)
                }
            }
        }
    }
    return {floors:_floors,x:(_x1+_x2)/2,y:(_y1+_y2)/2,x1:_x1,y1:_y1,x2:_x2,y2:_y2,xstart:_sx,ystart:_sy}
}

function scrNTTEFullFloorRoomFixtureFingerprint(_room,_before,_marker) {
    var _keep={},_stream=[],_floors=[]
    for(var _i=0;_i<array_length(_before);++_i) _keep[$ string(real(_before[_i]))]=true
    for(var _i=0;_i<array_length(_room.floors);++_i) {
        var _v=_room.floors[_i]
        array_push(_floors,[typeof(_v),real(_v)-real(_marker),_v.object_index,_v.x,_v.y,_v.depth,
            _v.sprite_index,_v.image_index,_v.image_speed,_v.styleb,_v.material,_v.traction])
    }
    var _all=scrNTTEFullInstanceEnumerationOld(all)
    for(var _i=0;_i<array_length(_all);++_i) {
        var _v=_all[_i]
        if(variable_struct_exists(_keep,string(real(_v)))) continue;
        array_push(_stream,[typeof(_v),real(_v)-real(_marker),_v.object_index,_v.x,_v.y,_v.depth,
            _v.sprite_index,_v.image_index,_v.image_speed,_v.image_xscale,_v.image_yscale,_v.image_angle,
            _v.visible,_v.mask_index])
    }
    return {room:[_room.x,_room.y,_room.x1,_room.y1,_room.x2,_room.y2,_room.xstart,_room.ystart],
        floors:_floors,orderedCreatedInstances:_stream,rng:random_get_seed(),nativeRng:json_stringify(global.rng_state)}
}
function scrNTTEFullFloorRoomCacheNativeTests() {
    var _before=scrNTTEFullInstanceEnumerationOld(all),_seed=random_get_seed(),_area=GameCont.area,
        _native=[];array_copy(_native,0,global.rng_state,0,array_length(global.rng_state))
    scrNTTEFullFloorInit()
    var _style=global.ntte_full_floor_style,_floorArea=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    try {
        GameCont.area=area_desert;scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32)
        // Real static terrain forces repeated placement retries; no generation
        // event can run during this synchronous function. Keep each room away
        // from the starter's mask, so both trials share identical old terrain.
        for(var _y=-1;_y<=1;++_y) for(var _x=-1;_x<=1;++_x) instance_create(360000+_x*32,360000+_y*32,Floor)
        var _baseline=scrNTTEFullInstanceEnumerationOld(all),_baseFloors=scrNTTEFullInstanceEnumerationOld(Floor,true),
            _baseBytes=json_stringify(_baseFloors),_seeds=[672491,672492,672493]
        for(var _case=0;_case<array_length(_seeds);++_case) {
            var _expected=undefined,_oldMs=0,_newMs=0
            for(var _pass=0;_pass<2;++_pass) {
                var _marker=instance_create(365000,365000,NTTEFullWorldFinalize),
                    _passBefore=scrNTTEFullInstanceEnumerationOld(all),_off=[0,30],_offBytes=json_stringify(_off),
                    _passNative=[];array_copy(_passNative,0,_native,0,array_length(_native))
                global.rng_state=_passNative;random_set_seed(_seeds[_case])
                var _start=get_timer(),_room
                if(_pass==0) _room=scrNTTEFullFloorRoomCreateOld(360016,360016,3,3,_case==1?"round":"",90,_off,32)
                else _room=scrNTTEFullFloorRoomCreate(360016,360016,3,3,_case==1?"round":"",90,_off,32)
                var _elapsed=(get_timer()-_start)/1000,
                    _record=scrNTTEFullFloorRoomFixtureFingerprint(_room,_passBefore,_marker)
                assert(is_struct(_room) && array_length(_room.floors)>0,"Room cache fixture did not create real terrain")
                assert(json_stringify(_off)==_offBytes && json_stringify(_baseFloors)==_baseBytes,
                    "Room cache builder mutated its direction input or baseline instance array")
                for(var _i=0;_i<array_length(_baseFloors);++_i)
                    assert(instance_exists(_baseFloors[_i]),"Room cache builder unexpectedly destroyed original separated terrain")
                if(_pass==0) {_expected=json_stringify(_record);_oldMs=_elapsed}
                else {
                    _newMs=_elapsed
                    assert(json_stringify(_record)==_expected,
                        "Room cache differs from literal old coordinates/ordered constructor stream/returned types/RNG: seed="+string(_seeds[_case]))
                }
                scrNTTEFullQueryFixtureCleanup(_baseline)
            }
            scrNTTESmokeLog("ROOM CACHE CPU "+json_stringify({seed:_seeds[_case],round:_case==1,
                oldMs:_oldMs,newMs:_newMs,rate:30/timescale,device_timing:false}))
        }
        scrNTTESmokeLog("PASS ROOM CACHE three fixed seeds real static-floor retries/literal old placement+FloorFill coordinates/ordered created ID offsets+types+visual fields/returned floor order/native RNG/direction+original input arrays unchanged @"+string(30/timescale))
    }
    finally {
        scrNTTEFullQueryFixtureCleanup(_before)
        scrNTTEFullFloorSetStyle(_style,_floorArea);scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
        GameCont.area=_area;global.rng_state=_native;random_set_seed(_seed)
    }
}


// BEGIN NTTE WALLDELETE ORDER ORACLE 20261023
function scrNTTEFullWallDeleteLiteralOld(_r) {
    var _walls=scrNTTEFullRectInstancesOld(_r[0],_r[1],_r[2],_r[3],[Wall,InvisiWall])
    for(var _i=0;_i<array_length(_walls);++_i) with(_walls[_i]) {
        var _wx=x,_wy=y
        with(TrapScorchMark) if(x==_wx && y==_wy) instance_destroy(id,false)
        instance_destroy(id,false)
    }
    var _tops=scrNTTEFullRectInstancesOld(_r[0],_r[1],_r[2],_r[3],[TopSmall,TopPot,Bones])
    for(var _i=0;_i<array_length(_tops);++_i) instance_destroy(_tops[_i],false)
}
function scrNTTEFullWallDeleteOracleRow(_v) {
    return [real(_v),typeof(_v),_v.object_index,_v.x,_v.y,_v.depth,_v.sprite_index,_v.mask_index,
        _v.image_index,_v.image_speed,_v.image_xscale,_v.image_yscale,_v.image_angle,
        _v.image_alpha,_v.visible,_v.solid,_v.persistent]
}
function scrNTTEFullWallDeleteOrderNativeTests() {
    var _before=scrNTTEFullInstanceEnumerationOld(all),_seed=random_get_seed(),_area=GameCont.area,
        _native=[];array_copy(_native,0,global.rng_state,0,array_length(global.rng_state))
    var _expectedHistory=undefined,_inactive=noone
    assert(instance_number(Player)==1,"WallDelete oracle requires one actual Player")
    try {
        for(var _mode=0;_mode<2;++_mode) {
            GameCont.area=area_desert;random_set_seed(672497)
            var _passRng=[];array_copy(_passRng,0,_native,0,array_length(_native));global.rng_state=_passRng
            var _created=[],_map={},_history=[],_objects=[TopSmall,NTTEFullTopTiny,TopPot,TopDecalScrapyard,Bones,Wall,InvisiWall,TrapScorchMark]
            for(var _i=0;_i<256;++_i) {
                var _v=instance_create(410000+((_i div 8) mod 8)*16,410000+(_i div 64)*16,_objects[_i mod 8])
                assert(instance_exists(_v),"WallDelete real fixture constructor self-destroyed")
                _map[$ string(real(_v))]=array_length(_created);array_push(_created,_v)
            }
            _created[9].image_xscale=-1.5;_created[9].image_yscale=0.75;_created[9].image_angle=13
            _inactive=_created[8];instance_deactivate_object(_inactive)
            assert(!instance_exists(_inactive),"WallDelete did not deactivate the real TopSmall")
            var _queries=[all,TopSmall,TopPot,Bones,Wall,InvisiWall,TrapScorchMark],
                _rects=[[500000,500000,500001,500001],[410000,410000,410000,410000],
                    [410016,410000,410047,410031],[410000,410016,410063,410063],
                    [410080,410000,410079,410031],[409900,409900,410300,410300]]
            for(var _step=0;_step<array_length(_rects);++_step) {
                if(_step==1) {instance_activate_object(_inactive);assert(instance_exists(_inactive),"WallDelete touched inactive actor");_inactive=noone;}
                if(_step==3) for(var _j=0;_j<2;++_j) {
                    var _v=instance_create(410032,410000,_objects[1+_j*2])
                    assert(instance_exists(_v),"WallDelete insert-after-delete actor self-destroyed")
                    _map[$ string(real(_v))]=array_length(_created);array_push(_created,_v)
                }
                var _r=_rects[_step],_walls=scrNTTEFullRectInstancesOld(_r[0],_r[1],_r[2],_r[3],[Wall,InvisiWall]),
                    _gone=scrNTTEFullRectInstancesOld(_r[0],_r[1],_r[2],_r[3],[TopSmall,TopPot,Bones]),
                    _scorch=scrNTTEFullInstanceEnumerationOld(TrapScorchMark),_expected=[]
                for(var _i=0;_i<array_length(_walls);++_i) {
                    var _w=_walls[_i];array_push(_gone,_w)
                    for(var _j=0;_j<array_length(_scorch);++_j)
                        if(_scorch[_j].x==_w.x && _scorch[_j].y==_w.y) array_push(_gone,_scorch[_j])
                }
                for(var _q=0;_q<array_length(_queries);++_q) {
                    var _items=scrNTTEFullInstanceEnumerationOld(_queries[_q]),_rows=[]
                    for(var _i=0;_i<array_length(_items);++_i)
                        if(array_get_index(_gone,_items[_i])<0) array_push(_rows,scrNTTEFullWallDeleteOracleRow(_items[_i]))
                    array_push(_expected,json_stringify(_rows))
                }
                var _rng=random_get_seed(),_nrng=json_stringify(global.rng_state),_start=get_timer()
                if(_mode==0) scrNTTEFullWallDeleteLiteralOld(_r)
                else with(Player) {
                    var _s=self,_o=other
                    scrNTTEFullWallDelete(_r[0],_r[1],_r[2],_r[3])
                    assert(self==_s && other==_o,"WallDelete leaked nested native with context")
                }
                var _elapsed=get_timer()-_start
                assert(random_get_seed()==_rng && json_stringify(global.rng_state)==_nrng,"WallDelete consumed RNG")
                for(var _q=0;_q<array_length(_queries);++_q) {
                    var _items=scrNTTEFullInstanceEnumerationOld(_queries[_q]),_rows=[]
                    for(var _i=0;_i<array_length(_items);++_i) array_push(_rows,scrNTTEFullWallDeleteOracleRow(_items[_i]))
                    assert(json_stringify(_rows)==_expected[_q],"WallDelete survivor ordered ID/type/fields differ mode/step/query="+string(_mode)+"/"+string(_step)+"/"+string(_q))
                }
                var _items=scrNTTEFullInstanceEnumerationOld(all),_stream=[]
                for(var _i=0;_i<array_length(_items);++_i) {
                    var _key=string(real(_items[_i]));if(!variable_struct_exists(_map,_key)) continue;
                    var _row=scrNTTEFullWallDeleteOracleRow(_items[_i]);_row[@ 0]=_map[$ _key];array_push(_stream,_row)
                }
                array_push(_history,[_step,_stream,_rng,_nrng])
                scrNTTESmokeLog("WALLDELETE ORDER CPU "+json_stringify({mode:_mode,step:_step,us:_elapsed,rate:30/timescale,device_timing:false}))
            }
            if(_mode==0) _expectedHistory=json_stringify(_history)
            else assert(json_stringify(_history)==_expectedHistory,"WallDelete old/candidate normalized constructor ordinal+ordered fields/RNG fingerprint differs")
            scrNTTEFullQueryFixtureCleanup(_before)
        }
        scrNTTESmokeLog("PASS WALLDELETE ORDER literal old/candidate real mixed parent-child constructors/overlap+empty+edge+inverted rectangles/inactive-reactivated/insert-after-delete/all+typed exact surviving ID+type+fields/order/RNG+ordinal fingerprint @"+string(30/timescale))
    }
    finally {
        if(_inactive!=noone) instance_activate_object(_inactive)
        scrNTTEFullQueryFixtureCleanup(_before);GameCont.area=_area;global.rng_state=_native;random_set_seed(_seed)
    }
}
// END NTTE WALLDELETE ORDER ORACLE 20261023
