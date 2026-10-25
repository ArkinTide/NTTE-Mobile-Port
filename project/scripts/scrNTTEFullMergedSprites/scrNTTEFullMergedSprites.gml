// BEGIN ORIGINAL QUEST ARTIFACT MERGE ART
// teassets160..162: exact ordered combinations use source-authored artwork.
// Direct expansion also works after a fixture/save replaces the sprite cache.
function scrNTTEFullQuestArtifactSpriteParts(_sprite) {
    switch(_sprite) {
        case sprNTTERefQuestArtifactSubMerge0:
            return [sprNTTERefQuestArtifactI0,sprNTTERefQuestArtifactI1];
        case sprNTTERefQuestArtifactSubMerge1:
            return [sprNTTERefQuestArtifactI2,sprNTTERefQuestArtifactI3];
        case sprNTTERefQuestArtifactMerge:
            return [sprNTTERefQuestArtifactI0,sprNTTERefQuestArtifactI1,sprNTTERefQuestArtifactI2,sprNTTERefQuestArtifactI3];
    }
    return undefined;
}
function scrNTTEFullQuestArtifactMergedSprite(_parts) {
    var _n=array_length(_parts);
    if(_n==2) {
        if(_parts[0]==sprNTTERefQuestArtifactI0 && _parts[1]==sprNTTERefQuestArtifactI1)
            return sprNTTERefQuestArtifactSubMerge0;
        if(_parts[0]==sprNTTERefQuestArtifactI2 && _parts[1]==sprNTTERefQuestArtifactI3)
            return sprNTTERefQuestArtifactSubMerge1;
    }
    if(_n==4 && _parts[0]==sprNTTERefQuestArtifactI0 && _parts[1]==sprNTTERefQuestArtifactI1
        && _parts[2]==sprNTTERefQuestArtifactI2 && _parts[3]==sprNTTERefQuestArtifactI3)
        return sprNTTERefQuestArtifactMerge;
    return -1;
}
// END ORIGINAL QUEST ARTIFACT MERGE ART

// teassets.mod.gml::weapon_sprite_list_merge, native in-memory surfaces.
// Every cached sprite retains its source slices, so nested merges flatten
// exactly as the original sprite-key table without parsing numeric asset IDs.
// Ordered source rows remain authoritative. These indexes accelerate only
// history lookup, never a live weapon's context-dependent sprite result.
function scrNTTEFullMergeSpriteCacheReset(_rows) {
    global.ntte_full_merge_sprites=_rows;
    global.ntte_full_merge_sprite_index=undefined;
}
function scrNTTEFullMergeSpriteCacheInvalidate() {
    global.ntte_full_merge_sprite_index=undefined;
}
function scrNTTEFullMergeSpriteCacheAppend(_row) {
    array_push(global.ntte_full_merge_sprites,_row);
    scrNTTEFullMergeSpriteCacheInvalidate();
}
function scrNTTEFullMergeSpriteIndex() {
    if(!variable_global_exists("ntte_full_merge_sprites")) scrNTTEFullMergeSpriteCacheReset([]);
    var _rows=global.ntte_full_merge_sprites,_count=array_length(_rows),
        _first=_count>0?_rows[0]:undefined,_last=_count>0?_rows[_count-1]:undefined,
        _index=variable_global_exists("ntte_full_merge_sprite_index")?global.ntte_full_merge_sprite_index:undefined;
    // Explicit resets/row edits invalidate above. Boundary identity also catches
    // direct same-length cache replacement by fixtures or external callers.
    if(is_struct(_index) && _index.count==_count && _index.first==_first && _index.last==_last) return _index;
    _index={by_sprite:{},by_key:{},count:_count,first:_first,last:_last};
    for(var _i=0;_i<_count;++_i) {
        var _row=_rows[_i],_sprite_key=string(_row.sprite);
        // Source flattening takes the first matching sprite row, even if a
        // later key uses the same sprite identity. Keep its exact precedence.
        if(!variable_struct_exists(_index.by_sprite,_sprite_key)) _index.by_sprite[$ _sprite_key]=_row;
        var _key_rows=variable_struct_exists(_index.by_key,_row.key)?_index.by_key[$ _row.key]:[];
        array_push(_key_rows,_row);_index.by_key[$ _row.key]=_key_rows;
    }
    global.ntte_full_merge_sprite_index=_index;
    if(variable_global_exists("ntte_full_merge_sprite_index_test") && is_struct(global.ntte_full_merge_sprite_index_test))
        global.ntte_full_merge_sprite_index_test.build_rows+=_count;
    return _index;
}
function scrNTTEFullMergeSpriteFindSource(_sprite) {
    if(!variable_global_exists("ntte_full_merge_sprites")) return undefined;
    var _index=scrNTTEFullMergeSpriteIndex(),_key=string(_sprite);
    if(variable_global_exists("ntte_full_merge_sprite_index_test") && is_struct(global.ntte_full_merge_sprite_index_test))
        global.ntte_full_merge_sprite_index_test.sprite_lookups++;
    return variable_struct_exists(_index.by_sprite,_key)?_index.by_sprite[$ _key]:undefined;
}
function scrNTTEFullMergeSpriteFindKey(_key,_live=true) {
    var _index=scrNTTEFullMergeSpriteIndex();
    if(!variable_struct_exists(_index.by_key,_key)) return undefined;
    var _rows=_index.by_key[$ _key];
    for(var _i=0;_i<array_length(_rows);++_i) {
        if(variable_global_exists("ntte_full_merge_sprite_index_test") && is_struct(global.ntte_full_merge_sprite_index_test))
            global.ntte_full_merge_sprite_index_test.key_rows++;
        // Generic lookup skips deleted dynamic sprites; authored combinations
        // overwrite the first exact row regardless of its stale sprite value.
        if(!_live || sprite_exists(_rows[_i].sprite)) return _rows[_i];
    }
    return undefined;
}

