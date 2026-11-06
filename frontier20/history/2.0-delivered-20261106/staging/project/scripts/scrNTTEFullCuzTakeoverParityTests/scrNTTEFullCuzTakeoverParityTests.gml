// Controlled synchronous component only: no adoption/death/natural-route claim.
function scrNTTEFullCuzParityDeleteSince(_before) {
    var _all=scrNTTEFullInstances(all)
    for(var _i=array_length(_all)-1;_i>=0;--_i)
        if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
}
function scrNTTEFullCuzTakeoverParityTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Cuz parity requires dedicated desktop smoke")
    assert(timescale==1 || timescale==0.5,"Cuz parity requires actual30/60")
    var _before=scrNTTEFullInstances(all),_hidden=[],_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_top=scrNTTEFullAreaGeneratorSnapshot(TopCont),
        _input=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_seed=random_get_seed(),_globals=[],_graph={nodes:[]},
        _names=variable_struct_get_names(global),_old_map=UberCont.saveData,_old_data=ds_map_write(_old_map),
        _private_map=ds_map_create(),_old_count=player_count,_old_my_player=my_player,
        _old_top_count=instance_number(TopCont)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i],_value=variable_global_get(_name)
        array_push(_globals,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
    }
    for(var _i=0;_i<array_length(_before);++_i) {
        var _id=_before[_i],_object=_id.object_index
        if(_object==GameCont || _object==UberCont || _object==TopCont || _object==KeyCont || _object==Console) continue;
        array_push(_hidden,_id);instance_deactivate_object(_id)
    }
    ds_map_copy(_private_map,_old_map);UberCont.saveData=_private_map
    try {
        scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        GameCont.win=false;GameCont.underwater=false;GameCont.loops=0;GameCont.crown=crwn_none
        GameCont.ultra_got[Race.Fish]=array_create(array_length(GameCont.ultra_got[Race.Fish]),0)
        GameCont.ultra_got[Race.Cuz]=array_create(array_length(GameCont.ultra_got[Race.Cuz]),0)
        GameCont.ultra_hud=[]
        // Dedicated startup smoke has no generated-room TopCont yet. Use its
        // real native constructor, including SubTopCont, before reading controls.
        // DeleteSince removes this fixture-only pair; existing controllers stay.
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
        assert(instance_exists(TopCont),"Cuz parity native TopCont prerequisite missing")
        var _pet=scrNTTEFullPetCreate(88000,88000,"Cuz")
        _pet.leader_index=0;_pet.leader=noone
        var _cases=[{label:"normal-negative",object:Portal,type:1,endgame:-1,want:sprPortal},
            {label:"popo-negative",object:Portal,type:2,endgame:-1,want:sprPopoPortal},
            {label:"proto-negative",object:Portal,type:3,endgame:-1,want:sprProtoPortal},
            {label:"big-negative",object:BigPortal,type:2,endgame:-1,want:sprBigPortal},
            {label:"unknown-negative",object:Portal,type:4,endgame:-1,want:sprPortalDisappear},
            {label:"normal-zero",object:Portal,type:1,endgame:0,want:sprPortalDisappear},
            {label:"popo-positive",object:Portal,type:2,endgame:30,want:sprPortalDisappear},
            {label:"proto-idle",object:Portal,type:3,endgame:100,want:sprPortalDisappear},
            {label:"big-zero",object:BigPortal,type:3,endgame:0,want:sprPortalDisappear}],_portals=[]
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _c=_cases[_i],_p=instance_create(88128+_i*128,88000,_c.object)
            _p.type=_c.type;_p.endgame=_c.endgame;_p.sprite_index=sprPortalDisappear
            _p.image_index=2;_p.image_speed=0.125;_p.close=true
            array_push(_portals,_p)
        }
        var _screen_cases=[{alarm0:45,visible:false},{alarm0:0,visible:false},{alarm0:-1,visible:false},
            {alarm0:10,visible:true}],_screens=[]
        for(var _i=0;_i<array_length(_screen_cases);++_i) {
            var _s=instance_create(0,0,UnlockScreen),_c=_screen_cases[_i]
            _s.alarm[0]=_c.alarm0;_s.alarm[1]=17;_s.visible=_c.visible
            _s.race=Race.Fish;_s.bskin=SkinLetter.A;_s.wait=7;_s.anim=0.25;_s.can_continue=true
            array_push(_screens,_s)
        }
        UberCont.letterbox=true;UberCont.letterbox_frame=2.5
        var _controls=TopCont.drawcontrols,_new=noone
        with(_pet) _new=scrNTTEFullPetCuzTakeover()
        assert(instance_exists(_new) && !instance_exists(_pet) && _new.race==Race.Cuz
            && _new.ntte_cuz_adopted && _new.index==0 && scr_playerinstance_find(0).race==Race.Cuz,
            "Controlled Cuz parity did not execute actual production takeover/self-delete")
        for(var _i=0;_i<array_length(_portals);++_i) {
            var _p=_portals[_i],_c=_cases[_i]
            scrNTTESmokeLog("CUZ PARITY PORTAL "+json_stringify({label:_c.label,id:_p,type:_p.type,
                before_endgame:_c.endgame,after_endgame:_p.endgame,sprite:_p.sprite_index,expected:_c.want}))
            assert(instance_exists(_p) && _p.endgame==(_c.endgame<0?100:_c.endgame) && _p.sprite_index==_c.want,
                "Cuz source special Portal restoration mismatch: "+_c.label)
            assert(_p.type==_c.type && _p.image_index==2 && _p.image_speed==0.125 && _p.close,
                "Cuz source Portal restoration altered unrelated state: "+_c.label)
        }
        assert(instance_number(Portal)==array_length(_portals),"Cuz parity duplicated/deleted a Portal")
        for(var _i=0;_i<array_length(_screens);++_i) {
            var _s=_screens[_i],_c=_screen_cases[_i]
            assert(instance_exists(_s) && _s.alarm[0]==-1 && _s.alarm[1]==17 && _s.visible==_c.visible
                && _s.race==Race.Fish && _s.bskin==SkinLetter.A && _s.wait==7 && _s.anim==0.25 && _s.can_continue,
                "Cuz cancellation must preserve actual UnlockScreen identity/visibility/other state")
        }
        assert(instance_number(UnlockScreen)==array_length(_screens),"Cuz cancellation deleted/created UnlockScreen")
        assert(!UberCont.letterbox && UberCont.letterbox_frame==2.5 && TopCont.drawcontrols==_controls,
            "Cuz cancellation bypassed letterbox fade or overwrote controls")
    }
    finally {
        scrNTTEFullCuzParityDeleteSince(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        var _current=variable_struct_get_names(global)
        for(var _i=0;_i<array_length(_current);++_i)
            if(array_get_index(_names,_current[_i])<0) variable_struct_remove(global,_current[_i])
        for(var _i=0;_i<array_length(_globals);++_i) variable_global_set(_globals[_i][0],_globals[_i][1])
        player_count=_old_count;my_player=_old_my_player
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_top);scrNTTEFullAreaGeneratorRestore(_input)
        UberCont.saveData=_old_map;ds_map_destroy(_private_map);random_set_seed(_seed)
        assert(ds_map_write(_old_map)==_old_data,"Cuz parity changed original save/options map")
        assert(instance_number(TopCont)==_old_top_count,"Cuz parity changed original TopCont lifecycle")
    }
    scrNTTESmokeLog("PASS CUZ TAKEOVER PARITY controlled native special Portal negative/nonnegative/unknown type; all UnlockScreen alarm-only; letterbox fade input preserved @"+string(30/timescale)
        +"; no natural adoption/death/portal route, physical Draw fade, music, ultras or multiplayer acceptance")
}
