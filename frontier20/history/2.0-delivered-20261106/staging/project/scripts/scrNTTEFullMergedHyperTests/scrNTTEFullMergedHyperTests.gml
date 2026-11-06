// Actual native phases, generated pixels, native Slash collision forwarding.
function scrNTTEFullMergedHyperProbeCreate() {
    ntte_probe_steps=0; ntte_probe_end=0; ntte_probe_begin=0; ntte_probe_alarms=0; ntte_probe_animation=0
    ntte_probe_death=-1; speed=0; friction=0; gravity=0; image_speed=0
}
function scrNTTEFullMergedHyperProbeStep() {
    ++ntte_probe_steps; array_push(global.ntte_hyper_probe_trace,"step")
    if(ntte_probe_death==ntte_probe_steps) instance_destroy()
}
function scrNTTEFullMergedHyperUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _frame=current_frame,_seed=random_get_seed(),_old_trace=variable_global_exists("ntte_hyper_probe_trace") ? global.ntte_hyper_probe_trace:[],
        _state=scrNTTEFullCoastDrawState()
    global.ntte_hyper_probe_trace=[]; current_frame=2
    try {
        scrNTTEFullMergedHyperInit()
        var _pan_x=BackCont.viewx2,_pan_y=BackCont.viewy2
        scrNTTEFullMergedHyperViewShift(global.index+1,0,100)
        assert(BackCont.viewx2==_pan_x && BackCont.viewy2==_pan_y,"Hyper foreign-player melee panned the active local viewport")
        var _p=instance_create(44000,44000,NTTEFullMergedHyperProbe)
        _p.team=team_player; _p.direction=0; _p.speed=4*timescale; _p.alarm[0]=2
        var _joined=scrNTTEFullMergedHyperSetup([_p])
        assert(array_length(_joined)==1 && _p.temerge_hyper_speed==1 && _p.temerge_hyper_minspeed==timescale,
            "Hyper source first effect setup lost logical minimum speed")
        var _result=scrNTTEFullMergedHyperBegin([_p]),_steps=round(15/timescale)
        assert(_p.ntte_probe_steps==_steps && _p.ntte_probe_end==_steps && _p.ntte_probe_begin==_steps
            && _p.ntte_probe_alarms==1 && abs(_p.x-44060)*1000000<=1,
            "Hyper manual native alarms/Step/motion/EndStep/BeginStep or 15logical-tick travel changed @"+string(30/timescale))
        assert(global.ntte_hyper_probe_trace[0]=="step" && global.ntte_hyper_probe_trace[1]=="end"
            && global.ntte_hyper_probe_trace[2]=="begin","Hyper source phase ordering changed")
        scrNTTEFullMergedHyperSetup([_p],2)
        assert(_p.temerge_hyper_speed==3,"Hyper repeated source effects must add travel multipliers")
        var _animated=instance_create(44100,44200,NTTEFullMergedHyperProbe)
        _animated.sprite_index=sprSlash; _animated.image_index=0
        _animated.image_speed=sprite_get_number(sprSlash)*timescale/4; _animated.direction=0; _animated.speed=4*timescale
        scrNTTEFullMergedHyperSetup([_animated]); scrNTTEFullMergedHyperBegin([_animated])
        assert(_animated.ntte_probe_animation==3 && _animated.image_index<sprite_get_number(sprSlash),
            "Hyper manual source animation wrapping failed actual native AnimationEnd events")
        var _dying=instance_create(44200,44000,NTTEFullMergedHyperProbe)
        _dying.direction=0; _dying.speed=4*timescale; _dying.ntte_probe_death=3
        scrNTTEFullMergedHyperSetup([_dying]); global.ntte_hyper_probe_trace=[]
        scrNTTEFullMergedHyperBegin([_dying])
        assert(!instance_exists(_dying) && array_length(global.ntte_hyper_probe_trace)==7,
            "Hyper substep continued native motion/end/begin after normal Step destroyed projectile")
        var _target=instance_create(44432,44000,Bandit),_shot=instance_create(44400,44000,NTTEFullMergedHyperProbe)
        _target.team=team_enemy; _target.hp=100; _target.speed=0
        _shot.team=team_player; _shot.direction=0; _shot.speed=4*timescale
        with(_shot) assert(!place_meeting(x,y,_target),"Hyper contact fixture must begin outside real native bullet/Bandit masks")
        scrNTTEFullMergedHyperSetup([_shot]); scrNTTEFullMergedHyperBegin([_shot])
        scrNTTESmokeLog("HYPER HIT DIAG "+string({rate:30/timescale,
            shot:[_shot.x,_shot.y,_shot.xprevious,_shot.yprevious,_shot.bbox_left,_shot.bbox_top,_shot.bbox_right,_shot.bbox_bottom,_shot.mask_index,_shot.team,_shot.speed],
            target:[_target.x,_target.y,_target.bbox_left,_target.bbox_top,_target.bbox_right,_target.bbox_bottom,_target.mask_index,_target.hp,_target.team],
            hitme_count:instance_number(hitme),steps:_shot.ntte_probe_steps}))
        with(_shot) assert(!place_meeting(x,y,_target) && x==xprevious && x<44460,
            "Hyper failed to stop before living foreign hitme and rewind to previous safe position")
        _target.team=team_player
        scrNTTEFullMergedHyperBegin([_shot])
        assert(_shot.x>=44460,"Hyper source potential-hit scan wrongly stops on own team")
        var _wall=instance_create(44632,44000,Wall),_blocked=instance_create(44600,44000,NTTEFullMergedHyperProbe)
        _blocked.direction=0; _blocked.speed=4*timescale
        scrNTTEFullMergedHyperSetup([_blocked]); scrNTTEFullMergedHyperBegin([_blocked])
        with(_blocked) assert(!place_meeting(x,y,Wall) && x==xprevious && x<44660,
            "Hyper source wall hitscan failed to stop before ordinary collision")
        // Native Slash source melee teleport, actual creator wall scan and the
        // dynamic sprite/mask pipeline run against the real original artwork.
        var _owner=instance_find(Player,0)
        _owner.x=45000; _owner.y=44000; _owner.mask_index=mskPlayer; _owner.gunangle=0
        _owner.temerge_hyper_frame=current_frame-1
        var _slash=scr_projectile_create(45008,44000,Slash,0,0),_old_owner_x=_owner.x
        _slash.creator=_owner; _slash.image_angle=0; _slash.team=team_player
        var _source_sprite=_slash.sprite_index,_source_mask=_slash.mask_index,
            _cut=ceil((sprite_get_bbox_left(_source_sprite)+sprite_get_bbox_right(_source_sprite)+1)/2),
            _out=scrNTTEFullMergedHyperSetup([_slash]),_trail=instance_find(NTTEFullHyperSlashTrail,0)
        assert(!array_length(_out) && instance_exists(_trail) && _trail.target==_slash
            && _owner.x>_old_owner_x && _owner.x==_owner.xprevious && _slash.x==_slash.xprevious,
            "Hyper source melee teleport/trail creation/one-frame creator retention failed")
        assert(sprite_exists(_trail.sprite_index) && sprite_exists(_trail.mask_index)
            && sprite_get_width(_trail.sprite_index)==_cut
            && sprite_get_number(_trail.sprite_index)==sprite_get_number(_source_sprite)
            && sprite_get_xoffset(_trail.sprite_index)==_cut && _trail.image_xscale>_slash.image_xscale,
            "Hyper native trail did not crop exact source half-sprite/allframes/origin and stretch actual mask")
        var _saved_sprite=_trail.sprite_index,_saved_mask=_trail.mask_index
        with(_trail) scrNTTEFullHyperSlashStep()
        assert(_trail.sprite_index==_saved_sprite && _trail.mask_index==_saved_mask,"Hyper trail cache regenerated native assets on every Step")
        var _victim=instance_create((_trail.xstart+_slash.x)/2,44000,Bandit)
        _victim.hp=100; _victim.team=team_enemy; _victim.nexthurt=0
        _slash.damage=12; _slash.team=team_player; _slash.xprevious=_slash.x-5
        var _slash_x=_slash.x,_hp=_victim.hp
        with(_victim) with(_trail) event_perform(ev_collision,hitme)
        assert(_victim.hp<_hp && _slash.x==_slash_x && _slash.xprevious==_slash_x,
            "Hyper actual trail collision failed native target Slash event/damage/position restoration")
        instance_destroy(_slash,false)
        with(_trail) scrNTTEFullHyperSlashStep()
        assert(!instance_exists(_trail),"Hyper trail outlived its native target")
        // Every object below was an exact CustomSlash in the original source.
        // Engine parents differ only because the original loader is absent.
        var _custom=[NTTEFullEnergyBatSlash,NTTEFullBubbleSlash,NTTEFullRedSlash,NTTEFullEntanglerSlash]
        for(var _i=0;_i<array_length(_custom);++_i) {
            _owner.x=45500+_i*500;_owner.y=44500;_owner.temerge_hyper_frame=current_frame-1
            var _custom_slash=noone
            with(_owner) _custom_slash=scrNTTEFullMergedBasicProjectileCreate(x+8,y,_custom[_i],0,2)
            var _old_x=_owner.x,_trails=instance_number(NTTEFullHyperSlashTrail),
                _remaining=scrNTTEFullMergedHyperSetup([_custom_slash])
            assert(!array_length(_remaining) && _owner.x>_old_x
                && instance_number(NTTEFullHyperSlashTrail)==_trails+1,
                "Original concrete CustomSlash bypassed Hyper melee creator movement/trail")
            var _events=scrNTTEFullMergedStockEvents(_custom[_i])
            assert(is_callable(_events.fire),"Original concrete CustomSlash lost default merged-fire hook")
            var _custom_trail=noone
            with(NTTEFullHyperSlashTrail) if(target==_custom_slash) _custom_trail=id
            var _enemy=instance_create((_custom_trail.xstart+_custom_slash.x)/2,44500,Bandit)
            _enemy.team=team_enemy;_enemy.hp=100;_enemy.nexthurt=0
            with(_enemy) with(_custom_trail) event_perform(ev_collision,hitme)
            assert(_enemy.hp<100,"Hyper concrete CustomSlash trail lost actual weapon hit forwarding")
        }
        assert(surface_get_target()==_state.target,"Hyper native sprite/mask crop leaked caller surface target")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players); scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_frame; random_set_seed(_seed); global.ntte_hyper_probe_trace=_old_trace
        matrix_set(matrix_world,_state.world); matrix_set(matrix_view,_state.view); matrix_set(matrix_projection,_state.projection)
        draw_set_color(_state.color); draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("FULL MERGED HYPER: native alarms/Step-motion-EndStep-animation-BeginStep substeps, timescale travel, death stop, foreign-team/wall safe rewind, real creator melee hitscan, exact cached native sprite/mask crop and native Slash collision forwarding OK @"+string(30/timescale))
}
