// teassets.mod.gml::weapon_loadout_sprite_list_merge (4599..4913).
// Original 15 degree lengths and curved alpha masks, captured in memory.
function scrNTTEFullMergeLoadoutParts(_sprites) {
    var _parts=[];
    for(var _i=0;_i<array_length(_sprites);++_i) {
        var _found=false;
        if(variable_global_exists("ntte_full_merge_loadouts"))
            for(var _j=0;_j<array_length(global.ntte_full_merge_loadouts);++_j) {
                var _entry=global.ntte_full_merge_loadouts[_j];
                if(_entry.sprite==_sprites[_i]) {
                    var _nested=scrNTTEFullMergeLoadoutParts(_entry.parts);
                    for(var _k=0;_k<array_length(_nested);++_k) array_push(_parts,_nested[_k]);
                    _found=true; break;
                }
            }
        if(!_found) array_push(_parts,_sprites[_i]);
    }
    return _parts;
}
function scrNTTEFullMergeLoadoutList(_sprites) {
    if(array_length(_sprites)==0) throw "Cannot compose an empty loadout";
    if(array_length(_sprites)==1) return _sprites[0];
    if(!variable_global_exists("ntte_full_merge_loadouts")) global.ntte_full_merge_loadouts=[];
    var _parts=scrNTTEFullMergeLoadoutParts(_sprites),_key="";
    for(var _i=0;_i<array_length(_parts);++_i) _key+=string(_parts[_i])+":";
    for(var _i=0;_i<array_length(global.ntte_full_merge_loadouts);++_i) {
        var _cached=global.ntte_full_merge_loadouts[_i];
        if(_cached.key==_key && sprite_exists(_cached.sprite)) return _cached.sprite;
    }
    var _angle=15,_factor=1/dcos(_angle),_slices=[],_offset_x=0,_offset_y=0;
    var _x1=infinity,_y1=infinity,_x2=-infinity,_y2=-infinity,_frames=0,_count=array_length(_parts);
    for(var _i=0;_i<_count;++_i) {
        var _spr=_parts[_i];
        if(!sprite_exists(_spr)) throw "Original merged loadout source is missing";
        var _slice={sprite:_spr,width:sprite_get_width(_spr),height:sprite_get_height(_spr),
            xoffset:sprite_get_xoffset(_spr),yoffset:sprite_get_yoffset(_spr),frames:sprite_get_number(_spr),
            sprite_length1:0,sprite_length2:0,length1:0,length2:0};
        if(_spr!=mskNone) {
            var _dis1=floor(((sprite_get_bbox_left(_spr)+2)-_slice.xoffset)*_factor)-4;
            var _dis3=ceil(((sprite_get_bbox_right(_spr)-1)-_slice.xoffset)*_factor)-4;
            var _dis2=lerp(_dis1,_dis3,0.4);
            _slice.sprite_length1=_dis1; _slice.sprite_length2=_dis3;
            for(var _side=0;_side<=1;++_side) {
                var _dis;
                if(_i==(_count-1)*_side) _dis=_side==0?_dis1:_dis3;
                else {
                    var _amount=_i/_count+_side/min(2,_count);
                    _dis=lerp(lerp(_dis1,_dis2,clamp(2*_amount,0,1)),_dis3,clamp(2*(_amount-0.5),0,1));
                }
                if(_side==0) _slice.length1=_dis; else _slice.length2=_dis;
            }
        }
        else {
            _slice.width=1; _slice.height=1; _slice.xoffset=0; _slice.yoffset=0;
            _slice.length1=-11; _slice.length2=-5; _slice.sprite_length1=-11; _slice.sprite_length2=-5;
        }
        var _sx=ceil(_offset_x)-_slice.xoffset,_sy=floor(_offset_y)-_slice.yoffset;
        _x1=min(_x1,_sx); _y1=min(_y1,_sy); _x2=max(_x2,_sx+_slice.width); _y2=max(_y2,_sy+_slice.height);
        _offset_x+=lengthdir_x(_slice.length2-_slice.length1,_angle);
        _offset_y+=lengthdir_y(_slice.length2-_slice.length1,_angle);
        _frames=max(_frames,_slice.frames); array_push(_slices,_slice);
    }
    var _w=_x2-_x1,_h=_y2-_y1,_ox=-_x1,_oy=-_y1,_surface=surface_create(_w*_frames,_h);
    if(!surface_exists(_surface)) throw "Cannot allocate merged loadout surface";
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    gpu_push_state();
    gpu_set_fog(false,0,0,0); gpu_set_blendmode(bm_normal); draw_set_color(c_white); draw_set_alpha(1);
    surface_set_target(_surface); draw_clear_alpha(c_black,0); surface_reset_target();
    for(var _frame=0;_frame<_frames;++_frame) {
        var _dx=_ox+lengthdir_x(_slices[0].length1,_angle)+_w*_frame;
        var _dy=_oy+lengthdir_y(_slices[0].length1,_angle);
        for(var _i=0;_i<_count;++_i) {
            var _slice=_slices[_i],_sx=_slice.xoffset,_sy=_slice.yoffset;
            var _mask=surface_create(_slice.width,_slice.height),_part=surface_create(_slice.width,_slice.height);
            if(!surface_exists(_mask) || !surface_exists(_part)) throw "Cannot allocate original curved loadout mask";
            surface_set_target(_part); draw_clear_alpha(c_black,0);
            if(_slice.sprite==sprGoldScrewdriverLoadout)
                draw_sprite_ext(_slice.sprite,_slice.frames*(_frame/_frames),_sx,_sy,1,1,_angle-45,c_white,1);
            else draw_sprite(_slice.sprite,_slice.frames*(_frame/_frames),_sx,_sy);
            surface_reset_target();
            if(_slice.length2<_slice.sprite_length2) {
                surface_set_target(_mask); draw_clear_alpha(c_black,0);
                draw_circle(_sx+ceil(lengthdir_x(_slice.sprite_length2,_angle)),
                    _sy+floor(lengthdir_y(_slice.sprite_length2,_angle)),ceil(_slice.length2-_slice.sprite_length2),false);
                gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha); draw_set_alpha(0.5);
                draw_circle(_sx+ceil(lengthdir_x(_slice.length2-10,_angle)),
                    _sy+floor(lengthdir_y(_slice.length2-10,_angle)),16,false);
                draw_set_alpha(1); gpu_set_blendmode(bm_normal); surface_reset_target();
                surface_set_target(_part); gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha);
                draw_surface(_mask,0,0); gpu_set_blendmode(bm_normal); surface_reset_target();
            }
            if(_slice.length1>_slice.sprite_length1) {
                surface_set_target(_mask); draw_clear_alpha(c_black,0);
                draw_circle(_sx+ceil(lengthdir_x(_slice.length2,_angle)),
                    _sy+floor(lengthdir_y(_slice.length2,_angle)),ceil(_slice.length2-_slice.length1),false);
                surface_reset_target();
                surface_set_target(_part); gpu_set_blendmode_ext(bm_zero,bm_src_alpha);
                draw_surface(_mask,0,0); gpu_set_blendmode(bm_normal); surface_reset_target();
            }
            surface_set_target(_surface);
            draw_surface(_part,ceil(_dx-lengthdir_x(_slice.length1,_angle))-_sx,
                floor(_dy-lengthdir_y(_slice.length1,_angle))-_sy);
            surface_reset_target(); surface_free(_mask); surface_free(_part);
            _dx+=lengthdir_x(_slice.length2-_slice.length1,_angle);
            _dy+=lengthdir_y(_slice.length2-_slice.length1,_angle);
        }
    }
    var _sprite=sprite_create_from_surface(_surface,0,0,_w,_h,false,false,_ox,_oy);
    for(var _frame=1;_frame<_frames;++_frame) sprite_add_from_surface(_sprite,_surface,_w*_frame,0,_w,_h,false,false);
    surface_free(_surface);
    gpu_pop_state();
    draw_set_color(_color); draw_set_alpha(_alpha);
    array_push(global.ntte_full_merge_loadouts,{sprite:_sprite,parts:_parts,key:_key,slices:_slices});
    return _sprite;
}
function scrNTTEFullMergedLoadoutSprite(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    var _raw=scrNTTEFullWeaponRaw(_weapon),_stock=_raw==wep_none?mskNone:scr_weapon_get_loadout_sprite(_raw);
    _stock=scrNTTEFullTunnellerMetadata(_weapon,"loadout",_stock);
    if(scrNTTEFullWeaponHasMerge(_weapon)!=true || !sprite_exists(_stock)) return _stock;
    var _front=scrNTTEFullMergedLoadoutSprite(_weapon.temerge.wep[0]);
    if(!sprite_exists(_front)) return _front;
    return scrNTTEFullMergeLoadoutList([_stock,_front]);
}
function scrNTTEFullMergedLoadoutTests() {
    var _a=scr_weapon_get_loadout_sprite(wep_revolver),_b=scr_weapon_get_loadout_sprite(wep_golden_shotgun),_c=scr_weapon_get_loadout_sprite(wep_golden_crossbow);
    var _ab=scrNTTEFullMergeLoadoutList([_a,_b]),_abc=scrNTTEFullMergeLoadoutList([_ab,_c]);
    assert(_abc==scrNTTEFullMergeLoadoutList([_a,_b,_c]) && _ab==scrNTTEFullMergeLoadoutList([_a,_b]),"Merged loadout cache did not expand nested slices");
    assert(sprite_get_number(_ab)==max(sprite_get_number(_a),sprite_get_number(_b)),"Curved loadout frame count changed");
    var _entry=undefined;
    for(var _i=0;_i<array_length(global.ntte_full_merge_loadouts);++_i)
        if(global.ntte_full_merge_loadouts[_i].sprite==_abc) { _entry=global.ntte_full_merge_loadouts[_i]; break; }
    assert(array_length(_entry.slices)==3 && abs(_entry.slices[0].sprite_length1-(floor(((sprite_get_bbox_left(_a)+2)-sprite_get_xoffset(_a))/dcos(15))-4))*100000<=1,"Loadout source angle/lengths changed");
    var _w=sprite_get_width(_ab),_h=sprite_get_height(_ab),_s=surface_create(_w,_h);
    surface_set_target(_s); draw_clear_alpha(c_black,0); draw_sprite(_ab,0,sprite_get_xoffset(_ab),sprite_get_yoffset(_ab)); surface_reset_target();
    var _visible=0,_partial=0;
    for(var _x=0;_x<_w;++_x) for(var _y=0;_y<_h;++_y) {
        var _pixel=surface_getpixel_ext(_s,_x,_y),_opacity=(_pixel>>24)&255;
        if(_opacity>0) _visible++;
        if(_opacity>0 && _opacity<255) _partial++;
    }
    surface_free(_s);
    assert(_visible>20 && _partial>0,"Original curved loadout masks produced empty or hard-clipped art");
    var _part=scrNTTEFullMergeLoadoutList([mskNone,_b]);
    assert(sprite_exists(_part),"Missing-stock loadout placeholder failed");
    assert(scrNTTEFullMergedLoadoutSprite(scrNTTEFullWeaponMerge(wep_revolver,wep_golden_shotgun))==_ab,"Weapon loadout reducer did not use original composite");
    assert(scrNTTEFullMergedLoadoutSprite(scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun))==scr_weapon_get_loadout_sprite(wep_shotgun),"A front without loadout art should retain source no-loadout behavior");
    scrNTTESmokeLog("PASS original 15-degree loadout slice lengths, curved alpha masks, nested cache, captured pixels and missing-stock placeholder");
}
