// Content-independent legacy NTT APIs used by the frozen Frontier source.
// Native parity providers stay responsible for damage, seeded drops and text.
function scrFRSoundResolve(_sound) {
    if(!variable_global_exists("fr_sound_replacements")) return _sound;
    // Each value is a physical packaged sample captured at assignment time.
    // Do not follow it as another logical target: later assignments to that
    // target cannot change audio data already copied into an earlier target.
    return global.fr_sound_replacements[$ string(_sound)]??_sound;
}
function scrFRSoundAdd(_path) {
    var _key=scrFRAssetPath(_path),_asset=global.fr_asset_sources[$ _key];
    if(is_undefined(_asset)) throw "Frontier sound was not packaged: "+string(_path);
    return _asset;
}
function scrFRSoundAssign(_sound,_replacement) {
    // Copying a sound onto itself preserves any sample previously assigned.
    if(_sound==_replacement) return _replacement;
    global.fr_sound_replacements[$ string(_sound)]=scrFRSoundResolve(_replacement);
    return _replacement;
}
function scrFRSoundRestore(_sound) {
    variable_struct_remove(global.fr_sound_replacements,string(_sound));return _sound;
}
function scrFRSoundPlay(_sound) {
    return snd_play(_sound);
}
function scrFRSoundPitch(_sound,_pitch) { return scrFRSoundPitchVolume(_sound,_pitch,1); }
function scrFRSoundPitchVolume(_sound,_pitch,_volume) {
    return snd_play(_sound,max(0.01,_pitch),max(0,_volume));
}
function scrFRSoundHit(_sound,_pitch_range=0.2) {
    return snd_play_hit(custom_sound_check(_sound),_pitch_range);
}
function scrFRSoundHitBig(_sound,_pitch_range=0.2) {
    return snd_play_hit_big(custom_sound_check(_sound),_pitch_range);
}
function scrFRSoundHitExt(_sound,_pitch=1,_volume=1) {
    var _handle=snd_play_hit(_sound,0);
    if(_handle>=0) {
        audio_sound_pitch(_handle,max(0.01,_pitch));
        // Authored helpers multiply the actual hit voice gain. Keep native
        // distance attenuation and allow the source's 1.2x emphasis.
        audio_sound_gain(_handle,audio_sound_get_gain(_handle)*max(0,_volume),0);
    }
    return _handle;
}
function scrFRSoundGun(_sound,_random_pitch=0.2,_fade=0.3) {
    // NTT's second argument is a pitch range and its third ducks the
    // background emitter; authored negative fades are intentional.
    // snd_play_gun inside this provider resolves sound assignment exactly
    // once, preserving the captured physical resource of sound_assign.
    return scrNTTEFullCustomProjectileGunSound(_sound,_random_pitch,_fade);
}
function scrFRSoundLoop(_sound) {
    if(scr_test_is_fps_uncapped()) return -1;
    _sound=custom_sound_check(_sound);
    if(!audio_exists(_sound)) return -1;
    // Original NTT snd_loop stops the sample, then returns the newly started
    // voice. Event cleanup owns that voice even if a later room uses the same
    // music sample; returning the sample incorrectly aliases those lifetimes.
    audio_stop_sound(_sound);
    return audio_play_sound_on(UberCont.mainsound,_sound,true,1,UberCont.opt_sndvol,0,1);
}
function scrFRSoundControlTarget(_sound) {
    // Source controllers retain a voice before its first play (noone), after
    // a one-shot ends, and after a sample restart retires the previous voice.
    // Those slots describe no live sound. Resolving a packaged asset remains
    // valid even while it is silent, so asset-level edits still take effect.
    if(is_undefined(_sound) || _sound==noone || _sound==-1) return undefined;
    var _resolved=custom_sound_check(_sound);
    return audio_exists(_resolved)?_resolved:undefined;
}
function scrFRSoundStop(_sound) {
    var _target=scrFRSoundControlTarget(_sound);
    if(!is_undefined(_target)) audio_stop_sound(_target);
}
function scrFRSoundStopAll() { audio_stop_all(); }
function scrFRSoundVolume(_sound,_volume) {
    var _target=scrFRSoundControlTarget(_sound);
    if(!is_undefined(_target)) audio_sound_gain(_target,max(0,_volume),0);
    return is_undefined(_target)?_sound:_target;
}
function scrFRSoundSetPitch(_sound,_pitch) {
    // Robocenter's energy hammer deliberately passes zero. Native NTT forwards
    // the authored pitch to the backend, whose supported range owns clamping.
    var _target=scrFRSoundControlTarget(_sound);
    if(!is_undefined(_target)) audio_sound_pitch(_target,_pitch);
    return is_undefined(_target)?_sound:_target;
}
function scrFRSoundPosition(_sound,_seconds) {
    var _target=scrFRSoundControlTarget(_sound);
    if(!is_undefined(_target)) audio_sound_set_track_position(_target,max(0,_seconds));
    return is_undefined(_target)?_sound:_target;
}
function scrFRSoundMusic(_sound,_loop=true) {
    var _sample=custom_sound_check(_sound);
    with(MusCont) {
        if(song!=_sample || !audio_is_playing(_sample)) {
            if(audio_exists(song)) audio_stop_sound(song);
            song=_sample;music_sound=snd_play_music(_sound,_loop);
        }
        alarm[0]=-1;alarm[1]=-1;alarm[3]=-1;
    }
    return _sound;
}
function scrFRSoundAmbient(_sound,_loop=true) {
    var _sample=custom_sound_check(_sound);
    with(MusCont) {
        if(amb!=_sample || !audio_is_playing(_sample)) {
            if(audio_exists(amb)) audio_stop_sound(amb);
            amb=_sample;snd_play_ambience(_sound,_loop);
        }
    }
    return _sound;
}

