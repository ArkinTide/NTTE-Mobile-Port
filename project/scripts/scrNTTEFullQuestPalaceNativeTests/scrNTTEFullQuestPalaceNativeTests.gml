function scrNTTEFullQuestPalaceNativeTests() {
    var _before=scrNTTEFullInstances(all),_terrain=scrNTTEFullInstances([Floor,Wall,TopSmall,SnowFloor]),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _progress=global.ntte_full_progress,_seed=random_get_seed(),_skills=GameCont.skills,_testSkills=ds_list_create(),
        _p=instance_find(Player,0),_oldFeet=scrNTTEFullValue(_p,"footkind",undefined),_oldSlow=scrNTTEFullValue(_p,"ntte_stairslow",0)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    GameCont.skills=_testSkills
    for(var _i=0;_i<array_length(_terrain);++_i) instance_deactivate_object(_terrain[_i])
    GameCont.area=area_palace;GameCont.crown=0;GameCont.ntte_quest_spawned_part_index_list=[]
    global.ntte_full_progress.unlocks[$ "quest:part:1"]=false
    try {
        instance_create(88000,88000,Floor)
        var _anchor=instance_create(88016,88016,NothingInactive),_result=scrNTTEFullQuestPalaceAtAnchor(_anchor)
        assert(is_struct(_result) && abs(_result.room.x2-_result.room.x1-128)<=0.01
            && abs(_result.room.y2-_result.room.y1-128)<=0.01 && array_length(_result.room.floors)==16,
            "Palace3 source4x4guarded shrine room lost exact native geometry")
        assert(array_length(_result.stairs)>0 && array_length(_result.center)==4
            && instance_exists(_result.chest) && scrNTTEFullCrabbonePartIndex(_result.chest.wep)==1
            && _result.chest.x==_result.room.x && _result.chest.y==_result.room.y,
            "Palace3 acquisition lost actual stairs/2x2center/physical Guarded artifact")
        var _seen=[]
        for(var _i=0;_i<4;++_i) {
            var _f=_result.center[_i]
            assert(_f.sprite_index==scrNTTERefSprite("FloorPalaceShrineRoomSmall"),"Palace source shrine center art missing")
            array_push(_seen,_f.image_index)
        }
        array_sort(_seen,true)
        assert(_seen[0]==0 && _seen[3]==3,"Palace shrine2x2floor source image sequence diverged")
        for(var _i=0;_i<array_length(_result.stairs);++_i) {
            var _s=_result.stairs[_i],_f=instance_position(_s.x+16,_s.y+21,Floor)
            assert(instance_is(_s,NTTEFullPalaceStairs) && instance_exists(_f)
                && _f.sprite_index==scrNTTERefSprite("FloorPalaceStairs") && _f.image_index==1 && _f.depth==8,
                "Palace hallway controller lost actual native source stair floor/offset/depth")
        }
        assert(!scrNTTEFullQuestArtifactAvailable(1) && is_undefined(scrNTTEFullQuestPalaceAtAnchor(_anchor)),
            "Palace guarded artifact source once-per-run gate permits duplicate room")
        GameCont.ntte_quest_spawned_part_index_list=[]
        global.ntte_full_progress.unlocks[$ "quest:part:1"]=true
        assert(is_undefined(scrNTTEFullQuestPalaceAtAnchor(_anchor)),"Permanent guarded artifact unlock did not suppress acquisition room")
        var _s=_result.stairs[0]
        _p.x=_s.x+16;_p.y=_s.y+16;_p.visible=true;_p.footkind=1;_p.roll=0
        _p.sprite_index=_p.spr_walk;_p.image_index=0;_p.footstep=0;_p.footextra=0;_p.ntte_stairslow=0
        var _dust=instance_number(Dust)
        with(_s) event_perform(ev_step,ev_step_begin)
        assert(_p.ntte_stairslow==5 && instance_number(Dust)==_dust+1,
            "Actual PalaceStairs BeginStep did not coat touching active walking feet with5tickslow/smoke")
        with(_s) event_perform(ev_step,ev_step_begin)
        assert(instance_number(Dust)==_dust+1,"Palace stairs emitted fresh smoke everyframe while slow persisted")
        _p.ntte_stairslow=0;_p.footkind=0
        with(_s) event_perform(ev_step,ev_step_begin)
        assert(_p.ntte_stairslow==0,"Palace stairs slowed a source footkind0floating actor")
        with(_p) {
            ntte_stairslow=5;roll=0;vspeed=timescale;maxspeed=4*timescale;friction=0.45*timescale*timescale
            scrNTTEFullQuestStairPlayerStep()
            assert(abs(friction/timescale/timescale-1.45)<=0.00001 && abs(ntte_stairslow-(5-timescale))<=0.00001,
                "Palace stair source friction/logical timer changed with Runner frame rate")
            ntte_stairslow=5;roll=1;vspeed=0
            scrNTTEFullQuestStairPlayerStep()
            assert(abs(vspeed/timescale/timescale-0.4)<=0.00001,"Palace stairs rolling gravity lost logical timescale acceleration")
            ds_list_add(GameCont.skills,mut_throne_butt);ntte_stairslow=5;vspeed=0
            scrNTTEFullQuestStairPlayerStep()
            assert(vspeed==0,"Palace source ThroneButt roll exception missing")
            ds_list_clear(GameCont.skills);ds_list_add(GameCont.skills,mut_extra_feet)
            ntte_stairslow=5;roll=0;vspeed=timescale;friction=0.45*timescale*timescale
            scrNTTEFullQuestStairPlayerStep()
            assert(abs(friction/timescale/timescale-0.45)<=0.00001,"Palace source ExtraFeet terrain exception missing")
        }
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_terrain);++_i) instance_activate_object(_terrain[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        _p.footkind=_oldFeet;_p.ntte_stairslow=_oldSlow
        GameCont.skills=_skills;ds_list_destroy(_testSkills)
        global.ntte_full_progress=_progress;random_set_seed(_seed);scrNTTEFullFloorResetAlign()
    }
    scrNTTESmokeLog("FULL QUEST PALACE NATIVE: source256clearance4x4guarded shrine/old-floor snapshot hallway/2x2center/artifact gates;actual staircase BeginStep smoke/feet gates;normalized friction,roll gravity,ThroneButt/ExtraFeet exceptions OK @"+string(30/timescale))
}
