// Native wall-top controller. Reference: tegeneral.TopObject and telib.top_create.
// Raven flight uses the original separate RavenFly controller state.
function scrNTTEFullNearestBBox(_x,_y,_object) {
    var _nearest=noone,_best=infinity;
    with(_object) {
        var _dx=max(bbox_left-_x,0,_x-bbox_right);
        var _dy=max(bbox_top-_y,0,_y-bbox_bottom);
        var _distance=_dx*_dx+_dy*_dy;
        if(_distance<_best) { _best=_distance; _nearest=id; }
    }
    return _nearest;
}

function scrNTTEFullTopCreateEvent() {
    spr_shadow=-1; spr_shadow_x=0; spr_shadow_y=0;
    mask_index=-1; mask_x=0; mask_y=8;
    target=noone; target_save={};
    z=8; zspeed=0; zfriction=0; maxspeed=0; grav=0.8;
    jump=random_range(3,4); jump_x=x; jump_y=y; jump_time=0;
    idle_time=0; idle_wait=[15,90]; idle_walk=[5,20]; idle_walk_chance=1/6;
    canmove=true; spawn_dis=0; spawn_dir=0; type=-1;
    wobble=0; wobble_num=0; override_mask=true; unstick=false;
    search_x1=x; search_x2=x; search_y1=y; search_y2=y;
    y+=z;
}

function scrNTTEFullTopSave(_key,_value) {
    variable_struct_set(target_save,_key,_value);
}