function scrFRAssetPath(_path) {
    _path=string_lower(string_replace_all(string(_path),"\\","/"));
    while(string_copy(_path,1,2)=="./") _path=string_delete(_path,1,2);
    return _path;
}
function scrFRSpriteReplace(_target,_replacement) {
    if(!sprite_exists(_target) || !sprite_exists(_replacement)) return -1;
    var _key=string(_target);
    if(!variable_struct_exists(global.fr_sprite_backups,_key)) global.fr_sprite_backups[$ _key]=sprite_duplicate(_target);
    sprite_assign(_target,_replacement);return _target;
}
function scrFRSpriteReplacePath(_target,_path,_frames=1,_xorigin=0,_yorigin=0) {
    if(!is_string(_path)) return scrFRSpriteReplace(_target,_path);
    var _key=scrFRAssetPath(_path),_replacement=global.fr_asset_sources[$ _key];
    if(is_undefined(_replacement)) throw "Frontier sprite replacement was not packaged: "+_path;
    return scrFRSpriteReplace(_target,_replacement);
}
function scrFRSpriteReplaceImage(_target,_source,_image=0) {
    if(is_string(_source)) {
        var _key=scrFRAssetPath(_source);_source=global.fr_asset_sources[$ _key];
        if(is_undefined(_source)) throw "Frontier boss artwork was not packaged: "+_key;
    }
    if(!sprite_exists(_source) || !sprite_exists(_target)) return -1;
    var _key=string(_target);
    if(!variable_struct_exists(global.fr_sprite_backups,_key)) global.fr_sprite_backups[$ _key]=sprite_duplicate(_target);
    var _w=sprite_get_width(_source),_h=sprite_get_height(_source),_surface=surface_create(_w,_h);
    if(!surface_exists(_surface)) return -1;
    surface_set_target(_surface);
    var _view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),_world=matrix_get(matrix_world);
    try {
        matrix_set(matrix_world,matrix_build_identity());
        matrix_set(matrix_view,matrix_build_identity());matrix_set(matrix_projection,matrix_build_projection_ortho(_w,_h,0,32000));
        draw_clear_alpha(c_black,0);
        draw_sprite(_source,_image,sprite_get_xoffset(_source)-_w/2,sprite_get_yoffset(_source)-_h/2);
    } finally {
        surface_reset_target();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
    }
    var _single=sprite_create_from_surface(_surface,0,0,_w,_h,false,false,sprite_get_xoffset(_source),sprite_get_yoffset(_source));
    surface_free(_surface);
    if(sprite_exists(_single)) {sprite_assign(_target,_single);sprite_delete(_single);}
    return _target;
}
function scrFRSpriteRestore(_target) {
    var _key=string(_target),_backup=global.fr_sprite_backups[$ _key];
    if(!is_undefined(_backup) && sprite_exists(_backup)) sprite_assign(_target,_backup);
    return _target;
}
function scrFRSpriteDelete(_sprite) {
    // Compiled assets are owned by the project; only their runtime backups
    // and true dynamic copies can be freed by a module cleanup callback.
    if(!sprite_exists(_sprite)) return;
    var _paths=variable_struct_get_names(global.fr_asset_sources);
    for(var _i=0;_i<array_length(_paths);++_i) if(global.fr_asset_sources[$ _paths[_i]]==_sprite) return;
    sprite_delete(_sprite);
}

