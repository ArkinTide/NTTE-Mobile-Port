// Independent extras regression; root invokes after native collision integration.
function scrNTTEFullMergedStockExtraTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        _stack=variable_global_exists("ntte_merge_native_collision_stack")?global.ntte_merge_native_collision_stack:[],
        _sound=variable_global_exists("ntte_full_merged_basic_sound_observer")?global.ntte_full_merged_basic_sound_observer:undefined,
        _frame=current_frame,_seed=random_get_seed(),_walls=ds_list_create()
    ds_list_copy(_walls,global.lis_walls_visible)
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_merge_native_collision_mode=true;global.ntte_merge_native_collision_stack=[]
    global.ntte_full_merged_basic_sound_observer=[]
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.underwater=false;current_frame=2
    try {
        scrNTTEFullMergedEffectsInit();scrNTTEFullMergedMotionInit()
        var _owner=instance_find(Player,0),_beam=instance_create(13000,13000,NTTEFullQuasarBeam),_info={}
        _beam.ntte_full_scale_goal=2;_beam.ntte_full_ring=true
        _beam.ntte_full_max_distance=171
        with(_beam) scrNTTEFullMergedQuasarBeamFire({},_info)
        assert(_info.scale_goal==2 && _info.is_ring && _info.line_dis_max==171
            && _info.spr_hit==_beam.ntte_full_hit && _info.spr_trail==_beam.ntte_full_trail,
            "Quasar stock Fire failed native metadata capture")
        var _ring_shot=instance_create(13000,13000,Bullet1)
        _ring_shot.team=team_player;_ring_shot.creator=_owner;_ring_shot.speed=0
        _ring_shot.damage=2;_ring_shot.knockback_speed=3*timescale
        _ring_shot.image_xscale=1;_ring_shot.image_yscale=1
        scrNTTEFullMergedQuasarBeamSetup([_ring_shot],_info)
        assert(_ring_shot.damage==14 && abs(_ring_shot.knockback_speed-7*timescale)<0.0001
            && abs(_ring_shot.image_xscale-1.5)<0.0001 && abs(_ring_shot.image_yscale-1.5)<0.0001
            && _ring_shot.temerge_piercing_amount==1
            && abs(_ring_shot.temerge_wall_piercing_count-sqrt(14))<0.0001,
            "Quasar ring lost source scale/damage/force, piercing or sqrt(new damage) wall budget")
        var _beam_shot=instance_create(13300,13000,Bullet1),_still=instance_create(13400,13000,Bullet1)
        _beam_shot.team=team_player;_beam_shot.creator=_owner;_beam_shot.direction=0;_beam_shot.speed=8*timescale
        _still.team=team_player;_still.creator=_owner;_still.speed=0
        _info.is_ring=false;_info.line_dis_max=120;_info.scale_goal=1
        scrNTTEFullMergedQuasarBeamSetup([_beam_shot,_still],_info)
        assert(_beam_shot.x>13300 && _beam_shot.x<=13420 && _still.x==13400
            && _beam_shot.temerge_piercing_amount==1 && !variable_instance_exists(_beam_shot,"temerge_wall_piercing_count"),
            "Quasar beam did not apply its laser only to moving replacement shots")

        var _disc=instance_create(13700,13000,NTTEFullLightningDisc),_disc_info={}
        _disc.ntte_full_super=-1
        with(_disc) scrNTTEFullMergedLightningDiscFire({},_disc_info)
        var _disc_shot=instance_create(13700,13000,Bullet1)
        _disc_shot.team=team_player;_disc_shot.creator=_owner;_disc_shot.speed=0;_disc_shot.damage=20
        scrNTTEFullMergedLightningDiscSetup([_disc_shot],_disc_info)
        assert(!variable_instance_exists(_disc_shot,"temerge_lightning_disc"),"Ordinary lightring incorrectly gained super destruction payload")
        _disc.ntte_full_super=0
        with(_disc) scrNTTEFullMergedLightningDiscFire({},_disc_info)
        scrNTTEFullMergedLightningDiscSetup([_disc_shot],_disc_info)
        scrNTTEFullMergedLightningDiscSetup([_disc_shot],_disc_info)
        assert(_disc_shot.temerge_lightning_disc.super_count==2 && array_length(_disc_shot.temerge_destroy_event_ref_list)==1,
            "Super lightring lost additive count or registered duplicate destruction callbacks")
        var _disc_before=scrNTTEFullInstances(NTTEFullLightningDisc)
        with(_disc_shot) scrNTTEFullMergedLightningDiscDestroy()
        var _discs=scrNTTEFullInstances(NTTEFullLightningDisc),_born=0
        for(var _i=0;_i<array_length(_discs);++_i) if(array_get_index(_disc_before,_discs[_i])<0) {
            var _child=_discs[_i];_born+=1
            assert(abs(_child.ntte_full_charge-1.5)<0.0001 && !_child.ntte_full_follow
                && abs(_child.image_xscale-1.35)<0.0001 && abs(_child.image_yscale-1.35)<0.0001
                && abs(_child.speed-10*timescale)<0.0001 && _child.team==team_player && _child.creator==_owner,
                "Super lightring child lost damage-based instant charge, detached follow, motion or ownership")
        }
        assert(_born==2,"Stacked super lightring destruction emitted the wrong number of discs")
        // LightningDisc hit is validated separately after the original native
        // Lightning ammo/Alarm0 bridge has been integrated by root.

        _owner.x=14000;_owner.y=13000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
        _owner.visible=true;_owner.nexthurt=0
        var _portal=instance_create(14300,13000,NTTEFullPortalBullet),_portal2=instance_create(14600,13000,NTTEFullPortalBullet)
        var _portal_info=scrNTTEFullMergedPortalBind(_portal),_portal_info2=scrNTTEFullMergedPortalBind(_portal2)
        assert(scrNTTEFullMergedPortalBind(_portal)==_portal_info,"Repeated portal binding replaced source closure")
        _portal_info.can_teleport=false
        assert(_portal_info2.can_teleport,"Separate source portal bullets shared one teleport allowance")
        _portal_info.can_teleport=true
        var _pa=instance_create(14300,13000,Bullet1),_pb=instance_create(14320,13000,Bullet1),
            _pt=instance_create(14300,13000,NTTEBabyGator)
        _pa.team=team_player;_pa.creator=_owner;_pa.speed=0;_pa.damage=4
        _pb.team=team_player;_pb.creator=_owner;_pb.speed=0;_pb.damage=4
        _pt.team=team_enemy;_pt.hp=20;_pt.nexthurt=0;_pt.size=2;_pt.speed=0;_pt.solid=false
        var _merge={speed_factor:1,on_setup:_portal.temerge_on_setup,on_hit:_portal.temerge_on_hit,setup_vars:{}}
        scrNTTEFullMergeApplyEffects([_pa,_pb],_merge)
        assert(array_length(_portal_info.teleport_instance_list)==2
            && _pa.image_blend==make_color_rgb(136,0,255) && _pb.image_blend==make_color_rgb(136,0,255),
            "Portal replacement setup lost shared source membership or purple tint")
        with(_pt) with(_pa) event_perform(ev_collision,hitme)
        assert(!_portal_info.can_teleport && _portal_info2.can_teleport && _owner.x==14300 && _owner.y==13000
            && _pt.x==14000 && _pt.y==13000 && _pt.hp==16 && !instance_exists(_pa)
            && _owner.nexthurt>=current_frame+10 && _pb.image_blend==c_white,
            "Portal hit lost one shared swap allowance, native manual hit, creator iframes or sibling tint removal")
        _pt.x=_pb.x;_pt.y=_pb.y;_pt.nexthurt=0
        with(_pt) with(_pb) event_perform(ev_collision,hitme)
        assert(_owner.x==14300 && _pt.x==14320 && _pt.hp==12 && !instance_exists(_pb)
            && !array_length(global.ntte_merge_native_collision_stack),
            "Spent portal sibling teleported twice, duplicated native damage, or leaked native recursion guard")
        var _sounds=global.ntte_full_merged_basic_sound_observer
        assert(array_length(_sounds)>=2 && _sounds[array_length(_sounds)-1].fade==64,
            "Portal teleport lost original default sound falloff")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_mode;global.ntte_merge_native_collision_stack=_stack
        global.ntte_full_merged_basic_sound_observer=_sound
        current_frame=_frame;random_set_seed(_seed)
        ds_list_copy(global.lis_walls_visible,_walls);ds_list_destroy(_walls)
    }
    scrNTTESmokeLog("FULL MERGED STOCK EXTRA: Quasar metadata/ring/beam, lightring ordinary/super counts/charge (hit bridge tested separately), portal per-source refs/one swap/manual native damage/sibling tint/iframes OK @"+string(30/timescale))
}
