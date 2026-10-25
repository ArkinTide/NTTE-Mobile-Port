// Compare the offline importer against NTT's recovered surface operations in
// the actual GameMaker renderer, including clipping, alpha and integer edges.
function scrNTTEFullWeaponShineTests() {
    var _keys=["Bone","TeleportGun","Trident","Tunneller","Harpoon","BatWeap"];
    var _old_color=draw_get_color(), _old_alpha=draw_get_alpha();
    draw_set_color(c_white); draw_set_alpha(1);
    for(var _k=0;_k<array_length(_keys);++_k) {
        var _s=scrNTTERefSprite(_keys[_k]), _w=sprite_get_width(_s), _h=sprite_get_height(_s);
        assert(sprite_get_number(_s)==7,"Generated weapon shine lost frames: "+_keys[_k]);
        var _ox=sprite_get_xoffset(_s), _oy=sprite_get_yoffset(_s);
        var _white=surface_create(1,1), _actual=surface_create(_w,_h), _expected=surface_create(_w,_h);
        surface_set_target(_white); draw_clear_alpha(c_white,1); surface_reset_target();
        var _shift=-_h;
        for(var _frame=1;_frame<7;++_frame) {
            surface_set_target(_actual);
            draw_clear_alpha(c_black,0);
            gpu_set_blendmode_ext(bm_one,bm_zero);
            draw_sprite(_s,0,_ox,_oy);
            gpu_set_colorwriteenable(true,true,true,false);
            if(_frame==1) draw_surface_ext(_white,0,0,_w,_h,0,c_white,1);
            else {
                var _prev=_shift;
                switch(_frame) {
                    case 2: _shift=1; break;
                    case 3: _shift=ceil(_w/3); break;
                    case 4: _shift=ceil(_w*0.8); break;
                    case 5: _shift=_w-1; break;
                    case 6: _shift=_w+_h; break;
                }
                for(var _y=0;_y<_h;++_y)
                    draw_surface_ext(_white,_prev+_y-(_h div 2),_y,_shift-_prev,1,0,c_white,1);
            }
            gpu_set_colorwriteenable(true,true,true,true);
            surface_reset_target();
            surface_set_target(_expected);
            draw_clear_alpha(c_black,0);
            draw_sprite(_s,_frame,_ox,_oy);
            surface_reset_target();
            gpu_set_blendmode(bm_normal);
            for(var _y=0;_y<_h;++_y) for(var _x=0;_x<_w;++_x) {
                var _a=surface_getpixel_ext(_actual,_x,_y),_b=surface_getpixel_ext(_expected,_x,_y);
                assert((_a & $ff000000)==(_b & $ff000000),"Weapon shine alpha differs from NTT");
                if((_a & $ff000000)!=0) assert(_a==_b,"Weapon shine pixel differs: "+_keys[_k]+" frame="+string(_frame)+" x="+string(_x)+" y="+string(_y));
            }
        }
        surface_free(_white); surface_free(_actual); surface_free(_expected);
    }
    draw_set_color(_old_color); draw_set_alpha(_old_alpha);
    scrNTTESmokeLog("PASS weapon shine NTT surface rasterization and offline frames");
}