function scrFRPrivateFile(_path) {
    if(!is_string(_path)) throw "Frontier settings path is not a string";
    _path=string_replace_all(_path,"\\","/");
    var _colon=string_pos(":",_path);
    if(_colon>0) {
        var _kind=string_copy(_path,1,_colon-1);
        if(array_contains(["mod","area","weapon","race","skin","skill","crown"],_kind))
            _path=_kind+"_"+string_delete(_path,1,_colon);
    }
    if(string_pos("..",_path)>0 || string_pos(":",_path)>0 || string_copy(_path,1,1)=="/")
        throw "Frontier settings path leaves the game save directory";
    var _target=game_directory+"Frontier/"+_path,_parent=filename_dir(_target);
    if(!directory_exists(game_directory+"Frontier")) directory_create(game_directory+"Frontier");
    if(!directory_exists(_parent)) directory_create(_parent);
    return _target;
}
function scrFRFileExists(_path) {
    var _key=scrFRAssetPath(_path);
    if(variable_struct_exists(global.fr_asset_sources,_key)) return true;
    return file_exists(scrFRPrivateFile(_path));
}
function scrFRFileLoad(_path) { scrFRPrivateFile(_path);return 0; }
function scrFRFileLoaded(_path) {
    // All packaged assets and local settings are available synchronously;
    // missing save files are a completed load and let source choose defaults.
    return true;
}
function scrFRFileUnload(_path) { return 0; }
function scrFRStringLoad(_path) {
    var _target=scrFRPrivateFile(_path);
    if(!file_exists(_target)) return undefined;
    var _file=file_text_open_read(_target),_text="";
    while(!file_text_eof(_file)) {
        _text+=file_text_read_string(_file);file_text_readln(_file);
        if(!file_text_eof(_file)) _text+="\n";
    }
    file_text_close(_file);return _text;
}
function scrFRStringSave(_text,_path) {
    var _target=scrFRPrivateFile(_path),_temporary=_target+".tmp",_file=file_text_open_write(_temporary);
    file_text_write_string(_file,_text);file_text_close(_file);
    var _buffer=buffer_load(_temporary);buffer_save(_buffer,_target);buffer_delete(_buffer);file_delete(_temporary);
}

function scrFRSaveLoad(_module,_defaults=undefined,_merge_defaults=false) {
    // Exact libSaves.save_load boundary for already-local native files. Its
    // authored wait(file_load()) waited for remote NTT file availability;
    // carrying that suspension over local I/O exposes partially loaded saves
    // to Options/Projectiles during bootstrap. All unrelated waits stay intact.
    var _path=_module+"Save.json",_data={};
    scrFRFileLoad(_path);
    assert(scrFRFileLoaded(_path),"Frontier local configuration did not finish synchronously");
    if(scrFRFileExists(_path)) _data=scrFRJsonDecode(scrFRStringLoad(_path));
    if(_data==scrFRJsonError()) return undefined;
    if(_merge_defaults) {
        for(var _i=0;_i<scrFRLQSize(_defaults);++_i) {
            var _key=scrFRLQKey(_defaults,_i);
            if(!scrFRVariableExists(_data,_key)) scrFRLQSet(_data,_key,scrFRLQValue(_defaults,_i));
        }
    }
    return scrFRModCallArray("mod","libSaves","save_reset",[_module,_data]);
}

function scrFRSaveLoadTests() {
    var _module="__frontier_save_fixture_"+string(get_timer()),_path=_module+"Save.json",
        _namespace=global.fr_module_vars[$ "mod:libSaves"].saves,_tasks=array_length(global.fr_tasks);
    try {
        assert(!scrFRFileExists(_path),"Frontier configuration fixture path was not isolated");
        scrFRModCallArray("mod","libSaves","save_load",[_module,{counter:7,items:[]}]);
        var _data=_namespace[$ _module];
        assert(is_struct(_data) && _data.counter==7 && is_array(_data.items)
            && array_length(global.fr_tasks)==_tasks,"Cold source save_load returned before defaults were available");
        _data.counter=19;scrFRModCallArray("mod","libSaves","save_set",[_module,"counter",19]);
        scrFRModCallArray("mod","libSaves","save_load",[_module,{counter:0,added:true}]);
        _data=_namespace[$ _module];
        assert(_data.counter==19 && _data.added && is_array(_data.items),
            "Source save_load overwrote a stored value or omitted a new default");
        scrFRStringSave("{broken",_path);
        scrFRModCallArray("mod","libSaves","save_load",[_module,{counter:0}]);
        assert(_namespace[$ _module]==_data && scrFRStringLoad(_path)=="{broken",
            "Malformed JSON was silently reset or overwritten");
        scrNTTESmokeLog("PASS FRONTIER synchronous cold/default/reload/error configuration and source save_reset");
    } finally {
        variable_struct_remove(_namespace,_module);
        var _target=scrFRPrivateFile(_path);if(file_exists(_target)) file_delete(_target);
    }
}

function scrFRTrace() {
    var _text="Frontier:";
    for(var _i=0;_i<argument_count;++_i) _text+=" "+string(argument[_i]);
    show_debug_message(_text);
}
function scrFRTraceColor(_text,_color=c_white) { show_debug_message("Frontier: "+string(_text)); }
function scrFRTraceError(_text) { show_debug_message("Frontier error: "+string(_text)); }
function scrFRTraceTime(_label=undefined) {
    static _begin=0;
    var _now=get_timer();
    if(!is_undefined(_label)) show_debug_message("Frontier "+string(_label)+": "+string((_now-_begin)/1000)+"ms");
    _begin=_now;return _now;
}
function scrFRBackgroundColour() {
    // NTT background_color is room state, never a field of callback self.
    // Its writes already use background_set_colour; read the same native
    // room background so nested with/actor callbacks see weather updates.
    var _background=__background_get_colour_element();
    return layer_background_get_blend(_background[0]);
}
function scrFRLocSet(_key,_value) { global.language_current[$ string(_key)]=_value;return _value; }