function scrNTTEFullTopCreate(_x,_y,_obj,_spawn_dir=-1,_spawn_dis=-1) {
    var _target=_obj,_gator_request=(is_string(_obj) && _obj=="Gator") || _obj==Gator,_buff_before=[];
    if(_gator_request) with(BuffGator) array_push(_buff_before,id);
    if(is_string(_obj)) _target=scrNTTEFullSystemsCreate(_obj,_x,_y);
    else if(object_exists(_obj)) _target=instance_create(_x,_y,_obj);
    if(!instance_exists(_target)) {
        // Gator's native Create may promote itself to BuffGator and destroy
        // the just-created Gator before this wrapper is attached.
        var _replacement=noone
        if(_gator_request) with(BuffGator) if(array_get_index(_buff_before,id)<0 && x==_x && y==_y) _replacement=id;
        if(instance_exists(_replacement)) _target=_replacement
        else return noone
    }
    var _existing=noone;
    with(NTTEFullTopObject) if(target==_target) _existing=id;
    if(instance_exists(_existing)) return _existing;
    with(_target) {
        x=_x; y=_y; xprevious=x; yprevious=y;
        if(instance_is(id,hitme) || instance_is(id,chestprop)) {
            with(PortalClear) if(id>_target && xstart==_target.xstart && ystart==_target.ystart) instance_destroy();
            with(PortalShock) if(id>_target && xstart==_target.xstart && ystart==_target.ystart) instance_destroy();
        }
    }
    var _wrapper=instance_create(_x,_y,NTTEFullTopObject);
    with(_wrapper) {
        target=_target; target.ntte_full_top_object=id;
        spawn_dis=random_range(16,48);
        if(instance_is(target,hitme)) {
            unstick=true;
            if(instance_is(target,enemy)) {
                type=enemy; idle_time=90+random(90);
                with(target) if(direction==0 && !variable_instance_exists(id,"walk") && variable_instance_exists(id,"right")) {
                    direction=random(360);
                    if(direction<90 || direction>270) right=1;
                    else if(direction>90 && direction<270) right=-1;
                }
            } else if(instance_is(target,prop)) {
                spawn_dis=random_range(8,16);
                if(target.team==team_none && target.size<=1 && target.max_hp<50) target_save.hp=0;
            }
        } else if(instance_is(target,chestprop) || instance_is(target,AmmoPickup) || instance_is(target,HPPickup) || instance_is(target,WepPickup)) {
            wobble=8; spawn_dis=8;
            if(!instance_is(target,chestprop)) jump=0;
            if(instance_is(target,chestprop) || instance_is(target,WepPickup)) unstick=true;
        } else if(instance_is(target,projectile)) {
            jump=0; type=projectile;
        } else if(instance_is(target,Explosion) || instance_is(target,MeatExplosion) || instance_is(target,PlasmaImpact)) {
            jump=0; grav=0; type=projectile; override_mask=false;
        } else if(instance_is(target,ReviveCircle) || instance_is(target,NecroReviveArea) || instance_is(target,RevivePopoFreak)) {
            jump=0; grav=0; override_mask=false;
        } else if(instance_is(target,IDPDSpawn) || instance_is(target,VanSpawn)) {
            jump=0; grav=0;
        }

        // Native counterparts of original object-specific setup.
        switch(target.object_index) {
            case JungleFly: jump=0; grav=random_range(0.1,0.3); idle_walk=[8,12]; idle_walk_chance=1/2; break;
            case MeleeBandit: idle_walk=[10,30]; idle_walk_chance=1/2; break;
            case Barrel: case GoldBarrel: case ToxicBarrel:
                jump*=1.5; spr_shadow=shd16; spr_shadow_y=4; wobble=8; break;
            case Cactus:
                with(target) {
                    var _variant=choose("","3");
                    spr_idle=asset_get_index("sprCactusB"+_variant);
                    spr_hurt=asset_get_index("sprCactusB"+_variant+"Hurt");
                    spr_dead=asset_get_index("sprCactusB"+_variant+"Dead");
                }
                spr_shadow=sprMine; spr_shadow_y=9; break;
            case BigFlower: case IceFlower: spr_shadow=target.spr_idle; spr_shadow_y=1; break;
            case Bush: case JungleAssassinHide: spr_shadow_y=-1; break;
            case Cocoon:
                spr_shadow=shd16; spr_shadow_y=2;
                if(_obj==Cocoon) with(Cocoon) if(id>_target) instance_destroy(id,false);
                break;
            case FireBaller: case SuperFireBaller: z+=random(8); jump=random(1); grav=random_range(0.1,0.2); break;
            case FrogEgg: grav=1.5; break;
            case BigGenerator:
                spr_shadow=scrNTTERefSprite(target.image_xscale<0 ? "shd.BigGeneratorR":"shd.BigGenerator");
                target_save.hp=0; break;
            case Hydrant:
                if(random(2)<1 || target.spr_idle==sprIcicle) with(target) {
                    spr_idle=sprIcicle; spr_hurt=sprIcicleHurt; spr_dead=sprIcicleDead;
                    snd_hurt=sndHitRock; snd_dead=sndIcicleBreak; spr_shadow=shd16; spr_shadow_y=3;
                }
                break;
            case MeleeFake: spr_shadow=sprMine; spr_shadow_y=7; break;
            case MoneyPile: spawn_dis=8; spr_shadow_y=-1; break;
            case Pillar: spr_shadow_y=-3; break;
            case Pipe: spr_shadow=sprMine; spr_shadow_y=7; break;
            case Server: spr_shadow=sprHydrant; spr_shadow_y=5; break;
            case SmallGenerator: spr_shadow=target.spr_idle; spr_shadow_y=1; target.image_xscale=1; break;
            case SnowMan: spr_shadow=sprNewsStand; spr_shadow_y=5; break;
            case Terminal: spr_shadow_y=1; break;
            case Tires: spr_shadow_y=-1; break;
        }
        if(instance_is(target,NTTEFullTopRaven) || instance_is(target,NTTEFullBoneRaven)) {
            type=RavenFly; jump=2; grav=0; canmove=true; spr_shadow_y--;
        }
        if(variable_instance_exists(target,"spr_shadow")) {
            if(spr_shadow==-1) spr_shadow=target.spr_shadow;
            if(spr_shadow_x==0) spr_shadow_x=target.spr_shadow_x;
            if(spr_shadow_y==0) spr_shadow_y=target.spr_shadow_y;
        }
        if(mask_index<0) {
            image_xscale=0.5; image_yscale=0.5;
            if(spr_shadow==-1) mask_index=target.sprite_index;
            else { mask_index=spr_shadow; mask_y=spr_shadow_y+(bbox_top-y)*(1-image_yscale); }
        }
        if(_spawn_dir>=0) spawn_dir=(_spawn_dir%360+360)%360;
        else {
            var _floor=scrNTTEFullNearestBBox(x,y,Floor);
            if(instance_exists(_floor)) spawn_dir=point_direction((_floor.bbox_left+_floor.bbox_right+1)/2,(_floor.bbox_top+_floor.bbox_bottom+1)/2,x,y);
        }
        if(_spawn_dis>=0) spawn_dis=_spawn_dis;
        if(spawn_dis>0) {
            var _iterations=0;
            while(true) {
                var _distance=max(spawn_dis-distance_to_object(Floor),spawn_dis+16-distance_to_object(PortalClear),
                    16-distance_to_object(Bones),8-distance_to_object(TopPot));
                // Original CustomObject distance includes other wall-top controllers.
                var _near=noone,_best=infinity;
                with(NTTEFullTopObject) if(id!=_wrapper) {
                    var _d=point_distance(x,y,_wrapper.x,_wrapper.y);
                    if(_d<_best) { _best=_d; _near=id; }
                }
                if(instance_exists(_near)) _distance=max(_distance,8-distance_to_object(_near));
                if(_distance<=0) break;
                _distance=max(1,_distance); x+=lengthdir_x(_distance,spawn_dir); y+=lengthdir_y(_distance,spawn_dir);
                if(++_iterations>4096) throw "NTTE wall-top spawn could not leave floors";
            }
        }
        x=round(x); y=round(y);
        if(instance_is(target,enemy)) {
            if(jump_time==0) {
                var _floor=instance_nearest(x-16,y-16,Floor);
                if(instance_exists(_floor)) with(_floor) _wrapper.jump_time=90+distance_to_object(Player)*(2+GameCont.loops);
            }
            if(!variable_instance_exists(target,"walk") && type!=RavenFly) canmove=false;
            var _alarms=[];
            for(var _i=0;_i<=10;++_i) { _alarms[_i]=target.alarm[_i]; target.alarm[_i]=-1; }
            target_save.ntte_full_saved_alarms=_alarms;
        }
        if(target.object_index==JungleFly) z+=random_range(4,16+distance_to_object(Floor)/2);
        with(target) { x=other.x; y=other.y-other.z; xprevious=x; yprevious=y; }
        if(instance_exists(GameCont) && GameCont.underwater) { jump/=6; grav/=4; }
        var _floor=instance_nearest(x-16,y-16,Floor);
        if(instance_exists(_floor) && !instance_exists(NothingSpiral)
            && !collision_line(x,y+8,(_floor.bbox_left+_floor.bbox_right+1)/2,(_floor.bbox_top+_floor.bbox_bottom+1)/2,Wall,false,false)
            && !collision_line(x,y+8,(_floor.bbox_left+_floor.bbox_right+1)/2,(_floor.bbox_top+_floor.bbox_bottom+1)/2,TopSmall,false,false)) {
            zspeed=jump; zfriction=grav;
        }
        target_save.depth=target.depth;
        target.depth=object_get_depth(SubTopCont)+min(-1,target.depth);
        scrNTTEFullTopEndStep();
    }
    return _wrapper;
}

