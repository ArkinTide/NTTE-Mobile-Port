// telabs989..1153 / tecoast2806..2915. Source Igloo and Palanking statue.
function scrNTTEFullWorldPickupDrop(_pickup,_weapon,_index=undefined) {
    if (!variable_global_exists("ntte_full_pickup_drop") || !is_callable(global.ntte_full_pickup_drop))
        throw "Original NTT pickup_drop adapter must be installed before world deaths are enabled"
    // The common provider owns the native NTT seed-index semantics.
    return global.ntte_full_pickup_drop(id,_pickup,_weapon,_index)
}
function scrNTTEFullIglooCreate() {
    front=random(3)<1; ntte_igloo_face_scale=undefined
    with (NTTEFullPalankingStatue) {
        if (other.x>=bbox_left && other.x<bbox_right) { if (y>other.y) other.front=true }
        else if (other.y>=bbox_top && other.y<bbox_bottom) {
            other.front=false
            if (other.x!=x) other.ntte_igloo_face_scale=sign(x-other.x)
        }
    }
    var _prefix=front ? "IglooFront":"IglooSide"
    spr_idle=scrNTTERefSprite(_prefix+"Idle"); spr_hurt=scrNTTERefSprite(_prefix+"Hurt"); spr_dead=scrNTTERefSprite(_prefix+"Dead")
    sprite_index=spr_idle; depth=-1; mask_index=-1; max_hp=30; size=2
    num=irandom_range(5,6); type=irandom_range(4,6); alert=true; chest=random(5)<1; ntte_igloo_timer=irandom_range(150,240)
}
function scrNTTEFullIglooAfterCreate() {
    snd_hurt=sndHitRock; snd_dead=sndSnowmanBreak; team=team_enemy
    if (!is_undefined(ntte_igloo_face_scale)) image_xscale=ntte_igloo_face_scale
    var _prevent=instance_create(0,0,NTTEFullPortalPrevent)
    _prevent.creator=id
}
function scrNTTEFullIglooAlert(_flash=3,_rise=0) {
    var _a=scrNTTEAlertCreate(x,y,scrNTTERefSprite("SealArcticAlert"),id)
    _a.flash=_flash; _a.vspeed=_rise*timescale
    if (chest) { _a.alert_sprite=sprBreath; _a.alert_x=1; _a.alert_y=2 }
    return _a
}
function scrNTTEFullIglooSpawn() {
    var _seal=instance_create(x,y,NTTEFullSeal)
    _seal.type=choose(type,4)
    return _seal
}
function scrNTTEFullIglooRelease() {
    if (num<=0) return;
    ntte_igloo_timer=60+random(60)
    if (!instance_exists(Player)) return;
    if (!alert || random(16)<num) {
        num--
        if (alert) ntte_igloo_timer+=random(30)
        else ntte_igloo_timer=2+random(3)
        scrNTTEFullIglooSpawn()
    }
    if (alert) {
        var _player=instance_nearest(x,y,Player),_enemy=instance_nearest(x,y,enemy)
        if (hp<max_hp || !instance_exists(_enemy) || point_distance(x,y,_player.x,_player.y)<point_distance(x,y,_enemy.x,_enemy.y)) {
            alert=false; ntte_igloo_timer=30; scrNTTEFullIglooAlert(ntte_igloo_timer)
        }
    }
}
function scrNTTEFullIglooStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (ntte_igloo_timer>0) {
        ntte_igloo_timer-=timescale
        if (ntte_igloo_timer<=0) { ntte_igloo_timer=-1; scrNTTEFullIglooRelease() }
    }
    if (num<=0) with (NTTEFullPortalPrevent) if (creator==other.id) instance_destroy()
    if (sprite_index==spr_hurt && image_index+image_speed>=image_number) sprite_index=spr_idle
}
function scrNTTEFullIglooDeath() {
    if (hp>0) return;
    if (num>0) {
        repeat(num) scrNTTEFullIglooSpawn()
        if (alert) scrNTTEFullIglooAlert(3,-3)
    }
    if (chest) {
        var _num=1+scr_skill_get(mut_open_mind)
        repeat(max(0,_num)) {
            var _object=random(5)<1 ? "Backpack":choose(WeaponChest,AmmoChest)
            if (scrCrownCheck(crwn_life) && random(3)<2) _object=HealthChest
            var _chest=scrNTTEFullLairChestCreate(x,y,_object)
            with (_chest) motion_add(random(360),timescale)
        }
    }
    else for(var _i=0;_i<2;++_i) scrNTTEFullWorldPickupDrop(50,20,_i)
    for(var _dir=0;_dir<360;_dir+=360/(12+num)) {
        with (instance_create(x+orandom(4),y+6+orandom(4),Smoke)) {
            motion_set(_dir+orandom(10),random_range(1,3)*timescale)
            sprite_index=sprSnowFlake; image_index=irandom(image_number-1); image_xscale*=2; image_yscale*=2
            vspeed-=1.5*timescale; gravity=0.085*timescale*timescale
        }
    }
    snd_play(sndMaggotSpawnDie,1.2+random(0.2),7)
}
function scrNTTEFullPalankingStatueCreate() {
    phase=0; spr_idle=scrNTTERefSprite("PalankingStatueIdle",phase); spr_hurt=scrNTTERefSprite("PalankingStatueHurt",phase)
    spr_dead=scrNTTERefSprite("PalankingStatueDead"); sprite_index=spr_idle
    mask_index=sprPortalClear; max_hp=240; size=4
}
function scrNTTEFullPalankingStatueAfterCreate() { snd_hurt=sndHitRock; snd_dead=sndPillarBreak; team=team_enemy }
function scrNTTEFullPalankingStatueChunk(_x,_y,_dir,_speed,_zspeed) {
    var _chunk=instance_create(_x,_y,ScrapBossCorpse)
    with (_chunk) {
        motion_set(_dir,_speed*timescale); sprite_index=scrNTTERefSprite("PalankingStatueChunk")
        image_index=irandom(image_number-1); friction=0.2*timescale*timescale
    }
    var _bag=instance_create(_x,_y,NTTEFullBackpackPickup)
    _bag.target=_chunk; _bag.zfriction=0.6; _bag.zspeed=_zspeed; _bag.speed=_speed*timescale
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    return _chunk
}
function scrNTTEFullPalankingStatueStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (sprite_index==spr_hurt) {
        var _phase=floor(4-(hp/max_hp)*4)
        while(phase<_phase) {
            phase++; spr_idle=scrNTTERefSprite("PalankingStatueIdle",phase); spr_hurt=scrNTTERefSprite("PalankingStatueHurt",phase); sprite_index=spr_hurt
            repeat(3) scrNTTEFullPalankingStatueChunk(x,y,random(360),random_range(2,5),random_range(4,5))
            snd_play(scrNTTERefSound("PalankingHurt"),0.7+random(0.2),0.5)
        }
        if (image_index+image_speed>=image_number) sprite_index=spr_idle
    }
}
function scrNTTEFullPalankingStatueDeath() {
    if (hp>0) return;
    team=2
    for(var _dir=0;_dir<360;_dir+=90) {
        scr_projectile_create(x+lengthdir_x(16,_dir)+orandom(32),y+lengthdir_y(16,_dir)+orandom(32),NTTEFullBubbleExplosion)
        scr_projectile_create(x,y,NTTEFullHyperBubble,_dir,4)
    }
    for(var _i=0;_i<3;++_i) scrNTTEFullWorldPickupDrop(100,10,_i)
    snd_play(scrNTTERefSound("PalankingDead"),0.7+random(0.2),0.5)
    repeat(5) scrNTTEFullPalankingStatueChunk(x,y,random(360),random_range(1,3),random_range(6,10))
    var _vx=view_xview+view_width/2,_vy=view_yview+view_height/2
    scrNTTEFullViewShift(global.index,point_direction(_vx,_vy,x,y),point_distance(_vx,_vy,x,y)*1.5)
    sleep(100)
}
function scrNTTEFullSealSettlementSmoke() {
    var _before=scrNTTEFullInstances(all)
    var _statue=instance_create(51000,51000,NTTEFullPalankingStatue),_chunks=instance_number(ScrapBossCorpse)
    assert(_statue.hp==240 && _statue.size==4 && _statue.mask_index==sprPortalClear && _statue.team==team_enemy,"Palanking statue source hp/mask/size/team changed")
    _statue.hp=110; _statue.sprite_index=_statue.spr_hurt
    with (_statue) scrNTTEFullPalankingStatueStep()
    assert(_statue.phase==2 && _statue.spr_idle==scrNTTERefSprite("PalankingStatueIdle",2) && instance_number(ScrapBossCorpse)==_chunks+6,"Palanking statue omitted intermediate phase art/three launched chunks per threshold")
    var _igloo=instance_create(51000,50940,NTTEFullIgloo)
    assert(_igloo.front && _igloo.hp==30 && _igloo.size==2 && _igloo.team==team_enemy && _igloo.num>=5 && _igloo.num<=6 && _igloo.type>=4 && _igloo.type<=6,"Igloo source statue-facing/stats/population changed")
    assert(_igloo.ntte_igloo_timer>=150 && _igloo.ntte_igloo_timer<=240,"Igloo original initial 150..240tick timer changed")
    var _prevent=noone
    with (NTTEFullPortalPrevent) if (creator==_igloo) _prevent=id
    assert(instance_exists(_prevent),"Igloo did not prevent portals while it has remaining seals")
    // Call actual burst release with source alert=false, when a player exists.
    if (instance_exists(Player)) {
        var _n=instance_number(NTTEFullSeal),_num=_igloo.num
        _igloo.alert=false
        with (_igloo) scrNTTEFullIglooRelease()
        assert(instance_number(NTTEFullSeal)==_n+1 && _igloo.num==_num-1 && _igloo.ntte_igloo_timer>=2 && _igloo.ntte_igloo_timer<5,"Igloo did not release one real Seal at source burst cadence")
    }
    _igloo.num=0
    with (_igloo) scrNTTEFullIglooStep()
    assert(!instance_exists(_prevent),"Empty Igloo retained portal lock")
    _igloo.chest=true
    var _a=noone
    with (_igloo) _a=scrNTTEFullIglooAlert(30)
    assert(_a.sprite_index==scrNTTERefSprite("SealArcticAlert") && _a.alert_sprite==sprBreath && _a.alert_x==1 && _a.alert_y==2 && _a.flash==30,"Igloo original seal portrait/chest breath overlay/flash changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD IGLOO STATUE FACING/30HP/5..6 SEALS/ALERT/BURST/PORTAL LOCK RELEASE + PALANKING STATUE 240HP/FOUR PHASES/REAL LAUNCHED CHUNKS OK; DEATH PICKUPS REQUIRE SHARED NTT DROP ADAPTER")
}
function scrNTTEFullSealSettlementDeathSmoke() {
    var _before=scrNTTEFullInstances(all)
    scrNTTEFullPickupDropInit()
    var _igloo=instance_create(59000,59000,NTTEFullIgloo),_seals=instance_number(NTTEFullSeal),_flakes=0
    with (Smoke) if (sprite_index==sprSnowFlake) _flakes++
    _igloo.num=2; _igloo.chest=false; _igloo.alert=true; _igloo.hp=0
    instance_destroy(_igloo)
    var _newflakes=0
    with (Smoke) if (sprite_index==sprSnowFlake) _newflakes++
    assert(instance_number(NTTEFullSeal)==_seals+2 && _newflakes==_flakes+14,"Igloo death omitted all remaining real seals or12+num snowflakes")
    var _statue=instance_create(59200,59000,NTTEFullPalankingStatue),_bubbles=instance_number(NTTEFullBubbleExplosion),_hypers=instance_number(NTTEFullHyperBubble),_chunks=instance_number(ScrapBossCorpse)
    _statue.hp=0
    instance_destroy(_statue)
    assert(instance_number(NTTEFullBubbleExplosion)==_bubbles+4 && instance_number(NTTEFullHyperBubble)==_hypers+4 && instance_number(ScrapBossCorpse)==_chunks+5,"Palanking statue death omitted source four explosions/four hyper bubbles/five launched chunks")
    with (NTTEFullHyperBubble) if (array_get_index(_before,id)<0) assert(team==2,"Palanking statue death lost original team2 hazards")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD IGLOO ACTUAL DEATH/REMAINING SEALS/14SNOWFLAKES/REAL NTT DROP ADAPTER + STATUE ACTUAL DEATH/FOUR BUBBLE+HYPER/TEAM2/FIVE BALLISTIC CHUNKS OK")
}