function scrFRDrawText(_x,_y,_text,_xs=1,_ys=_xs,_angle=0,_blend=draw_get_color(),_alpha=draw_get_alpha()) {
    _text=scrFROptionText(_text,"",false);
    var _font=scrFRLocalizationFont(_text);
    draw_text_nt(_x,_y,_text,_xs,_ys,_angle,_blend,_alpha);
    draw_set_font(_font);
}
function scrFRDrawTextPlain(_x,_y,_text) {
    _text=scrFRLocalize(_text);
    var _font=scrFRLocalizationFont(_text);draw_text(_x,_y,_text);draw_set_font(_font);
}
function scrFRDrawTextTransformed(_x,_y,_text,_xs,_ys,_angle) {
    _text=scrFRLocalize(_text);
    var _font=scrFRLocalizationFont(_text);draw_text_transformed(_x,_y,_text,_xs,_ys,_angle);draw_set_font(_font);
}
function scrFRDrawTextTransformedColor(_x,_y,_text,_xs,_ys,_angle,_c1,_c2,_c3,_c4,_alpha) {
    _text=scrFRLocalize(_text);
    var _font=scrFRLocalizationFont(_text);
    draw_text_transformed_color(_x,_y,_text,_xs,_ys,_angle,_c1,_c2,_c3,_c4,_alpha);
    draw_set_font(_font);
}
function scrFRDrawTextShadow(_x,_y,_text) {
    _text=scrFRLocalize(_text);var _font=scrFRLocalizationFont(_text);
    var _color=draw_get_color();draw_set_color(c_black);draw_text(_x+1,_y+1,_text);
    draw_set_color(_color);draw_text(_x,_y,_text);
    draw_set_font(_font);
}
function scrFRDrawSprite(_sprite,_subimage,_x,_y) {
    if(sprite_exists(_sprite)) draw_sprite(_sprite,_subimage,_x,_y);
}
function scrFRDrawSpriteExt(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha) {
    if(sprite_exists(_sprite)) draw_sprite_ext(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha);
    scrFRLocalizationDrawWeatherCaption(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha);
}
function scrFRDrawTooltip(_x,_y,_text,_width=undefined) {
    var _h=draw_get_halign(),_v=draw_get_valign();draw_set_halign(fa_center);draw_set_valign(fa_bottom);
    scrFRDrawText(_x,_y,_text);draw_set_halign(_h);draw_set_valign(_v);
}
function scrFRPointSeen(_x,_y,_view=-1) {
    if(_view<0) return point_in_rectangle(_x,_y,view_xview,view_yview,view_xview+view_width,view_yview+view_height);
    var _camera=view_camera[_view];
    return point_in_rectangle(_x,_y,camera_get_view_x(_camera),camera_get_view_y(_camera),
        camera_get_view_x(_camera)+camera_get_view_width(_camera),camera_get_view_y(_camera)+camera_get_view_height(_camera));
}
function scrFRViewShakeAt(_x,_y,_amount) {
    var _attenuation=clamp(1-point_distance(_x,_y,view_xview+view_width/2,view_yview+view_height/2)/640,0,1);
    BackCont.shake+=_amount*_attenuation;
}
function scrFRViewShakeMaxAt(_x,_y,_amount) {
    var _attenuation=clamp(1-point_distance(_x,_y,view_xview+view_width/2,view_yview+view_height/2)/640,0,1);
    BackCont.shake=max(BackCont.shake,_amount*_attenuation);
}
function scrFRDrawSetVisible(_index,_visible) {
    if(!variable_global_exists("fr_draw_visible")) global.fr_draw_visible=array_create(INPUT_MAX_PLAYERS,true);
    if(_index>=0 && _index<array_length(global.fr_draw_visible)) global.fr_draw_visible[_index]=_visible;
}
function scrFRDrawSetVisibleAll(_visible) { global.fr_draw_visible=array_create(INPUT_MAX_PLAYERS,_visible); }
function scrFRDrawGetVisible(_index) {
    return !variable_global_exists("fr_draw_visible") || (_index>=0 && _index<array_length(global.fr_draw_visible) && global.fr_draw_visible[_index]);
}
function scrFRDrawSurfaceScale(_surface,_x,_y,_scale,_color=c_white,_alpha=1) {
    if(surface_exists(_surface)) draw_surface_ext(_surface,_x,_y,_scale,_scale,0,_color,_alpha);
}
function scrFRProjectionSave() {
    if(!variable_global_exists("fr_projection_stack")) global.fr_projection_stack=[];
    array_push(global.fr_projection_stack,[matrix_get(matrix_world),matrix_get(matrix_view),matrix_get(matrix_projection)]);
}
function scrFRProjectionOrtho(_x,_y,_width,_height,_angle=0) {
    scrFRProjectionSave();
    matrix_set(matrix_world,matrix_build_identity());
    matrix_set(matrix_view,matrix_build(-_x-_width/2,-_y-_height/2,0,0,0,-_angle,1,1,1));
    matrix_set(matrix_projection,matrix_build_projection_ortho(_width,_height,0,32000));
}
function scrFRDrawSetProjection(_mode,_index=0) {
    // Mobile renders one local camera; NTT projection mode2 is that player's HUD.
    scrFRProjectionOrtho(view_xview,view_yview,view_width,view_height,0);
}
function scrFRDrawResetProjection() {
    if(!variable_global_exists("fr_projection_stack") || !array_length(global.fr_projection_stack)) return;
    var _state=array_pop(global.fr_projection_stack);
    matrix_set(matrix_world,_state[0]);matrix_set(matrix_view,_state[1]);matrix_set(matrix_projection,_state[2]);
}
function scrFRSurfaceSetup(_name,_width,_height,_scale=1) {
    // Reuse the existing NTTE surface cache: it recreates lost surfaces,
    // expires idle entries, and shares the mobile texture-size safeguards.
    var _entry=scrNTTEFullOutlineCacheSetup("Frontier:"+_name,_width,_height,_scale);
    if(!variable_struct_exists(_entry,"x")) {_entry.x=0;_entry.y=0;}
    return _entry;
}
function scrFRSurfaceScreenshot(_destination) {
    if(!surface_exists(_destination)) return false;
    var _source=surface_get_target();if(!surface_exists(_source)) _source=application_surface;
    if(!surface_exists(_source)) return false;
    var _width=surface_get_width(_source),_height=surface_get_height(_source),_copy=surface_create(_width,_height);
    if(!surface_exists(_copy)) return false;
    surface_copy(_copy,0,0,_source);
    surface_set_target(_destination);
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _w=surface_get_width(_destination),_h=surface_get_height(_destination);
    try {
        matrix_set(matrix_world,matrix_build_identity());matrix_set(matrix_view,matrix_build_identity());
        matrix_set(matrix_projection,matrix_build_projection_ortho(_w,_h,0,32000));
        draw_clear_alpha(c_black,0);draw_surface_stretched(_copy,-_w/2,-_h/2,_w,_h);
    } finally {
        surface_reset_target();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);surface_free(_copy);
    }
    return true;
}
function scrFRShaderSetup(_name,_texture=undefined,_values=undefined) {
    if(_name=="Unblend") return scrNTTEFullSourceUnblendBegin(is_array(_values) && array_length(_values)>0 ? _values[0]:1);
    if(_name=="Charm") return is_array(_values) && array_length(_values)>=2 && scrNTTEFullSourceCharmShaderBegin(_values[0],_values[1]);
    throw "Frontier requests an unregistered shader: "+string(_name);
}

