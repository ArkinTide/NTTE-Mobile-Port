// teassets.shader_setup: source arguments are logarithmic exponents.
// [1] means 1/2, [2] means 1/4; it never means alpha squared.
function scrNTTEFullSourceShaderEnabled() {
    return scrNTTEFullOptionGet("shaders") && !instance_exists(Menu)
}
function scrNTTEFullSourceUnblendBegin(_arg) {
    if(!scrNTTEFullSourceShaderEnabled() || !shader_is_compiled(shNTTEFullSourceUnblend)) return false
    shader_set(shNTTEFullSourceUnblend)
    shader_set_uniform_f(shader_get_uniform(shNTTEFullSourceUnblend,"blendPower"),1/power(2,_arg))
    return true
}
function scrNTTEFullSourceCharmShaderBegin(_width,_height) {
    if(!scrNTTEFullSourceShaderEnabled() || !shader_is_compiled(shNTTEFullSourceCharm)) return false
    shader_set(shNTTEFullSourceCharm)
    shader_set_uniform_f(shader_get_uniform(shNTTEFullSourceCharm,"pixelSize"),1/_width,1/_height)
    return true
}
function scrNTTEFullOutlineManager() {
    var _manager=instance_find(NTTEFullOutlineCache,0)
    if(!instance_exists(_manager)) _manager=instance_create(0,0,NTTEFullOutlineCache)
    return _manager
}
function scrNTTEFullOutlineCacheCreate() {
    entries={};groups=[];outline_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
    visible=false
}
function scrNTTEFullOutlineCacheSetup(_name,_width,_height,_scale) {
    var _manager=scrNTTEFullOutlineManager(),_entries=_manager.entries,
        _entry=scrNTTEFullValue(_entries,_name,undefined),
        _w=max(1,floor(_width*_scale)),_h=max(1,floor(_height*_scale))
    if(!is_struct(_entry)) {_entry={surf:-1,w:_width,h:_height,scale:_scale,time:30};_entries[$ _name]=_entry;}
    if(!surface_exists(_entry.surf) || surface_get_width(_entry.surf)!=_w || surface_get_height(_entry.surf)!=_h) {
        if(surface_exists(_entry.surf)) surface_free(_entry.surf)
        _entry.surf=surface_create(_w,_h)
    }
    _entry.w=_width;_entry.h=_height;_entry.scale=_scale
    if(_entry.time>=0) _entry.time=max(_entry.time,30)
    return _entry
}
function scrNTTEFullOutlineCacheStep() {
    if(lockstep_stop) return;
    var _keys=variable_struct_get_names(entries)
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _entry=entries[$ _keys[_i]]
        if(_entry.time>0) {
            _entry.time=max(0,_entry.time-timescale)
            if(_entry.time<=0 && surface_exists(_entry.surf)) {surface_free(_entry.surf);_entry.surf=-1;}
        }
    }
}
function scrNTTEFullOutlineCacheCleanup() {
    var _keys=variable_struct_get_names(entries)
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _entry=entries[$ _keys[_i]]
        if(surface_exists(_entry.surf)) surface_free(_entry.surf)
    }
    if(outline_camera>=0) camera_destroy(outline_camera)
}
function scrNTTEFullOutlineFrameScale() {
    var _target=surface_get_target()
    if(surface_exists(_target)) return surface_get_width(_target)/view_width
    if(surface_exists(application_surface)) return surface_get_width(application_surface)/view_width
    return 1
}
function scrNTTEFullOutlineCamera() {
    var _camera=scrNTTEFullOutlineManager().outline_camera
    camera_set_view_pos(_camera,view_xview,view_yview)
    camera_set_view_size(_camera,view_width,view_height)
    camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
}
function scrNTTEFullOutlineSurfaceDraw(_entry,_x,_y,_color=c_white) {
    draw_surface_ext(_entry.surf,_x,_y,1/_entry.scale,1/_entry.scale,0,_color,1)
}
// Capture is isolated rather than clearing/restoring the live framebuffer:
// the source body is drawn against the same transparent black, at the same
// framebuffer resolution, and the existing scene stays intact throughout.
function scrNTTEFullOutlineBodyCache(_raw,_cache) {
    surface_set_target(_cache.surf)
    try {
        scrNTTEFullOutlineCamera();draw_clear_alpha(c_black,0)
        gpu_set_blendmode_ext(bm_one,bm_zero)
        if(scrNTTEFullSourceUnblendBegin(1)) {
            scrNTTEFullOutlineSurfaceDraw(_raw,view_xview,view_yview);shader_reset()
        }
        else {
            scrNTTEFullOutlineSurfaceDraw(_raw,view_xview,view_yview)
            gpu_set_blendmode_ext(bm_inv_src_alpha,bm_one)
            scrNTTEFullOutlineSurfaceDraw(_raw,view_xview,view_yview)
        }
    }
    finally {surface_reset_target();shader_reset();}
}
function scrNTTEFullOutlineOwnerColor(_index) {
    var _owner=scr_playerinstance_find(_index)
    return is_struct(_owner)?_owner.color:c_white
}
function scrNTTEFullPetBodyDraw() {
    var _draw=scrNTTEFullValue(hooks,"draw",undefined),_alpha=image_alpha*(instance_exists(revive)?0.4:1)
    if(is_callable(_draw)) _draw(sprite_index,image_index,x,y,right*image_xscale,image_yscale,image_angle+portal_angle,image_blend,_alpha)
    else draw_sprite_ext(sprite_index,image_index,x,y,right*image_xscale,image_yscale,image_angle+portal_angle,image_blend,_alpha)
}
function scrNTTEFullPetOutlineDraw() {
    var _local=scr_playerinstance_find(global.index)
    if(!scrNTTEFullOptionGet("outline:pets") || !instance_exists(leader) || instance_exists(revive)
        || !is_struct(_local) || !_local.is_local()) return false
    var _raw=scrNTTEFullOutlineCacheSetup("PetScreen",view_width,view_height,scrNTTEFullOutlineFrameScale()),
        _cache=scrNTTEFullOutlineCacheSetup("Pet",view_width,view_height,scrNTTEFullOptionGet("quality:main"))
    if(!surface_exists(_raw.surf) || !surface_exists(_cache.surf)) return false
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),_target=false
    gpu_push_state()
    try {
        shader_reset();gpu_set_texfilter(false);gpu_set_fog(false,0,0,0)
        surface_set_target(_raw.surf);_target=true
        scrNTTEFullOutlineCamera();draw_clear_alpha(c_black,0);draw_set_alpha(1);draw_set_color(c_white)
        gpu_set_blendmode(bm_normal);scrNTTEFullPetBodyDraw()
        surface_reset_target();_target=false
        scrNTTEFullOutlineBodyCache(_raw,_cache)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_set_blendmode(bm_normal);gpu_set_fog(true,scrNTTEFullOutlineOwnerColor(leader.index),0,0)
        for(var _ang=0;_ang<360;_ang+=90)
            scrNTTEFullOutlineSurfaceDraw(_cache,view_xview+lengthdir_x(1,_ang),view_yview+lengthdir_y(1,_ang))
        gpu_set_fog(false,0,0,0);scrNTTEFullOutlineSurfaceDraw(_cache,view_xview,view_yview)
    }
    finally {
        if(_target) surface_reset_target()
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state()
    }
    return true
}
// Source creates one renderer per owner (-1 is the local fallback). Its
// depth is the minimum member.depth-1, so it follows real scene ordering.
function scrNTTEFullCharmOutlineSync() {
    if(!instance_exists(GameCont)) return;
    var _list=scrNTTEFullArrayCopy(scrNTTEFullValue(GameCont,"ntte_charm_instance_list",[])),_listed={}
    for(var _i=0;_i<array_length(_list);++_i) _listed[$ string(_list[_i])]=true
    // Friendly native enemies share the original charm eye overlay. This
    // list is visual only; it must never register them as timed charms.
    with(enemy) if(visible && hp>0 && team==team_player && !variable_struct_exists(_listed,string(id))) array_push(_list,id)
    if(array_length(_list)==0 && !instance_exists(NTTEFullOutlineCache)) return;
    var _manager=scrNTTEFullOutlineManager(),_groups=_manager.groups
    for(var _i=0;_i<array_length(_groups);++_i) if(instance_exists(_groups[_i])) {
        _groups[_i].members=[];_groups[_i].visible=false
    }
    for(var _i=0;_i<array_length(_list);++_i) {
        var _actor=_list[_i]
        if(!instance_exists(_actor) || !_actor.visible || !instance_is(_actor,enemy)) continue
        var _charm=scrNTTEFullValue(_actor,"ntte_charm",undefined)
        var _charmed=is_struct(_charm) && _charm.charmed
        if(!_charmed && (_actor.team!=team_player || _actor.hp<=0)) continue
        var _index=_charmed?_charm.index:global.index,_group=noone
        for(var _j=0;_j<array_length(_groups);++_j)
            if(instance_exists(_groups[_j]) && _groups[_j].owner_index==_index) {_group=_groups[_j];break;}
        if(!instance_exists(_group)) {
            _group=instance_create(0,0,NTTEFullCharmOutlineDraw);_group.owner_index=_index
            array_push(_groups,_group)
        }
        if(!_group.visible) _group.depth=_actor.depth-1
        else _group.depth=min(_group.depth,_actor.depth-1)
        _group.visible=true;array_push(_group.members,_actor)
    }
    _manager.groups=_groups
}
function scrNTTEFullCharmReplayReadOnly(_seen) {
    for(var _i=0;_i<array_length(_seen);++_i) {
        var _actor=_seen[_i]
        if(!instance_exists(_actor)) continue
        switch(_actor.object_index) {
            case Bandit:
            case NTTEFullBanditCamper:
            case NTTEFullMinerBandit:
            case NTTEFullBanditHiker:
            case NTTEBat:
            case BigMaggot:
            case BoneFish:
            case Crab:
            case CrownGuardian:
            case Exploder:
            case ExploFreak:
            case ExploGuardian:
            case FastRat:
            case FireBaller:
            case Freak:
            case FrogQueen:
            case GoldScorpion:
            case Guardian:
            case HostileHorror:
            case InvLaserCrystal:
            case InvSpider:
            case JungleFly:
            case Maggot:
            case MaggotSpawn:
            case RadMaggot:
            case Rat:
            case Ratking:
            case RatkingRage:
            case RhinoFreak:
            case Scorpion:
            case SnowBot:
            case Spider:
            case SuperFrog:
            case SuperMimic:
            case Turtle:
            case Wolf:
                break
            default: return false
        }
    }
    return true
}
function scrNTTEFullCharmOutlineDraw(_snapshot_all=false) {
    var _outline=scrNTTEFullOptionGet("outline:charm")
    if(array_length(members)==0 || (!_outline && !scrNTTEFullOptionGet("shaders"))) return;
    var _seen=[]
    for(var _i=0;_i<array_length(members);++_i) {
        var _actor=members[_i]
        if(instance_exists(_actor) && _actor.visible && _actor.bbox_left<view_xview+view_width+24
            && _actor.bbox_right>view_xview-24 && _actor.bbox_top<view_yview+view_height+24
            && _actor.bbox_bottom>view_yview-24) array_push(_seen,_actor)
    }
    if(array_length(_seen)==0) return;
    var _scale=scrNTTEFullOutlineFrameScale(),
        _raw=scrNTTEFullOutlineCacheSetup("CharmScreen",view_width,view_height,_scale),
        _cache=scrNTTEFullOutlineCacheSetup("Charm",view_width,view_height,_outline?scrNTTEFullOptionGet("quality:main"):_scale),
        _border=scrNTTEFullOutlineCacheSetup("CharmBorder",view_width,view_height,_scale)
    if(!surface_exists(_raw.surf) || !surface_exists(_cache.surf) || !surface_exists(_border.surf)) return;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),_ts=timescale,_target=false,
        _transaction=_snapshot_all || !scrNTTEFullCharmReplayReadOnly(_seen),
        _seed=0,_rng=[],_state=undefined,_source_random=undefined,_snapshot=undefined,_before=undefined
    if(_transaction) {
        _seed=random_get_seed();_state=scrNTTEFullSourceSeedState();_source_random=_state.random
        _snapshot=scrNTTEFullAreaGeneratorSnapshot(_seen);_before=scrNTTEFullParrotCharmInstanceSet()
        array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    }
    gpu_push_state()
    try {
        shader_reset();gpu_set_texfilter(false);gpu_set_fog(false,0,0,0)
        surface_set_target(_raw.surf);_target=true
        scrNTTEFullOutlineCamera();draw_clear_alpha(c_black,0);draw_set_alpha(1);draw_set_color(c_white)
        gpu_set_blendmode(bm_normal);timescale=0.00000001
        for(var _i=0;_i<array_length(_seen);++_i) if(instance_exists(_seen[_i])) with(_seen[_i]) {
            if(scrNTTEFullCoastObjectHasDraw(object_index)) event_perform(ev_draw,0)
            else draw_self()
        }
        timescale=_ts;surface_reset_target();_target=false
        scrNTTEFullOutlineBodyCache(_raw,_cache)
        if(_outline) {
            surface_set_target(_border.surf);_target=true
            scrNTTEFullOutlineCamera();draw_clear_alpha(c_black,0);gpu_set_blendmode(bm_normal)
            var _index=owner_index<0?global.index:owner_index
            gpu_set_fog(true,scrNTTEFullOutlineOwnerColor(_index),0,0)
            for(var _ang=0;_ang<360;_ang+=90)
                scrNTTEFullOutlineSurfaceDraw(_cache,view_xview+lengthdir_x(1,_ang),view_yview+lengthdir_y(1,_ang))
            gpu_set_fog(false,0,0,0);gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
            scrNTTEFullOutlineSurfaceDraw(_cache,view_xview,view_yview)
            surface_reset_target();_target=false
        }
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_set_blendmode(bm_normal)
        if(_outline) scrNTTEFullOutlineSurfaceDraw(_border,view_xview,view_yview)
        if(scrNTTEFullSourceCharmShaderBegin(view_width,view_height)) {
            scrNTTEFullOutlineSurfaceDraw(_cache,view_xview,view_yview);shader_reset()
        }
    }
    finally {
        if(_target) surface_reset_target()
        timescale=_ts
        if(_transaction) {
            random_set_seed(_seed);global.rng_state=_rng;_state.random=_source_random
            with(all) if(!variable_struct_exists(_before,string(id))) instance_destroy(id,false)
            scrNTTEFullAreaGeneratorRestore(_snapshot)
        }
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state()
    }
}
