// ntte1780..1850. Shared FreakChamber native lifecycle owns actual delayed
// excavation and part2 physical chest; this is the natural HQ acquisition setup.
function scrNTTEFullQuestHQAtMiddle(_middle) {
// BEGIN NTTE HQ STOLEN CONTINUE TEST HQ BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { if(instance_exists(_middle)) scrNTTEFullHQStolenContinueProviderBefore(_middle); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST HQ BEFORE
    if(!instance_exists(_middle)) return undefined
    var _side=choose(-1,1),_entry=instance_create(_middle.x,_middle.y+208,NTTEFullFreakChamber),
        _enemy=instance_create(_middle.x+208*_side,_middle.y,NTTEFullFreakChamber),
        _artifact=instance_create(_middle.x-208*_side,_middle.y,NTTEFullFreakChamber)
    _entry.object=Player;_entry.alarm0=1;_entry.open=true
    _enemy.enemies=1;_enemy.spawnmoment=-1
    _artifact.enemies=1;_artifact.spawnmoment=-1
    if(scrNTTEFullQuestArtifactAvailable(2)) {
        array_push(GameCont.ntte_quest_spawned_part_index_list,2);_artifact.object="QuestChest"
    }
    var _pots=scrNTTEFullInstances(TopPot)
    for(var _i=0;_i<array_length(_pots);++_i) {
        var _pot=_pots[_i]
        if((_pot.bbox_right-1>=_middle.x-32 && _pot.bbox_left<=_middle.x+32)
            || (_pot.bbox_bottom-1>=_middle.y-32 && _pot.bbox_top<=_middle.y+32)) instance_destroy(_pot,false)
    }
// BEGIN NTTE HQ STOLEN CONTINUE TEST HQ AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProviderAfter(_middle,_entry,_enemy,_artifact,_side); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST HQ AFTER
    return {entry:_entry,enemy:_enemy,artifact:_artifact,side:_side}
}
function scrNTTEFullQuestHQGenerate(_spawnX,_spawnY,_subarea) {
    var _want=scrNTTEFullInstances(WantPopo),_elevators=[]
    for(var _i=0;_i<array_length(_want);++_i) {
        instance_destroy(_want[_i],false)
        var _floors=array_shuffle(scrNTTEFullInstances(Floor,true))
        for(var _j=0;_j<array_length(_floors);++_j) {
            var _f=_floors[_j],_free=false
            with(_f) _free=place_free(x,y)
            if(_free && point_distance((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,_spawnX,_spawnY)>128) {
                array_push(_elevators,instance_create(_f.x,_f.y,NTTEFullFreakChamber));break
            }
        }
    }
    var _elites=scrNTTEFullInstances([EliteGrunt,EliteShielder,EliteInspector])
    for(var _i=0;_i<array_length(_elites);++_i) if(random(2)<1) {
        var _old=_elites[_i]
        array_push(_elevators,instance_create(_old.x,_old.y,NTTEFullFreakChamber))
        instance_destroy(_old,false)
        // NTT VanSpawn has a delayed-enemy threshold; Epsilon VanSpawn opens
        // directly on its native alarm and has no such field. Preserve any
        // threshold when provided, without inventing a dormant native field.
        with(VanSpawn) if(variable_instance_exists(id,"enemies")) enemies-=1
        with(NTTEFullFreakChamber) enemies-=1
    }
    var _side=undefined
    if(_subarea==3) _side=scrNTTEFullQuestHQAtMiddle(instance_find(FloorMiddle,0))
    var _troops=scrNTTEFullInstances([Grunt,Shielder,Inspector]),_guard=noone
    if(array_length(_troops)) {
        var _old=_troops[irandom(array_length(_troops)-1)]
        _guard=scrNTTEFullWorldCreateRequired("PopoSecurity",_old.x,_old.y);instance_destroy(_old,false)
    }
    return {elevators:_elevators,side:_side,security:_guard}
}
