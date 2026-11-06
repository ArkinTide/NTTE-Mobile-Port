function scrNTTEFullQuestLockedNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_enemies=scrNTTEFullInstances(enemy),_seed=random_get_seed(),_frame=current_frame
    for(var _i=0;_i<array_length(_enemies);++_i) instance_deactivate_object(_enemies[_i])
    GameCont.area=area_vault;GameCont.crown=0;current_frame=3
    try {
        var _player=instance_find(Player,0),_chest=instance_create(78000,78000,NTTEFullLockedHugeQuestChest),_floors=[],_models=[],_pickups=[]
        _player.x=78000;_player.y=77900;_player.speed=0;_player.visible=true;_player.can_pick=true
        _player.wep=wep_revolver;_player.ntte_state=undefined;_player.bwep=wep_shotgun;_player.bntte_state=undefined
        _player.curse=0;_player.bcurse=0;_player.extra_weps=[];_player.ntte_extra_states=[]
        assert(instance_is(_chest,chestprop) && _chest.max_merge_delay==120 && _chest.merge_delay==120
            && !_chest.is_unlockable && instance_exists(_chest.prompt),
            "Locked quest chest lost source actual chestprop/120tick state/UNLOCK prompt")
        for(var _part=0;_part<4;++_part) {
            var _f=instance_create(77904+64*_part,78064,Floor),_c=instance_create(_f.x+16,_f.y+16,NTTEFullQuestFloorCont),
                _model=scrNTTEFullCrabboneCreateModel(_part),_pickup=scrWeaponPickupCreate(_c.x,_c.y,_model)
            _c.target=_f;_c.part_index=_part;_pickup.speed=0;_pickup.ammo=(_part%2);_pickup.curse=_part
            array_push(_floors,_c);array_push(_models,_model);array_push(_pickups,_pickup)
        }
        var _targets=[]
        with(_chest) _targets=scrNTTEFullLockedQuestCollect(_floors)
        assert(array_length(_targets)==4 && _targets[0]==_pickups[0] && _targets[3]==_pickups[3],
            "Quest chest source collection lost actual distinct artifact pickup->four tile mapping")
        var _enemy=instance_create(78500,78000,Bandit)
        repeat(round(125/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(_chest.merge_delay==120 && instance_exists(_pickups[0]),"Locked quest chest merged artifacts while a real enemy remained")
        instance_destroy(_enemy,false)
        // Actual first merge occurs only after120source ticks, launches one
        // real unfolding ball per distinct part and freezes while they exist.
        repeat(round(119/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(abs(_chest.merge_delay-1)<=0.00001 && instance_exists(_pickups[0]) && instance_exists(_pickups[1]),
            "Quest artifact pair0+1 merged before120logical ticks")
        repeat(round(1/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(!instance_exists(_pickups[0]) && !instance_exists(_pickups[1]) && _chest.merge_delay==120
            && instance_number(NTTEFullCrystalHeartBullet)==2 && _chest.is_playing_music,
            "Quest real pair0+1 merge lost physical pickup consumption/source reset/two genuine unfolding balls/music")
        var _new=scrNTTEFullInstances(WepPickup),_mergedA=noone
        for(var _i=0;_i<array_length(_new);++_i) if(scrNTTEFullQuestWeaponHasPart(_new[_i].wep,0)
            && scrNTTEFullQuestWeaponHasPart(_new[_i].wep,1)) _mergedA=_new[_i]
        assert(instance_exists(_mergedA) && _mergedA.ammo && _mergedA.curse==1
            && scrNTTEFullWeaponModel(_mergedA.wep)==_models[0] && scrNTTEFullWeaponMergedPart(_mergedA.wep)==_models[1],
            "Quest merge copied/reversed physical stock/front, or lost source max ammo/curse")
        repeat(round(125/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(_chest.merge_delay==120 && instance_exists(_pickups[2]),"Quest chest ignored actual unfolding HeartBullet lock")
        var _hearts=scrNTTEFullInstances(NTTEFullCrystalHeartBullet),_areas=[]
        for(var _i=0;_i<array_length(_hearts);++_i) {
            var _heart=_hearts[_i];array_push(_areas,_heart.area)
            assert((_heart.area==area_vault && _heart.area_goal==2 && _heart.area_chest[0]==RadChest)
                || (_heart.area==area_palace && _heart.area_goal==12 && _heart.area_chest[0]==AmmoChest),
                "Quest first merge HeartBullet lost source Vault/Palace goals/reward chest destinations")
            instance_destroy(_heart,false)
        }
        assert(array_get_index(_areas,area_vault)>=0 && array_get_index(_areas,area_palace)>=0,
            "Quest first merge did not emit each distinct part destination exactly once")
        // Emulate completion of source attraction at its actual tile. A merged
        // pickup fills both contained logical slots, and2+3must merge next.
        _mergedA.x=_floors[1].x;_mergedA.y=_floors[1].y;_mergedA.speed=0
        repeat(round(120/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(!instance_exists(_pickups[2]) && !instance_exists(_pickups[3]) && instance_number(NTTEFullCrystalHeartBullet)==2,
            "Quest source ordered pair2+3 did not follow completed0+1")
        _new=scrNTTEFullInstances(WepPickup);var _mergedB=noone
        for(var _i=0;_i<array_length(_new);++_i) if(scrNTTEFullQuestWeaponHasPart(_new[_i].wep,2)
            && scrNTTEFullQuestWeaponHasPart(_new[_i].wep,3)) _mergedB=_new[_i]
        _hearts=scrNTTEFullInstances(NTTEFullCrystalHeartBullet)
        for(var _i=0;_i<array_length(_hearts);++_i) {
            var _heart=_hearts[_i]
            assert((_heart.area==area_hq && _heart.area_goal==8 && _heart.area_chest[0]==IDPDChest)
                || (_heart.area==scrNTTEFullAreaId("red") && _heart.area_goal==10 && _heart.area_chest[0]==HealthChest),
                "Quest second merge HeartBullet lost source HQ/Red goals/reward chest destinations")
            instance_destroy(_heart,false)
        }
        _mergedB.x=_floors[2].x;_mergedB.y=_floors[2].y;_mergedB.speed=0
        repeat(round(120/timescale)) with(_chest) scrNTTEFullLockedQuestMergeStep()
        assert(!instance_exists(_mergedA) && !instance_exists(_mergedB) && _chest.is_unlockable
            && instance_number(NTTEFullCrystalHeartBullet)==4,
            "Quest final source pair1+2 failed four physical parts/four distinct area balls/unlock state")
        _new=scrNTTEFullInstances(WepPickup);var _full=noone
        for(var _i=0;_i<array_length(_new);++_i) if(array_length(scrNTTEFullQuestPartList(_new[_i].wep))==4) _full=_new[_i]
        assert(instance_exists(_full) && _full.curse==3 && _full.ammo,"Quest final weapon lost max outer curse/ammo")
        _player.wep=_full.wep;_player.ntte_state=_full.ntte_state;_player.curse=2;instance_destroy(_full,false)
        var _can=false
        with(_chest.prompt) _can=scrNTTEFullLockedQuestPromptMeet(_player)
        assert(_can,"Fully merged4part source artifact could not meet real UNLOCK prompt")
        var _reward=instance_number(NTTEFullHugeQuestChest),_bones=instance_number(NTTEFullCrabboneBone)
        with(_chest) assert(scrNTTEFullLockedQuestUnlock(_player),"Actual quest UNLOCK did not execute")
        assert(!instance_exists(_chest) && instance_number(NTTEFullHugeQuestChest)==_reward+1
            && instance_number(NTTEFullCrabboneBone)==_bones+4 && _player.wep==wep_shotgun && _player.bwep==wep_none,
            "Quest UNLOCK lost genuine ultimate reward chest/four real broken Bone projectiles/safe native swap")
        var _shots=scrNTTEFullInstances(NTTEFullCrabboneBone),_seen=[]
        for(var _i=0;_i<array_length(_shots);++_i) if(array_get_index(_before,_shots[_i])<0) {
            var _shot=_shots[_i]
            assert(_shot.broken && _shot.creator==_player && _shot.curse==2 && _shot.speed>=15.99*timescale
                && scrNTTEFullWeaponHasMerge(_shot.wep)==false,
                "Quest artifact disposal lost source broken/native creator/curse/16logical speed or retained nested merge graph")
            array_push(_seen,scrNTTEFullCrabbonePartIndex(_shot.wep))
        }
        array_sort(_seen,true)
        assert(array_length(_seen)==4 && _seen[0]==0 && _seen[3]==3,"Quest final disposal duplicated/lost original four physical parts")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_enemies);++_i) instance_activate_object(_enemies[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_music)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL LOCKED QUEST NATIVE: real enemy/HeartBullet gates;120tick ordered0+1/2+3/1+2 exact physical merges/max ammo+curse;2/2/4 native area balls;source music;four-part native UNLOCK/reward/broken Bone disposal/safe swap OK @"+string(30/timescale))
}
