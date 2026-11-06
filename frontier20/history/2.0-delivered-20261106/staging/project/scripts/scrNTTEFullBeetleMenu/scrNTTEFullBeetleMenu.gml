// beetle.race.gml::step/ntte_draw. This adapter runs in the real Player
// after native aiming and before firing. The caller gates native fire/charge
// with its return value, and native weapon/laser drawing with MenuVisible.
function scrNTTEFullBeetleMenuVisible() {
    return race==NTTEFullRace.Beetle && is_struct(scrNTTEFullValue(id,"beetle_menu_info",undefined)) && beetle_menu_info.scale!=0
}
function scrNTTEFullBeetleMenuPreview(_menu,_indices) {
    var _preview=scrNTTEFullBeetleSelection(_menu.selection_wep_info,_indices,curse,bcurse)
    _preview.index_list=_indices
    _preview.name=array_length(_indices)>0 ? scrNTTEFullMergedName(_preview.weapon):""
    _preview.type=scrNTTEFullWeaponMergeProperty(_preview.weapon,"type")
    _preview.cost=scrNTTEFullWeaponMergeProperty(_preview.weapon,"cost")
    _preview.load=scrNTTEFullWeaponMergeProperty(_preview.weapon,"load")
    _preview.sprite=array_length(_indices)>0 ? scrNTTEFullWeaponNativeSprite(_preview.weapon):mskNone
    _menu.merging_wep_info=_preview
}
function scrNTTEFullBeetleMenuSound(_sound,_pitch=1,_gain=1,_offset=0) {
    var _voice=snd_play(_sound,_pitch,_gain)
    if(_voice!=-1 && _offset>0) audio_sound_set_track_position(_voice,_offset)
}
function scrNTTEFullBeetleMenuToggleFX(_menu,_selected) {
    var _info=_menu.selection_wep_info,_idx=_info.index,_part=_info.list[_idx]
    var _ratio=array_length(_menu.merging_wep_info.index_list)/array_length(_info.list)
    var _fx=instance_create(x+lengthdir_x(10,gunangle),y+lengthdir_y(10,gunangle),BulletHit)
    _fx.image_xscale=lerp(1/3,2/3,_ratio); _fx.image_yscale=_fx.image_xscale; _fx.image_blend=c_black
    _fx.depth=depth+1; _fx.hspeed+=hspeed*2/3; _fx.vspeed+=vspeed*2/3; _fx.friction=0.1
    if(_selected) {
        var _raw=scrNTTEFullWeaponRaw(_part)
        scrNTTEFullBeetleMenuSound(scrNTTEFullWeaponSwapSound(_raw),1,2/3,0.03)
        if(scr_weapon_is_golden(_raw)) snd_play(sndSwapGold,1,2/3)
        if((_idx<_info.primary_count ? curse:bcurse)>0) snd_play(sndSwapCursed,1,2/3)
    }
    scrNTTEFullBeetleMenuSound(_selected ? sndPlantFire:sndNTTEOriginalPlantPower,lerp(1.25,2,_ratio),2,0.04)
}
function scrNTTEFullBeetleMenuStepInput(_press,_release,_fire,_effects=true,_commit=true) {
    if(race!=NTTEFullRace.Beetle) return false
    if(!is_struct(scrNTTEFullValue(id,"beetle_menu_info",undefined))) beetle_menu_info=scrNTTEFullBeetleMenuNew()
    var _menu=beetle_menu_info,_was=_menu.is_open
    if(_press && !_was && can_spec && scrNTTEFullPlayerActive(id)) {
        _menu.is_open=true; _menu.selection_angle=gunangle
    }
    if(!_menu.is_open && _menu.scale==0) return false
    if(wep!=_menu.wep || bwep!=_menu.bwep || curse!=_menu.curse || bcurse!=_menu.bcurse) {
        _menu.wep=wep; _menu.bwep=bwep; _menu.curse=curse; _menu.bcurse=bcurse
        _menu.selection_wep_info=scrNTTEFullBeetleMenuInventory(wep,bwep,curse,bcurse)
        scrNTTEFullBeetleMenuPreview(_menu,[]); _menu.selection_state=undefined
    }
    if(_menu.is_open) {
        var _inv=_menu.selection_wep_info,_n=array_length(_inv.list),_merge=_menu.merging_wep_info
        if(_n>0) {
            // Normalize negative GML remainders too; gunangle may wrap either way.
            _inv.index=((round(_n*(1+(gunangle-_menu.selection_angle)/360))%_n)+_n)%_n
            if(_fire && _menu.scale>0.75) {
                var _where=array_get_index(_merge.index_list,_inv.index),_selected=_where>=0
                if(is_undefined(_menu.selection_state)) _menu.selection_state=!_selected
                else if(_effects) {
                    var _trail=instance_create(x+lengthdir_x(10,gunangle),y+lengthdir_y(10,gunangle),BoltTrail)
                    _trail.image_angle=point_direction(_trail.x,_trail.y,_menu.selection_trail_last_x,_menu.selection_trail_last_y)
                    _trail.image_xscale=point_distance(_trail.x,_trail.y,_menu.selection_trail_last_x,_menu.selection_trail_last_y)
                    _trail.image_yscale=1.5+0.5*dsin(wave/8*360); _trail.image_blend=c_black; _trail.depth=depth+1
                }
                _menu.selection_trail_last_x=x+lengthdir_x(10,gunangle); _menu.selection_trail_last_y=y+lengthdir_y(10,gunangle)
                if(_menu.selection_state!=_selected) {
                    var _indices=scrNTTEFullArrayCopy(_merge.index_list)
                    if(_menu.selection_state) array_push(_indices,_inv.index)
                    else array_delete(_indices,_where,1)
                    scrNTTEFullBeetleMenuPreview(_menu,_indices); _merge=_menu.merging_wep_info
                    _menu.selection_icon_scale=0
                    if(_effects) scrNTTEFullBeetleMenuToggleFX(_menu,_menu.selection_state)
                }
            }
            else _menu.selection_state=undefined
        }
        if(array_length(_merge.index_list)>0) _menu.merging_scale=abs(1-_menu.merging_scale)>0.01 ? lerp(_menu.merging_scale,1,1-power(2/3,timescale)):1
        else _menu.merging_scale=_menu.merging_scale>0.01 ? _menu.merging_scale*power(2/3,timescale):0
        if((_press && _was) || (_release && (_menu.scale>0.75 || _n==0))) {
            _menu.is_open=false
            if(_commit) {
                var _result=scrNTTEFullBeetleCommit(_merge.index_list)
                _menu.merging_part_num=_result.ok && array_length(_merge.index_list)>1 ? array_length(_merge.index_list):0
                if(_result.ok) {
                    if(_effects) {
                        if(_result.cost!=0) {
                            var _popup=scrPopupCreate(x,y-58,"-"+string(_result.cost)+" MAX HP "); _popup.speed=0
                            var _blood=instance_create(x,y,BloodStreak); _blood.sprite_index=scrNTTERefSprite("SquidBloodStreak")
                            _blood.direction=random(360); _blood.speed=3*timescale
                        }
                        snd_play(sndPlantTBKill,lerp(0.75,0.25,_result.cost/(max_hp+headloses)),2.5)
                        scrPopupCreate(x,y,loc_fmt("HUD:GotWeapon","%!",scr_weapon_get_name(wep)))
                    }
                    _menu.wep=wep; _menu.bwep=bwep; _menu.curse=curse; _menu.bcurse=bcurse
                    scrNTTEFullBeetleMenuPreview(_menu,[])
                    if(_result.primary && _result.secondary && (curse>0 || bcurse>0)) { _menu.wep=wep_none; _menu.bwep=wep_none }
                }
            }
        }
        if(_effects && _menu.scale==0 && (wep!=wep_none || bwep!=wep_none)) {
            if(scrNTTEFullWeaponHasMerge(scrNTTEFullWeaponModel(wep))) { trigger_fingers_shine=1; snd_play(sndWeaponPickup,1+orandom(0.1),2/3) }
            snd_play(sndPlantSnareTB,2+orandom(0.1),4/3)
        }
        _menu.scale=abs(1-_menu.scale)>0.01 ? lerp(_menu.scale,1,1-power(0.85,timescale)):1
        if(_menu.scale>5/6 || array_length(_merge.key_list)>0)
            _menu.selection_icon_scale=abs(1-_menu.selection_icon_scale)>0.01 ? lerp(_menu.selection_icon_scale,1,1-power(0.8,timescale)):1
    }
    else if(_menu.scale>0.05) {
        _menu.scale*=power(0.8,timescale); _menu.selection_icon_scale*=power(0.2,timescale)
    }
    else {
        var _parts=_menu.merging_part_num
        beetle_menu_info=scrNTTEFullBeetleMenuNew()
        if(_effects && wep!=wep_none) {
            snd_play(scrNTTEFullWeaponSwapSound(wep),1+orandom(0.1))
            if(scr_weapon_is_golden(scrNTTEFullWeaponRaw(wep))) snd_play(sndSwapGold,1+orandom(0.1))
            if(curse>0) snd_play(sndSwapCursed,1+orandom(0.1))
            if(scrNTTEFullWeaponHasMerge(scrNTTEFullWeaponModel(wep))) trigger_fingers_shine=2
            var _swap=instance_create(x,y,WepSwap); _swap.creator=id
            var _start=random(360)
            for(var _i=0;_i<_parts;++_i) {
                var _fx=instance_create(x+lengthdir_x(8,gunangle+wepangle),y+lengthdir_y(8,gunangle+wepangle),Shell)
                _fx.sprite_index=scrNTTERefSprite("BackpackDebris"); _fx.image_index=irandom(sprite_get_number(_fx.sprite_index)-1)
                _fx.image_speed=0; _fx.image_xscale=choose(-1,1); _fx.image_blend=c_silver
                with(_fx) motion_add(_start+360*_i/_parts+orandom(70),3)
            }
        }
        return false
    }
    // Native draw guards replace original 10000px kick suppression, retaining
    // real kicks for the opening/closing interpolation and normal kick decay.
    _menu.last_wkick=wkick; _menu.last_bwkick=bwkick
    return _menu.is_open
}
function scrNTTEFullBeetleMenuStep() {
    var _press=KeyCont.press_spec[index],_release=KeyCont.release_spec[index]
    var _uses=scrNTTEFullValue(id,"usespec",0),_last=scrNTTEFullValue(id,"beetle_last_usespec",0)
    if((_uses>0)!=(_last>0)) {
        if(_uses>0) _press=true
        else _release=true
    }
    beetle_last_usespec=_uses
    return scrNTTEFullBeetleMenuStepInput(_press,_release,KeyCont.hold_fire[index])
}
// Follow the history trie using full cursed chains and individual uncursed
// parts. This is also used to find every original future-free recipe marker.
function scrNTTEFullBeetleMenuPartKeys(_menu,_i,_types) {
    var _part=_menu.selection_wep_info.list[_i],_keys=[]
    var _cursed=(_i<_menu.selection_wep_info.primary_count ? curse:bcurse)>0
    while(true) {
        var _raw=scrNTTEFullBeetleUnmerge(_part)
        array_push(_keys,string(_types ? scrNTTEFullWeaponMergeProperty(_raw,"type"):scrNTTEFullWeaponRaw(_raw)))
        if(!_cursed || !scrNTTEFullWeaponHasMerge(_part)) break
        _part=scrNTTEFullWeaponMergedPart(_part)
    }
    return _keys
}
function scrNTTEFullBeetleMenuHistoryBranch(_tree,_keys) {
    for(var _i=0;_i<array_length(_keys);++_i) {
        if(!is_struct(_tree) || !variable_struct_exists(_tree,_keys[_i])) return undefined
        _tree=variable_struct_get(_tree,_keys[_i])
    }
    return _tree
}
function scrNTTEFullBeetleMenuRecipeExists(_menu,_tree,_used,_types) {
    if(!is_struct(_tree)) return false
    if(scrNTTEFullValue(_tree,"?",false)) return true
    for(var _i=0;_i<array_length(_menu.selection_wep_info.list);++_i) {
        if(array_get_index(_used,_i)>=0) continue
        var _next=scrNTTEFullBeetleMenuHistoryBranch(_tree,scrNTTEFullBeetleMenuPartKeys(_menu,_i,_types))
        if(!is_struct(_next)) continue
        var _path=scrNTTEFullArrayCopy(_used); array_push(_path,_i)
        if(scrNTTEFullBeetleMenuRecipeExists(_menu,_next,_path,_types)) return true
    }
    return false
}
function scrNTTEFullBeetleMenuCenteredSprite(_spr,_img,_x,_y,_sx,_sy,_colour,_alpha) {
    var _ox=sprite_get_xoffset(_spr)-floor((sprite_get_bbox_left(_spr)+sprite_get_bbox_right(_spr)+1)/2)
    var _oy=sprite_get_yoffset(_spr)-floor((sprite_get_bbox_top(_spr)+sprite_get_bbox_bottom(_spr)+1)/2)
    draw_sprite_ext(_spr,_img,_x+_ox*_sx,_y+_oy*_sy,_sx,_sy,0,_colour,_alpha)
}
function scrNTTEFullBeetleMenuWeapon(_spr,_img,_x,_y,_angle,_melee,_kick,_flip,_colour,_alpha) {
    _angle+=_melee*(1-_kick/20)
    draw_sprite_ext(_spr,_img,_x-lengthdir_x(_kick,_angle),_y-lengthdir_y(_kick,_angle),1,_flip,_angle,_colour,max(0,_alpha))
}
function scrNTTEFullBeetleMenuDraw() {
    if(!scrNTTEFullBeetleMenuVisible() || !visible) return;
    var _menu=beetle_menu_info,_scale=_menu.scale,_inv=_menu.selection_wep_info,_merge=_menu.merging_wep_info
    var _n=array_length(_inv.list),_count=array_length(_merge.index_list),_mx=round(x),_my=round(y)
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_col=draw_get_color(),_alpha=draw_get_alpha()
    var _hx=x+lengthdir_x(lerp(5,10,_scale),gunangle),_hy=y+lengthdir_y(lerp(2,10,sqr(_scale)),gunangle)+3*(1-_scale)
    var _hx2=_hx+lengthdir_x(4*_scale,gunangle),_hy2=_hy+lengthdir_y(4*_scale,gunangle)+dsin(wave/60*360),_hr=lerp(1,2,_scale)
    draw_set_color(c_black); draw_circle(_hx-1,_hy-1,_hr,false)
    if(is_undefined(_menu.selection_state)) draw_triangle(_hx-1+lengthdir_x(_hr,gunangle-90),_hy-1+lengthdir_y(_hr,gunangle-90),
        _hx-1-lengthdir_x(_hr,gunangle-90),_hy-1-lengthdir_y(_hr,gunangle-90),_hx2-1,_hy2-1,false)
    var _types=scr_skill_get(mut_throne_butt)>0,_history=scrNTTEFullBeetleHistory(),_tree=_types ? _history.types:_history.keys
    _tree=scrNTTEFullBeetleMenuHistoryBranch(_tree,_types ? _merge.type_key_list:_merge.key_list)
    for(var _i=0;_i<_n;++_i) {
        var _primary=_i<_inv.primary_count,_part=_inv.list[_i],_cursed=(_primary ? curse:bcurse)>0
        var _drawpart=_cursed ? _part:scrNTTEFullBeetleUnmerge(_part),_spr=scrNTTEFullWeaponNativeSprite(_drawpart)
        var _ang=_menu.selection_angle+360*_i/_n
        var _selected=array_get_index(_merge.index_list,_i)>=0
        if(_n>1) {
            var _r1=lerp(56,20,power(_scale,1.5))+2*dcos(wave/60*360),_r2=_r1+16*sqr(_scale)
            var _da=_ang+360*(0.5/_n)*_scale,_w=2*lerp(3,_scale,abs(power(_scale,1.5)-0.5)/0.5)
            var _x1=_mx+lengthdir_x(_r1,_da),_y1=_my+lengthdir_y(_r1,_da),_x2=_mx+lengthdir_x(_r2,_da),_y2=_my+lengthdir_y(_r2,_da)
            draw_set_color(c_black); draw_line_width(_x1,_y1-1,_x2,_y2-1,_w); draw_line_width(_x1-1,_y1,_x2-1,_y2,_w); draw_line_width(_x1,_y1,_x2,_y2,_w)
            draw_set_color(c_white); draw_line_width(_x1-1,_y1-1,_x2-1,_y2-1,_w)
        }
        var _melee=scr_weapon_is_melee(_primary ? wep:bwep),_flip=_melee ? (_primary ? wepright:bwepright):right
        var _colour=_selected ? c_black:c_white,_wa=_flip<0 ? 180:0,_wm=0,_wk=0,_alp=1
        var _ox=sprite_get_xoffset(_spr)-floor((sprite_get_bbox_left(_spr)+sprite_get_bbox_right(_spr)+1)/2)
        var _oy=sprite_get_yoffset(_spr)-floor((sprite_get_bbox_top(_spr)+sprite_get_bbox_bottom(_spr)+1)/2),_len=28,_dir=_ang
        if(_flip<0) _ox+=sprite_get_width(_spr)-2*sprite_get_xoffset(_spr)
        if(_scale<1) {
            // NTT swapmove is -Epsilon.swapanim. Preserve the authored start
            // pose and angle interpolation rather than shrinking a radial ring.
            _wk=lerp(_primary ? _menu.last_wkick:0,_wk,_scale)
            _wa=angle_lerp(_primary ? gunangle:90+15*right,_wa,_scale)
            _wm=angle_lerp(_primary ? wepangle:0,_wm,_scale)
            _colour=merge_color(_primary ? image_blend:c_black,_colour,_scale)
            _alp=lerp(_primary ? image_alpha:-0.5,_alp,_scale)
            _ox=lerp(_primary ? 0:-2*right,_ox,_scale)
            _oy=lerp(_primary ? -swapanim:swapanim,_oy,_scale)
            _dir=angle_lerp(_primary ? (_flip<0 ? 180:0):90+90*right,_dir,_scale)
            _len=lerp(0,_len,_scale)
        }
        var _px=_mx+lengthdir_x(_len,_dir)+_ox,_py=_my+lengthdir_y(_len,_dir)+_oy
        if(_i==_inv.index) {
            gpu_set_fog(true,_cursed ? make_color_rgb(136,36,174):c_white,0,0)
            for(var _d=0;_d<360;_d+=90) scrNTTEFullBeetleMenuWeapon(_spr,trigger_fingers_shine,_px+dcos(_d),_py-dsin(_d),_wa,_wm,_wk,_flip,_colour,_alp*max(0,lerp(-1,1,_scale)))
            gpu_set_fog(false,c_white,0,0)
        }
        scrNTTEFullBeetleMenuWeapon(_spr,trigger_fingers_shine,_px,_py,_wa,_wm,_wk,_flip,_colour,_alp)
        if(!_selected && is_struct(_tree)) {
            var _branch=scrNTTEFullBeetleMenuHistoryBranch(_tree,scrNTTEFullBeetleMenuPartKeys(_menu,_i,_types))
            if(is_struct(_branch)) {
                var _ca=_ang-360*0.5/_n*(1-_scale),_cr=(3+0.25*dcos(wave/60*360))*_scale
                var _cx=_mx+lengthdir_x(28-2*_cr,_ca),_cy=_my+lengthdir_y(28-2*_cr,_ca)
                var _used=scrNTTEFullArrayCopy(_merge.index_list); array_push(_used,_i)
                for(var _j=0;_j<_n;++_j) {
                    if(array_get_index(_used,_j)>=0) continue
                    var _sub=scrNTTEFullBeetleMenuHistoryBranch(_branch,scrNTTEFullBeetleMenuPartKeys(_menu,_j,_types))
                    var _path=scrNTTEFullArrayCopy(_used); array_push(_path,_j)
                    if(scrNTTEFullBeetleMenuRecipeExists(_menu,_sub,_path,_types)) {
                        var _a=_ca+360*(_j-_i)/_n,_xx=_cx+lengthdir_x(_cr*2,_a),_yy=_cy+lengthdir_y(_cr*2,_a)
                        var _radius=_cr*lerp(1.5,_menu.selection_icon_scale,abs(_menu.selection_icon_scale-0.5)/0.5)*(_i==_inv.index ? 1:0.8)
                        draw_set_color(c_black); draw_circle(_xx,_yy-1,_radius,false); draw_circle(_xx-1,_yy,_radius,false); draw_circle(_xx,_yy,_radius,false)
                        draw_set_color(c_white); draw_circle(_xx-1,_yy-1,_radius,false)
                    }
                }
                if(_count>0 && scrNTTEFullValue(_branch,"?",false)) {
                    draw_set_color(c_black); draw_circle(_cx,_cy,_cr*2/3+1,false)
                    draw_set_color(bskin==0 ? make_color_rgb(24,165,132):make_color_rgb(252,56,0)); draw_circle(_cx-1,_cy-1,_cr*2/3,false)
                }
            }
        }
    }
    var _x1=_mx-lerp(24,32,_scale)*_menu.merging_scale,_x2=_mx+(_mx-_x1)
    var _y1=_my-(52+4+8*(_count>0 ? -1:1)*(1-sqrt(_menu.merging_scale))),_y2=_y1+16*_scale
    draw_set_color(c_black); draw_set_alpha(2/3); draw_roundrect(_x1-1,_y1-1,_x2-1,_y2-1,false); draw_set_alpha(1)
    if(_count>0) {
        var _history=scrNTTEFullBeetleHistory(),_quote=scrNTTEFullBeetleQuote(_merge,max_hp,_types,_history.keys,_history.types)
        var _sx=power(_menu.merging_scale,1/3)*lerp(2,1,_scale),_sy=_scale*lerp(2,1,power(_menu.merging_scale,1/5)),_wy=round((_y1+_y2)/2)
        scrNTTEFullBeetleMenuCenteredSprite(_merge.sprite,0,_mx,_wy,_sx,_sy,merge_color(c_black,c_white,clamp(_sy,0,1)),1)
        draw_set_font(fntSmall); draw_set_halign(fa_center); draw_set_valign(fa_bottom); draw_set_color(c_white)
        if(_quote.cost!=0) scrNTTEFullDrawText(_mx,_y1-2,"-"+string(_quote.cost)+(_quote.can_merge ? " @rMAX HP@w!":" @dMAX HP."))
        var _name_font=draw_get_font()
        if(scrNTTEFullIsSimplifiedChinese()) draw_set_font(global.language_font_default)
        scrNTTEFullDrawText(_mx,_y1-(2+10*(_quote.cost!=0)),scrNTTEFullWeaponNameDisplay(_merge.name))
        draw_set_font(_name_font)
        draw_set_valign(fa_middle)
        if(_merge.cost!=0) {
            draw_set_halign(fa_right); scrNTTEFullDrawText(_x1-2,_wy,string(_merge.cost))
            draw_sprite(scrNTTERefSprite("WhiteAmmoTypeIcon"),_merge.type,_x1-4-string_width(string(_merge.cost)),_wy)
        }
        if(_merge.load>0) {
            draw_set_halign(fa_left); var _sec=round(_merge.load/30*100)/100
            var _text=string_format(_sec,0,_sec>0 && _sec<0.1 ? 2:(frac(round(_sec*10)/10)==0 ? 0:1))
            if(string_char_at(_text,1)=="0") _text=string_delete(_text,1,1)
            scrNTTEFullDrawText(_x2+2,_wy,_text); draw_sprite(scrNTTERefSprite("WhiteReloadIcon"),0,_x2+4+string_width(_text),_wy)
        }
    }
    draw_set_font(_font); draw_set_halign(_ha); draw_set_valign(_va); draw_set_color(_col); draw_set_alpha(_alpha)
}
function scrNTTEFullBeetleMenuTests() {
    var _p=instance_find(Player,0),_old={race:_p.race,wep:_p.wep,bwep:_p.bwep,curse:_p.curse,bcurse:_p.bcurse,angle:_p.gunangle,
        menu:scrNTTEFullValue(_p,"beetle_menu_info",undefined),canspec:_p.can_spec},_blocked
    with(_p) {
        race=NTTEFullRace.Beetle; wep=wep_revolver; bwep=wep_shotgun; curse=0; bcurse=0; can_spec=true; gunangle=25
        beetle_menu_info=scrNTTEFullBeetleMenuNew()
        _blocked=scrNTTEFullBeetleMenuStepInput(true,false,false,false,false)
    }
    assert(_blocked && _p.beetle_menu_info.is_open && _p.beetle_menu_info.selection_angle==25,"Beetle menu did not open from native active input/aim")
    with(_p) {
        beetle_menu_info.scale=1
        scrNTTEFullBeetleMenuStepInput(false,false,true,false,false)
        gunangle+=180; scrNTTEFullBeetleMenuStepInput(false,false,true,false,false)
    }
    var _merge=_p.beetle_menu_info.merging_wep_info
    assert(array_length(_merge.index_list)==2 && _merge.index_list[0]==0 && _merge.index_list[1]==1,
        "Beetle held-fire drag did not select each radial part once in input order")
    assert(_p.wep==wep_revolver && _p.bwep==wep_shotgun,"Beetle preview mutated actual native inventory")
    with(_p) {
        scrNTTEFullBeetleMenuStepInput(false,false,false,false,false)
        scrNTTEFullBeetleMenuStepInput(false,false,true,false,false)
    }
    assert(array_length(_p.beetle_menu_info.merging_wep_info.index_list)==1,"Beetle new fire gesture failed to deselect rather than duplicate a selected part")
    with(_p) _blocked=scrNTTEFullBeetleMenuStepInput(false,true,false,false,false)
    assert(!_blocked && !_p.beetle_menu_info.is_open && _p.beetle_menu_info.scale>0,"Beetle release did not confirm/close while retaining closing draw animation")
    with(_p) {
        repeat(ceil(40/timescale)) scrNTTEFullBeetleMenuStepInput(false,false,false,false,false)
    }
    assert(_p.beetle_menu_info.scale==0 && array_length(_p.beetle_menu_info.merging_wep_info.index_list)==0,"Beetle closed radial menu retained stale selection")
    with(_p) { race=_old.race; wep=_old.wep; bwep=_old.bwep; curse=_old.curse; bcurse=_old.bcurse; gunangle=_old.angle; can_spec=_old.canspec; beetle_menu_info=_old.menu }
    scrNTTESmokeLog("SYSTEMS BEETLE MENU: native aim/active opening, held-fire select/deselect drag, immutable preview, release confirmation, firing gate and time-scaled close/reset OK")
    scrNTTEFullBeetleMenuDrawNativeTests();
}

