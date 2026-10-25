// Original tepickups.Prompt + ntte_begin_step collision selector. Native
// interaction HUD/ButtonAct and KeyCont.press_pick remain the input path.
function scrNTTEFullPromptCreate(_owner,_text="",_mask=mskWepPickup,_xoff=0,_yoff=0) {
    if(!instance_exists(_owner)) return noone
    var _prompt=instance_create(_owner.x,_owner.y,NTTEFullPrompt)
    _prompt.creator=_owner; _prompt.depth=_owner.depth; _prompt.name=_text; _prompt.text=_text
    _prompt.mask_index=_mask; _prompt.xoff=_xoff; _prompt.yoff=_yoff
    return _prompt
}
function scrNTTEFullPromptCreateEvent() {
    creator=noone; nearwep=noone; name=""; text=""; pick=-1; xoff=0; yoff=0; on_meet=undefined
    mask_index=mskWepPickup; sprite_index=mskShield; image_speed=0
    persistent=true; depth=0; ntte_prompt=true
}
function scrNTTEFullPromptStep() {
    if(creator!=noone) {
        if(!instance_exists(creator)) { instance_destroy(); return; }
        x=creator.x; y=creator.y
    }
    name=text
}
function scrNTTEFullPromptWinner(_player) {
    if(!instance_exists(_player) || !_player.visible || !_player.can_pick) return noone
    var _winner=noone,_depth=infinity,_distance=infinity
    // Native priority blockers are checked exactly before custom prompts.
    var _blocked=false
    with(_player) _blocked=place_meeting(x,y,IceFlower) || place_meeting(x,y,CarVenusFixed)
    if(_blocked) return noone
    with(Van) if(can_hq && drawspr==sprVanDeactivate && place_meeting(x,y,_player)) return noone
    var _native=instance_nearest(_player.x,_player.y,WepPickup)
    var _touching=false
    if(instance_exists(_native)) with(_native) _touching=place_meeting(x,y,_player)
    if(instance_exists(_native) && _native.visible && !_native.autopick && _touching) {
        _depth=_native.depth; _distance=point_distance(_player.x,_player.y,_native.x,_native.y)
    }
    with(NTTEFullPrompt) if(visible && (!instance_exists(creator) || creator.visible) && place_meeting(x,y,_player)) {
        if(is_callable(on_meet) && !on_meet(_player)) continue
        var _d=point_distance(x,y,_player.x,_player.y)
        if(depth<_depth || (depth==_depth && _d<_distance)) {
            _winner=id; _depth=depth; _distance=_d
        }
    }
    return _winner
}
function scrNTTEFullPromptPlayerStep() {
    var _player=id
    with(NTTEFullPrompt) if(pick==_player.index) pick=-1
    var _winner=scrNTTEFullPromptWinner(id)
    if(instance_exists(_winner)) {
        _winner.nearwep=_winner
        if(KeyCont.press_pick[index]) _winner.pick=index
    }
}
function scrNTTEFullPromptHUDAllows(_player,_candidate) {
    var _winner=scrNTTEFullPromptWinner(_player)
    if(instance_is(_candidate,NTTEFullPrompt)) return _winner==_candidate
    return !instance_exists(_winner)
}
// VaultFlower/PalaceAltar shared source prompt mutation icon. Native HUD already
// owns per-player visibility and selection; draw from that actual winner.
function scrNTTEFullVaultFlowerPromptMeet(_player) {
    ntte_skill_icon=true
    return true
}
function scrNTTEFullPromptSkillIcon(_x,_y) {
    var _icon=scrNTTEFullPromptMutationIcon(id)
    if(is_undefined(_icon)) return;
    var _skill=scrNTTEFullValue(creator,"skill",undefined)
    draw_sprite(_icon[0],_icon[1],_x,_y-13)
    if(scr_skill_get(mut_patience)>0 && GameCont.patienceskill==_skill) draw_sprite(sprPatienceIconHUD,0,_x,_y-13)
}