function scrNTTEFullTopEndStep() {
    if(lockstep_stop) return;
    if(!instance_exists(target)) {
        if(target!=noone) target=noone;
        else instance_destroy();
        return;
    }
    if(zspeed!=0) z+=zspeed*timescale;
    if(zfriction!=0) zspeed-=zfriction*timescale;
    with(target) {
        if(x!=xprevious || y!=yprevious) {
            if(other.canmove) { other.x+=x-xprevious; other.y+=y-yprevious; }
            var _speed=point_distance(xprevious,yprevious,x,y);
            other.direction=point_direction(xprevious,yprevious,x,y);
            other.maxspeed=max(other.maxspeed,_speed/timescale);
        }
        x=other.x; y=other.y-other.z; xprevious=x; yprevious=y;
        var _mask=mask_index;
        mask_index=-1;
        other.search_x1=min(x-8,bbox_left); other.search_x2=max(x+8,bbox_right+1);
        other.search_y1=min(y-8,bbox_top); other.search_y2=max(y+8,bbox_bottom+1);
        mask_index=_mask;
        if(mask_index!=mskNone && other.override_mask) {
            other.target_save.mask_index=mask_index; mask_index=mskNone;
        }
        if(variable_instance_exists(id,"spr_shadow") && spr_shadow!=-1) {
            other.target_save.spr_shadow=spr_shadow; spr_shadow=-1;
        }
        if(variable_instance_exists(id,"canfly") && !canfly) { other.target_save.canfly=false; canfly=true; }
    }
    if(z<8) {
        if(place_meeting(x,y,Floor)) with(target) {
            mask_index=scrNTTEFullValue(other.target_save,"mask_index",mask_index);
            if(place_meeting(x,y,Wall)) mask_index=mskNone;
        }
        if(z>0) {
            if(!collision_rectangle(bbox_left+4,bbox_top+8-z,bbox_right-4,bbox_bottom-z,Wall,false,false))
                target.depth=min(-1,scrNTTEFullValue(target_save,"depth",0));
        } else {
            if(!instance_exists(NothingSpiral) || place_meeting(x,y,Floor)) instance_destroy();
            else {
                target.depth=max(12,target.depth);
                if(!scrNTTEFullPortalPointSeen(x,bbox_top-z,-1)) { instance_destroy(target,false); target=noone; instance_destroy(id,false); }
            }
        }
        return;
    }
    if(type==projectile) scrNTTEFullTopProjectileCollisions();
    if(!instance_exists(target)) return;
    if(type==RavenFly) { scrNTTEFullTopRavenFlight(); return; }
    if(type==enemy) {
        if(zfriction!=0) { canmove=false; return; }
        if(idle_time>0) idle_time-=timescale;
        else if(jump_time==0) with(target) {
            if(!variable_instance_exists(id,"walk") || walk<=0 || instance_is(id,Freak) || instance_is(id,ExploFreak)) {
                other.idle_time=10+random(20);
                var _aim=instance_exists(Player) ? instance_nearest(other.x,other.y,Player):instance_nearest(other.x-16,other.y-16,Floor);
                if(instance_exists(_aim)) direction=point_direction(other.x,other.y,_aim.x,_aim.y-8);
                speed+=timescale;
                if(variable_instance_exists(id,"walk")) walk=other.idle_time;
                if(variable_instance_exists(id,"gunangle")) gunangle=direction;
                if(variable_instance_exists(id,"right")) right=lengthdir_x(1,direction)>=0 ? 1:-1;
            }
        } else {
            idle_time=random_range(idle_wait[0],idle_wait[1]);
            var _aim=instance_nearest(x,y,Player);
            with(target) {
                if(instance_exists(_aim)) {
                    var _direction=point_direction(x,y,_aim.x,_aim.y-8)+orandom(5);
                    if(variable_instance_exists(id,"gunangle")) gunangle=_direction;
                    if(variable_instance_exists(id,"right")) {
                        if(!variable_instance_exists(id,"gunangle")) direction=_direction;
                        right=lengthdir_x(1,_direction)>=0 ? 1:-1;
                    }
                }
                if(random(1)<other.idle_walk_chance) {
                    direction=random(360);
                    if(variable_instance_exists(id,"walk")) walk=random_range(other.idle_walk[0],other.idle_walk[1]);
                }
                if(GameCont.area==area_city && random(3)<2) {
                    var _breath=instance_create(x,y,Breath);
                    _breath.image_xscale=sign(image_xscale)*scrNTTEFullValue(id,"right",1);
                    _breath.depth=depth-1;
                }
            }
            if(random(5)<1 && instance_exists(_aim) && point_distance(x,y,_aim.x,_aim.y)<160) jump_time=1;
        }
        if(jump_time>0) {
            jump_time-=timescale;
            if(jump_time<=0) {
                jump_time=0; canmove=true;
                with(NTTEFullTopObject) if(jump_time>0 && instance_exists(target)
                    && target.object_index==_top_target_object(other.id) && point_distance(x,y,other.x,other.y)<64) {
                    jump_time=0; idle_time=random_range(10,60); canmove=true;
                }
            }
        }
    }
}

