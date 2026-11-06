function scrNTTEFullBubbleBombTestGrenade() {
    ntte_bubble_grenade_calls+=1
    other.ntte_bubble_callback_source=id
    other.direction=123;other.speed=5*timescale
}
function scrNTTEFullBubbleBombTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0)
    try {
        _owner.x=98000;_owner.y=98000;_owner.team=team_player
        var _bomb=noone
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98100,98100,NTTEFullBubbleBomb)
        assert(_bomb.sprite_index==scrNTTERefSprite("BubbleBomb") && _bomb.image_speed==0.5*timescale
            && _bomb.friction==0.4*timescale*timescale && _bomb.typ==1 && _bomb.damage==3
            && _bomb.knockback_speed==2*timescale && _bomb.zspeed==-0.5 && _bomb.zfriction==-0.02,
            "BubbleBomb original physical constructor changed")
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(!_bomb.ntte_bubble_setup,"BubbleBomb actual first EndStep failed setup")
        _bomb.team=team_enemy;_bomb.ntte_bubble_setup=true
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(_bomb.sprite_index==scrNTTERefSprite("BubbleBombEnemy"),"Source enemy BubbleBomb setup art lost")
        _bomb.big=1;_bomb.ntte_bubble_setup=true
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(_bomb.sprite_index==scrNTTERefSprite("BubbleBombBig") && _bomb.mask_index==mskExploder,
            "Big BubbleBomb source setup failed real sprite/mask")
        _bomb.big=0;_bomb.z=9;_bomb.zspeed=1;_bomb.depth=-4;_bomb.speed=timescale;_bomb.image_angle=0
        current_frame=8
        with(_bomb) event_perform(ev_step,ev_step_normal)
        assert(abs(_bomb.z-(9+timescale))<0.0001 && abs(_bomb.zspeed-(1+0.02*timescale))<0.0001
            && _bomb.depth==-8 && abs(_bomb.image_angle-sin(1)*10*timescale)<0.0001,
            "BubbleBomb floating logical integrator/depth/spin changed")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98100,98100,NTTEFullBubbleBomb)
        var _shot=instance_create(98100,98100,EnemyBullet1),_grabbed=false
        _shot.team=team_enemy;_shot.speed=4*timescale;_shot.direction=0
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_shot)
        assert(_grabbed && array_length(_bomb.held)==1 && _bomb.held[0]==_shot && _shot.bubble_bombed
            && abs(_bomb.speed-(2*timescale+(1-timescale)*_bomb.friction/2))<0.0001,
            "Source BubbleBomb did not preserve and actually capture opposing physical projectile")
        var _second=instance_create(98100,98100,EnemyBullet1)
        _second.team=team_enemy
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_second)
        assert(!_grabbed && !scrNTTEFullValue(_second,"bubble_bombed",false),"Small BubbleBomb grabbed a second held projectile")
        _bomb.z=4;_bomb.zspeed=0;_shot.hspeed=2*timescale;_shot.vspeed=timescale
        _shot.friction=0.2*timescale*timescale;_shot.gravity=0.1*timescale*timescale;_shot.gravity_direction=90
        var _undo_hs=_shot.hspeed-lengthdir_x(_shot.gravity,_shot.gravity_direction),
            _undo_vs=_shot.vspeed-lengthdir_y(_shot.gravity,_shot.gravity_direction),
            _undo_speed=point_distance(0,0,_undo_hs,_undo_vs),_undo_factor=(_undo_speed+_shot.friction)/_undo_speed
        with(_bomb) event_perform(ev_step,ev_step_normal)
        assert(abs(_shot.x-(_bomb.x-2*timescale))<0.02 && abs(_shot.y-(_bomb.y-4-timescale))<0.02,
            "Held small-bubble projectile lost native motion cancellation or floating altitude")
        assert(abs(_shot.hspeed-_undo_hs*_undo_factor)<0.0001 && abs(_shot.vspeed-_undo_vs*_undo_factor)<0.0001,
            "Source held projectile reverse motion did not undo native gravity and friction")
        instance_destroy(_bomb)
        assert(!_shot.bubble_bombed && instance_exists(_shot),"BubbleBomb death failed held marker release or destroyed preserved projectile")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98100,98100,NTTEFullBubbleBomb)
        _bomb.big=1
        var _enemy=instance_create(98100,98100,Bandit),_friend=instance_create(98100,98100,Bandit)
        _enemy.team=team_enemy;_enemy.size=3;_friend.team=_owner.team
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_friend)
        assert(!_grabbed,"Big BubbleBomb source grabbed same-team enemy")
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_enemy)
        assert(_grabbed && _enemy.bubble_bombed,"Big BubbleBomb rejected source size3 enemy")
        var _too_big=instance_create(98100,98100,Bandit)
        _too_big.team=team_enemy;_too_big.size=4
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_too_big)
        assert(!_grabbed,"Big BubbleBomb ignored source size gate")
        _bomb.z=24
        with(_bomb) _grabbed=scrNTTEFullBubbleBombGrab(_too_big)
        assert(!_grabbed,"BubbleBomb grabbed above original z24 cutoff")
        _bomb.big=0;_bomb.z=0;_bomb.team=team_player;_bomb.direction=0;_bomb.speed=4*timescale
        _enemy.bubble_bombed=false;_enemy.hspeed=0;_enemy.vspeed=0;_bomb.image_index=0
        var _hit_seed=0
        while(true) {random_set_seed(_hit_seed);if(random(2)<1) break;_hit_seed++}
        random_set_seed(_hit_seed)
        with(_bomb) scrNTTEFullBubbleBombHit(_enemy)
        assert(abs(_bomb.speed-3.6*timescale)<0.0001
            && abs(_enemy.hspeed-(2*timescale+(1-timescale)*_enemy.friction/2))<0.0001
            && _bomb.image_index==_bomb.image_speed*2,
            "BubbleBomb original collision lost chance knockback/FT friction compensation or source animation speedup")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98100,98100,NTTEFullBubbleBomb)
        _bomb.big=100;_bomb.image_index=6;_bomb.z=0;_bomb.speed=timescale
        var _old=scrNTTEFullInstances(NTTEFullBubbleBomb)
        with(_bomb) event_perform(ev_step,ev_step_normal)
        var _children=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubbleBomb)
        assert(array_length(_children)==1 && _children[0].big==0 && _children[0].creator==_owner
            && _children[0].team==_owner.team && _children[0].image_speed>=0.4*timescale
            && _children[0].image_speed<=0.5*timescale,
            "Big BubbleBomb source excretion did not emit actual small bubble with source ownership/animation")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _owner.x=98300;_owner.y=98300
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98301,98300,NTTEFullBubbleBomb)
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(abs(_bomb.hspeed-1.5*timescale*timescale)<0.0001 && abs(_bomb.vspeed)<0.0001,
            "BubbleBomb player repulsion lost original motion_add_ct double timescale")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _owner.x=98000;_owner.y=98000
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98400,98400,NTTEFullBubbleBomb)
        var _peer=noone
        with(_owner) _peer=scrNTTEFullMergedBasicProjectileCreate(98399,98400,NTTEFullBubbleBomb)
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(abs(_bomb.speed-0.5*timescale*timescale)<0.0001,
            "BubbleBomb peer repulsion lost source motion_add_ct double timescale")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98500,98500,NTTEFullBubbleBomb)
        var _slash=instance_create(98500,98500,Slash)
        _slash.team=_bomb.team;_slash.direction=90;_slash.shank=true
        _bomb.typ=2;_bomb.speed=3*timescale;_bomb.alarm[1]=17;_bomb.friction=0.4*timescale*timescale
        var _fx=instance_number(Deflect),_alive=false
        with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_slash)
        assert(_alive && instance_exists(_bomb) && _bomb.deflected && _bomb.direction==90
            && abs(_bomb.speed-14*timescale)<0.0001 && _bomb.alarm[1]==17
            && _bomb.friction==0.4*timescale*timescale && instance_number(Deflect)==_fx+1,
            "Explicit original Grenade event incorrectly used ordinary shank/typ2/team destroy or lost restored alarm/friction")
        _bomb.speed=12*timescale
        with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_slash)
        assert(_alive && _bomb.speed==12*timescale,"Unchanged source grenade speed incorrectly triggered extra small-bubble boost")
        _slash.guitar=true;_bomb.deflected=false
        with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_slash)
        assert(_alive && _bomb.deflected,"Original GuitarSlash grenade event did not mark bubble deflected")
        var _custom=instance_create(98500,98500,NTTEFullEnergyBatSlash),_is=false
        with(_bomb) _is=scrNTTEFullBubbleBombIsSlash(_custom)
        assert(_is,"BubbleBomb omitted original explicit EnergyBat CustomSlash alias")
        _custom.on_grenade=scrNTTEFullBubbleBombTestGrenade;_custom.ntte_bubble_grenade_calls=0
        with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_custom)
        assert(_alive && _custom.ntte_bubble_grenade_calls==1 && _bomb.ntte_bubble_callback_source==_custom
            && _bomb.direction==123 && _bomb.speed==12*timescale,
            "CustomSlash on_grenade override lost source self/other or baseball's exact speed restoration")
        _custom.on_grenade=undefined
        _custom.candeflect=false
        with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_custom)
        assert(!_alive && !instance_exists(_bomb),"CustomSlash candeflectfalse Grenade event did not destroy bubble")
        var _native_slashes=[BloodSlash,EnergySlash,EnergyHammerSlash,LightningSlash]
        for(var _i=0;_i<array_length(_native_slashes);++_i) {
            with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98500,98500,NTTEFullBubbleBomb)
            _slash=instance_create(98500,98500,_native_slashes[_i]);_slash.direction=123
            _bomb.speed=2*timescale;_bomb.friction=0.4*timescale*timescale;_bomb.alarm[1]=19
            with(_bomb) _alive=scrNTTEFullBubbleBombBaseball(_slash)
            assert(_alive && _bomb.deflected && _bomb.direction==123 && _bomb.speed==14*timescale
                && _bomb.friction==0.4*timescale*timescale && _bomb.alarm[1]==19,
                "Distinct original native Slash Grenade event lost source direction/boost/deflection or exact state restoration")
            instance_destroy(_bomb)
        }
        _slash=instance_create(98500,98500,UltraSlash)
        _is=scrNTTEFullBubbleBombIsSlash(_slash)
        assert(!_is,"BubbleBomb source exact Slash identity was incorrectly generalized to arbitrary descendant")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98600,98600,NTTEFullBubbleBomb)
        var _popper=instance_create(98600,98600,Bolt)
        _popper.team=team_enemy
        with(_bomb) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_bomb) && instance_exists(_popper),"Opposing exact native Bolt did not pop bubble while preserving bolt")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _bomb=scrNTTEFullMergedBasicProjectileCreate(98700,98700,NTTEFullBubbleBomb)
        _bomb.big=1;_bomb.damage=7;_bomb.z=4;_bomb.deflected=true;_bomb.team=team_enemy
        var _foreign=instance_create(98700,98700,EnemyBullet1),_own=instance_create(98700,98700,Bullet1)
        _foreign.creator=noone;_foreign.bubble_bombed=true;_own.creator=_owner;_own.bubble_bombed=true
        _bomb.held=[_foreign,_own]
        var _blasts=scrNTTEFullInstances(NTTEFullBubbleExplosion)
        with(_bomb) event_perform(ev_other,ev_animation_end)
        var _new=scrNTTEFullBubbleWeaponTestNew(_blasts,NTTEFullBubbleExplosion)
        assert(!instance_exists(_bomb) && !instance_exists(_foreign) && instance_exists(_own) && !_own.bubble_bombed
            && array_length(_new)==3,"BubbleBomb actual animation failed source three explosions or selective held creator cleanup")
        for(var _i=0;_i<3;++_i) assert(_new[_i].damage==7 && _new[_i].creator==_owner && _new[_i].team==_owner.team
            && abs(point_distance(98700,98696,_new[_i].xstart,_new[_i].ystart)-16)<0.02
            && abs(_new[_i].x-_new[_i].xstart)<=2.02 && abs(_new[_i].y-_new[_i].ystart)<=2.02,
            "BubbleBomb original animation lost radial origin/radius, inherited damage or deflected creator team")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL BUBBLE BOMB: actual source setup/float/excretion, held projectile+enemy gates/motion/cleanup, ct repulsion, exact native/custom Grenade baseball, poppable Bolt and radial physical animation explosions OK @"+string(30/timescale))
}
