// Explicit real-audio-only pressure case. No global channel count changes;
// every voice stopped below was allocated by this fixture.
function scrNTTEFullQuasarAudioPressureTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_voices=[],
        _beam=noone,_full=false,_failed=-999,_owner=instance_find(Player,0);
    try {
        with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(98000,98000,NTTEFullQuasarBeam,0,0);
        _beam.ntte_full_follow=false;_beam.ntte_full_max_distance=0;
        _beam.ntte_full_shrink_delay=100;_beam.ntte_full_scale_goal=1;
        for(var _i=0;_i<512;++_i) {
            var _voice=audio_play_sound(sndNothingBeamLoop,100,true);
            if(_voice>=0) array_push(_voices,_voice);
            _failed=audio_play_sound(sndNothingBeamLoop,0,true);
            if(_failed<0) {_full=true;break;}
            audio_stop_sound(_failed);
        }
        scrNTTESmokeLog("QUASAR AUDIO PRESSURE voices="+string(array_length(_voices))+" probe="+string(_failed));
        assert(_full,"Real audio pressure fixture did not obtain a failed low-priority sound within its bound");
        assert(scrNTTEFullMergedBasicSoundAt(_beam.x,_beam.y,sndToxicBoltGas,0.8,0.9,64)<0,
            "Full audio pool unexpectedly admitted the actual shared positional sound");
        assert(snd_play_pitchvol(sndPistol,0.2,0.8)<0,
            "Full audio pool unexpectedly admitted the native pitch/volume wrapper");
        assert(scrNTTEFullSkinSwap("red crystal",true),
            "Failed red skin sound prevented the ordinary swap return");
        var _saw=instance_create(view_xview+view_width/2,view_yview+view_height/2,NTTEFullSawTrap);
        _saw.spd=0.5;
        with(_saw) scrNTTEFullSawTrapFX();
        assert(_saw.loop_snd<0 && _saw.hp==30,
            "Full audio pool failed to exercise the actual SawTrap allocation branch");
        try {
            with(_beam) event_perform(ev_step,ev_step_normal);
        } catch(_error) {
            scrNTTESmokeLog("QUASAR AUDIO STEP FAILED handle="+string(_beam.ntte_full_loop));
            throw _error;
        }
        assert(_beam.ntte_full_loop<0,"Full audio pool unexpectedly admitted the actual priority-zero Quasar loop");
        for(var _i=0;_i<array_length(_voices);++_i) audio_stop_sound(_voices[_i]);
        _voices=[];
        with(_beam) event_perform(ev_step,ev_step_normal);
        assert(_beam.ntte_full_loop>=0 && audio_is_playing(_beam.ntte_full_loop),
            "Quasar failed to retry the actual loop after owned pressure voices were released");
        assert(abs(audio_sound_get_pitch(_beam.ntte_full_loop)-(0.3+0.1*sin(current_frame/10)))<0.0001
            && abs(audio_sound_get_gain(_beam.ntte_full_loop)-_beam.image_xscale)<0.0001,
            "Recovered Quasar loop lost original pitch/gain");
        with(_saw) scrNTTEFullSawTrapFX();
        assert(_saw.loop_snd>=0 && audio_is_playing(_saw.loop_snd),
            "Actual SawTrap failed to retry after audio allocation became available");
        var _saw_loop=_saw.loop_snd;
        instance_destroy(_saw,false);
        assert(!audio_is_playing(_saw_loop),"SawTrap Cleanup leaked its recovered loop");
        var _loop=_beam.ntte_full_loop;
        instance_destroy(_beam);
        assert(!audio_is_playing(_loop),"Actual Quasar Cleanup leaked the recovered loop");
    } finally {
        for(var _i=0;_i<array_length(_voices);++_i) audio_stop_sound(_voices[_i]);
        scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed);
    }
    scrNTTESmokeLog("FULL QUASAR AUDIO PRESSURE: actual failed handle, safe Step, next-Step recovery/original pitch/gain/Cleanup OK @"+string(30/timescale));
}

function scrNTTEFullQuasarTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),_skills=ds_list_create(),
        _vx=view_xview,_vy=view_yview,_surface=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog(),
        _mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    global.ntte_merge_native_collision_mode=true
    try {
        _owner.x=92000;_owner.y=92000;_owner.team=team_player;_owner.gunangle=0
        var _beam=noone
        with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(92100,92100,NTTEFullQuasarBeam,0,5)
        assert(_beam.damage==12 && _beam.knockback_speed==4*timescale && _beam.typ==0
            && _beam.ntte_full_hit_list==-1 && !_beam.ntte_full_primed && _beam.ntte_full_flame==-1
            && _beam.ntte_full_follow && !_beam.ntte_full_ring && _beam.friction==0.02*timescale*timescale,
            "Quasar original constructor lost lazy map, force, motion, follow or one-shot EndStep")
        // Original CustomProjectile Collision rejects equal teams before its
        // callback and before merged event dispatch. The callback itself only
        // owns a private six-frame map, allowing hp0 and native-iframe hits.
        var _victim=instance_create(_beam.x+40,_beam.y+20,Bandit)
        _victim.hp=100;_victim.team=_beam.team;_victim.nexthurt=current_frame+1000
        _victim.speed=0;_victim.friction=0.2*timescale*timescale;_victim.size=1
        var _speed=_beam.speed
        _beam.ntte_full_test_friendly_hits=0
        scrNTTEFullMergedProjectileAddEvent(_beam,"hit",function() {
            ntte_full_test_friendly_hits+=1;return true
        })
        with(_victim) with(_beam) event_perform(ev_collision,hitme)
        assert(_victim.hp==100 && _beam.speed==_speed && _beam.ntte_full_hit_list==-1
            && _beam.ntte_full_test_friendly_hits==0,
            "Quasar original CustomProjectile outerteam gate allowed friendly callback/merged effects")
        _victim.team=team_enemy
        with(_victim) with(_beam) event_perform(ev_collision,hitme)
        assert(_victim.hp==76 && abs(_beam.speed-_speed*0.95)<0.0001 && _beam.direction==0
            && abs(_victim.direction)<0.0001
            && abs(_victim.speed-(4*timescale+(1-timescale)*_victim.friction/2))<0.0001,
            "Quasar actual hit gained eligibility gate or lost initial double damage/directional NP/FT force")
        with(_victim) with(_beam) event_perform(ev_collision,hitme)
        assert(_victim.hp==76,"Quasar private six-frame cache allowed duplicate actual hit")
        _beam.ntte_full_hit_time=6;_beam.ntte_full_blast=false;_victim.hp=0
        with(_victim) with(_beam) event_perform(ev_collision,hitme)
        assert(_victim.hp==-12,"Quasar private map boundary gained native health/iframe gate")
        _owner.x=_beam.x;_owner.y=_beam.y+32;_owner.hp=100;_owner.nexthurt=current_frame+1000
        _owner.speed=0;_owner.friction=0.2*timescale*timescale
        with(_owner) with(_beam) event_perform(ev_collision,hitme)
        assert(_owner.hp==100,"Quasar actual Collision hit same-team creator")
        _owner.team=team_enemy
        with(_owner) with(_beam) event_perform(ev_collision,hitme)
        assert(_owner.hp==88 && abs(angle_difference(_owner.direction,270))<0.0001,
            "Quasar source NP Player radial force or iframe bypass changed")
        _owner.team=team_player
        var _map=_beam.ntte_full_hit_list
        instance_destroy(_beam)
        assert(!ds_exists(_map,ds_type_map),"Quasar actual Cleanup leaked private hit map")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Grow/follow is one normal Step plus a full source quick-fix Step at
        // first EndStep. The latter builds no trace and executes only once.
        _owner.x=92000;_owner.y=92000;_owner.speed=0;_owner.friction=0.2*timescale*timescale
        _owner.gunangle=0;_owner.wkick=0;_owner.wep=wep_ntte_quasar_rifle
        with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(92100,92100,NTTEFullQuasarBeam,90)
        _beam.ntte_full_shrink_delay=20;_beam.ntte_full_scale_goal=1
        var _wave=_beam.ntte_full_wave
        with(_beam) event_perform(ev_step,ev_step_normal)
        var _force=0.4*timescale+(1-timescale)*_owner.friction/2
        assert(abs(_owner.wkick-8/3)<0.0001 && abs(_owner.speed-_force)<0.0001
            && abs(_beam.ntte_full_hold_x-(_owner.x+_owner.hspeed))<=0.008
            && abs(_beam.ntte_full_hold_y-(_owner.y+_owner.vspeed))<=0.008,
            "Quasar follow lost source angle-dependent recoil, FT push or physical creator prediction")
        with(_beam) event_perform(ev_step,ev_step_end)
        assert(_beam.ntte_full_primed && abs(_beam.ntte_full_wave-(_wave+2*timescale))<0.0001
            && abs(_beam.ntte_full_hit_time-2*timescale)<0.0001 && _beam.ntte_full_max_distance==300
            && _beam.ntte_full_distance==0 && !array_length(_beam.ntte_full_line),
            "Quasar first actual EndStep failed one-shot full Step with zero trace maximum")
        with(_beam) event_perform(ev_step,ev_step_end)
        assert(abs(_beam.ntte_full_hit_time-2*timescale)<0.0001,"Quasar quick-fix repeated on a later EndStep")
        // One visual binding per creator and physical slot. Source ordinary
        // property lookup unwraps stock; a front alone does not add this flag.
        var _binders=scrNTTEFullInstances(NTTEFullQuasarWeaponAngle)
        assert(array_length(_binders)==1 && _binders[0].creator==_owner,"Quasar follow missing unique actual angle binder")
        with(_beam) scrNTTEFullQuasarBeamBindAngle(90)
        assert(instance_number(NTTEFullQuasarWeaponAngle)==1,"Quasar repeated follow duplicated angle binder")
        var _binder=_binders[0]
        _owner.wepangle=0;_owner.gunangle=0;_owner.right=-1
        with(_binder) event_perform(ev_step,ev_step_end)
        assert(_owner.wepangle==90 && _owner.right==-1 && _owner.back==1
            && abs(_binder.ntte_full_angle-90*power(0.7,timescale))<0.0001,
            "Quasar angle binder lost primary angle, exact90 face preservation, back or logical decay")
        var _merged=scrNTTEFullWeaponMerge(wep_revolver,wep_ntte_quasar_rifle)
        _owner.wep=scrNTTEFullWeaponNative(_merged);_owner.wepangle=0;_binder.ntte_full_angle=30
        with(_binder) event_perform(ev_step,ev_step_end)
        assert(_owner.wepangle==0,"Quasar front invented stock ntte_quasar property")
        _binder.ntte_full_primary=false;_owner.bwep=wep_ntte_quasar_blaster;_owner.bwepangle=4;_binder.ntte_full_angle=20
        with(_binder) event_perform(ev_step,ev_step_end)
        assert(_owner.bwepangle==24,"Quasar secondary binder failed independent mounted angle")
        _binder.ntte_full_angle=1
        with(_binder) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_binder),"Quasar angle binder failed source abs<=1 destruction")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Trace snapshot filters teams, but independently bypasses enemy
        // iframes and dispatches the actual collision event at beam origin.
        _owner.x=92000;_owner.y=92000;_owner.speed=0
        view_xview=92100;view_yview=92100
        with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(92120,92120,NTTEFullQuasarBeam)
        _beam.ntte_full_follow=false;_beam.ntte_full_shrink=0;_beam.ntte_full_blast=false
        _victim=instance_create(_beam.x+20,_beam.y,Bandit)
        _victim.team=team_enemy;_victim.hp=100;_victim.nexthurt=current_frame+1000;_victim.solid=false
        var _friend=instance_create(_beam.x+20,_beam.y,Bandit)
        _friend.team=team_player;_friend.hp=100;_friend.solid=false
        _beam.ntte_full_test_hits=0;_beam.ntte_full_test_target=noone
        scrNTTEFullMergedProjectileAddEvent(_beam,"hit",function() {
            ntte_full_test_hits+=1;ntte_full_test_target=other.id
            return true
        })
        with(_beam) event_perform(ev_step,ev_step_normal)
        assert(_victim.hp==88 && _friend.hp==100 && _beam.ntte_full_test_hits==1
            && _beam.ntte_full_test_target==_victim && array_length(_beam.ntte_full_line)>0,
            "Quasar trace lost snapshot team filter, private iframe damage or real merged collision context")
        assert(_beam.ntte_full_line[0].v==0 && _beam.ntte_full_line[1].v==1,
            "Quasar trace collapsed opposite texture edges into the same row")
        assert(!scrNTTEFullQuasarPointSeen(view_xview-40,view_yview+1,40,40)
            && scrNTTEFullQuasarPointSeen(view_xview-39,view_yview+1,40,40),
            "Quasar segment visibility lost strict previous-endpoint border bounds")
        // Native wall stops a beam; ring directly replaces intersecting walls.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(92120,92120,NTTEFullQuasarBeam)
        _beam.ntte_full_follow=false;_beam.ntte_full_shrink=0
        var _wall=instance_create(92140,92120,Wall)
        with(_beam) event_perform(ev_step,ev_step_normal)
        // At120Hz the first source trace reaches only30 logical pixels. Its
        // wall segment sets _walled then exits; blast clears next iteration.
        // A second real Step allows that authored iteration at every FT.
        with(_beam) event_perform(ev_step,ev_step_normal)
        scrNTTESmokeLog("QUASAR WALL DIAG "+json_stringify({ts:timescale,wall:instance_exists(_wall),
            blast:_beam.ntte_full_blast,distance:_beam.ntte_full_distance,vertices:array_length(_beam.ntte_full_line)}))
        assert(instance_exists(_wall) && !_beam.ntte_full_blast,"Quasar normal trace failed source wall braking")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _ring=noone
        with(_owner) _ring=scrNTTEFullMergedBasicProjectileCreate(92120,92120,NTTEFullQuasarRing,0,4)
        assert(_ring.ntte_full_ring && !_ring.ntte_full_follow && _ring.ntte_full_start==-1
            && _ring.ntte_full_stop==-1 && _ring.knockback_speed==timescale && _ring.mask_index==mskExploder
            && _ring.ntte_full_shrink_delay==120 && _ring.ntte_full_ring_timer>=10 && _ring.ntte_full_ring_timer<=30,
            "QuasarRing source actual constructor lost mask/force/timer/follow")
        _ring.ntte_full_ring_timer=-1
        with(_ring) scrNTTEFullQuasarRingEmit()
        var _child=_ring.ntte_full_ring_lasers[0]
        assert(_child.creator==_owner && _child.team==team_player && !_child.visible && !_child.ntte_full_follow
            && _child.speed==0 && _child.ntte_full_start==-1 && _child.image_xscale==0 && _child.image_yscale==0,
            "Quasar ring emission lost BasicCreate default motion/real owner or invisible zero-scale child")
        _ring.ntte_full_ring_timer=-1;_child.image_xscale=1;_child.image_yscale=1
        var _dir=_child.image_angle
        with(_ring) event_perform(ev_step,ev_step_normal)
        assert(abs(_child.ntte_full_hold_x-(_ring.x+_ring.hspeed/timescale+lengthdir_x(57+6*_ring.image_yscale,_dir)))<=0.008
            && abs(_child.ntte_full_hold_y-(_ring.y+_ring.vspeed/timescale+lengthdir_y(57+6*_ring.image_yscale,_dir)))<=0.008
            && array_length(_ring.ntte_full_line)>=4,
            "Quasar ring child hold lost logical velocity prediction or closed native ring trace")
        _wall=instance_create(_ring.x-12,_ring.y+57,Wall)
        var _floors=instance_number(FloorExplo)
        with(_ring) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_wall) && instance_number(FloorExplo)>_floors,
            "Quasar ring failed source two-sided wall mask/direct FloorExplo replacement")
        _ring.ntte_full_blast=false
        _victim=instance_create(_ring.x,_ring.y+20,Bandit);_victim.hp=100;_victim.team=team_player
        with(_victim) with(_ring) event_perform(ev_collision,hitme)
        assert(_victim.hp==100,"QuasarRing inherited CustomProjectile Collision lost outerteam gate")
        _victim.team=team_enemy
        with(_victim) with(_ring) event_perform(ev_collision,hitme)
        assert(_victim.hp==88,"Quasar ring opposing-team actual hit failed")
        with(_victim) with(_ring) event_perform(ev_collision,hitme)
        assert(_victim.hp==88,"Quasar ring private three-frame map failed duplicate guard")
        _ring.ntte_full_hit_time+=3
        with(_victim) with(_ring) event_perform(ev_collision,hitme)
        assert(_victim.hp==76,"Quasar ring source three-frame map failed exact release")
        var _ring_map=_ring.ntte_full_hit_list
        instance_destroy(_ring)
        assert(!instance_exists(_child) && !ds_exists(_ring_map,ds_type_map),"QuasarRing Cleanup leaked child or map")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _ultra=noone
        with(_owner) _ultra=scrNTTEFullMergedBasicProjectileCreate(92120,92120,NTTEFullUltraQuasarBeam)
        assert(_ultra.ntte_full_ultra && _ultra.damage==24 && _ultra.ntte_full_turn_factor==1/50
            && _ultra.ntte_full_flame==scrNTTERefSprite("UltraQuasarBeamFlame")
            && _ultra.mask_index==scrNTTERefSprite("msk.UltraQuasarBeam"),"UltraQuasar actual constructor lost source sprites/mask/turn/damage")
        _victim=instance_create(_ultra.x+32,_ultra.y,Bandit);_victim.hp=1;_victim.size=2
        var _green=instance_number(GreenExplosion),_small=instance_number(SmallExplosion)
        with(_victim) with(_ultra) event_perform(ev_collision,hitme)
        assert(_victim.hp==-47 && instance_number(GreenExplosion)==_green+1 && instance_number(SmallExplosion)==_small+3,
            "UltraQuasar original kill effect lost large victim native green/three small explosions")
        // Actual Draw uses fog for source white flash and normal atlas UVs.
        // This surface is confined to the fixture and restores native state.
        _surface=surface_create(64,64)
        _camera=camera_create_view(0,0,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        _ultra.x=32;_ultra.y=32;_ultra.ntte_full_line=[];_ultra.image_blend=c_red;_ultra.image_alpha=1
        _ultra.ntte_full_flash=current_frame+2
        with(_ultra) event_perform(ev_draw,0)
        surface_reset_target()
        var _pixels=0
        for(var _py=0;_py<64;++_py) for(var _px=0;_px<64;++_px) {
            var _pixel=surface_getpixel(_surface,_px,_py)
            if(color_get_red(_pixel)>0 && color_get_green(_pixel)>0 && color_get_blue(_pixel)>0) _pixels+=1
        }
        var _after_fog=gpu_get_fog()
        assert(_pixels>0 && !_after_fog[0],"Quasar actual Draw lost source white flash/fog reset")
        surface_free(_surface);_surface=-1
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        view_xview=_vx;view_yview=_vy;ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
        global.ntte_merge_native_collision_mode=_mode
    }
    scrNTTESmokeLog("FULL QUASAR LIFECYCLE: actual three classes/original CustomProjectile outerteam/private6+3 map-only callback/NP/FT/Ultra kill, full one-shot EndStep, follow recoil/physical lead, stock-aware angle binder, trace/team/bbox/real callbacks, ring logical child hold/emission/cleanup and actual white-flash Draw OK @"+string(30/timescale))
    scrNTTEFullQuasarBeamColorNativeTests();
    scrNTTEFullQuasarCropNativeTests();
}

function scrNTTEFullQuasarBeamColorNativeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_frame=current_frame,
        _vx=view_xview,_vy=view_yview,_draw=scrNTTEFullCoastDrawState(),_shader=shader_current(),
        _surface=-1,_camera=-1,_target=false;
    gpu_push_state();
    try {
        view_xview=0;view_yview=0;current_frame=64;
        scrNTTESmokeLog("QUASAR legacy boolean edges="+json_stringify([!!-1,!!1]));
        _surface=surface_create(256,128);assert(surface_exists(_surface),"Quasar color surface unavailable");
        _camera=camera_create_view(0,0,256,128,0,noone,-1,-1,-1,-1);
        var _classes=[NTTEFullQuasarBeam,NTTEFullUltraQuasarBeam];
        for(var _kind=0;_kind<array_length(_classes);++_kind) {
            var _beam=instance_create(32,64,_classes[_kind]);
            _beam.ntte_full_follow=false;_beam.ntte_full_shrink=0;_beam.ntte_full_shrink_delay=100;
            _beam.ntte_full_max_distance=160;_beam.image_angle=0;_beam.direction=0;_beam.image_index=0;
            _beam.image_blend=c_white;_beam.image_alpha=1;_beam.hspeed=0;_beam.vspeed=0;
            with(_beam) repeat(4) event_perform(ev_step,ev_step_normal);
            assert(array_length(_beam.ntte_full_line)>=4,"Actual Quasar trace omitted drawable body vertices");
            for(var _v=0;_v<array_length(_beam.ntte_full_line);_v+=2)
                assert(_beam.ntte_full_line[_v].v==0 && _beam.ntte_full_line[_v+1].v==1,
                    "Actual Quasar strip failed to span the source texture across its width");
            for(var _flash=0;_flash<2;++_flash) {
                _beam.ntte_full_flash=current_frame+(_flash?2:-1);
                surface_set_target(_surface);_target=true;camera_apply(_camera);
                matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                gpu_set_texfilter(false);gpu_set_fog(false,c_white,0,0);
                draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1);
                var _diagnostic={kind:_kind,flash:_flash,rate:30/timescale,
                    sprite:sprite_get_name(_beam.sprite_index),frame:_beam.image_index,
                    uv:sprite_get_uvs(_beam.sprite_index,_beam.image_index),
                    texel_width:texture_get_texel_width(sprite_get_texture(_beam.sprite_index,_beam.image_index)),
                    texel_height:texture_get_texel_height(sprite_get_texture(_beam.sprite_index,_beam.image_index)),
                    vertices:array_length(_beam.ntte_full_line),first:_beam.ntte_full_line[0],
                    first_other_side:_beam.ntte_full_line[1],last:_beam.ntte_full_line[array_length(_beam.ntte_full_line)-1],
                    before_target:surface_get_target(),before_fog:gpu_get_fog(),
                    before_world:matrix_get(matrix_world),before_view:matrix_get(matrix_view),
                    before_projection:matrix_get(matrix_projection),shader:shader_current(),
                    ztest:gpu_get_ztestenable(),zwrite:gpu_get_zwriteenable(),
                    alphatest:gpu_get_alphatestenable(),colorwrite:gpu_get_colorwriteenable(),
                    cullmode:gpu_get_cullmode(),texfilter:gpu_get_texfilter(),blendmode:gpu_get_blendmode()};
                with(_beam) event_perform(ev_draw,0);
                _diagnostic.after_target=surface_get_target();_diagnostic.after_fog=gpu_get_fog();
                _diagnostic.after_world=matrix_get(matrix_world);_diagnostic.after_view=matrix_get(matrix_view);
                _diagnostic.after_projection=matrix_get(matrix_projection);
                surface_reset_target();_target=false;
                var _coloured=0,_white=0;
                // Exclude both end sprites: this validates the textured strip.
                for(var _y=40;_y<88;++_y) for(var _x=64;_x<144;++_x) {
                    var _pixel=surface_getpixel(_surface,_x,_y),_r=color_get_red(_pixel),
                        _g=color_get_green(_pixel),_b=color_get_blue(_pixel);
                    if(max(_r,_g,_b)>64 && max(_r,_g,_b)-min(_r,_g,_b)>40) _coloured++;
                    if(min(_r,_g,_b)>200) _white++;
                }
                var _path=working_directory+"ntte-quasar-color-"+string(_kind)+"-"+string(_flash)+"-"+string(30/timescale)+".png";
                surface_save(_surface,_path);
                _diagnostic.colored=_coloured;_diagnostic.white=_white;_diagnostic.image=_path;
                // Render the exact source subimage through native sprite drawing
                // as an independent atlas/color control after preserving the
                // actual beam evidence. It does not replace the strip oracle.
                surface_set_target(_surface);_target=true;camera_apply(_camera);
                matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);
                draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1);
                draw_sprite_ext(_beam.sprite_index,_beam.image_index,64,64,40,1,0,c_white,1);
                surface_reset_target();_target=false;
                var _source_colored=0,_source_white=0;
                for(var _y=40;_y<88;++_y) for(var _x=64;_x<144;++_x) {
                    var _pixel=surface_getpixel(_surface,_x,_y),_r=color_get_red(_pixel),
                        _g=color_get_green(_pixel),_b=color_get_blue(_pixel);
                    if(max(_r,_g,_b)>64 && max(_r,_g,_b)-min(_r,_g,_b)>40) _source_colored++;
                    if(min(_r,_g,_b)>200) _source_white++;
                }
                var _source_path=string_replace(_path,"ntte-quasar-color-","ntte-quasar-texture-");
                surface_save(_surface,_source_path);
                _diagnostic.source_colored=_source_colored;_diagnostic.source_white=_source_white;
                _diagnostic.source_image=_source_path;
                // Immediate primitive APIs may map the sprite texture entry's
                // local UVs themselves. Compare identical geometry and texture
                // with local/atlas UVs and both vertex overloads before making
                // any production change. These are diagnostic-only controls.
                _diagnostic.primitive_controls=[];
                var _texture=sprite_get_texture(_beam.sprite_index,_beam.image_index),
                    _uv=sprite_get_uvs(_beam.sprite_index,_beam.image_index);
                for(var _probe=0;_probe<3;++_probe) {
                    surface_set_target(_surface);_target=true;camera_apply(_camera);
                    matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                    gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);
                    draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1);
                    var _u0=_probe==1 ? _uv[0]:0,_u1=_probe==1 ? _uv[2]:1,
                        _v0=_probe==1 ? _uv[1]:0,_v1=_probe==1 ? _uv[3]:1;
                    draw_primitive_begin_texture(pr_trianglestrip,_texture);
                    if(_probe==2) {
                        draw_vertex_texture(64,48,_u0,_v0);draw_vertex_texture(64,80,_u0,_v1);
                        draw_vertex_texture(144,48,_u1,_v0);draw_vertex_texture(144,80,_u1,_v1);
                    }
                    else {
                        draw_vertex_texture_color(64,48,_u0,_v0,c_white,1);draw_vertex_texture_color(64,80,_u0,_v1,c_white,1);
                        draw_vertex_texture_color(144,48,_u1,_v0,c_white,1);draw_vertex_texture_color(144,80,_u1,_v1,c_white,1);
                    }
                    draw_primitive_end();surface_reset_target();_target=false;
                    var _probe_colored=0,_probe_white=0;
                    for(var _y=40;_y<88;++_y) for(var _x=64;_x<144;++_x) {
                        var _pixel=surface_getpixel(_surface,_x,_y),_r=color_get_red(_pixel),
                            _g=color_get_green(_pixel),_b=color_get_blue(_pixel);
                        if(max(_r,_g,_b)>64 && max(_r,_g,_b)-min(_r,_g,_b)>40) _probe_colored++;
                        if(min(_r,_g,_b)>200) _probe_white++;
                    }
                    var _probe_path=string_replace(_path,"ntte-quasar-color-","ntte-quasar-primitive-"+string(_probe)+"-");
                    surface_save(_surface,_probe_path);
                    array_push(_diagnostic.primitive_controls,{mode:_probe==0 ? "local-color":(_probe==1 ? "atlas-color":"local"),
                        colored:_probe_colored,white:_probe_white,image:_probe_path});
                }
                scrNTTESmokeLog("QUASAR COLOR RENDER DIAGNOSTIC "+json_stringify(_diagnostic));
                assert(_flash ? (_white>40 && _coloured==0):(_coloured>40),
                    "Quasar sustained strip lost authored colors or source initial white flash: "+json_stringify([_kind,_flash,_coloured,_white]));
                scrNTTESmokeLog("QUASAR COLOR kind="+string(_kind)+" flash="+string(_flash)+" colored="+string(_coloured)+" white="+string(_white)+" image="+_path);
            }
            instance_destroy(_beam);
        }
    }
    finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);view_xview=_vx;view_yview=_vy;current_frame=_frame;random_set_seed(_seed);
    }
    scrNTTESmokeLog("QUASAR COLOR actual normal/Ultra trace and Draw, opposite UV edges, sustained colored body and original white flash OK @"+string(30/timescale));
}

function scrNTTEFullQuasarCropNativeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_frame=current_frame,
        _vx=view_xview,_vy=view_yview,_state=scrNTTEFullCoastDrawState(),_shader=shader_current(),
        _surface=-1,_oracle=-1,_legacy=-1,_camera=-1,_target=false,_cases=0,_parked=[];
    gpu_push_state();
    try {
        // The oracle is an open, unoccluded muzzle. Park existing world
        // colliders so a camp wall cannot truncate the real beam trace.
        for(var _i=0;_i<array_length(_before);++_i) {
            var _p=_before[_i];
            if(instance_is(_p,Wall) || instance_is(_p,TopSmall) || instance_is(_p,hitme)) {
                array_push(_parked,_p);instance_deactivate_object(_p);
            }
        }
        view_xview=0;view_yview=0;current_frame=64;
        _surface=surface_create(256,256);_oracle=surface_create(256,256);_legacy=surface_create(256,256);
        assert(surface_exists(_surface) && surface_exists(_oracle) && surface_exists(_legacy),"Quasar seam surfaces unavailable");
        _camera=camera_create_view(0,0,256,256,0,noone,-1,-1,-1,-1);
        var _classes=[NTTEFullQuasarBeam,NTTEFullUltraQuasarBeam],_angles=[0,45,90,137,180,270],_scales=[0.6,1,1.25];
        for(var _kind=0;_kind<2;++_kind) for(var _sub=0;_sub<2;++_sub)
        for(var _a=0;_a<array_length(_angles);++_a) for(var _s=0;_s<3;++_s) {
            var _beam=instance_create(128,128,_classes[_kind]),_angle=_angles[_a],_scale=_scales[_s];
            _beam.ntte_full_follow=false;_beam.ntte_full_shrink=0;_beam.ntte_full_shrink_delay=100;
            _beam.ntte_full_max_distance=160;_beam.ntte_full_distance=160;
            _beam.image_angle=_angle;_beam.direction=_angle;
            _beam.image_blend=c_white;_beam.image_alpha=1;_beam.hspeed=0;_beam.vspeed=0;
            _beam.image_xscale=_scale;_beam.image_yscale=_scale;_beam.image_index=_sub;
            // First two real trace samples have identical full-sprite radii:
            // sample0 has no wobble, sample1 sin(-0.1+0.1)==0.
            _beam.ntte_full_wave=-0.6;_beam.ntte_full_bend=0;_beam.ntte_full_stop=-1;
            with(_beam) scrNTTEFullQuasarBeamLine();
            assert(array_length(_beam.ntte_full_line)>=4,"Quasar seam lacks actual trace samples: "+json_stringify([_kind,_sub,_angle,_scale,view_xview,view_yview,view_width,view_height]));
            var _short=[];
            for(var _i=0;_i<4;++_i) array_push(_short,_beam.ntte_full_line[_i]);
            _beam.ntte_full_line=_short;
            _beam.ntte_full_flash=current_frame-1;
            for(var _pass=0;_pass<3;++_pass) {
                surface_set_target(_pass==0?_surface:(_pass==1?_oracle:_legacy));_target=true;camera_apply(_camera);
                matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);
                draw_set_color(c_white);draw_set_alpha(1);
                if(_pass==1) {
                    // Independent full-sprite draw retains authored margins.
                    draw_sprite_ext(_beam.ntte_full_start,_sub,128,128,_scale,_scale,_angle,c_white,1);
                    draw_sprite_ext(_beam.sprite_index,_sub,128,128,10,_scale,_angle,c_white,1);
                } else if(_pass==0) with(_beam) event_perform(ev_draw,0);
                else {
                    // Negative control: the previous cropped texture stretched
                    // over the full sprite height must fail this same oracle.
                    draw_sprite_ext(_beam.ntte_full_start,_sub,128,128,_scale,_scale,_angle,c_white,1);
                    draw_primitive_begin_texture(pr_trianglestrip,sprite_get_texture(_beam.sprite_index,_sub));
                    for(var _v=0;_v<4;++_v) {
                        var _vertex=_beam.ntte_full_line[_v];
                        draw_vertex_texture_color(_vertex.x+_vertex.xoff*_scale,_vertex.y+_vertex.yoff*_scale,
                            _vertex.u,_vertex.v,c_white,1);
                    }
                    draw_primitive_end();
                }
                surface_reset_target();_target=false;
            }
            var _mismatch=0,_signal=0,_different=[],_raster_edges=0,_legacy_mismatch=0;
            // Away from rasterized outer edges, all source cap/body pixels
            // must agree, including the join on both sides of the muzzle.
            var _h=sprite_get_height(_beam.sprite_index),_uv=sprite_get_uvs(_beam.sprite_index,_sub),
                _top=_uv[5]-_h/2,_bottom=_uv[5]+_h*_uv[7]-_h/2;
            for(var _along=-6;_along<17;++_along) for(var _across=ceil(_top*_scale)+2;_across<floor(_bottom*_scale)-2;++_across) {
                var _x=floor(128+lengthdir_x(_along,_angle)+lengthdir_x(_across,_angle-90)),
                    _y=floor(128+lengthdir_y(_along,_angle)+lengthdir_y(_across,_angle-90)),
                    _actual=surface_getpixel(_surface,_x,_y),_expected=surface_getpixel(_oracle,_x,_y);
                if(_actual!=_expected) {
                    // Native sprite and triangle rasterizers can choose opposite
                    // sides of a texel boundary (observed at Ultra 90deg,1.25).
                    // Permit only a real source-color transition within one
                    // pixel; missing coverage or wider shifts remain failures.
                    var _edge=false;
                    if(_actual!=c_black && _expected!=c_black) {
                        for(var _dx=-1;_dx<=1;++_dx) for(var _dy=-1;_dy<=1;++_dy)
                            if(surface_getpixel(_oracle,_x+_dx,_y+_dy)==_actual) _edge=true;
                    }
                    if(_edge) _raster_edges++;
                    else {_mismatch++;array_push(_different,[_along,_across,_x,_y,_actual,_expected]);}
                }
                if(_expected!=c_black) _signal++;
            }
            // The old error widens the exterior of the beam. Sample that
            // exterior too; the interior alone may be one constant color.
            var _radius=ceil(_h*_scale/2)+3;
            for(var _along=2;_along<17;++_along) for(var _across=-_radius;_across<=_radius;++_across) {
                var _x=floor(128+lengthdir_x(_along,_angle)+lengthdir_x(_across,_angle-90)),
                    _y=floor(128+lengthdir_y(_along,_angle)+lengthdir_y(_across,_angle-90));
                if(surface_getpixel(_oracle,_x,_y)==c_black && surface_getpixel(_legacy,_x,_y)!=c_black)
                    _legacy_mismatch++;
            }
            if(_mismatch>0) {
                surface_save(_surface,working_directory+"ntte-quasar-seam-mismatch-actual.png");
                surface_save(_oracle,working_directory+"ntte-quasar-seam-mismatch-oracle.png");
                scrNTTESmokeLog("QUASAR SEAM MISMATCH "+json_stringify(_different));
            }
            assert(_signal>20 && _mismatch==0,"Quasar cropped strip disagrees with full-sprite cap/body: "+json_stringify([_kind,_sub,_angle,_scale,_signal,_mismatch]));
            assert(_legacy_mismatch>10,"Quasar seam oracle did not reject the former width distortion: "+json_stringify([_kind,_sub,_angle,_scale,_legacy_mismatch]));
            if(_a==0 && _s==1) surface_save(_surface,working_directory+"ntte-quasar-seam-"+string(_kind)+"-"+string(_sub)+"-"+string(30/timescale)+".png");
            _cases++;instance_destroy(_beam);
        }
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(surface_exists(_oracle)) surface_free(_oracle);
        if(surface_exists(_legacy)) surface_free(_legacy);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        view_xview=_vx;view_yview=_vy;current_frame=_frame;random_set_seed(_seed);
    }
    scrNTTESmokeLog("QUASAR CROP native full-sprite seam comparisons="+string(_cases)+" @"+string(30/timescale));
}