// Original tegeneral.TopObject_end_step:4701..4870.
function scrNTTEFullTopRavenFlight() {
    var _wrapper=id;
    if(jump_time>0) {
        jump_time-=timescale;
        if(zspeed==0 && speed==0) {
            if(instance_exists(ScrapBoss)) jump_time=0;
            else if(distance_to_object(projectile)<16 || distance_to_object(BulletHit)<16) { jump_time=0; idle_time=random(3); }
        }
        if(jump_time<=0) {
            jump_time=0;
            if(zspeed==0) {
                with(NTTEFullTopObject) if(jump_time>0 && zspeed==0 && speed==0 && instance_exists(target)
                    && target.object_index==_wrapper.target.object_index && point_distance(x,y,_wrapper.x,_wrapper.y)<64) {
                    jump_time=0; idle_time=min(idle_time,random_range(10,60));
                }
            } else { speed=6*timescale; zspeed=0; }
        }
    }
    if(zspeed==0) {
        if(speed>0) {
            direction=point_direction(x,y,jump_x,jump_y);
            if(point_distance(x,y,jump_x,jump_y)<=speed) {
                speed=0; x=jump_x; y=jump_y; zspeed=-jump*max(1,(z-8)/20);
            }
        } else if(idle_time>0) idle_time-=timescale;
        else if(jump_time==0) { jump_x=x; jump_y=y; zspeed=jump; zfriction=grav; }
        else {
            idle_time=random_range(idle_wait[0],idle_wait[1]);
            with(target) {
                right*=choose(-1,1);
                var _player=instance_nearest(x,y,Player);
                if(instance_exists(_player)) right=_player.x>=x ? 1:-1;
            }
        }
    } else {
        canmove=false;
        if(zspeed>0) {
            with(target) {
                var _mask=mask_index; mask_index=scrNTTEFullValue(other.target_save,"mask_index",mask_index);
                if((other.jump_x==other.x && other.jump_y==other.y)
                    || !place_meeting(other.jump_x,other.jump_y,Floor) || place_meeting(other.jump_x,other.jump_y,Wall)) {
                    var _x=other.x,_y=other.y,_player=instance_nearest(_x,_y,Player);
                    if(instance_exists(_player)) {
                        right=_player.x>=_x ? 1:-1; _x=_player.x; _y=_player.y;
                        var _floors=ds_list_create();
                        collision_rectangle_list(_x-64,_y-64,_x+64,_y+64,Floor,false,false,_floors,false);
                        ds_list_shuffle(_floors);
                        for(var _i=0;_i<ds_list_size(_floors);++_i) {
                            var _f=_floors[| _i],_fx=(_f.bbox_left+_f.bbox_right+1)/2+orandom(4),_fy=(_f.bbox_top+_f.bbox_bottom+1)/2+orandom(4);
                            if(!place_meeting(_fx,_fy,Wall)) { _x=_fx; _y=_fy; break; }
                        }
                        ds_list_destroy(_floors);
                    } else {
                        var _distance=random_range(48,96),_direction=random(360);
                        var _f=scrNTTEFullNearestBBox(_x+lengthdir_x(_distance,_direction),_y+lengthdir_y(_distance,_direction),Floor);
                        if(instance_exists(_f)) { _x=(_f.bbox_left+_f.bbox_right+1)/2; _y=(_f.bbox_top+_f.bbox_bottom+1)/2; }
                    }
                    other.jump_x=_x; other.jump_y=_y;
                }
                mask_index=_mask;
            }
            if(speed>0) zspeed=0;
            else if(jump_time<=0 || jump_time>12) jump_time=12;
        }
    }
}

