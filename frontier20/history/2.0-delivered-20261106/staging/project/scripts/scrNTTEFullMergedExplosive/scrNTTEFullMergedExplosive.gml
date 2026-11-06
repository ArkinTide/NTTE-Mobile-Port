// Original temerge3486..3769: explosion and grenade timing/presentation.
function scrNTTEFullMergedExplosiveInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_explosive_events_ready",false)) return;
    _registry.ntte_explosive_events_ready=true
    scrNTTEFullMergedEffectAddEvent("explosion","setup",scrNTTEFullMergedExplosionSetup)
    scrNTTEFullMergedEffectAddEvent("grenade","setup",scrNTTEFullMergedGrenadeEffectSetup)
    scrNTTEFullMergedEffectAddEvent("grenade","step",scrNTTEFullMergedGrenadeEffectStep)
    scrNTTEFullMergedEffectAddEvent("grenade","end_step",scrNTTEFullMergedGrenadeEffectEndStep)
    scrNTTEFullMergedEffectAddEvent("grenade","draw",scrNTTEFullMergedGrenadeEffectDraw)
}
function scrNTTEFullMergedExplosionSetup(_instances,_info=undefined,_count=1) {
    var _explosion={}
    if(is_struct(_info)) {
        var _names=variable_struct_get_names(_info)
        for(var _n=0;_n<array_length(_names);++_n) variable_struct_set(_explosion,_names[_n],variable_struct_get(_info,_names[_n]))
    }
    var _flags=["is_small","is_heavy","is_blood","is_bubble","is_toxic","is_cluster"]
    for(var _i=0;_i<array_length(_flags);++_i) if(!variable_struct_exists(_explosion,_flags[_i])) variable_struct_set(_explosion,_flags[_i],false)
    if(!variable_struct_exists(_explosion,"is_active")) _explosion.is_active=true
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_explosion_list")) {
            temerge_explosion_list=[]
            scrNTTEFullMergedProjectileAddEvent(id,"destroy",scrNTTEFullMergedExplosionDestroy)
        }
        // One cloned descriptor is shared across every slot and projectile in
        // THIS setup invocation; later is_active changes intentionally alias.
        repeat(_count) array_push(temerge_explosion_list,_explosion)
    }
    if(_explosion.is_toxic) scrNTTEFullMergedProjectileAddEffect(_instances,"toxic")
}
function scrNTTEFullMergedExplosionCreate(_x,_y,_small,_heavy,_blood,_bubble,_logical_speed) {
    var _object=_bubble?(_small?NTTEFullBubbleExplosionSmall:NTTEFullBubbleExplosion):
        (_blood?MeatExplosion:(_small?SmallExplosion:(_heavy?GreenExplosion:Explosion))),
        _instance=scrNTTEFullMergedBasicProjectileCreate(_x,_y,_object,direction,_logical_speed)
    if(!instance_exists(_instance)) return noone
    if(!_bubble && !_blood && _small && _heavy) {
        // Original tegeneral4308 returns an actual SmallExplosion with these
        // fields, not a new object class with different ancestry/events.
        _instance.sprite_index=sprNTTERefSmallGreenExplosion
        _instance.damage=12;_instance.knockback_speed=8*timescale
        if(scrNTTEFullValue(id,"hitid",HitId.None)==HitId.None)
            _instance.hitid=[sprNTTERefSmallGreenExplosion,"SMALL GREEN#EXPLOSION"]
    }
    return _instance
}
function scrNTTEFullMergedExplosionDestroy() {
    if((object_index==Lightning || object_index==EnemyLightning) && (ammo%4)>=1) return;
    var _list=temerge_explosion_list,_count=array_length(_list),_angle=random(360),_logical_speed=speed/timescale
    for(var _i=0;_i<_count;++_i) {
        var _info=_list[_i]
        if(!_info.is_active) continue
        var _small=_info.is_small || damage<10,_heavy=_info.is_heavy,_blood=_info.is_blood,_bubble=_info.is_bubble,
            _cluster=_info.is_cluster,_offset=min(16,8*(_count-1)),_offset_direction=_angle+360*(_i/_count),
            _ex=x+lengthdir_x(_offset,_offset_direction),_ey=y+lengthdir_y(_offset,_offset_direction),
            _subcount=_blood && !_small?3:1,_subangle=random(360)
        if(_cluster) snd_play_hit(sndClusterOpen,0.2)
        else if(_blood) { snd_play_hit_big(sndMeatExplo,0.2);snd_play_hit_big(sndBloodLauncherExplo,0.2) }
        else if(!_bubble) snd_play_hit_big(_count>1?(_small?sndExplosion:sndExplosionL):(_small?sndExplosionS:sndExplosion),0.2)
        for(var _sub_direction=_subangle;_sub_direction<_subangle+360;_sub_direction+=360/_subcount) {
            if(_cluster) {
                var _number=min(ceil(damage/3),640)+(GameCont.crown==Crown.Death)
                if(_number>0) {
                    var _lerp=min(abs(_logical_speed)/16,1)/sqrt(_number)
                    repeat(_number) {
                        // Original NTT MiniNade = Epsilon SmallGrenade, the
                        // existing native short-fuse 5damage grenade class.
                        scrNTTEFullMergedBasicProjectileCreate(x+orandom(2),y+orandom(2),SmallGrenade,
                            angle_lerp(random(360),direction,_lerp),lerp(random_range(3,8),_logical_speed/2,_lerp))
                        scrNTTEFullMergedStockFX(x,y,random_range(2,5),Smoke)
                    }
                }
            }
            else {
                var _suboffset=_subcount>1?24:random(1),_instance=scrNTTEFullMergedExplosionCreate(
                    _ex+lengthdir_x(_suboffset,_sub_direction),_ey+lengthdir_y(_suboffset,_sub_direction),
                    _small,_heavy,_blood,_bubble,_logical_speed/4)
                if(!instance_exists(_instance)) continue
                _instance.friction=0.5*timescale*timescale;_instance.image_angle=0
                var _damage=damage*(_heavy?4/5:1/3)
                if(_blood) _damage*=0.8
                if(_bubble) _damage*=0.6
                _instance.damage=round(_damage)
                if(_blood) {
                    var _streak=instance_create(_ex,_ey,BloodStreak)
                    _streak.image_angle=_sub_direction
                }
                else {
                    if(!_bubble) {
                        _instance.team=-1
                        if(_instance.hitid==HitId.None) switch(_instance.object_index) {
                            case Explosion:_instance.hitid=HitId.Explosion;break;
                            case SmallExplosion:_instance.hitid=HitId.SmallExplosion;break;
                            case GreenExplosion:_instance.hitid=HitId.GreenExplosion;break;
                        }
                    }
                    if(GameCont.crown==Crown.Death && _small && !_info.is_small)
                        with(_instance) with(scrNTTEFullMergedNativeCopy(false)) { x+=orandom(2);y+=orandom(2) }
                }
            }
        }
    }
}
function scrNTTEFullMergedGrenadeEffectSetup(_instances,_max_range,_info=undefined) {
    if(!variable_instance_exists(GameCont,"temerge_grenade_frame")) GameCont.temerge_grenade_frame=0
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_grenade_frame")) {
            temerge_grenade_frame=GameCont.temerge_grenade_frame
            if(instance_is(id,HyperGrenade)) {
                scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedGrenadeHyperHit)
                scrNTTEFullMergedProjectileAddEvent(id,"wall",scrNTTEFullMergedGrenadeHyperWall)
            }
        }
        temerge_grenade_frame=max(temerge_grenade_frame,GameCont.temerge_grenade_frame+_max_range/max(6,speed/timescale))
        if(instance_is(id,Grenade) && alarm[0]>0) { temerge_grenade_frame+=alarm[0]/4;alarm[0]=-1 }
    }
    if(!is_undefined(_info)) scrNTTEFullMergedProjectileAddEffect(_instances,"explosion",[_info])
}
function scrNTTEFullMergedGrenadeEffectStep(_instances) {
    GameCont.temerge_grenade_frame+=timescale
    var _explode=[]
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])
        && _instances[_i].temerge_grenade_frame<=GameCont.temerge_grenade_frame) array_push(_explode,_instances[_i])
    if(array_length(_explode)) scrNTTEFullMergedProjectileDestroy(_explode)
}
function scrNTTEFullMergedGrenadeEffectEndStep(_instances) {
    if(!instance_exists(Explosion)) return;
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(temerge_grenade_frame<=GameCont.temerge_grenade_frame+10 && place_meeting(x,y,Explosion))
            scrNTTEFullMergedProjectileDestroy(id)
    }
}
function scrNTTEFullMergedGrenadeEffectDraw(_instances) {
    var _blink=[]
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].visible
        && _instances[_i].temerge_grenade_frame<=GameCont.temerge_grenade_frame+10) array_push(_blink,_instances[_i])
    if(array_length(_blink)) {
        gpu_set_fog(true,((GameCont.temerge_grenade_frame*0.4)%2)<1?c_white:c_black,0,0)
        for(var _i=0;_i<array_length(_blink);++_i) with(_blink[_i]) draw_self()
        gpu_set_fog(false,0,0,0)
    }
}
function scrNTTEFullMergedGrenadeHyperHit() {
    alarm[1]=max(alarm[1],temerge_grenade_frame-GameCont.temerge_grenade_frame)
}
function scrNTTEFullMergedGrenadeHyperWall() {
    if(!variable_instance_exists(id,"temerge_explosion_list")) return;
    var _bounce=false
    for(var _i=0;_i<array_length(temerge_explosion_list);++_i) {
        var _info=temerge_explosion_list[_i]
        if(!_info.is_small && !_info.is_blood) { _bounce=true;break }
    }
    if(_bounce) {
        alarm[1]=max(alarm[1],temerge_grenade_frame-GameCont.temerge_grenade_frame)
        if(speed!=0 && !variable_instance_exists(id,"temerge_sticky_target")) {
            friction=0.4*timescale*timescale;move_bounce_solid(true)
            snd_play_hit(sndGrenadeHitWall,0.2);instance_create(x,y,Dust)
        }
    }
}

function scrNTTEFullMergedExplosiveUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _frame=current_frame,_seed=random_get_seed()
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.crown=Crown.None;GameCont.underwater=false;current_frame=2
    try {
        scrNTTEFullMergedBasicInit();scrNTTEFullMergedExplosiveInit()
        var _owner=instance_find(Player,0),_a=instance_create(82000,82000,Bullet1),_b=instance_create(82200,82000,Bullet1)
        _a.creator=_owner;_a.team=team_player;_a.hitid=HitId.None;_a.damage=30;_a.speed=8*timescale
        _b.creator=_owner;_b.team=team_player
        var _info={is_small:true,is_heavy:true}
        scrNTTEFullMergedProjectileAddEffect([_a,_b],"explosion",[_info,2])
        _info.is_small=false
        assert(_a.temerge_explosion_list[0].is_small && !_a.temerge_explosion_list[0].is_blood
            && array_length(_a.temerge_destroy_event_ref_list)==1,"Explosion descriptor clone/defaults or unique destroy registration changed")
        _a.temerge_explosion_list[0].is_active=false
        assert(!_a.temerge_explosion_list[1].is_active && !_b.temerge_explosion_list[1].is_active,
            "Explosion setup lost one shared descriptor across every supplied projectile and count slot")
        _a.temerge_explosion_list[0].is_active=true
        var _small=instance_number(SmallExplosion)
        scrNTTEFullMergedEffectsCall(_a,_owner,scrNTTEFullMergedExplosionDestroy)
        assert(instance_number(SmallExplosion)==_small+2,"Heavy-small explosion list did not create both real SmallExplosion objects")
        var _checked=0
        with(SmallExplosion) if(array_get_index(_before,id)<0 && x>81950 && x<82050) {
            ++_checked
            assert(sprite_index==sprNTTERefSmallGreenExplosion && damage==24 && team==-1 && creator==_owner
                && abs(speed-2*timescale)<0.0001 && abs(friction-0.5*timescale*timescale)<0.0001
                && abs(knockback_speed-8*timescale)<0.0001 && is_array(hitid),
                "Heavy-small explosion lost original class/sprite/damage/ownership/force/friction/custom hit id")
        }
        assert(_checked==2,"Heavy-small explosion assertions did not observe both native instances")

        var _blood=instance_create(82500,82000,Bullet1),_meat=instance_number(MeatExplosion),_streak=instance_number(BloodStreak)
        _blood.creator=_owner;_blood.team=team_player;_blood.damage=30;_blood.speed=0
        scrNTTEFullMergedProjectileAddEffect(_blood,"explosion",[{is_blood:true,is_heavy:true}])
        scrNTTEFullMergedEffectsCall(_blood,_owner,scrNTTEFullMergedExplosionDestroy)
        assert(instance_number(MeatExplosion)==_meat+3 && instance_number(BloodStreak)==_streak+3,
            "Large blood explosion lost three sub-explosions and real BloodStreak objects")
        _checked=0
        with(MeatExplosion) if(array_get_index(_before,id)<0 && point_distance(x,y,_blood.x,_blood.y)<30) {
            ++_checked
            assert(damage==19 && team==team_player && creator==_owner,"Blood explosion damage multiplier or friendly ownership changed")
        }
        assert(_checked==3,"Blood explosion ownership assertions did not observe all three instances")

        var _bubble=instance_create(82800,82000,Bullet1),_bubbles=instance_number(NTTEFullBubbleExplosionSmall)
        _bubble.creator=_owner;_bubble.team=team_player;_bubble.damage=9;_bubble.speed=0
        scrNTTEFullMergedProjectileAddEffect(_bubble,"explosion",[{is_bubble:true}])
        scrNTTEFullMergedEffectsCall(_bubble,_owner,scrNTTEFullMergedExplosionDestroy)
        assert(instance_number(NTTEFullBubbleExplosionSmall)==_bubbles+1,"Low-damage bubble explosion did not select the real small-bubble class")
        with(NTTEFullBubbleExplosionSmall) if(array_get_index(_before,id)<0 && point_distance(x,y,_bubble.x,_bubble.y)<5)
            assert(damage==2 && team==team_player && creator==_owner,"Bubble explosion lost rounded0.6 multiplier or source ownership")

        GameCont.crown=Crown.Death
        var _death=instance_create(83100,82000,Bullet1),_cluster=instance_create(83400,82000,Bullet1)
        _death.creator=_owner;_death.team=team_player;_death.damage=9;_death.speed=0
        _small=instance_number(SmallExplosion)
        scrNTTEFullMergedProjectileAddEffect(_death,"explosion")
        scrNTTEFullMergedEffectsCall(_death,_owner,scrNTTEFullMergedExplosionDestroy)
        assert(instance_number(SmallExplosion)==_small+2,"Crown of Death did not copy an implicitly small native explosion")
        _cluster.creator=_owner;_cluster.team=team_player;_cluster.damage=10;_cluster.speed=0
        var _mininades=instance_number(SmallGrenade)
        scrNTTEFullMergedProjectileAddEffect(_cluster,"explosion",[{is_cluster:true}])
        scrNTTEFullMergedEffectsCall(_cluster,_owner,scrNTTEFullMergedExplosionDestroy)
        assert(instance_number(SmallGrenade)==_mininades+5,"Cluster grenade count lost ceil(damage/3) plus Death crown")
        _checked=0
        with(SmallGrenade) if(array_get_index(_before,id)<0 && point_distance(x,y,_cluster.x,_cluster.y)<12) {
            ++_checked
            assert(team==team_player && creator==_owner && speed>=3*timescale && speed<=8*timescale && alarm[0]>=10 && alarm[0]<=20,
                "Cluster creation lost native MiniNade counterpart, ownership, motion or short fuse")
        }
        assert(_checked==5,"Cluster native state assertions did not observe every spawned grenade")

        GameCont.crown=Crown.None;GameCont.temerge_grenade_frame=0
        var _grenade=instance_create(83700,82000,Grenade),_timer=instance_create(84000,82000,Bullet1),_later=instance_create(84300,82000,Bullet1)
        _grenade.speed=12*timescale;_grenade.alarm[0]=20
        scrNTTEFullMergedProjectileAddEffect(_grenade,"grenade",[60])
        assert(_grenade.temerge_grenade_frame==10 && _grenade.alarm[0]==-1,"Grenade setup lost source max-range timing and native fuse quarter addition")
        scrNTTEFullMergedProjectileAddEffect(_grenade,"grenade",[120])
        assert(_grenade.temerge_grenade_frame==10,"Repeated grenade setup added a disabled native fuse again")
        _timer.speed=0;_later.speed=0
        scrNTTEFullMergedProjectileAddEffect([_timer,_later],"grenade",[120])
        _timer.temerge_grenade_frame=2*timescale;_later.temerge_grenade_frame=10*timescale
        scrNTTEFullMergedGrenadeEffectStep([_timer,_later])
        assert(instance_exists(_timer) && GameCont.temerge_grenade_frame==timescale,"Grenade group scheduler advanced global clock per projectile")
        scrNTTEFullMergedGrenadeEffectStep([_timer,_later])
        assert(!instance_exists(_timer) && instance_exists(_later) && GameCont.temerge_grenade_frame==2*timescale,
            "Grenade timer did not destroy only expired native projectile")
        var _hyper=instance_create(84600,82000,HyperGrenade)
        _hyper.speed=0
        scrNTTEFullMergedProjectileAddEffect(_hyper,"grenade",[120,{is_blood:true}])
        assert(array_length(_hyper.temerge_hit_event_ref_list)==1 && array_length(_hyper.temerge_wall_event_ref_list)==1,
            "Hyper grenade setup lost its hit/wall event callbacks")
        _hyper.alarm[1]=2
        scrNTTEFullMergedEffectsCall(_hyper,_owner,scrNTTEFullMergedGrenadeHyperHit)
        assert(_hyper.alarm[1]==20,"Hyper grenade hit did not preserve remaining logical fuse")
        _hyper.alarm[1]=2
        scrNTTEFullMergedEffectsCall(_hyper,_owner,scrNTTEFullMergedGrenadeHyperWall)
        assert(_hyper.alarm[1]==2,"Blood-only hyper grenade wall incorrectly enabled ordinary grenade bounce/delay")
        var _blast=instance_create(_later.x,_later.y,Explosion)
        _later.mask_index=mskBullet1;_later.temerge_grenade_frame=GameCont.temerge_grenade_frame+5
        // Native mskExplosion frame0 is transparent. Only frame1 contains
        // its real damage mask; test the actual temporal contact boundary.
        scrNTTEFullMergedGrenadeEffectEndStep([_later])
        assert(instance_exists(_later),"Transparent native Explosion frame0 incorrectly chain-detonated a grenade")
        _blast.image_index=1
        scrNTTEFullMergedGrenadeEffectEndStep([_later])
        assert(!instance_exists(_later),"Near-fuse grenade did not chain-detonate through real Explosion overlap")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED EXPLOSIVE: shared descriptor, real heavy/blood/bubble/cluster/crown classes and damage, logical fuse, native destruction and Hyper callbacks OK @"+string(30/timescale))
}
