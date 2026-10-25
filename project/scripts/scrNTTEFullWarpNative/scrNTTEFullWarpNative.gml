// tecaves4740..4970. Actual Warp/prompt/seeded exit, not an ordinary Portal.
function scrNTTEFullWarpCreate() {
    name="Warp";spr_idle=scrNTTERefSprite("Warp");spr_open=scrNTTERefSprite("WarpOpen")
    spr_open_out=scrNTTERefSprite("WarpOpenOut");sprite_index=spr_idle
    image_speed=0.4*timescale;image_angle=scrNTTEFullSourceRandom(360);image_alpha=-1;depth=-9;mask_index=-1
    open=false;setup=true;area=206;subarea=1;loops=GameCont.loops;ntte_warp_alarm=30
    var _older=0
    with(NTTEFullWarp) if(id<other.id) {_older+=1}
    seed=scrNTTEFullSourceWarpSeed(_older)
    prompt=scrNTTEFullPromptCreate(id,"",mskReviveArea,0,8)
    scrNTTEFullWarpChooseArea()
}
function scrNTTEFullWarpChooseArea() {
    var _pick=[],_secret=scrNTTEFullSourceRandom(8)<1,
        _areas=[area_desert,area_sewers,area_scrapyards,area_caves,area_city,area_labs,
            area_palace,scrNTTEFullSourceChoose([area_mansion,area_crib]),area_cursed_caves,area_jungle,201,202,203,204,205,206]
    for(var _i=0;_i<array_length(_areas);++_i) {
        var _area=_areas[_i]
        if(_area==206) continue
        if(_area==area_caves) with(Player) if(curse>0 || bcurse>0) {_area=area_cursed_caves;break}
        array_push(_pick,_area)
    }
    if(!array_length(_pick)) return;
    area=_pick[scrNTTEFullSourceIRandom(array_length(_pick)-1)]
    // Source telib1945 forward Fisher-Yates includes the final RNG draw.
    for(var _i=0;_i<array_length(_pick);++_i) {
        var _j=scrNTTEFullSourceIRandomRange(_i,array_length(_pick)-1),_swap=_pick[_i]
        _pick[_i]=_pick[_j];_pick[_j]=_swap
    }
    for(var _i=0;_i<array_length(_pick);++_i) {
        var _area=_pick[_i],_used=false
        if((!scrNTTEFullWorldAreaSecret(_area)) ^^ _secret) {
            with(NTTEFullWarp) if(id!=other.id && area==_area) {_used=true;break}
            if(!_used) {area=_area;break}
        }
    }
    subarea=scrNTTEFullSourceIRandomRange(1,scrAreaGetMaxSubarea(area))
}
function scrNTTEFullWarpAreaName(_area,_subarea,_loops) {
    var _text=scrNTTEFullAreaMapLabel(_area,_subarea)
    if(is_undefined(_text)) _text=scrAreaGetMapName(_area,_subarea,0,undefined,false)
    if(_loops>0) _text+=" "+(scrGameIsHardmode()?"H":"L")+string(_loops)
    return _text
}
function scrNTTEFullWarpAlarm() {
    ntte_warp_alarm=30
    // Literal original gate: enemy count minus actual Vans, then player LOS.
    if(instance_number(enemy)-instance_number(Van)>0) return;
    var _seen=false
    with(Player) if(!collision_line(x,y,other.x,other.y,Wall,false,false)) {_seen=true;break}
    if(!_seen) return;
    open=true;ntte_warp_alarm=-1
    var _sound=scrNTTEFullMergedBasicSoundAt(x,y,sndHyperCrystalSearch,0.4+scrNTTEFullSourceRandom(0.2),4,64)
    with(MusCont) {
        snd_stop(amb);amb=sndHyperCrystalAppear
        var _ambient=snd_play_ambience(amb)
        if(_ambient>=0) audio_sound_pitch(_ambient,0.6)
    }
}
function scrNTTEFullWarpBreakWalls() {
    var _old_area=GameCont.area
    GameCont.area=area;y+=4
    if(place_meeting(x,y,Wall)) {
        var _walls=scrNTTEFullInstances(Wall)
        for(var _i=0;_i<array_length(_walls);++_i) if(place_meeting(x,y,_walls[_i])) with(_walls[_i]) {
            instance_create(x,y,FloorExplo);instance_destroy()
        }
    }
    else {
        var _wall=scrNTTEFullNearestBBox(x-32+scrNTTEFullSourceRandom(64),y-32+scrNTTEFullSourceRandom(64),Wall)
        if(instance_exists(_wall)) with(_wall) {instance_create(x,y,FloorExplo);instance_destroy()}
    }
    snd_stop(sndWallBreak);y-=4;GameCont.area=_old_area
}
function scrNTTEFullWarpStep() {
    if(lockstep_stop) return;
    if(ntte_warp_alarm>0) {
        ntte_warp_alarm-=timescale
        if(ntte_warp_alarm<=0) {ntte_warp_alarm=-1;scrNTTEFullWarpAlarm()}
    }
    image_angle+=timescale
    var _sparkle=1,_open_scale=3,_scale=(open || sprite_index==(open?spr_open:spr_idle))?1:1/_open_scale
    image_xscale+=(_scale-image_xscale)*0.2*timescale
    image_yscale+=(_scale-image_yscale)*0.2*timescale
    if(max(abs(_scale-image_xscale),abs(_scale-image_yscale))<0.1) {
        if(sprite_index==(open?spr_idle:spr_open)) {
            sprite_index=open?spr_open:spr_idle
            image_xscale*=open?1/_open_scale:_open_scale
            image_yscale*=open?1/_open_scale:_open_scale
        }
    }
    else {
        if(open && (current_frame mod 2)<timescale) scrNTTEFullWarpBreakWalls()
        _sparkle*=2
    }
    if(scrNTTEFullSourceRandom(15/_sparkle)<timescale) {
        var _fx=instance_create(bbox_left+scrNTTEFullSourceRandom(bbox_right+1-bbox_left),bbox_top+scrNTTEFullSourceRandom(bbox_bottom+1-bbox_top),LaserCharge)
        with(_fx) {
            sprite_index=sprSpiralStar;image_index=scrNTTEFullSourceChoose([0,scrNTTEFullSourceIRandom(image_number-1)])
            alarm[0]=15+scrNTTEFullSourceRandom(15);motion_set(90,(0.2+scrNTTEFullSourceRandom(0.3))*timescale)
        }
    }
    if(scrNTTEFullSourceRandom(20/_sparkle)<timescale) with(instance_create(bbox_left+scrNTTEFullSourceRandom(bbox_right+1-bbox_left),bbox_top+scrNTTEFullSourceRandom(bbox_bottom+1-bbox_top),BulletHit)) {
        sprite_index=sprThrowHit;image_xscale=0.2+scrNTTEFullSourceRandom(0.3);image_yscale=image_xscale
    }
    scrNTTEFullPortalPoof()
    if(instance_exists(prompt)) {
        prompt.visible=open
        if(prompt.text=="") prompt.text="WARP#"+scrNTTEFullWarpAreaName(area,subarea,loops)
        var _picked=false,_index=prompt.pick
        with(Player) if(index==_index) {_picked=true;break}
        if(_picked) instance_destroy()
    }
}
function scrNTTEFullWarpDraw() {
    image_alpha=abs(image_alpha)
    var _color=scrAreaGetBackroundColor(area)
    _color=make_color_hsv(color_get_hue(_color),color_get_saturation(_color),lerp(color_get_value(_color),255,1/3))
    if(sprite_index==spr_open) draw_sprite_ext(spr_open_out,current_frame*image_speed/timescale,x,y,image_xscale,image_yscale,image_angle,_color,image_alpha)
    draw_self()
    var _blend=gpu_get_blendmode()
    gpu_set_blendmode(bm_add)
    if(sprite_index==spr_open) draw_sprite_ext(spr_open_out,current_frame*image_speed/timescale,x,y,image_xscale*1.4,image_yscale*1.4,image_angle,_color,image_alpha*0.075)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,_color,image_alpha*0.075)
    gpu_set_blendmode(_blend);image_alpha=-image_alpha
}
function scrNTTEFullWarpDestroy() {
    if(open) {
        with(NTTEFullWarp) if(id!=other.id) {open=false;ntte_warp_alarm=-1}
        scrNTTEFullSourceWarpSetSeed(seed)
        var _portal=instance_create(x,y,NTTEFullWarpPortal)
        _portal.area=area;_portal.subarea=subarea;_portal.loops=loops
    }
    else with(instance_create(x,y,BulletHit)) {
        sprite_index=sprThrowHit;image_xscale=other.image_xscale;image_yscale=other.image_yscale;image_angle=other.image_angle
    }
}