function scrNTTEFullPromptTests() {
    var _p=instance_find(Player,0),_old_pick=KeyCont.press_pick[_p.index],_can=_p.can_pick
    _p.can_pick=true
    var _owner=instance_create(_p.x,_p.y,BulletHit),_a=scrNTTEFullPromptCreate(_owner,"TEST",mskWepPickup)
    _owner.visible=true; _a.depth=-100
    assert(scrNTTEFullPromptWinner(_p)==_a,"Prompt failed native pickup overlap/priority selection")
    KeyCont.press_pick[_p.index]=true
    with(_p) scrNTTEFullPromptPlayerStep()
    assert(_a.pick==_p.index && scrNTTEFullPromptHUDAllows(_p,_a),"Prompt did not use the shared native pickup key")
    KeyCont.press_pick[_p.index]=false
    with(_p) scrNTTEFullPromptPlayerStep()
    assert(_a.pick==-1,"Prompt pickup selection persisted without a new native press")
    _a.visible=false
    assert(scrNTTEFullPromptWinner(_p)==noone,"Invisible prompt remained interactive")
    instance_destroy(_a,false); instance_destroy(_owner,false)
    _p.can_pick=_can; KeyCont.press_pick[_p.index]=_old_pick
    scrNTTEFullPromptTouchRenderTests()
    scrNTTESmokeLog("SYSTEMS PROMPT: original priority/overlap/visibility, shared native pickup key, one-frame selection and HUD selection OK")
}

// Real native interaction HUD with actual touch state and ButtonAct, not a
// direct invocation of the icon helper. Mutations, generic prompt, Patience
// and the ordinary weapon path are compared against isolated sprite draws.
function scrNTTEFullPromptTouchRenderTests() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _parked=scrNTTEFullInstances([NTTEFullPrompt,ButtonAct,WepPickup,Van,IceFlower,CarVenusFixed]),
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _shader=shader_current(),_surface=-1,_reference=-1,_camera=-1,_target=false,
        _skills=ds_list_create(),_viewx=view_xview,_viewy=view_yview
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        GameCont.skills=_skills
        _p.x=187000;_p.y=187000;_p.can_pick=true;_p.visible=true
        KeyCont.touch[_p.index]=true
        view_xview=0;view_yview=0
        var _button=instance_create(160,96,ButtonAct)
        _button.x=160;_button.y=96;_button.rad=25;_button.alpha=1
        var _owner=instance_create(_p.x,_p.y,BulletHit),
            _prompt=scrNTTEFullPromptCreate(_owner,"REROLL",mskLast)
        _owner.visible=true;_prompt.depth=-100
        _prompt.on_meet=method(_prompt,scrNTTEFullVaultFlowerPromptMeet)
        _surface=surface_create(320,192);_reference=surface_create(320,192)
        assert(surface_exists(_surface) && surface_exists(_reference),"Touch prompt could not allocate render surfaces")
        _camera=camera_create_view(0,0,320,192,0,noone,-1,-1,-1,-1)
        var _skills_to_show=[mut_last_wish,mut_heavy_heart,NTTEFullSkill.Compassion,undefined,mut_last_wish],
            _sprites=[sprSkillIconHUD,sprSkillIconHUD,scrNTTERefSprite("Skill.Compassion.HUD"),sprMobilePickup,sprSkillIconHUD],
            _frames=[mut_last_wish,mut_heavy_heart,0,0,mut_last_wish],
            _labels=["last-wish","heavy-heart","compassion","generic","patience"]
        for(var _pass=0;_pass<6;++_pass) {
            var _weapon=_pass==5,_sprite,_frame,_label
            ds_list_clear(_skills)
            if(_pass==4) {ds_list_add(_skills,mut_patience);GameCont.patienceskill=mut_last_wish}
            if(_weapon) {
                _prompt.visible=false
                var _pickup=scrWeaponPickupCreate(_p.x,_p.y,wep_revolver)
                _pickup.image_angle=0;_pickup.image_index=0;_pickup.image_xscale=1;_pickup.image_yscale=1
                _sprite=sprRevolver;_frame=0;_label="weapon"
            } else {
                _owner.skill=_skills_to_show[_pass]
                _prompt.ntte_skill_icon=_pass!=3
                _prompt.on_meet=_pass==3?undefined:method(_prompt,scrNTTEFullVaultFlowerPromptMeet)
                _sprite=_sprites[_pass];_frame=_frames[_pass];_label=_labels[_pass]
                assert(scrNTTEFullPromptWinner(_p)==_prompt,"Actual touch fixture lost winning prompt")
            }
            surface_set_target(_surface);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
            gpu_set_texfilter(false);draw_clear_alpha(c_black,1);draw_set_alpha(1);draw_set_color(c_white)
            scrDrawInteractionHUD(_p)
            surface_reset_target();_target=false
            var _path="ntte-touch-"+_label+"-"+string(30/timescale)+".png"
            surface_save(_surface,working_directory+_path)
            assert(file_exists(working_directory+_path),"Actual touch HUD screenshot was not saved")
            // x+42 lies beyond the real button, inside the former 64*1.6
            // white collision circle. It must stay untouched background.
            assert(surface_getpixel(_surface,202,96)==c_black,
                "Touch interaction HUD drew collision-mask white disk outside ButtonAct: "+_label)
            surface_set_target(_reference);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,1)
            if(_weapon) {
                // Preserve the original ordinary-weapon centering/1.6 scale.
                draw_sprite_ext(_sprite,_frame,160+(sprite_get_xoffset(_sprite)-sprite_get_width(_sprite) div 2)*1.6,
                    96+(sprite_get_yoffset(_sprite)-sprite_get_height(_sprite) div 2)*1.6,1.6,1.6,0,c_white,1)
            } else {
                // Known16px mutation icons render at exactly2x within rad25.
                // The12x14 generic pickup also fits2x, including its low origin.
                draw_sprite_ext(_sprite,_frame,160+(sprite_get_xoffset(_sprite)-sprite_get_width(_sprite)/2)*2,
                    96+(sprite_get_yoffset(_sprite)-sprite_get_height(_sprite)/2)*2,2,2,0,c_white,1)
                if(_pass==4) draw_sprite_ext(sprPatienceIconHUD,0,160,96,2,2,0,c_white,1)
            }
            surface_reset_target();_target=false
            var _pixels=0
            for(var _y=72;_y<120;++_y) for(var _x=136;_x<184;++_x) {
                var _expected=surface_getpixel(_reference,_x,_y),_actual=surface_getpixel(_surface,_x,_y)
                assert(_actual==_expected,"Actual touch HUD differs from target mutation/ordinary pickup art: "+_label)
                if(_expected!=c_black) _pixels++
            }
            assert(_pixels>8,"Actual touch HUD target icon has no visible pixels: "+_label)
            scrNTTESmokeLog("TOUCH HUD PIXELS "+_label+" matched="+string(_pixels)+" image="+_path)
            if(_weapon) instance_destroy(_pickup,false)
        }
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_reference)) surface_free(_reference)
        if(_camera!=-1) camera_destroy(_camera)
        gpu_pop_state()
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        view_xview=_viewx;view_yview=_viewy
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_game)
        ds_list_destroy(_skills);random_set_seed(_seed)
    }
    scrNTTESmokeLog("TOUCH HUD real native winner + touch + ButtonAct: vanilla/custom/Patience/generic/weapon exact sprite pixels, no white collision disk @"+string(30/timescale))
}

