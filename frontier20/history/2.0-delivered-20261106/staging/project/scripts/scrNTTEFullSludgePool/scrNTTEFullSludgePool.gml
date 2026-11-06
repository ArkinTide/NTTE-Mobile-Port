// tescrapyard1988..2350,3174..3270. The render pass reproduces the original
// captured-screen, fogged sprite-feet, pool-alpha cutout and south-pixel shader.
function scrNTTEFullSludgePoolCreate() {
    sprite_index=scrNTTERefSprite("msk.SludgePool"); spr_floor=scrNTTERefSprite("SludgePool")
    depth=4; mask_index=-1; image_speed=0; floors=[]; fx_color=make_color_rgb(90,189,5)
    my_alert=noone; right=choose(-1,1); setup=true; num=-1
    ntte_raven_reward_left=-1; ntte_sludge_emerge_left=-1
    if (!instance_exists(NTTEFullSludgeDraw)) instance_create(0,0,NTTEFullSludgeDraw)
}
function scrNTTEFullSludgePoolSetup() {
    setup=false
    if (array_length(floors)==0) {
        floors=scrNTTEFullFloorFill(x,y,ceil(abs(sprite_width)/32),ceil(abs(sprite_height)/32))
        if (array_length(floors)>0) {
            x=0; y=0
            for(var _i=0;_i<array_length(floors);++_i) {
                x+=(floors[_i].bbox_left+floors[_i].bbox_right)/2
                y+=(floors[_i].bbox_top+floors[_i].bbox_bottom)/2
            }
            x/=array_length(floors); y/=array_length(floors)
        }
    }
    for(var _i=0;_i<array_length(floors);++_i) if (instance_exists(floors[_i])) with (floors[_i]) {
        sprite_index=other.spr_floor
        image_index=sprite_index==sprFloor3 ? 3:_i
        if (material>0 && material<4) material+=3
    }
    if (num>0) {
        var _angle=random(360)
        for(var _dir=_angle;_dir<_angle+360;_dir+=360/num) {
            var _r=instance_create(round(x+lengthdir_x(12,_dir)),round(y+lengthdir_y(12,_dir)),NTTEFullBoneRaven)
            with (_r) {
                x=xstart; y=ystart; y-=round(bbox_bottom-1-y); creator=other.id
                scrNTTEFullWorldLook(_dir); scrNTTEFullWorldBudge(id,enemy,4)
            }
        }
    }
    // Original regular Manhole mapping is supplied by the shared factory. Do
    // not accidentally move BigManhole or already-open entrance substitutes.
    var _holes=scrNTTEFullWorldSludgeManholes()
    for(var _i=0;_i<array_length(_holes);++_i) with (_holes[_i]) if (place_meeting(x,y,other.id)) {
        var _hole=id,_fs=array_shuffle(scrNTTEFullInstances(Floor,true))
        for(var _j=0;_j<array_length(_fs);++_j) {
            var _floor=_fs[_j],_overlap=false
            with(_floor) _overlap=place_meeting(x,y,NTTEFullSludgePool)
            if (_overlap) continue
            _hole.x=(_floor.bbox_left+_floor.bbox_right)/2; _hole.y=(_floor.bbox_top+_floor.bbox_bottom)/2
            break
        }
    }
}
function scrNTTEFullWorldSludgeManholes() {
    return scrNTTEFullInstances(NTTEFullManhole)
}
function scrNTTEFullSludgePoolFail() {
    with (NTTEFullBoneRaven) if (creator==other.id) failed=true
}
function scrNTTEFullSludgePoolEmerge() {
    var _pet=scrNTTEFullPetCreate(x,y,"Salamander"); _pet.right=right
    for(var _dir=0;_dir<360;_dir+=120) {
        var _acid=instance_create(x+orandom(8),y+orandom(4),AcidStreak)
        with (_acid) {
            direction=_dir+90; speed=2*timescale; image_angle+=orandom(30)
            image_blend=merge_color(image_blend,c_lime,random(0.1))
        }
    }
    repeat(8) {
        var _s=instance_create(x,y,NTTEFullSweat)
        _s.direction=90+orandom(60); _s.speed=random(1)*timescale; _s.image_blend=merge_color(fx_color,c_lime,random(0.3))
    }
    snd_play(sndCorpseExplo,1+orandom(0.1)); snd_play(sndOasisMelee)
    if (instance_exists(my_alert)) with (my_alert) {
        sprite_index=scrNTTERefSprite("PetSalamanderIcon"); alert_sprite=scrNTTERefSprite("AlertIndicator")
        alert_angle=0; alert_age=0; alert_hold=90; flash=3; snd_flash=sndSalamanderEndFire
    }
}
function scrNTTEFullSludgePoolStep() {
    if (lockstep_stop) return;
    if (setup) scrNTTEFullSludgePoolSetup()
    if (ntte_raven_reward_left>0) {
        ntte_raven_reward_left-=timescale
        if (ntte_raven_reward_left<=0) { ntte_raven_reward_left=-1; scrNTTEFullSludgePoolFail(); return }
    }
    if (ntte_sludge_emerge_left>0) {
        ntte_sludge_emerge_left-=timescale
        if (ntte_sludge_emerge_left<=0) { ntte_sludge_emerge_left=-1; scrNTTEFullSludgePoolEmerge(); return }
    }
    if (num>0) {
        var _ravens=[]
        with (NTTEFullBoneRaven) if (creator==other.id) array_push(_ravens,id)
        if (array_length(_ravens)>0) {
            if (ntte_raven_reward_left<0) {
                var _start=false
                for(var _i=0;_i<array_length(_ravens);++_i) if (_ravens[_i].active) _start=true
                if (!_start) with (Player) if (point_distance(x,y,other.x,other.y)<96
                    && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _start=true; break }
                if (_start) ntte_raven_reward_left=120
            }
            if (ntte_raven_reward_left>0) {
                var _distance=96
                for(var _i=0;_i<array_length(_ravens);++_i) with (_ravens[_i]) if (!active) {
                    active=true; scrNTTEFullBoneRavenFly(_distance,_distance+64); _distance+=64
                }
            }
        }
    }
    else if (num==0) {
        num=-1; ntte_sludge_emerge_left=150
        var _p=instance_nearest(x,y,Player)
        if (instance_exists(_p)) scrNTTEFullWorldLook(point_direction(x,y,_p.x,_p.y))
        if (instance_exists(my_alert)) instance_destroy(my_alert)
        my_alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("SludgePoolAlert"),id)
        my_alert.alert_sprite=scrNTTERefSprite("AlertIndicatorMystery"); my_alert.alert_color=c_yellow
        my_alert.target_y-=4; my_alert.alert_hold=infinity
    }
    if (ntte_sludge_emerge_left>0) {
        if (random(30)<timescale || current_frame%15<timescale) {
            var _l=random_range(1/10,1/3)*choose(-1,1),_d=current_frame*10
            var _splash=instance_create(x+lengthdir_x(_l*sprite_width,_d),y+lengthdir_y(_l*sprite_height*2/3,_d),RainSplash)
            _splash.image_blend=merge_color(fx_color,c_black,random(0.1))
            var _bubble=instance_create(_splash.x,_splash.y,Bubble)
            _bubble.gravity*=random_range(0.5,0.8); _bubble.image_blend=_splash.image_blend
            _bubble.image_index=irandom(2); _bubble.hspeed/=3; _bubble.vspeed=0
        }
        var _sounds=[sndOasisMelee,sndOasisCrabAttack,sndOasisChest],_interval=scrNTTEFullPortalPointSeen(x,y,-1) ? 8:12
        if (current_frame%_interval<timescale || random(12)<1) snd_play_hit(_sounds[floor(((current_frame/_interval)/1.5)%array_length(_sounds))],0.4)
        if (instance_exists(my_alert)) my_alert.alert_angle=sin(current_frame*0.1)*20
    }
    var _survives=false
    for(var _i=0;_i<array_length(floors);++_i) if (instance_exists(floors[_i])) { _survives=true; break }
    if (!_survives) instance_destroy()
}
function scrNTTEFullSludgePoolEndStep() {
    if (lockstep_stop) return;
    var _pool=id,_col=fx_color
    with (hitme) if (speed>0 && size<6 && place_meeting(x,y,_pool) && position_meeting(x,bbox_bottom-1,_pool)) {
        var _slow=true
        if (instance_is(id,Player)) {
            if (!variable_global_exists("ntte_full_footprint_give") || !is_callable(global.ntte_full_footprint_give))
                throw "Original SludgePool footprint_give is not integrated"
            var _footprint=method(id,global.ntte_full_footprint_give); _footprint(40,_col,1.1)
            if (scr_skill_get(mut_extra_feet)>0) _slow=false
        }
        if (_slow) { x=lerp(xprevious,x,2/3); y=lerp(yprevious,y,2/3) }
        if (_pool.ntte_sludge_emerge_left>0) motion_add(point_direction(_pool.x,_pool.y,x,y),0.6*timescale*timescale)
        if (random(12)<speed) {
            var _dust=instance_create(x+orandom(2),bbox_bottom-1+random(4),Dust)
            /* NTTE DUST LIFETIME sludge-motion */ if(instance_exists(_dust)) {_dust.sprite_index=sprBoltTrail; _dust.image_blend=_col; _dust.image_xscale*=random_range(1,3); _dust.depth=_pool.depth-1 }
        }
    }
    with (RainSplash) if (image_blend==c_white && place_meeting(x,y,_pool)) {
        var _d=point_direction(_pool.x,_pool.y,x,y)
        if (position_meeting(x+lengthdir_x(4,_d),y+lengthdir_y(4*2/3,_d),_pool)) image_blend=_col
    }
    with (Dust) if (sprite_index==sprDust && place_meeting(x,y,_pool) && position_meeting(x,y,_pool)) {
        sprite_index=sprSweat; image_blend=_col; speed/=3
    }
}
function scrNTTEFullSludgePoolDraw() {
    if (ntte_sludge_emerge_left<=0) return;
    var _left=ntte_sludge_emerge_left
    gpu_set_fog(true,fx_color,0,0)
    draw_sprite_ext(scrNTTERefSprite("PetSalamanderIdle"),0.4*current_frame,x,
        y+max(0,_left-60)/8+min(1,_left/10)*sin(current_frame/10),image_xscale*right,image_yscale,image_angle,image_blend,image_alpha/max(1,0.1*(_left-50)))
    gpu_set_fog(false,0,0,0)
}