function _top_target_object(_wrapper) {
    return instance_exists(_wrapper.target) ? _wrapper.target.object_index:-1;
}

function scrNTTEFullTopDestroy() {
    if(!instance_exists(target)) return;
    with(target) {
        ntte_full_top_object=noone;
        x=other.x; y=other.y; xprevious=x; yprevious=y; xstart=x; ystart=y;
        if(other.wobble_num!=0) image_angle=0;
        var _names=variable_struct_get_names(other.target_save);
        for(var _i=0;_i<array_length(_names);++_i) {
            var _key=_names[_i],_value=variable_struct_get(other.target_save,_key);
            if(_key=="ntte_full_saved_alarms") {
                for(var _a=0;_a<array_length(_value);++_a) alarm[_a]=_value[_a];
            } else variable_instance_set(id,_key,_value);
        }
        if(other.unstick && place_meeting(x,y,Wall)) {
            if(place_meeting(x,y,Floor)) {
                if(other.maxspeed<=0 || !scrNTTEFullWorldBudge(id,Wall,24)) scrNTTEFullWorldWallClear(id);
            } else {
                var _floor=scrNTTEFullNearestBBox(x,y,Floor);
                if(instance_exists(_floor)) { x=(_floor.bbox_left+_floor.bbox_right+1)/2; y=(_floor.bbox_top+_floor.bbox_bottom+1)/2; }
            }
        }
        if(variable_instance_exists(id,"spr_shadow")) {
            var _number=abs(sprite_width/4)+irandom(2);
            for(var _angle=direction;_angle<direction+360;_angle+=360/_number) {
                var _dust=instance_create(x,y,Dust);
                with(_dust) motion_add(_angle+orandom(20),random_range(2,4)*timescale);
                /* NTTE DUST LIFETIME top-restore */ if(instance_exists(_dust)) {_dust.hspeed+=hspeed/2; _dust.vspeed+=vspeed/2; _dust.depth=max(_dust.depth,depth); }
            }
            scr_screenshake(6);
        }
        if(!instance_exists(GameCont) || !GameCont.underwater) {
            if(instance_is(id,hitme) || instance_is(id,CampChar)) snd_play(sndAssassinHit,1+orandom(0.3),abs(other.zspeed)/4);
            else if(instance_is(id,chestprop)) snd_play(sndWeaponChest,0.5+random(0.2),1.6);
        }
    }
}