function scrNTTEFullMergeSpriteParts(_sprites) {
    var _parts=[];
    for(var _i=0;_i<array_length(_sprites);++_i) {
        var _authored=scrNTTEFullQuestArtifactSpriteParts(_sprites[_i]);
        if(is_array(_authored)) {
            for(var _k=0;_k<array_length(_authored);++_k) array_push(_parts,_authored[_k]);
            continue;
        }
        var _entry=scrNTTEFullMergeSpriteFindSource(_sprites[_i]);
        if(is_struct(_entry)) {
            var _nested=scrNTTEFullMergeSpriteParts(_entry.parts);
            for(var _k=0;_k<array_length(_nested);++_k) array_push(_parts,_nested[_k]);
        }
        else array_push(_parts,_sprites[_i]);
    }
    return _parts;
}
function scrNTTEFullMergeSpriteList(_sprites) {
    if(array_length(_sprites)==0) throw "Cannot merge an empty sprite list";
    if(array_length(_sprites)==1) return _sprites[0];
    if(!variable_global_exists("ntte_full_merge_sprites")) scrNTTEFullMergeSpriteCacheReset([]);
    var _parts=scrNTTEFullMergeSpriteParts(_sprites),_key="";
    for(var _i=0;_i<array_length(_parts);++_i) _key+=string(_parts[_i])+":";
    // The original table takes precedence over generic slices/stale cache rows.
    var _authored=scrNTTEFullQuestArtifactMergedSprite(_parts);
    if(_authored!=-1) {
        var _entry=scrNTTEFullMergeSpriteFindKey(_key,false);
        if(is_struct(_entry)) {
            var _changed=_entry.sprite!=_authored;
            _entry.sprite=_authored;_entry.parts=_parts;
            if(_changed) scrNTTEFullMergeSpriteCacheInvalidate();
            return _authored;
        }
        scrNTTEFullMergeSpriteCacheAppend({sprite:_authored,parts:_parts,key:_key});
        return _authored;
    }
    var _cached=scrNTTEFullMergeSpriteFindKey(_key);
    if(is_struct(_cached)) return _cached.sprite;
    var _slices=[],_y1=infinity,_y2=-infinity,_width=0,_frames=0,_count=array_length(_parts);
    for(var _i=0;_i<_count;++_i) {
        var _spr=_parts[_i];
        if(!sprite_exists(_spr)) throw "Merged weapon source sprite is missing";
        var _slice={sprite:_spr,width:sprite_get_width(_spr),height:sprite_get_height(_spr),
            xoffset:sprite_get_xoffset(_spr),yoffset:sprite_get_yoffset(_spr),
            bbox_y1:sprite_get_bbox_top(_spr)-sprite_get_yoffset(_spr),
            bbox_y2:sprite_get_bbox_bottom(_spr)+1-sprite_get_yoffset(_spr),
            frames:sprite_get_number(_spr),x1:0,x2:0};
        // Original's manual alignment adjustments use native weapon sprites.
        if(_spr==scr_weapon_get_sprite(wep_toxic_bow)) _slice.yoffset+=2;
        if(_spr==scr_weapon_get_sprite(wep_super_crossbow) || _spr==scr_weapon_get_sprite(wep_gatling_slugger)) _slice.yoffset+=1;
        if(_spr==scr_weapon_get_sprite(wep_auto_shotgun) || _spr==scr_weapon_get_sprite(wep_party_gun)) _slice.yoffset-=1;
        if(_spr==mskNone) {
            _slice.height=1; _slice.yoffset=0; _slice.bbox_y1=infinity;
            _slice.bbox_y2=_i>0?infinity:-infinity; _slice.x2=3;
        }
        else {
            var _sx1=sprite_get_bbox_left(_spr)+1,_sx3=sprite_get_bbox_right(_spr),_sx2=round(lerp(_sx1,_sx3,0.4));
            for(var _side=0;_side<=1;++_side) {
                var _sx;
                if(_i==(_count-1)*_side) _sx=_slice.width*_side;
                else {
                    var _amount=_i/_count+_side/min(2,_count);
                    _sx=ceil(lerp(lerp(_sx1,_sx2,clamp(2*_amount,0,1)),_sx3,clamp(2*(_amount-0.5),0,1)));
                }
                if(_side==0) _slice.x1=_sx; else _slice.x2=_sx;
            }
        }
        _y1=min(_y1,-_slice.yoffset); _y2=max(_y2,-_slice.yoffset+_slice.height);
        _width+=_slice.x2-_slice.x1; _frames=max(_frames,_slice.frames); array_push(_slices,_slice);
    }
    var _height=_y2-_y1,_ox=_slices[0].xoffset,_oy=-_y1;
    var _surface=surface_create(_width*_frames,_height);
    if(!surface_exists(_surface)) throw "Could not allocate original merged weapon sprite surface";
    var _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog();
    surface_set_target(_surface); draw_clear_alpha(c_black,0);
    draw_set_color(c_white); draw_set_alpha(1); gpu_set_fog(false,0,0,0);
    for(var _outline=1;_outline>=0;_outline-=1) for(var _frame=0;_frame<_frames;++_frame) {
        var _offset=_width*_frame,_flash=_frame==min(1,_frames-1);
        for(var _i=0;_i<_count;++_i) {
            var _slice=_slices[_i],_w=_slice.x2-_slice.x1,_h=_slice.height;
            var _img=_flash?1:_slice.frames*(_frame/_frames),_y=_oy-_slice.yoffset;
            if(_outline==1) {
                if(!_flash) gpu_set_fog(true,c_black,0,0);
                if(_i>0) {
                    var _last=_slices[_i-1];
                    draw_sprite_part(_slice.sprite,_img,_slice.x1,0,1,_slice.bbox_y2<_last.bbox_y2?ceil(_h/2):_h,_offset-1,_y);
                }
                if(_i<_count-1) {
                    var _next=_slices[_i+1];
                    draw_sprite_part(_slice.sprite,_img,_slice.x2-1,0,1,_slice.bbox_y2<=_next.bbox_y2?ceil(_h/2):_h,_offset+_w,_y);
                }
                if(!_flash) gpu_set_fog(false,0,0,0);
            }
            else draw_sprite_part(_slice.sprite,_img,_slice.x1,0,_w,_h,_offset,_y);
            _offset+=_w;
        }
    }
    if(_count==2 && _parts[0]==_parts[1]) {
        draw_set_color(c_black); draw_set_alpha(0.2); gpu_set_colorwriteenable(true,true,true,false);
        // Original darkens the base frame only, leaving its shine intact.
        draw_rectangle(0,0,_width,_height,false);
        gpu_set_colorwriteenable(true,true,true,true); draw_set_alpha(1);
    }
    surface_reset_target();
    var _sprite=sprite_create_from_surface(_surface,0,0,_width,_height,false,false,_ox,_oy);
    for(var _i=1;_i<_frames;++_i) sprite_add_from_surface(_sprite,_surface,_width*_i,0,_width,_height,false,false);
    surface_free(_surface);
    gpu_set_fog(_fog[0],_fog[1],_fog[2],_fog[3]); draw_set_color(_color); draw_set_alpha(_alpha);
    scrNTTEFullMergeSpriteCacheAppend({sprite:_sprite,parts:_parts,key:_key});
    return _sprite;
}
function scrNTTEFullMergedSpriteTests() {
    var _a=scr_weapon_get_sprite(wep_revolver),_b=scr_weapon_get_sprite(wep_shotgun),_c=scr_weapon_get_sprite(wep_crossbow);
    var _ab=scrNTTEFullMergeSpriteList([_a,_b]);
    var _abc=scrNTTEFullMergeSpriteList([_ab,_c]),_flat=scrNTTEFullMergeSpriteList([_a,_b,_c]);
    assert(_abc==_flat && _ab==scrNTTEFullMergeSpriteList([_a,_b]),"Merged sprite lost flattening or original slice-cache identity");
    assert(sprite_get_number(_ab)==max(sprite_get_number(_a),sprite_get_number(_b))
        && sprite_get_xoffset(_ab)==sprite_get_xoffset(_a),"Merged sprite lost source frames or stock grip origin");
    var _mid_a=round(lerp(sprite_get_bbox_left(_a)+1,sprite_get_bbox_right(_a),0.4));
    var _mid_b=round(lerp(sprite_get_bbox_left(_b)+1,sprite_get_bbox_right(_b),0.4));
    assert(sprite_get_width(_ab)==_mid_a+sprite_get_width(_b)-_mid_b,"Merged sprite slice width differs from source");
    // Compare the actual generated sprite's interior to the stock texture.
    // This catches surface capture, frame stride, origin and alpha errors.
    var _w=sprite_get_width(_ab),_h=sprite_get_height(_ab),_s1=surface_create(_w,_h),_s2=surface_create(_w,_h);
    var _oy=sprite_get_yoffset(_ab),_col=draw_get_color(),_alpha=draw_get_alpha();
    draw_set_color(c_white); draw_set_alpha(1); gpu_set_blendmode_ext(bm_one,bm_zero);
    for(var _frame=0;_frame<sprite_get_number(_ab);++_frame) {
        surface_set_target(_s1); draw_clear_alpha(c_black,0);
        draw_sprite(_ab,_frame,sprite_get_xoffset(_ab),_oy); surface_reset_target();
        surface_set_target(_s2); draw_clear_alpha(c_black,0);
        draw_sprite(_a,_frame,sprite_get_xoffset(_a),_oy); surface_reset_target();
        for(var _x=0;_x<max(0,_mid_a-1);++_x) for(var _y=0;_y<_h;++_y)
            assert(surface_getpixel_ext(_s1,_x,_y)==surface_getpixel_ext(_s2,_x,_y),"Merged sprite GPU capture altered stock-slice pixel");
    }
    gpu_set_blendmode(bm_normal); draw_set_color(_col); draw_set_alpha(_alpha);
    surface_free(_s1); surface_free(_s2);
    var _partial=scrNTTEFullMergeSpriteList([mskNone,_b]);
    assert(sprite_exists(_partial) && sprite_get_number(_partial)==sprite_get_number(_b),"Original missing-stock placeholder failed sprite composition");
    scrNTTEFullQuestArtifactSpriteTests();
    scrNTTESmokeLog("PASS merged sprite source slice geometry, cached/nested flattening, grip origin, seven GPU-captured frames and stock pixels");
}

