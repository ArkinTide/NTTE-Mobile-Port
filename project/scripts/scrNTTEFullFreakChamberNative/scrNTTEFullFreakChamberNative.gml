// telabs405..984 and2889..3043. Real delayed side-room excavation, occupants,
// revealing tiles and colliding sliding doors. HQ artifact branch uses this same
// controller, rather than a permanently exposed chest or substitute room.
function scrNTTEFullFreakChamberCreate() {
    visible=false;mask_index=mskFloor;image_xscale=1;image_yscale=1
    hallway_size=1;styleb=true;area=GameCont.area;type="";object=-1;num=1
    enemies=instance_number(enemy);spawnmoment=random_range(0.3,0.9);open=false;setup=true;alarm0=-1
    slide_path=[[30,0,0,[sndToxicBoltGas,0.5+orandom(0.05),1]],
                [16,0,1,[sndTurretFire,0.3+random(0.1),0.9]],
                [10,0,0,[sndToxicBoltGas,0.3+random(0.1),0.5]],
                [16,90,1,[sndSwapMotorized,0.5+random(0.1),1]]]
    type=GameCont.area==area_hq?"Popo":scrNTTEFullTunnellerPool([["Freak",8],["Rhino",4],["Explo",4],["Vat",1]])
}
function scrNTTEFullFreakChamberSetup() {
    setup=false
    switch(type) {
        case "Freak":
            var _add=irandom_range(2,6)*num
            if(object==-1) object=Freak
            num*=(1+GameCont.loops)*2;image_xscale*=1+ceil(num/8);num+=_add
            break
        case "Explo":
            if(object==-1) object=ExploFreak
            num*=1+ceil(GameCont.loops/2)
            image_xscale*=1+ceil((num-4)/12);image_yscale*=1+ceil((num-4)/12)
            break
        case "Rhino":
            if(object==-1) object=RhinoFreak
            num*=1+ceil(GameCont.loops/2);image_xscale*=1+floor(num*2/3)
            break
        case "Vat":
            if(object==-1) object=Necromancer
            image_xscale*=3;image_yscale*=3;hallway_size*=irandom_range(1,3)
            break
        case "Popo":
            if(object==-1) {
                object=choose(Grunt,Grunt,Shielder,Inspector)
                num=(object==Grunt?irandom_range(2,3):1)+GameCont.loops
                if(GameCont.loops>2) object=PopoFreak
            }
            image_xscale*=2;image_yscale*=2;hallway_size*=0.5;styleb=false
            slide_path=[[45,0,0,[sndToxicBoltGas,0.6+random(0.1),1]],
                        [6,90,0.5,[sndIDPDPortalSpawn,6+random(0.1),1.4]],
                        [15,90,0],[13,90,1,[sndIDPDNadeAlmost,1.4+random(0.1),1.2]]]
            break
    }
}
function scrNTTEFullFreakChamberStep() {
// BEGIN NTTE HQ STOLEN CONTINUE TEST CHAMBER STEP
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueChamberStep(id); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST CHAMBER STEP
    if(setup) scrNTTEFullFreakChamberSetup()
    if(alarm0>0) {
        alarm0-=timescale
        if(alarm0<=0) { alarm0=-1;scrNTTEFullFreakChamberOpen() }
        return;
    }
    if(instance_number(enemy)<=enemies*spawnmoment) {
        if(!open) { open=true;alarm0=instance_exists(enemy)?30:1 }
    }
    else if(alarm0<0) {
        var _target=instance_nearest(x,y,Player)
        if(open || (instance_exists(_target) && point_distance(x,y,_target.x,_target.y)<96
            && !collision_line(x,y,_target.x,_target.y,Wall,false,false)))
            if(!instance_exists(LastFire)) alarm0=60
// BEGIN NTTE HQ STOLEN CONTINUE TEST CHAMBER GATE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueChamberGate(id,_target); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST CHAMBER GATE
    }
    if(alarm0>0) {
        var _me=id,_delay=alarm0
        with(NTTEFullFreakChamber) if(id!=_me && alarm0==_delay) alarm0+=30
    }
}
function scrNTTEFullChamberSnapshot(_inst) {
    var _names=variable_instance_get_names(_inst),_values={}
    for(var _i=0;_i<array_length(_names);++_i) variable_struct_set(_values,_names[_i],variable_instance_get(_inst,_names[_i]))
    var _builtins=["x","y","xprevious","yprevious","xstart","ystart","sprite_index","mask_index",
        "image_index","image_speed","image_xscale","image_yscale","image_angle","image_blend","image_alpha",
        "depth","visible","solid","speed","direction","friction","gravity","gravity_direction"]
    for(var _i=0;_i<array_length(_builtins);++_i) variable_struct_set(_values,_builtins[_i],variable_instance_get(_inst,_builtins[_i]))
    return {object_index:_inst.object_index,x:_inst.x,y:_inst.y,bbox_left:_inst.bbox_left,bbox_top:_inst.bbox_top,
        bbox_right:_inst.bbox_right-1,bbox_bottom:_inst.bbox_bottom-1,values:_values}
}
function scrNTTEFullChamberRestore(_record) {
    var _v=instance_create(_record.x,_record.y,_record.object_index),_names=variable_struct_get_names(_record.values)
    for(var _i=0;_i<array_length(_names);++_i) if(_names[_i]!="id" && _names[_i]!="object_index")
        variable_instance_set(_v,_names[_i],variable_struct_get(_record.values,_names[_i]))
    return _v
}
function scrNTTEFullChamberTransition(_wall,_area) {
    _wall.topspr=scrNTTEFullAreaWallSprite(_area,"Trans")
    if(_wall.sprite_index==sprWall6Bot) _wall.sprite_index=scrNTTERefSprite("Wall6BotTrans")
}
function scrNTTEFullChamberMakeSlide(_wall,_path,_dir,_cx,_cy,_top=false) {
    var _slide=instance_create(_wall.x,_wall.y,NTTEFullWallSlide),_copy=[],
        _side=sign(angle_difference(_dir,point_direction((_wall.bbox_left+_wall.bbox_right)/2,(_wall.bbox_top+_wall.bbox_bottom)/2,_cx,_cy)))
    for(var _i=0;_i<array_length(_path);++_i) {
        var _row=[];array_copy(_row,0,_path[_i],0,array_length(_path[_i]));array_push(_copy,_row)
    }
    for(var _i=0;_i<array_length(_copy);++_i) if(array_length(_copy[_i])>1) _copy[_i][1]=_dir+_copy[_i][1]*_side
    if(_top && array_length(_copy)>1 && array_length(_copy[1])>2) _copy[1][2]=0
    _slide.slide_inst=[_wall];_slide.slide_path=_copy
    if(!_top) _slide.smoke=1/5
    return _slide
}
function scrNTTEFullFreakChamberOpen() {
// BEGIN NTTE HQ STOLEN CONTINUE TEST CHAMBER ATTEMPT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueChamberAttempt(id); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST CHAMBER ATTEMPT
    alarm0=60
    if(!instance_exists(Player)) return false
    var _angle=round(random(360)/90)*90,_target=instance_nearest(x,y,Player),_hallDis=32*hallway_size,
        _path=slide_path,_candidates=[],_floors=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i]
        for(var _fx=_f.bbox_left;_fx<_f.bbox_right;_fx+=16) for(var _fy=_f.bbox_top;_fy<_f.bbox_bottom;_fy+=16) {
            var _cx=_fx+16,_cy=_fy+16
            if(!collision_rectangle(_fx,_fy,_fx+31,_fy+31,Wall,false,false)
                && (open || !collision_line(_cx,_cy,_target.x,_target.y,Wall,false,false))) {
                var _score=type=="Popo"?point_distance(_cx,_cy,x,y)
                    :random(32)+max(64*(1+instance_is(_f,FloorExplo)),point_distance(_cx,_cy,_target.x,_target.y))
                array_push(_candidates,{score:_score,x:_cx,y:_cy,w:32,h:32})
            }
        }
    }
    array_sort(_candidates,function(_a,_b){return sign(_a.score-_b.score)})
    var _avoid=_hallDis<32?[Floor,Wall,TopPot,Bones]:[Floor,Wall,TopSmall,TopPot,Bones]
    for(var _ci=0;_ci<array_length(_candidates);++_ci) {
        var _floor=_candidates[_ci]
        for(var _dir=_angle;_dir<_angle+360;_dir+=90) {
            var _fx=_floor.x+lengthdir_x(16,_dir),_fy=_floor.y+lengthdir_y(16,_dir)
            if(position_meeting(_fx+dcos(_dir),_fy-dsin(_dir),Floor)) continue
            var _hw=max(1,abs(lengthdir_x(_hallDis/32,_dir))),_hh=max(1,abs(lengthdir_y(_hallDis/32,_dir))),
                _hx=_fx+lengthdir_x(max(32,_hallDis)/2,_dir),_hy=_fy+lengthdir_y(max(32,_hallDis)/2,_dir),
                _hox=lengthdir_x(32,_dir),_hoy=lengthdir_y(32,_dir)
            if(array_length(scrNTTEFullRectInstances(_hx-_hw*16+max(0,_hox),_hy-_hh*16+max(0,_hoy),
                _hx+_hw*16+min(0,_hox)-1,_hy+_hh*16+min(0,_hoy)-1,_avoid))) continue
            var _yoff=-sprite_get_height(mask_index)*image_yscale/2,_spawn=true
            x=_fx+lengthdir_x(_hallDis,_dir)+lengthdir_x(_yoff,_dir-90)
            y=_fy+lengthdir_y(_hallDis,_dir)+lengthdir_y(_yoff,_dir-90);image_angle=_dir
            for(var _i=0;_i<array_length(_avoid);++_i) if(place_meeting(x,y,_avoid[_i])) { _spawn=false;break }
            if(!_spawn) continue
            var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2,
                _w=floor((bbox_right-bbox_left)/32),_h=floor((bbox_bottom-bbox_top)/32),_walls=[],_tops=[]
            var _oldWalls=scrNTTEFullRectInstances(_hx-_hw*16,_hy-_hh*16,_hx+_hw*16-1,_hy+_hh*16-1,Wall)
            for(var _i=0;_i<array_length(_oldWalls);++_i) {
                array_push(_walls,scrNTTEFullChamberSnapshot(_oldWalls[_i]));instance_destroy(_oldWalls[_i],false)
            }
            if(array_get_index(_avoid,TopSmall)>=0) {
                var _oldTops=scrNTTEFullRectInstances(_hx-_hw*16-16,_hy-_hh*16-16,_hx+_hw*16+15,_hy+_hh*16+15,TopSmall)
                for(var _i=0;_i<array_length(_oldTops);++_i) {
                    array_push(_tops,scrNTTEFullChamberSnapshot(_oldTops[_i]));instance_destroy(_oldTops[_i],false)
                }
                _oldTops=scrNTTEFullRectInstances(bbox_left-1,bbox_top-1,bbox_right,bbox_bottom,TopSmall)
                for(var _i=0;_i<array_length(_oldTops);++_i) {
                    array_push(_tops,scrNTTEFullChamberSnapshot(_oldTops[_i]));instance_destroy(_oldTops[_i],false)
                }
            }
            var _lastArea=GameCont.area,_min=scrNTTEFullBuriedVaultMaxID(),_hall=[],_main=[]
            GameCont.area=area;scrNTTEFullFloorSetStyle(styleb,area);scrNTTEFullFloorSetAlign(16,16)
            try { _hall=scrNTTEFullFloorFill(_hx,_hy,_hw,_hh);_main=scrNTTEFullFloorFill(_cx,_cy,_w,_h) }
            finally { scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();GameCont.area=_lastArea }
            var _new=scrNTTEFullBuriedVaultNew(Wall,_min)
            for(var _i=0;_i<array_length(_new);++_i) scrNTTEFullChamberTransition(_new[_i],area)
            _new=scrNTTEFullBuriedVaultNew(FloorExplo,_min)
            for(var _i=0;_i<array_length(_new);++_i) if(_new[_i].sprite_index==sprFloor106Explo) {
                _new[_i].sprite_index=scrNTTERefSprite("Floor106Small");_new[_i].depth=10
            }
            _new=scrNTTEFullBuriedVaultNew(Floor,_min)
            for(var _i=0;_i<array_length(_new);++_i) with(_new[_i]) {
                if(random(5)<1) {
                    var _style=styleb;styleb=false
                    instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Detail)
                    styleb=_style
                }
                depth=10
            }
            _new=scrNTTEFullBuriedVaultNew([Floor,Wall,TopSmall],_min)
            for(var _i=0;_i<array_length(_new);++_i) {
                var _v=_new[_i],_reveal=true
                if(array_get_index(_hall,_v)>=0) for(var _j=0;_j<array_length(_walls);++_j) {
                    var _wr=_walls[_j]
                    if(rectangle_in_rectangle(_wr.bbox_left,_wr.bbox_top,_wr.bbox_right,_wr.bbox_bottom,
                        _v.bbox_left,_v.bbox_top,_v.bbox_right-1,_v.bbox_bottom-1)) { _reveal=false;break }
                }
                if(instance_is(_v,Wall) || instance_is(_v,TopSmall)) {
                    with(_v) if(place_meeting(x,y,TopPot) || place_meeting(x,y,Bones)) _reveal=false
                    if(_reveal) for(var _j=0;_j<array_length(_tops);++_j)
                        if(_tops[_j].x==_v.x && _tops[_j].y==_v.y) { _reveal=false;break }
                }
                if(_reveal) {
                    var _re=scrNTTEFullFloorReveal(_v.bbox_left,_v.bbox_top,_v.bbox_right-1,_v.bbox_bottom-1,10)
                    _re.flash=false;_re.flash_color=_re.color
                    for(var _j=0;_j<min(2,array_length(_path));++_j) _re.time+=_path[_j][0]
                }
            }
            var _spawned=[]
            if(is_string(object) || object_exists(object)) for(var _i=0;_i<num;++_i) {
                var _f=_main[floor((_i+random(1))/num*array_length(_main))],_obj=object
                switch(_obj) {
                    case Grunt: if(random(5)<1) _obj=EliteGrunt;break
                    case Shielder: if(random(3)<1) _obj=EliteShielder;break
                    case Inspector: if(random(3)<1) _obj=EliteInspector;break
                }
                if(_obj==Player) with(Player) { x=_cx;y=_cy;xprevious=x;yprevious=y }
                else {
                    var _ox=(_f.bbox_left+_f.bbox_right)/2+orandom(4),_oy=(_f.bbox_top+_f.bbox_bottom)/2+orandom(4),
                        _occupant=is_string(_obj)?scrNTTEFullSystemsCreate(_obj,_ox,_oy):instance_create(_ox,_oy,_obj)
                    if(instance_exists(_occupant)) {
                        array_push(_spawned,_occupant)
                        if(instance_is(_occupant,enemy)) with(_occupant) {
                            walk=true;direction=random(360)
                            for(var _j=0;_j<array_length(_path);++_j) alarm[1]+=_path[_j][0]
                            if(variable_instance_exists(id,"roll")) roll=false
                        }
                        else if(instance_is(_occupant,chestprop)) {
                            _occupant.x=_cx;_occupant.y=_cy;_occupant.xprevious=_cx;_occupant.yprevious=_cy;_occupant.xstart=_cx;_occupant.ystart=_cy
                            if(_obj=="QuestChest") _occupant.wep=scrNTTEFullCrabboneCreateModel(2)
                        }
                        var _clear=scrNTTEFullBuriedVaultNew(PortalClear,real(_occupant.id))
                        for(var _j=0;_j<array_length(_clear);++_j) instance_destroy(_clear[_j])
                    }
                }
            }
            switch(type) {
                case "Explo":
                    for(var _i=0;_i<array_length(_main);++_i) if(random(3)<1) with(_main[_i]) {
                        var _mark=instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Scorchmark)
                        _mark.sprite_index=scrNTTERefSprite("FirePitScorch");_mark.image_index=irandom(_mark.image_number-1);_mark.image_speed=0;_mark.image_angle=random(360)
                    }
                    break
                case "Vat":
                    scrNTTEFullWorldCreateRequired("MutantVat",_cx,_cy-4)
                    instance_create(_cx+choose(-32,32),_cy-2+choose(-32,32),Terminal)
                    break
                case "Popo":
                    if(_w>1 && _h>1) {
                        var _middle=instance_create(_cx,_cy,FloorMiddle)
                        if(_w<4 || _h<4) { _middle.sprite_index=scrNTTERefSprite("FloorMiddleSmall");_middle.mask_index=scrNTTERefSprite("msk.FloorMiddleSmall") }
                    }
                    _new=scrNTTEFullBuriedVaultNew(enemy,_min)
                    for(var _i=0;_i<array_length(_new);++_i) if(!is_undefined(scrNTTEFullValue(_new[_i],"gunangle",undefined))) with(_new[_i]) {
                        direction=point_direction(x,y,_hx,_hy);scrNTTEFullWorldLook(direction);alarm[1]=max(1,alarm[1]-30)
                    }
                    break
            }
            var _sliders=[]
            for(var _i=0;_i<array_length(_tops);++_i) {
                var _top=_tops[_i],_override=[]
                with(Wall) if(x==_top.x && y==_top.y) array_push(_override,id)
                if(array_length(_override)) for(var _j=0;_j<array_length(_override);++_j) {
                    _override[_j].topspr=_top.values.sprite_index;_override[_j].topindex=_top.values.image_index
                }
                else {
                    var _wall=instance_create(_top.x,_top.y,Wall)
                    _wall.topspr=_top.values.sprite_index;_wall.topindex=_top.values.image_index
                    _wall.image_blend=_top.values.image_blend;_wall.image_alpha=_top.values.image_alpha
                    if(_wall.sprite_index==sprWall6Bot) _wall.sprite_index=scrNTTERefSprite("Wall6BotTrans")
                    array_push(_sliders,scrNTTEFullChamberMakeSlide(_wall,_path,_dir,_cx,_cy,true))
                }
            }
            for(var _i=0;_i<array_length(_walls);++_i) {
                var _wall=scrNTTEFullChamberRestore(_walls[_i])
                _wall.depth=min(_wall.depth,-1)
                if(!_wall.visible && _wall.sprite_index==sprWall6Bot) _wall.sprite_index=scrNTTERefSprite("Wall6BotTrans")
                array_push(_sliders,scrNTTEFullChamberMakeSlide(_wall,_path,_dir,_cx,_cy))
            }
            ntte_chamber_result={center_x:_cx,center_y:_cy,hall_x:_hx,hall_y:_hy,floors:_main,hall:_hall,occupants:_spawned,slides:_sliders,walls:_walls,tops:_tops,direction:_dir}
            // Keep exact result available to instrumentation before source self
            // disposal. Callers testing need to capture it via this return.
            var _result=ntte_chamber_result
