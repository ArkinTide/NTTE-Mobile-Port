// Frozen pre-candidate production oracles. Do not delegate to candidate helpers.
function scrNTTEPerfCoastWadingOld() {
    // Run after actual projectiles' Step events; BeginStep's real native floor
    // must remain alive until UltraBolt has performed its floor collision.
    var _fixes=scrNTTEFullValue(GameCont,"ntte_coast_ultrabolt_floors",[])
    for(var _i=0;_i<array_length(_fixes);++_i) if(instance_exists(_fixes[_i])) instance_destroy(_fixes[_i],false)
    GameCont.ntte_coast_ultrabolt_floors=[]
    if(!scrNTTEFullCoastActive()) return;
    var _pickups=scrNTTEFullCoastPickupInstances(),_objects=scrNTTEFullInstances([hitme,projectile,Corpse,ChestOpen,chestprop,Debris])
    for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_objects,_pickups[_i])<0) array_push(_objects,_pickups[_i])
    for(var _i=0;_i<array_length(_objects);++_i) with(_objects[_i]) scrNTTEFullCoastWadingSetup()
    // Push actual damageable units, pickups and chests back to the islands.
    if(instance_exists(Floor)) {
        var _push=scrNTTEFullInstances([hitme,chestprop])
        for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_push,_pickups[_i])<0) array_push(_push,_pickups[_i])
        for(var _i=0;_i<array_length(_push);++_i) with(_push[_i]) {
            var _is_pickup=scrNTTEFullIsPickup(id),_is_chest=instance_is(id,chestprop),_is_hit=instance_is(id,hitme),
                _eligible=(_is_hit && visible && wading>=80) || (_is_pickup && wading>=80) || (_is_chest && wading>=192)
            if(!_eligible) continue
            var _near=instance_nearest(x,y,Portal),_portal_ok=!instance_exists(_near),_ordinary=false
            with(Portal) if(endgame<100) _ordinary=true
            var _player=instance_is(id,Player)
            if(!_portal_ok) _portal_ok=distance_to_object(Portal)>96 && (!_player || _ordinary)
            if(!_portal_ok || (_is_hit && (team==team_none || instance_is(id,prop)))) continue
            var _floor=instance_nearest(x-16,y-16,Floor),_dir=point_direction(x,y,_floor.x,_floor.y),
                _accel=_player ? (3+(wading-80)/16)*timescale*timescale:friction*3
            motion_add(_dir,_accel)
            if(_player && wading>120) {
                var _finished=false
                with(Portal) if(endgame>=100) _finished=true
                if(!_finished) {
                    var _distance=(wading-120)/10*timescale
                    x+=lengthdir_x(_distance,_dir); y+=lengthdir_y(_distance,_dir)
                    if(random(2)<timescale) instance_create(x,y,Dust)
                }
            }
        }
    }
    var _sea=scrNTTEFullInstances([Debris,Corpse,ChestOpen,chestprop,WepPickup,CrownObject,Grenade,hitme,NTTEFullClamShield])
    for(var _i=0;_i<array_length(_pickups);++_i) if(_pickups[_i].mask_index==mskPickup && array_get_index(_sea,_pickups[_i])<0)
        array_push(_sea,_pickups[_i])
    var _swimming=[]
    for(var _i=0;_i<array_length(_sea);++_i) with(_sea[_i]) {
        scrNTTEFullCoastWadingSetup()
        if(depth>20 || !visible || !canwade) continue
        var _distance=distance_to_object(Floor),_logical_speed=speed/timescale
        if(_distance>4 && depth>=-5) {
            if(wading<=0) {
                y+=2
                if(distance_to_object(Floor)<=4) y-=2
                repeat(irandom_range(4,8)) instance_create(x,y,NTTEFullSweat)
                scrNTTEFullCoastSoundAt(x,y,choose(sndOasisChest,sndOasisMelee),1.5+random(0.5))
            }
            wading=_distance; visible=false
            if(random(20)<min(_logical_speed,4)) with(instance_create(x,y,Dust))
                motion_add(other.direction+orandom(10),3*timescale)
            if(wading_sink) {
                wading_sink+=0.3*timescale
                if(wading>30) y+=0.3*timescale
                if(wading_sink>=abs(sprite_height) && !persistent) { instance_destroy(); continue }
            }
            else if(wading>sprite_height) {
                wading_wave+=0.1*(timescale+_logical_speed)
                var _bob=min(wading/sprite_height,2)*cos(wading_wave)/10*timescale
                if(speed==0) y+=_bob
                else if(instance_is(id,hitme)) {
                    if(!instance_is(id,Player) || !scr_skill_get(mut_extra_feet)) {
                        var _length=_bob*(1+1.5*_logical_speed),_dir=direction-90
                        x+=lengthdir_x(_length,_dir); y+=lengthdir_y(_length,_dir)
                    }
                }
                else y+=_bob*(1+1.5*_logical_speed)
            }
            else if(wading_wave) wading_wave=0
        }
        else if(wading>0) {
            wading=0; wading_sink=0; y-=2
            if(distance_to_object(Floor)>4) y+=2
            repeat(irandom_range(5,9)) with(instance_create(x,y,NTTEFullSweat)) motion_set(other.direction,other.speed)
            scrNTTEFullCoastSoundAt(x,y,choose(sndOasisChest,sndOasisMelee),1+random(0.25))
            if(instance_is(id,Player)) scrNTTEFullFootprintGive(20,scrAreaGetBackroundColor(GameCont.area),0.5)
        }
        if(wading>0) array_push(_swimming,id)
    }
    GameCont.ntte_sea_inst=_swimming
    with(Corpse) if(scrNTTEFullValue(id,"wading",0)>30 && wading_sink==0 && speed==0 && image_speed==0 && size<3) wading_sink=1
    with(Player) if(scrNTTEFullValue(id,"wading",0)>0) {
        if(roll==0 && !scr_skill_get(mut_extra_feet)) friction=timescale*timescale
        var _nearest=instance_nearest(x,y,Portal)
        if(instance_exists(_nearest)) {
            if(_nearest.endgame>=100) {
                if(wading>120 || !instance_exists(Floor)) {
                    if(_nearest.type==1) { _nearest.x=x; _nearest.y=y; _nearest.xstart=x; _nearest.ystart=y }
                    else instance_create(x,y,Portal)
                }
            }
            else if(wading_sink>=0) wading_sink+=0.6*timescale
        }
    }
    with(Shell) if(!position_meeting(x,y,Floor)) y+=sin((x+y+current_frame)/10)*0.1*timescale
    with(Explosion) if(random(5)<timescale) {
        var _length=random_range(24,48),_dir=random(360)
        with(instance_create(x+lengthdir_x(_length,_dir),y+lengthdir_y(_length,_dir),RainSplash))
            if(place_meeting(x,y,Floor)) instance_destroy()
    }
    with(Portal) if(!visible && endgame<100 && !place_meeting(xstart,ystart,Floor)) {
        var _radius=5+image_index
        x=xstart+cos(current_frame)*_radius; y=ystart+sin(current_frame)*_radius
        if(current_frame_active) instance_create(x,y,choose(NTTEFullSweat,NTTEFullSweat,Bubble))
        if(!variable_instance_exists(id,"coast_portal_sound")) { coast_portal_sound=true; snd_play(sndOasisPortal) }
    }
}

