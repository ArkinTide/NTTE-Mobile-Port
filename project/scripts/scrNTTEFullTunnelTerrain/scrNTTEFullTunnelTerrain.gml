// teassets4949..5000 / tegeneral4967..5035. Source quadrant art stays exact.
function scrNTTEFullTopTinySprites(_sprite) {
    if (!variable_global_exists("ntte_full_toptiny_sprites")) global.ntte_full_toptiny_sprites={}
    var _key=string(_sprite)
    if (variable_struct_exists(global.ntte_full_toptiny_sprites,_key)) return global.ntte_full_toptiny_sprites[$ _key]
    var _frames=sprite_get_number(_sprite),_width=sprite_get_width(_sprite)/2,_height=sprite_get_height(_sprite)/2,
        _ox=sprite_get_xoffset(_sprite),_oy=sprite_get_yoffset(_sprite),_out=[[0,0],[0,0]],_surface=surface_create(_width,_height)
    if (!surface_exists(_surface)) throw "NTTE TopTiny quadrant surface allocation failed"
    var _filter=gpu_get_texfilter(),_blend=gpu_get_blendenable(),_color=draw_get_color(),_alpha=draw_get_alpha(),
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _camera=camera_create_view(0,0,_width,_height,0,noone,-1,-1,-1,-1)
    gpu_set_texfilter(false); gpu_set_blendenable(false); draw_set_color(c_white); draw_set_alpha(1)
    for(var _xx=0;_xx<2;++_xx) for(var _yy=0;_yy<2;++_yy) {
        var _crop=-1
        for(var _frame=0;_frame<_frames;++_frame) {
            surface_set_target(_surface); camera_apply(_camera); matrix_set(matrix_world,matrix_build_identity()); draw_clear_alpha(c_black,0)
            draw_sprite_part(_sprite,_frame,_width*(1-_xx),_height*(1-_yy),_width,_height,0,0)
            surface_reset_target()
            if (_frame==0) _crop=sprite_create_from_surface(_surface,0,0,_width,_height,false,false,(_ox-8)*_xx,(_oy-8)*_yy)
            else sprite_add_from_surface(_crop,_surface,0,0,_width,_height,false,false)
        }
        _out[_xx][_yy]=_crop
    }
    gpu_set_texfilter(_filter); gpu_set_blendenable(_blend); draw_set_color(_color); draw_set_alpha(_alpha); surface_free(_surface)
    matrix_set(matrix_world,_world); matrix_set(matrix_view,_view); matrix_set(matrix_projection,_projection); camera_destroy(_camera)
    global.ntte_full_toptiny_sprites[$ _key]=_out
    return _out
}
function scrNTTEFullTunnelTerrainSmoke() {
    var _before=scrNTTEFullInstances(all),_tile=instance_create(70000,70000,TopSmall),_sprite=_tile.sprite_index,
        _tiny=scrNTTEFullTopTinyCreate(70008,70008)
    assert(instance_exists(_tiny) && instance_is(_tiny,TopSmall) && !_tiny.visible,"TopTiny omitted actual native TopSmall geometry/hidden controller draw")
    assert(sprite_get_width(_tiny.sprite_index)==sprite_get_width(_sprite)/2 && sprite_get_height(_tiny.sprite_index)==sprite_get_height(_sprite)/2,"TopTiny original quadrant dimensions changed")
    assert(sprite_get_xoffset(_tiny.sprite_index)==sprite_get_xoffset(_sprite)-8 && sprite_get_yoffset(_tiny.sprite_index)==sprite_get_yoffset(_sprite)-8,"TopTiny source quadrant offset changed")
    with (_tiny) scrNTTEFullTopTinyEndStep()
    assert(!instance_exists(_tile) && array_length(_tiny.ntte_toptiny_restore)>0,"TopTiny omitted original deferred older-tile copy/reorder")
    with (_tiny) scrNTTEFullTopTinyEndStep()
    assert(_tiny.ntte_toptiny_phase==3 && !array_length(_tiny.ntte_toptiny_restore),"TopTiny deferred mask restoration failed")
    var _record=scrNTTEFullFloorReveal(70000,70000,70015,70015,6)
    _record.time_max*=1.3
    assert(_record.time==6 && _record.time_max>7 && _record.oy==-8 && instance_exists(_record.creator),"Tunnel floor reveal lost mutable source timing/offset/controller record")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD TOPTINY ORIGINAL QUADRANT DIMENSIONS+OFFSETS/NATIVE TOPSMALL/DEFERRED OLD TILE COPIES+MASK RESTORATION/MUTABLE FLOOR REVEAL TIMING OK; PIXEL DRAW STILL REQUIRES VISUAL REGRESSION")
}
function scrNTTEFullTopTinyCreate(_x,_y) {
    if (!position_meeting(_x,_y,TopSmall)) return noone;
    var _tile=instance_create(floor(_x/16)*16,floor(_y/16)*16,NTTEFullTopTiny)
    if (!instance_exists(_tile)) return noone;
    if (sprite_exists(_tile.sprite_index)) {
        var _sprites=scrNTTEFullTopTinySprites(_tile.sprite_index)
        _tile.mask_index=_tile.mask_index<0 ? _tile.sprite_index:_tile.mask_index
        _tile.sprite_index=_sprites[_x>=_tile.x+8][_y>=_tile.y+8]
        _tile.image_index=irandom(_tile.image_number-1)
        _tile.ntte_toptiny_phase=1; _tile.ntte_toptiny_restore=[]
    }
    return _tile
}
function scrNTTEFullTopTinyEndStep() {
    if (lockstep_stop) return;
    if (ntte_toptiny_phase==1) {
        ntte_toptiny_phase=2
        var _old=scrNTTEFullRectInstances(x-16,y-16,x+16,y+16,TopSmall)
        array_sort(_old,function(_a,_b) { return real(_a)-real(_b) })
        for(var _i=0;_i<array_length(_old);++_i) {
            var _tile=_old[_i]
            if (instance_exists(_tile) && real(_tile)<real(id)) {
                with (_tile) {
                    var _copy=scrNTTEFullMergedNativeCopy(false),_mask=_copy.mask_index
                    _copy.mask_index=mskNone
                    if (variable_instance_exists(_copy,"ntte_toptiny_phase")) _copy.ntte_toptiny_phase=3
                    array_push(other.ntte_toptiny_restore,[_copy,_mask])
                    instance_destroy(id,false)
                }
            }
        }
    }
    else if (ntte_toptiny_phase==2) {
        ntte_toptiny_phase=3
        for(var _i=0;_i<array_length(ntte_toptiny_restore);++_i) {
            var _entry=ntte_toptiny_restore[_i]
            if (instance_exists(_entry[0]) && _entry[0].mask_index==mskNone) _entry[0].mask_index=_entry[1]
        }
        ntte_toptiny_restore=[]
    }
}
