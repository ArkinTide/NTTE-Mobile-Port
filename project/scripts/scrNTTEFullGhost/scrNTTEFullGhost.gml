// tescrapyard518..730, tepickups5360..5403. OrchidBall is a systems dependency.
function scrNTTEFullVaultFlowerSparkleCreate() {
    sprite_index=scrNTTERefSprite("VaultFlowerSparkle"); image_angle=random(360)
    image_xscale=0; image_yscale=0; depth=-3; alarm[0]=-1
    ntte_sparkle_left=random_range(10,45); ntte_sparkle_max=ntte_sparkle_left
    ntte_sparkle_grow=5+ntte_sparkle_left/3; ntte_sparkle_scale=random_range(1,1.25); ntte_sparkle_rot=orandom(4)
    ntte_sparkle_started=false
}
function scrNTTEFullVaultFlowerSparkleStep() {
    if (lockstep_stop) return;
    // Source coroutine waits one physical frame before capturing its alarm.
    if (!ntte_sparkle_started) { ntte_sparkle_started=true; return }
    ntte_sparkle_left-=timescale
    if (ntte_sparkle_left<=0) { instance_destroy(); return }
    image_angle+=ntte_sparkle_rot*timescale
    image_xscale=ntte_sparkle_scale
    if (ntte_sparkle_left>ntte_sparkle_grow)
        image_xscale*=1-abs(ntte_sparkle_left-ntte_sparkle_grow)/max(1,abs(ntte_sparkle_max-ntte_sparkle_grow))
    else image_xscale*=ntte_sparkle_left/ntte_sparkle_grow
    image_yscale=image_xscale
}

function scrNTTEFullGhostCreate() {
    spr_idle=scrNTTERefSprite("GhostIdle"); spr_spwn=scrNTTERefSprite("GhostAppear"); spr_dead=scrNTTERefSprite("GhostDisappear")
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=8
    halo_sprite=scrNTTERefSprite("GhostHaloAppear"); halo_index=0
    sprite_index=spr_spwn; image_speed=0.4*timescale; image_index=0; depth=-2
    dark_vertices=12; dark_scale=1/3; wave=random(90)
    prompt=scrNTTEFullPromptCreate(id,"BLESSING",mskShield,0,-10); prompt.visible=false
    snd_play(sndGuardianAppear,0.8,0.6)
    var _sound=snd_play(sndStatueCharge,0.8,0.8)
    if (audio_is_playing(_sound)) audio_sound_set_track_position(_sound,0.5)
    repeat(10) with (instance_create(x,y,NTTEFullVaultFlowerSparkle)) {
        motion_set(random(360),(1+random(3))*timescale)
        depth=other.depth-1; gravity=-0.1*timescale*timescale; friction=0.1*timescale*timescale
    }
}