// BEGIN ORIGINAL QUEST ARTIFACT MERGE ART TESTS
function scrNTTEFullQuestArtifactSpriteAssert(_weapon,_state,_expected,_order,_pickup=noone) {
    var _parts=scrNTTEFullQuestPartList(_weapon,_state);
    assert(array_length(_parts)==array_length(_order),"Authored artifact art changed actual physical component count");
    for(var _i=0;_i<array_length(_order);++_i)
        assert(_parts[_i]==_order[_i],"Authored artifact art changed actual physical component order");
    assert(scr_weapon_get_sprite(_weapon)==_expected
        && scrNTTEFullWeaponNativeSprite(_weapon,true,_state)==_expected
        && scrNTTEFullWeaponHUDSprite(_weapon)==_expected,
        "Physical artifact world/held/HUD paths lost exact original preauthored combination art");
    if(instance_exists(_pickup)) assert(_pickup.sprite_index==_expected,
        "Physical artifact pickup retained generic chopped combination art");
}
function scrNTTEFullQuestArtifactSpriteTests() {
    scrNTTEFullWeaponNativeInit();
    var _registry=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _cache=global.ntte_full_merge_sprites,_seed=random_get_seed(),_before=scrNTTEFullInstances(all);
    scrNTTEFullMergeSpriteCacheReset([]);
    try {
        var _art=[sprNTTERefQuestArtifactSubMerge0,sprNTTERefQuestArtifactSubMerge1,sprNTTERefQuestArtifactMerge],
            _widths=[28,35,60],_source=[sprNTTERefQuestArtifactI0,sprNTTERefQuestArtifactI1,sprNTTERefQuestArtifactI2,sprNTTERefQuestArtifactI3];
        for(var _i=0;_i<3;++_i) assert(sprite_get_width(_art[_i])==_widths[_i]
            && sprite_get_height(_art[_i])==14 && sprite_get_number(_art[_i])==7
            && sprite_get_xoffset(_art[_i])==3 && sprite_get_yoffset(_art[_i])==5,
            "Original artifact combination source dimensions/origin/seven shine frames changed");
        var _parts=scrNTTEFullMergeSpriteParts([_art[0],_art[1]]);
        assert(array_length(_parts)==4,"Authored artifact parts depend on a previously populated sprite cache");
        for(var _i=0;_i<4;++_i) assert(_parts[_i]==_source[_i],"Authored pair flattening reordered source identities");
        assert(scrNTTEFullMergeSpriteList([_art[0],_art[1]])==_art[2],
            "Nested authored artifact halves failed exact full-key artwork lookup");
        var _five=scrNTTEFullMergeSpriteParts([_art[2],sprRevolver]);
        assert(array_length(_five)==5 && _five[4]==sprRevolver,"Full key nested into another weapon lost source slicing inputs");
        for(var _i=0;_i<4;++_i) assert(_five[_i]==_source[_i],"Nested full key lost a distinct original artifact sprite");
        var _reversed=scrNTTEFullMergeSpriteList([_source[1],_source[0]]);
        assert(_reversed!=_art[0] && _reversed!=_art[1] && _reversed!=_art[2],
            "Artifact authored-art lookup incorrectly ignored original component order");
        assert(scrNTTEFullQuestArtifactMergedSprite([_source[0],_source[1],_source[2],_source[0]])==-1,
            "Artifact art lookup accepted duplicate/missing components");
        var _m0=scrNTTEFullCrabboneCreateModel(0),_m1=scrNTTEFullCrabboneCreateModel(1),
            _m2=scrNTTEFullCrabboneCreateModel(2),_m3=scrNTTEFullCrabboneCreateModel(3),
            _pairA=scrNTTEFullWeaponMerge(_m0,_m1),_pairB=scrNTTEFullWeaponMerge(_m2,_m3);
        scrNTTEFullQuestArtifactSpriteAssert(_pairA,_m0.ntte_native_state,_art[0],[0,1]);
        scrNTTEFullQuestArtifactSpriteAssert(_pairB,_m2.ntte_native_state,_art[1],[2,3]);
        var _full=scrNTTEFullWeaponMerge(_pairA,_pairB),_handle=scrNTTEFullWeaponNative(_full),
            _state=scrNTTEFullWeaponNativeState(_handle);
        assert(_full==_m0 && scrNTTEFullWeaponMergedPart(_full,1)==_m1
            && scrNTTEFullWeaponMergedPart(_full,2)==_m2 && scrNTTEFullWeaponMergedPart(_full,3)==_m3,
            "Artifact image correction replaced/reordered the actual four physical models");
        scrNTTEFullQuestArtifactSpriteAssert(_handle,_state,_art[2],[0,1,2,3]);
        var _pickup=scrWeaponPickupCreate(178000,178000,_handle);
        with(_pickup) scrNTTEFullWeaponNativeNormalizePickup();
        assert(_pickup.wep==_handle && _pickup.ntte_state==_state
            && scrNTTEFullWeaponModel(_pickup.wep)==_full,"Native artifact normalization changed the physical graph/state");
        scrNTTEFullQuestArtifactSpriteAssert(_pickup.wep,_pickup.ntte_state,_art[2],[0,1,2,3],_pickup);
        scrNTTESmokeLog("PASS source-authored artifact pair28/35/full60x14, seven shine frames/origin3,5; actual four-model merge/world/held/HUD/pickup; cache-free nested expansion and order negatives");
    }
    finally {
        var _after=scrNTTEFullInstances(all);
        for(var _i=array_length(_after)-1;_i>=0;--_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false);
        for(var _i=0;_i<array_length(global.ntte_full_merge_sprites);++_i) {
            var _sprite=global.ntte_full_merge_sprites[_i].sprite;
            if(_sprite!=sprNTTERefQuestArtifactSubMerge0 && _sprite!=sprNTTERefQuestArtifactSubMerge1
                && _sprite!=sprNTTERefQuestArtifactMerge && sprite_exists(_sprite)) sprite_delete(_sprite);
        }
        scrNTTEFullMergeSpriteCacheReset(_cache);global.ntte_full_native_weapon_models=_registry;
        random_set_seed(_seed);
    }
}
// END ORIGINAL QUEST ARTIFACT MERGE ART TESTS


