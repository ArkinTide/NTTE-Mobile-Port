// tescrapyard1471..1667. Real bidirectional hub floor controller. Source's
// aliases into queue arrays are explicitly written back for modern GML COW.
function scrNTTEFullQuestTeleporterCreate() {
    sprite_index=scrNTTERefSprite("QuestTeleporterPad");image_speed=0;depth=5
    mask_index=mskSuperFlakBullet;target=noone;teleport_x=x;teleport_y=y
    teleport_instance_delay_map={key_list:[],list:[]};teleport_charge_sound=-1
}
function scrNTTEFullQuestTeleporterQueue(_actor,_delay) {
    if(!instance_exists(_actor)) return false
    var _map=teleport_instance_delay_map
    if(array_get_index(_map.key_list,_actor)>=0) return false
    array_push(_map.key_list,_actor);array_push(_map.list,_delay)
    return true
}
function scrNTTEFullQuestTeleporterWind(_x,_y,_depth,_sprite,_angle=0,_speed=0.4) {
    var _wind=instance_create(_x,_y,Wind)
    _wind.sprite_index=_sprite;_wind.image_angle=_angle;_wind.image_speed=_speed*timescale;_wind.depth=_depth
    return _wind
}
function scrNTTEFullQuestTeleporterMove(_actor) {
    var _source=id,_tx=teleport_x,_ty=teleport_y
    with(_actor) {
        scrNTTEFullViewShift(index,point_direction(x,y,_tx,_ty),point_distance(x,y,_tx,_ty))
        scrNTTEFullQuestTeleporterWind(x,y,depth-1,sprOldGuardianDeflect)
        x=_tx+orandom(1);y=_ty+orandom(1)-8;xprevious=x;yprevious=y
        var _owner=id
        with(NTTEFullPet) if(leader==_owner) { x=other.x;y=other.y;xprevious=x;yprevious=y }
        sprite_index=spr_hurt;image_index=0
        var _wind=scrNTTEFullQuestTeleporterWind(x,y,depth-1,sprOldGuardianDeflect),_angle=random(360)
        for(var _dir=_angle;_dir<_angle+360;_dir+=90) {
            var _len=random_range(20,40)
            scrNTTEFullQuestTeleporterWind(_wind.x+lengthdir_x(_len,_dir),_wind.y+lengthdir_y(_len,_dir),-8,scrNTTERefSprite("QuestTeleporterSparkle"),0,0.4+orandom(0.2))
        }
        snd_play(sndPortalAppear,4+orandom(0.4),0.4);snd_play(sndCrownGuardianHurt,0.5+orandom(0.2))
        scrNTTEFullWorldWallClear(id)
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST TELEPORT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryTeleport(_source,id); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST TELEPORT
        var _pads=scrNTTEFullInstances(NTTEFullQuestTeleporterPad)
        for(var _i=0;_i<array_length(_pads);++_i) if(place_meeting(x,y,_pads[_i])) with(_pads[_i]) scrNTTEFullQuestTeleporterQueue(_owner,90)
    }
}
function scrNTTEFullQuestTeleporterBegin() {
    var _map=teleport_instance_delay_map,_snapshot=[]
    array_copy(_snapshot,0,_map.key_list,0,array_length(_map.key_list))
    if(array_length(_snapshot)>0) {
        var _oy=y;y-=4
        try {
            for(var _i=0;_i<array_length(_snapshot);++_i) {
                var _actor=_snapshot[_i],_index=array_get_index(_map.key_list,_actor),_meet=false
                if(_index<0) continue
                if(instance_exists(_actor)) with(_actor) _meet=place_meeting(x,y,other.id)
                if(_meet) {
                    if(_map.list[_index]>0) _map.list[_index]-=(_actor.speed==0?2:1)*timescale
                    else scrNTTEFullQuestTeleporterMove(_actor)
                }
                else {
                    array_delete(_map.key_list,_index,1);array_delete(_map.list,_index,1)
                    if(array_length(_map.key_list)<=0) {
                        snd_play(sndClickBack,0.5,0.5)
                        if(audio_is_playing(teleport_charge_sound)) audio_stop_sound(teleport_charge_sound)
                    }
                }
            }
        }
        finally { y=_oy }
    }
    var _interval=array_length(_snapshot)>0?2:20
    if((current_frame%_interval)<timescale) {
        var _len=random_range(4,8),_dir=random(360),
            _wind=scrNTTEFullQuestTeleporterWind(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir),6,scrNTTERefSprite("QuestTeleporterSparkle"),random(360))
        with(_wind) motion_add(_dir,random(0.1)*timescale)
    }
}
function scrNTTEFullQuestTeleporterEnd() {
    if(!instance_exists(target)) { instance_destroy();return }
    var _turn=2*timescale,_oy=y;y-=4
    try {
        if(place_meeting(x,y,Player)) {
            var _players=scrNTTEFullInstances(Player)
            for(var _i=0;_i<array_length(_players);++_i) {
                var _actor=_players[_i],_meet=false
                with(_actor) _meet=place_meeting(x,y,other.id)
                if(_meet && array_get_index(teleport_instance_delay_map.key_list,_actor)<0) {
                    if(array_length(teleport_instance_delay_map.key_list)<=0) {
                        snd_play(sndAppear,0.4,0.8);teleport_charge_sound=snd_play(sndRocketFly,1.5+orandom(0.1))
                    }
                    scrNTTEFullQuestTeleporterQueue(_actor,20)
                }
            }
            _turn*=2
        }
    }
    finally { y=_oy }
    if(abs(angle_difference(image_angle,round(image_angle/60)*60))>_turn/2 || random(30)<timescale
        || array_length(teleport_instance_delay_map.key_list)>0) image_angle+=_turn
}
function scrNTTEFullQuestTeleporterDraw() {
    var _oy=y
    for(image_index=0;image_index<image_number;image_index+=1) {
        y=_oy
        if((image_index==0 || image_index==image_number-1) && array_length(teleport_instance_delay_map.key_list)<=0) y-=1
        draw_self()
    }
    y=_oy
}
