// tecaves3309..3844,3977..4193. Genuine Warp Zone boss and staged death.
function scrNTTEFullTesseractLayers() {
    var _idle=scrNTTERefSprite("TesseractLayer"),_dead=scrNTTERefSprite("TesseractDeathLayer"),_layers=[]
    for(var _i=0;_i<array_length(_idle);++_i) array_push(_layers,
        {spr_idle:_idle[_i],spr_dead:_dead[_i],rotation:0,rotspeed:0,rotfriction:0.2})
    return _layers
}
function scrNTTEFullTesseractCreate() {
    name="Tesseract";boss=true;spr_idle=scrNTTERefSprite("TesseractIdle");spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("TesseractHurt");spr_fire=scrNTTERefSprite("TesseractFire")
    spr_tell=scrNTTERefSprite("TesseractTell");sprite_index=spr_tell;depth=-3
    hitid=[scrNTTERefSprite("TesseractDeathCause"),"@9("+string(scrNTTERefSprite("TesseractDeathCauseText"))+":-0.7)"]
    mask_index=scrNTTERefSprite("msk.CaveHole");ntte_tesseract_hp=scrNTTEFullSewerBossHP(600)
    max_hp=ntte_tesseract_hp/(1+GameCont.loops/20);meleedamage=ntte_tesseract_hp;raddrop=65;size=6
    walk=0;walkspeed=0.4;maxspeed=2;minspeed=0.2;intro=false;ammo=3;tauntdelay=30
    direction=scrNTTEFullSourceRandom(360);ntte_tesseract_direction=direction
    ntte_tesseract_alarm1=200;ntte_tesseract_alarm2=240;layers=scrNTTEFullTesseractLayers()
    weapons=[];weapons_max=4+GameCont.loops
    if(weapons_max>0) for(var _rotation=0;_rotation<360;_rotation+=360/weapons_max) array_push(weapons,
        {spr_idle:scrNTTERefSprite("TesseractWeapon"),rotation:_rotation+round(direction/90)*90,
            rotspeed:0,rotfriction:0.1,offset:64*2/3,kick:16,kick_goal:0,strike:noone})
    bossname=hitid[1];col=make_color_rgb(235,0,67)
}
function scrNTTEFullTesseractAfterCreate() {
    hp=ntte_tesseract_hp;max_hp=hp;direction=ntte_tesseract_direction;corpse=false;canmelee=false
    spr_shadow=mskNone;spr_shadow_x=0;spr_shadow_y=12;friction=0.2*timescale*timescale
    snd_hurt=sndHyperCrystalHurt;snd_dead=sndHyperCrystalChargeExplo;snd_lowh=sndNothingRise;snd_mele=sndBasicUltra
    alarm[1]=-1;alarm[2]=-1
    GameCont.ntte_full_boss_music_key="Tesseract"
    with(MusCont) {alarm[2]=1;alarm[3]=-1}
}
function scrNTTEFullTesseractTarget() {
    if(instance_exists(Player)) target=instance_nearest(x,y,Player)
    else if(!instance_exists(target)) target=noone
    return instance_exists(target)
}
function scrNTTEFullTesseractStep() {
    if(lockstep_stop) return;
    if(hp<=0) {instance_destroy();return;}
    if(ntte_tesseract_alarm1>0) {
        ntte_tesseract_alarm1-=timescale
        if(ntte_tesseract_alarm1<=0) {ntte_tesseract_alarm1=-1;scrNTTEFullTesseractAlarm1()}
    }
    if(ntte_tesseract_alarm2>0) {
        ntte_tesseract_alarm2-=timescale
        if(ntte_tesseract_alarm2<=0) {ntte_tesseract_alarm2=-1;scrNTTEFullTesseractAlarm2()}
    }
    if((sprite_index!=spr_tell && sprite_index!=spr_fire) || image_index+image_speed>=image_number)
        sprite_index=(intro || sprite_index==spr_hurt)?scrNTTEFullWorldEnemySprite():spr_tell
    if(walk>0) {walk-=timescale;speed+=walkspeed*timescale*timescale}
    speed=clamp(speed,minspeed*timescale,maxspeed*timescale)
    for(var _i=0;_i<array_length(weapons);++_i) {
        var _weapon=weapons[_i]
        _weapon.rotation+=_weapon.rotspeed*timescale
        _weapon.rotspeed-=clamp(_weapon.rotspeed,-_weapon.rotfriction*timescale,_weapon.rotfriction*timescale)
        _weapon.kick-=clamp(_weapon.kick,-timescale,timescale)
        if(instance_exists(_weapon.strike) && _weapon.strike.active) {
            var _strike=_weapon.strike
            _strike.xstart=x+lengthdir_x(_weapon.offset*image_xscale,_weapon.rotation)
            _strike.ystart=y+lengthdir_y(_weapon.offset*image_yscale,_weapon.rotation)
            _strike.image_angle=_weapon.rotation
            if(_strike.ntte_strike_alarm>0 && _strike.ntte_strike_alarm<=ceil(timescale)) {
                _weapon.kick=_weapon.kick_goal;sprite_index=spr_fire;image_index=0
                for(var _j=0;_j<array_length(layers);++_j) {
                    var _layer=layers[_j]
                    if(abs(_layer.rotspeed)<6) _layer.rotspeed+=3*(_layer.rotspeed==0?scrNTTEFullSourceChoose([-1,1]):sign(_layer.rotspeed))
                }
            }
        }
    }
    for(var _i=0;_i<array_length(layers);++_i) {
        var _layer=layers[_i]
        _layer.rotation+=_layer.rotspeed*timescale
        _layer.rotspeed-=clamp(_layer.rotspeed,-_layer.rotfriction*timescale,_layer.rotfriction*timescale)
        if(scrNTTEFullSourceRandom(40)<timescale) _layer.rotspeed=scrNTTEFullSourceRandomRange(-6,6)
    }
    if(tauntdelay>0 && !instance_exists(Player)) {
        tauntdelay-=timescale
        if(tauntdelay<=0) {snd_play(sndLastGrowl,0.3);snd_play(sndHyperCrystalChargeExplo,0.3)}
    }
    if(hp/max_hp<=max(0.1,array_length(weapons)-1)/weapons_max) scrNTTEFullTesseractArmBreak(array_length(weapons)-1)
}
function scrNTTEFullTesseractAlarm1() {
    ntte_tesseract_alarm1=60+scrNTTEFullSourceRandom(30)
    scrNTTEFullRedEnemyWalk(direction+scrNTTEFullSourceRandomRange(-90,90),60+scrNTTEFullSourceRandom(60))
    if(!intro) {
        intro=true;canmelee=true;scrNTTEFullBossIntro("Tesseract",true)
        snd_play(sndBigDogHit,0.2);snd_play(sndTVOn,0.3);snd_play(sndRogueCanister,0.5);snd_play(sndBallMamaLoop,8)
        scrNTTEFullWorldWallClear(id)
        for(var _i=0;_i<array_length(weapons);++_i) {
            var _weapon=weapons[_i],_clear=instance_create(x+lengthdir_x(_weapon.offset*image_xscale,_weapon.rotation),
                y+lengthdir_y(_weapon.offset*image_yscale,_weapon.rotation),PortalClear)
            with(_clear) motion_add(_weapon.rotation,3*timescale)
        }
    }
    else if(scrNTTEFullTesseractTarget() && (collision_line(x,y,target.x,target.y,Wall,false,false) || point_distance(x,y,target.x,target.y)>192)) {
        direction=point_direction(x,y,target.x,target.y)+scrNTTEFullSourceRandomRange(-30,30)
        var _clear=scrNTTEFullWorldWallClear(id)
        with(_clear) motion_add(other.direction,8*timescale)
        ntte_tesseract_alarm1=15+scrNTTEFullSourceRandom(30)
    }
    else if(instance_exists(Floor)) {
        var _left=x,_top=y,_right=x,_bottom=y,_floors=scrNTTEFullInstances(Floor)
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _floor=_floors[_i]
            if(!collision_line(x,y,(_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,Wall,false,false)) {
                _left=min(_left,_floor.bbox_left);_top=min(_top,_floor.bbox_top)
                _right=max(_right,_floor.bbox_right-1);_bottom=max(_bottom,_floor.bbox_bottom-1)
            }
        }
        var _tx=(_left+_right)/2,_ty=(_top+_bottom)/2
        if(point_distance(x,y,_tx,_ty)>64) direction=point_direction(x,y,_tx,_ty)+scrNTTEFullSourceRandomRange(-30,30)
    }
}
function scrNTTEFullTesseractStrikeSound(_sound,_pitch,_volume,_position) {
    var _handle=scrNTTEFullMergedBasicSoundAt(x,y,_sound,_pitch,_volume,64)
    if(_handle>=0) audio_sound_set_track_position(_handle,_position)
}
function scrNTTEFullTesseractAlarm2() {
    ntte_tesseract_alarm2=10+scrNTTEFullSourceRandom(40);scrNTTEFullTesseractTarget()
    if(ammo<=0) {
        if(scrNTTEFullSourceRandom(weapons_max*2)<array_length(weapons)-1) {
            ammo=min(array_length(weapons),scrNTTEFullSourceIRandomRange(2,4))
            for(var _i=0;_i<array_length(weapons);++_i) weapons[_i].kick=-16
        }
        else if(array_length(weapons)>0) {
            var _weapon=weapons[0]
            if(!instance_exists(_weapon.strike)) {
                instance_create(x+lengthdir_x(_weapon.offset,_weapon.rotation),y+lengthdir_y(_weapon.offset,_weapon.rotation),Smoke)
                if(instance_exists(target)) {
                    var _last=_weapon.rotation;_weapon.rotation=point_direction(x,y,target.x,target.y)
                    _weapon.rotspeed=1.2*sign(angle_difference(_weapon.rotation,_last))
                }
                _weapon.strike=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTesseractStrike,_weapon.rotation)
                _weapon.strike.ntte_strike_alarm=min(20,ntte_tesseract_alarm2*array_length(weapons))
                _weapon.kick_goal=15;_weapon.kick=-5
                for(var _i=0;_i<array_length(weapons)-1;++_i) weapons[_i]=weapons[_i+1]
                weapons[array_length(weapons)-1]=_weapon
                scrNTTEFullTesseractStrikeSound(sndPortalStrikeLoop,1.3+scrNTTEFullSourceRandom(0.25),10,0.93)
                scrNTTEFullTesseractStrikeSound(sndSnowBotDead,1.3+scrNTTEFullSourceRandom(0.2),10,0.55)
            }
        }
    }
    if(ammo>0) {
        --ammo;right=scrNTTEFullSourceChoose([-1,1]);var _max=array_length(weapons)
        if(_max>0) {
            var _direction=weapons[0].rotation,_speed=scrNTTEFullSourceRandomRange(2,6)*right
            ntte_tesseract_alarm2=max(45,10*abs(_speed))
            for(var _i=0;_i<_max;++_i) {
                var _weapon=weapons[_i];_weapon.rotation=_direction+(_i/_max)*360
                _weapon.rotspeed=_speed;_weapon.kick_goal=10
                _weapon.strike=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTesseractStrike,_weapon.rotation)
                _weapon.strike.ntte_strike_alarm=ntte_tesseract_alarm2-15
            }
            sprite_index=spr_tell;image_index=0
            scrNTTEFullTesseractStrikeSound(sndPortalStrikeLoop,0.85+scrNTTEFullSourceRandom(0.15),10,1.33)
            scrNTTEFullTesseractStrikeSound(sndSnowBotThrow,0.6+scrNTTEFullSourceRandom(0.2),8,0.2)
            if(ammo<=0) ntte_tesseract_alarm2=24*_max
        }
    }
}
function scrNTTEFullTesseractDraw() {
    var _max=array_length(layers),_hurt=sprite_index==spr_hurt && image_index<1,_fog=gpu_get_fog()
    if(_hurt) gpu_set_fog(true,image_blend,0,0)
    for(var _i=0;_i<_max;++_i) {
        var _layer=layers[_i]
        draw_sprite_ext(_layer.spr_idle,0,x,y,image_xscale,image_yscale,image_angle+_layer.rotation,image_blend,image_alpha)
    }
    for(var _i=0;_i<_max;++_i) {
        var _layer=layers[_i]
        if(_i==_max-1) for(var _j=0;_j<array_length(weapons);++_j) {
            var _weapon=weapons[_j],_length=_weapon.offset-_weapon.kick,_direction=_weapon.rotation
            draw_sprite_ext(_weapon.spr_idle,image_index,x+lengthdir_x(_length*image_xscale,_direction),
                y+lengthdir_y(_length*image_yscale,_direction),image_xscale,image_yscale,_direction,image_blend,image_alpha)
        }
        draw_sprite_ext(_layer.spr_idle,1,x,y,image_xscale,image_yscale,image_angle+_layer.rotation,image_blend,image_alpha)
    }
    gpu_set_fog(_fog);draw_self()
}
function scrNTTEFullTesseractHurt(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        hp-=_damage;nexthurt=current_frame+6
        scrNTTEFullNativeMotionAddFT(id,is_undefined(_direction)?0:_direction,_force/timescale)
        sprite_index=spr_hurt;image_index=0
        if(snd_hurt==sndHyperCrystalHurt) {
            scrNTTEFullMergedBasicSoundAt(x,y,snd_hurt,0.5+scrNTTEFullSourceRandom(0.3),1,64)
            scrNTTEFullMergedBasicSoundAt(x,y,sndNothingHurtHigh,0.8+scrNTTEFullSourceRandom(0.2),1,64)
            snd_play_hit(sndBigDogWalk,0.3)
        }
        else snd_play_hit(snd_hurt,0.2)
    }
    return true
}
function scrNTTEFullTesseractArmBreak(_number) {
    if(_number<0 || _number>=array_length(weapons)) return noone;
    var _weapon=weapons[_number];array_delete(weapons,_number,1)
    if(!intro) {ntte_tesseract_alarm1=min(ntte_tesseract_alarm1,1);ntte_tesseract_alarm2=min(ntte_tesseract_alarm2,10)}
    ammo=min(ammo,0)
    if(array_length(weapons)==floor(weapons_max/2)) {
        if(snd_lowh==sndNothingRise) {snd_play(snd_lowh,0.7);snd_play(sndLastMeleeCharge,0.25);snd_play(sndHyperCrystalChargeExplo,1.5)}
        else snd_play(snd_lowh)
        scrNTTEFullTrenchShake(x,y,40)
    }
    var _arm=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x((_weapon.offset-_weapon.kick)*image_xscale,_weapon.rotation),
        y+lengthdir_y((_weapon.offset-_weapon.kick)*image_yscale,_weapon.rotation),NTTEFullTesseractArmDeath,_weapon.rotation,5.5)
    _arm.sprite_index=_weapon.spr_idle;_arm.image_xscale=image_xscale;_arm.image_yscale=image_yscale
    _arm.image_blend=image_blend;_arm.image_alpha=image_alpha;_arm.depth=depth-1;_arm.strike=_weapon.strike
    with(_arm) {
        repeat(8) {
            var _fx=scrNTTEFullMergedStockFX(x,y,[direction+scrNTTEFullSourceChoose([-45,45]),3],Smoke)
            /* NTTE NATIVE EFFECT LIFETIME tesseract-arm-smoke */ if(instance_exists(_fx)) {_fx.depth=depth;_fx.growspeed/=3 }
        }
        scrNTTEFullTrenchShake(x,y,20)
        scrNTTEFullMergedBasicSoundAt(x,y,sndIDPDNadeExplo,0.6,3.5,64)
        scrNTTEFullMergedBasicSoundAt(x,y,sndHeavyCrossbow,0.6,5,64)
    }
    return _arm
}
function scrNTTEFullTesseractDeath() {
    if(hp>0) return;
    with(MusCont) alarm[1]=1
    while(array_length(weapons)>0) scrNTTEFullTesseractArmBreak(0)
    if(snd_dead==sndHyperCrystalChargeExplo) {snd_play(snd_dead,0.2);snd_dead=-1}
    var _death=instance_create(x,y,NTTEFullTesseractDeath),_fields=["spr_shadow","spr_shadow_x","spr_shadow_y","hitid","layers",
        "image_xscale","image_yscale","image_angle","image_blend","image_alpha","depth","mask_index","snd_hurt","raddrop","size","team","direction"]
    for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(_death,_fields[_i],variable_instance_get(id,_fields[_i]))
    _death.sprite_index=spr_hurt;_death.speed=min(speed/2.5,6*timescale);raddrop=0
}
function scrNTTEFullTesseractDeathCreate() {
    name="TesseractDeath";sprite_index=scrNTTERefSprite("TesseractHurt");spr_shadow=mskNone;spr_shadow_x=0;spr_shadow_y=12
    hitid=-1;image_speed=0.2*timescale;depth=-3;snd_hurt=sndHyperCrystalHurt;snd_dead=sndHyperCrystalHalfHP
    mask_index=scrNTTERefSprite("msk.CaveHole");friction=0.2*timescale*timescale;size=6;team=1;raddrop=65;throes=3
    layers=scrNTTEFullTesseractLayers();ntte_tesseract_death_alarm=1
}
function scrNTTEFullTesseractDeathStep() {
    if(lockstep_stop) return;
    if(ntte_tesseract_death_alarm>0) {
        ntte_tesseract_death_alarm-=timescale
        if(ntte_tesseract_death_alarm<=0) {
            ntte_tesseract_death_alarm=-1;scrNTTEFullTesseractDeathAlarm()
            if(!instance_exists(id)) return;
        }
    }
    var _max=array_length(layers)
    for(var _i=0;_i<_max;++_i) {
        var _layer=layers[_i];_layer.rotation+=_layer.rotspeed*timescale
        _layer.rotspeed-=clamp(_layer.rotspeed,-_layer.rotfriction*timescale,_layer.rotfriction*timescale)
        if(_i<_max-throes) {
            var _speed=2+1.5*_i
            if(abs(_layer.rotspeed)<_speed) _layer.rotspeed=_speed*(_layer.rotspeed==0?scrNTTEFullSourceChoose([-1,1]):sign(_layer.rotspeed))
        }
    }
    if(sprite_index!=-1 && image_index+image_speed>=image_number) {image_index=image_number-1;image_speed=0}
    x+=scrNTTEFullSourceRandomRange(-2*timescale,2*timescale);y+=scrNTTEFullSourceRandomRange(-2*timescale,2*timescale)
    if(scrNTTEFullSourceRandom(1+1.5*throes)<timescale) {
        var _fx=scrNTTEFullMergedStockFX(x,y,3,Smoke);/* NTTE NATIVE EFFECT LIFETIME tesseract-death-smoke */ if(instance_exists(_fx)) {_fx.image_blend=c_black }
    }
    scrNTTEFullWallFakeMotionStep(id,1)
    if(place_meeting(x,y,Wall)) {x=xprevious;y=yprevious;move_bounce_solid(true)}
    scrNTTEFullWallFakeMotionStep(id,-1)
}
function scrNTTEFullTesseractDeathAlarm() {
    ntte_tesseract_death_alarm=30
    if(throes<=0) {instance_destroy();return;}
    --throes;image_index=0;image_speed=0.2*timescale;speed=4*timescale
    direction=point_direction(x,y,xstart,ystart)+scrNTTEFullSourceRandomRange(-30,30);move_contact_solid(direction,4)
    scrNTTEFullCrystalBrainChunks(2,2,5)
    if(snd_hurt==sndHyperCrystalHurt) {
        scrNTTEFullMergedBasicSoundAt(x,y,sndLaserCrystalHit,0.5+scrNTTEFullSourceRandom(0.3),8,64)
        scrNTTEFullMergedBasicSoundAt(x,y,sndPlantPotBreak,1.2+scrNTTEFullSourceRandom(0.6/(1+throes)),8,64)
    }
    snd_play_hit_big(snd_hurt,0.3);scrNTTEFullTrenchShake(x,y,30)
}
function scrNTTEFullTesseractDeathDraw() {
    var _max=array_length(layers),_hurt=image_index<1,_fog=gpu_get_fog()
    if(_hurt) gpu_set_fog(true,image_blend,0,0)
    for(var _i=clamp(_max-throes,0,_max-1);_i<_max;++_i) {
        var _layer=layers[_i]
        draw_sprite_ext(_layer.spr_idle,0,x,y,image_xscale,image_yscale,image_angle+_layer.rotation,image_blend,image_alpha)
    }
    for(var _i=0;_i<_max;++_i) {
        var _layer=layers[_i],_angle=image_angle+_layer.rotation
        if(_i>=_max-throes) draw_sprite_ext(_layer.spr_idle,1,x,y,image_xscale,image_yscale,_angle,image_blend,image_alpha)
        else {
            var _sprite=_layer.spr_dead,_number=sprite_get_number(_sprite)
            for(var _image=0;_image<_number;++_image) {
                var _length=16+4*dsin(4*(360*(_image/_number)+_angle)),_direction=_angle+(_image/_number)*360
                if(image_speed!=0 && _i>=(_max-throes)-1) _length*=clamp((image_index/image_number)*1.5,0,1)
                draw_sprite_ext(_sprite,_image,x+lengthdir_x(_length,_direction)*image_xscale,
                    y+lengthdir_y(_length,_direction)*image_yscale,image_xscale,image_yscale,_angle,image_blend,image_alpha)
            }
        }
    }
    gpu_set_fog(_fog);draw_self()
}
function scrNTTEFullTesseractDeathDestroy() {
    for(var _i=0;_i<max(1,array_length(layers)-1);++_i) {
        var _layer=layers[_i],_sprite=_layer.spr_dead,_number=sprite_get_number(_sprite),_angle=image_angle+_layer.rotation
        for(var _image=0;_image<_number;++_image) {
            var _direction=(_image/_number)*360+_angle,
                _corpse=instance_create(x+lengthdir_x(16,_direction),y+lengthdir_y(16,_direction),ScrapBossCorpse)
            _corpse.sprite_index=_sprite;_corpse.image_index=_image;_corpse.image_xscale=image_xscale;_corpse.image_yscale=image_yscale
            _corpse.image_angle=_angle;_corpse.mask_index=-1;_corpse.friction=0.5*timescale*timescale;_corpse.size=3
            with(_corpse) {
                scrNTTEFullNativeMotionAddFT(id,_direction,4+scrNTTEFullSourceRandom(6)+4*scr_skill_get(mut_impact_wrists))
                speed=min(speed,16*timescale)
            }
        }
    }
    var _explosion=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullRedExplosion)
    _explosion.mask_index=mskPopoPlasmaImpact;_explosion.image_angle=image_angle;scrNTTEFullTrenchShake(x,y,50)
    for(var _direction=0;_direction<360;_direction+=12) {
        var _length=scrNTTEFullSourceRandom(20),_fx=scrNTTEFullMergedStockFX(x+lengthdir_x(_length*image_xscale,_direction),
            y+lengthdir_y(_length*image_yscale,_direction),[_direction,scrNTTEFullSourceRandomRange(3,4)],Smoke)
        if(instance_exists(_fx)) {_fx.image_xscale=image_xscale;_fx.image_yscale=image_yscale;_fx.image_blend=c_black;_fx.depth=depth}
    }
    repeat(3) scrNTTEFullWorldPickupDrop(100,0)
    scrRadDrop(x,y,raddrop)
    var _gold=false
    with(Player) {
        if(scrNTTEFullWeaponMergeProperty(wep,"gold")!=0 || scrNTTEFullWeaponMergeProperty(bwep,"gold")!=0
            || array_get_index([wep_ntte_tunneller,wep_ntte_golden_tunneller],scrNTTEFullWeaponRaw(wep))>=0
            || array_get_index([wep_ntte_tunneller,wep_ntte_golden_tunneller],scrNTTEFullWeaponRaw(bwep))>=0) {_gold=true;break}
    }
    if(_gold) scrWeaponPickupCreate(x,y,wep_ntte_golden_tunneller,true)
    scrNTTEFullMergedBasicSoundAt(x,y,sndPlantPotBreak,0.8+scrNTTEFullSourceRandom(0.2),6,64)
    scrNTTEFullMergedBasicSoundAt(x,y,sndPortalOpen,1.8+scrNTTEFullSourceRandom(0.2),4,64)
    scrNTTEFullMergedBasicSoundAt(x,y,sndPortalStrikeFire,2.5+scrNTTEFullSourceRandomRange(-0.1,0.1),4,64)
    scrNTTEFullMergedBasicSoundAt(x,y,sndHyperCrystalTaunt,3+scrNTTEFullSourceRandomRange(-0.1,0.1),4,64)
    snd_play_hit_big(snd_dead,0.2)
}