function scrNTTEFullTopDraw() {
    if(spr_shadow<0 || !instance_exists(target) || !target.visible) return;
    if(place_meeting(x+spr_shadow_x,y+spr_shadow_y,Floor))
        draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y);
}

function scrNTTEFullTopProjectileCollisions() {
    var _projectile=target,_wrapper=id;
    with(_projectile) {
        var _saved_mask=mask_index;
        mask_index=scrNTTEFullValue(_wrapper.target_save,"mask_index",mask_index);
        with(NTTEFullTopObject) if(id!=_wrapper && instance_exists(target)
            && abs(x-_projectile.x)<=32 && abs(y-z-_projectile.y)<=32 && instance_is(target,hitme)) {
            var _victim=target;
            with(_victim) {
                var _victim_mask=mask_index;
                mask_index=scrNTTEFullValue(other.target_save,"mask_index",mask_index);
                if(place_meeting(x,y,_projectile)) with(_projectile) event_perform(ev_collision,hitme);
                if(instance_exists(_victim)) mask_index=_victim_mask;
            }
            if(!instance_exists(_projectile)) break;
        }
        if(instance_exists(_projectile)) mask_index=_saved_mask;
    }
}

// Original tegeneral.ntte_step: floor contact starts a jump; it is separate
// from TopObject_end_step, which integrates the z axis and follows the target.
function scrNTTEFullTopGlobalStep() {
    if(lockstep_stop || !instance_exists(NTTEFullTopObject)) return;
    var _idle=[];
    with(NTTEFullTopObject) if(zspeed==0 && zfriction==0 && speed==0 && instance_exists(target)) {
        if(place_meeting(x+mask_x,y+mask_y,Floor) && (jump!=0 || grav>0)) {
            if(wobble!=0 && place_meeting(x+mask_x,y+mask_y,Wall)) {
                var _west=position_meeting(bbox_left,y,Floor),_east=position_meeting(bbox_right,y,Floor);
                if(_west || _east) {
                    var _move=((_west-_east)-wobble_num)*0.1*timescale;
                    wobble_num+=_move;
                    target.image_angle+=wobble*_move+(wobble/16)*sin(current_frame/10)*wobble_num;
                }
            } else if(type!=RavenFly || !canmove || !position_meeting(x+mask_x,y+mask_y+8,Wall)) {
                jump_x=x; jump_y=y; zspeed=jump; zfriction=grav;
                if(type!=RavenFly) {
                if(unstick) with(target) {
                    var _min=5*max(speed/timescale,other.maxspeed),_max=4*_min,_dir=other.direction;
                    var _tx=x+lengthdir_x(_min,_dir),_ty=y+lengthdir_y(_min,_dir),_mask=mask_index;
                    mask_index=scrNTTEFullValue(other.target_save,"mask_index",mask_index);
                    if(!place_meeting(_tx,_ty,Floor) || place_meeting(_tx,_ty,Wall)) {
                        var _origin_x=x,_origin_y=y;
                        with(Floor) if(bbox_right>=_origin_x-_max-1 && bbox_left<=_origin_x+_max
                            && bbox_bottom>=_origin_y-_max-1 && bbox_top<=_origin_y+_max) {
                            var _left=bbox_left,_right=bbox_right+1,_top=bbox_top,_bottom=bbox_bottom+1;
                            with(other) for(var _fx=_left;_fx<_right;_fx+=8) for(var _fy=_top;_fy<_bottom;_fy+=8) {
                                if(!place_meeting(_fx,_fy,Wall)) {
                                    var _d=point_distance(x,y,_fx,_fy);
                                    if((_d<_max || (_d>_min && _max<_min)) && abs(angle_difference(point_direction(x,y,_fx,_fy),_dir))<90) {
                                        _max=_d; _tx=_fx; _ty=_fy;
                                    }
                                }
                            }
                        }
                    }
                    mask_index=_mask; other.jump_x=_tx; other.jump_y=_ty;
                }
                if(target.speed==0) zspeed*=2/3;
                direction=point_direction(x,y,jump_x,jump_y);
                var _d=point_distance(x,y,jump_x,jump_y);
                speed=min(maxspeed+scrNTTEFullValue(target,"friction",0)/timescale,
                    (sqrt(max(0,_d*_d*(2*zfriction*z+zspeed*zspeed)))-_d*zspeed)/(2*z))*timescale;
                if(speed>0) with(target) {
                    if(variable_instance_exists(id,"gunangle")) gunangle=other.direction;
                    if(variable_instance_exists(id,"right")) right=lengthdir_x(1,other.direction)>=0 ? 1:-1;
                }
                snd_play(sndAssassinAttack,1+orandom(0.4),abs(zspeed)/3);
                }
            }
        } else if(wobble_num!=0) {
            wobble_num-=wobble_num*0.5*timescale;
            target.image_angle-=target.image_angle*0.5*timescale;
            if(abs(wobble_num)<0.5) { wobble_num=0; target.image_angle=0; }
        }
        if(jump_time>60) array_push(_idle,id);
    }
    if(!instance_exists(NothingSpiral) && array_length(_idle)>0
        && instance_number(enemy)-array_length(_idle)<5*(1+GameCont.loops)*(1+(GameCont.crown==Crown.Blood))) {
        var _pick=_idle[irandom(array_length(_idle)-1)];
        _pick.jump_time=random_range(1,60);
    }
}

