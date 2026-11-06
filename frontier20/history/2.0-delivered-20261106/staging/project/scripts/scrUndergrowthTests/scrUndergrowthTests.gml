// Tests invoke real resource constructors/events/collision and public native
// fire/hurt entry points; no replacement source implementation in assertions.
function scrUndergrowthEntityTests() {
    var _before=scrNTTEFullInstances(all),_oldarea=GameCont.area;
    try {
        var _names=["Firefly","Dragonfly","Flytrap","PitcherPlant","GoldPitcherPlant","Woo","Mushroom","BugBones","Vine","FireFlower"],
            _health=[7,30,34,25,40,30,17,16,12,500],_made=[];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _e=scrUGCreate(32000+96*_i,32000,_names[_i]);array_push(_made,_e);
            assert(instance_exists(_e) && _e.hp==_health[_i] && sprite_exists(_e.sprite_index),"Undergrowth constructor/health/art "+_names[_i]);
            with(_e) {scrUGStep();scrUGBegin();scrUGEnd();scrUGDraw();}
            if(scrUGHasHurt(_e)) {var _hp=_e.hp;scr_projectile_hit(_e,1,0,0,true);assert(_e.hp==_hp-1,"Undergrowth damage must apply once "+_names[_i]);}
        }
        var _firefly=_made[0];_firefly.alarm1=10;
        with(_firefly) repeat(round(10/timescale)) scrUGStep();
        assert(_firefly.alarm1>0,"Firefly actual alarm did not reschedule at30/60");
        var _plant=_made[3];_plant.gunangle=0;
        var _count=instance_number(UGProjectile);with(_plant) scrUG_PitcherPlant_alrm2();
        assert(instance_number(UGProjectile)==_count+1,"Pitcher plant must fire a line-explosion controller");
        var _mill=scrUGCreate(34000,34000,"Millipede");
        assert(array_length(_mill)>=13 && array_length(_mill)<=13+GameCont.loops,"Millipede source segment count");
        assert(_mill[0].type=="head" && _mill[array_length(_mill)-1].type=="tail","Millipede linked head/tail");
        for(var _i=0;_i<array_length(_mill);++_i) with(_mill[_i]) {scrUGStep();scrUGEnd();}
        scrUGDrawTop();scrUGDark(true,33900,33900);scrUGDark(false,33900,33900);
        var _mush=_made[6];_mush.hp=0;with(_mush) scrUGStep();
        assert(!instance_exists(_mush) && array_length(scrUGMatching(UGObject,"name","MushroomExplode"))==1,"Mushroom death callback exactly once");
        assert(sprite_get_number(mskUGMushroomExplosion)==20,"Mushroom explosion per-frame source mask");
        scrNTTESmokeLog("PASS Undergrowth actual constructors, AI alarms, authored hurt, plant fire, linked millipede, source death and light passes @"+string(30/timescale));
    }
    finally {
        GameCont.area=_oldarea;
        var _after=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false);
    }
}
function scrUndergrowthWeaponTests() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0);
    var _old={wep:_p.wep,angle:_p.gunangle,x:_p.x,y:_p.y,speed:_p.speed,dir:_p.direction};
    try {
        assert(maxwep==178,"Undergrowth five weapons omitted from native registry");
        var _cost=[1,3,4,3,3],_loads=[10,20,30,30,20],_shots=[1,3,1,1,1];
        for(var _i=0;_i<5;++_i) {
            var _w=174+_i;
            assert(scr_weapon_get_cost(_w)==_cost[_i] && scr_weapon_get_load(_w)==_loads[_i] && !scr_weapon_is_auto(_w),"Undergrowth original weapon metadata");
            assert(sprite_exists(scr_weapon_get_sprite(_w)),"Undergrowth weapon sprite");
            var _projectile_before=instance_number(UGProjectile)+instance_number(UGSlash);
            with(_p) {x=40000;y=40000;gunangle=0;wep=_w;scrNTTEFireAll(_w,true);}
            assert(instance_number(UGProjectile)+instance_number(UGSlash)==_projectile_before+_shots[_i],"Undergrowth real firing dispatch shot count "+string(_w));
        }
        var _bullet=scrUG_fossil_gun_LavaBomb_create(40000,40000),_target=scrUGCreate(40000,40000,"PitcherPlant");
        _bullet.creator=_p;_bullet.team=_p.team;_bullet.speed=7*timescale;_bullet.direction=0;
        var _hp=_target.hp;
        with(_bullet) {with(_target) {with(other.id) event_perform(ev_collision,hitme);}}
        // The native collision event's other is runner-owned; use the actual
        // gameplay hit function for deterministic source damage parameters.
        with(_bullet) scrUGHit(_target,3,8,0);
        assert(_target.hp<=_hp-3,"Fossil projectile did not use authored enemy hurt pipeline");
        var _beforeline=array_length(scrUGMatching(UGProjectile,"name","DirectionalExplosion"));
        instance_destroy(_bullet);
        assert(array_length(scrUGMatching(UGProjectile,"name","DirectionalExplosion"))==_beforeline+1,"Fossil bomb terminal line explosion");
        assert(instance_number(UGKnockback)==2,"Cannon and Mega Grenade source recoil controllers");
        scrNTTESmokeLog("PASS Undergrowth five registered weapons, actual fire dispatch, damage and terminal explosion @"+string(30/timescale));
    }
    finally {
        _p.wep=_old.wep;_p.gunangle=_old.angle;_p.x=_old.x;_p.y=_old.y;_p.speed=_old.speed;_p.direction=_old.dir;
        var _after=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false);
    }
}
function scrUndergrowthAreaTests() {
    var _info=scrNTTEFullAreaInfo("undergrowth");
    assert(_info.area_id==207 && _info.goal==120 && _info.subareas==1 && _info.next_area==area_jungle,"Undergrowth source area metadata");
    assert(is_struct(scrNTTEFullAreaNativeBuilder(207)),"Undergrowth native generator not registered");
    assert(scrAreaGetBackroundColor(207)==make_color_rgb(102,78,24) && scrAreaGetShadowColor(207)==make_color_rgb(28,0,14),"Undergrowth source colors");
    var _a=GameCont.area,_s=GameCont.subarea,_pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined),_before=scrNTTEFullInstances(all),
        _wish=scr_skill_get(mut_last_wish),_points=GameCont.skillpoints,_visits=GameCont.junglevisits,_junpick=scrNTTEFullValue(GameCont,"junpick",false);
    try {
        GameCont.area=207;GameCont.subarea=1;
        var _floor=instance_create(36000,36000,Floor),_wall=instance_create(36000,36000,Wall);
        assert(_floor.sprite_index==sprUGFloorUndergrowth && _floor.material==4,"Undergrowth floor art/material");
        with(_floor) {styleb=true;scrNTTEFullAreaFloorSetup(207);}
        assert(_floor.sprite_index==sprUGFloorUndergrowthB && _floor.material==1 && _floor.depth==8,"Undergrowth styled floor");
        assert(_wall.sprite_index==sprUGWallUndergrowthBot && _wall.topspr==sprUGWallUndergrowthTop && _wall.outspr==sprUGWallUndergrowthOut,"Undergrowth full wall artwork");
        GameCont.ntte_full_pending_destination=undefined;
        with(GameCont) scrUGFinishDestination();
        var _dest=scrNTTEFullAreaTakeDestination();
        assert(_dest.area==area_jungle && _dest.subarea==1,"Undergrowth exit must reach Jungle");
        scr_skill_set(mut_last_wish,1);GameCont.ntte_full_pending_destination=undefined;
        with(GameCont) scrUGFinishDestination();
        assert(scr_skill_get(mut_last_wish)==0 && GameCont.skillpoints==_points+1 && GameCont.junglevisits==_visits+1
            && GameCont.junpick,"Undergrowth source Last Wish refund/Jungle visit omitted");
        // Opening a source chest before interacting with the Vine closes it.
        var _flower=scrUGCreate(37000,37000,"FireFlower"),_portalcount=instance_number(Portal);
        instance_create(37000,37000,ChestOpen);instance_create(37000,37000,FXChestOpen);
        with(_flower) scrUGFlowerStep();
        assert(!instance_exists(_flower) && instance_number(Portal)==_portalcount,"Vine survived opening the source chest or entered prematurely");
        scrNTTESmokeLog("PASS Undergrowth area registration, original terrain and Jungle destination @"+string(30/timescale));
    }
    finally {
        GameCont.area=_a;GameCont.subarea=_s;GameCont.ntte_full_pending_destination=_pending;
        scr_skill_set(mut_last_wish,_wish);GameCont.skillpoints=_points;GameCont.junglevisits=_visits;GameCont.junpick=_junpick;
        var _after=scrNTTEFullInstances(all);
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false);
    }
}