function scrNTTEFullSludgeDrawCreate() {
    depth=-4; ntte_sludge_surface=-1
    ntte_sludge_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
}
function scrNTTEFullSludgeDrawCleanup() {
    if (surface_exists(ntte_sludge_surface)) surface_free(ntte_sludge_surface)
    if (ntte_sludge_camera>=0) camera_destroy(ntte_sludge_camera)
}
function scrNTTEFullSludgeDraw() {
    if (!instance_exists(NTTEFullSludgePool) || instance_exists(GenCont)) return;
    var _vx=view_xview,_vy=view_yview,_w=view_width,_h=view_height,_scale=scrNTTEFullVisualQuality("minor")
    if (_scale<2/3) return;
    var _sw=max(1,ceil(_w*_scale)),_sh=max(1,ceil(_h*_scale)),_old_view=matrix_get(matrix_view),_old_projection=matrix_get(matrix_projection)
    if (!surface_exists(ntte_sludge_surface) || surface_get_width(ntte_sludge_surface)!=_sw || surface_get_height(ntte_sludge_surface)!=_sh) {
        if (surface_exists(ntte_sludge_surface)) surface_free(ntte_sludge_surface)
        ntte_sludge_surface=surface_create(_sw,_sh)
    }
    if (!surface_exists(ntte_sludge_surface)) return;
    var _shader=scrNTTEFullOptionGet("shaders") && !instance_exists(Menu) && shader_is_compiled(shNTTEFullSludgePool),
        _objects=scrNTTEFullInstances([hitme,Corpse,chestprop,ChestOpen,CrownObject]),
        _screen=surface_get_target(),_old_world=matrix_get(matrix_world),_old_color=draw_get_color(),_old_alpha=draw_get_alpha()
    if(!surface_exists(_screen)) _screen=application_surface
    gpu_push_state();draw_set_color(c_white);draw_set_alpha(1)
    if (_shader) {
        var _pickups=scrNTTEFullInstances([AmmoPickup,HPPickup,WepPickup,Rad,BigRad,CrownPickup])
        for(var _i=0;_i<array_length(_pickups);++_i) if (_pickups[_i].mask_index==mskPickup && array_get_index(_objects,_pickups[_i])<0) array_push(_objects,_pickups[_i])
    }
    var _pools=scrNTTEFullInstances(NTTEFullSludgePool)
    for(var _i=0;_i<array_length(_pools);++_i) with (_pools[_i]) if (visible) {
        var _near=scrNTTEFullRectInstances(bbox_left-8,bbox_top-8,bbox_right-1+8,bbox_bottom-1+8,_objects)
        var _visible=[]
        for(var _j=0;_j<array_length(_near);++_j) if (_near[_j].visible) array_push(_visible,_near[_j])
        if (array_length(_visible)==0) continue
        surface_set_target(other.ntte_sludge_surface)
        if (_shader) {
            camera_set_view_pos(other.ntte_sludge_camera,0,0); camera_set_view_size(other.ntte_sludge_camera,_sw,_sh); camera_apply(other.ntte_sludge_camera)
            gpu_set_blendmode_ext(bm_one,bm_zero)
            draw_surface_stretched(_screen,0,0,_sw,_sh)
            gpu_set_blendmode(bm_normal)
        }
        else draw_clear_alpha(c_black,0)
        camera_set_view_pos(other.ntte_sludge_camera,_vx,_vy); camera_set_view_size(other.ntte_sludge_camera,_w,_h); camera_apply(other.ntte_sludge_camera)
        gpu_set_fog(true,fx_color,0,0)
        for(var _j=0;_j<array_length(_visible);++_j) with (_visible[_j]) {
            var _spr=sprite_index
            if (!sprite_exists(_spr)) continue
            var _xsc=image_xscale*scrNTTEFullValue(id,"right",1),_ysc=image_yscale,_width=sprite_get_width(_spr)
            var _height=max(1/_scale,(_shader && (instance_is(id,Corpse) || instance_is(id,AmmoPickup) || instance_is(id,HPPickup) || instance_is(id,WepPickup) || instance_is(id,Rad) || instance_is(id,BigRad) || instance_is(id,CrownPickup) || instance_is(id,chestprop) || instance_is(id,prop)))
                ? sprite_get_bbox_bottom(_spr)+1-sprite_get_yoffset(_spr)
                :1+(string_pos("Sit",sprite_get_name(_spr))>0 ? 3:(_spr==sprRavenIdle || _spr==scrNTTERefSprite("BoneRavenIdle"))))
            var _top=sprite_get_bbox_bottom(_spr)+1-_height
            draw_sprite_part_ext(_spr,image_index,0,_top,_width,_height,x-sprite_get_xoffset(_spr)*_xsc,y-sprite_get_yoffset(_spr)*_ysc+_top,_xsc,_ysc,image_blend,image_alpha)
        }
        gpu_set_fog(false,0,0,0)
        gpu_set_blendmode_ext(bm_inv_src_alpha,bm_src_alpha)
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        gpu_set_blendmode(bm_normal)
        surface_reset_target(); matrix_set(matrix_view,_old_view); matrix_set(matrix_projection,_old_projection)
        if (_shader) {
            shader_set(shNTTEFullSludgePool)
            shader_set_uniform_f(shader_get_uniform(shNTTEFullSludgePool,"pixelSize"),1/_sw,1/_sh)
            shader_set_uniform_f(shader_get_uniform(shNTTEFullSludgePool,"sludgeRGB"),color_get_red(fx_color)/255,color_get_green(fx_color)/255,color_get_blue(fx_color)/255)
        }
        draw_surface_part_ext(other.ntte_sludge_surface,(bbox_left-_vx)*_scale,(bbox_top-_vy)*_scale,(bbox_right-bbox_left)*_scale,(bbox_bottom-bbox_top)*_scale,bbox_left,bbox_top,1/_scale,1/_scale,c_white,1)
        shader_reset()
    }
    gpu_pop_state();matrix_set(matrix_world,_old_world)
    draw_set_color(_old_color);draw_set_alpha(_old_alpha)
}

