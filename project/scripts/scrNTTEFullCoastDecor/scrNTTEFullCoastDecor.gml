// tecoast477..621. Actual destructible rocks/shell and permanent corpse floor.
function scrNTTEFullCoastDecalCreate() {
    var _type=irandom(array_length(scrNTTERefSprite("RockIdle"))-1)
    spr_idle=scrNTTERefSprite("RockIdle",_type); spr_hurt=scrNTTERefSprite("RockHurt",_type)
    spr_dead=scrNTTERefSprite("RockDead",_type); spr_bott=scrNTTERefSprite("RockBott",_type); spr_foam=scrNTTERefSprite("RockFoam",_type)
    sprite_index=spr_idle; mask_index=mskBandit; max_hp=50; size=3; shell=false; canwade=false
    x+=orandom(10); y+=orandom(10); xstart=x; ystart=y
}
function scrNTTEFullCoastDecalAfterCreate() {
    spr_shadow=mskNone; snd_hurt=sndHitRock; snd_dead=sndWallBreakRock
}
function scrNTTEFullCoastBigDecalAfterCreate() {
    spr_idle=scrNTTERefSprite("ShellIdle"); spr_hurt=scrNTTERefSprite("ShellHurt"); spr_dead=scrNTTERefSprite("ShellDead")
    spr_bott=scrNTTERefSprite("ShellBott"); spr_foam=scrNTTERefSprite("ShellFoam"); sprite_index=spr_idle; depth=-2
    snd_dead=sndHyperCrystalHurt; mask_index=mskScrapBoss; max_hp*=2; hp*=2; size=4; shell=true
}
function scrNTTEFullCoastDecalStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy(); return }
    var _self=id,_size=size,_touch=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,NTTEFullCoastDecal)
    for(var _i=0;_i<array_length(_touch);++_i) with(_touch[_i]) {
        if(id==_self || size>_size || !place_meeting(x,y,_self)) continue
        var _dir=point_direction(_self.x,_self.y,x,y),_tries=4096
        do { x+=lengthdir_x(8,_dir); y+=lengthdir_y(8,_dir) }
        until((!place_meeting(x,y,_self) && !position_meeting(x,y,Floor)) || --_tries<=0)
        if(_tries<=0) throw "Coast rock source separation could not find open water"
        xstart=x; ystart=y; xprevious=x; yprevious=y
    }
}
function scrNTTEFullCoastDecalDeath() {
    if(hp>0) return;
    if(!shell) {
        var _ang=random(360)
        for(var _a=_ang;_a<_ang+360;_a+=120) with(instance_create(x,y,MeleeHitWall)) image_angle=_a+orandom(10)
        repeat(choose(2,3)) with(instance_create(x+orandom(2),y+orandom(2),Debris))
            motion_set(other.direction+orandom(10),(speed+other.speed)/2)
    }
    var _corpse=instance_create(x,y,NTTEFullCoastDecalCorpse)
    _corpse.sprite_index=spr_dead; _corpse.spr_bott=spr_bott; _corpse.spr_foam=spr_foam; _corpse.image_xscale=image_xscale
    if(shell) { _corpse.depth-=2; _corpse.my_floor.mask_index=mskSalamander }
    spr_dead=-1
}
function scrNTTEFullCoastDecalCorpseCreate() {
    sprite_index=scrNTTERefSprite("RockDead",0); spr_bott=scrNTTERefSprite("RockBott",0); spr_foam=scrNTTERefSprite("RockFoam",0)
    depth=5; image_speed=0.4*timescale; image_index=0; my_floor=noone
    var _off=0,_tries=4096
    while(!instance_exists(my_floor) && _tries-->0) {
        my_floor=instance_create(_off,0,Floor); _off+=32
        if(instance_exists(my_floor)) with(my_floor) {
            x=other.x; y=other.y; instance_change(FloorExplo,false)
            mask_index=mskAlly; visible=false; material=2
        }
    }
    if(!instance_exists(my_floor)) throw "Coast rock corpse could not allocate actual support floor"
}
function scrNTTEFullCoastDecalCorpseStep() {
    if(lockstep_stop) return;
    if(image_speed!=0 && image_index+image_speed>=image_number) { image_speed=0; image_index=image_number-1 }
}
function scrNTTEFullCoastDecorSmoke() {
    var _before=scrNTTEFullInstances(all)
    var _rock=instance_create(38016,38016,NTTEFullCoastDecal),_shell=instance_create(38216,38016,NTTEFullCoastBigDecal)
    assert(_rock.hp==50 && _rock.size==3 && !_rock.canwade && !_rock.shell && _rock.spr_shadow==mskNone,
        "Coast rock lost source50HP/size3/unwadeable/no-shadow setup")
    assert(_shell.hp==100 && _shell.max_hp==100 && _shell.size==4 && _shell.shell && _shell.depth==-2
        && _shell.mask_index==mskScrapBoss && _shell.spr_idle==scrNTTERefSprite("ShellIdle"),
        "Large Coast shell lost original doubled health/size4/ScrapBoss mask/artwork")
    var _small=instance_create(_rock.x,_rock.y,NTTEFullCoastDecal)
    _small.x=_rock.x; _small.y=_rock.y
    with(_rock) scrNTTEFullCoastDecalStep()
    with(_rock) assert(!place_meeting(x,y,_small) && _small.xstart==_small.x && _small.ystart==_small.y,
        "Coast overlapping rock separation lost actual non-overlap/water movement/spawn position")
    var _rx=_rock.x,_ry=_rock.y,_dead=_rock.spr_dead,_bottom=_rock.spr_bott,_foam=_rock.spr_foam,
        _corpse_count=instance_number(NTTEFullCoastDecalCorpse),_native_corpse=instance_number(Corpse)
    _rock.hp=0; instance_destroy(_rock)
    var _corpse=instance_nearest(_rx,_ry,NTTEFullCoastDecalCorpse),_floor=_corpse.my_floor
    assert(instance_number(NTTEFullCoastDecalCorpse)==_corpse_count+1 && instance_number(Corpse)==_native_corpse
        && _corpse.sprite_index==_dead && _corpse.spr_bott==_bottom && _corpse.spr_foam==_foam,
        "Coast rock death failed actual special corpse or emitted an extra generic corpse")
    assert(instance_exists(_floor) && instance_is(_floor,FloorExplo) && !_floor.visible && _floor.mask_index==mskAlly
        && _floor.material==2 && _floor.x==_rx && _floor.y==_ry,
        "Coast rock corpse must provide an actual invisible small native FloorExplo support")
    _corpse.image_index=_corpse.image_number-1
    with(_corpse) event_perform(ev_step,ev_step_normal)
    assert(_corpse.image_speed==0.4*timescale,
        "Coast corpse froze before finishing the source final animation frame")
    _corpse.image_index=_corpse.image_number-_corpse.image_speed/2
    with(_corpse) event_perform(ev_step,ev_step_normal)
    assert(_corpse.image_speed==0 && _corpse.image_index==_corpse.image_number-1,
        "Coast corpse failed source last-frame animation freeze")
    var _sx=_shell.x,_sy=_shell.y
    _shell.hp=0; instance_destroy(_shell)
    var _shell_corpse=instance_nearest(_sx,_sy,NTTEFullCoastDecalCorpse)
    assert(_shell_corpse.depth==3 && _shell_corpse.my_floor.mask_index==mskSalamander,
        "Large shell corpse lost source depth3/larger Salamander support mask")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL COAST DECOR: actual50HP rock/100HP shell, overlapping rock separation, unique special corpse/invisible native support floor and animation freeze OK @"+string(30/timescale))
}