function scrNTTEPerfRedWallShineOld() {
    if(lockstep_stop) return;
    var _count=instance_number(Wall),_first=instance_find(Wall,0)
    if(_count!=ntte_shine_wall_count || (instance_exists(_first) && ntte_shine_marker<real(_first))) {
        ntte_shine_reset=true;ntte_shine_wall_count=_count;ntte_shine_marker=-1
        // The original instance_max is a newly-created maximum instance ID.
        // Live maximum is equivalent for comparison with future wall IDs.
        with(all) other.ntte_shine_marker=max(other.ntte_shine_marker,real(id))
        ntte_shine_walls=[];ntte_shine_tops=[]
        var _top=scrNTTERefSprite("WallRedTop"),_trans=scrNTTERefSprite("WallRedTrans")
        with(Wall) if(topspr==_top || topspr==_trans) array_push(other.ntte_shine_walls,id)
        with(TopSmall) if(sprite_index==_top || sprite_index==_trans) array_push(other.ntte_shine_tops,id)
    }
    visible=array_length(ntte_shine_walls)>0 || array_length(ntte_shine_tops)>0
    if(visible && GameCont.area!=206 && scrNTTEFullSourceRandom(40)<timescale) scrNTTEFullRedEffect()
}

// Withdrawn Coast bucket prototype, retained ONLY for experiment evidence.
function scrNTTEPerfCoastAppendCandidate(_base,_incoming,_pickup_mask=false) {
    if(array_length(_incoming)==0) return _base;
    var _seen={},_out=_base;
    for(var _i=0;_i<array_length(_base);++_i) {
        var _v=_base[_i],_key=string(real(_v)),_bucket=[];
        if(variable_struct_exists(_seen,_key)) _bucket=_seen[$ _key];
        if(array_get_index(_bucket,_v)<0) array_push(_bucket,_v);
        _seen[$ _key]=_bucket;
    }
    for(var _i=0;_i<array_length(_incoming);++_i) {
        var _v=_incoming[_i];
        if(_pickup_mask && _v.mask_index!=mskPickup) continue;
        var _key=string(real(_v)),_bucket=[];
        if(variable_struct_exists(_seen,_key)) {
            _bucket=_seen[$ _key];
            if(array_get_index(_bucket,_v)>=0) continue;
        }
        array_push(_bucket,_v);_seen[$ _key]=_bucket;array_push(_out,_v);
    }
    return _out;
}

