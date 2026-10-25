// Bound compatibility framebuffer allocations, not world/camera coordinates.
// The original source quality defaults to physical-display/logical-view scale;
// a two-view cache therefore otherwise allocates >5000px on a2532px iPhone.
function scrNTTEFullIOSSurfaceScale(_w,_h,_requested,_enabled=true) {
    if(!_enabled) return _requested;
    // Leave a subpixel margin so floating-point multiplication followed by
    // ceil cannot turn a2048px limit into a2049px allocation.
    return min(_requested,(2048-0.000001)/max(1,_w,_h));
}
function scrNTTEFullIOSSurfaceTarget(_surface) {
    if(!surface_exists(_surface)) return false;
    var _before=surface_get_target(),_ok=surface_set_target(_surface),_after=surface_get_target()
    if(_ok && real(_after)==real(_surface)) return true;
    // Never clear or pop the caller after a failed target bind. In the unusual
    // partial-bind case unwind the one attempted push before reporting failure.
    if(real(_after)!=real(_before)) surface_reset_target()
    return false;
}
function scrNTTEFullIOSRenderTrace(_kind,_data) {
    if(os_type!=os_ios && !(variable_global_exists("ntte_ios_trace_fixture") && global.ntte_ios_trace_fixture)) return;
    if(!variable_global_exists("ntte_ios_render_trace"))
        global.ntte_ios_render_trace={build:"r49",events:{},os:os_type,
            window:[window_get_width(),window_get_height()],view:[view_width,view_height]}
    // Record a bounded first observation for each event. No per-frame file I/O.
    if(variable_struct_exists(global.ntte_ios_render_trace.events,_kind)) return;
    variable_struct_set(global.ntte_ios_render_trace.events,_kind,_data)
    try {
        var _file=file_text_open_write(game_directory+"ntte-ios-render-r49.json")
        if(_file>=0) {file_text_write_string(_file,json_stringify(global.ntte_ios_render_trace));file_text_close(_file)}
    } catch(_trace_error) {show_debug_message("NTTE r49 render trace write failed")}
}
function scrNTTEFullIOSRenderTraceNeeded(_kind) {
    if(os_type!=os_ios) return false;
    return !variable_global_exists("ntte_ios_render_trace")
        || !variable_struct_exists(global.ntte_ios_render_trace.events,_kind);
}
// A once-only device pixel probe. This separates target bind/clear failures,
// texture alpha sampling and custom shader compilation in the actual runner.
function scrNTTEFullIOSSurfaceProbe(_force=false) {
    if(!_force && !scrNTTEFullIOSRenderTraceNeeded("pixel-probe")) return;
    var _state=scrNTTEFullCoastDrawState(),_a=-1,_b=-1,_camera=-1,
        _result={shader:shader_is_compiled(shNTTEFullCoastPresent),source_bind:false,output_bind:false}
    gpu_push_state();shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
    gpu_set_colorwriteenable(true,true,true,true);draw_set_color(c_white);draw_set_alpha(1)
    try {
        _a=surface_create(4,4);_b=surface_create(4,4)
        _camera=camera_create_view(0,0,4,4,0,noone,-1,-1,-1,-1)
        _result.source_bind=scrNTTEFullIOSSurfaceTarget(_a)
        if(_result.source_bind) {
            camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,0)
            draw_set_color(c_red);draw_rectangle(2,2,3,3,false);draw_set_color(c_white)
            surface_reset_target()
            _result.source_empty=surface_getpixel_ext(_a,0,0)
            _result.source_solid=surface_getpixel_ext(_a,2,2)
            _result.output_bind=scrNTTEFullIOSSurfaceTarget(_b)
            if(_result.output_bind) {
                camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(make_color_rgb(42,145,205),1)
                if(_result.shader) {
                    shader_set(shNTTEFullCoastPresent)
                    shader_set_uniform_f(shader_get_uniform(shNTTEFullCoastPresent,"waterTint"),0,0,0,0)
                }
                draw_surface(_a,0,0);shader_reset();surface_reset_target()
                _result.present_empty=surface_getpixel_ext(_b,0,0)
                _result.present_solid=surface_getpixel_ext(_b,2,2)
            }
        }
    } catch(_probe_error) {
        _result.error=string(_probe_error)
        if(_force) throw _probe_error;
    } finally {
        for(var _i=0;_i<3 && real(surface_get_target())!=real(_state.target);++_i) surface_reset_target()
        if(surface_exists(_a)) surface_free(_a)
        if(surface_exists(_b)) surface_free(_b)
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state()
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTEFullIOSRenderTrace("pixel-probe",_result)
    return _result;
}