function scrNTTEFullBeetleMenuDrawNativeTests() {
    scrNTTEFullWeaponNativeInit();
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _fixture=scrNTTEFullVanillaFixtureBegin(),_stop=lockstep_stop,
        _parked=scrNTTEFullInstances([NTTEFullPrompt,Cinematic,SitDown,MenuGen]),
        _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _draw=scrNTTEFullCoastDrawState(),_shader=shader_current(),_surface=-1,_camera=-1,_target=false,
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _language=global.language_current,_small=global.language_font_default,
        _big=global.language_font_bigname_default,_oracle=-1;
    gpu_push_state();
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    lockstep_stop=false;
    try {
        var _p=instance_find(Player,0);
        _p.x=197000;_p.y=197000;_p.race=NTTEFullRace.Beetle;_p.can_spec=true;_p.visible=true;
        _p.hp=8;_p.max_hp=8;_p.curse=0;_p.bcurse=0;_p.gunangle=25;_p.trigger_fingers_shine=0;
        _p.fainted=0;_p.roll=0;_p.can_walk=false;_p.can_aim=false;_p.can_pick=false;_p.can_shoot=false;
        _p.speed=0;_p.hspeed=0;_p.vspeed=0;
        KeyCont.press_swap[_p.index]=false;KeyCont.press_pick[_p.index]=false;KeyCont.moving[_p.index]=0;
        KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false;
        KeyCont.press_spec[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.release_spec[_p.index]=false;
        _surface=surface_create(384,256);assert(surface_exists(_surface),"Beetle menu render surface unavailable");
        _oracle=surface_create(384,256);assert(surface_exists(_oracle),"Beetle name oracle surface unavailable");
        _camera=camera_create_view(_p.x-192,_p.y-128,384,256,0,noone,-1,-1,-1,-1);
        for(var _lang=0;_lang<2;++_lang) {
        scrLanguageSet(_lang==0?"English":"Simplified Chinese");
        for(var _merged=0;_merged<2;++_merged) {
            _p.wep=_merged ? scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun)):wep_revolver;
            _p.bwep=wep_wrench;_p.trigger_fingers_shine=0;
            // Create initializes facing to false. In normal play Player.Step
            // establishes +/-1, then Player.Draw derives both weapon flips
            // before TopCont dispatches the menu. Execute that real lifecycle
            // instead of making the menu draw a zero-height fixture weapon.
            with(_p) {
                beetle_menu_info=scrNTTEFullBeetleMenuNew();
                event_perform(ev_step,ev_step_normal);
            }
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_fog(false,0,0,0);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1);
            with(_p) event_perform(ev_draw,0);
            surface_reset_target();_target=false;
            assert(abs(_p.right)==1 && abs(_p.wepright)==1 && abs(_p.bwepright)==1,
                "Native Player Step/Draw did not establish valid Beetle weapon facing");
            _p.trigger_fingers_shine=0;_p.can_spec=true;
            with(_p) {
                beetle_menu_info=scrNTTEFullBeetleMenuNew();
                scrNTTEFullBeetleMenuStepInput(true,false,false,true,false);
            }
            assert(_p.beetle_menu_info.is_open && _p.trigger_fingers_shine==_merged,
                "Beetle first opening lost the native weapon-shine lifecycle");
            for(var _phase=0;_phase<3;++_phase) {
                if(_phase==1) {
                    _p.beetle_menu_info.scale=1;
                    with(_p) scrNTTEFullBeetleMenuStepInput(false,false,true,false,false);
                    _p.beetle_menu_info.merging_scale=1;
                }
                if(_phase==2) with(_p) scrNTTEFullBeetleMenuStepInput(false,true,false,false,false);
                surface_set_target(_surface);_target=true;camera_apply(_camera);
                matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                gpu_set_texfilter(false);draw_clear_alpha(c_black,1);draw_set_alpha(1);draw_set_color(c_white);
                var _diagnostic={merged:_merged,phase:_phase,rate:30/timescale,
                    x:_p.x,y:_p.y,race:_p.race,visible:_p.visible,scale:_p.beetle_menu_info.scale,
                    count:array_length(_p.beetle_menu_info.selection_wep_info.list),
                    selected:_p.beetle_menu_info.selection_wep_info.index,
                    alpha:_p.image_alpha,blend:_p.image_blend,shine:_p.trigger_fingers_shine,
                    wkick:_p.wkick,bwkick:_p.bwkick,swap:_p.swapanim,right:_p.right,
                    wepright:_p.wepright,bwepright:_p.bwepright,wepangle:_p.wepangle,wave:_p.wave,
                    before_target:surface_get_target(),before_fog:gpu_get_fog(),
                    before_world:matrix_get(matrix_world),before_view:matrix_get(matrix_view),
                    before_projection:matrix_get(matrix_projection),shader:shader_current(),
                    ztest:gpu_get_ztestenable(),zwrite:gpu_get_zwriteenable(),
                    alphatest:gpu_get_alphatestenable(),colorwrite:gpu_get_colorwriteenable(),
                    cullmode:gpu_get_cullmode(),texfilter:gpu_get_texfilter(),blendmode:gpu_get_blendmode()};
                with(_p) _diagnostic.menu_visible=scrNTTEFullBeetleMenuVisible();
                var _entry_font=draw_get_font(),_entry_width=string_width("13");
                with(_p) scrNTTEFullBeetleMenuDraw();
                assert(draw_get_font()==_entry_font && string_width("13")==_entry_width,
                    "Beetle name font leaked into surrounding numeric/icon layout");
                _diagnostic.after_target=surface_get_target();_diagnostic.after_fog=gpu_get_fog();
                _diagnostic.after_world=matrix_get(matrix_world);_diagnostic.after_view=matrix_get(matrix_view);
                _diagnostic.after_projection=matrix_get(matrix_projection);
                surface_reset_target();_target=false;
                if(_phase==1) {
                    var _display=scrNTTEFullDisplay(_p.beetle_menu_info.merging_wep_info.name),
                        _expected_font=_lang==0?fntSmall:global.language_font_default,
                        _glyphs=font_get_info(_expected_font).glyphs,_cjk=0,
                        _label_font=draw_get_font(),_label_ha=draw_get_halign(),_label_va=draw_get_valign();
                    assert(array_length(_p.beetle_menu_info.merging_wep_info.index_list)==1
                        && string_pos("@",_display)==0,"Beetle name render oracle requires actual unstyled single-component selection");
                    for(var _ch=1;_ch<=string_length(_display);++_ch) {
                        var _char=string_char_at(_display,_ch);
                        if(ord(_char)>127) {
                            ++_cjk;
                            assert(is_struct(_glyphs[$ _char]),"Beetle localized name missing compiled glyph: "+_char);
                        }
                    }
                    if(_lang==1) assert(_expected_font==fntCJK && _cjk>0,"Beetle Chinese render oracle did not exercise real CJK text/font");
                    surface_set_target(_oracle);_target=true;camera_apply(_camera);
                    matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
                    gpu_set_fog(false,0,0,0);gpu_set_texfilter(false);
                    draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1);
                    draw_set_font(_expected_font);draw_set_halign(fa_center);draw_set_valign(fa_bottom);
                    draw_text_nt(_p.x,_p.y-58,_display);
                    surface_reset_target();_target=false;
                    var _different=0,_ink=0;
                    for(var _oy=0;_oy<72;++_oy) for(var _ox=0;_ox<384;++_ox) {
                        var _expected=surface_getpixel(_oracle,_ox,_oy);
                        if(_expected!=c_black) _ink++;
                        if(surface_getpixel(_surface,_ox,_oy)!=_expected) _different++;
                    }
                    assert(_ink>0 && _different==0,
                        "Beetle actual menu name differs from native CJK/original English font oracle: "+json_stringify({language:_lang,merged:_merged,ink:_ink,different:_different,text:_display}));
                    surface_save(_oracle,working_directory+"ntte-beetle-name-oracle-"+string(_lang)+"-"+string(_merged)+"-"+string(30/timescale)+".png");
                    draw_set_font(_label_font);draw_set_halign(_label_ha);draw_set_valign(_label_va);
                    scrNTTESmokeLog("BEETLE NAME NATIVE ORACLE "+json_stringify({language:_lang,merged:_merged,font:_expected_font,cjk:_cjk,ink:_ink,different:_different,text:_display}));
                }
                var _pixels=0;
                for(var _y=40;_y<200;++_y) for(var _x=112;_x<272;++_x)
                    if(surface_getpixel(_surface,_x,_y)!=c_black) _pixels++;
                var _path=working_directory+"ntte-beetle-menu-"+string(_merged)+"-"+string(_phase)+"-"+string(30/timescale)+"-lang"+string(_lang)+".png";
                surface_save(_surface,_path);
                _diagnostic.pixels=_pixels;_diagnostic.image=_path;
                scrNTTESmokeLog("BEETLE MENU RENDER DIAGNOSTIC "+json_stringify(_diagnostic));
                assert(_pixels>10,"Beetle native opening/open/closing draw produced an empty menu");
                scrNTTESmokeLog("BEETLE MENU rendered merged="+string(_merged)+" phase="+string(_phase)+" pixels="+string(_pixels)+" image="+_path);
            }
            _p.beetle_menu_info.scale=0.01;
            with(_p) scrNTTEFullBeetleMenuStepInput(false,false,false,true,false);
            assert(_p.beetle_menu_info.scale==0 && _p.trigger_fingers_shine==2*_merged,
                "Beetle closing animation did not return its flash to the native weapon renderer");
        }
        }
    }
    finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(surface_exists(_oracle)) surface_free(_oracle);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        global.language_current=_language;global.language_font_default=_small;global.language_font_bigname_default=_big;
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_back);
        scrNTTEFullVanillaFixtureEnd(_fixture);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        lockstep_stop=_stop;
        global.ntte_full_native_weapon_models=_models;random_set_seed(_seed);
    }
    scrNTTESmokeLog("BEETLE MENU actual first-open/open/close drawing, stock/merged inventory and native weapon flash OK @"+string(30/timescale));
}