// DRAFT. Concatenate old-oracles.gml before this file into one registered
// script resource. The coordinator owns resource/harness registration.
// All timing below runs in the actual GML Runner, never a Python model.

function scrNTTEPerfCoastAppendOld(_base,_incoming,_pickup_mask=false) {
    var _out=_base;
    for(var _i=0;_i<array_length(_incoming);++_i) {
        if(_pickup_mask && _incoming[_i].mask_index!=mskPickup) continue;
        if(array_get_index(_out,_incoming[_i])<0) array_push(_out,_incoming[_i]);
    }
    return _out;
}
function scrNTTEPerfOrderedEqual(_a,_b,_label) {
    assert(array_length(_a)==array_length(_b),_label+": count mismatch");
    for(var _i=0;_i<array_length(_a);++_i)
        assert(_a[_i]==_b[_i] && typeof(_a[_i])==typeof(_b[_i]),_label+": ID/type/order mismatch at "+string(_i));
}
function scrNTTEPerfCoastAppendCheck(_base,_incoming,_mask,_label) {
    var _input=json_stringify([_base,_incoming]),_seed=random_get_seed(),
        _rng=json_stringify(global.rng_state),_source=json_stringify(scrNTTEFullSourceSeedState()),
        _count=instance_number(all),_oldInput=[],_newInput=[];
    // Modern arrays are shared. Give both literal old and candidate their
    // own working base, exactly as the caller creates three separate unions.
    array_copy(_oldInput,0,_base,0,array_length(_base));array_copy(_newInput,0,_base,0,array_length(_base));
    var _old=scrNTTEPerfCoastAppendOld(_oldInput,_incoming,_mask),
        _new=scrNTTEPerfCoastAppendCandidate(_newInput,_incoming,_mask);
    scrNTTEPerfOrderedEqual(_old,_new,_label);
    scrNTTEPerfOrderedEqual(_oldInput,_newInput,_label+" base mutation");
    assert(json_stringify([_base,_incoming])==_input && random_get_seed()==_seed
        && json_stringify(global.rng_state)==_rng && json_stringify(scrNTTEFullSourceSeedState())==_source
        && instance_number(all)==_count,_label+": append mutated caller/RNG/instances");
}
function scrNTTEPerfTimingSummary(_samples) {
    var _sorted=[];array_copy(_sorted,0,_samples,0,array_length(_samples));array_sort(_sorted,true);
    return {medianUs:_sorted[array_length(_sorted) div 2],p90Us:_sorted[floor((array_length(_sorted)-1)*0.9)],samplesUs:_samples};
}
function scrNTTEPerfCoastAppendTime(_base,_incoming,_mask,_label) {
    var _reps=32,_samples=9,_old=[],_new=[],_sink=0,
        _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_source=json_stringify(scrNTTEFullSourceSeedState());
    repeat(8) {
        var _oldInput=[],_newInput=[];
        array_copy(_oldInput,0,_base,0,array_length(_base));array_copy(_newInput,0,_base,0,array_length(_base));
        _sink+=array_length(scrNTTEPerfCoastAppendOld(_oldInput,_incoming,_mask));
        _sink+=array_length(scrNTTEPerfCoastAppendCandidate(_newInput,_incoming,_mask));
    }
    for(var _sample=0;_sample<_samples;++_sample) for(var _phase=0;_phase<2;++_phase) {
        var _candidate=((_sample+_phase) mod 2)==1,_total=0;
        repeat(_reps) {
            var _working=[];array_copy(_working,0,_base,0,array_length(_base));
            var _started=get_timer();
            if(_candidate) _sink+=array_length(scrNTTEPerfCoastAppendCandidate(_working,_incoming,_mask));
            else _sink+=array_length(scrNTTEPerfCoastAppendOld(_working,_incoming,_mask));
            _total+=get_timer()-_started;
        }
        var _elapsed=_total/_reps;
        if(_candidate) array_push(_new,_elapsed);else array_push(_old,_elapsed);
    }
    assert(random_get_seed()==_seed && json_stringify(global.rng_state)==_rng
        && json_stringify(scrNTTEFullSourceSeedState())==_source,"Coast timed membership consumed RNG");
    scrNTTESmokeLog("REGION PERFORMANCE COAST APPEND "+json_stringify({label:_label,rate:30/timescale,
        base:array_length(_base),incoming:array_length(_incoming),mask:_mask,old:scrNTTEPerfTimingSummary(_old),
        candidate:scrNTTEPerfTimingSummary(_new),sink:_sink}));
}

