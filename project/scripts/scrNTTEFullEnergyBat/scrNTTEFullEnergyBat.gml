// Original tecaves.mod.gml2029..2178 and4503..4692.
function scrNTTEFullEnergyBatCreate() {
    var _skill=scr_skill_get(mut_laser_brain)
    sprite_index=scrNTTERefSprite("EnergyBatSlash")
    image_speed=0.4/(_skill>0?1+_skill:power(2,_skill))*timescale
    mask_index=mskSlash;damage=18;force=12;knockback_speed=force*timescale
    typ=0;walled=false;ntte_custom_slash=true;candeflect=true
}
function scrNTTEFullEnergyBatHit(_victim) {
    // Recovered original melee CanHit compares teams and nexthurt only.
    if(lockstep_stop || !instance_exists(_victim) || _victim.team==team || _victim.nexthurt>current_frame) return;
    scr_projectile_hit(_victim,damage,knockback_speed)
}
function scrNTTEFullEnergyBatWall(_wall) {
    if(lockstep_stop || walled) return;
    walled=true;x+=hspeed;y+=vspeed
    var _cx=bbox_center_x,_cy=bbox_center_y,
        _color=image_yscale>0?c_lime:c_white,_target=_wall
    if(instance_is(_wall,Wall)) {
        var _walls=scrNTTEFullInstances(Wall),_best=infinity
        _target=noone
        for(var _i=0;_i<array_length(_walls);++_i) {
            var _candidate=_walls[_i]
            if(!place_meeting(x,y,_candidate)) continue
            var _dx=max(_candidate.bbox_left-_cx,0,_cx-_candidate.bbox_right),
                _dy=max(_candidate.bbox_top-_cy,0,_cy-_candidate.bbox_bottom),_distance=_dx*_dx+_dy*_dy
            if(_distance<_best) {_best=_distance;_target=_candidate}
        }
    }
    if(instance_exists(_target)) {
        var _fx=instance_create((_target.bbox_left+_target.bbox_right)/2,(_target.bbox_top+_target.bbox_bottom)/2,MeleeHitWall)
        _fx.image_angle=point_direction(_cx,_cy,_fx.x,_fx.y);_fx.image_blend=_color
        with(_fx) snd_play_hit(sndMeleeWall,0.3)
    }
    x-=hspeed;y-=vspeed
}
function scrNTTEFullEnergyBatProjectile(_projectile) {
    if(lockstep_stop || !instance_exists(id) || !instance_exists(_projectile)) return;
    // CustomSlash parent collision gate is applied by this native entry.
    if(_projectile.team==team || (_projectile.typ!=1 && _projectile.typ!=2)) return;
    var _x=_projectile.x,_y=_projectile.y,_depth=_projectile.depth,_damage=_projectile.damage,
        _target=_projectile.creator,_tx=_projectile.xstart,_ty=_projectile.ystart,
        _deflect=_projectile.typ==1 && candeflect,_before=scrNTTEFullInstances(projectile)
    if(_deflect) _projectile.deflected=true
    // Destroy events deliberately execute: rockets/cannons create their true
    // descendants. Source detects those descendants, rather than guessing
    // cannon status from damage or the incoming object's name.
    instance_destroy(_projectile)
    var _cannon=false,_after=scrNTTEFullInstances(projectile)
    for(var _i=0;_i<array_length(_after);++_i) {
        var _child=_after[_i]
        if(array_get_index(_before,_child)>=0) continue
        _cannon=true
        if(_deflect) instance_destroy(_child,false)
        else break
    }
    if(!instance_exists(id)) return;
    if(_deflect) {
        var _vlasma=scrNTTEFullMergedBasicProjectileCreate(_x,_y,_cannon?NTTEFullVlasmaCannon:NTTEFullVlasmaBullet,direction,speed/timescale+2)
        _vlasma.target=_target;_vlasma.target_x=_tx;_vlasma.target_y=_ty
        if(_cannon) _vlasma.cannon=_damage*1.5
    }
    var _impact=scrNTTEFullMergedBasicProjectileCreate(_x,_y,_cannon?PlasmaImpact:NTTEFullPlasmaImpactSmall)
    _impact.depth=_depth
    var _brain=instance_is(_impact.creator,Player) && scr_skill_get(mut_laser_brain)>0,
        _sounds=[[sndPlasma,sndPlasmaUpg],[sndPlasmaBig,sndPlasmaBigUpg]]
    scrNTTEFullMergedBasicSoundAt(_x,_y,_sounds[_cannon][_brain],random_range(0.7,1.3),0.6,320)
    if(_cannon) sleep(10*_damage)
}
function scrNTTEFullVlasmaCreate() {
    sprite_index=scrNTTERefSprite("VlasmaBullet");image_speed=0.4*timescale;depth=-9
    mask_index=mskEnemyBullet1;damage=2;force=1;knockback_speed=timescale;typ=1
    maxspeed=8;addspeed=0.4;target=noone;target_x=x;target_y=y;my_sound=-1
    cannon=0;wall_frame=0;setup=true
}
function scrNTTEFullVlasmaCannonCreate() {
    sprite_index=scrNTTERefSprite("VlasmaCannon");damage=4;cannon=6
}
function scrNTTEFullVlasmaSetup() {
    setup=false
    if(instance_is(creator,Player)) {
        var _skill=scr_skill_get(mut_laser_brain)
        image_xscale*=power(1.2,_skill);image_yscale*=power(1.2,_skill);damage*=power(2,_skill)
    }
}
function scrNTTEFullVlasmaTeam(_instance,_source_sprite) {
    if(!instance_exists(_instance)) return _instance
    var _friendly=["VlasmaBullet","VlasmaCannon","PlasmaImpactSmall"],
        _hostile=["EnemyVlasmaBullet","EnemyVlasmaCannon","EnemyPlasmaImpactSmall"],
        _popo=["PopoVlasmaBullet","PopoVlasmaCannon","PopoPlasmaImpactSmall"],_group=1
    for(var _i=0;_i<array_length(_friendly);++_i) {
        if(_source_sprite==scrNTTERefSprite(_hostile[_i])) _group=0
        if(_source_sprite==scrNTTERefSprite(_popo[_i])) _group=2
    }
    if(_source_sprite==scrNTTERefSprite("EnemyPlasmaImpact") || _source_sprite==scrNTTERefSprite("EnemyPlasmaTrail")) _group=0
    if(_source_sprite==sprPopoPlasmaImpact || _source_sprite==sprPopoPlasmaTrail) _group=2
    for(var _i=0;_i<array_length(_friendly);++_i) {
        var _spr=_instance.sprite_index
        if(_spr==scrNTTERefSprite(_friendly[_i]) || _spr==scrNTTERefSprite(_hostile[_i]) || _spr==scrNTTERefSprite(_popo[_i])) {
            var _sprites=_group==0?_hostile:(_group==2?_popo:_friendly)
            _instance.sprite_index=scrNTTERefSprite(_sprites[_i]);return _instance
        }
    }
    if(_instance.sprite_index==sprPlasmaImpact || _instance.sprite_index==scrNTTERefSprite("EnemyPlasmaImpact") || _instance.sprite_index==sprPopoPlasmaImpact)
        _instance.sprite_index=_group==0?scrNTTERefSprite("EnemyPlasmaImpact"):(_group==2?sprPopoPlasmaImpact:sprPlasmaImpact)
    if(_instance.sprite_index==sprPlasmaTrail || _instance.sprite_index==scrNTTERefSprite("EnemyPlasmaTrail") || _instance.sprite_index==sprPopoPlasmaTrail)
        _instance.sprite_index=_group==0?scrNTTERefSprite("EnemyPlasmaTrail"):(_group==2?sprPopoPlasmaTrail:sprPlasmaTrail)
    return _instance
}
function scrNTTEFullVlasmaStep() {
    if(lockstep_stop) return;
    if(setup) scrNTTEFullVlasmaSetup()
    if(instance_exists(target)) {
        target_x=target.x;target_y=target.y
        if(target==creator && variable_instance_exists(creator,"gunangle")) {
            var _length=variable_instance_exists(creator,"spr_weap")
                ?sprite_get_width(creator.spr_weap)-sprite_get_xoffset(creator.spr_weap):16
            target_x+=lengthdir_x(_length,creator.gunangle);target_y+=lengthdir_y(_length,creator.gunangle)
        }
    }
    var _distance=point_distance(x,y,target_x,target_y)
    if(image_speed==0) {
        var _hostile=instance_exists(creator)?instance_is(creator,enemy):team!=team_player,
            _euphoria=_hostile?power(0.8,scr_skill_get(mut_euphoria)):1,
            _maximum=maxspeed*_euphoria*timescale,_add=addspeed*_euphoria*timescale*timescale
        speed+=clamp(_maximum-speed,-_add,_add)
        var _turn=angle_difference(point_direction(x,y,target_x,target_y),direction)
        _turn*=clamp((speed/timescale)/_distance,0.1,1);_turn*=min(timescale,1)
        direction+=_turn;image_angle+=_turn
    }
    if(random(4)<timescale) {
        var _trail=scrNTTEFullMergedStockFX([x,4],[y,4],[direction,2*(speed/timescale/maxspeed)],PlasmaTrail)
        _trail.depth=depth;scrNTTEFullVlasmaTeam(_trail,sprite_index)
    }
    if(image_speed==0 && (_distance<=8+speed || (instance_exists(target)
        && (!variable_instance_exists(target,"team") || team!=target.team) && place_meeting(x,y,target)))) instance_destroy()
}
function scrNTTEFullVlasmaAnim() { image_index=image_number-1;image_speed=0 }
function scrNTTEFullVlasmaHit(_victim) {
    if(lockstep_stop || image_speed!=0 || !scrNTTEFullNativeProjectileCanHitNP(_victim)
        || (!instance_is(_victim,Player) && !current_frame_active)) return;
    scrNTTEFullNativeProjectileHitNP(_victim,damage,knockback_speed/timescale,40)
}
function scrNTTEFullVlasmaWall() {
    if(wall_frame!=current_frame && x==xprevious && y==yprevious) {
        wall_frame=current_frame;x+=hspeed;y+=vspeed;xprevious=x;yprevious=y
    }
}
function scrNTTEFullVlasmaDraw() {
    draw_self();gpu_set_blendmode(bm_add)
    draw_sprite_ext(sprite_index,image_index,x,y,2*image_xscale,2*image_yscale,image_angle,image_blend,0.1*image_alpha)
    gpu_set_blendmode(bm_normal)
}
function scrNTTEFullVlasmaDestroy() {
    if(my_sound>=0) audio_stop_sound(my_sound)
    snd_play_hit(sndLightningHit,0.2)
    scrNTTEFullMergedBasicSoundAt(x,y,sndLaser,1.1+random(0.3),1,320)
    if(cannon>0) {
        for(var _i=0;_i<cannon;++_i) {
            var _dir=direction+360*_i/cannon,
                _shot=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(96,_dir),y+lengthdir_y(96,_dir),NTTEFullVlasmaBullet,_dir+180)
            _shot.target=target;_shot.target_x=target_x;_shot.target_y=target_y
            scrNTTEFullVlasmaTeam(_shot,sprite_index)
        }
        scrNTTEFullMergedBasicSoundAt(x,y,sndPlasmaHit,0.6+random(0.2),4,320)
    }
    var _impact=scrNTTEFullMergedBasicProjectileCreate(x,y,cannon>0?PlasmaImpact:NTTEFullPlasmaImpactSmall)
    _impact.depth=depth;scrNTTEFullVlasmaTeam(_impact,sprite_index)
}
