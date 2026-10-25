// temerge.mod.gml 334..772: merged names, style accumulation and loading tips.
// All calls take the original LWO; native inventory handles resolve before here.
function scrNTTEFullNameColor(_tag) {
    switch(_tag) {
        case "s": return make_color_rgb(125,131,141);
        case "b": return make_color_rgb(22,97,223);
        case "r": return make_color_rgb(252,56,0);
        case "y": return make_color_rgb(250,171,0);
        case "d": return make_color_rgb(59,62,67);
        case "g": return make_color_rgb(68,198,22);
        case "p": return make_color_rgb(86,34,110);
        case "w": return c_white;
    }
    if(string_pos("(color:",_tag)==1 && string_char_at(_tag,string_length(_tag))==")")
        return real(string_copy(_tag,8,string_length(_tag)-8));
    return undefined;
}
function scrNTTEFullMergeTextRange(_items,_offset,_length) {
    var _result=[];
    for(var _i=_offset;_i<min(array_length(_items),_offset+_length);++_i) array_push(_result,_items[_i]);
    return _result;
}
function scrNTTEFullNameColorTag(_color) {
    var _tags=["s","b","r","y","d","g","p","w"];
    for(var _i=0;_i<array_length(_tags);++_i)
        if(scrNTTEFullNameColor(_tags[_i])==_color) return "@"+_tags[_i];
    return "@(color:"+string(_color)+")";
}
function scrNTTEFullNameWords(_name) {
    var _words=[{space:" ",color:c_white,shake:0,text:""}],_color=c_white,_shake=0;
    // Each tag changes the style of subsequent text, preserving inline tags
    // when a style change happens halfway through a word.
    var _chunks=[],_text="",_tag="",_pos=1,_length=string_length(_name);
    while(_pos<=_length) {
        var _char=string_char_at(_name,_pos++);
        if(_char!="@") { _text+=_char; continue; }
        array_push(_chunks,[_tag,_text]); _text=""; _tag="";
        if(_pos<=_length) {
            var _start=_pos;
            // NTT sprite slot tags include an optional leading digit.
            if(string_pos(string_char_at(_name,_pos),"123456789")>0
                && string_char_at(_name,_pos+1)=="(") _pos++;
            if(string_char_at(_name,_pos)=="(") {
                while(_pos<=_length && string_char_at(_name,_pos)!=")") _pos++;
                _pos=min(_length+1,_pos+1);
            }
            else _pos++;
            _tag=string_copy(_name,_start,_pos-_start);
        }
    }
    array_push(_chunks,[_tag,_text]);
    for(var _chunk=0;_chunk<array_length(_chunks);++_chunk) {
        _tag=_chunks[_chunk][0];
        if(_chunk>0) {
            var _new_color=scrNTTEFullNameColor(_tag);
            if(!is_undefined(_new_color)) _color=_new_color;
            else if(_tag=="q" || _tag=="Q") _shake++;
            else { _words[array_length(_words)-1].text+="@"+_tag; _tag=""; }
        }
        var _lines=string_split(_chunks[_chunk][1],"#");
        for(var _line=0;_line<array_length(_lines);++_line) {
            var _parts=string_split(_lines[_line]," ");
            if(_line==0) {
                var _last=_words[array_length(_words)-1],_first=_parts[0];
                if(_last.text=="") { _last.color=_color; _last.shake=_shake; }
                else if(_first!="") {
                    _last.final_color=_color; _last.final_shake=_shake;
                    if(_tag!="") _last.text+="@"+_tag;
                }
                _last.text+=_first;
            }
            for(var _i=(_line==0?1:0);_i<array_length(_parts);++_i)
                array_push(_words,{space:_i>0?" ":"#",color:_color,shake:_shake,text:_parts[_i]});
        }
    }
    return _words;
}
function scrNTTEFullNameCompare(_word) {
    var _length=string_length(_word.text);
    while(_length>0 && string_char_at(_word.text,_length)=="!") _length--;
    return string_upper(string_copy(_word.text,1,_length));
}
function scrNTTEFullNameFind(_words,_text,_last=false) {
    var _result=-1;
    for(var _i=0;_i<array_length(_words);++_i) if(scrNTTEFullNameCompare(_words[_i])==_text) {
        _result=_i; if(!_last) break;
    }
    return _result;
}
function scrNTTEFullNameAddStyle(_word,_with) {
    var _color=_word.color,_colors=[scrNTTEFullNameColor("r"),scrNTTEFullNameColor("y"),scrNTTEFullNameColor("g"),scrNTTEFullNameColor("b")];
    var _index=array_get_index(_colors,_color);
    if((_index>=0 || color_get_saturation(_color)<255 || color_get_value(_color)<242)
        && _index+1<array_length(_colors)) {
        _word.color=_colors[_index+1]; if(_index>=0) _word.text+="!";
    }
    else {
        var _hue=color_get_hue(_color)+39;
        if(_hue>=255) { _hue=_hue mod 255; _word.shake++; }
        _word.color=make_color_hsv(_hue,255,242);
    }
    _word.shake+=_with.shake;
}
function scrNTTEFullMergeNameStrings(_stock,_front,_is_part=false,_stock_empty=false,_front_empty=false) {
    if(_stock=="" && _front=="") return _stock;
    var _stock_words=scrNTTEFullNameWords(_stock),_front_words=scrNTTEFullNameWords(_front);
    var _words=_front==""?_stock_words:_front_words;
    if(_front!="" && _stock!="") {
        var _suffix=_stock_words[array_length(_stock_words)-1],_suffix_text=scrNTTEFullNameCompare(_suffix);
        var _prefix=scrNTTEFullMergeTextRange(_stock_words,0,array_length(_stock_words)-1);
        for(var _i=array_length(_prefix)-1;_i>=0;--_i) {
            var _at=scrNTTEFullNameFind(_words,scrNTTEFullNameCompare(_prefix[_i]));
            if(_at>=0) {
                if(_words[_at].text!="GOLDEN") scrNTTEFullNameAddStyle(_words[_at],_prefix[_i]);
                array_delete(_prefix,_i,1);
            }
        }
        if(array_length(_prefix)>0) _words=array_concat(_prefix,_words);
        switch(_suffix_text) {
            case "GUN": case "PISTOL": case "LAUNCHER": case "REVOLVER": case "BLASTER":
                if(array_length(_prefix)>0) _suffix_text="";
                break;
            case "RIFLE": if(scrNTTEFullNameFind(_words,"ASSAULT")>=0) _suffix_text=""; break;
            case "CANNON": if(scrNTTEFullNameFind(_words,"FLAK")>=0) _suffix_text=""; break;
        }
        if(_suffix_text!="") {
            var _last=array_length(_words)-1,_last_text=scrNTTEFullNameCompare(_words[_last]);
            if(array_contains(["STOCK","FRONT","PARTS"],_last_text)) _last_text=scrNTTEFullNameCompare(_words[--_last]);
            switch(_last_text) {
                case "GUN": case "PISTOL": case "LAUNCHER": _words[_last]=_suffix; break;
                default:
                    var _at=scrNTTEFullNameFind(_words,_suffix_text,true);
                    if(_at>=0) scrNTTEFullNameAddStyle(_words[_at],_suffix);
                    else array_insert(_words,_last+1,_suffix);
            }
        }
    }
    if(_is_part && (_stock_empty ^^ _front_empty)) {
        var _last=array_length(_words)-1,_last_text=scrNTTEFullNameCompare(_words[_last]);
        if(_last_text!="PARTS") {
            var _text;
            if(_last_text==(_stock_empty?"STOCK":"FRONT")) _text="PARTS";
            else { _last++; _text=_stock_empty?"FRONT":"STOCK"; }
            _words[_last]={space:" ",color:c_white,shake:0,text:_text};
        }
    }
    var _result="",_color=c_white,_shake=0;
    _words[0].space="";
    for(var _i=0;_i<array_length(_words);++_i) {
        var _word=_words[_i]; _result+=_word.space;
        if(_word.color!=_color) _result+=scrNTTEFullNameColorTag(_word.color);
        _color=variable_struct_exists(_word,"final_color")?_word.final_color:_word.color;
        if(_word.shake!=_shake) repeat(max(0,_word.shake-_shake)) _result+="@q";
        _shake=variable_struct_exists(_word,"final_shake")?_word.final_shake:_word.shake;
        _result+=_word.text;
    }
    return _result;
}
function scrNTTEFullMergedName(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    var _raw=scrNTTEFullWeaponRaw(_weapon),_stock=scrNTTEFullMergedStockName(_weapon);
    if(scrNTTEFullWeaponHasMerge(_weapon)!=true) return _stock;
    var _front=_weapon.temerge.wep[0];
    return scrNTTEFullMergeNameStrings(_stock,scrNTTEFullMergedName(_front),_weapon.temerge.is_part,
        _raw==wep_none,scrNTTEFullWeaponRaw(_front)==wep_none);
}
function scrNTTEFullMergedText(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon);
    var _raw=scrNTTEFullWeaponRaw(_weapon),_stock=_raw==wep_none?"":scrNTTEFullTunnellerStockText(_weapon);
    if(scrNTTEFullWeaponHasMerge(_weapon)!=true) return _stock;
    var _front=_weapon.temerge.wep[0],_front_text=scrNTTEFullMergedText(_front);
    if(is_string(_stock) && _stock!="" && is_string(_front_text) && _front_text!="") {
        var _result=string_lower(_stock); _front_text=string_lower(_front_text);
        var _merged_name=string_lower(scrNTTEFullMergedName(_weapon));
        _front_text=string_replace(_front_text,string_lower(scrNTTEFullMergedName(_front)),_merged_name);
        _result=string_replace(_result,string_lower(scr_weapon_get_name(_raw)),_merged_name);
        var _stock_type=scr_weapon_get_type(_raw),_front_type=scrNTTEFullWeaponMergeProperty(_front,"type");
        if(_stock_type>=0 && _stock_type<6 && _stock_type!=_front_type && _front_type>=0 && _front_type<6) {
            var _types=[["swing"],["bullet"],["shell"],["bolt"],["explosive","grenade","nade"],["plasma"]];
            for(var _i=0;_i<array_length(_types[_stock_type]);++_i)
                _result=string_replace_all(_result,_types[_stock_type][_i],_types[_front_type][0]);
        }
        var _a=string_split(_front_text," "),_b=string_split(_result," ");
        return string_join_ext(" ",scrNTTEFullMergeTextRange(_a,0,max(1,floor(array_length(_a)/2))))+" "
            +string_join_ext(" ",scrNTTEFullMergeTextRange(_b,floor(array_length(_b)/2),ceil(array_length(_b)/2)));
    }
    return _front_text;
}
function scrNTTEFullMergedTextTests() {
    assert(scrNTTEFullMergeNameStrings("SUPER PLASMA CANNON","AUTO SHOTGUN")=="SUPER PLASMA AUTO SHOTGUN CANNON","Source multiword name insertion changed");
    assert(scrNTTEFullMergeNameStrings("ASSAULT RIFLE","SHOTGUN")=="ASSAULT SHOTGUN","Source assault suffix rule changed");
    assert(scrNTTEFullMergeNameStrings("PLASMA RIFLE","DISC GUN")=="PLASMA DISC RIFLE","Source redundant gun replacement changed");
    assert(scrNTTEFullMergeNameStrings("HEAVY MACHINEGUN","MACHINEGUN")=="HEAVY @rMACHINEGUN","Duplicate suffix style accumulation changed");
    assert(scrNTTEFullMergeNameStrings("GOLDEN REVOLVER","GOLDEN SHOTGUN")=="GOLDEN SHOTGUN REVOLVER","GOLDEN prefix must not accumulate style");
    assert(scrNTTEFullMergeNameStrings("","REVOLVER",true,true,false)=="REVOLVER FRONT","Front part label changed");
    assert(scrNTTEFullMergeNameStrings("REVOLVER STOCK","",true,true,false)=="REVOLVER PARTS","Opposing part labels must become PARTS");
    var _word={space:" ",color:scrNTTEFullNameColor("r"),shake:0,text:"PLASMA"};
    scrNTTEFullNameAddStyle(_word,{shake:1});
    assert(_word.text=="PLASMA!" && _word.color==scrNTTEFullNameColor("y") && _word.shake==1,"Source colored duplicate hue/exclamation/shake changed");
    var _words=scrNTTEFullNameWords("@rPLAS@qMA#@yGUN");
    assert(array_length(_words)==2 && _words[0].text=="PLAS@qMA" && _words[0].final_shake==1
        && _words[1].space=="#" && _words[1].color==scrNTTEFullNameColor("y"),"Name parser lost inline style or line break");
    var _merge=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun);
    assert(scrNTTEFullMergedName(_merge)=="SHOTGUN REVOLVER","Recursive weapon names changed");
    scrNTTESmokeLog("PASS source merged name suffix/prefix rules, duplicate styles, part labels, inline tags and recursive weapon name");
}