function scrNTTEFullCoastAppendPerformanceTests() {
    assert(scrNTTESmokeEnabled(),"Coast membership fixture is desktop-test-only");
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _source=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState()),_seed=random_get_seed(),_rng=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    try {
        GameCont.area=area_desert;
        var _basePool=[],_pickups=[];
        for(var _i=0;_i<1024;++_i) array_push(_basePool,instance_create(300000+_i*2,300000,NTTEDesertDecor));
        for(var _i=0;_i<512;++_i) {
            var _p=instance_create(300000+_i*2,300100,Rad);
            assert(instance_exists(_p),"Native Rad constructor did not survive fixture setup");
            _p.mask_index=(_i mod 3==0)?mskNone:mskPickup;array_push(_pickups,_p);
        }
        var _a=_pickups[0],_b=_pickups[1],_numeric=real(_a);
        scrNTTEPerfCoastAppendCheck([],[],false,"empty");
        scrNTTEPerfCoastAppendCheck([_a,_a],[_a,_b,_b],false,"base duplicates retained");
        scrNTTEPerfCoastAppendCheck([_a],[_numeric,_a,_numeric],false,"typed base / numeric incoming");
        scrNTTEPerfCoastAppendCheck([_numeric],[_a,_numeric,_a],false,"numeric base / typed incoming");
        scrNTTEPerfCoastAppendCheck([_a,_numeric],[_b,_a,_numeric],true,"mask before membership / aliases");
        var _sizes=[[0,0],[32,4],[128,16],[512,64],[1024,256],[1024,512]];
        for(var _s=0;_s<array_length(_sizes);++_s) for(var _overlap=0;_overlap<2;++_overlap) {
            var _base=[],_incoming=[],_n=_sizes[_s][0],_p=_sizes[_s][1];
            for(var _i=0;_i<_n;++_i) array_push(_base,_overlap && _i<(_p div 2)?_pickups[_i]:_basePool[_i]);
            for(var _i=0;_i<_p;++_i) array_push(_incoming,_pickups[_i]);
            var _label=string(_n)+"/"+string(_p)+" overlap="+string(_overlap);
            for(var _mask=0;_mask<2;++_mask) {
                scrNTTEPerfCoastAppendCheck(_base,_incoming,_mask==1,_label);
                scrNTTEPerfCoastAppendTime(_base,_incoming,_mask==1,_label);
            }
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);global.rng_state=_rng;
    }
    scrNTTESmokeLog("PASS Coast append native handles / numeric aliases / base duplicates / mask order / unchanged inputs / RNG; timings recorded");
}

