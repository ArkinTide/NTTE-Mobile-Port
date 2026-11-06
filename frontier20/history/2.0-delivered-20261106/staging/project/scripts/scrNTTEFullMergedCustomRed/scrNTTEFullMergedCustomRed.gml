// Original tecaves.mod.gml2637..2729 and tegeneral CustomShell1809..1893.
// A source RedBullet owns one closure shared by its replacement descendants.
function scrNTTEFullMergedRedBulletBind(_shot) {
    if(!instance_exists(_shot)) return undefined
    if(variable_instance_exists(_shot,"temerge_red_info")) return _shot.temerge_red_info
    var _info={annihilate_instance_list:[],can_annihilate:true}
    _shot.temerge_red_info=_info
    _shot.temerge_on_setup=scrNTTEFullMergedEffectRef(scrNTTEFullMergedRedBulletSetup,[_info])
    _shot.temerge_on_hit=scrNTTEFullMergedEffectRef(scrNTTEFullMergedRedBulletHit,[_info])
    return _info
}
function scrNTTEFullRedBulletAnnihilate(_target) {
    if(!instance_exists(_target)) return;
    // Original custom Tesseract has the name discriminator (also used by
    // OrchidBall). Props and neutral actors explode locally; enemies register
    // the real two-portal type-wide effect, including future matching spawns.
    if(instance_is(_target,prop) || _target.team==team_none || scrNTTEFullValue(_target,"name","")=="Tesseract") {
        scrNTTEFullSystemsCreate("RedExplosion",x,y)
    }
    else {
        scrNTTEFullAnnihilate(_target,2)
        sleep(150)
    }
}
function scrNTTEFullMergedRedBulletSetup(_info,_list,_unused=undefined) {
    if(!_info.can_annihilate) return;
    var _color=scrAreaGetBackroundColor(scrNTTEFullAreaId("red"))
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) {
        var _shot=_list[_i]
        _shot.image_blend=_color
        array_push(_info.annihilate_instance_list,_shot)
    }
}
function scrNTTEFullMergedRedBulletHit(_info) {
    if(!_info.can_annihilate) return true
    if(!scrNTTEFullMergedProjectileCanHit(other.id) || other.hp<=0) return undefined
    _info.can_annihilate=false
    scrNTTEFullRedBulletAnnihilate(other.id)
    var _self=id
    instance_destroy()
    // Clear all live descendants and add exactly one source-colored poof for
    // each sibling; the consumed physical projectile never gets a second one.
    for(var _i=0;_i<array_length(_info.annihilate_instance_list);++_i) {
        var _shot=_info.annihilate_instance_list[_i]
        if(!instance_exists(_shot)) continue
        if(_shot!=_self) {
            var _fx=instance_create(_shot.x+_shot.hspeed,_shot.y+_shot.vspeed,BulletHit)
            _fx.sprite_index=sprThrowHit;_fx.image_blend=_shot.image_blend;_fx.depth=_shot.depth+1
        }
        _shot.image_blend=c_white
    }
    return true
}
function scrNTTEFullRedBulletCreate() {
    sprite_index=scrNTTERefSprite("RedBullet");image_speed=0.4*timescale
    spr_fade=scrNTTERefSprite("RedBulletDisappear");spr_dead=spr_fade
    mask_index=mskFlakBullet;friction=timescale*timescale
    damage=400;knockback_speed=10*timescale;force=10;typ=1
    bonus=true;bonus_damage=40;minspeed=8;maxspeed=16
    wallbounce=7*scr_skill_get(mut_shotgun_shoulders)
    ntte_red_bonus_alarm=2
    scrNTTEFullMergedRedBulletBind(id)
}
function scrNTTEFullRedBulletStep() {
    if(lockstep_stop) return;
    if(ntte_red_bonus_alarm>0) {
        ntte_red_bonus_alarm-=timescale
        if(ntte_red_bonus_alarm<=0) bonus=false
    }
    image_angle=direction
    if(speed<minspeed*timescale && sprite_index!=spr_fade) {
        sprite_index=spr_fade;image_index=0;image_speed=0.4*timescale
    }
}
function scrNTTEFullRedBulletAnim() {
    if(sprite_index!=spr_fade) {image_speed=0;image_index=image_number-1}
    else instance_destroy()
}
function scrNTTEFullRedBulletHit(_target) {
    if(lockstep_stop || !scr_can_hit(_target)) return;
    scr_projectile_hit(_target,min(damage+bonus_damage*bonus,max(_target.hp,10)),knockback_speed)
    scrNTTEFullRedBulletAnnihilate(_target)
    var _fx=instance_create(x,y,BulletHit)
    _fx.sprite_index=spr_dead
    instance_destroy()
}
function scrNTTEFullRedBulletWall() {
    if(lockstep_stop) return;
    instance_create(x,y,Dust)
    if(speed>minspeed*timescale) snd_play(sndShotgunHitWall,random_range(0.8,1.2))
    if(wallbounce>0 && !bonus) {bonus=true;ntte_red_bonus_alarm=2}
    move_bounce_solid(true)
    image_angle=direction
    speed=min(speed*0.8+wallbounce*timescale,maxspeed*timescale)
    wallbounce*=0.95
}