// BEGIN FOLLOWUP69 PICKUP PRESENTATION
// temerge6036..6105: original pickup component subtext, without mutating the
// physical merge graph or using a generated sprite with a Latin-only font.
function scrNTTEFullMergedStockName(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model),
        _name=_raw==wep_none?"":scr_weapon_get_name(_raw);
    if(scrNTTEFullCrabboneIs(_model)) _name=scrNTTEFullBoneWeaponMetadata(_model,"name",_name);
    _name=scrNTTEFullTunnellerMetadata(_model,"name",_name);
    return scrNTTEFullWeaponSkinName(_model,_name);
}
function scrNTTEFullMergedPickupSubtitle(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon);
    if(scrNTTEFullWeaponHasMerge(_model)!=true) return "";
    var _is_part=_model.temerge.is_part,_names=[];
    while(true) {
        var _name=scrNTTEFullMergedStockName(_model);
        if(_name!="") array_push(_names,scrNTTEFullWeaponNameDisplay(_name));
        if(scrNTTEFullWeaponHasMerge(_model)!=true) break;
        _model=scrNTTEFullWeaponMergedPart(_model);
    }
    if(array_length(_names)==0) return "";
    if(_is_part) return scrNTTEFullIsSimplifiedChinese()
        ?"武器部件"+(array_length(_names)==1?"":" / @s"+string_join_ext(" @s+ ",_names))
        :(array_length(_names)==1?"WEAPON PART":"WEAPON PARTS / @s"+string_join_ext(" @s+ ",_names));
    return string_join_ext(" + ",_names);
}
function scrNTTEFullDrawMergedPickupTitle(_weapon,_x,_y,_name) {
    var _subtitle=scrNTTEFullMergedPickupSubtitle(_weapon);
    if(_subtitle=="") {
        scrNTTEFullDrawText(_x,_y-31,_name);
        return undefined;
    }
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    // Resolve Simplified Chinese with the same fully populated font used by
    // other in-game UI; a small Latin title font produces missing-glyph boxes.
    draw_set_font(global.language_font_default);
    draw_set_halign(fa_center);draw_set_valign(fa_top);
    var _title=scrNTTEFullDisplay(_name),_width=max(1,render_parse_text(_subtitle).width),
        _available=max(1,view_width-16),
        _scale=min(scrNTTEFullIsSimplifiedChinese()?0.75:1,_available/_width),
        _title_width=max(1,render_parse_text(_title).width),_title_scale=min(1,_available/_title_width),
        _sx=clamp(_x,8+_width*_scale/2,view_width-8-_width*_scale/2),
        _tx=clamp(_x,8+_title_width*_title_scale/2,view_width-8-_title_width*_title_scale/2),
        _layout={title:_title,subtitle:_subtitle,title_x:_tx,
            title_y:_y-31-max(11,ceil(font_get_string_height(_title)*_title_scale)+3),
            subtitle_x:_sx,subtitle_y:_y-31,subtitle_scale:_scale,font:draw_get_font()};
    scrNTTEFullDrawText(_tx,_layout.title_y,_title,_title_scale);
    draw_text_nt(_sx,_layout.subtitle_y,_subtitle,_scale);
    draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);
    return _layout;
}