function scrNTTEFullQuasarTestPixel(_bytes,_width,_x,_y) {
    return buffer_peek(_bytes,(_y*_width+_x)*4,buffer_u32) & $FFFFFF;
}

// Actual moving Player follow/turn + Draw. Native full-sprite drawing is the
// independent color/coverage oracle, including both green/yellow borders.
function scrNTTEFullQuasarDynamicSeamNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_streams=scrNTTEFullArrayCopy(global.rng_state),_owner=instance_find(Player,0),
        _seed=random_get_seed(),_frame=current_frame,_vx=view_xview,_vy=view_yview,
        _state=scrNTTEFullCoastDrawState(),_shader=shader_current(),_skills=ds_list_create(),
        _actual=-1,_oracle=-1,_camera=-1,_target=false,_parked=[],_cases=0,_ab=-1,_ob=-1;
    gpu_push_state();
    try {
        GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=64;
        view_xview=0;view_yview=0;
        for(var _i=0;_i<array_length(_before);++_i) {
            var _p=_before[_i];
            if(_p!=_owner && (instance_is(_p,Wall) || instance_is(_p,TopSmall) || instance_is(_p,hitme) || instance_is(_p,NTTEFullQuasarWeaponAngle))) {
                array_push(_parked,_p);instance_deactivate_object(_p);
            }
        }
        _actual=surface_create(512,512);_oracle=surface_create(512,512);
        assert(surface_exists(_actual) && surface_exists(_oracle),"Dynamic Quasar surfaces unavailable");
        _camera=camera_create_view(0,0,512,512,0,noone,-1,-1,-1,-1);
        _ab=buffer_create(512*512*4,buffer_fixed,1);_ob=buffer_create(512*512*4,buffer_fixed,1);
        var _classes=[NTTEFullQuasarBeam,NTTEFullUltraQuasarBeam],_angles=[0,45,90,137,180,270],_scales=[2,4];
        for(var _kind=0;_kind<2;++_kind) for(var _sub=0;_sub<2;++_sub)
        for(var _a=0;_a<6;++_a) for(var _s=0;_s<2;++_s) for(var _fraction=0;_fraction<2;++_fraction) {
            var _scale=_scales[_s],_angle=_angles[_a],_cx=256+_fraction*0.375,_cy=256+_fraction*0.625;
            _owner.x=_cx-lengthdir_x(32+32*_scale,_angle);
            _owner.y=_cy-lengthdir_y(32+32*_scale,_angle);
            _owner.xprevious=_owner.x;_owner.yprevious=_owner.y;
            _owner.team=team_player;_owner.gunangle=_angle+20;_owner.wepangle=0;_owner.wkick=0;
            _owner.wep=_kind?wep_ntte_ultra_quasar_rifle:wep_ntte_quasar_rifle;
            _owner.direction=_angle+90;_owner.speed=(1+_fraction)*timescale;_owner.friction=0.2*timescale*timescale;
            var _beam=noone;
            with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(x,y,_classes[_kind],_angle,0);
            _beam.ntte_full_offset=32;_beam.image_xscale=_scale;_beam.image_yscale=_scale;
            _beam.ntte_full_scale_goal=_scale;_beam.ntte_full_shrink_delay=100;
            _beam.ntte_full_max_distance=160;_beam.ntte_full_distance=160;
            _beam.ntte_full_flash=current_frame-1;_beam.image_index=_sub;
            with(_beam) event_perform(ev_step,ev_step_normal);
            with(_beam) event_perform(ev_step,ev_step_end);
            _owner.x+=_owner.hspeed;_owner.y+=_owner.vspeed;
            _beam.ntte_full_wave=-0.6-timescale;
            with(_beam) event_perform(ev_step,ev_step_normal);
            assert(_beam.creator==_owner && _beam.ntte_full_follow && array_length(_beam.ntte_full_line)>=4,
                "Dynamic Quasar lost actual Player follow or the first drawable cross-section");
            var _first=_beam.ntte_full_line[0],_opposite=_beam.ntte_full_line[1],
                _join_x=(_first.x+_opposite.x)/2,_join_y=(_first.y+_opposite.y)/2;
            assert(point_distance(_beam.x,_beam.y,_join_x,_join_y)<0.001,
                "Actual moving Quasar cap/body anchors diverged before Draw");
            for(var _pass=0;_pass<2;++_pass) {
                surface_set_target(_pass==0?_actual:_oracle);_target=true;camera_apply(_camera);
                matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);
                draw_set_color(c_white);draw_set_alpha(0.37);
                if(_pass==0) with(_beam) event_perform(ev_draw,0);
                else {
                    draw_sprite_ext(_beam.ntte_full_start,_sub,_join_x,_join_y,_scale,_scale,_first.dir,c_white,1);
                    draw_sprite_ext(_beam.sprite_index,_sub,_join_x,_join_y,10,_scale,_first.dir,c_white,1);
                }
                if(_pass==0) assert(draw_get_alpha()==1,"Quasar buffer drawing lost source alpha reset");
                surface_reset_target();_target=false;
            }
            buffer_get_surface(_ab,_actual,0);buffer_get_surface(_ob,_oracle,0);
            var _gap=0,_mismatch=0,_signal=0,_green=[0,0],_yellow=[0,0],
                _h=sprite_get_height(_beam.sprite_index),_uv=sprite_get_uvs(_beam.sprite_index,_sub),
                _top=(_uv[5]-_h/2)*_scale,_bottom=(_uv[5]+_h*_uv[7]-_h/2)*_scale;
            for(var _along=-3;_along<=12;++_along) for(var _across=ceil(_top)+2;_across<floor(_bottom)-2;++_across) {
                var _px=floor(_join_x+lengthdir_x(_along,_first.dir)+lengthdir_x(_across,_first.dir-90)),
                    _py=floor(_join_y+lengthdir_y(_along,_first.dir)+lengthdir_y(_across,_first.dir-90)),
                    _got=scrNTTEFullQuasarTestPixel(_ab,512,_px,_py),_want=scrNTTEFullQuasarTestPixel(_ob,512,_px,_py);
                if(_along<=4 && _want!=c_black) {_signal++;if(_got==c_black) _gap++;}
                if(_along<=4 && _got!=_want) {
                    var _boundary=false;
                    if(_got!=c_black && _want!=c_black)
                        for(var _dx=-1;_dx<=1;++_dx) for(var _dy=-1;_dy<=1;++_dy)
                            if(scrNTTEFullQuasarTestPixel(_ob,512,_px+_dx,_py+_dy)==_got) _boundary=true;
                    if(!_boundary) _mismatch++;
                }
                if(_along>=4) {
                    var _side=_across<0?0:1;
                    if(!_kind && color_get_red(_got)>200 && color_get_green(_got)<120 && color_get_blue(_got)<80) {_green[_side]++;_yellow[_side]++;}
                    if(_kind && color_get_green(_got)>200 && color_get_red(_got)<120) _green[_side]++;
                    if(_kind && color_get_green(_got)>220 && color_get_red(_got)>220 && color_get_blue(_got)<80) _yellow[_side]++;
                }
            }
            if(_gap || _mismatch || min(_green[0],_green[1],_yellow[0],_yellow[1])==0) {
                surface_save(_actual,working_directory+"ntte-quasar-dynamic-failed-actual.png");
                surface_save(_oracle,working_directory+"ntte-quasar-dynamic-failed-oracle.png");
            }
            assert(_signal>100 && _gap==0 && _mismatch==0
                && min(_green[0],_green[1],_yellow[0],_yellow[1])>0,
                "Dynamic Quasar native-sprite color/seam disagreement: "+json_stringify([_kind,_sub,_angle,_scale,_fraction,_gap,_mismatch,_green,_yellow]));
            if(_fraction==1 && _s==1 && (_a==0 || _a==4)) {
                var _path=working_directory+"ntte-quasar-dynamic-"+string(_kind)+"-"+string(_sub)+"-"+string(_angle)+"-"+string(30/timescale)+".png";
                surface_save(_actual,_path);surface_save(_oracle,string_replace(_path,"dynamic-","dynamic-oracle-"));
            }
            instance_destroy(_beam);_cases++;
        }
        // A ring can author u>1 while its logical trace length is still growing.
        // All submitted texels must remain in this sprite's atlas entry.
        for(var _kind=0;_kind<2;++_kind) {
            var _ring=instance_create(256,256,NTTEFullQuasarRing);
            if(_kind) with(_ring) scrNTTEFullUltraQuasarCreate();
            _ring.ntte_full_follow=false;_ring.ntte_full_ring_timer=-1;_ring.ntte_full_shrink_delay=100;
            _ring.ntte_full_scale_goal=2;_ring.image_xscale=2;_ring.image_yscale=2;
            _ring.ntte_full_start=-1;_ring.ntte_full_stop=-1;_ring.ntte_full_flash=current_frame-1;
            _ring.ntte_full_distance=40;_ring.ntte_full_max_distance=40;
            with(_ring) event_perform(ev_step,ev_step_normal);
            var _max_u=0;for(var _v=0;_v<array_length(_ring.ntte_full_line);++_v) _max_u=max(_max_u,_ring.ntte_full_line[_v].u);
            assert(_max_u>1,"Actual Quasar ring did not exercise out-of-entry authored u coordinates");
            surface_set_target(_actual);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);draw_set_alpha(1);
            with(_ring) event_perform(ev_draw,0);
            surface_reset_target();_target=false;buffer_get_surface(_ab,_actual,0);
            var _foreign=0,_colored=0;
            for(var _y=0;_y<512;++_y) for(var _x=0;_x<512;++_x) {
                var _pixel=scrNTTEFullQuasarTestPixel(_ab,512,_x,_y);
                if(_pixel!=c_black && _pixel!=c_white) {
                    _colored++;
                    if(_pixel!=make_color_rgb(72,253,8) && _pixel!=c_yellow && _pixel!=make_color_rgb(252,56,0)) _foreign++;
                }
            }
            assert(_colored>100 && _foreign==0,"Actual ring sampled a neighbouring packed atlas sprite: "+json_stringify([_kind,_max_u,_colored,_foreign]));
            surface_save(_actual,working_directory+"ntte-quasar-ring-atlas-"+string(_kind)+"-"+string(30/timescale)+".png");
            instance_destroy(_ring);
        }
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_actual)) surface_free(_actual);if(surface_exists(_oracle)) surface_free(_oracle);
        if(_camera!=-1) camera_destroy(_camera);if(buffer_exists(_ab)) buffer_delete(_ab);if(buffer_exists(_ob)) buffer_delete(_ob);gpu_pop_state();
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);global.rng_state=_streams;ds_list_destroy(_skills);
        view_xview=_vx;view_yview=_vy;current_frame=_frame;random_set_seed(_seed);
    }
    scrNTTEFullQuasarCullingSourceTests();
    scrNTTESmokeLog("QUASAR DYNAMIC SEAM Windows native Player follow/turn, both frames/borders, fractional origins, scale2/4 source-sprite oracle cases="+string(_cases)+" OK @"+string(30/timescale));
}


function scrNTTEFullQuasarSwapIconNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_owner=instance_find(Player,0),
        _seed=random_get_seed(),_state=scrNTTEFullCoastDrawState(),_shader=shader_current(),
        _surface=-1,_camera=-1,_target=false,_bytes=-1,_parked=scrNTTEFullInstances(MobileUI),_cases=0,_diagnostics=[];
    gpu_push_state();
    try {
        for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
        UberCont.custom=true;UberCont.quit_pause=false;UberCont.want_pause=false;UberCont.opt_volumecontrol=false;
        _owner.wep=wep_ntte_ultra_quasar_rifle;_owner.bwep=wep_none;
        _owner.extra_weps=[];_owner.extra_weps_reload=[];_owner.extra_weps_curse=[];
        _owner.reload=0;_owner.breload=0;_owner.curse=false;_owner.bcurse=false;
        var _button=instance_create(128,128,ButtonSwap);_button.x=128;_button.y=128;_button.rad=25;
        _button.smoothrad=0;_button.image_alpha=1;
        _surface=surface_create(256,256);assert(surface_exists(_surface),"Ultra swap icon surface unavailable");
        _camera=camera_create_view(0,0,256,256,0,noone,-1,-1,-1,-1);
        _bytes=buffer_create(256*256*4,buffer_fixed,1);
        // Preserve the ordinary ready-to-fire UI ring as diagnostic evidence.
        // draw_circle_part is rad..rad+width, so this background intentionally
        // extends beyond the button's inner radius. It is not the icon.
        _owner.reload=0;_owner.swapanim=0;_button.rot=45;
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
        gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);
        draw_set_color(c_white);draw_set_alpha(1);scrDrawMobileControls(_owner,0);
        surface_reset_target();_target=false;buffer_get_surface(_bytes,_surface,0);
        var _ready_outside=0,_ready_radius=25*(0.5+scrMobileControlsDrawScale(0))/2;
        for(var _y=0;_y<256;++_y) for(var _x=0;_x<256;++_x)
            if(scrNTTEFullQuasarTestPixel(_bytes,256,_x,_y)!=c_black
                && point_distance(128,128,_x+0.5,_y+0.5)>_ready_radius+1.5) _ready_outside++;
        var _ready_path=working_directory+"ntte-quasar-swap-ready-ring-"+string(30/timescale)+".png";
        surface_save(_surface,_ready_path);
        array_push(_diagnostics,{kind:"source-ready-ring-background",reload:0,radius:_ready_radius,outside:_ready_outside,image:_ready_path});
        // A full reload makes precision=0 (two vertices, no ring triangles).
        // All 24 measured cases still invoke the complete real control Draw.
        // This isolates every icon pixel, including its gray/black border,
        // without increasing the permitted radius or changing production UI.
        _owner.reload=scr_weapon_get_load(_owner.wep);
        var _sizes=[0,0.5,1],_angles=[0,45,90,137],_animations=[0,3];
        for(var _s=0;_s<3;++_s) for(var _a=0;_a<4;++_a) for(var _m=0;_m<2;++_m) {
            _button.rot=45-_angles[_a];_owner.swapanim=_animations[_m];
            var _radius=_button.rad*(0.5+scrMobileControlsDrawScale(_sizes[_s]))/2;
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);
            draw_set_color(c_white);draw_set_alpha(1);
            scrDrawMobileControls(_owner,_sizes[_s]);
            surface_reset_target();_target=false;
            buffer_get_surface(_bytes,_surface,0);
            var _outside=0,_colored=0,_minx=256,_maxx=-1,_miny=256,_maxy=-1;
            for(var _y=0;_y<256;++_y) for(var _x=0;_x<256;++_x) {
                var _pixel=scrNTTEFullQuasarTestPixel(_bytes,256,_x,_y);
                if(_pixel==c_black) continue;
                if(point_distance(128,128,_x+0.5,_y+0.5)>_radius+1.5) _outside++;
                if(max(color_get_red(_pixel),color_get_green(_pixel),color_get_blue(_pixel))
                    -min(color_get_red(_pixel),color_get_green(_pixel),color_get_blue(_pixel))>15) {
                    _colored++;_minx=min(_minx,_x);_maxx=max(_maxx,_x);_miny=min(_miny,_y);_maxy=max(_maxy,_y);
                }
            }
            var _case_path=working_directory+"ntte-quasar-swap-"+string(_sizes[_s])+"-"+string(_angles[_a])+"-"+string(_animations[_m])+"-"+string(30/timescale)+".png";
            var _centered=_a!=0 || _m!=0 || (abs((_minx+_maxx+1)/2-128)<=1.5 && abs((_miny+_maxy+1)/2-128)<=1.5);
            array_push(_diagnostics,{kind:"isolated-actual-control-icon",size:_sizes[_s],angle:_angles[_a],animation:_animations[_m],
                reload:_owner.reload,radius:_radius,outside:_outside,colored:_colored,bounds:[_minx,_miny,_maxx,_maxy],centered:_centered,image:_case_path});
            if(_outside>0 || _colored<=15 || !_centered || (_m==0 && (_a==0 || _a==1))) surface_save(_surface,_case_path);
            assert(_colored>15 && _outside==0,"Actual mobile Ultra swap icon escaped its button: "+json_stringify([_sizes[_s],_angles[_a],_animations[_m],_radius,_outside,_colored]));
            if(_a==0 && _m==0) assert(abs((_minx+_maxx+1)/2-128)<=1.5 && abs((_miny+_maxy+1)/2-128)<=1.5,
                "Actual mobile Ultra swap icon retained a fixed ten-pixel displacement");
            _cases++;
        }
        // The new branch must decline an ordinary weapon, preserving its
        // existing draw path rather than resizing the whole weapon catalog.
        surface_set_target(_surface);_target=true;camera_apply(_camera);draw_clear_alpha(c_black,1);
        assert(!scrNTTEFullQuasarSwapWeaponDraw(wep_revolver,scr_weapon_get_sprite(wep_revolver),0,128,128,2,45,25,c_white,1),
            "Ultra-only swap fit intercepted another weapon");
        surface_reset_target();_target=false;
        buffer_get_surface(_bytes,_surface,0);
        for(var _y=90;_y<166;++_y) for(var _x=90;_x<166;++_x)
            assert(scrNTTEFullQuasarTestPixel(_bytes,256,_x,_y)==c_black,"Ultra-only swap fit drew an ordinary weapon");
        // Required old-layout negative control, using the real oversized art.
        var _sprite=scrNTTERefSprite("UltraQuasarBlaster");
        surface_set_target(_surface);_target=true;camera_apply(_camera);draw_clear_alpha(c_black,1);
        draw_sprite_ext(_sprite,0,128-(round(sprite_get_width(_sprite)/2)-sprite_get_xoffset(_sprite)),
            138-(round(sprite_get_height(_sprite)/2)-sprite_get_yoffset(_sprite)),2,2,45,c_white,1);
        surface_reset_target();_target=false;
        buffer_get_surface(_bytes,_surface,0);
        var _legacy_outside=0;
        for(var _y=0;_y<256;++_y) for(var _x=0;_x<256;++_x)
            if(scrNTTEFullQuasarTestPixel(_bytes,256,_x,_y)!=c_black && point_distance(128,128,_x+0.5,_y+0.5)>26.5) _legacy_outside++;
        assert(_legacy_outside>100,"Swap icon bounds failed to reject the old oversized/origin-shifted draw");
    } finally {
        var _diagnostic_text=json_stringify({rate:30/timescale,cases:_diagnostics}),
            _diagnostic_file=file_text_open_write(working_directory+"ntte-quasar-swap-diagnostic-"+string(30/timescale)+".json");
        if(_diagnostic_file>=0) {file_text_write_string(_diagnostic_file,_diagnostic_text);file_text_close(_diagnostic_file);}
        scrNTTESmokeLog("QUASAR SWAP ICON DIAGNOSTIC "+_diagnostic_text);
        if(_target) surface_reset_target();if(surface_exists(_surface)) surface_free(_surface);
        if(_camera!=-1) camera_destroy(_camera);if(buffer_exists(_bytes)) buffer_delete(_bytes);gpu_pop_state();
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber);random_set_seed(_seed);
    }
    scrNTTESmokeLog("QUASAR SWAP ICON Windows actual mobile Draw, Ultra-only radius fit/center, control sizes/rotations/animation and old-layout negative control cases="+string(_cases)+" OK @"+string(30/timescale));
}