// Frozen candidate56 lookup/composition, row-visit counters only.
function scrNTTEFullMergeSpritePartsLegacyTest(_sprites) {
    var _parts=[];
    for(var _i=0;_i<array_length(_sprites);++_i) {
        var _authored=scrNTTEFullQuestArtifactSpriteParts(_sprites[_i]);
        if(is_array(_authored)) {
            for(var _k=0;_k<array_length(_authored);++_k) array_push(_parts,_authored[_k]);
            continue;
        }
        var _found=false;
        if(variable_global_exists("ntte_full_merge_sprites"))
            for(var _j=0;_j<array_length(global.ntte_full_merge_sprites);++_j) {
                var _entry=global.ntte_full_merge_sprites[_j];
                global.ntte_full_merge_sprite_index_test.legacy_rows++;
                if(_entry.sprite==_sprites[_i]) {
                    var _nested=scrNTTEFullMergeSpritePartsLegacyTest(_entry.parts);
                    for(var _k=0;_k<array_length(_nested);++_k) array_push(_parts,_nested[_k]);
                    _found=true; break;
                }
            }
        if(!_found) array_push(_parts,_sprites[_i]);
    }
    return _parts;
}
function scrNTTEFullMergeSpriteListLegacyTest(_sprites) {
    if(array_length(_sprites)==0) throw "Cannot merge an empty sprite list";
    if(array_length(_sprites)==1) return _sprites[0];
    if(!variable_global_exists("ntte_full_merge_sprites")) global.ntte_full_merge_sprites=[];
    var _parts=scrNTTEFullMergeSpritePartsLegacyTest(_sprites),_key="";
    for(var _i=0;_i<array_length(_parts);++_i) _key+=string(_parts[_i])+":";
    // The original table takes precedence over generic slices/stale cache rows.
    var _authored=scrNTTEFullQuestArtifactMergedSprite(_parts);
    if(_authored!=-1) {
        for(var _i=0;_i<array_length(global.ntte_full_merge_sprites);++_i) {
            var _entry=global.ntte_full_merge_sprites[_i];
            global.ntte_full_merge_sprite_index_test.legacy_rows++;
            if(_entry.key==_key) {
                _entry.sprite=_authored;_entry.parts=_parts;return _authored;
            }
        }
        array_push(global.ntte_full_merge_sprites,{sprite:_authored,parts:_parts,key:_key});
        return _authored;
    }
    for(var _i=0;_i<array_length(global.ntte_full_merge_sprites);++_i) {
        var _cached=global.ntte_full_merge_sprites[_i];
        global.ntte_full_merge_sprite_index_test.legacy_rows++;
        if(_cached.key==_key && sprite_exists(_cached.sprite)) return _cached.sprite;
    }
    var _slices=[],_y1=infinity,_y2=-infinity,_width=0,_frames=0,_count=array_length(_parts);
    for(var _i=0;_i<_count;++_i) {
        var _spr=_parts[_i];
        if(!sprite_exists(_spr)) throw "Merged weapon source sprite is missing";
        var _slice={sprite:_spr,width:sprite_get_width(_spr),height:sprite_get_height(_spr),
            xoffset:sprite_get_xoffset(_spr),yoffset:sprite_get_yoffset(_spr),
            bbox_y1:sprite_get_bbox_top(_spr)-sprite_get_yoffset(_spr),
            bbox_y2:sprite_get_bbox_bottom(_spr)+1-sprite_get_yoffset(_spr),
            frames:sprite_get_number(_spr),x1:0,x2:0};
        // Original's manual alignment adjustments use native weapon sprites.
        if(_spr==scr_weapon_get_sprite(wep_toxic_bow)) _slice.yoffset+=2;
        if(_spr==scr_weapon_get_sprite(wep_super_crossbow) || _spr==scr_weapon_get_sprite(wep_gatling_slugger)) _slice.yoffset+=1;
        if(_spr==scr_weapon_get_sprite(wep_auto_shotgun) || _spr==scr_weapon_get_sprite(wep_party_gun)) _slice.yoffset-=1;
        if(_spr==mskNone) {
            _slice.height=1; _slice.yoffset=0; _slice.bbox_y1=infinity;
            _slice.bbox_y2=_i>0?infinity:-infinity; _slice.x2=3;
        }
        else {
            var _sx1=sprite_get_bbox_left(_spr)+1,_sx3=sprite_get_bbox_right(_spr),_sx2=round(lerp(_sx1,_sx3,0.4));
            for(var _side=0;_side<=1;++_side) {
                var _sx;
                if(_i==(_count-1)*_side) _sx=_slice.width*_side;
                else {
                    var _amount=_i/_count+_side/min(2,_count);
                    _sx=ceil(lerp(lerp(_sx1,_sx2,clamp(2*_amount,0,1)),_sx3,clamp(2*(_amount-0.5),0,1)));
                }
                if(_side==0) _slice.x1=_sx; else _slice.x2=_sx;
            }
        }
        _y1=min(_y1,-_slice.yoffset); _y2=max(_y2,-_slice.yoffset+_slice.height);
        _width+=_slice.x2-_slice.x1; _frames=max(_frames,_slice.frames); array_push(_slices,_slice);
    }
    var _height=_y2-_y1,_ox=_slices[0].xoffset,_oy=-_y1;
    var _surface=surface_create(_width*_frames,_height);
    if(!surface_exists(_surface)) throw "Could not allocate original merged weapon sprite surface";
    var _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog();
    surface_set_target(_surface); draw_clear_alpha(c_black,0);
    draw_set_color(c_white); draw_set_alpha(1); gpu_set_fog(false,0,0,0);
    for(var _outline=1;_outline>=0;_outline-=1) for(var _frame=0;_frame<_frames;++_frame) {
        var _offset=_width*_frame,_flash=_frame==min(1,_frames-1);
        for(var _i=0;_i<_count;++_i) {
            var _slice=_slices[_i],_w=_slice.x2-_slice.x1,_h=_slice.height;
            var _img=_flash?1:_slice.frames*(_frame/_frames),_y=_oy-_slice.yoffset;
            if(_outline==1) {
                if(!_flash) gpu_set_fog(true,c_black,0,0);
                if(_i>0) {
                    var _last=_slices[_i-1];
                    draw_sprite_part(_slice.sprite,_img,_slice.x1,0,1,_slice.bbox_y2<_last.bbox_y2?ceil(_h/2):_h,_offset-1,_y);
                }
                if(_i<_count-1) {
                    var _next=_slices[_i+1];
                    draw_sprite_part(_slice.sprite,_img,_slice.x2-1,0,1,_slice.bbox_y2<=_next.bbox_y2?ceil(_h/2):_h,_offset+_w,_y);
                }
                if(!_flash) gpu_set_fog(false,0,0,0);
            }
            else draw_sprite_part(_slice.sprite,_img,_slice.x1,0,_w,_h,_offset,_y);
            _offset+=_w;
        }
    }
    if(_count==2 && _parts[0]==_parts[1]) {
        draw_set_color(c_black); draw_set_alpha(0.2); gpu_set_colorwriteenable(true,true,true,false);
        // Original darkens the base frame only, leaving its shine intact.
        draw_rectangle(0,0,_width,_height,false);
        gpu_set_colorwriteenable(true,true,true,true); draw_set_alpha(1);
    }
    surface_reset_target();
    var _sprite=sprite_create_from_surface(_surface,0,0,_width,_height,false,false,_ox,_oy);
    for(var _i=1;_i<_frames;++_i) sprite_add_from_surface(_sprite,_surface,_width*_i,0,_width,_height,false,false);
    surface_free(_surface);
    gpu_set_fog(_fog[0],_fog[1],_fog[2],_fog[3]); draw_set_color(_color); draw_set_alpha(_alpha);
    array_push(global.ntte_full_merge_sprites,{sprite:_sprite,parts:_parts,key:_key});
    return _sprite;
}