function scrNTTEFullFollowup69PresentationNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _owner=instance_find(Player,0),_lang=global.language_current,
        _small=global.language_font_default,_big=global.language_font_bigname_default,
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_seed=random_get_seed(),_custom=UberCont.custom,
        _custom_options=UberCont.custom_options,
        _draw=scrNTTEFullCoastDrawState(),_shader=shader_current(),_target=false,
        _surface=surface_create(512,240),_camera=camera_create_view(0,0,512,240,0,noone,-1,-1,-1,-1);
    assert(surface_exists(_surface),"Presentation test surface unavailable");
    gpu_push_state();
    try {
        UberCont.custom_options=new CustomModeOptions("followup69-presentation-fixture");UberCont.custom=true;
        // Real collision -> projectile Destroy/Cleanup -> final pickup class
        // -> inherited Step and Draw, both normal and golden physical weapons.
        var _variants=[wep_ntte_trident,wep_ntte_golden_trident];
        for(var _v=0;_v<2;++_v) {
            var _enemy=instance_create(251000+100*_v,251000,Bandit),
                _state=scrNTTENewState(_variants[_v]),
                _shot=instance_create(_enemy.x,_enemy.y,NTTEFullTrident);
            _enemy.hp=200;_enemy.team=team_enemy;
            _shot.creator=_owner;_shot.team=team_player;_shot.wep=_variants[_v];_shot.state=_state;
            _shot.speed=18*timescale;
            with(_enemy) with(_shot) event_perform(ev_collision,hitme);
            assert(_shot.target==_enemy,"Trident test did not hit a surviving native enemy");
            instance_destroy(_shot);
            var _pickup=noone;
            with(NTTEFullWepPickupStick) if(ntte_state==_state) _pickup=id;
            assert(instance_exists(_pickup) && scrNTTEFullWeaponRaw(_pickup.wep)==_variants[_v]
                && _pickup.stick_target==_enemy && _pickup.ntte_state==_state,
                "Attached trident lost its actual physical weapon/target/state");
            var _expected=scrNTTERefSprite(_v==0?"Weapon.trident.sprWep":"Weapon.trident.sprWepGold");
            assert(_pickup.sprite_index==_expected && _pickup.sprite_index!=sprScrewDriver,
                "Attached normal/golden trident inherited screwdriver art at creation");
            with(_pickup) event_perform(ev_step,ev_step_normal);
            var _position=[_pickup.x,_pickup.y];_pickup.x=40;_pickup.y=40;
            surface_set_target(_surface);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
            shader_reset();gpu_set_blendmode(bm_normal);draw_clear_alpha(c_black,0);
            with(_pickup) event_perform(ev_draw,0);
            surface_reset_target();_target=false;
            surface_save(_surface,working_directory+"ntte-followup69-trident-"+string(_v)+"-"+string(30/timescale)+".png");
            _pickup.x=_position[0];_pickup.y=_position[1];
            assert(_pickup.sprite_index==_expected && scrNTTEFullWeaponRaw(_pickup.wep)==_variants[_v],
                "Attached trident inherited Step/Draw reverted its physical art");
            _pickup.stick_damage=0;instance_destroy(_enemy,false);
            with(_pickup) event_perform(ev_step,ev_step_normal);
            assert(_pickup.stick_target==noone && _pickup.sprite_index==_expected,
                "Detached trident lost original normal/golden art");
        }
        // Original crabbone lightweight models store artifact identity in
        // type_index even when every part shares the ordinary bone raw ID.
        var _parts=[];
        for(var _i=0;_i<4;++_i) {
            var _part=scrNTTEFullCrabboneCreateModel(_i);
            _part.wep=wep_ntte_bone;array_push(_parts,_part);
        }
        var _pairA=scrNTTEFullWeaponMerge(_parts[0],_parts[1]),
            _pairB=scrNTTEFullWeaponMerge(_parts[2],_parts[3]),
            _full=scrNTTEFullWeaponMerge(_pairA,_pairB),_handle=scrNTTEFullWeaponNative(_full),
            _state=scrNTTEFullWeaponNativeState(_handle),_pickup=scrWeaponPickupCreate(252000,252000,_handle);
        scrNTTEFullQuestArtifactSpriteAssert(_handle,_state,sprNTTERefQuestArtifactMerge,[0,1,2,3],_pickup);
        assert(sprite_get_width(_pickup.sprite_index)==60,"Complete original key is still clipped to half artwork");
        surface_set_target(_surface);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        draw_clear_alpha(c_black,1);
        draw_sprite_ext(_pickup.sprite_index,0,30,60,4,4,0,c_white,1);
        surface_reset_target();_target=false;
        surface_save(_surface,working_directory+"ntte-followup69-key-"+string(30/timescale)+".png");
        var _loaded=scrNTTEFullWeaponNative(json_parse(json_stringify(_full)));
        scrNTTEFullQuestArtifactSpriteAssert(_loaded,scrNTTEFullWeaponNativeState(_loaded),
            sprNTTERefQuestArtifactMerge,[0,1,2,3]);
        // Source-order subtext for nested merges and parts. Calling it must
        // not disable a stock's active merge or change physical state.
        var _fusion=scrNTTEFullWeaponMerge(wep_grenade_launcher,scrNTTEFullWeaponMerge(wep_shotgun,wep_crossbow)),
            _fingerprint=json_stringify(_fusion),_locales=["English","Simplified Chinese"];
        for(var _l=0;_l<2;++_l) {
            scrLanguageSet(_locales[_l]);
            global.language_font_default=_l==0?fntM1:fntCJK;
            draw_set_font(fntM1);draw_set_halign(fa_left);draw_set_valign(fa_middle);
            surface_set_target(_surface);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
            draw_clear_alpha(c_black,1);
            var _layout=scrNTTEFullDrawMergedPickupTitle(_fusion,view_width/2,100,scr_weapon_get_name(_fusion));
            surface_reset_target();_target=false;
            assert(_layout.subtitle==scrNTTEFullWeaponNameDisplay(scr_weapon_get_name(wep_grenade_launcher))+" + "
                +scrNTTEFullWeaponNameDisplay(scr_weapon_get_name(wep_shotgun))+" + "
                +scrNTTEFullWeaponNameDisplay(scr_weapon_get_name(wep_crossbow)),
                "Fusion subtitle omitted or reordered its original stock/front components");
            assert(_layout.font==(_l==0?fntM1:fntCJK) && _layout.title_y<_layout.subtitle_y
                && _layout.subtitle_y<100-21 && draw_get_font()==fntM1
                && draw_get_halign()==fa_left && draw_get_valign()==fa_middle,
                "Fusion subtitle lost correct Chinese font, HUD spacing or restored Draw state");
            assert(json_stringify(_fusion)==_fingerprint,"Pickup subtitle mutated the physical merge");
            draw_set_font(_layout.font);
            var _subtitle_width=max(1,render_parse_text(_layout.subtitle).width),
                _expected_scale=min(_l==0?1:0.75,max(1,view_width-16)/_subtitle_width);
            draw_set_font(fntM1);
            // GML's default comparison epsilon is 1e-5; an unscaled <1e-5
            // rejects even an exact zero delta. Compare in scaled units.
            assert(abs(_layout.subtitle_scale-_expected_scale)*1000000<10,
                "Composition subtitle scale mismatch locale="+_locales[_l]
                +" actual="+string(_layout.subtitle_scale)+" expected="+string(_expected_scale));
            surface_save(_surface,working_directory+"ntte-followup69-subtitle-"+string(_l)+"-"+string(30/timescale)+".png");
            scrNTTESmokeLog("FOLLOWUP69 SUBTITLE "+_locales[_l]+": "+_layout.subtitle);
        }
        assert(scrNTTEFullMergedPickupSubtitle(wep_revolver)=="","Ordinary weapon unexpectedly gained fusion subtext");
        scrNTTESmokeLog("FOLLOWUP69 PRESENTATION actual normal/golden Trident collision-cleanup-Step-Draw-detach; original crabbone type_index four-part full-key world/held/HUD/pickup/save; nested fusion EN/ZH subtitle/fonts/spacing/state PASS @"+string(30/timescale));
    } finally {
        var _all=scrNTTEFullInstances(all);
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) {
            if(instance_is(_all[_i],NTTEFullTrident)) _all[_i].wep=wep_none;
            if(instance_is(_all[_i],NTTEFullWepPickupStick)) _all[_i].stick_damage=0;
            instance_destroy(_all[_i],false);
        }
        if(_target) surface_reset_target();
        surface_free(_surface);camera_destroy(_camera);
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        scrNTTEFullAreaGeneratorRestore(_game);
        global.language_current=_lang;global.language_font_default=_small;global.language_font_bigname_default=_big;
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_color);draw_set_alpha(_alpha);
        random_set_seed(_seed);
        UberCont.custom=_custom;UberCont.custom_options=_custom_options;
    }
}
