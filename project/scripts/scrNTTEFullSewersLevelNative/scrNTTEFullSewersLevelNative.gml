// ntte.level_start859..981: source ordinary Sewers variants, separate from
// the custom sewer event builders and their independent Crime Crown gates.
function scrNTTEFullSewersPropGuardCreate() {visible=false;ntte_guard_target=noone;ntte_guard_size=1}
function scrNTTEFullSewersPropGuardStep() {
    if(lockstep_stop) return;
    if(!instance_exists(ntte_guard_target)) {instance_destroy();return;}
    if(scrNTTEFullPortalPointSeen(ntte_guard_target.x,ntte_guard_target.y,-1)) {
        if(ntte_guard_target.size==4) ntte_guard_target.size=ntte_guard_size
        instance_destroy()
    }
}
function scrNTTEFullSewersPropShield(_prop) {
    var _size=_prop.size
    _prop.size=4
    if(scrNTTEFullPortalPointSeen(_prop.x,_prop.y,-1)) {_prop.size=_size;return;}
    var _guard=instance_create(0,0,NTTEFullSewersPropGuard)
    _guard.ntte_guard_target=_prop;_guard.ntte_guard_size=_size
}
function scrNTTEFullSewersFrogNest(_queen) {
    var _minimum=-1
    with(all) _minimum=max(_minimum,real(id))
    var _pool=instance_create(_queen.x,_queen.y,NTTEFullSludgePool)
    _pool.sprite_index=scrNTTERefSprite("msk.SewerPoolBig");_pool.spr_floor=scrNTTERefSprite("SewerPoolBig")
    with(_pool) event_perform(ev_step,ev_step_normal)
    var _floors=[]
    with(Floor) if(real(id)>_minimum) array_push(_floors,id)
    for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
        var _nw=!place_meeting(x-32,y,Floor) && !place_meeting(x,y-32,Floor),
            _ne=!place_meeting(x+32,y,Floor) && !place_meeting(x,y-32,Floor),
            _sw=!place_meeting(x-32,y,Floor) && !place_meeting(x,y+32,Floor),
            _se=!place_meeting(x+32,y,Floor) && !place_meeting(x,y+32,Floor)
        if(_nw || _ne || _sw || _se) {
            if(random(5)<1) {
                var _prop=instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,choose(Pipe,ToxicBarrel))
                scrNTTEFullSewersPropShield(_prop)
            }
            else {
                if(_nw) instance_create(x,y,Wall)
                if(_ne) instance_create(x+16,y,Wall)
                if(_sw) instance_create(x,y+16,Wall)
                if(_se) instance_create(x+16,y+16,Wall)
            }
        }
    }
    // Source egg placement is commented out; do not spawn extra FrogEggs.
    return _pool
}
function scrNTTEFullSewersLevelStart() {
    if(GameCont.area!=area_sewers) return;
    // This switch branch has no _normalArea gate in the original level_start.
    // Cats are emitted before the pool's new ToxicBarrels are constructed.
    with(ToxicBarrel) repeat(irandom_range(2,3)) instance_create(x,y,NTTECat)
    // Source with(FrogQueen) / break order is runner enumeration order, which
    // is not guaranteed to match instance_find(FrogQueen,0).
    // BEGIN NTTE SEWER PIZZA READONLY NEST
    with(FrogQueen) {
        if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrNTTEFullSewerPizzaEntryNestLog("before source FrogNest");
        scrNTTEFullSewersFrogNest(id);
        if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrNTTEFullSewerPizzaEntryNestLog("after source FrogNest");
        break
    }
    // END NTTE SEWER PIZZA READONLY NEST
    if(GameCont.loops>0) with(Ratking) {
        // Consume chance first even on an always-eligible styleB tile.
        var _replace=random(3)<1
        if(!_replace) with(Floor) if(styleb && position_meeting(other.x,other.y,id)) {_replace=true;break}
        if(_replace) {
            instance_create(x,y,NTTEFullTrafficCrab);instance_destroy(id,false)
        }
    }
}
