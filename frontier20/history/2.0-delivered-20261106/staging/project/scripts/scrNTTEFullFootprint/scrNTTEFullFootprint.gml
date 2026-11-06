// ntte.footprint_give and ntte_begin_step footprints; event ordering follows
// the original before native footstep advances its animation marker.
function scrNTTEFullFootprintGive(_time,_color,_alpha) {
    if(scrNTTEFullValue(id,"ntte_foot_time",-1)<_time) {
        ntte_foot_time=_time; ntte_foot_color=_color; ntte_foot_alpha=_alpha
        return true
    }
    return false
}
function scrNTTEFullFootprintInit() { global.ntte_full_footprint_give=scrNTTEFullFootprintGive }
function scrNTTEFullFootprintCreate() {
    sprite_index=sprBoltTrail; image_speed=0; image_alpha=0.5
    depth=5; mask_index=mskNone; persistent=false; friction=0.5*timescale*timescale
}
function scrNTTEFullFootprintStep() {
    if(lockstep_stop) return;
    image_alpha-=0.01*timescale
    if(image_alpha<0) { instance_destroy(); return; }
    direction=image_angle
    speed=0.5*timescale
    if(image_alpha<0.3) { image_xscale*=power(0.95,timescale); image_yscale*=power(0.95,timescale) }
}
function scrNTTEFullFootprintNativeKind(_race,_skin) {
    // Read-only original scrPlayerCreate 0060ac42..0060bd15:
    // Plant2, Robot4, VenuzB0, Venuz/Rebel3, all other native races1.
    if(_race==Race.Plant) return 2;
    if(_race==Race.Robot || _race==NTTEFullRace.Beetle) return 4;
    if(_race==Race.Venuz && _skin==SkinLetter.B) return 0;
    if(_race==Race.Venuz || _race==Race.Rebel) return 3;
    return 1;
}
function scrNTTEFullFootprintPlayerStep() {
    scrNTTEFullFootprintInit()
    if(!scrNTTEFullPlayerActive(id)) { if(variable_instance_exists(id,"ntte_foot_time")) ntte_foot_time=0; return; }
    var _mask=mask_index; mask_index=sprite_index
    // Epsilon draws source ScorchTop directly from Scorch in BackCont.Draw.
    if(position_meeting(x,bbox_bottom,Scorch)) scrNTTEFullFootprintGive(40,make_color_rgb(23,13,13),1.5)
    else if(!position_meeting(x,bbox_bottom,FloorMiddle)) {
        var _floor=instance_position(x,bbox_bottom,Floor)
        if(instance_exists(_floor)) {
            switch(_floor.sprite_index) {
                case sprFloor2B: scrNTTEFullFootprintGive(20,make_color_rgb(149,214,6),1.1); break;
                case sprFloor102B: scrNTTEFullFootprintGive(20,make_color_rgb(239,157,8),1.1); break;
                case sprFloor4B: case sprFloor104B: scrNTTEFullFootprintGive(20,make_color_rgb(234,217,237),1.1); break;
                default:
                    if((_floor.material==1 || _floor.material==4) && instance_exists(BackCont))
                        scrNTTEFullFootprintGive(timescale,BackCont.shadow_color,0.45)
                    break;
            }
        }
    }
    if(scrNTTEFullValue(id,"ntte_foot_time",0)>0) {
        if(sprite_index==spr_walk && speed/timescale>max(0,friction/(timescale*timescale)) && scrNTTEFullOptionGet("footprints")) {
            if(footextra==true) footextra=2
            if(round(image_index)==footstep+2 && roll==0) {
                var _grounded=false,_fx=x,_fy=bbox_bottom
                with(Floor) if(material!=0 && position_meeting(_fx,_fy,id)) _grounded=true
                if(footkind!=0 && _grounded) {
                    var _side=((footstep mod 2)<1 ? -1:1)*right
                    var _mark=instance_create(x+random_range(3,4)*_side,bbox_bottom+(race==Race.Plant ? -_side/right:1),NTTEFullFootprint)
                    _mark.image_blend=scrNTTEFullValue(id,"ntte_foot_color",c_white)
                    _mark.image_alpha=scrNTTEFullValue(id,"ntte_foot_alpha",1)
                    _mark.image_xscale=clamp(ntte_foot_time/15,1,4)
                    _mark.image_angle=direction+90*_side*(abs(hspeed)>abs(vspeed) ? sign(hspeed*right):sign(vspeed))
                    _mark.image_angle+=20*_side*(vspeed==0 ? 1:sign(vspeed*(hspeed==0 ? 1:sign(hspeed*right))))
                    ntte_foot_time-=4
                }
            }
        }
        ntte_foot_time-=timescale
    }
    mask_index=_mask
}
function scrNTTEFullFootprintTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed()
    var _p=instance_find(Player,0),_time=scrNTTEFullValue(_p,"ntte_foot_time",undefined)
    var _col=scrNTTEFullValue(_p,"ntte_foot_color",undefined),_alpha=scrNTTEFullValue(_p,"ntte_foot_alpha",undefined)
    try {
    scrNTTESmokeLog("FOOTPRINT TEST: actual player="+string(_p)+" grant/fade")
    _p.ntte_foot_time=0
    with(_p) assert(scrNTTEFullFootprintGive(40,c_red,1.1),"Footprint grant failed")
    with(_p) assert(!scrNTTEFullFootprintGive(20,c_blue,0.5),"Short footprint grant replaced longer original coating")
    assert(_p.ntte_foot_time==40 && _p.ntte_foot_color==c_red && _p.ntte_foot_alpha==1.1,"Footprint grant lost original color/alpha/time")
    var _mark=instance_create(10000,10000,NTTEFullFootprint)
    _mark.image_alpha=0.305; _mark.image_xscale=2; _mark.image_yscale=1; _mark.image_angle=37
    repeat(ceil(2/timescale)) with(_mark) scrNTTEFullFootprintStep()
    assert(_mark.image_alpha<0.3 && _mark.image_xscale<2 && _mark.image_yscale<1 && _mark.direction==37,"Footprint original fade/direction/shrink lifecycle failed")
    repeat(ceil(40/timescale)) if(instance_exists(_mark)) with(_mark) scrNTTEFullFootprintStep()
    assert(!instance_exists(_mark),"Faded footprints leaked permanent floor instances")
    scrNTTESmokeLog("FOOTPRINT TEST: coating/fade passed; actual active walking")
    assert(scrNTTEFullPlayerActive(_p),"Footprint native walking regression requires the actual active Player")
    with(_p) {
        x=99000;y=99000;visible=true;sprite_index=sprMutant1Walk;spr_walk=sprite_index
        mask_index=sprite_index;image_index=2;image_speed=0;image_xscale=1;image_yscale=1
        direction=0;speed=timescale;friction=0.5*timescale*timescale;roll=0;right=1;footstep=0;footextra=1
        footkind=1;race=Race.Horror;ntte_foot_time=40;ntte_foot_color=c_red;ntte_foot_alpha=1.1
    }
    var _ground=instance_create(_p.x-16,_p.bbox_bottom-16,Floor)
    _ground.sprite_index=sprFloor1;_ground.material=2
    // Native Floor.Create removes overlaps. Create independently, then move
    // into the overlap being tested rather than retaining a destroyed handle.
    var _empty=instance_create(_ground.x+64,_ground.y,Floor)
    _empty.x=_ground.x
    _empty.sprite_index=sprFloor1;_empty.material=0
    assert(position_meeting(_p.x,_p.bbox_bottom,_ground),"Native footprint floor fixture does not meet real sprite feet")
    var _count=instance_number(NTTEFullFootprint)
    scrNTTESmokeLog("FOOTPRINT TEST: real floors="+string([_ground,_empty])+" player="+string(_p))
    with(_p) scrNTTEFullFootprintPlayerStep()
    assert(instance_number(NTTEFullFootprint)==_count+1 && _p.footextra==2
        && abs(_p.ntte_foot_time-(36-timescale))<0.001,
        "Actual Horror walking/overlapping material0 floor/source extra marker failed")
    _p.footkind=0;_p.ntte_foot_time=40
    with(_p) scrNTTEFullFootprintPlayerStep()
    assert(instance_number(NTTEFullFootprint)==_count+1,"Footless native skin left footprints")
    _p.footkind=1;_p.speed=0.25*timescale;_p.ntte_foot_time=40
    with(_p) scrNTTEFullFootprintPlayerStep()
    assert(instance_number(NTTEFullFootprint)==_count+1,"Raw speed/friction footprint gate changed with frame rate")
    assert(scrNTTEFullFootprintNativeKind(Race.Venuz,SkinLetter.B)==0
        && scrNTTEFullFootprintNativeKind(Race.Venuz,SkinLetter.A)==3
        && scrNTTEFullFootprintNativeKind(Race.Plant,SkinLetter.A)==2
        && scrNTTEFullFootprintNativeKind(Race.Robot,SkinLetter.A)==4
        && scrNTTEFullFootprintNativeKind(Race.Horror,SkinLetter.A)==1,
        "Original native footkind mapping diverged")
    }
    catch(_error) {scrNTTESmokeLog("FOOTPRINT TEST actual error: "+json_stringify(_error));throw _error;}
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);random_set_seed(_seed)
    }
    _p.ntte_foot_time=_time; _p.ntte_foot_color=_col; _p.ntte_foot_alpha=_alpha
    scrNTTESmokeLog("SYSTEMS FOOTPRINT: longest coating/color/alpha preserved; original 0.01 logical fade, late shrink, angle, cleanup OK")
}