function scrNTTEFullTopSmoke() {
    var _asset_count=instance_number(Bandit),_from_asset=scrNTTEFullTopCreate(10080,10080,Bandit,0,0);
    assert(instance_exists(_from_asset) && instance_number(Bandit)==_asset_count+1
        && instance_is(_from_asset.target,Bandit),"TopCreate could not create a modern typed object asset");
    instance_destroy(_from_asset.target,false); instance_destroy(_from_asset,false);
    var _enemy=instance_create(10080,10080,Bandit),_mask=_enemy.mask_index,_shadow=_enemy.spr_shadow;
    _enemy.alarm[1]=17;
    var _count=instance_number(Bandit),_wrapper=scrNTTEFullTopCreate(_enemy.x,_enemy.y,_enemy,0,0);
    assert(instance_number(Bandit)==_count && _wrapper.target==_enemy,"TopCreate duplicated an existing target");
    assert(_enemy.mask_index==mskNone && _enemy.spr_shadow==-1 && _enemy.alarm[1]==-1,"Top wrapper failed to suspend ground mask/shadow/alarm");
    assert(scrNTTEFullTopCreate(_enemy.x,_enemy.y,_enemy,0,0)==_wrapper,"Duplicate wall-top wrapper created");
    _wrapper.z=0; _wrapper.zspeed=0; _wrapper.zfriction=0;
    with(_wrapper) scrNTTEFullTopEndStep();
    assert(!instance_exists(_wrapper) && _enemy.mask_index==_mask && _enemy.spr_shadow==_shadow && _enemy.alarm[1]==17,"Wall-top landing did not restore native state");
    instance_destroy(_enemy,false);
    _enemy=instance_create(10080,10080,Bandit); _enemy.team=team_enemy; _enemy.hp=100; _enemy.nexthurt=0;
    _wrapper=scrNTTEFullTopCreate(_enemy.x,_enemy.y,_enemy,0,0);
    _wrapper.z=8; _wrapper.zspeed=0; _wrapper.zfriction=0; _wrapper.x=10080; _wrapper.y=10080;
    with(_wrapper) scrNTTEFullTopEndStep();
    var _bullet=instance_create(_enemy.x,_enemy.y,Bullet1);
    _bullet.team=team_player; _bullet.creator=Player; _bullet.damage=3; _bullet.speed=0;
    var _bullet_wrapper=scrNTTEFullTopCreate(_bullet.x,_bullet.y,_bullet,0,0);
    _bullet_wrapper.x=_enemy.x; _bullet_wrapper.y=_enemy.y+8; _bullet_wrapper.z=8;
    with(_bullet_wrapper) scrNTTEFullTopEndStep();
    assert(_enemy.hp==97,"Wall-top projectile could not hit a wall-top enemy through saved masks");
    instance_destroy(projectile,false); instance_destroy(NTTEFullTopObject,false); instance_destroy(_enemy,false);
    scrNTTESmokeLog("PASS wall-top existing target identity, suspended state, landing restore and elevated damage @"+string(30/timescale));
}

