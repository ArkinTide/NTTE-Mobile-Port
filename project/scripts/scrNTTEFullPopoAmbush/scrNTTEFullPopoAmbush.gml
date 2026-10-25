// teevents2536..2567 and tegeneral797..891. Original BigIDPDSpawn forces
// num native Alarm1 groups in one release, rather than inventing wave timers.
function scrNTTEFullBigIDPDSpawnCreate() {
    sprite_index=sprVanPortalStart; image_index=0
    elite=true; freak=GameCont.loops-(GameCont.area==area_desert)>=3
    num=2*(1+GameCont.loops); depth=-3
    ntte_big_delay=alarm[0]+30; ntte_big_release=-1; ntte_big_released=false
    alarm[0]=-1; alarm[1]=-1
    snd_stop(sndIDPDPortalSpawn); snd_play(sndEliteIDPDPortalSpawn)
    instance_create(x,y,PortalClear)
}
function scrNTTEFullBigIDPDSpawnEndStep() {
    if (lockstep_stop) return;
    if (sprite_index==sprVanPortalCharge) {
        if (random(3)<2*timescale) {
            var _dir=random(360),_charge=instance_create(x+lengthdir_x(64,_dir),y+lengthdir_y(64,_dir),NTTEFullIDPDCharge)
            _charge.ntte_life=20+random(20); _charge.alarm[0]=-1
            _charge.speed=64/_charge.ntte_life*timescale; _charge.direction=_dir+180
        }
        if (random(4)<timescale) with (instance_create(x,y,PlasmaTrail)) {
            motion_set(random(360),(1+random(1))*timescale); sprite_index=sprPopoPlasmaTrail
        }
    }
    if (ntte_big_delay>0) {
        ntte_big_delay-=timescale
        if (ntte_big_delay<=0) { ntte_big_release=12; sprite_index=sprVanPortalClose; image_index=0 }
    }
    else if (ntte_big_release>0) {
        if (ntte_big_release<=ceil(timescale)) {
            ntte_big_release=-1; ntte_big_released=true; depth=0
            with (instance_create(x,y,PortalClear)) { image_xscale=2; image_yscale=2 }
            if (num>0) repeat(num) event_perform(ev_alarm,1)
            snd_play(sndPortalOpen,0.2)
        }
        else ntte_big_release-=timescale
    }
}
function scrNTTEFullBigIDPDSpawnAnimate() {
    if (sprite_index==sprVanPortalStart) sprite_index=sprVanPortalCharge
    else if (sprite_index==sprVanPortalClose) instance_destroy()
}
function scrNTTEFullPopoAmbushCreate() {
    if (GameCont.loops>0) repeat(GameCont.loops) instance_create(x,y,IDPDSpawn)
    var _spawn=instance_create(spawn_x,spawn_y,NTTEFullBigIDPDSpawn)
    var _alert=scrNTTEAlertCreate(_spawn.x,_spawn.y,scrNTTERefSprite(_spawn.freak ? "PopoFreakAlert":"PopoEliteAlert"),_spawn)
    _alert.image_speed=0.1*timescale; _alert.alert_sprite=scrNTTERefSprite("AlertIndicatorPopo"); _alert.alert_x=-5; _alert.alert_y=5
    _alert.target_x=-3; _alert.target_y=-24; _alert.alert_hold=_spawn.ntte_big_delay
    var _chests=scrNTTEFullInstances(AmmoChest)
    for(var _i=0;_i<array_length(_chests);++_i) with (_chests[_i]) {
        var _replacement=scrNTTEFullLairChestCreate(x,y,IDPDChest,true)
        if (instance_exists(_replacement)) instance_destroy(id,false)
    }
    return _spawn
}
function scrNTTEFullIDPDChargeStep() {
    if (lockstep_stop) return;
    ntte_life-=timescale
    if (ntte_life<=0) instance_destroy()
}
function scrNTTEFullPopoAmbushSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_loops=GameCont.loops,_area=GameCont.area
    GameCont.loops=0; GameCont.area=area_palace
    var _spawn=instance_create(39000,39000,NTTEFullBigIDPDSpawn)
    assert(_spawn.elite && !_spawn.freak && _spawn.num==2 && _spawn.depth==-3 && _spawn.ntte_big_delay>=30
        && _spawn.sprite_index==sprVanPortalStart && _spawn.alarm[0]==-1 && _spawn.alarm[1]==-1,"BigIDPD source elite/num/depth/logical delay/actual start sprite changed")
    var _old=instance_number(NTTEFullBigIDPDSpawn),_event=instance_create(39100,39000,NTTEFullWorldEvent)
    _event.spawn_x=39100; _event.spawn_y=39000
    var _created=noone
    with (_event) _created=scrNTTEFullPopoAmbushCreate()
    assert(instance_number(NTTEFullBigIDPDSpawn)==_old+1,"PopoAmbush did not create one source BigIDPDSpawn")
    var _alert=instance_nearest(_created.x,_created.y,NTTEAlert)
    assert(instance_exists(_alert) && _alert.sprite_index==scrNTTERefSprite("PopoEliteAlert") && _alert.alert_sprite==scrNTTERefSprite("AlertIndicatorPopo")
        && _alert.target_x==-3 && _alert.target_y==-24 && _alert.alert_hold==_created.ntte_big_delay,"PopoAmbush source elite icon/alert offsets/delay changed")
    var _freaks=instance_number(PopoFreak)
    GameCont.loops=3; _spawn.freak=true; _spawn.num=8; _spawn.ntte_big_delay=-1; _spawn.ntte_big_release=12
    repeat(ceil(12/timescale)) with (_spawn) scrNTTEFullBigIDPDSpawnEndStep()
    assert(_spawn.ntte_big_released && _spawn.depth==0 && instance_number(PopoFreak)==_freaks+8,"BigIDPD failed to force all eight real original native Alarm1 groups at the logical release time")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.loops=_loops; GameCont.area=_area
    scrNTTESmokeLog("FULL WORLD POPO AMBUSH SOURCE ACTUAL VAN SPRITES/ELITE VS FREAK ICON/LOGICAL DELAY/REAL EIGHT ALARM1 RELEASE/IDPD CHEST ROUTE OK")
}