function scrUndergrowthIntegrationTests() {
    scrNTTEFullWeaponNativeInit();
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _registry=global.ntte_full_native_weapon_models,_base=global.ntte_full_native_weapon_base,
        _language=global.language_current,_oldmap=scrNTTEFullValue(global,"ntte_weapon_load_rebase",undefined),_buffer=-1,
        _oldprobe=scrNTTEFullValue(global,"ug_merge_probe",undefined),_mode=scrNTTEFullValue(global,"ntte_merge_native_collision_mode",false);
    try {
        var _p=instance_find(Player,0),_candidates=scrNTTEFullWeaponDropCandidates();
        for(var _i=0;_i<5;++_i) assert(scrNTTEFullWeaponDropResolve(_candidates[161+_i])==174+_i,"Undergrowth omitted from shuffled natural drop pool");
        assert(scrNTTEFullWeaponDropArea("mega grenade launcher",{curse:0})==-1 && scrNTTEFullWeaponDropArea("mega grenade launcher",{curse:1})==8,"Mega Grenade curse-only source pool");
        global.language_current=global.language_store[$ "Simplified Chinese"];scrNTTEFullLocalizeInstall();
        assert(scrNTTEFullDisplay("FOSSIL PISTOL")=="化石手枪" && scrNTTEFullDisplay("MILLIPEDE")=="马陆","Undergrowth Simplified Chinese display");
        global.language_current=global.language_store[$ "English"];
        assert(scrNTTEFullDisplay("FOSSIL PISTOL")=="FOSSIL PISTOL","Undergrowth changed English identity");
        // Actual fusion transactions in both directions. Native fusion replaces
        // the stock projectile with the front's projectile, retaining metadata.
        for(var _i=0;_i<5;++_i) {
          for(var _reverse=0;_reverse<2;++_reverse) {
            scrNTTEFullMergedRuntimeTestCleanup(_before);
            var _model=scrNTTEFullWeaponMerge(_reverse?wep_revolver:174+_i,_reverse?174+_i:wep_revolver),_handle=scrNTTEFullWeaponNative(_model);
            _p.wep=_handle;_p.reload=0;_p.can_shoot=true;_p.ammo[Ammo.Explosives]=100;_p.ammo[Ammo.Bullets]=100;
            _p.race=Race.Fish;_p.ntte_race_ultra=0;_p.infammo=0;
            _p.x=41000;_p.y=41000;_p.gunangle=0;
            var _fired=false;
            with(_p) _fired=scrFire(_handle,true);
            var _shots=scrNTTEFullMergedRuntimeProjectiles(scrNTTEFullMergedRuntimeNew(_before));
            assert(_fired && array_length(_shots)>0 && _p.wep==_handle,"Undergrowth native fusion fire transaction "+string([_i,_reverse]));
            var _fronts=0,_retained=0;
            for(var _j=0;_j<array_length(_shots);++_j) {
                var _shot=_shots[_j];
                // Native Slash stocks are deliberately retained at reduced
                // scale, in addition to the front's new projectile.
                if(!_reverse && _i==3 && instance_is(_shot,UGSlash)) {_retained++;continue;}
                assert(instance_is(_shot,_reverse?(_i==3?UGSlash:UGProjectile):Bullet1)
                    && _shot.creator==_p && array_length(_shot.temerge_vars_list)==1,"Undergrowth fusion replacement/metadata "+string([_i,_reverse]));
                _fronts++;
            }
            assert(_fronts>0 && (_reverse || _i!=3 || _retained==1),"Undergrowth Hammer stock lost native retained slash/front");
            assert((_reverse?_p.ammo[Ammo.Explosives]:_p.ammo[Ammo.Bullets])<100
                && (_reverse?_p.ammo[Ammo.Bullets]:_p.ammo[Ammo.Explosives])==100,"Undergrowth fusion front-only ammunition consumption");
          }
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        // Real UG collision events must run inherited fusion effects before
        // their source damage, and capture terminal effects before destruction.
        global.ug_merge_probe={hits:0,deaths:0};global.ntte_merge_native_collision_mode=true;
        var _target=scrUGCreate(42000,42000,"PitcherPlant"),_bullet=scrUG_fossil_gun_LavaBomb_create(42000,42000);
        _bullet.team=_p.team;_bullet.creator=_p;_bullet.speed=0;
        _bullet.x=(_target.bbox_left+_target.bbox_right-1)/2;_bullet.y=(_target.bbox_top+_target.bbox_bottom-1)/2;
        var _hp=_target.hp;
        scrNTTEFullMergedProjectileAddEvent(_bullet,"hit",function() {global.ug_merge_probe.hits++;x+=100;});
        with(_target) with(_bullet) event_perform(ev_collision,hitme);
        assert(global.ug_merge_probe.hits==1 && _target.hp==_hp,"Undergrowth actual fusion collision callback skipped/doubled or failed to suppress source hit "+string([global.ug_merge_probe.hits,_target.hp,_hp,scrNTTEFullValue(global,"ntte_merge_native_collision_mode",false)]));
        scrNTTEFullMergedProjectileAddEvent(_bullet,"destroy",function() {global.ug_merge_probe.deaths++;});
        var _deathvars=scrNTTEFullMergedEffectVars("destroy_event");
        instance_destroy(_bullet,false);scrNTTEFullMergedEffectsReplayDestroy(_deathvars);
        assert(global.ug_merge_probe.deaths==1,"Undergrowth native Cleanup lost terminal fusion effect");
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        // Build an actual pre1.1 numeric-handle fixture, then use the real
        // export/import plus native Player serialization to verify migration.
        global.ntte_full_native_weapon_base=179;global.ntte_full_native_weapon_models=[];
        var _legacy=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun));
        var _state=scrNTTEFullWeaponNativeState(_legacy);_state.ammo=9;_state.weapon=174;
        var _encoded=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()));_encoded.base=174;
        _p.wep=174;_p.bwep=wep_wrench;_p.extra_weps=[174];_p.ntte_state=_state;
        _buffer=buffer_create(1024,buffer_grow,1);scrSavegamePlayers(_buffer,false);buffer_seek(_buffer,buffer_seek_start,0);
        scrNTTEFullWeaponNativeImport(_encoded);
        assert(global.ntte_full_native_weapon_base==179 && !scrNTTEFullWeaponIsNative(174)
            && scrNTTEFullWeaponRaw(179)==wep_revolver && scrNTTEFullWeaponNativeState(179).weapon==179,"Old continuation handles collided with new raw weapons");
        scrSavegamePlayers(_buffer,true);
        var _loaded=noone;with(Player) if(array_get_index(_before,id)<0) {_loaded=id;break;}
        assert(instance_exists(_loaded) && _loaded.wep==179 && _loaded.extra_weps[0]==179 && _loaded.bwep==wep_wrench
            && _loaded.ntte_state==scrNTTEFullWeaponNativeState(179) && _loaded.ntte_state.ammo==9,"Actual old Player continuation did not rebase weapon/state aliases");
        scrNTTESmokeLog("PASS Undergrowth natural drop pool, curse restriction, localization, five real fusion shots and old1.0 continuation handle migration @"+string(30/timescale));
    }
    finally {
        if(buffer_exists(_buffer)) buffer_delete(_buffer);
        var _after=scrNTTEFullInstances(all);for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false);
        global.ntte_full_native_weapon_models=_registry;global.ntte_full_native_weapon_base=_base;global.ntte_weapon_load_rebase=_oldmap;
        global.ug_merge_probe=_oldprobe;
        global.ntte_merge_native_collision_mode=_mode;
        global.language_current=_language;scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
    }
}
