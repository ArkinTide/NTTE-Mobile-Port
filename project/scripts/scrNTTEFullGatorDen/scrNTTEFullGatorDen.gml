// teevents1349..1652. Occupants and their table form one sleeping group.
function scrNTTEFullGatorDenSetup() { inst=[] }
// Original NTT Table.Create (0xACD7A0), reconstructed from its variable table.
function scrNTTEFullOriginalTableCreate() {
    max_hp=1; size=1; dir=choose(1,2,3)
    switch(dir) {
        case 1:spr_idle=sprTable1; spr_hurt=sprTable1Hurt; spr_dead=sprTable1Dead; break
        case 2:spr_idle=sprTable2; spr_hurt=sprTable2Hurt; spr_dead=sprTable2Dead; break
        case 3:spr_idle=sprFallenChair; spr_hurt=sprFallenChairHurt; spr_dead=sprFallenChairDead; break
    }
    sprite_index=spr_idle; mask_index=-1
}
function scrNTTEFullWallDecalSprite(_area) {
    switch(_area) {
        case area_campfire:return sprNightBones
        case area_desert:return sprBones
        case area_sewers:return sprSewerDecal
        case area_scrapyards:return sprScrapDecal
        case area_caves:return sprCaveDecal
        case area_city:return sprIceDecal
        case area_oasis:return sprCoral
        case area_pizza_sewers:return sprPizzaSewerDecal
        case area_cursed_caves:return sprInvCaveDecal
        case area_jungle:return sprJungleDecal
    }
    switch(scrNTTEFullAreaKey(_area)) {
        case "oasis":return sprCoral
        case "pizza":return sprPizzaSewerDecal
        case "lair":return scrNTTERefSprite("WallDecalLair")
        case "red":return scrNTTERefSprite("WallDecalRed")
    }
    return -1
}
function scrNTTEFullFloorBones(_floors,_num,_chance=1,_linked=false) {
    var _out=[],_all=scrNTTEFullInstances(_floors),_sprite=scrNTTEFullWallDecalSprite(GameCont.area)
    if (!sprite_exists(_sprite)) return _out
    for(var _i=0;_i<array_length(_all);++_i) with (_all[_i]) {
        if (!collision_rectangle(bbox_left-16,bbox_top,bbox_right+15,bbox_bottom-1,Floor,false,true)) {
            for(var _y=bbox_top;_y<bbox_bottom;_y+=32/_num) {
                var _create=true
                for(var _side=0;_side<=1;++_side) {
                    if (_side==0 || !_linked) _create=random(1)<_chance
                    if (_create) {
                        var _decal=instance_create(lerp(bbox_left,bbox_right,_side),_y,Bones)
                        _decal.sprite_index=_sprite; _decal.image_index=irandom(_decal.image_number-1); _decal.image_xscale=_side>0.5 ? -1:1
                        array_push(_out,_decal)
                    }
                }
            }
        }
    }
    return _out
}
function scrNTTEFullGatorDenTable(_x,_y,_inst) {
    var _table=instance_create(_x,_y,NTTEFullOriginalTable)
    with (_table) {
        spr_idle=sprTable1; spr_hurt=sprTable1Hurt; spr_dead=sprTable1Dead; spr_shadow=shd32; max_hp=5; hp=max_hp
        scrNTTEFullLairCreate(x,y,"SewerRug")
        with (scrNTTEFullLairCreate(x,y-30,"CatLight")) image_xscale*=1.1
        if (random(3)<1) { spr_idle=sprTable2; spr_hurt=sprTable2Hurt; spr_dead=sprTable2Dead }
        else if (random(2)<1) with (instance_create(x,y-10,Corpse)) {
            sprite_index=sprBanditDead; image_xscale=choose(-1,1); mask_index=mskBandit; size=1; other.depth=depth
        }
        else with (instance_create(x,y-9,MoneyPile)) { x=xstart; y=ystart; depth=other.depth-1 }
        array_push(_inst,id)
        for(var _side=-1;_side<=1;_side+=2) {
            var _dir=180*(_side<0)-20
            repeat(2) {
                var _object=choose(Gator,Gator,GatorSmoke,GatorSmoke,NTTEBabyGator,NTTEBabyGator,NTTEBabyGator,BuffGator,BuffGator,NTTEBoneGator,NTTEAlbinoGator)
                with (instance_create(x+orandom(2)+lengthdir_x(28,_dir),y-random(4)+lengthdir_y(28,_dir),_object)) {
                    x=xstart; y=ystart; image_index=irandom(image_number-1)
                    scrNTTESewerLook(_dir+180)
                    if (random(3)<2) gunangle=90+random_range(30,50)*right
                    if (_object==GatorSmoke) image_speed=0
                    else if (_object==NTTEBabyGator && random(2)<1) with (scrNTTEFullMergedNativeCopy(false)) {
                        var _off=orandom(30)
                        x+=lengthdir_x(16,_dir+_off); y+=lengthdir_y(16,_dir+_off); right*=choose(-1,1)
                        gunangle=90+angle_difference(90,gunangle)*right+orandom(20)
                        ntte_full_den_hold=true; array_push(_inst,id)
                    }
                    ntte_full_den_hold=true; array_push(_inst,id)
                }
                _dir+=40
            }
        }
    }
    return _inst
}
function scrNTTEFullGatorDenCreate() {
    var _inst=inst,_floors=array_shuffle(scrNTTEFullInstances(Floor,true)),_done=false
    for(var _i=0;_i<array_length(_floors) && !_done;++_i) with (_floors[_i]) if (!place_meeting(x,y,Wall)) {
        var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2,_w=160,_h=128,_angle=90*irandom(3)
        for(var _dir=_angle;_dir<_angle+360 && !_done;_dir+=90) if (!place_meeting(x+lengthdir_x(32,_dir),y+lengthdir_y(32,_dir),Floor)) {
            for(var _dis=32+choose(32,64,96);_dis>=32;_dis-=32) {
                var _hx=lengthdir_x(_dis-32,_dir+180),_hy=lengthdir_y(_dis-32,_dir+180)
                var _cx=_fx+lengthdir_x(16+_dis+_w/2,_dir),_cy=_fy+lengthdir_y(16+_dis+_h/2,_dir)
                if (!collision_rectangle(_cx-_w/2-32+min(0,_hx),_cy-_h/2-32+min(0,_hy),_cx+_w/2+32+max(0,_hx)-1,_cy+_h/2+32+max(0,_hy)-1,Floor,false,false)) {
                    scrNTTEFullFloorFill(_cx,_cy,_w/32,_h/32)
                    scrNTTEFullFloorSetStyle(true,scrNTTEFullAreaId("lair"))
                    for(var _l=32;_l<=_dis;_l+=32) {
                        var _floor=scrNTTEFullFloorSet(_fx-16+lengthdir_x(_l,_dir),_fy-16+lengthdir_y(_l,_dir),true)
                        with (_floor) {
                            if (_l>_dis-32) scrNTTEFullCatDoorPair(x+16,y+16,_dir)
                            if (_l<=32) scrNTTEFullCatDoorPair(x+16,y+16,_dir+180)
                            else scrNTTEFullFloorBones(id,1,1/10,true)
                        }
                    }
                    scrNTTEFullFloorResetStyle()
                    other.x=_cx+lengthdir_x(12,_dir+180); other.y=_cy+lengthdir_y(12,_dir+180)
                    _inst=scrNTTEFullGatorDenTable(other.x,other.y,_inst)
                    var _px=choose(_cx-_w/2+16,_cx+_w/2-16),_py=choose(_cy-_h/2+16,_cy+_h/2-16),_obj=MoneyPile
                    if (abs(angle_difference(_dir+180,point_direction(_cx,_cy,_px,_py)))<90) _obj=NTTEFullOriginalTable
                    with (instance_create(_px,_py,_obj)) if (_obj==NTTEFullOriginalTable) { spr_idle=sprFallenChair; spr_hurt=sprFallenChairHurt; spr_dead=sprFallenChairDead }
                    var _num=3+scr_skill_get(mut_open_mind)
                    for(var _j=0;_j<max(0,_num);++_j) {
                        var _side=_num>1 ? -1+2*_j/(_num-1):0,_ox=abs(_side)<1 ? -24:-32,_oy=-32
                        var _lx=_cx+lengthdir_x(_w/2+_ox,_dir)+lengthdir_x(_w/2+_oy,_dir-90)*_side+orandom(2)
                        var _ly=_cy+lengthdir_y(_h/2+_ox,_dir)+lengthdir_y(_h/2+_oy,_dir-90)*_side+orandom(2)
                        var _object=choose(choose(WeaponChest,AmmoChest),AmmoChestMystery,MoneyPile)
                        if (abs(_side)<1) _object=choose("CatChest","BatChest","RatChest")
                        with (scrNTTEFullLairChestCreate(_lx,_ly,_object,true)) { x=xstart; y=ystart }
                        with (scrNTTEFullLairCreate(_lx,_ly-28,"CatLight")) { sprite_index=scrNTTERefSprite("CatLightThin"); image_xscale*=1.2 }
                    }
                    _done=true; break
                }
            }
        }
        if (_done) break
    }
    inst=_inst
    // Hold the new occupants before their first native Step can run.
    scrNTTEFullGatorDenStep()
    return _done
}
function scrNTTEFullGatorDenStep() {
    if (lockstep_stop || array_length(inst)==0) return;
    var _wake=false
    for(var _i=0;_i<array_length(inst);++_i) {
        var _v=inst[_i]
        if (instance_exists(_v) && _v.sprite_index!=_v.spr_hurt) {
            with (_v) if (distance_to_object(Player)>80) {
                alarm[1]=-1; ntte_full_den_hold=true
                if (instance_is(id,GatorSmoke)) timer=0
            }
            else _wake=true
        }
        else _wake=true
    }
    if (!_wake) return;
    var _alerted=false
    for(var _i=0;_i<array_length(inst);++_i) if (instance_exists(inst[_i])) with (inst[_i]) {
        ntte_full_den_hold=false
        if (instance_is(id,GatorSmoke)) {
            var _x=x,_y=y
            with (instance_create(_x,_y,Shell)) sprite_index=sprCigarette
            instance_change(Gator,true); x=_x; y=_y
        }
        if (instance_is(id,enemy)) {
            if (alarm[1]<0) alarm[1]=25+random(10)
            scrTarget()
            if (instance_exists(target) && scrNTTEFullWorldTargetVisible() && hp>0) {
                _alerted=true
                var _ready=sign(right)==sign(lengthdir_x(1,gunangle))
                scrNTTESewerLook(point_direction(x,y,target.x,target.y)+orandom(20))
                if (_ready) { alarm[1]/=2; walk=random(15); direction=gunangle+180+orandom(30) }
                else {
                    wkick=-4; instance_create(x+lengthdir_x(4,gunangle),y+lengthdir_y(4,gunangle),WepSwap)
                    if (scrNTTEFullValue(id,"spr_weap",-1)!=scrNTTERefSprite("AlbinoGatorWeap")) with (instance_create(x,y,Shell)) { sprite_index=sprShotShell; motion_set(other.gunangle+90*other.right,(2+random(2))*timescale) }
                }
            }
            if (variable_instance_exists(id,"ntte_gator_timer")) ntte_gator_timer=alarm[1]
            if (variable_instance_exists(id,"ntte_albino_timer")) ntte_albino_timer=alarm[1]
        }
    }
    if (_alerted) {
        var _a=scrNTTEAlertCreate(x,y-16,scrNTTERefSprite("GatorAlert"))
        _a.vspeed=-2*timescale; _a.snd_flash=sndBuffGatorHit
    }
    else for(var _i=0;_i<array_length(inst);++_i) if (instance_exists(inst[_i])) with (inst[_i]) if (instance_is(id,enemy) && hp>0) {
        var _a=scrNTTEAlertCreate(x,y,-1,id)
        _a.alert_sprite=scrNTTERefSprite("AlertIndicatorMystery"); _a.alert_color=c_yellow; _a.target_y-=2; _a.alert_hold=irandom_range(50,70); _a.blink=irandom_range(6,15)
    }
    inst=[]
}
function scrNTTEFullGatorDenSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_sewers; scrNTTEFullFloorResetStyle(); scrNTTEFullFloorResetAlign()
    scrNTTEFullFloorFill(45016,45016,7)
    var _event=instance_create(45016,45016,NTTEFullWorldEvent),_done=false
    with (_event) { scrNTTEFullGatorDenSetup(); _done=scrNTTEFullGatorDenCreate() }
    assert(_done && array_length(_event.inst)>=5 && array_length(_event.inst)<=9,"GatorDen failed source 5x4 distant room/table/four gator seats and optional baby copies")
    var _table=_event.inst[0]
    assert(instance_is(_table,NTTEFullOriginalTable) && _table.max_hp==5 && _table.hp==5,"GatorDen omitted actual five-HP source Table")
    var _doors=0,_sleepers=0
    with (NTTEFullCatDoor) if (array_get_index(_before,id)<0) _doors++
    for(var _i=1;_i<array_length(_event.inst);++_i) {
        var _v=_event.inst[_i]
        // Epsilon's smoking Gator is a prop until instance_change(Gator,true).
        assert((instance_is(_v,enemy) || instance_is(_v,GatorSmoke)) && _v.ntte_full_den_hold && _v.alarm[1]==-1,"GatorDen occupant was not held before native AI")
        _sleepers++
    }
    assert(_doors==4 && _sleepers>=4,"GatorDen source two door pairs/four occupants changed")
    _table.sprite_index=_table.spr_hurt
    with (_event) scrNTTEFullGatorDenStep()
    assert(array_length(_event.inst)==0,"GatorDen did not release its whole group when source table was disturbed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD GATOR DEN SOURCE OUTWARD5x4 ROOM/FOUR SEATS+BABY COPIES/REAL TABLE/FLOOR STYLE/TWO DOOR PAIRS/CHEST LIGHTS/SLEEP AND GROUP RELEASE OK")
}