// Candidate54 pre-render-culling Line is frozen below as a literal oracle.
// Tests use real native hit/Wall masks and independent all-birth FX rows.
function scrNTTEFullQuasarCullingSourceTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Quasar culling invariant needs explicit desktop smoke")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),_vx=view_xview,_vy=view_yview,
        _owner=instance_find(Player,0),_skills=ds_list_create(),_parked=[],_cases=0
    try {
        view_xview=0;view_yview=0;current_frame=64
        // Keep the actual creator active while parking ambient camp colliders.
        for(var _i=0;_i<array_length(_before);++_i) {
            var _p=_before[_i]
            if(_p!=_owner && (instance_is(_p,Wall) || instance_is(_p,TopSmall) || instance_is(_p,hitme))) {
                array_push(_parked,_p);instance_deactivate_object(_p)
            }
        }
        for(var _scale=2;_scale<=4;_scale+=2) for(var _path=0;_path<3;++_path) {
            var _case_before=scrNTTEFullInstances(all),_wall=noone,_victim=noone,_results=[],_y=view_height/2
            if(_path==1) {
                _wall=instance_create(35,_y,Wall)
                _wall.image_xscale=0.05;_wall.image_yscale=0.1
                _wall.x+=35-_wall.bbox_left;_wall.y+=_y-(_wall.bbox_top+_wall.bbox_bottom)/2
                assert(_wall.bbox_left>=34 && _wall.bbox_right<40,
                    "Culling invariant's real Wall does not isolate the second ray segment")
            }
            if(_path==2) {
                _victim=instance_create(100,_y,Bandit)
                _victim.hp=1000;_victim.team=team_enemy;_victim.size=1
                _victim.hspeed=0;_victim.vspeed=0;_victim.nexthurt=0
            }
            var _victim_saved=scrNTTEFullAreaGeneratorSnapshot(Bandit)
            for(var _impl=0;_impl<2;++_impl) {
                scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
                scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
                scrNTTEFullAreaGeneratorRestore(_victim_saved)
                GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skills={}
                UberCont.opt_shake=1;UberCont.opt_freeze=1;UberCont.opt_prtcls=true
                _owner.team=team_player;_owner.race=Race.Fish;_owner.bskin=0;_owner.gunangle=0
                _owner.ntte_native_race=-1;_owner.ntte_race_ultra=0
                // This is an offscreen creator at the source's actual held
                // placement: hold+offset32+64*scale/2 gives visible join x20.
                // With a straight onscreen Player these terms cancel in the
                // back probe; do not claim that case reproduces this defect.
                _owner.x=20-32-32*_scale;_owner.y=_y;_owner.hspeed=0;_owner.vspeed=0
                var _local=scrNTTEFullInstances(all),_beam=noone
                random_set_seed(651230+_path);global.rng_state=scrNTTEFullArrayCopy(_streams)
                with(_owner) _beam=scrNTTEFullMergedBasicProjectileCreate(20,_y,NTTEFullUltraQuasarBeam,0,0)
                _beam.ntte_full_follow=true;_beam.ntte_full_offset=32;_beam.ntte_full_hold_x=_owner.x;_beam.ntte_full_hold_y=_owner.y
                _beam.image_xscale=_scale;_beam.image_yscale=_scale;_beam.image_angle=0;_beam.direction=0
                _beam.ntte_full_scale_goal=_scale;_beam.ntte_full_shrink_delay=100
                _beam.ntte_full_max_distance=160;_beam.ntte_full_distance=160;_beam.ntte_full_flash=current_frame-1
                assert(_owner.x<0 && abs(_beam.x-(_owner.x+32+sprite_get_width(_beam.ntte_full_start)*_scale/2))<0.001
                    && !scrNTTEFullQuasarPointSeen(_beam.x-sprite_get_width(_beam.ntte_full_start)*_scale/2,_y,40,40),
                    "Culling fixture lost its visible held muzzle / offscreen original back probe")
                if(_impl==0) with(_beam) scrNTTEFullQuasarCullingLegacyLineTest()
                else with(_beam) scrNTTEFullQuasarBeamLine()
                var _hit=undefined
                if(instance_exists(_victim) && ds_exists(_beam.ntte_full_hit_list,ds_type_map))
                    _hit=ds_map_find_value(_beam.ntte_full_hit_list,string(real(_victim)))
                var _births=[]
                with(all) if(id>_beam) array_push(_births,[object_index,x,y,hspeed,vspeed,direction,
                    sprite_index,image_index,image_angle,image_xscale,image_yscale,
                    scrNTTEFullValue(id,"damage",undefined),scrNTTEFullValue(id,"creator",noone)==_owner])
                var _state=[_beam.x,_beam.y,_beam.hspeed,_beam.vspeed,_beam.direction,
                    _beam.ntte_full_distance,_beam.ntte_full_blast,_beam.ntte_full_hit_time,_hit,
                    instance_exists(_victim)?[_victim.hp,_victim.hspeed,_victim.vspeed]:undefined,
                    BackCont.viewx2,BackCont.viewy2,BackCont.shake,_births]
                var _row={state:json_stringify(_state),seed:random_get_seed(),streams:json_stringify(global.rng_state),
                    probe:random(1),vertices:array_length(_beam.ntte_full_line),
                    firstU:array_length(_beam.ntte_full_line)>0?_beam.ntte_full_line[0].u:undefined,
                    distance:_beam.ntte_full_distance,blast:_beam.ntte_full_blast,
                    hp:instance_exists(_victim)?_victim.hp:undefined,hit:_hit}
                array_push(_results,_row)
                scrNTTEFullMergedRuntimeTestCleanup(_local)
            }
            assert(_results[0].state==_results[1].state && _results[0].seed==_results[1].seed
                && _results[0].streams==_results[1].streams && _results[0].probe==_results[1].probe,
                "Render culling altered literal old distance/blast/hit/FX/motion or RNG: "+json_stringify([_scale,_path,_results]))
            if(_path==1) assert(_results[0].vertices==0 && _results[1].vertices==2
                && _results[0].distance==0 && !_results[0].blast,
                "Visible-only vertex changed the source's empty-before-wall distance reset")
            else assert(_results[0].firstU>0 && _results[1].firstU==0 && _results[1].vertices==_results[0].vertices+2,
                "Offscreen back-probe control did not distinguish old skipped muzzle from repaired rendering")
            if(_path==2) assert(_results[1].hp<1000 && !is_undefined(_results[1].hit),
                "Culling invariant never exercised actual native enemy damage/private hit map")
            scrNTTESmokeLog("QUASAR CULL SOURCE "+json_stringify({rate:30/timescale,scale:_scale,path:_path,
                oldVertices:_results[0].vertices,newVertices:_results[1].vertices,
                oldFirstU:_results[0].firstU,newFirstU:_results[1].firstU,
                distance:_results[1].distance,hp:_results[1].hp,equivalent:true}))
            scrNTTEFullMergedRuntimeTestCleanup(_case_before);_cases++
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        ds_list_destroy(_skills);view_xview=_vx;view_yview=_vy;current_frame=_frame
        global.rng_state=_streams;random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS Quasar render culling vs frozen pre-change Line: "+string(_cases)
        +" real offscreen-owner/muzzle, old-empty-wall and native hit paths; distance/blast/FX/motion/bothRNG preserved @"+string(30/timescale))
}

