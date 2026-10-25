// parrot.race.gml 2061..2306: original homing/sticking/retrieval lifecycle.
function scrNTTEFullParrotFeatherCreate() {
    sprite_index=sprChickenFeather; image_blend_fade=c_gray; depth=-1; mask_index=mskAlly
    creator=noone; target=noone; index=-1; bskin=0; stick=false; stickx=0; sticky=0
    stick_time_max=30; stick_time=stick_time_max; stick_list=[]; stick_wait=0
    motion_add(random(360),random_range(4,6)*timescale); image_angle=direction+135
}
function scrNTTEFullParrotFeatherNew(_x,_y,_creator,_target,_index=-1) {
    var _f=instance_create(_x,_y,NTTEFullParrotFeather)
    _f.creator=_creator; _f.target=_target; _f.index=_index
    _f.bskin=scrNTTEFullValue(_creator,"bskin",0)
    _f.stick_time_max=30*power(1.5,scrNTTEFullRaceUltraValue(_creator,1)); _f.stick_time=_f.stick_time_max
    // Source race_sprite maps the base Chicken feather to its B-skin art.
    _f.sprite_index=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Feather",_f.bskin,sprChickenFeather)
    return _f
}
function scrNTTEFullParrotFeatherStep() {
    if(stick_time<=0) { instance_destroy(); return }
    speed*=power(0.9,timescale)
    if(stick) {
        if(array_length(stick_list)==0) {
            var _list=[],_self=id
            with(NTTEFullParrotFeather) if(target==_self.target && creator==_self.creator && stick==_self.stick) array_push(_list,id)
            for(var _i=0;_i<array_length(_list);++_i) _list[_i].stick_list=_list
        }
        if(array_length(stick_list)>0 && stick_list[0]==id) stick_time-=timescale
    } else stick_list=[]
    if(instance_exists(target)) {
        if(stick) { visible=target.visible; depth=target.depth-1 }
        else {
            var _dir=point_direction(x,y,target.x,target.y),_dis=point_distance(x,y,target.x,target.y)
            if(stick_wait!=0) {
                if(stick_wait>0) stick_wait=max(0,stick_wait-timescale)
                var _orbit=_dir+180+5*sign(angle_difference(direction,_dir+180))
                motion_add(point_direction(x,y,target.x+lengthdir_x(16,_orbit),target.y+lengthdir_y(16,_orbit))+orandom(60),timescale*timescale)
            } else {
                motion_add(_dir+orandom(60),timescale*timescale)
                if(_dis>640) { var _len=(_dis-640)/16*timescale; x+=lengthdir_x(_len,_dir); y+=lengthdir_y(_len,_dir); direction=_dir }
                if(_dis<=speed/max(timescale,0.000001) || place_meeting(x,y,target) || (target==creator && place_meeting(x,y,Portal))) {
                    var _fx=instance_create(x,y,Dust); /* NTTE DUST LIFETIME parrot-feather */ if(instance_exists(_fx)) {_fx.depth=depth-1 }
                    snd_play(sndFlyFire,2+random(0.2),0.25); snd_play(sndChickenThrow,1+orandom(0.3),0.25); snd_play(sndMoneyPileBreak,1+random(3),0.5)
                    if(target!=creator) {
                        stick=true; stickx=random(x-target.x)*scrNTTEFullValue(target,"right",1); sticky=random(y-target.y); image_angle=random(360); speed=0
                        var _was=!is_struct(scrNTTEFullValue(target,"ntte_charm",undefined)) || !target.ntte_charm.charmed
                        if(!variable_instance_exists(target,"ntte_charm") && scrNTTEFullValue(creator,"race",0)==NTTEFullRace.Parrot)
                            scrNTTEFullRaceStatAdd("race:parrot:spec",1)
                        var _charm=scrNTTEFullParrotCharm(target,true)
                        if(_was || _charm.time>=0 || _charm.feather) { _charm.time=max(0,_charm.time+stick_time); _charm.index=index; _charm.feather=true }
                    } else {
                        if(variable_instance_exists(creator,"feather_ammo")) creator.feather_ammo=min(creator.feather_ammo+1,creator.feather_ammo_max)
                        instance_destroy(id,false); return;
                    }
                }
            }
        }
    } else if(instance_exists(creator)) {
        if(stick) { stick=false; motion_add(random(360),4*timescale) }
        if(index>=0 && KeyCont.hold_spec[index]) {
            var _best=infinity,_self=id
            with(enemy) if(size<6 && mask_index!=mskNone) {
                var _dis=point_distance(x,y,_self.x,_self.y)
                if(_dis<_best) { _best=_dis; _self.target=id }
            }
        }
        if(!instance_exists(target)) target=creator
    } else stick_time=0
    image_angle=direction+135
}
function scrNTTEFullParrotFeatherEndStep() {
    if(stick && instance_exists(target)) {
        x=target.x+stickx*image_xscale*scrNTTEFullValue(target,"right",1)
        y=target.y+sticky*image_yscale-abs(scrNTTEFullValue(target,"z",0))
    } else {
        visible=true
        if(stick_wait==0 || position_meeting(x,y+8,Wall) || !position_meeting(x,y+8,Floor)) depth=-8
        else if(depth< -6) depth=-1
    }
}
function scrNTTEFullParrotFeatherDraw() {
    var _blend=image_blend
    if(stick && stick_time<stick_time_max) image_blend=merge_color(image_blend,image_blend_fade,1-stick_time/stick_time_max)
    draw_self(); image_blend=_blend
}
function scrNTTEFullParrotFeatherDestroy() {
    var _f=instance_create(x,y,Feather)
    _f.sprite_index=sprite_index; _f.image_angle=image_angle; _f.image_blend=image_blend_fade; _f.depth=0
    if(position_meeting(x,y+8,Wall) || (depth< -6 && !position_meeting(x,y+8,Floor))) { _f.depth=-7; _f.fall=random_range(20,30) }
    snd_play(sndMoneyPileBreak,1.5+random(1.5),random(0.4))
    var _charm=scrNTTEFullValue(target,"ntte_charm",undefined)
    if(is_struct(_charm)) snd_play(sndAssassinPretend,1.5+random(1.5),stick_time_max/max(stick_time_max,_charm.time))
}
function scrNTTEFullParrotFeatherCleanup() {
    // All stuck feathers deliberately share one group array. Removing self
    // from that shared array can also mutate this instance's stick_list,
    // including the index currently being visited. Snapshot the peers and
    // hold each peer id before mutating; never dereference stick_list[i]
    // after array_delete changed its bounds.
    var _self=id,_peers=scrNTTEFullArrayCopy(stick_list)
    for(var _i=0;_i<array_length(_peers);++_i) {
        var _peer=_peers[_i]
        if(!instance_exists(_peer)) continue
        var _list=_peer.stick_list,_index=array_get_index(_list,_self)
        if(_index>=0) { array_delete(_list,_index,1); _peer.stick_list=_list }
    }
}
