// Actual source factory calls through Frontier's external module dispatch.
// Test-only; these snapshots are restored before ordinary weapon acceptance.
function scrFRIrisProjectileTests() {
    scrFRProjectileAttributionTests();
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),
        _laser=scr_skill_get(mut_laser_brain),_recycle=scr_skill_get(mut_recycle_gland),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state);
    try {
        assert(!scrFRModLoaded("mod","defpack tools")
            && !scrFRScriptExists("mod","defpack tools","create_fire_bullet"),
            "Partial Iris dependency incorrectly enabled complete optional Defpack branches");
        assert(scrFRGetSkill("excitedneurons")==0 && scrFRGetSkill("recycleglandx10")==0
            && scrFRGetSkill("skill:__frontier_absent_optional_skill")==0,
            "Absent optional source skills must remain unowned");
        var _write_rejected=false;
        try {scrFRSetSkill("__frontier_absent_optional_skill",1);}
        catch(_error) {_write_rejected=true;}
        assert(_write_rejected,"Unknown optional skill writes became silently accepted");
        scr_skill_set(mut_laser_brain,0);scr_skill_set(mut_recycle_gland,0);
        var _sprites=scrFRModGet("mod","Frontier_IrisProjectiles","spr"),
            _factories=["create_fire_bullet","create_gamma_bullet","create_toxic_bullet",
                "create_psy_bullet","create_lightning_bullet"],
            _names=["Fire Bullet","Gamma Bullet","Toxic Bullet","Psy Bullet","Lightning Bullet"],
            _damage=[5,2,4,4,3],_types=[1,1,1,2,2],
            _sprite_fields=["FireBullet","GammaBullet","ToxicBullet","PsyBullet","LightningBullet"],
            _dead_fields=["FireBulletHit","GammaBulletHit","ToxicBulletHit","PsyBulletHit","LightningBulletHit"];
        for(var _i=0;_i<5;++_i) {
            var _shot;
            with(_player) _shot=scrFRModCall("mod","defpack tools",_factories[_i],46112+_i*24,46112);
            assert(instance_exists(_shot) && _shot.fr_custom_actor
                && _shot.object_index==(_i==1?FRCustomSlash:FRCustomProjectile),
                "Iris source factory did not produce its authored native actor: "+_factories[_i]);
            assert(_shot.name==_names[_i] && _shot.damage==_damage[_i] && _shot.typ==_types[_i]
                && _shot.sprite_index==_sprites[$ _sprite_fields[_i]]
                && _shot.spr_dead==_sprites[$ _dead_fields[_i]]
                && sprite_exists(_shot.sprite_index) && sprite_exists(_shot.mask_index)
                && !is_undefined(_shot.on_hit) && !is_undefined(_shot.on_destroy)
                && !is_undefined(_shot.on_wall) && !is_undefined(_shot.on_anim),
                "Iris source factory lost damage, type, artwork or callbacks: "+_factories[_i]);
            if(_i==0) {
                _shot.team=_player.team;_shot.creator=_player;_shot.fallofftime=scrFRSourceFrame()-1;
                var _flames=instance_number(Flame);
                with(_shot) scrFRActorCallback("on_step");
                assert(_shot.image_index==2 && _shot.defbloom.alpha==.1 && instance_number(Flame)==_flames+1,
                    "Authored fire bullet falloff failed to emit its flame");
            }
            if(_i==1) assert(_shot.pierce==1 && !is_undefined(_shot.on_projectile)
                && !is_undefined(_shot.on_grenade),"Authored gamma interception callbacks were omitted");
            if(_i==2) {
                var _target=instance_create(46200,46112,FRCustomObject);
                with(_shot) scrFRModCall("mod","Frontier_IrisProjectiles","poison",_target);
                assert(_target.poisoned==60,"Authored toxic first-hit poison was omitted");
                with(_shot) scrFRModCall("mod","Frontier_IrisProjectiles","poison",_target);
                assert(_target.poisoned==100,"Authored toxic repeated-hit poison was omitted");
                var _gas_before=scrNTTEFullInstances(ToxicGas);
                with(_shot) instance_destroy();
                var _gases=scrNTTEFullInstances(ToxicGas),_new_gas=noone;
                for(var _g=0;_g<array_length(_gases);++_g)
                    if(array_get_index(_gas_before,_gases[_g])<0) {_new_gas=_gases[_g];break;}
                assert(instance_exists(_new_gas),"Authored toxic destruction failed to create real ToxicGas");
                var _victim=instance_create(46300,46112,Bandit),_hp=_victim.hp;
                _victim.nexthurt=0;_new_gas.team=team_none;
                with(_new_gas) event_perform(ev_alarm,0);
                assert(_new_gas.typ==2 && _new_gas.hitid==HitId.Toxin,
                    "Authored ToxicGas lost its native activation or toxin damage identity");
                with(_victim) with(_new_gas) event_perform(ev_collision,hitme);
                assert(_victim.hp<_hp,"Real toxic factory gas did not damage a native hostile target");
            }
            if(_i==3) assert(_shot.mask_index==_sprites.msk.PsyBullet && _shot.timer>=4
                && _shot.timer<=10 && _shot.range==70 && _shot.knockback_speed/timescale==-10 && !is_undefined(_shot.on_step),
                "Authored psy homing configuration or precise mask was omitted");
            if(_i==4) assert(_shot.charge==2 || _shot.charge==3,
                "Authored lightning charge distribution was omitted");
            scrNTTESmokeLog("FRONTIER IRIS FACTORY OK "+_factories[_i]);
        }
        scr_skill_set(mut_laser_brain,1);
        var _lightning;
        with(_player) _lightning=scrFRModCall("mod","defpack tools","create_lightning_bullet",46112,46200);
        assert(_lightning.sprite_index==_sprites.LightningBulletUpg
            && _sprites.LightningBulletUpgBounce==_sprites.LightningBulletBounceUpg,
            "Authored lightning Laser Brain artwork or source compatibility alias is missing");
        scrFRIrisBloomTests();
        scrNTTESmokeLog("FRONTIER IRIS five source factories, optional getters and authored effects OK");
    } finally {
        scr_skill_set(mut_laser_brain,_laser);scr_skill_set(mut_recycle_gland,_recycle);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        random_set_seed(_seed);global.rng_state=_rng;
    }
}
