// Original tegeneral193..798. Invisible controller owns a real Bones decal.
function scrNTTEFullBigDecalKey(_area) {
    switch(_area) {
        case area_desert:return "area_desert";
        case area_sewers:return "area_sewers";
        case area_scrapyards:return "area_scrapyards";
        case area_caves:return "area_caves";
        case area_cursed_caves:return "area_cursed_caves";
        case area_palace:return "area_palace";
        case area_oasis:return "area_oasis";
        case area_pizza_sewers:return "area_pizza_sewers";
    }
    switch(scrNTTEFullAreaKey(_area)) {
        case "trench":return "trench";
        case "oasis":return "area_oasis";
        case "pizza":return "area_pizza_sewers";
    }
    return "";
}
function scrNTTEFullBigDecalCreate() {
    visible=false;target=noone;area=GameCont.area;ntte_decal_initialized=false
}
// telib.fx adds motion to the real particle's constructor velocity and updates
// its facing when the original helper would; it does not reset initial motion.
function scrNTTEFullBigDecalFx(_x,_y,_motion,_object) {
    var _fx=instance_create(_x,_y,_object)
    with(_fx) {
        var _face=image_angle==direction || (speed==0 && (object_index==AcidStreak || object_index==BloodStreak))
        motion_add(random(360),_motion*timescale)
        if(_face) image_angle=direction
    }
    return _fx;
}
function scrNTTEFullBigDecalCustomOverlap(_who) {
    var _found=false
    with(all) if(id!=_who && string_pos("NTTE",object_get_name(object_index))==1) {
        if(place_meeting(x,y,_who)) {_found=true;break}
    }
    return _found;
}
function scrNTTEFullBigDecalSpawn(_x,_y) {
    var _key=scrNTTEFullBigDecalKey(GameCont.area)
    if(_key=="") return noone;
    var _self=instance_create(_x,_y,NTTEFullBigDecal)
    with(_self) {
        sprite_index=scrNTTERefSprite("BigTopDecal."+_key);image_xscale=choose(-1,1);image_speed=0.4*timescale
        depth=object_get_depth(SubTopCont)-1
        var _mask_key=(_key=="area_cursed_caves")?"area_caves":_key
        if(array_get_index(["area_desert","area_caves","area_palace","trench"],_mask_key)<0) _mask_key="area_desert"
        mask_index=scrNTTERefSprite("msk.BigTopDecal."+_mask_key)
        if(area==area_desert && instance_exists(scrNTTEFullWorldEventGet("ScorpionCity"))) sprite_index=scrNTTERefSprite("BigTopDecalScorpion")
        var _xo=(sprite_get_xoffset(mask_index)-(sprite_get_bbox_left(mask_index)+sprite_get_bbox_right(mask_index)+1)/2)*image_xscale,
            _yo=(sprite_get_yoffset(mask_index)-(sprite_get_bbox_top(mask_index)+sprite_get_bbox_bottom(mask_index)+1)/2)*image_yscale,
            _dir=random(360),_tries=1000,_near=scrNTTEFullNearestBBox(x,y,Floor)
        if(instance_exists(_near)) _dir=point_direction((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,x,y)
        x=round(_x/16)*16+_xo;y=round(_y/16)*16+_yo
        while(_tries-->0 && (place_meeting(x,y,Floor) || place_meeting(x,y,Bones) || place_meeting(x,y,TopPot)
            || place_meeting(x,y,PortalClear) || scrNTTEFullBigDecalCustomOverlap(id))) {
            x=round((x-_xo+lengthdir_x(24,_dir))/16)*16+_xo
            y=round((y-_yo+lengthdir_y(24,_dir))/16)*16+_yo
        }
        for(var _ox=-64;_ox<64;_ox+=32) for(var _oy=-48;_oy<64;_oy+=32) {
            var _min=-1
            with(all) _min=max(_min,real(id))
            instance_create(round((x+_ox)/16)*16,round((y+_oy)/16)*16,Top)
            with(TopSmall) if(real(id)>_min) {
                if(random(2)<1 && !point_in_rectangle((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,
                    other.bbox_left-16,other.bbox_top-16,other.bbox_right+16,other.bbox_bottom+64)) instance_destroy()
            }
        }
        var _num=irandom(4),_ang=random(360)
        // _num==0 deliberately executes the first iteration then advances by
        // infinity in original floating GML. Preserve that single decal.
        var _step=_num==0?infinity:360/_num
        for(var _a=_ang;_a<_ang+360;_a+=_step) {
            var _dis=24+random(12),_d=_a+orandom(30),_decal=scrNTTEFullAreaTopDecalCreate(x,y)
            if(instance_exists(_decal)) with(_decal) {
                x=xstart+lengthdir_x(_dis*1.5,_d);y=ystart+lengthdir_y(_dis,_d)
                var _move=4096
                while(place_meeting(x,y,other)) {
                    x+=lengthdir_x(8,_d);y+=lengthdir_y(8,_d)
                    if(--_move<=0) throw "BigDecal source surrounding decal cannot leave its mask";
                }
                if(sprite_index==sprTopDecalScrapyard) image_index=choose(1,2)
                if(place_meeting(x,y,Floor)) instance_destroy(id,false)
            }
        }
        if(area==area_scrapyards) {
            var _ang=random(360)
            for(var _a=_ang;_a<_ang+360;_a+=120) scrNTTEFullTopCreate(x+lengthdir_x(8*random_range(1,2.5),_a),y+lengthdir_y(8,_a)-12,NTTEFullTopRaven,0,0)
        }
        if(area==area_caves || area==area_cursed_caves) {
            var _all=scrNTTEFullInstances(Floor),_candidates=[]
            for(var _i=0;_i<array_length(_all);++_i) if(_all[_i].bbox_top<=y+32 && _all[_i].bbox_bottom-1>=y-16) array_push(_candidates,_all[_i])
            var _near=scrNTTEFullWorldNearestRectBBox(x,y,x,y,_candidates)
            if(instance_exists(_near)) {
                var _fx=(_near.bbox_left+_near.bbox_right)/2
                if(_fx!=x) image_xscale=-sign(_fx-x)
            }
        }
        ntte_decal_initialized=true;scrNTTEFullBigDecalStep()
    }
    return instance_exists(_self)?_self:noone;
}
function scrNTTEFullBigDecalStep() {
    if(lockstep_stop || !ntte_decal_initialized) return;
    if(!instance_exists(target)) {
        if(!place_meeting(x,y,Floor)) {
            target=instance_create(x,y,Bones)
            with(target) {
                name="NTTEBigDecal";mask_index=other.mask_index;sprite_index=other.sprite_index
                image_index=other.image_index;image_speed=other.image_speed
                image_xscale=other.image_xscale;image_yscale=other.image_yscale;image_angle=other.image_angle
                image_blend=other.image_blend;image_alpha=other.image_alpha
                var _self=id,_all=scrNTTEFullInstances([TopPot,Bones])
                for(var _i=0;_i<array_length(_all);++_i) if(_all[_i]!=_self && instance_exists(_all[_i])) with(_all[_i])
                    if(place_meeting(x,y,_self)) instance_destroy(id,false)
            }
        }
        if(!instance_exists(target)) instance_destroy()
    }
    else {
        x=target.x;y=target.y
        if(scrNTTEFullAreaKey(area)=="trench") {
            var _offsets=[[2,-46],[15,-24],[1,-32],[-19,-15],[-12,-7],[11,-4],[24,-14]]
            for(var _i=0;_i<7;++_i) if(random(8)<timescale) {
                var _o=_offsets[_i],_bubble=instance_create(target.x+_o[0]*target.image_xscale,target.y+_o[1]*target.image_yscale,Bubble)
                with(_bubble) {motion_set(90+orandom(5),random_range(4,7)*timescale);friction=0.2*timescale*timescale}
            }
        }
    }
}
function scrNTTEFullBigDecalEggDepthStep() {
    var _all=ntte_decal_egg_depth
    for(var _i=0;_i<array_length(_all);++_i) {
        var _row=_all[_i]
        if(instance_exists(_row[0]) && _row[0].depth==_row[1]+1) _row[0].depth=_row[1]
    }
    instance_destroy()
}
function scrNTTEFullBigDecalFeathers(_sprite,_web) {
    repeat(irandom_range(12,14)) {
        var _feather=instance_create(x+orandom(_web?32:24),y-random(_web?32:24),Feather)
        with(_feather) {
            motion_add(point_direction(other.x,other.y,x,y),random(6)*timescale)
            sprite_index=_sprite;image_index=irandom(irandom(image_number-1));image_speed=0;depth=-1
            if(_web) fall*=random(2)
            else fall/=1+image_index/8
        }
    }
}
function scrNTTEFullBigDecalDeath() {
    if(instance_exists(target)) {x=target.x;y=target.y;instance_destroy(target)}
    if(!ntte_decal_initialized || !place_meeting(x,y,Floor)) return;
    y-=8;scrNTTEFullWorldWallClear(id);sleep(100);scrNTTEFullTrenchShake(x,y,50)
    repeat(irandom_range(9,18)) with(instance_create(x,y,Debris)) {
        speed=random_range(6,12)*timescale
        if(!place_meeting(x+hspeed/timescale,y+vspeed/timescale,Floor)) speed/=3
    }
    var _key=scrNTTEFullBigDecalKey(area)
    switch(_key) {
        case "area_desert":
            if(sprite_index==scrNTTERefSprite("BigTopDecalScorpion")) scrNTTEFullBigDecalScorpionDeath()
            else {
                repeat(irandom_range(2,3)) {
                    var _pickup=scrWeaponPickupCreate(x,y,"crabbone")
                    with(_pickup) {
                        motion_set(random(360),random_range(3,6)*timescale)
                        repeat(3) scrNTTEFullBigDecalFx(x,y,2,Smoke)
                    }
                }
                snd_play(sndWallBreakBrick,0.5+random(0.2),2.5)
            }
            break
        case "area_sewers":
            var _ang=random(360),_num=irandom_range(3,5),_sort=[]
            for(var _a=_ang;_a<_ang+360;_a+=360/_num) {
                var _dis=random_range(8,12),_egg=instance_create(x+lengthdir_x(_dis*random_range(1,1.5),_a),y+lengthdir_y(_dis,_a)+4,FrogEgg)
                with(_egg) {
                    alarm[0]=irandom_range(20,60);nexthurt=current_frame+6
                    sprite_index=sprFrogEggSpawn;image_index=0;image_speed*=random_range(0.25,1)
                    repeat(2) with(scrNTTEFullBigDecalFx(x+orandom(4),y+orandom(4),1,AcidStreak)) {
                        image_speed*=random_range(0.5,1)
                    }
                }
                array_push(_sort,[_egg,_egg.y])
            }
            array_sort(_sort,function(_a,_b){return sign(_b[1]-_a[1]);})
            var _restore=[]
            for(var _i=0;_i<array_length(_sort);++_i) {var _egg=_sort[_i][0];array_push(_restore,[_egg,_egg.depth]);_egg.depth+=1}
            var _guard=instance_create(0,0,NTTEFullBigDecalEggDepth);_guard.ntte_decal_egg_depth=_restore
            snd_play(sndFrogExplode,0.6+random(0.2),5);snd_play(sndToxicBarrelGas,0.6+random(0.1),3.5)
            break
        case "area_scrapyards":
            scrNTTEFullBigDecalFeathers(scrNTTERefSprite("NestDebris"),false)
            snd_play(sndMoneyPileBreak,0.6+random(0.2),5.5);snd_play(sndWallBreakJungle,1.2+random(0.2),2.5)
            break
        case "area_caves":case "area_cursed_caves":
            y+=8;scrNTTEFullFloorSetStyle(1,area);scrNTTEFullFloorFill(x,y,2,1);scrNTTEFullFloorResetStyle()
            with(instance_create(x,y,PortalClear)) {image_xscale*=1.5;image_yscale*=1.2}
            repeat(irandom_range(2,3)) scrNTTEFullSystemsCreate(random(2)<1?"MinerBandit":"Spiderling",x+orandom(32),y+orandom(16)-8)
            repeat(irandom_range(3,4)) {
                // Epsilon's Crystal combines original CrystalProp/InvCrystal.
                var _prop=instance_create(x+orandom(32),y+orandom(16)-8,choose(Crystal,Cocoon))
                _prop.nexthurt=current_frame+6;scrNTTEFullWorldBudge(_prop,prop,16)
            }
            scrNTTEFullBigDecalFeathers(scrNTTERefSprite("PetSpiderWebBits"),true)
            snd_play(sndHitMetal,0.4+random(0.2),5);snd_play(sndPlantPotBreak,0.4+random(0.2),2.5);snd_play(sndWallBreakScrap,0.6+random(0.2),2.5)
            break
        case "area_palace":
            var _ang=random(360)
            for(var _a=_ang;_a<_ang+360;_a+=120) with(instance_create(x+lengthdir_x(12,_a),y+lengthdir_y(12,_a),GreenExplosion)) hitid=99
            repeat(16) {
                var _pickup=instance_create(x+orandom(8),y+orandom(8)+8,NTTEFullBackpackPickup)
                with(_pickup) {z=random(32);zspeed=random_range(4,8);target=instance_create(x,y,random(6)<1?BigRad:Rad);target.depth=-6}
            }
            snd_play(sndBigGeneratorBreak,0.8+orandom(0.1),1.5);snd_play(sndHitMetal,0.2+random(0.1),5)
            break
        case "area_pizza_sewers":
            repeat(irandom_range(4,6)) {
                instance_create(x+orandom(4),y+orandom(4),NTTEFullPizza)
                with(instance_create(x,y,NTTEFullWaterStreak)) {
                    speed=(1+random(3))*timescale;direction=random(360);image_angle=direction;image_blend=c_orange
                    image_speed*=random_range(0.4,1.25);depth=-3;mask_index=mskNone
                }
            }
            snd_play(sndPizzaBoxBreak,0.3+random(0.1),5);snd_play(sndWallBreakBrick,0.6+random(0.2),1.5)
            break
        case "area_oasis":
            y+=8;scrNTTEFullFloorSetStyle(1,area);scrNTTEFullFloorFill(x,y,2,1);scrNTTEFullFloorResetStyle()
            with(instance_create(x,y,PortalClear)) {image_xscale*=1.5;image_yscale*=1.2}
            repeat(4) {
                var _sx=x+orandom(24),_sy=y+orandom(16)-8
                if(random(100)<1) instance_create(_sx,_sy,Freak)
                else if(random(4)<1) instance_create(_sx,_sy,Crab)
                else if(random(2)<1) instance_create(_sx,_sy,BoneFish)
                else scrNTTEFullSystemsCreate("Puffer",_sx,_sy)
                var _prop=instance_create(_sx+orandom(4),_sy+orandom(4),choose(WaterPlant,WaterPlant,OasisBarrel))
                _prop.nexthurt=current_frame+30;scrNTTEFullWorldBudge(_prop,prop,24)
            }
            repeat(20) instance_create(x+orandom(24),y+orandom(24),Bubble)
            snd_play(sndHitMetal,0.5+orandom(0.2),2.5);snd_play(sndOasisPortal,2+orandom(0.2),4);snd_play(sndOasisExplosion,1+orandom(0.2),4)
            break
        case "trench":
            instance_create(x,y,NTTEFullBubbleExplosion);repeat(3) instance_create(x,y,NTTEFullBubbleExplosionSmall)
            repeat(150) scrNTTEFullBigDecalFx(x+orandom(32),y+orandom(24),random(2),Bubble)
            snd_play(sndOasisExplosion,0.6+random(0.2),3);snd_play(sndOasisExplosionSmall,0.4+random(0.2),6)
            break
    }
}
function scrNTTEFullBigDecalScorpionDeath() {
    var _hitid=[sprite_index,"GRAND SCORPION"],_clear=instance_create(x,y,PortalClear)
    with(_clear) {
        image_xscale*=1.5;image_yscale*=1.5
        with(Wall) if(place_meeting(x,y,other)) with(other) event_perform(ev_collision,Wall)
    }
    repeat(75) {
        var _dir=random(360),_spd=random_range(2,6)
        repeat(2) {
            var _bullet=scrNTTEFullMergedBasicProjectileCreate(x,y,EnemyBullet2,_dir,max(0.1,_spd--))
            _bullet.hitid=_hitid;_bullet.friction=-0.2*timescale*timescale
        }
    }
    var _flak=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullVenomFlak)
    _flak.hitid=_hitid;_flak.charging=false;_flak.alarm[0]=1;_flak.ntte_venom_left=1
    var _explosion=scrNTTEFullMergedBasicProjectileCreate(x,y,GreenExplosion)
    _explosion.hitid=_hitid;_explosion.alarm[0]=-1
    var _ang=random(360)
    for(var _a=_ang;_a<_ang+360;_a+=120) {
        var _dis=random_range(12,24),_ex=x+lengthdir_x(_dis,_a),_ey=y+lengthdir_y(_dis,_a)
        var _small=scrNTTEFullMergedExplosionCreate(_ex,_ey,true,true,false,false,0)
        _small.hitid=_hitid;scrNTTEFullBigDecalScorchGreen(_small.x,_small.y)
    }
    var _rads=scrNTTEFullRadDrop(x,y,50,0,0)
    for(var _i=0;_i<array_length(_rads);++_i) _rads[_i].speed+=0.4*timescale
    var _sprite=scrNTTERefSprite("BigTopDecalScorpionDebris")
    for(var _i=0;_i<sprite_get_number(_sprite);++_i) with(instance_create(x,y,Debris)) {
        sprite_index=_sprite;image_index=_i;image_xscale=choose(-1,1);depth=object_get_depth(Corpse);speed=random_range(10,14)*timescale
    }
    repeat(50) {
        var _fx=scrNTTEFullBigDecalFx(x,y,random(6),Dust)
        /* NTTE DUST LIFETIME grand-scorpion */ if(instance_exists(_fx)) {_fx.image_xscale=2+random(2);_fx.image_yscale=_fx.image_xscale;_fx.friction=_fx.speed*0.02*timescale }
    }
    snd_play(sndGoldScorpionDead,0.8,2);snd_play(sndBigMaggotDie,0.5+random(0.2),3);snd_play(sndExplosionCar,0.8+random(0.4),1.5)
}
// Original NTT9940 ScorchGreen.Create 00aa3ac0 first checks its actual mask
// against Floor (constant92), otherwise destroys itself; it then creates
// ScorchTop100. OBJT gives ScorchGreen and Scorch the SAME sprite660/depth7.
// Epsilon renders ScorchTop directly for each Scorch in BackCont.Draw.
function scrNTTEFullBigDecalScorchGreen(_x,_y) {
    var _scorch=instance_create(_x,_y,Scorch),_floor=false
    with(_scorch) _floor=place_meeting(x,y,Floor)
    if(!_floor) {instance_destroy(_scorch,false);return noone}
    return _scorch
}
