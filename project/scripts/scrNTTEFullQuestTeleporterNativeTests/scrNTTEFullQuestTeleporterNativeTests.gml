function scrNTTEFullQuestTeleporterNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_frame=current_frame,_seed=random_get_seed()
    GameCont.area=area_vault;current_frame=3
    try {
        var _player=instance_find(Player,0),_f1=instance_create(73000,73000,Floor),_f2=instance_create(73500,73000,Floor),
            _a=instance_create(73016,73016,NTTEFullQuestTeleporterPad),_b=instance_create(73516,73016,NTTEFullQuestTeleporterPad)
        _a.target=_f1;_b.target=_f2;_a.teleport_x=_b.x;_a.teleport_y=_b.y
        _b.teleport_x=_a.x;_b.teleport_y=_a.y
        assert(_a.sprite_index==scrNTTERefSprite("QuestTeleporterPad") && _a.mask_index==mskSuperFlakBullet
            && _a.depth==5 && _a.image_speed==0 && array_length(_a.teleport_instance_delay_map.key_list)==0,
            "Quest teleporter lost real source native sprite/mask/depth/queue constructor")
        _player.x=_a.x;_player.y=_a.y-4;_player.xprevious=_player.x;_player.yprevious=_player.y;_player.speed=0
        var _pet=instance_create(73900,73000,NTTEFullPet);_pet.leader=_player
        with(_a) event_perform(ev_step,ev_step_end)
        assert(array_length(_a.teleport_instance_delay_map.key_list)==1
            && _a.teleport_instance_delay_map.key_list[0]==_player && _a.teleport_instance_delay_map.list[0]==20
            && _a.y==73016,"Quest teleporter real EndStep did not queue source20logical tick delay or restore4px collision offset")
        with(_a) event_perform(ev_step,ev_step_end)
        assert(array_length(_a.teleport_instance_delay_map.key_list)==1,"Quest teleporter queued duplicate actor")
        repeat(round(10/timescale)) with(_a) event_perform(ev_step,ev_step_begin)
        assert(abs(_a.teleport_instance_delay_map.list[0])<=0.00001 && _player.x==_a.x,
            "Stationary quest teleporter did not count20at double logical rate or teleported before next source callback")
        with(_a) event_perform(ev_step,ev_step_begin)
        assert(abs(_player.x-_b.x)<=1.01 && abs(_player.y-(_b.y-8))<=1.01
            && _player.xprevious==_player.x && _player.yprevious==_player.y
            && _player.sprite_index==_player.spr_hurt && _player.image_index==0
            && _pet.x==_player.x && _pet.y==_player.y && _pet.xprevious==_pet.x && _pet.yprevious==_pet.y,
            "Quest teleporter real BeginStep lost exact destination±1/-8 offset, previous positions, native hurt frame or real follower Pet relocation")
        assert(array_length(_b.teleport_instance_delay_map.key_list)==1
            && _b.teleport_instance_delay_map.key_list[0]==_player && _b.teleport_instance_delay_map.list[0]==90,
            "Quest teleport did not place source90logical tick anti-bounce delay on destination pad")
        with(_a) event_perform(ev_step,ev_step_begin)
        assert(array_length(_a.teleport_instance_delay_map.key_list)==0,"Quest source pad retained actor after leaving")
        repeat(round(44/timescale)) with(_b) event_perform(ev_step,ev_step_begin)
        assert(abs(_b.teleport_instance_delay_map.list[0]-2)<=0.00001 && abs(_player.x-_b.x)<=1.01,
            "Quest destination pad ignored source stationary90tick cooldown")
        // Moving doubles the charge time. Exercise source cancellation too.
        _player.x=_a.x;_player.y=_a.y-4;_player.speed=2*timescale
        with(_b) event_perform(ev_step,ev_step_begin)
        assert(array_length(_b.teleport_instance_delay_map.key_list)==0,"Quest destination queue did not remove departed moving actor")
        with(_a) event_perform(ev_step,ev_step_end)
        repeat(round(19/timescale)) with(_a) event_perform(ev_step,ev_step_begin)
        assert(abs(_a.teleport_instance_delay_map.list[0]-1)<=0.00001 && _player.x==_a.x,
            "Moving quest teleport failed source single-rate20tick delay")
        _player.x=_a.x+80
        with(_a) event_perform(ev_step,ev_step_begin)
        assert(array_length(_a.teleport_instance_delay_map.key_list)==0,
            "Walking away from charging quest pad did not cancel its real queue")
        // Source layered Draw may alter image_index but must restore y.
        var _oldY=_a.y
        with(_a) event_perform(ev_draw,0)
        assert(_a.y==_oldY,"Quest teleporter layered Draw leaked idle1px bob into its collision position")
        instance_destroy(_f1,false)
        with(_a) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_a),"Quest teleporter survived deletion of its actual target Floor")
    }
    finally {
        var _pads=scrNTTEFullInstances(NTTEFullQuestTeleporterPad)
        for(var _i=0;_i<array_length(_pads);++_i) if(array_get_index(_before,_pads[_i])<0
            && audio_is_playing(_pads[_i].teleport_charge_sound)) audio_stop_sound(_pads[_i].teleport_charge_sound)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL QUEST TELEPORTER NATIVE: real Begin/End queue20double/single-rate, exact destination/previous position/real Pet/camera+FX,90tick destination anti-bounce, leaving cancellation, layered Draw y restoration and target cleanup OK @"+string(30/timescale))
}
