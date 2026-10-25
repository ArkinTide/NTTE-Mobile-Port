// tesewers4382..4586 and tegeneral1714..1817. Native prop, shared Prompt,
// OrchidBall and real merged weapon pickups preserve the original chain.
function scrNTTEFullGatorStatueFX(_x,_y,_direction,_velocity,_object) {
    var _fx=instance_create(_x,_y,_object)
    with(_fx) motion_set(_direction,_velocity*timescale)
    return _fx
}
function scrNTTEFullGatorStatueCreate() {
    spr_idle=scrNTTERefSprite("GatorStatueIdle");spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("GatorStatueHurt");spr_dead=scrNTTERefSprite("GatorStatueDead")
    sprite_index=spr_idle;hitid=[spr_idle,"GATOR STATUE"];depth=-1
    mask_index=mskScorpion;max_hp=56;size=3;skill=mut_shotgun_shoulders
}
function scrNTTEFullGatorStatueAfterCreate() {
    spr_shadow=shd32;spr_shadow_y=7;snd_hurt=sndHitRock;snd_dead=sndWallBreak
    team=team_enemy;raddrop=8
    prompt=scrNTTEFullPromptCreate(id,"BLESSING",mskReviveArea,0,-10)
}
function scrNTTEFullGatorStatueCleanup() {
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    prompt=noone
}
function scrNTTEFullGatorStatueStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy();return }
    speed=0;sprite_index=scrNTTEFullWorldEnemySprite()
    if(!instance_exists(prompt) || prompt.pick<0) return;
    var _player=noone,_index=prompt.pick
    with(Player) if(index==_index) _player=id
    if(!scrNTTEFullPlayerActive(_player)) return;
    prompt.visible=false
    var _orb=scrNTTEFullSystemsCreate("OrchidBall",x,y)
    _orb.skill=skill;_orb.type="portal";_orb.creator=id
    snd_play(sndFlakCannon,0.2,0.3);snd_play(sndGuardianFire,0.2,0.3);snd_play(sndGatorDie,0.2,-0.5)
    with(_player) snd_play(snd_valt)
    sprite_index=spr_hurt;image_index=0
    var _text=instance_create(x+prompt.xoff,y+prompt.yoff-16,PopupText)
    _text.text="BLESSED!";_text.target=_index
}
function scrNTTEFullGatorStatueDeath() {
    var _wepNum=2
    repeat(4) scr_projectile_create(x,y,NTTEFullGatorStatueFlak)
    if(instance_exists(prompt) && prompt.visible) {
        var _shot=scr_projectile_create(x,y,NTTEFullCustomFlak,90,0.1)
        with(_shot) {
            sprite_index=scrNTTERefSprite("EnemySuperFlak");spr_dead=scrNTTERefSprite("EnemySuperFlakHit")
            depth=-1;snd_dead=sndSuperFlakExplode;mask_index=mskSuperFlakBullet
            friction=speed*timescale/60;damage=10;bonus_damage=0;knockback_speed=8*timescale
            typ=2;flak=array_create(5,EnemyFlak);super=true
            var _fx=instance_create(x,y,BulletHit)
            _fx.sprite_index=spr_dead;_fx.friction=friction;_fx.hspeed=hspeed;_fx.vspeed=vspeed
        }
        _wepNum*=2
    }
    repeat(_wepNum) {
        var _avoid=[]
        for(var _w=maxwep;_w>=0;--_w) if(scr_weapon_get_type(_w)!=Ammo.Shells) array_push(_avoid,_w)
        // Source draws the stock first and constrains only the added front.
        with(instance_create(x+orandom(4),y+orandom(4),WepPickup)) {
            ammo=true
            var _stock=scrNTTEFullWeaponDecide(0,max(1,GameCont.hard-1)),
                _front=scrNTTEFullWeaponDecide(0,max(1,GameCont.hard-1),false,_avoid)
            wep=scrNTTEFullWeaponMerge(_stock,_front)
            scrNTTEFullWeaponNativeNormalizePickup()
        }
    }
    scrNTTEFullCoastSoundAt(x,y,sndCrownNo,0.8,0.4)
    scrNTTEFullCoastSoundAt(x,y,sndStatueCharge,0.8,0.4)
    repeat(10) {
        scrNTTEFullGatorStatueFX(x+orandom(16),y+orandom(16),90,1+random(4),Dust)
        scrNTTEFullGatorStatueFX(x,y,random(360),2+random(3),Debris)
        var _shell=scrNTTEFullGatorStatueFX(x,y,random(360),1+random(4),Shell)
        _shell.sprite_index=sprShotShell
    }
    sleep(100)
}
function scrNTTEFullGatorStatueFlakCreate() {
    sprite_index=sprEFlak;image_speed=0.4*timescale;depth=-1;ntte_bloom=0.1
    mask_index=mskFlakBullet;image_xscale=0;image_yscale=0;visible=false
    damage=4;typ=2;grow=1/45;effect_color=make_color_rgb(252,56,0)
    ntte_flak_wait=irandom_range(1,10);alarm[0]=-1
    if(instance_exists(Player)) {
        var _floors=array_shuffle(scrNTTEFullInstances(Floor))
        for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
            if(!place_meeting(x,y,Wall) && distance_to_object(Player)<96 && !place_meeting(x,y,Player)) {
                // Original iterates the entire shuffled array, retaining the
                // last qualifying tile rather than stopping on the first.
                other.x=bbox_center_x;other.y=bbox_center_y
            }
        }
    }
}
function scrNTTEFullGatorStatueFlakActivate() {
    visible=true
    var _hit=instance_create(x,y,ThrowHit);_hit.image_blend=effect_color
    scrNTTEFullCoastSoundAt(x,y,sndServerBreak,2+orandom(0.2),1.2)
}
function scrNTTEFullGatorStatueFlakStep() {
    if(lockstep_stop) return;
    if(ntte_flak_wait>0) {
        ntte_flak_wait-=timescale
        if(ntte_flak_wait<=0) scrNTTEFullGatorStatueFlakActivate()
        return;
    }
    if(visible) {
        image_xscale+=grow*timescale;image_yscale+=grow*timescale
        var _scale=max(image_xscale,image_yscale)
        if(random(1)<1-power(1-1/2,timescale)) {
            var _trail=scrNTTEFullGatorStatueFX(x,y,random(360),random_range(2,5)*_scale,PlasmaTrail)
            _trail.sprite_index=scrNTTERefSprite("QuasarBeamTrail")
        }
        if(_scale>1) instance_destroy()
    }
}
// The source asks sprite_get_team, not the gameplay team. A deflected shot
// can intentionally retain hostile artwork; this adapter preserves that.
function scrNTTEFullCustomFlakSpriteTeam(_inst,_sprite) {
    var _friendly=(_sprite==sprFlakBullet || _sprite==sprSuperFlakBullet)
    var _hostile=(_sprite==sprEFlak || _sprite==scrNTTERefSprite("EnemySuperFlak"))
    if(_friendly || _hostile) scrNTTEFullPetTwinsTeam(_inst,_friendly?team_player:team_enemy)
    return _inst
}
function scrNTTEFullGatorStatueFlakDestroy() {
    var _shot=scr_projectile_create(x,y,EnemyFlak)
    scrNTTEFullCustomFlakSpriteTeam(_shot,sprite_index)
}
function scrNTTEFullGatorStatueFlakHit(_target) {
    // Original CustomProjectile default Hit: outer team gate, native can-hit,
    // hit then Destroy. Invisible charging flak retains the default collider.
    if(team==_target.team || !scr_can_hit(_target)) return;
    scr_projectile_hit(_target,damage,knockback_speed);instance_destroy()
}
function scrNTTEFullCustomFlakCreate() {
    sprite_index=sprFlakBullet;spr_dead=sprFlakHit;ntte_bloom=0.1;snd_dead=sndFlakExplode
    mask_index=mskFlakBullet;friction=0.4*timescale*timescale;damage=4;knockback_speed=6*timescale
    typ=1;bonus=true;bonus_damage=2;flak=array_create(16,Bullet2);super=false
    ntte_flak_bonus_wait=2;alarm[2]=-1
}
function scrNTTEFullCustomFlakStep() {
    if(lockstep_stop) return;
    if(ntte_flak_bonus_wait>0) {
        ntte_flak_bonus_wait-=timescale
        if(ntte_flak_bonus_wait<=0) bonus=false
        return;
    }
    if(super || random(1)<1-power(1-1/3,timescale))
        scrNTTEFullGatorStatueFX(x+orandom(3*super),y+orandom(3*super),random(360),random(2),Smoke)
    image_speed=speed/12
    if(speed==0 || place_meeting(x,y,Explosion)) instance_destroy()
}
function scrNTTEFullCustomFlakHit(_target) {
    if(team==_target.team || !scr_can_hit(_target)) return;
    sleep(30);scr_projectile_hit(_target,damage+bonus_damage*bonus,knockback_speed);instance_destroy()
}
function scrNTTEFullCustomFlakDestroy() {
    var _dir=random(360),_flak=flak,_count=array_length(_flak)
    for(var _i=0;_i<_count;++_i) {
        var _entry=_flak[_i]
        if(!is_struct(_entry)) _entry=is_array(_entry)?{flak:_entry}:{object_index:_entry}
        var _shot=scr_projectile_create(x+scrNTTEFullValue(_entry,"x",0),y+scrNTTEFullValue(_entry,"y",0),
            scrNTTEFullValue(_entry,"object_index",NTTEFullCustomFlak),
            scrNTTEFullValue(_entry,"direction",super?_dir+360*(_i/_count):random(360)),
            scrNTTEFullValue(_entry,"speed",super?12:random_range(8,16)))
        var _names=variable_struct_get_names(_entry)
        for(var _j=0;_j<array_length(_names);++_j) {
            var _key=_names[_j]
            if(_key!="object_index") variable_instance_set(_shot,_key,variable_struct_get(_entry,_key))
        }
        scrNTTEFullCustomFlakSpriteTeam(_shot,sprite_index)
        scrNTTEFullWeaponMimicProjectileSetup(_shot,id)
    }
    var _num=1+super
    repeat(6*_num) scrNTTEFullGatorStatueFX(x,y,random(360),random(3),Smoke)
    var _hit=instance_create(x,y,BulletHit);_hit.sprite_index=spr_dead
    snd_play_hit_big(snd_dead,0.2);scrNTTEFullTrenchShake(x,y,6*_num);sleep(10*_num)
}