function scrFRArrayClone(_array) {
    var _out=array_create(array_length(_array));array_copy(_out,0,_array,0,array_length(_array));return _out;
}
function scrFRIndexGet(_array,_index,_second=undefined) {
    return is_undefined(_second) ? _array[_index]:_array[_index,_second];
}
function scrFRIndexWrite(_array,_index,_value,_operation="=",_second=undefined) {
    // A plain assignment can extend an array, so it must not read the old
    // out-of-range slot. Nested modern arrays are passed by reference.
    var _next=_value;
    if(_operation!="=") _next=scrFRNumericWrite(scrFRIndexGet(_array,_index,_second),_value,_operation);
    if(is_undefined(_second)) _array[_index]=_next; else _array[_index,_second]=_next;
    return _next;
}
function scrFRIndexIncrement(_array,_index,_delta,_post,_second=undefined) {
    var _before=scrFRIndexGet(_array,_index,_second);
    scrFRIndexWrite(_array,_index,_before+_delta,"=",_second);
    return _post?_before:_before+_delta;
}
function scrFRIndexPathWrite(_array,_path,_value,_operation="=") {
    assert(is_array(_array) && array_length(_path)>0,"Frontier array write requires initialized array storage");
    var _row=_array,_last=array_length(_path)-1;
    for(var _i=0;_i<_last;++_i) {
        var _at=_path[_i];
        if(_at>=array_length(_row) || !is_array(_row[_at])) _row[_at]=[];
        _row=_row[_at];
    }
    return scrFRIndexWrite(_row,_path[_last],_value,_operation);
}
function scrFRIndexPathIncrement(_array,_path,_delta,_post) {
    var _row=_array;
    for(var _i=0;_i<array_length(_path)-1;++_i) _row=_row[_path[_i]];
    return scrFRIndexIncrement(_row,_path[array_length(_path)-1],_delta,_post);
}
function scrFRMemberIndexWrite(_scope,_field,_path,_value,_operation="=") {
    var _array=scrFRFieldGet(_scope,_field);
    if(!is_array(_array)) _array=[];
    var _result=scrFRIndexPathWrite(_array,_path,_value,_operation);
    if(is_struct(_scope)) _scope[$ _field]=_array;
    else variable_instance_set(_scope,_field,_array);
    return _result;
}
function scrFRMemberIndexIncrement(_scope,_field,_path,_delta,_post) {
    return scrFRIndexPathIncrement(scrFRFieldGet(_scope,_field),_path,_delta,_post);
}
function scrFRArraySlice(_array,_start,_count=undefined) {
    var _length=array_length(_array);
    _start=clamp(_start,0,_length);
    if(is_undefined(_count)) _count=_length-_start;
    _count=clamp(_count,0,_length-_start);
    var _result=array_create(_count);array_copy(_result,0,_array,_start,_count);return _result;
}
function scrFRArrayDelete(_array,_index,_count=1) {
    var _length=array_length(_array);_index=clamp(_index,0,_length);_count=clamp(_count,0,_length-_index);
    var _result=scrFRArraySlice(_array,0,_index);
    array_copy(_result,_index,_array,_index+_count,_length-_index-_count);return _result;
}
function scrFRArrayJoin(_array,_separator=",") {
    var _text="";
    for(var _i=0;_i<array_length(_array);++_i) {_text+=(_i>0?_separator:"")+string(_array[_i]);}
    return _text;
}
function scrFRArrayEquals(_left,_right) {
    if(!is_array(_left) || !is_array(_right) || array_length(_left)!=array_length(_right)) return false;
    for(var _i=0;_i<array_length(_left);++_i) {
        if(is_array(_left[_i]) && is_array(_right[_i])) {if(!scrFRArrayEquals(_left[_i],_right[_i])) return false;}
        else if(_left[_i]!=_right[_i]) return false;
    }
    return true;
}
function scrFRArrayFindIndex(_array,_value,_start=0) {
    if(!is_array(_array)) return -1;
    for(var _i=max(0,_start);_i<array_length(_array);++_i) if(_array[_i]==_value) return _i;
    return -1;
}
function scrFRArraySortSub(_array,_column,_ascending=true) {
    // Explicit stable insertion sort preserves NTT's original ordering for ties.
    for(var _i=1;_i<array_length(_array);++_i) {
        var _value=_array[_i],_j=_i-1;
        while(_j>=0 && (_ascending ? _array[_j][_column]>_value[_column] : _array[_j][_column]<_value[_column])) {_array[_j+1]=_array[_j];--_j;}
        _array[_j+1]=_value;
    }
    return _array;
}
function scrFRListAddArray(_list,_array) { for(var _i=0;_i<array_length(_array);++_i) ds_list_add(_list,_array[_i]);return _list; }
function scrFRListToArray(_list) {
    var _array=[];for(var _i=0;_i<ds_list_size(_list);++_i) array_push(_array,ds_list_find_value(_list,_i));return _array;
}
function scrFRListValid(_list) { return is_numeric(_list) && ds_exists(_list,ds_type_list); }
function scrFRMapValid(_map) { return is_numeric(_map) && ds_exists(_map,ds_type_map); }
function scrFRStringLPad(_value,_fill,_length) {
    _value=string(_value);_fill=string(_fill);
    if(!string_length(_fill)) return _value;
    var _missing=max(0,_length-string_length(_value));
    return string_copy(string_repeat(_fill,ceil(_missing/string_length(_fill))),1,_missing)+_value;
}