// NTT GameCont.Step 0x995273..0x995417: decrement the request, then
// with(enemy) my_health=0. Let normal enemy steps perform their own death;
// immediate instance destruction would reorder drops and scripted deaths.
function scrNTTEFullWorldKillEnemiesStep() {
    var _remaining=scrNTTEFullValue(id,"killenemies",0);
    if(_remaining<=0) return;
    killenemies=max(0,_remaining-timescale);
    if(killenemies<=0) with(enemy) hp=0;
}
function scrNTTEFullTopDecalFactoryTests() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area;
    GameCont.area=area_cursed_caves;
    var _decal=scrNTTEFullAreaTopDecalCreate(16800,16800);
    assert(instance_exists(_decal) && instance_is(_decal,TopDecalCave) && _decal.sprite_index==sprTopDecalInvCave,
        "Cursed cave source factory must use the native combined TopDecalCave object and actual cursed art");
    GameCont.area=_area;
    var _all=scrNTTEFullInstances(all);
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false);
    scrNTTESmokeLog("PASS real cursed cave top decal factory/native combined class and exact cursed artwork");
}
function scrNTTEFullWorldKillEnemiesTests() {
    var _cont=instance_find(GameCont,0),_saved=scrNTTEFullValue(_cont,"killenemies",0);
    var _health=[];
    with(enemy) array_push(_health,{instance:id,health:hp});
    var _a=instance_create(15400,15400,Bandit),_b=instance_create(15432,15400,Bandit);
    _a.hp=10; _b.hp=10; _b.team=team_player;
    with(_cont) killenemies=1;
    repeat(round(1/timescale)-1) with(_cont) scrNTTEFullWorldKillEnemiesStep();
    assert(_a.hp==10 && _b.hp==10,"Enemy-clear request executed before one source logical tick");
    with(_cont) scrNTTEFullWorldKillEnemiesStep();
    assert(instance_exists(_a) && instance_exists(_b) && _a.hp==0 && _b.hp==0
        && _cont.killenemies==0,"Source delayed HP clear must retain instances for normal death events");
    instance_destroy(_a,false); instance_destroy(_b,false); _cont.killenemies=_saved;
    for(var _i=0;_i<array_length(_health);++_i) if(instance_exists(_health[_i].instance))
        _health[_i].instance.hp=_health[_i].health;
    scrNTTESmokeLog("PASS original GameCont killenemies countdown and HP-only clear, preserving normal deaths and source team scope");
}