// Resolve the owner's actual mutation for both world and touch prompts.
function scrNTTEFullPromptMutationIcon(_prompt) {
    if(!instance_exists(_prompt) || !scrNTTEFullValue(_prompt,"ntte_skill_icon",false)) return undefined
    var _owner=scrNTTEFullValue(_prompt,"creator",noone)
    if(!instance_exists(_owner)) return undefined
    var _skill=scrNTTEFullValue(_owner,"skill",undefined)
    if(is_string(_skill)) _skill=scrNTTEFullSkillId(_skill)
    if(!is_numeric(_skill) || _skill<0 || _skill!=floor(_skill)) return undefined
    var _icon=_skill>=30?scrNTTEFullSkillIcon(_skill):[sprSkillIconHUD,_skill]
    if(!sprite_exists(_icon[0]) || _icon[1]<0 || _icon[1]>=sprite_get_number(_icon[0])) return undefined
    return _icon
}
function scrNTTEFullPromptDrawCentered(_sprite,_frame,_x,_y,_scale) {
    var _dx=(sprite_get_xoffset(_sprite)-sprite_get_width(_sprite)/2)*_scale,
        _dy=(sprite_get_yoffset(_sprite)-sprite_get_height(_sprite)/2)*_scale
    draw_sprite_ext(_sprite,_frame,round(_x+_dx),round(_y+_dy),_scale,_scale,0,c_white,1)
}
function scrNTTEFullPromptTouchIcon(_prompt,_x,_y,_radius) {
    var _icon=scrNTTEFullPromptMutationIcon(_prompt)
    if(is_undefined(_icon)) _icon=[sprMobilePickup,0]
    var _sprite=_icon[0],_extent=max(sprite_get_width(_sprite),sprite_get_height(_sprite)),
        _scale=max(1,min(2,floor(_radius*1.6/max(1,_extent))))
    scrNTTEFullPromptDrawCentered(_sprite,_icon[1],_x,_y,_scale)
    if(scrNTTEFullValue(_prompt,"ntte_skill_icon",false) && instance_exists(_prompt.creator)) {
        var _skill=scrNTTEFullValue(_prompt.creator,"skill",undefined)
        if(scr_skill_get(mut_patience)>0 && GameCont.patienceskill==_skill)
            draw_sprite_ext(sprPatienceIconHUD,0,round(_x),round(_y),_scale,_scale,0,c_white,1)
    }
}