function scrFRPlayerIsActive(_index) { return is_struct(scr_playerinstance_find(_index)); }
function scrFRPlayerFindLocal(_ordinal=0) {
    for(var _i=0;_i<INPUT_MAX_PLAYERS;++_i) if(scrFRPlayerIsActive(_i) && scr_player_is_local(_i)) {if(_ordinal--<=0) return _i;}
    return -1;
}
function scrFRPlayerIsLocal(_index) { return scrFRPlayerIsActive(_index) && scr_player_is_local(_index); }
function scrFRPlayerUID(_index) {
    var _player=scr_playerinstance_find(_index);
    if(!is_struct(_player)) return undefined;
    // NTT UIDs identify the host, not the control slot. Source campfire uses
    // equal UIDs to suppress its single-player camera move in local co-op.
    if(!instance_exists(CoopController) || _player.is_local()) return "FrontierLocalHost";
    var _uid=_player.uid;
    return is_string(_uid) && _uid!="" && _uid!="N/A" ? _uid : "FrontierRemote:"+string(_player.index);
}
function scrFRPlayerColor(_index) {
    var _player=scr_playerinstance_find(_index);return is_struct(_player) ? _player.color:c_white;
}
function scrFRPlayerShowHUD(_index,_local=undefined) { return scrFRPlayerIsActive(_index) && scrFRPlayerIsLocal(is_undefined(_local)?global.index:_local); }
function scrFRPlayerOutlines(_index) { return scrNTTEFullOptionGet("outline:players"); }
function scrFRButtonReleased(_index,_action) { return scrFRButtonValue(_index,_action,"release"); }