function scrNTTEFullSludgePoolSmoke() {
    var _snapshot=scrNTTEFullInstances(all)
    var _pool=instance_create(20000,20000,NTTEFullSludgePool)
    _pool.num=2
    with (_pool) scrNTTEFullSludgePoolSetup()
    assert(!_pool.setup && array_length(_pool.floors)==ceil(abs(_pool.sprite_width)/32)*ceil(abs(_pool.sprite_height)/32),"SludgePool source floor footprint changed")
    for(var _i=0;_i<array_length(_pool.floors);++_i) {
        var _f=_pool.floors[_i]
        assert(_f.sprite_index==_pool.spr_floor && _f.image_index==_i,"SludgePool original ordered floor frames changed")
    }
    var _ravens=[]
    with (NTTEFullBoneRaven) if (creator==_pool) array_push(_ravens,id)
    assert(array_length(_ravens)==2,"SludgePool did not create its original BoneRaven group")
    _ravens[0].active=true
    with (_pool) scrNTTEFullSludgePoolStep()
    assert(_pool.ntte_raven_reward_left==120 && _ravens[1].active,"SludgePool first active Raven did not start120ticks/activate group")
    _pool.ntte_raven_reward_left=timescale
    with (_pool) scrNTTEFullSludgePoolStep()
    assert(_pool.ntte_raven_reward_left==-1 && _ravens[0].failed && _ravens[1].failed,"SludgePool timeout did not mark actual Raven failure")
    var _e=instance_create(_pool.x,_pool.y-4,Maggot)
    _e.speed=timescale; _e.xprevious=_e.x-12; _e.yprevious=_e.y-6
    var _oldx=_e.x,_oldy=_e.y
    with (_pool) scrNTTEFullSludgePoolEndStep()
    assert(abs(_e.x-(_oldx-4))<=0.00001 && abs(_e.y-(_oldy-2))<=0.00001,"SludgePool sticky displacement did not retain source2/3 movement")
    _pool.num=0
    with (_pool) scrNTTEFullSludgePoolStep()
    assert(_pool.num==-1 && _pool.ntte_sludge_emerge_left==150 && instance_exists(_pool.my_alert)
        && _pool.my_alert.alert_sprite==scrNTTERefSprite("AlertIndicatorMystery") && _pool.my_alert.alert_hold==infinity,"SludgePool cleared challenge did not begin original150tick mystery silhouette stage")
    for(var _i=0;_i<array_length(_pool.floors);++_i) instance_destroy(_pool.floors[_i],false)
    _pool.ntte_sludge_emerge_left=-1
    with (_pool) scrNTTEFullSludgePoolStep()
    assert(!instance_exists(_pool),"SludgePool survived removal of its entire source floor footprint")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD SLUDGE POOL SOURCE FLOOR FRAMES/REAL RAVENS/120TIMER/TIMEOUT/STICKY TWO THIRDS/150MYSTERY/LOST FLOOR CLEANUP OK; SALAMANDER EMERGENCE SEPARATE")
}
function scrNTTEFullSludgeShaderSmoke() {
    assert(shader_is_compiled(shNTTEFullSludgePool),"Original SludgePool GLSL south-pixel shader did not compile")
    var _a=surface_create(4,4),_b=surface_create(4,4),_camera=camera_create_view(0,0,4,4,0,noone,-1,-1,-1,-1)
    var _view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),_sludge=make_color_rgb(90,189,5)
    surface_set_target(_a); camera_apply(_camera); draw_clear_alpha(c_black,0)
    draw_set_alpha(1); draw_set_color(_sludge); draw_point(1,1); draw_point(2,1)
    draw_set_color(make_color_rgb(133,249,26)); draw_point(1,2)
    draw_set_color(c_red); draw_point(2,2); draw_set_color(c_white)
    surface_reset_target()
    surface_set_target(_b); camera_apply(_camera); draw_clear_alpha(c_black,0)
    shader_set(shNTTEFullSludgePool)
    shader_set_uniform_f(shader_get_uniform(shNTTEFullSludgePool,"pixelSize"),1/4,1/4)
    shader_set_uniform_f(shader_get_uniform(shNTTEFullSludgePool,"sludgeRGB"),90/255,189/255,5/255)
    draw_surface(_a,0,0); shader_reset(); surface_reset_target()
    matrix_set(matrix_view,_view); matrix_set(matrix_projection,_projection)
    assert(surface_getpixel(_b,1,1)==_sludge,"Sludge shader did not retain sludge above exact original south RGB")
    assert(surface_getpixel(_b,2,1)==c_black && surface_getpixel(_b,1,2)==c_black,"Sludge shader retained pixels with wrong south RGB or wrong source RGB")
    surface_free(_a); surface_free(_b); camera_destroy(_camera)
    scrNTTESmokeLog("FULL WORLD SLUDGE ORIGINAL GLSL COLOR KEY/SOUTH PIXEL FILTER OK; FULL VISUAL SCENE REVIEW REMAINS")
}