// BEGIN NTTE HQ STOLEN CONTINUE TEST CHAMBER RESULT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueChamberResult(id,_result); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST CHAMBER RESULT
            if(instance_exists(enemy)) scrNTTEFullPortalPoof()
            instance_destroy()
            return _result
        }
    }
    return false
}
function scrNTTEFullWallSlideCreate() {
    visible=false;slide_inst=[];slide_path=[];slide_index=-1;slide_loop=false;slide_time=0;smoke=0;direction=0;speed=timescale
}
function scrNTTEFullWallSlideEnd() {
    var _live=[]
    for(var _i=0;_i<array_length(slide_inst);++_i) if(instance_exists(slide_inst[_i])) array_push(_live,slide_inst[_i])
    slide_inst=_live
    if(!array_length(slide_inst)) { instance_destroy();return }
    if(slide_time>0) slide_time-=timescale
    if(slide_time<=0) {
        for(var _i=0;_i<array_length(slide_inst);++_i) {
            var _wall=slide_inst[_i],_older=[]
            with(Wall) if(x==_wall.x && y==_wall.y && id<_wall.id) array_push(_older,id)
            for(var _j=0;_j<array_length(_older);++_j) {
                var _keys=["image_blend","topspr","topindex","l","h","w","r"]
                for(var _k=0;_k<array_length(_keys);++_k) variable_instance_set(_wall,_keys[_k],variable_instance_get(_older[_j],_keys[_k]))
                instance_destroy(_older[_j],false)
            }
        }
        var _tries=array_length(slide_path)
        while(slide_time<=0) {
            slide_index+=1
            if(slide_loop && array_length(slide_path)) slide_index%=array_length(slide_path)
            if(_tries-->0 && slide_index>=0 && slide_index<array_length(slide_path)) {
                var _current=slide_path[slide_index]
                if(array_length(_current)>0) slide_time=_current[0]
                if(array_length(_current)>1) direction=_current[1]
                if(array_length(_current)>2) speed=_current[2]*timescale
                if(array_length(_current)>3) {
                    var _snd=_current[3]
                    if(is_array(_snd)) scrNTTEFullCoastSoundAt(x,y,_snd[0],_snd[1],_snd[2])
                    else snd_play_hit(_snd,0)
                }
            }
            else { instance_destroy();return }
        }
    }
    var _mx=hspeed,_my=vspeed
    for(var _i=0;_i<array_length(slide_inst);++_i) with(slide_inst[_i]) {
        x+=_mx;y+=_my
        if(_mx!=0 || _my!=0) {
            var _actors=scrNTTEFullInstances(hitme)
            for(var _j=0;_j<array_length(_actors);++_j) {
                var _actor=_actors[_j],_touch=false
                with(_actor) _touch=place_meeting(x,y,other.id)
                if(_touch) with(_actor) {
                    if(!place_meeting(x+_mx,y,Wall)) x+=_mx
                    if(!place_meeting(x,y+_my,Wall)) y+=_my
                }
            }
            scrNTTEFullTrenchShake((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,3,true)
        }
        depth=min(depth,-1);visible=place_meeting(x,y+16,Floor);l=0;r=0;w=24;h=24
        if(other.smoke>0 && random(1)<other.smoke*timescale) {
            var _smoke=instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,Smoke)
            /* NTTE NATIVE EFFECT LIFETIME wall-slide-smoke */ if(instance_exists(_smoke)) {_smoke.direction=other.direction+180;_smoke.speed=2*timescale }
        }
    }
}
function scrNTTEFullWallSlideDestroy() {
    for(var _i=0;_i<array_length(slide_inst);++_i) if(instance_exists(slide_inst[_i])) with(slide_inst[_i]) {
        depth=max(depth,0);visible=place_meeting(x,y+16,Floor)
        l=place_free(x-16,y)?0:4;w=(place_free(x+16,y)?24:20)-l
        r=place_free(x,y-16)?0:4;h=(place_free(x,y+16)?24:20)-r
    }
}
