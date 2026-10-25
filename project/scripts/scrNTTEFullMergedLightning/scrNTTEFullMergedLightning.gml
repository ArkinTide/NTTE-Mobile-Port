// Original native NTT9940 Lightning Alarm0 b2cc30 / EnemyLightning c0eb00,
// restored for temerge's real Lightning nodes. Native movement is synchronous.
function scrNTTEFullMergedLightningCreateNode(_x,_y,_object) {
    var _before=variable_global_exists("ntte_full_merged_lightning_construct")?global.ntte_full_merged_lightning_construct:false,
        _node=noone
    global.ntte_full_merged_lightning_construct=true
    try { _node=instance_create(_x,_y,_object) }
    finally { global.ntte_full_merged_lightning_construct=_before }
    return instance_exists(_node)?_node:noone
}
function scrNTTEFullMergedLightningPointSeen(_x,_y) {
    // Original point_seen(x,y): zero margin and strict bounds. Epsilon has
    // one synchronized local viewport, including split-controller inputs.
    return _x>view_xview && _x<view_xview+view_width && _y>view_yview && _y<view_yview+view_height
}
function scrNTTEFullMergedLightningConstruct() {
    typ=0;ammo=0;damage=(object_index==EnemyLightning)?2:7;knockback_speed=4*timescale
    var _level=(object_index==EnemyLightning)?0:scr_skill_get(mut_laser_brain)
    image_speed=0.4*((_level>=0)?1/(1+_level/3):(1-_level/3))*timescale
    if(GameCont.area==101) {
        var _targets=scrNTTEFullInstances(hitme)
        // Original with(hitme) includes neutral hittables too. CustomHitme
        // native equivalents have independent parents and must join this scan.
        if(!variable_global_exists("ntte_full_merged_basic_custom_hitme")) scrNTTEFullMergedBasicClasses()
        for(var _f=0;_f<array_length(global.ntte_full_merged_basic_custom_hitme);++_f) {
            var _family=scrNTTEFullInstances(global.ntte_full_merged_basic_custom_hitme[_f])
            for(var _j=0;_j<array_length(_family);++_j)
                if(array_get_index(_targets,_family[_j])<0) array_push(_targets,_family[_j])
        }
        for(var _i=0;_i<array_length(_targets);++_i) if(instance_exists(_targets[_i])) with(_targets[_i]) {
            if(nexthurt<=current_frame && sprite_index!=spr_hurt && scrNTTEFullMergedLightningPointSeen(x,y)) {
                scrNTTEFullRawHit(id,2);sleep(3+size);scrNTTEFullTrenchShake(x,y,1)
            }
        }
        with(Player) lasthit=(other.object_index==EnemyLightning)?97:88
        instance_create(x,y,Smoke)
        instance_destroy()
    }
}
// Signature-compatible adapter for the scoped merged stock firing dispatcher.
// The original PC stock creates a real node, sets ammo, performs Alarm0,
// then hides only its first segment and emits native LightningSpawn there.
function scrNTTEFullMergedLightningCreate(_x,_y,_direction,_length) {
    var _node=scrNTTEFullMergedBasicProjectileCreate(_x,_y,Lightning,_direction)
    if(!instance_exists(_node)) return noone
    with(_node) {
        ammo=_length;event_perform(ev_alarm,0);visible=false
        var _spawn=instance_create(x,y,LightningSpawn)
        _spawn.image_angle=image_angle
    }
    return _node
}
function scrNTTEFullMergedLightningAlarm() {
    var _saved=variable_global_exists("ntte_full_lightning_alarm_dispatch")
        ?global.ntte_full_lightning_alarm_dispatch:undefined
    // Only the child whose real Alarm0 the driver is about to perform may
    // consume its continuation. An unrelated/reentrant chain drains itself.
    if(is_struct(_saved) && _saved.expected_node==id) {
        _saved.expected_node=noone
        scrNTTEFullMergedLightningAlarmSegment(_saved)
        return;
    }
    var _dispatch={expected_node:noone,next_node:noone,next_parent:noone},_visited=[id]
    global.ntte_full_lightning_alarm_dispatch=_dispatch
    try {
        scrNTTEFullMergedLightningAlarmSegment(_dispatch)
        while(instance_exists(_dispatch.next_node)) {
            var _next=_dispatch.next_node,_parent=_dispatch.next_parent
            _dispatch.next_node=noone;_dispatch.next_parent=noone
            _dispatch.expected_node=_next
            array_push(_visited,_next)
            // Preserve the direct parent's original self/other relationship.
            with(_parent) { with(_next) event_perform(ev_alarm,0) }
            _dispatch.expected_node=noone
        }
        // Original recursive returns attach metadata deepest-to-root, after
        // every native segment/constructor/impact has already run this frame.
        for(var _i=array_length(_visited)-1;_i>=0;--_i) if(instance_exists(_visited[_i])) with(_visited[_i]) {
            ntte_prism_remaining=max(0,ammo);ntte_prism_chain=ntte_full_lightning_chain.nodes
        }
    }
    finally { global.ntte_full_lightning_alarm_dispatch=_saved }
}
function scrNTTEFullMergedLightningAlarmSegment(_dispatch) {
    if(!variable_instance_exists(id,"ntte_full_lightning_chain")) ntte_full_lightning_chain={nodes:[]}
    var _chain=ntte_full_lightning_chain
    if(array_get_index(_chain.nodes,id)<0) array_push(_chain.nodes,id)
    var _enemy=(object_index==EnemyLightning),_target_class=_enemy?Player:enemy,
        _old_x=x,_old_y=y,_invisible_wall=!_enemy && GameCont.area==0 && instance_exists(InvisiWall)
    if(instance_exists(_target_class)) dir=instance_nearest(x+lengthdir_x(80,direction),y+lengthdir_y(80,direction),_target_class)
    direction=image_angle+random(30)-15
    speed=4*timescale
    if(instance_exists(_target_class) && instance_exists(dir) && point_distance(x,y,dir.x,dir.y)<120)
        motion_add(point_direction(x,y,dir.x,dir.y),timescale)
    image_angle=direction;speed=0
    var _distance=8+random(4)
    if(_invisible_wall) { x+=lengthdir_x(_distance,direction);y+=lengthdir_y(_distance,direction) }
    else move_contact_solid(direction,_distance)
    speed=0
    image_xscale=-point_distance(x,y,_old_x,_old_y)*0.5
    ammo-=1
    if(!_invisible_wall && !place_free(x,y)) { x=xprevious;y=yprevious;direction+=180 }
    if(ammo>0) {
        image_index+=0.4/ammo
        var _parent=id,_child=scrNTTEFullMergedLightningCreateNode(x,y,_enemy?EnemyLightning:Lightning)
        if(instance_exists(_child)) with(_child) {
            hitid=_parent.hitid;creator=_parent.creator;direction=_parent.direction;image_angle=direction
            ammo=_parent.ammo;team=_parent.team;image_index=_parent.image_index
            ntte_full_lightning_chain=_chain
            scrNTTEFullActorDamageMetadata(id,_parent)
            _dispatch.next_parent=_parent;_dispatch.next_node=id
        }
    }
    else instance_create(x+lengthdir_x(image_xscale*2,image_angle),y+lengthdir_y(image_xscale*2,image_angle),LightningHit)
}
function scrNTTEFullMergedLightningInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_lightning_events_ready",false)) return;
    _registry.ntte_lightning_events_ready=true
    scrNTTEFullMergedEffectAddEvent("lightning_trail","setup",scrNTTEFullMergedLightningTrailSetup)
    scrNTTEFullMergedEffectAddEvent("lightning_trail","step",scrNTTEFullMergedLightningTrailStep)
}
function scrNTTEFullMergedLightningTrailSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])
        && !scrNTTEFullMergedProjectileHasEffect(_instances[_i],"lightning_trail"))
        scrNTTEFullMergedProjectileAddEvent(_instances[_i],"hit",scrNTTEFullMergedLightningTrailHit)
}
function scrNTTEFullMergedLightningTrailSpawn(_angle,_amount) {
    var _node=scrNTTEFullMergedBasicProjectileCreate(x,y,Lightning,_angle)
    if(!instance_exists(_node)) return;
    with(_node) {
        ammo=min(_amount,27);event_perform(ev_alarm,0)
        visible=false
        var _spawn=instance_create(x,y,LightningSpawn)
        _spawn.image_angle=image_angle
    }
}
function scrNTTEFullMergedLightningTrailStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i])
        if(random(4)<timescale) scrNTTEFullMergedLightningTrailSpawn(random(360),irandom(damage))
}
function scrNTTEFullMergedLightningTrailHit() {
    if(scrNTTEFullMergedProjectileCanHit(other.id) && current_frame_active)
        scrNTTEFullMergedLightningTrailSpawn(point_direction(x,y,other.x,other.y)+orandom(45),3+irandom(damage))
}
function scrNTTEFullMergedLightningUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _seed=random_get_seed(),_frame=current_frame,
        _hitme=scrNTTEFullAreaGeneratorSnapshot(hitme),_temp_skills=ds_list_create()
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.underwater=false;GameCont.area=1;GameCont.skills=_temp_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        scrNTTEFullMergedBasicInit();scrNTTEFullMergedLightningInit()
        var _owner=instance_find(Player,0),_source=instance_create(88000,88000,Bullet1)
        _source.creator=_owner;_source.team=team_player;_source.hitid=[98];_source.speed=0
        var _node=noone
        with(_source) _node=scrNTTEFullMergedBasicProjectileCreate(88000,88000,Lightning,0)
        assert(_node.ammo==0 && _node.damage==7,"Native Lightning bridge lost Create ammo/default damage")
        var _count=instance_number(Lightning),_hits=instance_number(LightningHit),_start_x=_node.x,_start_y=_node.y
        _node.ammo=4
        with(_node) event_perform(ev_alarm,0)
        assert(_node.ammo==3 && _node.speed==0 && abs(_node.image_index-0.4/3)<0.0001
            && _node.image_xscale<=-4 && _node.image_xscale>=-6
            && abs(-_node.image_xscale*2-point_distance(_start_x,_start_y,_node.x,_node.y))<0.0001,
            "Lightning first Alarm0 lost source ammo, native 8..12 segment geometry or animation stagger")
        assert(instance_number(Lightning)==_count+3 && instance_number(LightningHit)==_hits+1,"Lightning recursion was delayed, truncated or failed to emit terminal real impact")
        var _remaining=[false,false,false,false],_native=0
        with(Lightning) if(array_get_index(_before,id)<0 && point_distance(x,y,_start_x,_start_y)<100) {
            ++_native;_remaining[ammo]=true
            assert(creator==_owner && team==team_player && is_array(hitid) && hitid[0]==98 && speed==0,"Lightning child lost actual native class, hit id, owner/team or stationary segment")
        }
        assert(_native==4 && _remaining[0] && _remaining[1] && _remaining[2] && _remaining[3],"Lightning recursive node budgets changed")
        assert(_node.ntte_prism_remaining==3 && array_length(_node.ntte_prism_chain)==4,
            "Original Lightning ammo/chain metadata did not reach the mobile Prism adapter")
        var _plain=noone,_plain_count=instance_number(Lightning),_plain_spawns=instance_number(LightningSpawn)
        with(_source) _plain=scrNTTEFullMergedLightningCreate(88300,88000,45,3)
        assert(instance_exists(_plain) && !_plain.visible && _plain.ammo==2 && _plain.creator==_owner
            && instance_number(Lightning)==_plain_count+3 && instance_number(LightningSpawn)==_plain_spawns+1,
            "Merged-only plain firing entrance lost native ammo chain, hidden first segment, spawn visual or ownership")
        var _disc_shot=instance_create(88600,88000,Bullet1),_disc_target=instance_create(88620,88000,NTTEBabyGator)
        _disc_shot.creator=_owner;_disc_shot.team=team_player;_disc_shot.speed=0;_disc_shot.damage=1
        _disc_shot.hitid=[177];_disc_target.team=team_enemy;_disc_target.hp=100;_disc_target.nexthurt=0
        var _disc_count=instance_number(Lightning),_disc_hits=instance_number(LightningHit)
        // For damage1 original irandom_range(floor(.5),ceil(1)) produces0/1,
        // and both values make exactly one real Alarm0 segment.
        scrNTTEFullMergedEffectsCall(_disc_shot,_disc_target,scrNTTEFullMergedLightningDiscHit)
        assert(instance_number(Lightning)==_disc_count+1 && instance_number(LightningHit)==_disc_hits+1,
            "Real LightningDisc hit callback failed to synchronously execute native Lightning Alarm0")
        var _disc_nodes=scrNTTEFullInstances(Lightning),_disc_node=_disc_nodes[array_length(_disc_nodes)-1]
        assert(_disc_node.ammo>=-1 && _disc_node.ammo<=0 && _disc_node.speed==0 && _disc_node.creator==_owner
            && _disc_node.team==team_player && is_array(_disc_node.hitid) && _disc_node.hitid[0]==177,
            "Real LightningDisc bridge lost exhausted source budget or native segment team/creator/hitid")
        var _hostile=scrNTTEFullMergedLightningCreateNode(88500,88000,EnemyLightning),_hostile_count=instance_number(EnemyLightning)
        _hostile.ammo=3;_hostile.creator=_owner;_hostile.team=team_enemy;_hostile.direction=0;_hostile.image_angle=0
        with(_hostile) event_perform(ev_alarm,0)
        assert(instance_number(EnemyLightning)==_hostile_count+2 && _hostile.ammo==2 && _hostile.damage==2,"EnemyLightning did not recurse using real EnemyLightning nodes")
        scrNTTEFullMergedProjectileAddEffect(_source,"lightning_trail")
        scrNTTEFullMergedProjectileAddEffect(_source,"lightning_trail")
        assert(array_length(_source.temerge_hit_event_ref_list)==2,"Original repeated setup callback membership changed")
        var _spawns=instance_number(LightningSpawn)
        with(_source) scrNTTEFullMergedLightningTrailSpawn(90,1)
        assert(instance_number(LightningSpawn)==_spawns+1,"Lightning trail failed to emit real first-segment spawn visual")
        // Execute the actual trail Step, including its source1/4 logical-time
        // chance. A direct Spawn call cannot catch missing NTT helper names.
        for(var _trial=0;_trial<2;++_trial) {
            var _wanted=_trial==1,_chance_seed=0
            for(var _candidate=1;_candidate<=10000;++_candidate) {
                random_set_seed(_candidate)
                if((random(4)<timescale)==_wanted) {_chance_seed=_candidate;break}
            }
            assert(_chance_seed>0,"Lightning trail could not seed source success/failure chance")
            _spawns=instance_number(LightningSpawn);random_set_seed(_chance_seed)
            scrNTTEFullMergedLightningTrailStep([_source])
            assert(instance_number(LightningSpawn)==_spawns+_wanted,
                "Actual Lightning trail Step lost source1/4 linear time chance or native spawn")
        }
        ds_list_add(GameCont.skills,mut_laser_brain)
        var _levels=[0,1,3,-1,-3]
        for(var _m=0;_m<array_length(_levels);++_m) {
            var _level=_levels[_m]
            variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_laser_brain),_level)
            var _mutated=scrNTTEFullMergedLightningCreateNode(89000,88000,Lightning),
                _expected=0.4*((_level>=0)?1/(1+_level/3):(1-_level/3))*timescale
            assert(abs(_mutated.image_speed-_expected)<0.0001 && _mutated.ammo==0 && _mutated.damage==7,
                "Scoped Lightning Create lost positive/multiple/negative LaserBrain animation scaling")
            var _enemy_node=scrNTTEFullMergedLightningCreateNode(89200,88000,EnemyLightning)
            assert(abs(_enemy_node.image_speed-0.4*timescale)<0.0001 && _enemy_node.damage==2,
                "EnemyLightning inherited player LaserBrain scaling or wrong damage")
        }
        assert(!global.ntte_full_merged_lightning_construct,"Merged Lightning constructor flag leaked after normal creation")
        assert(!scrNTTEFullMergedLightningPointSeen(view_xview,view_yview+1)
            && scrNTTEFullMergedLightningPointSeen(view_xview+1,view_yview+1)
            && !scrNTTEFullMergedLightningPointSeen(view_xview+view_width,view_yview+1),
            "Original point_seen lost strict zero-margin viewport edges")
        var _cx=view_xview+view_width*0.5,_cy=view_yview+view_height*0.5,
            _eligible=instance_create(_cx,_cy,NTTEBabyGator),_neutral=instance_create(_cx+25,_cy,NTTEBabyGator),
            _immune=instance_create(_cx+50,_cy,NTTEBabyGator),_hurt=instance_create(_cx+75,_cy,NTTEBabyGator),
            _offscreen=instance_create(view_xview-100,_cy,NTTEBabyGator)
        with(_owner) nexthurt=current_frame+100
        var _underwater_targets=[_eligible,_neutral,_immune,_hurt,_offscreen]
        for(var _m=0;_m<array_length(_underwater_targets);++_m) with(_underwater_targets[_m]) {
            hp=20;nexthurt=0;sprite_index=spr_idle
        }
        _neutral.team=team_none;_immune.nexthurt=current_frame+1;_hurt.sprite_index=_hurt.spr_hurt
        GameCont.area=101
        var _smoke=instance_number(Smoke),_rails=instance_number(Lightning),
            _underwater_node=scrNTTEFullMergedLightningCreateNode(_cx,_cy,Lightning)
        // Each eligible actual BabyGator also emits its authored hurt Smoke
        // through FullHurtParityAfter. Two raw hits plus one rail Smoke.
        assert(_underwater_node==noone && instance_number(Lightning)==_rails && instance_number(Smoke)==_smoke+3,
            "Underwater Lightning did not immediately destroy its native rail after real Smoke: node="+string(_underwater_node)
            +" exists="+string(instance_exists(_underwater_node))+" rails="+string(instance_number(Lightning))+" expected="+string(_rails)
            +" smoke="+string(instance_number(Smoke))+" expected="+string(_smoke+3))
        assert(_eligible.hp==18 && _neutral.hp==18 && _immune.hp==20 && _hurt.hp==20 && _offscreen.hp==20
            && _owner.lasthit==88,"Underwater Lightning lost raw damage2, neutral hit, i-frame/hurt/viewport filters or player death cause88")
        _smoke=instance_number(Smoke)
        _underwater_node=scrNTTEFullMergedLightningCreateNode(_cx,_cy,EnemyLightning)
        assert(_underwater_node==noone && _eligible.hp==18 && _neutral.hp==18 && _owner.lasthit==97
            && instance_number(Smoke)==_smoke+1 && !global.ntte_full_merged_lightning_construct,
            "Underwater EnemyLightning lost death cause97, inherited damage filtering, single constructor effect or scoped flag restoration")
        _smoke=instance_number(Smoke);_rails=instance_number(Lightning)
        scrNTTEFullMergedEffectsCall(_disc_shot,_disc_target,scrNTTEFullMergedLightningDiscHit)
        assert(instance_number(Lightning)==_rails && instance_number(Smoke)==_smoke+1
            && !global.ntte_full_merged_lightning_construct,
            "Real underwater LightningDisc callback accessed destroyed node ammo or failed to resolve its native screen strike")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_hitme);ds_list_destroy(_temp_skills)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL MERGED LIGHTNING: real native first/recursive Alarm0 segments, finite shared hitid ownership, EnemyLightning counterpart, trail spawn, signed/multi-level LaserBrain and underwater raw-hit filters OK @"+string(30/timescale))
}