function scrNTTEPerfCoastActorState(_actors) {
    var _out=[];
    for(var _i=0;_i<array_length(_actors);++_i) {
        var _v=_actors[_i];
        array_push(_out,{instance:_v,type:typeof(_v),x:_v.x,y:_v.y,speed:_v.speed,direction:_v.direction,
            hspeed:_v.hspeed,vspeed:_v.vspeed,friction:_v.friction,visible:_v.visible,mask:_v.mask_index,
            wading:_v.wading,wave:_v.wading_wave,sink:_v.wading_sink,canwade:_v.canwade});
    }
    return json_stringify({actors:_out,sea:scrNTTEFullValue(GameCont,"ntte_sea_inst",[]),
        source:scrNTTEFullSourceSeedState(),rng:global.rng_state,seed:random_get_seed()});
}
function scrNTTEFullCoastWadingPerformanceTests() {
    assert(scrNTTESmokeEnabled(),"Coast real-step fixture is desktop-test-only");
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState()),_rng=[],
        _park=scrNTTEFullInstances([hitme,projectile,Corpse,ChestOpen,chestprop,Debris,Floor,Wall,TopSmall,
            Rad,BigRad,HPPickup,AmmoPickup,RogueAmmo,WepPickup,NTTEFullCustomPickup,CrownObject,NTTEFullClamShield,
            Shell,Explosion,Portal,NTTEFullCoastSea]),_actors=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    for(var _i=0;_i<array_length(_park);++_i) instance_deactivate_object(_park[_i]);
    try {
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.lastarea=GameCont.area;GameCont.ntte_full_active_coast=true;
        GameCont.ntte_coast_ultrabolt_floors=[];GameCont.ntte_sea_inst=[];
        var _renderer=instance_create(0,0,NTTEFullCoastSea),_floor=instance_create(310000,310000,Floor);
        for(var _i=0;_i<16;++_i) {
            var _p=instance_create(_floor.bbox_right+48+(_i mod 4),_floor.bbox_top+8+(_i div 4),Rad);
            _p.mask_index=mskPickup;_p.visible=true;_p.speed=0;_p.depth=0;
            with(_p) scrNTTEFullCoastWadingSetup();
            _p.wading=10;_p.wading_wave=0;_p.wading_sink=0;array_push(_actors,_p);
            with(_p) assert(distance_to_object(Floor)>8,"Controlled native swimmer is too close to actual Floor mask");
        }
        var _gameScene=scrNTTEFullAreaGeneratorSnapshot(GameCont),_actorScene=scrNTTEFullAreaGeneratorSnapshot(_actors),
            _sceneSeed=random_get_seed(),_sceneRng=[],_count=instance_number(all);
        array_copy(_sceneRng,0,global.rng_state,0,array_length(global.rng_state));
        var _entitiesBefore=scrNTTEFullInstances(all);
        with(_renderer) scrNTTEPerfCoastWadingOld();
        var _expected=scrNTTEPerfCoastActorState(_actors);
        if(instance_number(all)!=_count) {
            var _added=[],_removed=[],_entitiesAfter=scrNTTEFullInstances(all);
            for(var _i=0;_i<array_length(_entitiesAfter);++_i) if(array_get_index(_entitiesBefore,_entitiesAfter[_i])<0)
                array_push(_added,{id:_entitiesAfter[_i],object:object_get_name(_entitiesAfter[_i].object_index)});
            for(var _i=0;_i<array_length(_entitiesBefore);++_i) if(array_get_index(_entitiesAfter,_entitiesBefore[_i])<0) array_push(_removed,_entitiesBefore[_i]);
            scrNTTESmokeLog("COAST CONTROLLED SCENE ENTITY DIFF "+json_stringify({before:_count,after:instance_number(all),added:_added,removed:_removed}));
        }
        assert(instance_number(all)==_count,"Controlled Coast oracle unexpectedly spawned/destroyed an effect");
        scrNTTEFullAreaGeneratorRestore(_gameScene);scrNTTEFullAreaGeneratorRestore(_actorScene);
        random_set_seed(_sceneSeed);global.rng_state=_sceneRng;
        with(_renderer) scrNTTEFullCoastWadingStep();
        assert(scrNTTEPerfCoastActorState(_actors)==_expected && instance_number(all)==_count,
            "Actual WadingStep differs from independent old oracle in water motion/visibility/order/RNG");
        var _oldTimes=[],_newTimes=[];
        for(var _sample=0;_sample<9;++_sample) for(var _phase=0;_phase<2;++_phase) {
            scrNTTEFullAreaGeneratorRestore(_gameScene);scrNTTEFullAreaGeneratorRestore(_actorScene);
            random_set_seed(_sceneSeed);global.rng_state=_sceneRng;
            var _candidate=((_sample+_phase) mod 2)==1,_started=get_timer();
            if(_candidate) with(_renderer) scrNTTEFullCoastWadingStep();
            else with(_renderer) scrNTTEPerfCoastWadingOld();
            var _elapsed=get_timer()-_started;
            if(_candidate) array_push(_newTimes,_elapsed);else array_push(_oldTimes,_elapsed);
            assert(scrNTTEPerfCoastActorState(_actors)==_expected,"Timed WadingStep state/RNG drifted from oracle");
        }
        scrNTTESmokeLog("REGION PERFORMANCE COAST STEP "+json_stringify({rate:30/timescale,pickups:16,
            old:scrNTTEPerfTimingSummary(_oldTimes),candidate:scrNTTEPerfTimingSummary(_newTimes)}));
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_park);++_i) instance_activate_object(_park[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_source_seed=_source;
        random_set_seed(_seed);global.rng_state=_rng;
    }
    scrNTTESmokeLog("PASS real Coast WadingStep against frozen old oracle: native swimmers/motion/visibility/sea order/RNG; whole-step timing recorded");
}