function scrNTTEFullGhostStep() {
    if (lockstep_stop) return;
    wave+=timescale
    x=xstart+sin(wave/10)*2; y=ystart+cos(wave/10)*2+sin(wave/30)*3
    if (random(5)<timescale) with (instance_create(random_range(bbox_left,bbox_right-1),random_range(bbox_top,bbox_bottom-1),NTTEFullVaultFlowerSparkle)) {
        motion_add(90,random(1)*timescale); depth=other.depth-1
    }
    if (random(30)<timescale && instance_exists(Player)) image_xscale=instance_nearest(x,y,Player).x<x ? -1:1
    if (instance_exists(prompt) && prompt.pick>=0) {
        var _picked=noone,_index=prompt.pick
        with (Player) if (index==_index) _picked=id
        if (scrNTTEFullPlayerActive(_picked)) {
            // Require the actual shared mutation pickup. A missing dependency
            // throws explicitly rather than consuming this one-shot blessing.
            var _orb=scrNTTEFullSystemsCreate("OrchidBall",x,y)
            _orb.skill=mut_last_wish
            sprite_index=spr_dead; image_index=0; dark_scale=5/3
            if (scr_skill_get(mut_strong_spirit)>0 && !_picked.can_spirit) _picked.can_spirit=true
            sleep(20)
            repeat(10) {
                var _l=random_range(16,24),_d=random(360)
                with (instance_create(x+lengthdir_x(_l,_d),y+lengthdir_y(_l,_d),NTTEFullVaultFlowerSparkle)) {
                    motion_set(_d,(1+random(4))*timescale)
                    gravity_direction=direction; gravity=-0.1*timescale*timescale; friction=0.1*timescale*timescale
                }
            }
            snd_play(sndCrownRandom,1,0.2); snd_play(sndGuardianDisappear,0.8,0.6)
            instance_destroy(prompt,false); prompt=noone
        }
    }
    var _end=image_index+image_speed>=image_number
    if (sprite_index==spr_spwn) {
        dark_vertices=max(dark_vertices-timescale,6); dark_scale=lerp(dark_scale,1,1-power(0.8,timescale))
        if (_end) { sprite_index=spr_idle; image_index=0 }
    }
    else if (halo_index<sprite_get_number(halo_sprite)-1) {
        halo_index+=image_speed
        if (halo_index>=sprite_get_number(halo_sprite)-1) {
            halo_index=sprite_get_number(halo_sprite)-1
            if (instance_exists(prompt)) prompt.visible=true
        }
    }
    if (sprite_index==spr_dead) {
        dark_vertices=min(dark_vertices+timescale,12); dark_scale=lerp(dark_scale,0,1-power(0.9,timescale))
        if (_end) {
            with (instance_create(x,y,RecycleGland)) sprite_index=scrNTTERefSprite("GhostHaloDisappear")
            instance_destroy()
        }
    }
}
function scrNTTEFullGhostDraw() {
    draw_self()
    draw_sprite_ext(halo_sprite,halo_index,x,y+sin(wave/10),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullGhostCleanup() {
    if (instance_exists(prompt)) instance_destroy(prompt,false)
}
function scrNTTEFullGhostStatueCreate() {
    spr_idle=scrNTTERefSprite("GhostStatueIdle"); spr_hurt=scrNTTERefSprite("GhostStatueHurt"); spr_dead=scrNTTERefSprite("GhostStatueDead")
    sprite_index=spr_idle; depth=-1; max_hp=30; size=3
}
function scrNTTEFullGhostStatueAfterCreate() {
    snd_hurt=sndHitRock; snd_dead=sndPillarBreak
}
function scrNTTEFullGhostStatueDeath() {
    if (hp>0) return;
    with (instance_create(x,y,Debris)) { sprite_index=scrNTTERefSprite("GhostStatueDebris"); motion_set(random(360),4*timescale) }
    with (instance_create(x,y-16,NTTEFullGhost)) right=other.image_xscale
}

function scrNTTEFullGhostSmoke() {
    var _statue=instance_create(10080,10048,NTTEFullGhostStatue),_before=instance_number(NTTEFullGhost)
    assert(_statue.hp==30 && _statue.size==3,"Ghost statue original30HP/size3 changed")
    _statue.hp=0; instance_destroy(_statue)
    assert(instance_number(NTTEFullGhost)==_before+1,"Destroyed Ghost statue failed to release Ghost")
    var _ghost=instance_find(NTTEFullGhost,instance_number(NTTEFullGhost)-1)
    assert(!_ghost.prompt.visible && _ghost.dark_vertices==12 && _ghost.dark_scale==1/3,"Ghost offered blessing before appear/halo animations")
    _ghost.image_index=sprite_get_number(_ghost.spr_spwn)-0.1
    with (_ghost) scrNTTEFullGhostStep()
    assert(_ghost.sprite_index==_ghost.spr_idle && !_ghost.prompt.visible,"Ghost appearance skipped halo interaction gate")
    _ghost.halo_index=sprite_get_number(_ghost.halo_sprite)-1-0.1
    with (_ghost) scrNTTEFullGhostStep()
    assert(_ghost.prompt.visible,"Ghost halo completion failed to enable blessing")
    var _player=instance_find(Player,0),_spirit=_player.can_spirit,_skill=scr_skill_get(mut_strong_spirit)
    scr_skill_set(mut_strong_spirit,1); _player.can_spirit=false; _ghost.prompt.pick=_player.index
    _before=instance_number(asset_get_index("NTTEFullOrchidBall"))
    with (_ghost) scrNTTEFullGhostStep()
    assert(_ghost.sprite_index==_ghost.spr_dead && !instance_exists(_ghost.prompt) && _player.can_spirit,"Ghost blessing did not consume prompt/restore spirit potential")
    assert(instance_number(asset_get_index("NTTEFullOrchidBall"))==_before+1,"Ghost did not produce one real OrchidBall")
    var _orb=instance_find(asset_get_index("NTTEFullOrchidBall"),instance_number(asset_get_index("NTTEFullOrchidBall"))-1)
    assert(_orb.skill==mut_last_wish,"Ghost blessing did not select Last Wish")
    instance_destroy(_orb,false)
    _before=instance_number(RecycleGland); _ghost.image_index=sprite_get_number(_ghost.spr_dead)-0.1
    with (_ghost) scrNTTEFullGhostStep()
    assert(!instance_exists(_ghost) && instance_number(RecycleGland)==_before+1,"Ghost disappearance failed to clean up and release its halo")
    _player.can_spirit=_spirit; scr_skill_set(mut_strong_spirit,_skill)
    instance_destroy(NTTEFullVaultFlowerSparkle,false)
    scrNTTESmokeLog("FULL WORLD GHOST STATUE30HP/SPAWN + APPEAR/HALO GATE + ONE LAST WISH/STRONG SPIRIT BLESSING + CLEANUP OK")
}
