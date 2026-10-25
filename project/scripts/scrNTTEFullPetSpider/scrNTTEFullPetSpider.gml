// Source petlib.Spider and petlib.ntte_end_step, including its intentionally
// broad triangle-bounds contact test (the source point-in-triangle is disabled).
function scrNTTEFullPetSpiderSkin() {
    var _prefix=bskin==1 ? "PetSpiderCursed":"PetSpider"
    scrNTTEFullPetSkinField("spr_idle",scrNTTERefSprite(_prefix+"Idle"))
    scrNTTEFullPetSkinField("spr_walk",scrNTTERefSprite(_prefix+"Walk"))
    scrNTTEFullPetSkinField("spr_hurt",scrNTTERefSprite(_prefix+"Hurt"))
    scrNTTEFullPetSkinField("spr_icon",scrNTTERefSprite(_prefix+"Icon"))
    spr_web_kill=bskin==1 ? scrNTTERefSprite("PetSpiderCursedKill"):sprTangleKill
}
function scrNTTEFullPetSpiderCreate() {
    scrNTTEFullPetSpiderSkin()
    spr_web=scrNTTERefSprite("PetSpiderWeb"); spr_web_bits=scrNTTERefSprite("PetSpiderWebBits"); spr_bubble_y=1
    maxspeed=3.4; web_list=[]; web_list_x1=infinity; web_list_y1=infinity; web_list_x2=-infinity; web_list_y2=-infinity
    web_add_l=8; web_add_side=choose(-90,90); web_add_d=direction+web_add_side
    web_timer_max=9; web_timer=9; web_frame=0; web_hit_list=ds_map_create(); web_bits=0; curse=0
    array_push(history,"curse"); stat.webbed=scrNTTEFullValue(stat,"webbed",0)
    hooks={skin:method(id,scrNTTEFullPetSpiderSkin),step:method(id,scrNTTEFullPetSpiderStep),alarm:method(id,scrNTTEFullPetSpiderAlarm),endstep:method(id,scrNTTEFullPetSpiderEndStep),cleanup:method(id,scrNTTEFullPetSpiderCleanup)}
    if(!instance_exists(NTTEFullPetWebDraw)) instance_create(0,0,NTTEFullPetWebDraw)
}
function scrNTTEFullPetSpiderWebAdd(_x,_y) {
    array_push(web_list,{x:_x,y:_y,frame:web_frame+120,wading:scrNTTEFullAreaKey(GameCont.area)=="coast" && !position_meeting(_x,_y,Floor)})
    web_list_x1=min(web_list_x1,_x); web_list_y1=min(web_list_y1,_y)
    web_list_x2=max(web_list_x2,_x); web_list_y2=max(web_list_y2,_y)
}
function scrNTTEFullPetSpiderWebDelete(_index) {
    array_delete(web_list,_index,1)
    web_list_x1=infinity; web_list_y1=infinity; web_list_x2=-infinity; web_list_y2=-infinity
    for(var _i=0;_i<array_length(web_list);++_i) {
        web_list_x1=min(web_list_x1,web_list[_i].x); web_list_y1=min(web_list_y1,web_list[_i].y)
        web_list_x2=max(web_list_x2,web_list[_i].x); web_list_y2=max(web_list_y2,web_list[_i].y)
    }
}
function scrNTTEFullPetSpiderStep() {
    web_addx=x; web_addy=y
    if(instance_exists(leader)) {
        if(web_timer>0) {
            if(speed>0) web_timer-=timescale
            if(web_timer<=0) {
                web_timer=web_timer_max
                scrNTTEFullPetSpiderWebAdd(x+lengthdir_x(web_add_l,web_add_d),bbox_bottom+lengthdir_y(web_add_l,web_add_d))
                web_add_l=8+orandom(2); web_add_d=direction+web_add_side+orandom(20); web_add_side*=-1
            }
        }
    } else web_timer=web_timer_max
    if(random(20)<timescale) {
        var _fx=instance_create(x+orandom(8),y+orandom(8),CaveSparkle)
        _fx.sprite_index=curse>0 ? sprCaveSparkle:scrNTTERefSprite("PetSparkle"); _fx.depth=depth-1
    }
    if(curse<=0 && GameCont.area==area_cursed_caves && !instance_exists(GenCont) && !instance_exists(LevCont)) {
        curse=1; scrNTTEFullPetSetSkin(id,1); stat.cursed=scrNTTEFullValue(stat,"cursed",0)+1
        var _alert=scrNTTEAlertCreate(x,y,spr_icon,id)
        _alert.alert_sprite=sprCurse; _alert.alert_x+=1; _alert.alert_y=3
        _alert.alert_hold=90; _alert.blink=10; _alert.snd_flash=sndCursedChest
    }
}
function scrNTTEFullPetSpiderAlarm(_dir,_dis) {
    ntte_pet_alarm=20+irandom(20)
    if(instance_exists(leader)) {
        if(!is_undefined(path_dir)) {
            scrNTTEFullPetWalk(path_dir+orandom(15),random_range(5,10)); right=lengthdir_x(1,direction)>=0 ? 1:-1; return walk
        }
        scrNTTEFullPetWalk(_dir+orandom(30),20); right=lengthdir_x(1,direction)>=0 ? 1:-1
        if(_dis>160) return walk
    } else { scrNTTEFullPetWalk(random(360),random_range(5,10)); right=lengthdir_x(1,direction)>=0 ? 1:-1 }
    return 0
}
// BEGIN NTTE SPIDER CONTINUOUS ENDSTEP BINDING
function scrNTTEFullPetSpiderBinding() {
    // Original petlib global end_step handles hidden spiders as well.
    // The room-local renderer owns surface/camera cleanup and is recreated.
    if(!instance_exists(NTTEFullPetWebDraw)) instance_create(0,0,NTTEFullPetWebDraw)
    if(instance_exists(GenCont)) {
        web_list=[]; web_timer=web_timer_max; web_list_x1=infinity; web_list_y1=infinity; web_list_x2=-infinity; web_list_y2=-infinity
    }
}
// END NTTE SPIDER CONTINUOUS ENDSTEP BINDING
function scrNTTEFullPetSpiderEndStep() {
    if(instance_exists(GenCont)) return;
    web_frame+=timescale
    var _slowed=[],_pet=id
    for(var _i=2;_i<array_length(web_list);++_i) {
        var _a=web_list[_i],_b=web_list[_i-1],_c=web_list[_i-2]
        var _left=min(_a.x,_b.x,_c.x),_right=max(_a.x,_b.x,_c.x),_top=min(_a.y,_b.y,_c.y),_bottom=max(_a.y,_b.y,_c.y)
        with(hitme) if(team!=_pet.team && team!=team_none && mask_index!=mskNone
            && (instance_is(id,enemy) || instance_is(id,Player) || instance_is(id,Sapling) || instance_is(id,Ally) || instance_is(id,SentryGun) || instance_is(id,NTTEFullPet))
            && bbox_right>=_left && bbox_left<=_right && bbox_bottom>=_top && bbox_top<=_bottom
            && array_get_index(_slowed,id)<0 && !collision_line(x,y,xprevious,yprevious,Wall,false,false)) array_push(_slowed,id)
    }
    for(var _i=0;_i<array_length(_slowed);++_i) {
        var _target=_slowed[_i]
        _target.x=lerp(_target.x,_target.xprevious,2/3*timescale); _target.y=lerp(_target.y,_target.yprevious,2/3*timescale)
        if(!variable_instance_exists(_target,"ntte_statspider")) { _target.ntte_statspider=true; stat.webbed+=1 }
        if(curse!=0 && _target.hp>0 && (!ds_map_exists(web_hit_list,_target) || web_hit_list[? _target]<=web_frame)) {
            web_hit_list[? _target]=web_frame+30
            scr_projectile_hit(_target,10*curse)
            if(instance_exists(_target) && _target.hp<=0) {
                snd_play_hit(sndPlantTBKill,0.2)
                var _kill=instance_create(_target.x,_target.y,TangleKill); _kill.sprite_index=spr_web_kill
            }
        }
    }
    for(var _i=0;_i<array_length(web_list);++_i) {
        var _point=web_list[_i]
        if(_point.frame<web_frame) {
            // Source _vertexNum was incremented already, so next point is i+2.
            var _x=_point.x,_y=_point.y
            if(_i+2<array_length(web_list)) { _x=web_list[_i+2].x; _y=web_list[_i+2].y }
            _point.x=lerp(_point.x,_x,1-power(0.8,timescale)); _point.y=lerp(_point.y,_y,1-power(0.8,timescale))
            if(point_distance(_x,_y,_point.x,_point.y)<1) { scrNTTEFullPetSpiderWebDelete(_i); --_i }
        } else if(_point.wading) {
            var _off=sin((current_frame+_point.frame)/10)*timescale
            _point.x+=_off*0.1; _point.y+=_off*0.15
        }
    }
    if(web_bits>0) web_bits-=timescale
    else {
        web_bits=10+random(20)
        if(array_length(web_list)>0 && web_list[0].frame<web_frame) {
            var _point=web_list[0]
            if(curse>0) instance_create(_point.x,_point.y,Curse)
            else { var _dust=instance_create(_point.x,_point.y,Dust); /* NTTE DUST LIFETIME spider-web */ if(instance_exists(_dust)) {_dust.image_xscale/=2; _dust.image_yscale/=2 } }
            var _bit=instance_create(_point.x,_point.y,Feather)
            _bit.sprite_index=spr_web_bits; _bit.image_index=irandom(sprite_get_number(spr_web_bits)-1)
            _bit.image_angle=orandom(30); _bit.image_speed=0; _bit.speed*=0.5
            _bit.rot*=0.5; _bit.alarm[0]=60+random(30)
        }
    }
}
function scrNTTEFullPetSpiderCleanup() { if(ds_exists(web_hit_list,ds_type_map)) ds_map_destroy(web_hit_list) }
function scrNTTEFullPetWebDrawCreate() {
    persistent=false; depth=5; ntte_web_surface=-1
    ntte_web_camera=camera_create_view(0,0,view_width,view_height,0,noone,-1,-1,-1,-1)
}
function scrNTTEFullPetWebDrawCleanup() {
    if(surface_exists(ntte_web_surface)) surface_free(ntte_web_surface)
    if(ntte_web_camera>=0) camera_destroy(ntte_web_camera)
}
function scrNTTEFullPetWebDraw() {
    var _spiders=[]
    with(NTTEFullPet) if(pet=="Spider") array_push(_spiders,id)
    if(array_length(_spiders)==0) { instance_destroy(); return; }
    var _w=view_width,_h=view_height,_vx=view_xview,_vy=view_yview,_scale=scrNTTEFullVisualQuality("main"),
        _sw=scrNTTEFullQualitySurfaceSize(_w,_scale),_sh=scrNTTEFullQualitySurfaceSize(_h,_scale)
    if(!surface_exists(ntte_web_surface) || surface_get_width(ntte_web_surface)!=_sw || surface_get_height(ntte_web_surface)!=_sh) {
        if(surface_exists(ntte_web_surface)) surface_free(ntte_web_surface)
        ntte_web_surface=surface_create(_sw,_sh)
    }
    if(!surface_exists(ntte_web_surface)) return;
    var _v=matrix_get(matrix_view),_p=matrix_get(matrix_projection),_world=matrix_get(matrix_world),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_active=false
    gpu_push_state()
    try {
        gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        surface_set_target(ntte_web_surface);_active=true;draw_clear_alpha(c_black,0)
        scrNTTEFullQualityCamera(ntte_web_camera,_vx,_vy,_w,_h)
        draw_set_color(c_black);draw_set_alpha(1)
        for(var _i=0;_i<array_length(_spiders);++_i) with(_spiders[_i]) {
            draw_primitive_begin(pr_trianglestrip)
            for(var _j=0;_j<array_length(web_list);++_j) draw_vertex(web_list[_j].x,web_list[_j].y)
            if(instance_exists(leader)) {
                var _length=web_add_l*(1-web_timer/web_timer_max)
                draw_vertex(x+lengthdir_x(_length,web_add_d),bbox_bottom+lengthdir_y(_length,web_add_d))
            }
            draw_primitive_end()
        }
        gpu_set_blendmode_ext(bm_inv_dest_alpha,bm_inv_dest_alpha)
        draw_rectangle(_vx,_vy,_vx+_w,_vy+_h,false)
        // World-space tiling is algebraically the source's pixel projection
        // and (-view*scale, scale, scale) sprite origin/size transformation.
        draw_sprite_tiled_ext(scrNTTERefSprite("PetSpiderWeb"),0,0,0,1,1,c_white,1)
        gpu_set_blendmode(bm_normal);surface_reset_target();_active=false
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_v);matrix_set(matrix_projection,_p)
        gpu_set_fog(true,make_color_rgb(50,41,71),0,0)
        draw_surface_ext(ntte_web_surface,_vx,_vy+1,1/_scale,1/_scale,0,c_white,1)
        gpu_set_fog(false,0,0,0)
        draw_surface_ext(ntte_web_surface,_vx,_vy,1/_scale,1/_scale,0,c_white,1)
    }
    finally {
        if(_active) surface_reset_target()
        gpu_pop_state();matrix_set(matrix_world,_world);matrix_set(matrix_view,_v);matrix_set(matrix_projection,_p)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}
