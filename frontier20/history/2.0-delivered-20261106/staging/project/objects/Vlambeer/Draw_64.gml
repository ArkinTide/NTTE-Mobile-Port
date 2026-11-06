if(lockstep_stop || mode!=-1) exit;
var _w=display_get_gui_width(),_h=display_get_gui_height(),
    _sw=sprite_get_width(sprNTTETeamStartup),_sh=sprite_get_height(sprNTTETeamStartup),
    _scale=min(_w/_sw,_h/_sh)*0.94;
gpu_push_state();
try {
    gpu_set_blendmode(bm_normal);gpu_set_texfilter(true);
    draw_sprite_ext(sprNTTETeamStartup,0,(_w-_sw*_scale)/2,(_h-_sh*_scale)/2,_scale,_scale,0,c_white,1);
} finally {gpu_pop_state();}