function scrFRProjectileCanHit(_target,_check_inframes=false) { return scr_can_hit(_target,_check_inframes); }
function scrFRProjectileCanHitNP(_target) { return scr_can_hit(_target,instance_is(_target,Player)); }
function scrFRProjectileCanHitMelee(_target) {
    // NTT's native helper checks team, health and the target's melee iframe.
    return scr_can_hit(_target,true);
}
function scrFRProjectileHit(_target,_damage,_force=0,_direction=undefined) {
    return scr_projectile_hit(_target,_damage,_force*timescale,_direction,true);
}
function scrFRProjectileHitRaw(_target,_damage,_hurt_sound=1) {
    if(!instance_exists(_target)) return false;
    var _before=_target.snd_hurt,_cause=scrNTTEFullValue(id,"hitid",HitId.None),_result;
    if(_hurt_sound==0 || _hurt_sound==2) _target.snd_hurt=-1;
    else if(_hurt_sound!=1) _target.snd_hurt=custom_sound_check(_hurt_sound);
    try { _result=scr_hit(_target,_damage,_cause,true); }
    finally { if(instance_exists(_target)) _target.snd_hurt=_before; }
    if(_result && _hurt_sound==2) snd_play_hit_big(_before);
    return _result;
}
function scrFRProjectileHitPush(_target,_damage,_force) {
    return scrFRProjectileHit(_target,_damage,_force,point_direction(x,y,_target.x,_target.y));
}
function scrFRProjectileInit(_team,_creator) {
    team=_team;creator=_creator;
    if(instance_exists(_creator)) hitid=scrNTTEFullValue(_creator,"hitid",HitId.None);
    if(timescale<1) {x+=hspeed*(1/timescale-1);y+=vspeed*(1/timescale-1);}
    return id;
}
function scrFRPickupDrop(_pickup,_weapon,_offset=undefined) { return scrNTTEFullPickupDropProvider(id,_pickup,_weapon,_offset); }
function scrFRMotionAddCT(_direction,_speed) { motion_add(_direction,_speed*timescale*scrFRSourceScale()); }
function scrFRMotionStep(_amount=1) { x+=hspeed*_amount/max(timescale,0.000001);y+=vspeed*_amount/max(timescale,0.000001); }
function scrFRInstanceRectangleBBox(_x1,_y1,_x2,_y2,_targets) {
    var _out=[],_items=scrFRInstances(_targets);
    for(var _i=0;_i<array_length(_items);++_i) {
        var _item=_items[_i];
        if(scrFRSourceBBoxRead(_item,"bbox_right")>=_x1 && _item.bbox_left<=_x2
            && scrFRSourceBBoxRead(_item,"bbox_bottom")>=_y1 && _item.bbox_top<=_y2) array_push(_out,_item);
    }
    return _out;
}
function scrFRInstancesMeeting(_x,_y,_targets) {
    var _out=[],_items=scrFRInstances(_targets);
    for(var _i=0;_i<array_length(_items);++_i) if(place_meeting(_x,_y,_items[_i])) array_push(_out,_items[_i]);
    return _out;
}
function scrFRInstancesSeen(_targets,_margin_x=0,_margin_y=0,_view=-1) {
    var _out=[],_items=scrFRInstances(_targets),_x=view_xview,_y=view_yview,_w=view_width,_h=view_height;
    if(_view>=0) {var _camera=view_camera[_view];_x=camera_get_view_x(_camera);_y=camera_get_view_y(_camera);_w=camera_get_view_width(_camera);_h=camera_get_view_height(_camera);}
    for(var _i=0;_i<array_length(_items);++_i) {
        var _item=_items[_i];
        // libGeneral.instances_seen includes any collision bounds touching
        // the view. Charm redraws large actors while their origin is outside.
        if(scrFRSourceBBoxRead(_item,"bbox_right")>=_x-_margin_x && scrFRSourceBBoxRead(_item,"bbox_bottom")>=_y-_margin_y
            && _item.bbox_left<=_x+_w+_margin_x && _item.bbox_top<=_y+_h+_margin_y) array_push(_out,_item);
    }
    return _out;
}
function scrFRRandomNonsync(_amount=1) {
    static _state=0;
    if(_state<=0) _state=1+(get_timer() mod 2147483646);
    _state=(_state*48271) mod 2147483647;return (_state/2147483647)*_amount;
}

function scrFRJsonError() { return "__FrontierJsonParseError__"; }
function scrFRJsonErrorText() { return variable_global_exists("fr_json_error") ? global.fr_json_error:""; }
function scrFRJsonDecode(_text) {
    try {var _data=json_parse(_text);global.fr_json_error="";return _data;}
    catch(_error) {global.fr_json_error=string(_error);return scrFRJsonError();}
}
function scrFRJsonEncode(_value,_indent=undefined) { return json_stringify(_value,!is_undefined(_indent)); }