// Original teevents1068..1125. Candidate restriction is based on all normal
// floors above the candidate's entire horizontal span, not just its center.
function scrNTTEFullSewerPoolEvent(_spawnx,_spawny) {
    scrNTTEFullFloorSetAlign(32,32)
    var _normal=scrNTTEFullInstances(Floor,true),_candidates=[]
    for(var _i=0;_i<array_length(_normal);++_i) with (_normal[_i]) if (styleb==0 && abs(_spawnx-(bbox_left+bbox_right)/2)>64) {
        var _above=false
        for(var _j=0;_j<array_length(_normal);++_j) {
            var _f=_normal[_j]
            if (_f.bbox_top<bbox_top && _f.bbox_left<=bbox_right-1 && _f.bbox_right-1>=bbox_left) { _above=true; break }
        }
        if (!_above) array_push(_candidates,id)
    }
    var _start=scrNTTEFullFloorRoomStart(_spawnx,_spawny,96,_candidates),_room=noone
    if (is_struct(_start)) {
        _room=scrNTTEFullFloorRoomCreate(_start.x,_start.y,2,4,"",90,0,-32)
        if (is_struct(_room)) {
            var _pool=instance_create(_room.x,_room.y,NTTEFullSludgePool)
            _pool.sprite_index=scrNTTERefSprite("msk.SewerPool"); _pool.spr_floor=scrNTTERefSprite("SewerPool")
            scrNTTEFullWorldCreateRequired("SewerDrain",_pool.x+16,_pool.y-64)
            if (point_distance(_room.x,_room.y,_spawnx,_spawny)>=128) repeat(2+irandom(1)) {
                var _cat=instance_create(_room.x-irandom(16),_room.y+orandom(24),NTTECat)
                _cat.right=choose(-1,1); _cat.ntte_cat_groundsit=true; _cat.ntte_cat_sit=noone; _cat.ntte_cat_sitting_sprite=-1
            }
        }
    }
    scrNTTEFullFloorResetAlign()
    return _room
}
function scrNTTEFullSewerPoolSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_sewers
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,24000,24000)
    // A pair of isolated tiles is enclosed by real Walls and deliberately
    // fails the source reachability test. This is a connected sewer corridor.
    scrNTTEFullFloorFill(24112,24016,8,1)
    var _count=instance_number(NTTEFullSewerDrain),_cats=instance_number(NTTECat)
    var _room=scrNTTEFullSewerPoolEvent(24016,24016)
    assert(is_struct(_room) && _room.x2-_room.x1==64 && _room.y2-_room.y1==128,"Original SewerPool vertical2x4 room dimensions changed")
    var _pool=instance_nearest(_room.x,_room.y,NTTEFullSludgePool)
    assert(instance_exists(_pool) && _pool.sprite_index==scrNTTERefSprite("msk.SewerPool") && _pool.spr_floor==scrNTTERefSprite("SewerPool"),"SewerPool did not use its real pool mask/floor frames")
    assert(instance_number(NTTEFullSewerDrain)==_count+1,"SewerPool did not create its actual source SewerDrain")
    var _drain=instance_nearest(_pool.x,_pool.y,NTTEFullSewerDrain)
    assert(_drain.x==_pool.x+16 && _drain.y==_pool.y-64,"SewerPool drain source offset changed")
    var _newcats=instance_number(NTTECat)-_cats
    var _distant=point_distance(_room.x,_room.y,24016,24016)>=128
    assert(_distant ? (_newcats>=2 && _newcats<=3):(_newcats==0),"SewerPool source distance-conditioned2..3 bathing Cats changed")
    with (NTTECat) if (array_get_index(_snapshot,id)<0) assert(ntte_cat_groundsit,"SewerPool Cats are not actually ground-sitting")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD SEWER POOL ORIGINAL TOP-EDGE CANDIDATES/2x4VERTICAL/MASK/FLOOR/REAL DRAIN+16,-64/BATHING CATS OK; AREA ROUTE AND FULL RENDER SEPARATE")
}