function scrNTTEFullWeaponNativeSpriteLegacyIndexTest(_weapon,_held=false,_state=undefined,_hud=false) {
    var _model=scrNTTEFullWeaponModel(_weapon),_parts=[]
    while(true) {
        var _raw=scrNTTEFullWeaponRaw(_model)
        var _sprite=_raw==wep_none ? mskNone:(_hud ? scrNTTEFullWeaponHUDSprite(_raw):(_held ? scrNTTEFullWeaponStateSprite(_raw,
            is_struct(_model) ? scrNTTEFullWeaponNativePartState(_model,_state):_state):scr_weapon_get_sprite(_raw))
        )
        _sprite=scrNTTEFullWeaponSourceSprite(_model,_state,_sprite,_hud)
        _sprite=scrNTTEFullTunnellerMetadata(_model,_hud?"hud":"sprite",_sprite)
        _sprite=scrNTTEFullWeaponSkinSprite(_model,_sprite,_hud)
        array_push(_parts,_sprite)
        if(scrNTTEFullWeaponHasMerge(_model)!=true) break
        _model=scrNTTEFullWeaponMergedPart(_model)
    }
    return scrNTTEFullMergeSpriteListLegacyTest(_parts)
}

// Independent lookup oracle above retains the old complete renderer.
function scrNTTEFullMergeSpriteIndexOwnRowsTest(_owned) {
    for(var _i=0;_i<array_length(global.ntte_full_merge_sprites);++_i) {
        var _sprite=global.ntte_full_merge_sprites[_i].sprite;
        if(_sprite!=sprNTTERefQuestArtifactSubMerge0 && _sprite!=sprNTTERefQuestArtifactSubMerge1
            && _sprite!=sprNTTERefQuestArtifactMerge && array_get_index(_owned,_sprite)<0) array_push(_owned,_sprite);
    }
    return _owned;
}
function scrNTTEFullMergeSpriteIndexPixelsTest(_a,_b) {
    assert(sprite_exists(_a) && sprite_exists(_b)
        && sprite_get_width(_a)==sprite_get_width(_b) && sprite_get_height(_a)==sprite_get_height(_b)
        && sprite_get_xoffset(_a)==sprite_get_xoffset(_b) && sprite_get_yoffset(_a)==sprite_get_yoffset(_b)
        && sprite_get_number(_a)==sprite_get_number(_b)
        && sprite_get_bbox_left(_a)==sprite_get_bbox_left(_b) && sprite_get_bbox_right(_a)==sprite_get_bbox_right(_b)
        && sprite_get_bbox_top(_a)==sprite_get_bbox_top(_b) && sprite_get_bbox_bottom(_a)==sprite_get_bbox_bottom(_b),
        "Sprite history index changed exact geometry/origin/shine frames or bounding box");
    var _w=sprite_get_width(_a),_h=sprite_get_height(_a),_sa=surface_create(_w,_h),_sb=surface_create(_w,_h),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_target_active=false,_outer_target=surface_get_target();
    gpu_push_state();gpu_set_fog(false,0,0,0);gpu_set_blendmode_ext(bm_one,bm_zero);
    draw_set_color(c_white);draw_set_alpha(1);
    try {
        for(var _f=0;_f<sprite_get_number(_a);++_f) {
            surface_set_target(_sa);_target_active=true;draw_clear_alpha(c_black,0);
            draw_sprite(_a,_f,sprite_get_xoffset(_a),sprite_get_yoffset(_a));surface_reset_target();_target_active=false;
            surface_set_target(_sb);_target_active=true;draw_clear_alpha(c_black,0);
            draw_sprite(_b,_f,sprite_get_xoffset(_b),sprite_get_yoffset(_b));surface_reset_target();_target_active=false;
            for(var _x=0;_x<_w;++_x) for(var _y=0;_y<_h;++_y)
                assert(surface_getpixel_ext(_sa,_x,_y)==surface_getpixel_ext(_sb,_x,_y),
                    "Sprite history index changed a literal old rendered pixel");
        }
        assert(surface_get_target()==_outer_target,"Pixel fixture changed its caller's surface target");
    } finally {
        if(_target_active) surface_reset_target();
        surface_free(_sa);surface_free(_sb);gpu_pop_state();
        draw_set_color(_color);draw_set_alpha(_alpha);
    }
}
function scrNTTEFullMergeSpriteIndexBuildTest(_legacy,_scenario) {
    var _a=scr_weapon_get_sprite(wep_revolver),_b=scr_weapon_get_sprite(wep_shotgun),_c=scr_weapon_get_sprite(wep_crossbow),
        _list=undefined;
    switch(_scenario) {
        case 0:_list=[_a,_b];break;
        case 1:
            var _pair=_legacy?scrNTTEFullMergeSpriteListLegacyTest([_a,_b]):scrNTTEFullMergeSpriteList([_a,_b]);
            _list=[_pair,_c];break;
        case 2:_list=[_b,_a];break;
        case 3:_list=[mskNone,_b];break;
        case 4:_list=[sprNTTERefQuestArtifactI0,sprNTTERefQuestArtifactI1];break;
        case 5:_list=[sprNTTERefQuestArtifactSubMerge0,sprNTTERefQuestArtifactSubMerge1];break;
    }
    var _sprite=_legacy?scrNTTEFullMergeSpriteListLegacyTest(_list):scrNTTEFullMergeSpriteList(_list),
        _parts=_legacy?scrNTTEFullMergeSpritePartsLegacyTest([_sprite]):scrNTTEFullMergeSpriteParts([_sprite]);
    return {sprite:_sprite,parts:json_stringify(_parts),rows:array_length(global.ntte_full_merge_sprites)};
}
function scrNTTEFullMergedSpriteHistoryIndexNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Sprite history regression needs explicit desktop smoke");
    scrNTTEFullWeaponNativeInit();
    var _cache=variable_global_exists("ntte_full_merge_sprites")?global.ntte_full_merge_sprites:[],
        _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_seed=random_get_seed(),
        _streams=scrNTTEFullArrayCopy(global.rng_state),_owned=[],_cases=0,
        _observer=variable_global_exists("ntte_full_merge_sprite_index_test")?global.ntte_full_merge_sprite_index_test:undefined;
    try {
        global.ntte_full_merge_sprite_index_test={legacy_rows:0,build_rows:0,sprite_lookups:0,key_rows:0};
        // Exact GPU comparison exercises cold synthesis, nested/reversed inputs,
        // mskNone, original authored pairs, and cache-free full-key flattening.
        for(var _scenario=0;_scenario<6;++_scenario) {
            var _results=[];
            for(var _legacy=1;_legacy>=0;--_legacy) {
                scrNTTEFullMergeSpriteCacheReset([]);
                var _rng=random_get_seed(),_native_rng=json_stringify(global.rng_state),
                    _row=scrNTTEFullMergeSpriteIndexBuildTest(_legacy,_scenario);
                assert(random_get_seed()==_rng && json_stringify(global.rng_state)==_native_rng,
                    "Sprite index/synthesis consumed either RNG stream");
                array_push(_results,_row);_owned=scrNTTEFullMergeSpriteIndexOwnRowsTest(_owned);
            }
            assert(_results[0].parts==_results[1].parts && _results[0].rows==_results[1].rows,
                "Sprite history index changed ordered flattening or authoritative row insertion");
            scrNTTEFullMergeSpriteIndexPixelsTest(_results[0].sprite,_results[1].sprite);_cases++;
        }
        var _a=scr_weapon_get_sprite(wep_revolver),_b=scr_weapon_get_sprite(wep_shotgun),_c=scr_weapon_get_sprite(wep_crossbow),
            _alias=sprite_duplicate(_a),_alias2=sprite_duplicate(_b);
        array_push(_owned,_alias,_alias2);
        var _rowsA=[{sprite:_alias,parts:[_a,_b],key:"source-A"},{sprite:_alias,parts:[_c,_a],key:"source-B"}],
            _rowsB=[{sprite:_alias,parts:[_b,_c],key:"source-C"},{sprite:_alias2,parts:[_a,_c],key:"source-D"}];
        scrNTTEFullMergeSpriteCacheReset(_rowsA);
        assert(json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify([_a,_b]),
            "Sprite index lost first source-row precedence for a duplicate sprite identity");
        // Deliberately replace the authoritative array directly, at the same
        // length, to prove that boundary row identities detect this as well.
        global.ntte_full_merge_sprites=_rowsB;
        assert(json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify(scrNTTEFullMergeSpritePartsLegacyTest([_alias]))
            && json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify([_b,_c]),
            "Same-length external sprite-cache replacement retained the old index");
        scrNTTEFullMergeSpriteCacheReset(_rowsA);
        assert(json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify([_a,_b]),
            "Restoring the source cache left fixture row references in the index");
        var _prior=_rowsA[0].parts;_rowsA[0].parts=[_c,_b];scrNTTEFullMergeSpriteCacheInvalidate();
        assert(json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify(scrNTTEFullMergeSpritePartsLegacyTest([_alias])),
            "Explicit source-row edit invalidation failed ordered flattening");
        _rowsA[0].parts=_prior;scrNTTEFullMergeSpriteCacheInvalidate();
        assert(json_stringify(scrNTTEFullMergeSpriteParts([_alias]))==json_stringify([_a,_b]),
            "Source-row restoration retained an edited nested-parts array");_cases++;
        var _q0=sprNTTERefQuestArtifactI0,_q1=sprNTTERefQuestArtifactI1,
            _questkey=string(_q0)+":"+string(_q1)+":",
            _stale={sprite:_alias,parts:[_c,_b],key:_questkey};
        scrNTTEFullMergeSpriteCacheReset([_stale]);
        assert(scrNTTEFullMergeSpriteList([_q0,_q1])==sprNTTERefQuestArtifactSubMerge0
            && _stale.sprite==sprNTTERefQuestArtifactSubMerge0 && array_length(global.ntte_full_merge_sprites)==1
            && is_undefined(scrNTTEFullMergeSpriteFindSource(_alias))
            && scrNTTEFullMergeSpriteFindSource(sprNTTERefQuestArtifactSubMerge0)==_stale,
            "Authored quest lookup failed first stale-row replacement or sprite-index invalidation");
        // The same authored draw repeats every frame: unchanged sprite identity
        // must update its row.parts alias without rebuilding history each time.
        global.ntte_full_merge_sprite_index_test={legacy_rows:0,build_rows:0,sprite_lookups:0,key_rows:0};
        repeat(16) assert(scrNTTEFullMergeSpriteList([_q0,_q1])==sprNTTERefQuestArtifactSubMerge0,
            "Repeated authored quest sprite changed its source identity");
        assert(global.ntte_full_merge_sprite_index_test.build_rows==0,
            "An unchanged authored quest row invalidates the history index every draw");_cases++;
        scrNTTEFullMergeSpriteCacheReset([]);
        var _dead=scrNTTEFullMergeSpriteList([_a,_b]);_owned=scrNTTEFullMergeSpriteIndexOwnRowsTest(_owned);
        sprite_delete(_dead);
        var _replacement=scrNTTEFullMergeSpriteList([_a,_b]);_owned=scrNTTEFullMergeSpriteIndexOwnRowsTest(_owned);
        assert(sprite_exists(_replacement) && array_length(global.ntte_full_merge_sprites)==2
            && global.ntte_full_merge_sprites[0].sprite==_dead
            && scrNTTEFullMergeSpriteListLegacyTest([_a,_b])==_replacement
            && scrNTTEFullMergeSpriteList([_a,_b])==_replacement
            && json_stringify(scrNTTEFullMergeSpriteParts([_replacement]))==json_stringify(scrNTTEFullMergeSpritePartsLegacyTest([_replacement])),
            "Deleted dynamic sprite was returned or changed stale-row/new-row precedence");_cases++;
        // Populate a natural long-run history using distinct real compositions,
        // then call the actual context-sensitive native getter repeatedly.
        scrNTTEFullMergeSpriteCacheReset([]);
        var _sources=[];
        for(var _raw=1;_raw<min(maxwep,100) && array_length(_sources)<16;++_raw) {
            var _sprite=scr_weapon_get_sprite(_raw);
            if(sprite_exists(_sprite) && array_get_index(_sources,_sprite)<0) array_push(_sources,_sprite);
        }
        assert(array_length(_sources)==16,"Sprite history fixture needs sixteen distinct native source sprites");
        for(var _i=0;_i<16;++_i) for(var _j=0;_j<16;++_j) scrNTTEFullMergeSpriteList([_sources[_i],_sources[_j]]);
        var _handles=[scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun)),
            scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_shotgun,wep_revolver)),
            scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(scrNTTEFullWeaponMerge(wep_revolver,wep_crossbow),wep_grenade_launcher))],
            _states=[];
        for(var _i=0;_i<3;++_i) {
            var _state=scrNTTEFullWeaponNativeState(_handles[_i]);array_push(_states,_state);
            for(var _mode=0;_mode<3;++_mode) scrNTTEFullWeaponNativeSprite(_handles[_i],_mode==1,_state,_mode==2);
        }
        var _history=array_length(global.ntte_full_merge_sprites);scrNTTEFullMergeSpriteIndex();
        assert(_history>=256,"Real composition history did not contain the requested distinct cache rows");
        var _results=[],_calls=0;
        for(var _legacy=1;_legacy>=0;--_legacy) {
            global.ntte_full_merge_sprite_index_test={legacy_rows:0,build_rows:0,sprite_lookups:0,key_rows:0};
            var _returned=[],_start=get_timer();
            repeat(128) for(var _i=0;_i<3;++_i) for(var _mode=0;_mode<3;++_mode) {
                var _sprite=_legacy?scrNTTEFullWeaponNativeSpriteLegacyIndexTest(_handles[_i],_mode==1,_states[_i],_mode==2)
                    :scrNTTEFullWeaponNativeSprite(_handles[_i],_mode==1,_states[_i],_mode==2);
                array_push(_returned,_sprite);
                assert(_states[_i].weapon==_handles[_i] && scrNTTEFullWeaponNativeState(_handles[_i])==_states[_i],
                    "Sprite index changed a live canonical physical state or its handle");
            }
            array_push(_results,{returned:json_stringify(_returned),cost:global.ntte_full_merge_sprite_index_test,
                elapsed:get_timer()-_start,rng:random_get_seed(),streams:json_stringify(global.rng_state)});
            _calls=array_length(_returned);
        }
        assert(_results[0].returned==_results[1].returned && _results[0].rng==_results[1].rng
            && _results[0].streams==_results[1].streams && array_length(global.ntte_full_merge_sprites)==_history,
            "History indexing changed real held/world/HUD identity, appended sprites or consumed RNG");
        assert(_results[0].cost.legacy_rows>=_history*_calls && _results[1].cost.build_rows==0
            && _results[1].cost.key_rows==_calls && _results[1].cost.sprite_lookups<=_calls*3,
            "Warm actual native getters still traverse historical sprite compositions");
        _owned=scrNTTEFullMergeSpriteIndexOwnRowsTest(_owned);_cases++;
        scrNTTESmokeLog("SPRITE HISTORY INDEX PASS history="+string(_history)+" actual_getters="+string(_calls)
            +" old_rows="+string(_results[0].cost.legacy_rows)+" new_build_rows="+string(_results[1].cost.build_rows)
            +" key_rows="+string(_results[1].cost.key_rows)+" host_us="+string(_results[0].elapsed)+"->"+string(_results[1].elapsed)
            +" exact nested/reversed/authored/deletion/reset/restore/GPU/contexts/RNG cases="+string(_cases)+" @"+string(30/timescale));
    } finally {
        for(var _i=0;_i<array_length(_owned);++_i) if(sprite_exists(_owned[_i])) sprite_delete(_owned[_i]);
        scrNTTEFullMergeSpriteCacheReset(_cache);global.ntte_full_native_weapon_models=_models;
        random_set_seed(_seed);global.rng_state=_streams;global.ntte_full_merge_sprite_index_test=_observer;
    }
}