function scrNTTEFullQuasarCullingLegacyLineTest() {
    var _add=20,_radius=sprite_get_height(sprite_index)/2,_start_dir=image_angle,
        _change=(instance_is(creator,Player) ? 120:40)*timescale,_distance=0,_dir=_start_dir,
        _cx=x,_cy=y,_last_x=x-lengthdir_x(sprite_get_width(ntte_full_start)/2*image_xscale,_dir),
        _last_y=y-lengthdir_y(sprite_get_width(ntte_full_start)/2*image_xscale,_dir),_walled=false,_wob=0,
        _enemies=[],_hitme=scrNTTEFullInstances(hitme),_beam=id
    for(var _i=0;_i<array_length(_hitme);++_i) if(_hitme[_i].team!=team) array_push(_enemies,_hitme[_i])
    if (ntte_full_ring) {
        _add=24*ntte_full_ring_size
        var _xoff=-_add/2,_yoff=57*ntte_full_ring_size
        _cx=x+lengthdir_x(_xoff,_dir)+lengthdir_x(_yoff,_dir-90)
        _cy=y+lengthdir_y(_xoff,_dir)+lengthdir_y(_yoff,_dir-90)
        _last_x=_cx; _last_y=_cy
        motion_add(random(360),0.2/(speed/max(0.001,timescale)+1)*timescale*timescale)
        var _rings=scrNTTEFullInstances(NTTEFullQuasarBeam)
        if(place_meeting(x,y,object_index)) for(var _i=0;_i<array_length(_rings);++_i) {
            var _r=_rings[_i]
            var _meeting=false
            if(_r!=id && _r.ntte_full_ring && scrNTTEFullQuasarBBoxOverlap(id,_r)) with(_r) _meeting=place_meeting(x,y,other.id)
            if (_meeting) {
                var _away=point_direction(x,y,_r.x,_r.y)
                _r.x+=lengthdir_x(0.5*timescale,_away); _r.y+=lengthdir_y(0.5*timescale,_away)
                with (_r) motion_add(_away,0.03*timescale*timescale)
            }
        }
        var _live=[]
        for(var _i=0;_i<array_length(ntte_full_ring_lasers);++_i)
            if (instance_exists(ntte_full_ring_lasers[_i])) array_push(_live,ntte_full_ring_lasers[_i])
        ntte_full_ring_lasers=_live
        for(var _i=0;_i<array_length(_live);++_i) {
            var _p=_live[_i],_length=_yoff+(ntte_full_ultra ? 10:6)*image_yscale
            _p.ntte_full_hold_x=x+hspeed/timescale+lengthdir_x(_length,_p.image_angle)
            _p.ntte_full_hold_y=y+vspeed/timescale+lengthdir_y(_length,_p.image_angle)
            _p.ntte_full_direction_goal+=4*timescale*sin(_p.ntte_full_wave/30+array_length(_live)+_i)
        }
    }
    ntte_full_line=[]; ntte_full_distance=clamp(ntte_full_distance+_change,0,ntte_full_max_distance)
    if (collision_line(_last_x,_last_y,_cx,_cy,TopSmall,false,false)) ntte_full_distance=0
    if(_add>0 && ntte_full_distance>0) while(true) {
        var _seen=scrNTTEFullQuasarPointSeen(_last_x,_last_y,_add*2,_add*2)
        if (!_walled) {
            if (!ntte_full_ring && collision_line(_last_x,_last_y,_cx,_cy,Wall,false,false)) _walled=true
            else if (_seen) {
                var _r=_radius,_vertex_x=_cx+hspeed,_vertex_y=_cy+vspeed,_normal=_dir-90
                if (ntte_full_ring) {
                    var _o=(2+2*ntte_full_ring_size*image_yscale)/max(ntte_full_shrink_delay/20,1)
                    _vertex_x+=lengthdir_x(_o,_normal)*dcos(_dir*2+ntte_full_wave*4)
                    _vertex_y+=lengthdir_y(_o,_normal)*dsin(_dir*10+ntte_full_wave*4)
                    _normal-=(_add/ntte_full_ring_size)*0.5
                }
                else _r*=1+0.1*sin(ntte_full_wave/6+_wob/10)*min(1,_wob/3)
                for(var _side=-1;_side<=1;_side+=2) {
                    array_push(ntte_full_line,{x:_vertex_x,y:_vertex_y,dir:_dir,
                        xoff:lengthdir_x(_r*_side,_normal),yoff:lengthdir_y(_r*_side,_normal),
                        // Map the authored -1/+1 sides to opposite texture edges.
                        u:_distance/ntte_full_distance,v:(_side+1)/2})
                }
            }
        }
        else {
            ntte_full_blast=false; ntte_full_distance-=_change
            if (array_length(ntte_full_line)==0) ntte_full_distance=0
        }
        var _ox=x,_oy=y
        x=_cx; y=_cy
        if (ntte_full_ring && place_meeting(x,y,Wall)) {
            speed*=0.96
            var _walls=ds_list_create()
            collision_rectangle_list(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall,false,true,_walls,false)
            for(var _i=0;_i<ds_list_size(_walls);++_i) {
                var _wall=_walls[| _i]
                var _meeting=false
                if(instance_exists(_wall) && scrNTTEFullQuasarBBoxOverlap(id,_wall)) with(_wall) _meeting=place_meeting(x,y,other.id)
                if (_meeting) {
                    instance_create(_wall.x,_wall.y,FloorExplo); instance_destroy(_wall)
                }
            }
            ds_list_destroy(_walls)
        }
        if(place_meeting(x,y,hitme)) for(var _i=0;_i<array_length(_enemies);++_i) {
            var _victim=_enemies[_i],_meeting=false
            if(instance_exists(_victim) && scrNTTEFullQuasarBBoxOverlap(id,_victim)) with(_victim) _meeting=place_meeting(x,y,other.id)
            if (!_meeting) continue
            if (instance_is(_victim,Player) && (_walled || collision_line(_victim.x,_victim.y,_last_x,_last_y,Wall,false,false))) continue
            var _key=string(real(_victim))
            if(!ds_exists(ntte_full_hit_list,ds_type_map)) ntte_full_hit_list=ds_map_create()
            if (!ds_map_exists(ntte_full_hit_list,_key) || ntte_full_hit_list[? _key]<=ntte_full_hit_time) {
                var _fx=instance_create(x+orandom(8),y+orandom(8),BulletHit)
                _fx.sprite_index=ntte_full_hit; _fx.image_xscale=image_yscale; _fx.image_yscale=image_yscale; _fx.depth=depth-1
                scrNTTEFullNativeMotionAddFT(_fx,point_direction(x,y,_fx.x,_fx.y),1)
                _fx.image_angle=_fx.direction
                if (!ntte_full_ring) direction=_dir
                x=_ox; y=_oy
                // Real Collision dispatch preserves temerge's mounted callback.
                with(_victim) with(_beam) event_perform(ev_collision,hitme)
                if(!instance_exists(_beam)) return;
                x=_cx; y=_cy
            }
            if (instance_is(creator,Player) && (!instance_exists(_victim) || _victim.hp<=0 || _victim.size>=(image_yscale<=1 ? 3:4) || ntte_full_blast)) ntte_full_distance=_distance
            ntte_full_blast=false
        }
        x=_ox; y=_oy
        if (_seen && random(160/_add)<timescale && position_meeting(_cx,_cy,Floor)) {
            var _off=(ntte_full_ultra ? 24:32)*image_yscale,_fx=instance_create(_cx+orandom(_off),_cy+orandom(_off),PlasmaTrail)
            _fx.sprite_index=ntte_full_trail
            if (ntte_full_ultra) { _fx.image_angle=_dir; _fx.image_xscale=random_range(2/3,1); _fx.image_yscale=_fx.image_xscale }
            scrNTTEFullNativeMotionAddFT(_fx,_dir,1+random(max(image_yscale-1,0)))
            if (image_yscale>1) _fx.depth=depth-1
        }
        _last_x=_cx; _last_y=_cy; _cx+=lengthdir_x(_add,_dir); _cy+=lengthdir_y(_add,_dir); _distance+=_add
        if (ntte_full_ring) _dir+=_add/ntte_full_ring_size
        else _dir=clamp(_dir+ntte_full_bend/(48/_add),_start_dir-90,_start_dir+90)
        if ((!ntte_full_ring && _distance>=ntte_full_distance) || (ntte_full_ring && abs(_dir-_start_dir)>360)) {
            if (_distance>=ntte_full_max_distance) ntte_full_blast=false
            if (ntte_full_ring && array_length(ntte_full_line)>0) {
                array_push(ntte_full_line,ntte_full_line[0]); array_push(ntte_full_line,ntte_full_line[1])
            }
            break
        }
        _wob+=1
    }
    if(!ntte_full_ring) {
        if(random(4)<timescale) {
            var _xoff=orandom(12)-(12*image_xscale+_add),_yoff=orandom(random(28*image_yscale)),
                _fx_x=(_walled?_last_x:_cx)+lengthdir_x(_xoff,_dir)+lengthdir_x(_yoff,_dir-90),
                _fx_y=(_walled?_last_y:_cy)+lengthdir_y(_xoff,_dir)+lengthdir_y(_yoff,_dir-90)
            if(!position_meeting(_fx_x,_fx_y,TopSmall)) {
                var _fx=instance_create(_fx_x,_fx_y,BulletHit)
                _fx.sprite_index=ntte_full_hit;_fx.image_xscale=image_yscale;_fx.image_yscale=image_yscale;_fx.depth=depth-1
                instance_create(_fx.x,_fx.y,Smoke)
            }
        }
        scrNTTEFullTrenchShake(_cx,_cy,4,true)
    }
    scrNTTEFullTrenchShake(x,y,4,true)
}