function scrNTTEPerfRedCacheCheck(_old,_new,_label) {
    _old.ntte_shine_reset=false;_new.ntte_shine_reset=false;
    var _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_source=json_stringify(scrNTTEFullSourceSeedState());
    with(_old) scrNTTEPerfRedWallShineOld();
    with(_new) scrNTTEFullRedWallShineEndStep();
    assert(_old.ntte_shine_reset==_new.ntte_shine_reset && _old.ntte_shine_wall_count==_new.ntte_shine_wall_count
        && _old.visible==_new.visible,_label+": Red cache invalidation/visibility diverged");
    scrNTTEPerfOrderedEqual(_old.ntte_shine_walls,_new.ntte_shine_walls,_label+" Wall");
    scrNTTEPerfOrderedEqual(_old.ntte_shine_tops,_new.ntte_shine_tops,_label+" TopSmall");
    assert(random_get_seed()==_seed && json_stringify(global.rng_state)==_rng
        && json_stringify(scrNTTEFullSourceSeedState())==_source,_label+": Red area206 cache consumed RNG");
}
function scrNTTEPerfRedCacheTime(_old,_new,_force,_label) {
    var _oldTimes=[],_newTimes=[],_reps=32;
    for(var _sample=0;_sample<9;++_sample) for(var _phase=0;_phase<2;++_phase) {
        var _candidate=((_sample+_phase) mod 2)==1,_started=get_timer();
        if(_candidate) repeat(_reps) with(_new) {
            if(_force) ntte_shine_wall_count=-1;
            scrNTTEFullRedWallShineEndStep();
        }
        else repeat(_reps) with(_old) {
            if(_force) ntte_shine_wall_count=-1;
            scrNTTEPerfRedWallShineOld();
        }
        var _elapsed=(get_timer()-_started)/_reps;
        if(_candidate) array_push(_newTimes,_elapsed);else array_push(_oldTimes,_elapsed);
    }
    scrNTTESmokeLog("REGION PERFORMANCE RED WALL "+json_stringify({label:_label,rate:30/timescale,
        all:instance_number(all),walls:instance_number(Wall),tops:instance_number(TopSmall),forceRebuild:_force,
        old:scrNTTEPerfTimingSummary(_oldTimes),candidate:scrNTTEPerfTimingSummary(_newTimes)}));
}
function scrNTTEFullRedWallScanPerformanceTests() {
    assert(scrNTTESmokeEnabled(),"Red real-instance fixture is desktop-test-only");
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _source=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState()),_rng=[],
        _park=scrNTTEFullInstances([Wall,TopSmall,Floor,NTTEFullRedWallShine,Menu,MenuGen]),_inactiveOwned=[];
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state));
    for(var _i=0;_i<array_length(_park);++_i) instance_deactivate_object(_park[_i]);
    try {
        GameCont.area=206;
        var _old=instance_create(0,0,NTTEFullRedWallShine),_new=instance_create(0,0,NTTEFullRedWallShine),
            _walls=[],_tops=[],_red=scrNTTERefSprite("WallRedTop");
        scrNTTEPerfRedCacheCheck(_old,_new,"empty");
        for(var _i=0;_i<64;++_i) {
            var _w=instance_create(320000+_i*32,320000,Wall);_w.topspr=_red;array_push(_walls,_w);
            var _t=instance_create(320000+_i*32,320064,TopSmall);_t.sprite_index=_red;array_push(_tops,_t);
        }
        var _maxWall=-1;with(Wall) _maxWall=max(_maxWall,real(id));
        assert(real(instance_find(Wall,instance_number(Wall)-1))==_maxWall,
            "Concrete Wall-only fixture did not expose newest Wall at native instance_find tail");
        scrNTTEPerfRedCacheCheck(_old,_new,"native Wall/TopSmall births");
        scrNTTEPerfRedCacheTime(_old,_new,true,"64 Walls / ordinary rebuild");
        scrNTTEPerfRedCacheTime(_old,_new,false,"64 Walls / stable cache");
        instance_destroy(_walls[0],false);
        var _replacement=instance_create(320000,320000,Wall);_replacement.topspr=_red;_walls[0]=_replacement;
        _old.ntte_shine_reset=false;_new.ntte_shine_reset=false;
        with(_old) scrNTTEPerfRedWallShineOld();with(_new) scrNTTEFullRedWallShineEndStep();
        scrNTTESmokeLog("REGION PERFORMANCE RED REPLACEMENT CORRECTION "+json_stringify({rate:30/timescale,
            oldReset:_old.ntte_shine_reset,candidateReset:_new.ntte_shine_reset,
            oldHasNew:array_get_index(_old.ntte_shine_walls,_replacement)>=0,
            candidateHasNew:array_get_index(_new.ntte_shine_walls,_replacement)>=0}));
        assert(array_get_index(_new.ntte_shine_walls,_replacement)>=0,
            "Red equal-count replacement did not invalidate after actual Wall constructor");
        _old.ntte_shine_wall_count=-1;_new.ntte_shine_wall_count=-1;
        scrNTTEPerfRedCacheCheck(_old,_new,"replacement forced-old source order/RNG");
        for(var _i=0;_i<4096;++_i) instance_create(330000+_i,330000,NTTEDesertDecor);
        scrNTTEPerfRedCacheCheck(_old,_new,"non-Wall burst must not invalidate");
        assert(!_new.ntte_shine_reset,"Unrelated entity births unexpectedly invalidated Wall cache");
        scrNTTEPerfRedCacheTime(_old,_new,true,"64 Walls / 4096 unrelated entities / rebuild");
        scrNTTEPerfRedCacheTime(_old,_new,false,"64 Walls / 4096 unrelated entities / stable");
        // Wall has a genuine derived class. Creation-dirty invalidation must
        // catch both kinds even if parent enumeration groups concrete types.
        var _fake=instance_create(325000,325000,NTTEFullWallFake);_fake.topspr=_red;array_push(_walls,_fake);
        var _plain=instance_create(325032,325000,Wall);_plain.topspr=_red;array_push(_walls,_plain);
        scrNTTEPerfRedCacheCheck(_old,_new,"mixed concrete Wall/WallFake births");
        var _maxWall=-1;with(Wall) _maxWall=max(_maxWall,real(id));
        scrNTTESmokeLog("REGION PERFORMANCE RED MIXED ENDPOINTS "+json_stringify({
            first:instance_find(Wall,0),last:instance_find(Wall,instance_number(Wall)-1),maximumId:_maxWall,
            tailIsMaximum:real(instance_find(Wall,instance_number(Wall)-1))==_maxWall,
            fakeCount:instance_number(NTTEFullWallFake)}));
        instance_destroy(_walls[3],false);
        var _mixedNew=instance_create(325064,325000,Wall);_mixedNew.topspr=_red;_walls[3]=_mixedNew;
        with(_new) scrNTTEFullRedWallShineEndStep();
        assert(array_get_index(_new.ntte_shine_walls,_mixedNew)>=0 && array_get_index(_new.ntte_shine_walls,_fake)>=0,
            "Grouped derived-Wall order concealed a new plain Wall during same-count replacement");
        _old.ntte_shine_wall_count=-1;_new.ntte_shine_wall_count=-1;
        scrNTTEPerfRedCacheCheck(_old,_new,"mixed replacement forced-old source order/RNG");
        _inactiveOwned=_walls;
        for(var _i=0;_i<array_length(_walls);++_i) instance_deactivate_object(_walls[_i]);
        scrNTTEPerfRedCacheCheck(_old,_new,"all Walls deactivated");
        for(var _i=0;_i<array_length(_walls);++_i) instance_activate_object(_walls[_i]);
        _inactiveOwned=[];
        scrNTTEPerfRedCacheCheck(_old,_new,"all Walls restored");
        // Explicit counterexample probe: same-count reactivation can refresh
        // max-Wall more eagerly than the literal max-all oracle. Report this
        // separately. The coordinator approved this as an intentional cache
        // correctness fix: the newly activated Wall must replace the old one.
        for(var _i=0;_i<array_length(_walls);++_i) instance_destroy(_walls[_i],false);
        var _one=instance_create(340000,340000,Wall);_one.topspr=_red;
        var _two=instance_create(340032,340000,Wall);_two.topspr=_red;
        instance_deactivate_object(_two);_inactiveOwned=[_two];
        instance_create(340064,340000,NTTEDesertDecor);
        _old.ntte_shine_wall_count=-1;_new.ntte_shine_wall_count=-1;
        scrNTTEPerfRedCacheCheck(_old,_new,"reactivation probe preparation");
        instance_deactivate_object(_one);instance_activate_object(_two);_inactiveOwned=[_one];
        _old.ntte_shine_reset=false;_new.ntte_shine_reset=false;
        with(_old) scrNTTEPerfRedWallShineOld();with(_new) scrNTTEFullRedWallShineEndStep();
        scrNTTESmokeLog("REGION PERFORMANCE RED REACTIVATION BOUNDARY "+json_stringify({rate:30/timescale,
            literalParity:_old.ntte_shine_reset==_new.ntte_shine_reset,oldReset:_old.ntte_shine_reset,
            candidateReset:_new.ntte_shine_reset,oldWalls:_old.ntte_shine_walls,candidateWalls:_new.ntte_shine_walls}));
        assert(array_get_index(_new.ntte_shine_walls,_two)>=0 && array_get_index(_new.ntte_shine_walls,_one)<0,
            "Red candidate failed actual same-count reactivation correctness");
        instance_activate_object(_one);_inactiveOwned=[];
    }
    finally {
        for(var _i=0;_i<array_length(_inactiveOwned);++_i) instance_activate_object(_inactiveOwned[_i]);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_park);++_i) instance_activate_object(_park[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_source_seed=_source;
        random_set_seed(_seed);global.rng_state=_rng;
    }
    scrNTTESmokeLog("PASS Red native birth/delete/burst/all-deactivate cache parity and candidate reactivation correctness; timings and literal-parity boundary recorded");
}
