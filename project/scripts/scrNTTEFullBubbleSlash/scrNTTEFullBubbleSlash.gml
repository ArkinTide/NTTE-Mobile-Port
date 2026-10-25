// Original teoasis.mod.gml711..849. Uses existing physical BubbleBomb and
// explosion classes, without altering accepted weapon pickup behavior.
function scrNTTEFullBubblePopCreate() {
    // Original OBJT394: Effect parent, sprite492=sprPlayerBubblePop, depth1.
    // Its native Create calls image_speed_set(0.4), with no random motion.
    sprite_index=sprPlayerBubblePop;image_speed=0.4*timescale;depth=1
}
function scrNTTEFullBubbleSlashCreate() {
    sprite_index=scrNTTERefSprite("BubbleSlash");image_speed=0.4*timescale
    mask_index=mskSlash;damage=16;force=12;knockback_speed=force*timescale
    typ=0;walled=false;candeflect=true;ntte_custom_slash=true
}
function scrNTTEFullBubbleSlashProjectile(_shot) {
    if(lockstep_stop || !instance_exists(id) || !instance_exists(_shot)
        || _shot.team==team || (_shot.typ!=1 && _shot.typ!=2)) return;
    if(_shot.typ==1 && candeflect) {
        _shot.deflected=true;_shot.team=team;_shot.direction=direction;_shot.image_angle=direction
        var _fx=instance_create(_shot.x,_shot.y,Deflect);_fx.image_angle=_shot.image_angle
        if(!scrNTTEFullValue(_shot,"bubble_bombed",false)) {
            _shot.bubble_bombed=true
            var _bomb=scrNTTEFullMergedBasicProjectileCreate(_shot.x,_shot.y,NTTEFullBubbleBomb)
            array_push(_bomb.held,_shot)
            _fx=instance_create(_shot.x,_shot.y,Bubble)
            _fx.image_xscale=0.75;_fx.image_yscale=0.75;_fx.image_angle=random(360)
            _fx=instance_create(_shot.x,_shot.y,NTTEFullBubblePop)
            _fx.image_index=1;_fx.image_xscale=0.8;_fx.image_yscale=0.8
            _fx.image_angle=random(360);_fx.depth=_shot.depth-1
        }
    }
    else {
        scrNTTEFullMergedBasicProjectileCreate(_shot.x,_shot.y,_shot.damage<6?NTTEFullBubbleExplosionSmall:NTTEFullBubbleExplosion)
        instance_destroy(_shot)
    }
}
function scrNTTEFullBubbleSlashHit(_victim) {
    if(lockstep_stop || !instance_exists(_victim) || _victim.team==team || _victim.nexthurt>current_frame) return;
    var _slash=id
    scrNTTEFullNativeProjectileHitPush(_victim,damage,knockback_speed/timescale)
    if(!instance_exists(_victim)) return;
    var _size=_victim.size,_bubbles=clamp(_size*2,1,6)
    repeat(_bubbles) {
        var _bubble=instance_create(x,y,Bubble)
        with(_bubble) {
            motion_add(_victim.direction+orandom(12),(irandom(3)+2)*timescale)
            friction=0.1*timescale*timescale;image_xscale=0.75;image_yscale=0.75;image_angle=random(360)
        }
    }
    if(_size>0) {
        var _pop=instance_create(_victim.x,_victim.y,NTTEFullBubblePop)
        _pop.sprite_index=_size<2?sprPlayerBubblePop:scrNTTERefSprite("BigBubblePop")
        _pop.image_index=1;_pop.image_angle=random(360);_pop.depth=_victim.depth-1
        if(_victim.hp<=0) {scrNTTEFullTrenchShake(_victim.x,_victim.y,5);sleep(12)}
    }
}
function scrNTTEFullBubbleSlashWall(_wall) {
    if(lockstep_stop || walled) return;
    walled=true;x+=hspeed;y+=vspeed
    var _cx=bbox_center_x,_cy=bbox_center_y,_target=_wall
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
        _fx.image_angle=point_direction(_cx,_cy,_fx.x,_fx.y)
        scrNTTEFullMergedBasicSoundAt(_fx.x,_fx.y,sndMeleeWall,1.6+random(0.3),0.8,320)
    }
    x-=hspeed;y-=vspeed
}
function scrNTTEFullBubbleSlashTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false;current_frame=2
    try {
        var _owner=instance_find(Player,0),_slash=noone
        with(_owner) _slash=scrNTTEFullMergedBasicProjectileCreate(86000,86000,NTTEFullBubbleSlash,45,2)
        assert(_slash.damage==16 && _slash.mask_index==mskSlash && _slash.knockback_speed==12*timescale
            && _slash.typ==0 && _slash.candeflect && _slash.image_speed==0.4*timescale,
            "BubbleSlash original CustomSlash stats/mask/animation changed")
        var _plain_pop=instance_create(85900,86000,NTTEFullBubblePop)
        assert(_plain_pop.sprite_index==sprPlayerBubblePop && _plain_pop.image_speed==0.4*timescale
            && _plain_pop.depth==1 && _plain_pop.speed==0,"Actual BubblePop source defaults changed")
        with(_plain_pop) event_perform(ev_other,ev_animation_end)
        assert(!instance_exists(_plain_pop),"Actual BubblePop animation did not finish")
        var _enemy=instance_create(86020,86000,EnemyBullet1)
        _enemy.team=team_enemy;_enemy.creator=noone;_enemy.depth=-4
        var _bombs=instance_number(NTTEFullBubbleBomb),_deflects=instance_number(Deflect)
        with(_slash) scrNTTEFullBubbleSlashProjectile(_enemy)
        assert(instance_exists(_enemy) && _enemy.team==_slash.team && _enemy.direction==45
            && _enemy.image_angle==45 && _enemy.deflected && _enemy.bubble_bombed
            && instance_number(NTTEFullBubbleBomb)==_bombs+1 && instance_number(Deflect)==_deflects+1,
            "BubbleSlash must preserve and actually enbubble a reflected projectile")
        var _bomb=instance_find(NTTEFullBubbleBomb,_bombs)
        assert(array_length(_bomb.held)==1 && _bomb.held[0]==_enemy && _bomb.creator==_owner && _bomb.team==_slash.team,
            "BubbleSlash real floating bomb lost held projectile or slash ownership")
        _enemy.team=team_enemy
        _bombs=instance_number(NTTEFullBubbleBomb)
        with(_slash) scrNTTEFullBubbleSlashProjectile(_enemy)
        assert(instance_number(NTTEFullBubbleBomb)==_bombs,"Already enbubbled projectile received a duplicate bomb")
        instance_destroy(_bomb)
        assert(!_enemy.bubble_bombed,"Actual BubbleBomb cleanup did not release held projectile marker")
        var _small=instance_create(86040,86000,Bullet1)
        _small.team=team_enemy;_small.typ=2;_small.damage=5
        var _small_count=instance_number(NTTEFullBubbleExplosionSmall)
        with(_slash) scrNTTEFullBubbleSlashProjectile(_small)
        assert(!instance_exists(_small) && instance_number(NTTEFullBubbleExplosionSmall)==_small_count+1,
            "BubbleSlash typ2 low-damage projectile did not become actual small bubble explosion")
        var _big=instance_create(86060,86000,Bullet1)
        _big.team=team_enemy;_big.typ=2;_big.damage=6
        var _big_count=instance_number(NTTEFullBubbleExplosion)
        with(_slash) scrNTTEFullBubbleSlashProjectile(_big)
        assert(!instance_exists(_big) && instance_number(NTTEFullBubbleExplosion)==_big_count+1,
            "BubbleSlash source damage6 threshold did not select actual full bubble explosion")
        var _friendly=instance_create(86080,86000,Bullet1)
        _friendly.team=_slash.team
        with(_slash) scrNTTEFullBubbleSlashProjectile(_friendly)
        assert(instance_exists(_friendly),"BubbleSlash ignored original CustomSlash friendly-team gate")
        _slash.candeflect=false
        var _undeflectable=instance_create(86100,86000,EnemyBullet1)
        _undeflectable.team=team_enemy;_undeflectable.damage=3
        _small_count=instance_number(NTTEFullBubbleExplosionSmall)
        with(_slash) scrNTTEFullBubbleSlashProjectile(_undeflectable)
        assert(!instance_exists(_undeflectable) && instance_number(NTTEFullBubbleExplosionSmall)==_small_count+1,
            "BubbleSlash candeflect=false did not destroy through original explosion branch")
        var _victim=instance_create(86200,86000,NTTEBabyGator)
        _victim.hp=40;_victim.team=team_enemy;_victim.nexthurt=0;_victim.size=2
        var _bubbles=instance_number(Bubble),_pops=instance_number(NTTEFullBubblePop)
        with(_slash) scrNTTEFullBubbleSlashHit(_victim)
        assert(_victim.hp==24 && instance_number(Bubble)==_bubbles+4 && instance_number(NTTEFullBubblePop)==_pops+1,
            "BubbleSlash real push-hit lost damage16 or exact size-driven bubbles/pop")
        _victim.hp=40;_victim.nexthurt=current_frame+1
        with(_slash) scrNTTEFullBubbleSlashHit(_victim)
        assert(_victim.hp==40,"BubbleSlash melee gate ignored original target hurt interval")
        var _wall=instance_create(86300,86000,Wall)
        _slash.x=_wall.x;_slash.y=_wall.y;_slash.speed=0
        var _hits=instance_number(MeleeHitWall)
        with(_slash) scrNTTEFullBubbleSlashWall(_wall)
        with(_slash) scrNTTEFullBubbleSlashWall(_wall)
        assert(_slash.walled && instance_number(MeleeHitWall)==_hits+1,"BubbleSlash repeated its one-shot source wall effect")
        with(_slash) event_perform(ev_other,ev_animation_end)
        assert(!instance_exists(_slash),"BubbleSlash native animation completion did not destroy physical slash")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL BUBBLE SLASH: real reflected projectile/enbubble held lifecycle, damage-threshold explosions, source melee/push/FX, one-shot wall and animation completion OK @"+string(30/timescale))
}
