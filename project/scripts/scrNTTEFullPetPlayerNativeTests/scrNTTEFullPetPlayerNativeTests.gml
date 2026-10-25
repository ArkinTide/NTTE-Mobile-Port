function scrNTTEFullPetPlayerNativeTests() {
    assert(scrNTTESmokeEnabled(),"Pet player fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _progress=global.ntte_full_progress,_count=player_count,
        _max=variable_global_exists("pet_max")?global.pet_max:undefined,
        _last=variable_global_exists("pet_max_last")?global.pet_max_last:undefined,
        _surface=-1,_hidden=[],_petSlots=[]
    with(Player) array_push(_petSlots,[id,scrNTTEFullValue(id,"ntte_pet",[]),scrNTTEFullValue(id,"ntte_pet_max",undefined)])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        var _p=instance_find(Player,0)
        assert(instance_exists(_p),"Pet fixture needs a real native Player")
        with(Player) {ntte_pet=[];ntte_pet_max=3;visible=true}
        GameCont.ntte_pet_max=3;GameCont.ntte_pet_icon=[];global.pet_max=3;global.pet_max_last=3
        var _a=scrNTTEFullPetCreate(_p.x,_p.y,"Scorpion"),
            _b=scrNTTEFullPetCreate(_p.x,_p.y,"Parrot"),
            _c=scrNTTEFullPetCreate(_p.x,_p.y,"Mimic")
        assert(scrNTTEFullPetTake(_a,_p) && scrNTTEFullPetTake(_b,_p) && scrNTTEFullPetTake(_c,_p),
            "Real source pet acquisition failed")
        var _fx=instance_number(HealFX)
        _p.ntte_pet_max=1;scrNTTEFullPetPlayerSystemsStep()
        assert(array_length(_p.ntte_pet)==1 && _p.ntte_pet[0]==_a && _a.leader==_p
            && _b.leader==noone && _c.leader==noone && _b.can_take && _c.can_take
            && instance_number(HealFX)==_fx+2,
            "Source capacity reduction must release last companions with actual PetLost effects")
        var _lost=0
        with(HealFX) if(array_get_index(_before,id)<0 && sprite_index==scrNTTERefSprite("PetLost")) {
            assert(abs(image_speed-0.5*timescale)<=0.001 && abs(friction-timescale*timescale/8)<=0.001 && depth==-9,
                "Source release effect lost logical animation/friction/depth")
            _lost++
        }
        assert(_lost==2,"Source capacity reduction lost PetLost artwork")
        _p.ntte_pet=[_a,noone,_b];_p.ntte_pet_max=2
        _b.leader=_p;_b.can_take=false;_b.persistent=true
        _fx=instance_number(HealFX);scrNTTEFullPetPlayerSystemsStep()
        assert(array_length(_p.ntte_pet)==2 && _p.ntte_pet[0]==_a && _p.ntte_pet[1]==_b
            && _b.leader==_p && instance_number(HealFX)==_fx,
            "Source shrinking must remove a vacant slot before releasing a live pet")
        _p.ntte_pet_max=4;scrNTTEFullPetSetSkin(_b,1);scrNTTEFullPetPlayerSystemsStep()
        var _icons=GameCont.ntte_pet_icon[_p.index]
        assert(array_length(_p.ntte_pet)==4 && _p.ntte_pet[2]==noone && _p.ntte_pet[3]==noone
            && array_length(_icons)==2 && _icons[0][0]=="Scorpion" && _icons[1][0]=="Parrot"
            && _icons[1][1]=="mod" && _icons[1][2]=="petlib" && _icons[1][3]==1,
            "Source fixed empty slots or ID-independent map species/provider/skin metadata diverged")
        var _names=["Scorpion","Parrot","CoolGuy","Orchid","Octo","Mimic","Salamander","Slaughter","Spider","Prism","Twins","Cuz","Weapon","Guardian"],
            _stats=json_stringify(global.ntte_full_progress.stats),_instances=instance_number(all)
        for(var _i=0;_i<array_length(_names);++_i)
            assert(scrNTTEFullPetGetSprite(_names[_i],"mod","petlib",0,"icon")==scrNTTERefSprite("Pet"+_names[_i]+"Icon"),
                "Source pure map icon mismatch: "+_names[_i])
        assert(scrNTTEFullPetGetSprite("Parrot","mod","petlib",1,"icon")==scrNTTERefSprite("PetParrotBIcon")
            && scrNTTEFullPetGetSprite("CoolGuy","mod","petlib","peas","icon")==scrNTTERefSprite("PetPeasIcon")
            && scrNTTEFullPetGetSprite("Spider","mod","petlib",1,"icon")==scrNTTERefSprite("PetSpiderCursedIcon")
            && scrNTTEFullPetGetSprite("Weapon","mod","petlib",1,"icon")==scrNTTERefSprite("PetWeaponCursedIcon")
            && scrNTTEFullPetGetSprite("Twins","mod","petlib",1,"icon")==scrNTTERefSprite("PetTwinsIcon")
            && instance_number(all)==_instances && json_stringify(global.ntte_full_progress.stats)==_stats,
            "Pure roadmap queries lost source skin art/Twins combined icon or allocated pets/statistics")
        var _saved=json_parse(json_stringify(GameCont.ntte_pet_icon))
        _hidden=scrNTTEFullInstances(Player)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
        scrNTTEFullPetPlayerSystemsStep()
        assert(json_stringify(GameCont.ntte_pet_icon)==json_stringify(_saved),
            "Source roadmap pet metadata was erased after all Player bodies disappeared")
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        _hidden=[]
        // The source rings expand after the sixth icon, using provider/skin
        // metadata only, so saved metadata can draw after physical pets die.
        player_count=1;GameCont.ntte_pet_icon=[];GameCont.ntte_pet_icon[0]=[]
        repeat(8) array_push(GameCont.ntte_pet_icon[0],["Parrot","mod","petlib",1])
        var _rows=scrNTTEFullPetMapLayout(0,64,64)
        assert(array_length(_rows)==8 && _rows[0].sprite==scrNTTERefSprite("PetParrotBIcon")
            && _rows[0].x==64+floor(lengthdir_x(10,30)) && _rows[0].y==64+floor(lengthdir_y(10,30))
            && _rows[6].x==64+floor(lengthdir_x(18,390)) && _rows[6].y==64+floor(lengthdir_y(18,390))
            && abs(_rows[0].image-0.4*current_frame)<=0.001,
            "Source first/second icon ring positions or animation clock diverged")
        player_count=2;_rows=scrNTTEFullPetMapLayout(0,64,64)
        assert(abs(_rows[0].x-64-lengthdir_x(4,135)-floor(lengthdir_x(10,135)))<=0.001
            && abs(_rows[0].y-64-lengthdir_y(4,135)-floor(lengthdir_y(10,135)))<=0.001,
            "Source two-player roadmap radius/45-degree offset diverged")
        player_count=1
        _surface=surface_create(128,128)
        assert(surface_exists(_surface),"Native map drawing surface allocation failed")
        surface_set_target(_surface);draw_clear_alpha(c_black,0);scrNTTEFullPetMapDraw(0,64,64);surface_reset_target()
        var _opaque=0
        for(var _x=32;_x<96;_x+=2) for(var _y=32;_y<96;_y+=2)
            if((surface_getpixel_ext(_surface,_x,_y) & $ff000000)!=0) _opaque++
        assert(_opaque>0,"Actual native map draw produced no pet sprite pixels")
        // Legacy delta updates the shared default; existing local player
        // capacities stay local, as in ntte.mod.gml3258.
        global.pet_max=5;global.pet_max_last=3;GameCont.ntte_pet_max=3
        scrNTTEFullPetPlayerSystemsStep()
        assert(GameCont.ntte_pet_max==5 && global.pet_max==5 && global.pet_max_last==5
            && _p.ntte_pet_max==4,
            "Source legacy pet_max delta incorrectly replaced local capacity or double-applied default")
    }
    finally {
        if(surface_exists(_surface)) surface_free(_surface)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        for(var _i=0;_i<array_length(_petSlots);++_i) if(instance_exists(_petSlots[_i][0])) {
            _petSlots[_i][0].ntte_pet=_petSlots[_i][1];_petSlots[_i][0].ntte_pet_max=_petSlots[_i][2]
        }
        global.pet_max=_max;global.pet_max_last=_last
        global.ntte_full_progress=_progress;player_count=_count;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL PET PLAYER NATIVE: actual acquisition/live fixed capacity/last-release effects/vacant slots/pure14 species+skin icons/metadata survives bodies/actual map draw/rings+co-op offsets/legacy capacity delta OK @"+string(30/timescale))
}
