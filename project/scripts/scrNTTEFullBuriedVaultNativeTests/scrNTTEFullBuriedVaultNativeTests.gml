function scrNTTEFullBuriedVaultNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),_seed=random_get_seed()
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.crownvisits=0
    try {
        // Natural generation retains its six logical tick wait, both six-cell
        // decoration loops, and exactly one source3x3 loot room.
        var _base=instance_create(67000,67000,Floor),_vault=instance_create(67032,67000,NTTEFullBuriedVault)
        assert(_vault.obj_loot=="BuriedVaultPedestal" && _vault.area==area_vault
            && _vault.mask_index==mskWall && _vault.image_xscale==6 && _vault.image_yscale==4
            && array_length(_vault.layout)==0 && _vault.layout_delay==6,
            "BuriedVault constructor lost source dimensions/mask/ordinary pedestal route")
        repeat(round(6/timescale)) with(_vault) event_perform(ev_step,ev_step_normal)
        assert(array_length(_vault.layout)==0 && abs(_vault.layout_delay)<=0.00001,"BuriedVault generated before six logical ticks elapsed")
        with(_vault) event_perform(ev_step,ev_step_normal)
        assert(array_length(_vault.layout)>0 && GameCont.area==area_desert,"BuriedVault did not generate hidden source layout or leaked temporary vault area")
        var _rooms=0,_loot=0,_floors=0,_seen=[]
        for(var _i=0;_i<array_length(_vault.layout);++_i) {
            var _node=_vault.layout[_i]
            if(_node.obj==Floor) {
                _floors+=1
                if(variable_struct_exists(_node,"room")) { _rooms+=1;array_push(_seen,_node.room) }
            }
            else if(_node.obj=="BuriedVaultPedestal") _loot+=1
        }
        array_sort(_seen,true)
        assert(_rooms==9 && _loot==1 && _floors>=14 && _floors<=20 && _seen[0]==0 && _seen[8]==8,
            "BuriedVault random walk lost6..12nodes/source3x3room/one pedestal/room image ordering")
        assert(instance_number(NTTEFullBuriedVaultPedestal)==0 && instance_number(NTTEFullBuriedVaultCrownPed)==0,
            "Hidden vault spawned real loot before excavation")
        // No contact: real Step preserves hidden layout. Creating a boundary
        // Wall then changes Floor count to invoke exact source excavation test.
        with(_vault) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_vault),"BuriedVault uncovered before a Floor/boundary contact")
        var _first=_vault.layout[0],_touch=instance_create(_first.x,_first.y,Wall)
        instance_create(67640,67000,Floor)
        var _guards=instance_number(CrownGuardian)
        with(_vault) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_vault) && !instance_exists(_touch) && GameCont.area==area_desert,
            "Real BuriedVault boundary excavation did not clear obstruction/destroy controller/restore old area")
        var _newFloors=scrNTTEFullInstances(Floor),_roomImages=[]
        for(var _i=0;_i<array_length(_newFloors);++_i) {
            var _tile=_newFloors[_i]
            if(array_get_index(_before,_tile)<0 && _tile.sprite_index==scrNTTERefSprite("VaultFlowerFloor")) array_push(_roomImages,_tile.image_index)
        }
        array_sort(_roomImages,true)
        assert(array_length(_roomImages)==9 && _roomImages[0]==0 && _roomImages[8]==8
            && instance_number(CrownGuardian)==_guards,
            "Excavated vault lost9actual source room floor images or spawned guardians before taking pedestal loot")
        var _peds=scrNTTEFullInstances([NTTEFullBuriedVaultPedestal,NTTEFullBuriedVaultCrownPed]),_found=0
        for(var _i=0;_i<array_length(_peds);++_i) if(array_get_index(_before,_peds[_i])<0) _found+=1
        assert(_found==1,"Ordinary excavation did not create exactly one actual vault pedestal")
        var _reveal=instance_find(NTTEFullFloorReveal,0),_revealed=0
        assert(instance_exists(_reveal),"BuriedVault did not create real mutable reveal controller")
        for(var _i=0;_i<array_length(_reveal.list);++_i) {
            var _record=_reveal.list[_i]
            if(_record.x1>66000 && _record.time_max==4 && !_record.flash) _revealed+=1
        }
        assert(_revealed>=9,"BuriedVault excavation lost source4tick non-flashing distance-delayed terrain reveal")
        // Crown-vault path: excavation must emit the real GhostStatue with its
        // existing break->Ghost lifecycle, not the ordinary treasure pedestal.
        GameCont.area=area_vault
        _vault=instance_create(68500,68000,NTTEFullBuriedVault)
        assert(_vault.obj_loot=="GhostStatue","Crown-vault buried room did not select source GhostStatue")
        _vault.layout=[{x:68500,y:68000,obj:Floor,room:0},{x:68532,y:68000,obj:Floor,room:1},
            {x:68516,y:68008,obj:_vault.obj_loot}]
        GameCont.area=area_desert
        var _ghosts=instance_number(NTTEFullGhostStatue),_ghost=instance_number(NTTEFullGhost)
        instance_create(68500,68000,Floor)
        with(_vault) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_vault) && instance_number(NTTEFullGhostStatue)==_ghosts+1 && GameCont.area==area_desert,
            "Crown-vault excavation did not naturally create actual GhostStatue/restore active area")
        var _statues=scrNTTEFullInstances(NTTEFullGhostStatue)
        for(var _i=0;_i<array_length(_statues);++_i) if(array_get_index(_before,_statues[_i])<0) {
            _statues[_i].hp=0;instance_destroy(_statues[_i])
        }
        assert(instance_number(NTTEFullGhost)==_ghost+1,"Buried crown-vault actual statue destruction did not enter existing real Ghost blessing chain")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_music);random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL BURIED VAULT NATIVE: six-tick hidden random layout/source3x3lootroom, actual excavation/terrain/area restore/reveal, natural pedestal and crown-vault Ghost statue chain OK @"+string(30/timescale))
}