function scrFRVariableGet(_target,_field,_default=undefined) {
    if(_field=="object_index" && !is_struct(_target) && instance_exists(_target)) return scrFRObjectIndex(_target);
    var _value=(_field=="wep"||_field=="bwep")?scrFRWeaponSlotRead(_target,_field):scrFRFieldGet(_target,_field);
    if(is_undefined(_value)) return _default;
    switch(_field) {
        case "speed":case "hspeed":case "vspeed":case "maxspeed":case "force":case "knockback_speed":case "image_speed":return _value/timescale;
        case "gravity":case "friction":return _value/(timescale*timescale);
    }
    return _value;
}
function scrFRVariableSet(_target,_field,_value) {
    if(_field=="wep"||_field=="bwep") return scrFRWeaponSlotWrite(_target,_field,_value);
    if(scrFRAmmoField(_field)) return scrFRAmmoArrayWrite(_target,_field,_value);
    var _native=scrFRFieldName(_field,_target);
    if(string_length(_field)>=6 && string_copy(_field,1,5)=="alarm")
        return scrFRAlarmWrite(_target,real(string_delete(_field,1,5)),_value);
    if(_field=="maxhealth" && !is_struct(_target)) return scrFRMaxHealthWrite(_target,_value);
    switch(_field) {
        case "speed":case "hspeed":case "vspeed":case "maxspeed":case "force":case "knockback_speed":case "image_speed":_value*=timescale;break;
        case "gravity":case "friction":_value*=timescale*timescale;break;
        case "storedwep":_value=scrFRWeaponResolve(_value);break;
        case "area":case "lastarea":case "hqarea":case "spawnarea":_value=scrFRAreaResolve(_value);break;
        case "race":_value=scrFRRaceResolve(_value);break;
        case "bskin":case "skin":_value=scrFRSkinResolve(_value);break;
        case "sprite_index":_value=scrFRAreaSourceSprite(_value);break;
    }
    if(is_struct(_target)) variable_struct_set(_target,_native,_value);
    else if(instance_exists(_target)) variable_instance_set(_target,_native,_value);
    return _value;
}
function scrFRModNames(_kind) {
    if(_kind=="wep") _kind="weapon";
    var _prefix=_kind+":",_names=[];
    for(var _i=0;_i<array_length(global.fr_module_order);++_i) {
        var _key=global.fr_module_order[_i];
        if((global.fr_initialized[$ _key]??false) && string_copy(_key,1,string_length(_prefix))==_prefix)
            array_push(_names,string_delete(_key,1,string_length(_prefix)));
    }
    return _names;
}
function scrFRCharmInstance(_instance,_charm) {return scrFRModCall("mod","libCharm","charm_instance_raw",_instance,_charm);}
function scrFRObjectCreate(_x,_y,_name) {return scrFRModCall("mod","libGeneral","obj_create",_x,_y,_name);}
function scrFRGameSetSeed(_seed) {
    var _old=scrNTTEFullSourceSeedState(),_state=scrNTTEFullSourceSeedBuild(_seed);_state.areanum=_old.areanum;
    GameCont.ntte_full_source_seed=_state;global.seed=_state.baseseed;
    GameCont.levseed=_state.levseed;GameCont.ntte_full_source_pending_generation=_state.levseed;
    return _seed;
}
function scrFRModLoadText(_path) {
    // Bundled modules are compiled and registered at build time. Downloaded
    // scripts are never executed; the diagnostic names every rejected call.
    throw "Frontier dynamic source loading is unavailable in the packaged build: "+string(_path);
}
function scrFRSpriteTeam(_sprite) {
    var _table=scrFRTeamSpriteTable();
    for(var _i=0;_i<array_length(_table);++_i) {
        var _row=_table[_i];
        for(var _j=0;_j<array_length(_row);++_j)
            if(array_length(_row[_j])>0 && _row[_j][0]==_sprite) return _j+1;
    }
    return -1;
}
function scrFRTeamSprite(_team,_sprite) {
    var _table=scrFRTeamSpriteTable(),_index=_team-1;
    for(var _i=0;_i<array_length(_table);++_i) {
        var _row=_table[_i];
        for(var _j=0;_j<array_length(_row);++_j) if(array_length(_row[_j])>0 && _row[_j][0]==_sprite) {
            if(_index>=0 && _index<array_length(_row) && array_length(_row[_index])>0) return _row[_index][0];
            return _sprite;
        }
    }
    return _sprite;
}
function scrFRTeamInstanceSprite(_team,_instances) {
    var _items=scrFRInstances(_instances),_results=[];
    for(var _i=0;_i<array_length(_items);++_i) {
        var _instance=_items[_i];
        // Native mobile projectile objects already use their live team for
        // hit tests. Keep authored damage/motion/callback state; the six
        // hardcoded projectile pairs also need their native class converted.
        scrNTTEFullPetTwinsTeam(_instance,_team);
        if(!instance_exists(_instance)) continue;
        with(_instance) {
            sprite_index=scrFRTeamSprite(_team,sprite_index);
            if(variable_instance_exists(id,"spr_start")) spr_start=scrFRTeamSprite(_team,spr_start);
            if(variable_instance_exists(id,"spr_end")) spr_end=scrFRTeamSprite(_team,spr_end);
            if(variable_instance_exists(id,"spr_dead")) spr_dead=scrFRTeamSprite(_team,spr_dead);
            if(variable_instance_exists(id,"spr_fade")) spr_fade=scrFRTeamSprite(_team,spr_fade);
            if(variable_instance_exists(id,"spr_trail")) spr_trail=scrFRTeamSprite(_team,spr_trail);
        }
        array_push(_results,_instance);
    }
    return array_length(_results)==1?_results[0]:_results;
}
