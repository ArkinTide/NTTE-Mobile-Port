function scrDPBatchAtlasSprite(_sprite) {
    switch(_sprite) {
        case sprDetail0:
        case sprDetail1:
        case sprDetail101:
        case sprDetail102:
        case sprDetail104:
        case sprDetail2:
        case sprDetail3:
        case sprDetail4:
        case sprDetail5:
        case sprDetail6:
        case sprDPCampfireScorch:
        case sprDPCampfireScorchTop:
        case sprDPCityBScorch:
        case sprDPCityBScorch2:
        case sprDPCityBScorchTop:
        case sprDPCityBScorchTop2:
        case sprDPCityExploScorch:
        case sprDPCityExploScorch2:
        case sprDPCityProtoStatueDecal:
        case sprDPCityProtoStatueDecalDead:
        case sprDPCityScorch:
        case sprDPCityScorch2:
        case sprDPCityScorchTop:
        case sprDPCityScorchTop2:
        case sprDPCoastProtoStatueDecal:
        case sprDPCoastProtoStatueDecalDead:
        case sprDPDesertBScorch:
        case sprDPDesertBScorchTop:
        case sprDPDesertProtoStatueDecal:
        case sprDPDesertProtoStatueDecalDead:
        case sprDPDesertScorch:
        case sprDPDesertScorchTop:
        case sprDPDetailDesertB:
        case sprDPDetailDesertMudB:
        case sprDPDetailDesertMudBig:
        case sprDPFloorDesertBOut:
        case sprDPFloorOasisBOut:
        case sprDPOasisScorch:
        case sprDPOasisScorchTop:
        case sprDPPalaceProtoStatueDecal:
        case sprDPPalaceProtoStatueDecalDead:
        case sprDPScrapyardProtoStatueDecal:
        case sprDPScrapyardProtoStatueDecalDead:
        case sprDPshdSnowFloorDesertB:
        case sprDPSnowFloorDesertB:
        case sprDPTrenchProtoStatueDecal:
        case sprDPTrenchProtoStatueDecalDead:
        case sprDPTrenchScorch:
        case sprDPTrenchScorchTop:
        case sprDPWallDesertBotB:
        case sprNTTERefDetailCoast:
        case sprNTTERefDetailLair:
        case sprNTTERefDetailRed:
        case sprNTTERefDetailTrench:
        case sprUGDetailUndergrowth:
            return true;
    }
    return false;
}
// Static Details+ additions are captured once, retaining sprite/frame/order
// and depth, then submitted in texture runs. No per-decoration Step/Draw.
function scrDPBatchFormat() {
    if(!variable_global_exists("dp_vertex_format")) {
        vertex_format_begin();vertex_format_add_position_3d();
        vertex_format_add_colour();vertex_format_add_textcoord();
        global.dp_vertex_format=vertex_format_end();
    }
    return global.dp_vertex_format;
}
function scrDPBatchFree() {
    for(var _i=0;_i<array_length(dp_groups);++_i) vertex_delete_buffer(dp_groups[_i].buffer);
    dp_groups=[];
}
function scrDPBatchVertex(_b,_x,_y,_u,_v,_color,_alpha) {
    vertex_position_3d(_b,_x,_y,0);vertex_colour(_b,_color,_alpha);vertex_texcoord(_b,_u,_v);
}
function scrDPBatchBuild(_allow_shared=true) {
    scrDPBatchFree();
    var _group=undefined,_format=scrDPBatchFormat(),_atlas=texturegroup_get_textures("DetailsPlusStatic"),
        _single=_allow_shared && array_length(_atlas)==1;
    for(var _i=0;_i<array_length(dp_rows);++_i) {
        var _r=dp_rows[_i],_s=_r.sprite,_index=_r.index mod sprite_get_number(_s),
            _texture=sprite_get_texture(_s,_index),_uv=sprite_get_uvs(_s,_index),
            _w=sprite_get_width(_s),_h=sprite_get_height(_s),
            _x1=_r.x+(_uv[4]-sprite_get_xoffset(_s))*_r.scale,
            _y1=_r.y+_uv[5]-sprite_get_yoffset(_s),
            _x2=_x1+_w*_uv[6]*_r.scale,_y2=_y1+_h*_uv[7],
            _left=min(_x1,_x2),_right=max(_x1,_x2);
        // All decoration fits the same atlas on supported builds. A future
        // multi-page build falls back to exact sprite/frame runs, never to an
        // inferred texture pointer identity or an incorrect frame-zero page.
        var _shared=_single && scrDPBatchAtlasSprite(_s);
        if(is_undefined(_group) || _group.shared!=_shared
            || (!_shared && (_group.sprite!=_s || _group.index!=_index))) {
            if(!is_undefined(_group)) {vertex_end(_group.buffer);vertex_freeze(_group.buffer);}
            _group={buffer:vertex_create_buffer(),texture:_shared?_atlas[0]:_texture,
                shared:_shared,sprite:_s,index:_index,
                left:_left,right:_right,top:_y1,bottom:_y2};
            vertex_begin(_group.buffer,_format);array_push(dp_groups,_group);
        } else {
            _group.left=min(_group.left,_left);_group.right=max(_group.right,_right);
            _group.top=min(_group.top,_y1);_group.bottom=max(_group.bottom,_y2);
        }
        var _b=_group.buffer;
        scrDPBatchVertex(_b,_x1,_y1,_uv[0],_uv[1],_r.color,_r.alpha);
        scrDPBatchVertex(_b,_x2,_y1,_uv[2],_uv[1],_r.color,_r.alpha);
        scrDPBatchVertex(_b,_x1,_y2,_uv[0],_uv[3],_r.color,_r.alpha);
        scrDPBatchVertex(_b,_x2,_y1,_uv[2],_uv[1],_r.color,_r.alpha);
        scrDPBatchVertex(_b,_x2,_y2,_uv[2],_uv[3],_r.color,_r.alpha);
        scrDPBatchVertex(_b,_x1,_y2,_uv[0],_uv[3],_r.color,_r.alpha);
    }
    if(!is_undefined(_group)) {vertex_end(_group.buffer);vertex_freeze(_group.buffer);}
}
function scrDPBatchDraw() {
    if(lockstep_stop) return;
    var _camera=camera_get_active(),_cull=_camera>=0,
        _x1=_cull?camera_get_view_x(_camera):0,_y1=_cull?camera_get_view_y(_camera):0,
        _x2=_cull?_x1+camera_get_view_width(_camera):0,_y2=_cull?_y1+camera_get_view_height(_camera):0;
    for(var _i=0;_i<array_length(dp_groups);++_i) {
        var _g=dp_groups[_i];
        if(_cull && (_g.right<_x1 || _g.left>_x2 || _g.bottom<_y1 || _g.top>_y2)) continue;
        vertex_submit(_g.buffer,pr_trianglelist,_g.texture);
    }
}
function scrDPBatchCapture() {
    var _depths={},_changed=[];
    with(DPDecorBatch) _depths[$ string(depth)]=id;
    var _sources=[];
    // Native with order is newest first, matching automatic drawing at a depth.
    with(DPStaticDecor) array_push(_sources,id);
    with(Detail) if(scrNTTEFullValue(id,"dp_added",false)) array_push(_sources,id);
    for(var _i=0;_i<array_length(_sources);++_i) with(_sources[_i]) {
        var _key=string(depth),_batch=scrNTTEFullValue(_depths,_key,noone);
        if(!instance_exists(_batch)) {
            _batch=instance_create_depth(x,y,depth,DPDecorBatch);
            _depths[$ _key]=_batch;
        }
        array_push(_batch.dp_rows,{x:x,y:y,sprite:sprite_index,index:floor(image_index),
            scale:image_xscale,color:image_blend,alpha:image_alpha});
        if(array_get_index(_changed,_batch)<0) array_push(_changed,_batch);
        instance_destroy(id,false);
    }
    for(var _i=0;_i<array_length(_changed);++_i) with(_changed[_i]) scrDPBatchBuild();
}
function scrDPBatchRowCount() {
    var _n=0;with(DPDecorBatch) _n+=array_length(dp_rows);return _n;
}
