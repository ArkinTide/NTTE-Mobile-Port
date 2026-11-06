// tecoast4895..5035. Actual becomenemy keeps portals closed until wave ends.
function scrNTTEFullWorldViewSet(_object,_pan=undefined) {
    with (BackCont) { ntte_full_view_object=_object; ntte_full_view_pan_factor=_pan }
}
function scrNTTEFullWorldViewRelease(_object) {
    with (BackCont) if (scrNTTEFullValue(id,"ntte_full_view_object",noone)==_object) { ntte_full_view_object=noone; ntte_full_view_pan_factor=undefined }
}
function scrNTTEFullSealWaveCreate() {
    mask_index=sprPortalClear; direction=random(360); creator=noone; seal_num=4; seal_delay=30; seal_alert=false; floor_dis=16+random(16)
    visible=false
}
function scrNTTEFullSealWaveEndStep() {
    if (lockstep_stop) return;
    if (floor_dis>0) {
        while(distance_to_object(Floor)<floor_dis || place_meeting(x,y,prop)) { x+=lengthdir_x(12,direction); y+=lengthdir_y(12,direction) }
        floor_dis=0
        if (scrNTTEFullPortalPointSeen(x,y,-1)) seal_alert--
    }
    if (seal_delay>0) seal_delay-=timescale
    else if (seal_num>0) {
        seal_num--
        seal_delay=seal_num>0 ? max(4-GameCont.loops*0.5,2)*random_range(1,2):scrNTTEFullValue(creator,"intro_pan",0)
        snd_play(choose(sndOasisHurt,sndOasisMelee,sndOasisShoot,sndOasisChest,sndOasisCrabAttack),0.8+random(0.4))
        var _length=16+random(24),_dir=seal_num*90+orandom(40),_heavy=random(16)<1
        var _seal=instance_create(x+lengthdir_x(_length,_dir),y+lengthdir_y(_length,_dir),_heavy ? NTTEFullSealHeavy:NTTEFullSeal)
        _seal.creator=creator
        if (instance_exists(creator) && variable_instance_exists(creator,"raddrop")) {
            if (creator.raddrop>0) creator.raddrop-=min(_seal.raddrop,creator.raddrop)
            _seal.raddrop=min(_seal.raddrop,creator.raddrop)
        }
        if (!scrNTTEFullValue(creator,"active",false)) {
            // Missing active defaults true in the source's !in || active test.
            if (!instance_exists(creator) || !variable_instance_exists(creator,"active")) { _seal.kills=0; _seal.givekill=false }
        }
        else { _seal.kills=0; _seal.givekill=false }
        if (!_heavy) {
            var _roll=random(GameCont.loops>0 ? 32:16)
            if (_roll<8) _seal.type=NTTEFullSealType.Hookpole
            else if (_roll<13) _seal.type=NTTEFullSealType.Blunderbuss
            else if (_roll<16) _seal.type=NTTEFullSealType.Shield
            else if (_roll<24) _seal.type=NTTEFullSealType.Mercenary
            else if (_roll<29) _seal.type=NTTEFullSealType.Dasher
            else _seal.type=NTTEFullSealType.Deadeye
            if (GameCont.loops>0 && random(2)<1) {
                var _toss=instance_create(_seal.x,_seal.y,NTTEFullPalankingToss),_floor=scrNTTEFullWorldNearestRectBBox(_seal.x,_seal.y,_seal.x,_seal.y,Floor)
                if (instance_exists(_floor)) _toss.direction=point_direction(_toss.x,_toss.y,(_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2)+orandom(30)
                _toss.speed=(4+random(4))*timescale; _toss.creator=_seal; _toss.depth=_seal.depth; _toss.mask_index=_seal.mask_index; _toss.spr_shadow_y=_seal.spr_shadow_y
                snd_play(sndSlugger,1.5,0.6)
                var _water=scrNTTEFullWorldCreateRequired("WaterStreak",_toss.x,_toss.y)
                with (_water) motion_set(point_direction(x,y,x,_toss.z)+orandom(30),(2+random(2))*timescale)
                repeat(4) instance_create(_toss.x,_toss.y,Dust)
            }
        }
        if (seal_alert) {
            seal_alert=false
            var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("SealAlert"),id)
            _alert.blink=15; _alert.flash=6; _alert.snd_flash=sndOasisHorn
        }
    }
    else { scrNTTEFullWorldViewRelease(id); instance_destroy() }
}
function scrNTTEFullSealWaveSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops
    GameCont.loops=0
    var _leader=instance_create(63000,63000,NTTEFullPalankingStatue)
    _leader.raddrop=120; _leader.active=true; _leader.intro_pan=10
    var _wave=instance_create(63000,63000,NTTEFullSealWave)
    _wave.creator=_leader; _wave.floor_dis=0; _wave.seal_delay=0; _wave.seal_alert=true
    var _seals=instance_number(NTTEFullSeal)+instance_number(NTTEFullSealHeavy)
    with (_wave) scrNTTEFullSealWaveEndStep()
    assert(_wave.seal_num==3 && _wave.seal_delay>=4 && _wave.seal_delay<8 && instance_number(NTTEFullSeal)+instance_number(NTTEFullSealHeavy)==_seals+1,"SealWave omitted real first seal/source4..8tick interseal delay")
    repeat(3) { _wave.seal_delay=0; with (_wave) scrNTTEFullSealWaveEndStep() }
    assert(_wave.seal_num==0 && _wave.seal_delay==10 && instance_number(NTTEFullSeal)+instance_number(NTTEFullSealHeavy)==_seals+4,"SealWave omitted four total seals or final source leader intro pan delay")
    with (NTTEFullSeal) if (array_get_index(_before,id)<0) assert(creator==_leader && !givekill && raddrop<=1 && array_get_index([NTTEFullSealType.Hookpole,NTTEFullSealType.Blunderbuss,NTTEFullSealType.Shield],type)>=0,"Nonloop SealWave source pool/leader/rad budget/no free kills changed")
    _wave.seal_delay=0
    scrNTTEFullWorldViewSet(_wave,0.1)
    with (_wave) scrNTTEFullSealWaveEndStep()
    assert(!instance_exists(_wave),"Completed source SealWave retained portal preventer")
    with (BackCont) assert(ntte_full_view_object==noone && is_undefined(ntte_full_view_pan_factor),"SealWave failed to release its own camera follow")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD SEAL WAVE FOUR REAL SEALS/SOURCE NONLOOP WEIGHTED POOL/RAD BUDGET/NO FREE KILLS/INTERSEAL+INTRO DELAY/CAMERA RELEASE+PORTAL PREVENTER LIFETIME OK")
}