function scrNTTEFullPetSpiderTests() {
    var _p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"ntte_pet",[]),_x=_p.x,_y=_p.y
    _p.ntte_pet=[]; _p.x=18000; _p.y=18000
    var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Spider"); scrNTTEFullPetTake(_pet,_p)
    assert(_pet.maxspeed==3.4 && _pet.web_timer_max==9 && is_callable(_pet.hooks.skin)
        && instance_exists(NTTEFullPetWebDraw),"Spider original web timer/renderer/skin hooks missing")
    _pet.speed=timescale; _pet.web_timer=timescale
    var _side=_pet.web_add_side
    with(_pet) scrNTTEFullPetSpiderStep()
    assert(array_length(_pet.web_list)==1 && _pet.web_list[0].frame==_pet.web_frame+120
        && _pet.web_add_side==-_side,"Spider did not lay original120frame alternating web point")
    with(_pet) {
        web_list=[]
        scrNTTEFullPetSpiderWebAdd(x-24,y-24)
        scrNTTEFullPetSpiderWebAdd(x+24,y-24)
        scrNTTEFullPetSpiderWebAdd(x,y+24)
    }
    var _enemy=instance_create(_pet.x,_pet.y,Bandit),_ally=instance_create(_pet.x,_pet.y,Bandit)
    _enemy.team=team_enemy; _enemy.hp=100; _enemy.xprevious=_enemy.x-6; _enemy.yprevious=_enemy.y-3
    _ally.team=_p.team; _ally.hp=100; _ally.xprevious=_ally.x-6
    var _ex=_enemy.x,_ey=_enemy.y,_ax=_ally.x,_webbed=_pet.stat.webbed
    with(_pet) scrNTTEFullPetSpiderEndStep()
    assert(abs(_enemy.x-(_ex-4*timescale))<0.001 && abs(_enemy.y-(_ey-2*timescale))<0.001
        && _ally.x==_ax && _pet.stat.webbed==_webbed+1,"Spider web did not apply original2/3 displacement slow exactly once or slowed ally")
    _pet.curse=1; scrNTTEFullPetSetSkin(_pet,1)
    with(_pet) scrNTTEFullPetSpiderEndStep()
    assert(_enemy.hp==90 && _ally.hp==100 && _pet.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle"),"Cursed Spider real10damage/faction/skin failed")
    with(_pet) scrNTTEFullPetSpiderEndStep()
    assert(_enemy.hp==90 && _pet.stat.webbed==_webbed+1,"Spider ignored per-target30frame curse cooldown or duplicated lifetime stat")
    _pet.web_frame+=30
    with(_pet) scrNTTEFullPetSpiderEndStep()
    assert(_enemy.hp==80,"Spider curse did not renew real damage after30logicalframes")
    var _saved=json_parse(json_stringify(scrNTTEFullPetExport()))
    scrNTTEFullPetImport(_saved); _pet=_p.ntte_pet[0]
    assert(_pet.curse==1 && _pet.bskin==1 && _pet.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle")
        && ds_exists(_pet.web_hit_list,ds_type_map),"Spider JSON continuation lost permanent curse/skin or reused destroyed hit map")
    var _map=_pet.web_hit_list
    instance_destroy(_pet)
    assert(!ds_exists(_map,ds_type_map),"Spider cleanup leaked target hit map")
    instance_destroy(_enemy,false); instance_destroy(_ally,false)
    _p.ntte_pet=_old; _p.x=_x; _p.y=_y
    scrNTTESmokeLog("SYSTEMS PET SPIDER: original alternating120frame strips, actual2/3movement slow/faction/unique stats, cursed10damage/30cooldown/skin, JSON fresh map/cleanup OK; visual surface review separate")
}
