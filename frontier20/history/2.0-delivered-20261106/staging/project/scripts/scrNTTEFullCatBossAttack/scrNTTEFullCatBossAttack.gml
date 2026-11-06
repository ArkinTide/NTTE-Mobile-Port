// Original CatBossAttack warning fan -> instant damage + persistent toxic rails.
function scrNTTEFullCatBossAttackCreate() {
    // NTT CustomObject warning is above ground. The port's decor parent
    // supplies depth9, behind Pizza styleB/explosion floors at depth8.
    depth=6
    image_yscale=1.5; hitid=[scrNTTERefSprite("CatIdle"),"BIG CAT"]
    ntte_full_type=false; team=team_enemy; force=12; damage=8
    target=noone; creator=noone; ntte_full_lines=[]
    ntte_full_timer=30; ntte_full_max_timer=30
}

function scrNTTEFullCatBossAttackStep() {
    if (lockstep_stop) return;
    ntte_full_timer-=timescale
    if (ntte_full_timer<=0) { scrNTTEFullCatBossAttackFire(); return; }
    if (array_length(ntte_full_lines)==0) {
        var _num=(3+GameCont.loops)*(ntte_full_type ? 2.5:1),_spread=30+12*GameCont.loops,
            _offset=_num/2*ntte_full_type
        repeat(_num) array_push(ntte_full_lines,{dir:ntte_full_type ? orandom(_spread):0,
            dis:0,dir_goal:ntte_full_type ? 0:orandom(_spread),x:orandom(_offset),y:-4+orandom(_offset)})
    }
    if (creator!=noone && !instance_exists(creator)) { instance_destroy(); return; }
    if (instance_exists(creator)) creator.wkick=5*(1-ntte_full_timer/ntte_full_max_timer)
    if (ntte_full_type && instance_exists(target) && target.team!=team) {
        var _d=point_direction(x,y,target.x,target.y)
        if (instance_exists(creator)) with (creator)
            scrNTTEFullTrenchLook(gunangle+clamp(angle_difference(_d,gunangle),-60,60)/20*timescale)
        direction+=clamp(angle_difference(_d,direction),-60,60)/16*timescale
    }
    if (instance_exists(creator)) {
        var _offset=(ntte_full_type ? 28:16)-creator.wkick
        x=creator.x+lengthdir_x(_offset,creator.gunangle)
        y=creator.y+lengthdir_y(_offset,creator.gunangle)
    }
    for(var _i=0;_i<array_length(ntte_full_lines);++_i) {
        var _line=ntte_full_lines[_i]
        _line.dir=_line.dir_goal+angle_difference(_line.dir,_line.dir_goal)*power(1-1/7,timescale)
        var _dir=_line.dir+direction,_sx=x+_line.x,_sy=y+_line.y,_lx=_sx,_ly=_sy,
            _max=1000,_distance=_max,_minor=0
        while(_distance>0) {
            if (_minor<=0) {
                _lx=_sx+lengthdir_x(_distance,_dir); _ly=_sy+lengthdir_y(_distance,_dir)
                _distance-=sqrt(_max)
                if (collision_line(_sx,_sy,_lx,_ly,Wall,false,false)==noone && position_meeting(_lx,_ly,Floor)) {
                    _minor=2; _distance=sqrt(_max)
                }
            }
            else {
                if (position_meeting(_lx,_ly,Wall)) break
                _lx+=lengthdir_x(_minor,_dir); _ly+=lengthdir_y(_minor,_dir); _distance-=_minor
            }
        }
        _line.dis=point_distance(_sx,_sy,_lx,_ly)
        if (random(10)<timescale) {
            var _l=random(_line.dis),_p=instance_create(_sx+lengthdir_x(_l,_dir)+orandom(4),_sy+lengthdir_y(_l,_dir)+orandom(4),RadEat)
            _p.sprite_index=choose(sprEatRadPlut,sprEatBigRad)
            with (_p) motion_set(_dir+180+orandom(60),2*timescale)
        }
    }
}

