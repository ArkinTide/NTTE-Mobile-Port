// tepickups5057..5358. Actual source VaultFlower, not an OrchidChest.
function scrNTTEFullVaultFlowerCreate() {
    spr_idle=scrNTTERefSprite("VaultFlowerIdle");spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("VaultFlowerHurt");spr_dead=scrNTTERefSprite("VaultFlowerDead")
    sprite_index=spr_idle;mask_index=mskBigSkull;max_hp=30;size=3
    skill=mut_last_wish;prompt=noone;unlock=false
    alive=scrNTTEFullSkillGet("reroll")==0 && is_undefined(scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined))
    if(alive) {
        if(scrPlayerCountRace(Race.Plant)>0 && scr_skill_get(mut_heavy_heart)!=0 && !scrNTTEFullUnlockGet("skin:orchid plant")) {
            skill=mut_heavy_heart;unlock=true
        }
        else if(scrNTTEFullSkillGet(skill)==0) {
            var _pool=[]
            for(var _i=0;_i<ds_list_size(GameCont.skills);++_i) {
                var _skill=GameCont.skills[|_i]
                if(_skill!=mut_patience && scrNTTEFullSkillAvailable(_skill)) array_push(_pool,_skill)
            }
            if(array_length(_pool)) skill=_pool[irandom(array_length(_pool)-1)]
        }
        if(scrNTTEFullSkillGet(skill)==0) alive=false
    }
}
function scrNTTEFullVaultFlowerAfterCreate() {
    snd_hurt=sndHitPlant;snd_dead=sndMoneyPileBreak;team=team_enemy
    if(alive) {
        prompt=scrNTTEFullPromptCreate(id,"  REROLL",mskLast,-8,-10)
        prompt.on_meet=method(prompt,scrNTTEFullVaultFlowerPromptMeet)
    }
}
function scrNTTEFullVaultFlowerPan() {
    if(instance_exists(Menu)) return;
    var _scene=asset_get_index("PopoScene")
    if(_scene>=0 && instance_exists(_scene)) return;
    var _focused=false
    with(BackCont) if(instance_exists(scrNTTEFullValue(id,"ntte_full_view_object",noone))) _focused=true
    if(_focused) return;
    // Epsilon shares one camera in local co-op. Follow the camera owner's
    // view once, as view_shift's existing native adapter already requires.
    var _px=0,_py=0,_count=0
    with(Player) if(index==global.index && visible) { _px+=x;_py+=y;_count++ }
    if(_count<=0) return;
    _px/=_count;_py/=_count
    var _distance=point_distance(_px,_py,x,y)
    if(_distance>0) scrNTTEFullViewShift(global.index,point_direction(_px,_py,x,y),min(960/_distance,_distance/3))
}
function scrNTTEFullVaultFlowerInteract(_player) {
    if(!alive || !scrNTTEFullPlayerActive(_player)) return false
    GameCont.ntte_reroll=skill;scrNTTEFullSkillSet("reroll",true)
    if(unlock) scrNTTEFullUnlockSet("skin:orchid plant",true)
    sprite_index=spr_hurt;image_index=0
    var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("Skill.Reroll.HUD"),id)
    _alert.image_speed=0;_alert.snd_flash=sndLevelUp
    for(var _angle=0;_angle<360;_angle+=36) {
        var _length=8+8*dcos(_angle*4),_direction=_angle+orandom(60),
            _fx=instance_create(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),NTTEFullVaultFlowerSparkle)
        _fx.direction=90;_fx.speed=random_range(0.25,1.5)*timescale;_fx.depth=-8
    }
    snd_play(sndStatueXP,0.3,2)
    with(_player) snd_play(snd_crwn)
    return true
}
function scrNTTEFullVaultFlowerDebris(_x,_y,_direction,_velocity) {
    var _debris=instance_create(_x,_y,Feather)
    _debris.sprite_index=scrNTTERefSprite(alive?"VaultFlowerDebris":"VaultFlowerWiltedDebris")
    _debris.image_index=irandom(_debris.image_number-1);_debris.image_angle=orandom(30);_debris.image_speed=0
    _debris.depth=depth-1;_debris.direction=_direction;_debris.speed=_velocity*timescale;_debris.rot*=0.5
    return _debris
}
function scrNTTEFullVaultFlowerStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy();return }
    x=xstart;y=ystart;speed=0
    sprite_index=scrNTTEFullWorldEnemySprite()
    if(alive) {
        if(spr_idle==scrNTTERefSprite("VaultFlowerWiltedIdle")) { spr_idle=scrNTTERefSprite("VaultFlowerIdle");spr_walk=spr_idle }
        if(spr_hurt==scrNTTERefSprite("VaultFlowerWiltedHurt")) spr_hurt=scrNTTERefSprite("VaultFlowerHurt")
        if(spr_dead==scrNTTERefSprite("VaultFlowerWiltedDead")) spr_dead=scrNTTERefSprite("VaultFlowerDead")
        scrNTTEFullVaultFlowerPan()
        if(scrNTTEFullSkillGet(skill)==0 || scrNTTEFullSkillGet("reroll")!=0
            || !is_undefined(scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined))) alive=false
        else if(instance_exists(prompt) && prompt.pick>=0) {
            var _pick=prompt.pick,_player=noone
            with(Player) if(index==_pick) _player=id
            scrNTTEFullVaultFlowerInteract(_player)
        }
        if(random(12)<timescale) {
            var _fx=instance_create(x+orandom(12),y-6+orandom(8),CaveSparkle);_fx.depth=depth-1
        }
    }
    else {
        max_hp=min(9,max_hp);hp=min(hp,max_hp)
        if(spr_idle==scrNTTERefSprite("VaultFlowerIdle")) { spr_idle=scrNTTERefSprite("VaultFlowerWiltedIdle");spr_walk=spr_idle }
        if(spr_hurt==scrNTTERefSprite("VaultFlowerHurt")) spr_hurt=scrNTTERefSprite("VaultFlowerWiltedHurt")
        if(spr_dead==scrNTTERefSprite("VaultFlowerDead")) spr_dead=scrNTTERefSprite("VaultFlowerWiltedDead")
        if(random(150)<timescale) {
            var _debris=scrNTTEFullVaultFlowerDebris(x+orandom(12),y-4+orandom(8),0,0),_dust=instance_create(_debris.x,_debris.y,Dust)
            /* NTTE DUST LIFETIME vault-flower-wilt */ if(instance_exists(_dust)) {_dust.direction=270+orandom(60);_dust.speed=0.5*timescale
            _dust.image_blend=make_color_rgb(84,58,24);_dust.image_xscale/=2;_dust.image_yscale/=2 }
        }
    }
    if(sprite_index==spr_hurt && image_index>=1 && image_index<1+0.4*timescale)
        scrNTTEFullVaultFlowerDebris(x,y,direction+orandom(random(180)),2+random(3.5))
    if(instance_exists(prompt)) prompt.visible=alive
}
function scrNTTEFullVaultFlowerDeath() {
    if(hp>0) return;
    for(var _angle=direction;_angle<direction+360;_angle+=60) {
        var _dust=instance_create(x,y,Dust);/* NTTE DUST LIFETIME vault-flower-death */ if(instance_exists(_dust)) {_dust.direction=_angle+orandom(45);_dust.speed=3*timescale }
        scrNTTEFullVaultFlowerDebris(x,y-6,_angle+orandom(45),4+random(2))
        repeat(2) {
            var _debris=scrNTTEFullVaultFlowerDebris(x,y-6,_angle+orandom(45),random(4));_debris.vspeed-=timescale
        }
    }
    snd_play(sndPlantSnare,0.8,2.5)
    if(alive) {
        scrNTTEFullPetCreate(x,y,"Orchid");GameCont.ntte_vault_flower=false
        repeat(20) {
            var _fx=instance_create(x,y-6,NTTEFullVaultFlowerSparkle)
            _fx.direction=90+orandom(100);_fx.speed=random(4)*timescale;_fx.depth=-7;_fx.friction=0.1*timescale*timescale
            _fx.ntte_sparkle_left=_fx.speed/max(timescale,0.00001)/0.1+random(20)
            _fx.ntte_sparkle_max=_fx.ntte_sparkle_left;_fx.ntte_sparkle_grow=5+_fx.ntte_sparkle_left/3
        }
        snd_play(sndCrystalPropBreak,1.2+random(0.1))
        var _channel=snd_play(sndUncurse,0.5,5)
        if(is_numeric(_channel) && _channel>=0) audio_sound_set_track_position(_channel,0.66)
    }
}
function scrNTTEFullVaultFlowerCleanup() {
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    prompt=noone
}
