// teoasis1454..1759. Source treasure, delayed guardians, and disconnected-room
// protection. These use the real merged weapon, pickup and path providers.
function scrNTTEFullSunkenChestCreate() {
    sprite_index=scrNTTERefSprite("SunkenChest"); spr_dead=scrNTTERefSprite("SunkenChestOpen"); spr_shadow_y=0
    snd_open=sndGoldChest; num=2; wep=wep_none; skeal=false
    if (scrNTTEFullAreaKey(GameCont.area)=="coast") wep=wep_ntte_golden_trident
    on_step=scrNTTEFullSunkenChestStep; on_open=scrNTTEFullSunkenChestOpen
}
function scrNTTEFullSunkenChestStep() {
    if (random(90)<timescale) with(instance_create(x+orandom(16),y+orandom(8),CaveSparkle)) depth=other.depth-1
    var _num=3*skeal,_spawn=false
    if (_num<=0) return;
    with(Player) if (point_distance(x,y,other.x,other.y)<192 && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _spawn=true; break }
    if (!_spawn) return;
    skeal=0
    var _angle=random(360)
    for(var _a=_angle;_a<_angle+360;_a+=360/_num) {
        var _dir=_a+orandom(30)
        instance_create(x+lengthdir_x(32,_dir),y+lengthdir_y(32,_dir),NTTEFullSunkenSealSpawn)
    }
    with(instance_create(x,y,PortalClear)) { image_xscale=1.2; image_yscale=1.2 }
    var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("SkealAlert"),id)
    if(instance_exists(_alert)) _alert.flash=10
    snd_play(sndMutant14Turn,0.2+random(0.1),1)
}
function scrNTTEFullSunkenChestOpen(_opener) {
    instance_create(x,y,PortalClear)
    GameCont.sunkenchests=max(scrNTTEFullValue(GameCont,"sunkenchests",0),GameCont.loops+1)
    if(instance_is(_opener,Player)) snd_play(_opener.snd_chst)
    if(scrNTTEFullWeaponRaw(wep)==wep_ntte_golden_trident || scrNTTEFullWeaponRaw(wep)==wep_ntte_trident)
        scrNTTEFullUnlockSet("wep:trident",true)
    var _count=1+scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)
    if(_count>0) {
        var _weapon=wep
        if(_weapon==wep_none) _weapon=scrNTTEFullMergedWeaponDecide(0,max(1,GameCont.hard-1),true)
        repeat(_count) { var _pickup=scrWeaponPickupCreate(x,y,_weapon); _pickup.ammo=true }
    }
    if(num>0) {
        repeat(num*10) with(instance_create(x,y,NTTEFullSunkenCoin)) motion_add(random(360),(2+random(2.5))*timescale)
        var _angle=random(360)
        for(var _a=_angle;_a<_angle+360;_a+=360/num) with(scrNTTEFullWorldCreateRequired("BackpackPickup",x,y)) {
            target=instance_create(x,y,AmmoPickup); direction=_a; speed=random_range(2,3)*timescale
            event_perform(ev_step,ev_step_end)
        }
    }
}
function scrNTTEFullSunkenCoinPull(_player) { return speed<=0 }
function scrNTTEFullSunkenCoinOpen(_opener) { return speed>0 }
function scrNTTEFullSunkenCoinCreate() {
    sprite_index=scrNTTERefSprite(random(3)<1 ? "SunkenCoinBig":"SunkenCoin"); image_angle=random(360)
    spr_open=sprCaveSparkle; spr_fade=sprCaveSparkle; shine=0.075; snd_open=sndRadPickup; snd_fade=-1
    mask_index=mskRad; ntte_full_fade_timer=scrNTTEFullPickupAlarm(200+random(30),0.25)
    pull_dis=18+12*scr_skill_get(mut_plutonium_hunger)
    on_pull=scrNTTEFullSunkenCoinPull; on_open=scrNTTEFullSunkenCoinOpen
}
function scrNTTEFullSunkenSealSpawnCreate() {
    visible=false; mask_index=mskBandit; type=irandom_range(1,3); skeal=true
    ntte_sunken_spawn_left=30+10*instance_number(NTTEFullSunkenSealSpawn)
    repeat(3) instance_create(x,y,Smoke)
}
function scrNTTEFullSunkenSealSpawnStep() {
    if(lockstep_stop) return;
    ntte_sunken_spawn_left-=timescale
    if(ntte_sunken_spawn_left<=0) {
        with(instance_create(x,y,NTTEFullSeal)) {
            type=other.type; skeal=other.skeal
            instance_create(x,y,NTTEFullAssassinNotice)
            if(skeal) snd_play(sndBloodGamble,1.6+random(0.2),1.8)
            snd_play_hit(sndChickenRegenHead,0.1); snd_play(sndSharpTeeth,0.6+random(0.4),0.4)
        }
        instance_destroy(); return;
    }
    scrNTTEFullPortalPoof()
    var _list=ds_list_create(); instance_place_list(x,y,Wall,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) with(_list[|_i]) { instance_create(x,y,FloorExplo); instance_destroy() }
    ds_list_destroy(_list)
}
function scrNTTEFullSunkenRoomCreate() { visible=false; mask_index=mskFloor; image_xscale=1; image_yscale=1; floors=[]; size=1 }
function scrNTTEFullSunkenRoomOccupied(_instance) {
    with(_instance) return place_meeting(x,y,Player) || place_meeting(x,y,Portal) || place_meeting(x,y,enemy)
    return false;
}
function scrNTTEFullSunkenRoomStep() {
    if(lockstep_stop || !instance_exists(Floor) || !scrNTTEFullSunkenRoomOccupied(id)) return;
    var _touch=false
    for(var _i=0;_i<array_length(floors);++_i) if(instance_exists(floors[_i]) && scrNTTEFullSunkenRoomOccupied(floors[_i])) { _touch=true; break }
    if(!_touch) return;
    var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2,_sx=10016,_sy=10016,_candidates=[]
    with(Floor) if(object_index==Floor) {
        _sx=(bbox_left+bbox_right)/2; _sy=(bbox_top+bbox_bottom)/2
        if(array_get_index(other.floors,id)<0) array_push(_candidates,[id,point_distance(_sx,_sy,_cx,_cy)])
    }
    array_sort(_candidates,function(_a,_b) { return _a[1]-_b[1] })
    var _done=false
    for(var _i=0;_i<array_length(_candidates) && !_done;++_i) with(_candidates[_i][0]) {
        for(var _x=bbox_left;_x<bbox_right && !_done;_x+=16) for(var _y=bbox_top;_y<bbox_bottom;_y+=16) {
            if(scrNTTEFullPathReaches(scrNTTEFullPathCreate(_x+8,_y+8,_sx,_sy,Wall),_sx,_sy,Wall)) {
                var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2
                if(!scrNTTEFullPathReaches(scrNTTEFullPathCreate(_fx,_fy,_cx,_cy,Wall),_cx,_cy,Wall)) {
                    var _tunnel=scrNTTEFullFloorTunnel(_fx,_fy,_cx,_cy)
                    if(instance_exists(_tunnel)) _tunnel.image_yscale*=other.size
                }
                _done=true; break;
            }
        }
    }
    instance_destroy()
}