function scrNTTEFullCatBossAttackDraw() {
    var _s1=image_yscale*(1+3*(1-ntte_full_timer/ntte_full_max_timer)),_s2=9*image_yscale,
        _colors=[make_color_rgb(133,249,26),make_color_rgb(190,253,8)]
    draw_set_color(_colors[floor(current_frame) mod 2])
    for(var _i=0;_i<array_length(ntte_full_lines);++_i) {
        var _line=ntte_full_lines[_i],_sx=x+_line.x,_sy=y+_line.y,_d=_line.dir+direction,
            _ex=_sx+lengthdir_x(_line.dis,_d),_ey=_sy+lengthdir_y(_line.dis,_d)
        draw_line_width(_sx,_sy,_ex,_ey,_s1/2)
        if (ntte_full_type) draw_circle(_sx,_sy,_s1,false)
        gpu_set_blendmode(bm_add); draw_set_alpha(0.025)
        if (ntte_full_type) draw_circle(_sx,_sy,_s2,false)
        draw_line_width(_sx,_sy,_ex,_ey,_s2)
        draw_set_alpha(1); gpu_set_blendmode(bm_normal)
    }
    draw_set_color(c_white)
}

function scrNTTEFullCatBossAttackFire() {
    for(var _i=0;_i<array_length(ntte_full_lines);++_i) {
        var _line=ntte_full_lines[_i],_sx=x+_line.x,_sy=y+_line.y,_distance=_line.dis,_dir=_line.dir+direction
        if (ntte_full_type) {
            instance_create(_sx+lengthdir_x(_distance-24,_dir),_sy+lengthdir_y(_distance-24,_dir),PortalClear)
            instance_create(_sx+lengthdir_x(_distance,_dir),_sy+lengthdir_y(_distance,_dir),ToxicDelay)
        }
        while(_distance>0) {
            var _lx=_sx+lengthdir_x(_distance,_dir),_ly=_sy+lengthdir_y(_distance,_dir),
                _radius=(12+GameCont.loops)*ntte_full_type
            if (ntte_full_type) {
                var _list=ds_list_create()
                collision_circle_list(_lx,_ly,_radius/2,hitme,true,false,_list,false)
                for(var _h=0;_h<ds_list_size(_list);++_h) {
                    var _victim=_list[| _h]
                    if (_victim!=creator && instance_exists(_victim) && scr_can_hit(_victim,true))
                        scr_projectile_hit(_victim,damage,force*timescale,_dir)
                }
                ds_list_destroy(_list)
            }
            var _gas=scr_projectile_create(_lx+orandom(_radius),_ly+orandom(_radius),NTTECatGas,_dir,1+random(1))
            _gas.friction+=random_range(0.1,0.2)*timescale*timescale
            _gas.growspeed*=_distance/max(0.001,_line.dis)
            _gas.team=(team==team_player ? team_player:team_none)
            if (random(2)<1) {
                var _fx=scrNTTEFullTrenchFX(_gas.x,_gas.y,8,0,AcidStreak)
                with (_fx) motion_set(_dir+orandom(8),4*timescale)
            }
            _distance-=6
        }
        var _gas=scr_projectile_create(_sx,_sy,NTTECatGas,_dir+180+orandom(20),3)
        with (_gas) move_contact_solid(_dir+180,20)
        _gas.friction=0.1*timescale*timescale
        _gas.team=(team==team_player ? team_player:team_none)
    }
    scrNTTEFullTrenchShake(x,y,32); snd_play(sndToxicBarrelGas)
    if (ntte_full_type) {
        snd_play(sndHyperSlugger,0.4+random(0.4)); snd_play(sndUltraCrossbow,2+random(0.5))
    }
    else snd_play(sndHyperSlugger)
    if (instance_exists(creator)) { with (creator) motion_add(other.direction+180,4*timescale); creator.wkick=16 }
    instance_destroy()
}
