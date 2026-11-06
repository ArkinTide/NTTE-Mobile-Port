// tecaves361..886. Actual cloning enemy and staged, mobile-time-scaled death.
function scrNTTEFullCrystalBrainCreate() {
    name="CrystalBrain";spr_idle=scrNTTERefSprite("CrystalBrainIdle");spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("CrystalBrainHurt");spr_dead=scrNTTERefSprite("CrystalBrainDead")
    spr_part=scrNTTERefSprite("CrystalBrainPart");spr_appear=scrNTTERefSprite("CrystalBrainAppear")
    spr_disappear=scrNTTERefSprite("CrystalBrainDisappear");spr_effect=scrNTTERefSprite("CrystalBrainEffect")
    sprite_index=spr_hurt;hitid=[spr_idle,"CRYSTAL BRAIN"];depth=-2;mask_index=mskBanditBoss
    direction=scrNTTEFullSourceRandom(360);max_hp=80;raddrop=20;size=3;walk=0;walkspeed=0.3;maxspeed=1.2;minspeed=0.4
    meleedamage=4;clone_max=3;teleport=false;teleport_x=x;teleport_y=y;teleport_dis_min=80;teleport_dis_max=160
    ntte_brain_alarm=90
}
function scrNTTEFullCrystalBrainAfterCreate() {
    spr_shadow=shd32;spr_shadow_y=6;snd_hurt=sndLightningCrystalHit;snd_dead=sndLightningCrystalCharge
    corpse=false;friction=0.1*timescale*timescale;canmelee=true;canfly=false;alarm[1]=-1
}
function scrNTTEFullCrystalBrainTarget() {
    if(instance_exists(Player)) target=instance_nearest(x,y,Player)
    else if(!instance_exists(target)) target=noone
    return instance_exists(target)
}
function scrNTTEFullCrystalBrainCircuit(_x,_y) {
    if(!sprite_exists(spr_effect)) return noone;
    var _fx=scrNTTEFullCrystalBrainEffect(_x,_y)
    _fx.sprite_index=spr_effect;_fx.depth=depth-(scrNTTEFullSourceRandom(3)<2)
    return _fx
}
function scrNTTEFullCrystalBrainWarpIn() {
    var _found=false,_enemies=scrNTTEFullSourceShuffle(scrNTTEFullInstances(enemy)),
        _normal=scrNTTEFullInstances(Floor,true)
    for(var _i=0;_i<array_length(_enemies);++_i) {
        var _enemy=_enemies[_i],_floor=noone,_distance=infinity
        for(var _j=0;_j<array_length(_normal);++_j) {
            var _candidate=_normal[_j],_dx=max(_candidate.bbox_left-_enemy.x,0,_enemy.x-(_candidate.bbox_right-1)),
                _dy=max(_candidate.bbox_top-_enemy.y,0,_enemy.y-(_candidate.bbox_bottom-1)),_dis=_dx*_dx+_dy*_dy
            if(_dis<_distance) {_distance=_dis;_floor=_candidate}
        }
        if(instance_exists(_floor)) {
            var _x=(_floor.bbox_left+_floor.bbox_right)/2,_y=(_floor.bbox_top+_floor.bbox_bottom)/2
            if(point_distance(_x,_y,target.x,target.y)>=teleport_dis_min && !place_meeting(_x,_y,Wall)) {
                _found=true;teleport_x=_x;teleport_y=_y
            }
        }
        if(_found) break
    }
    if(hp<max_hp || !_found) {
        _found=false
        var _floors=scrNTTEFullSourceShuffle(_normal)
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _floor=_floors[_i],_x=(_floor.bbox_left+_floor.bbox_right)/2,_y=(_floor.bbox_top+_floor.bbox_bottom)/2,
                _distance=point_distance(_x,_y,target.x,target.y)
            if(_distance>=teleport_dis_min && _distance<=teleport_dis_max && !place_meeting(_x,_y,Wall)) {
                _found=true;teleport_x=_x;teleport_y=_y;break
            }
        }
    }
    teleport=false;canfly=false;x=teleport_x;y=teleport_y;sprite_index=spr_appear;image_index=0
    scrNTTEFullMergedBasicSoundAt(x,y,sndHyperCrystalSpawn,2.1+scrNTTEFullSourceRandom(0.3),0.8,64)
}
function scrNTTEFullCrystalBrainAlarm() {
    ntte_brain_alarm=scrNTTEFullSourceIRandomRange(20,40)
    if(!teleport) {
        if(scrNTTEFullCrystalBrainTarget()) {
            var _direction=point_direction(x,y,target.x,target.y),
                _seen=!collision_line(x,y,target.x,target.y,Wall,false,false),_can_warp=true
            if(_seen || scrNTTEFullSourceRandom(3)<1) {
                var _clones=0
                with(NTTEFullCrystalClone) if(creator==other.id) _clones+=scrNTTEFullValue(target,"size",1)
                if(!(scrNTTEFullSourceRandom(clone_max)<_clones)) {
                    var _clone=instance_create(x,y,NTTEFullCrystalClone)
                    _clone.creator=id;_clone.team=team;_can_warp=false
                }
                if(point_distance(x,y,target.x,target.y)<64) {
                    scrNTTEFullRedEnemyWalk(_direction+180+scrNTTEFullSourceRandomRange(-30,30),scrNTTEFullSourceRandomRange(10,20))
                    ntte_brain_alarm=walk+scrNTTEFullSourceRandom(10)
                }
            }
            if(_can_warp && scrNTTEFullSourceRandom(4)<1) {
                ntte_brain_alarm=30;teleport=true;teleport_x=x;teleport_y=y;sprite_index=spr_disappear;image_index=0
                scrNTTEFullMergedBasicSoundAt(x,y,sndTVOn,1.4+scrNTTEFullSourceRandom(0.2),0.4,64)
                scrNTTEFullMergedBasicSoundAt(x,y,sndCrystalShield,1.3+scrNTTEFullSourceRandom(0.2),1,64)
                repeat(8) {
                    var _fx=scrNTTEFullMergedStockFX(teleport_x,teleport_y,scrNTTEFullSourceRandom(2),NTTEFullCrystTrail)
                    _fx.sprite_index=scrNTTERefSprite("CrystalRedTrail")
                }
            }
            else if(_seen) scrNTTEFullRedEnemyLook(_direction)
        }
        else {ntte_brain_alarm=scrNTTEFullSourceRandomRange(30,60);scrNTTEFullRedEnemyWalk(scrNTTEFullSourceRandom(360),scrNTTEFullSourceRandomRange(20,40))}
    }
    else if(scrNTTEFullCrystalBrainTarget()) scrNTTEFullCrystalBrainWarpIn()
}
function scrNTTEFullCrystalBrainStep() {
    if(lockstep_stop) return;
    if(hp<=0) {instance_destroy();return;}
    if(ntte_brain_alarm>0) {
        ntte_brain_alarm-=timescale
        if(ntte_brain_alarm<=0) {ntte_brain_alarm=-1;scrNTTEFullCrystalBrainAlarm()}
    }
    if(walk>0) {walk-=timescale;speed+=walkspeed*timescale*timescale}
    speed=clamp(speed,minspeed*timescale,maxspeed*timescale)
    if(sprite_index==spr_disappear) {
        if(image_index+image_speed>=image_number) image_index-=image_speed
    }
    else if(sprite_index!=spr_appear || image_index+image_speed>=image_number) sprite_index=scrNTTEFullWorldEnemySprite()
    if(teleport) {
        x=0;y=0;canfly=true
        if(scrNTTEFullSourceRandom(4)<timescale) scrNTTEFullCrystalBrainCircuit(teleport_x+scrNTTEFullSourceRandomRange(-32,32),teleport_y+scrNTTEFullSourceRandomRange(-32,32))
    }
}
function scrNTTEFullCrystalBrainDraw() {
    draw_sprite_ext(sprite_index,image_index,teleport?teleport_x:x,teleport?teleport_y:y,
        image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullCrystalBrainHurt(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        hp-=_damage;nexthurt=current_frame+6
        scrNTTEFullNativeMotionAddFT(id,is_undefined(_direction)?0:_direction,_force/timescale)
        snd_play_hit(snd_hurt,0.2);sprite_index=spr_hurt;image_index=0
    }
    return true
}
function scrNTTEFullCrystalBrainDeath() {
    if(hp>0) return;
    with(instance_create(x,y,PortalClear)) {image_xscale*=0.8;image_yscale*=0.8}
    var _death=instance_create(x,y,NTTEFullCrystalBrainDeath),
        _fields=["spr_dead","spr_part","spr_shadow","spr_shadow_x","spr_shadow_y","image_yscale","image_angle",
            "image_blend","image_alpha","depth","mask_index","snd_hurt","raddrop","size","team","direction"]
    for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(_death,_fields[_i],variable_instance_get(id,_fields[_i]))
    _death.sprite_index=spr_hurt;_death.image_xscale=image_xscale*right;_death.speed=min(speed/1.5,8*timescale)
    raddrop=0
    with(instance_create(x,y,PortalL)) depth=other.depth-1
    repeat(8) scrNTTEFullMergedStockFX(x,y,3,Smoke)
}
function scrNTTEFullCrystalBrainDeathCreate() {
    name="CrystalBrainDeath";sprite_index=scrNTTERefSprite("CrystalBrainHurt")
    spr_dead=scrNTTERefSprite("CrystalBrainDead");spr_part=scrNTTERefSprite("CrystalBrainPart")
    spr_shadow=shd32;spr_shadow_x=0;spr_shadow_y=6;image_speed=0.4*timescale;depth=-2
    snd_hurt=sndLightningCrystalHit;snd_dead=sndLightningCrystalDeath;mask_index=mskBanditBoss
    friction=0.5*timescale*timescale;size=3;team=1;raddrop=20;throes=scrNTTEFullSourceIRandomRange(2,3);ntte_brain_death_alarm=15
}
function scrNTTEFullCrystalBrainDeathStep() {
    if(lockstep_stop) return;
    if(ntte_brain_death_alarm>0) {
        ntte_brain_death_alarm-=timescale
        if(ntte_brain_death_alarm<=0) {
            ntte_brain_death_alarm=-1;scrNTTEFullCrystalBrainDeathAlarm()
            if(!instance_exists(id)) return;
        }
    }
    if(sprite_index!=-1 && image_index+image_speed>=image_number) {image_index=image_number-1;image_speed=0}
    x+=scrNTTEFullSourceRandomRange(-2*timescale,2*timescale);y+=scrNTTEFullSourceRandomRange(-2*timescale,2*timescale)
    scrNTTEFullWallFakeMotionStep(id,1)
    if(place_meeting(x,y,Wall)) {x=xprevious;y=yprevious;move_bounce_solid(true)}
    scrNTTEFullWallFakeMotionStep(id,-1)
}
function scrNTTEFullCrystalBrainChunks(_count,_minimum,_maximum) {
    repeat(_count) {
        var _fx=scrNTTEFullMergedStockFX(x,y,scrNTTEFullSourceRandomRange(_minimum,_maximum),Shell)
        _fx.sprite_index=scrNTTERefSprite("CrystalBrainChunk");_fx.image_index=scrNTTEFullSourceIRandom(_fx.image_number-1);_fx.image_speed=0
    }
}
function scrNTTEFullCrystalBrainDeathAlarm() {
    ntte_brain_death_alarm=15
    if(sprite_index!=-1) {
        sprite_index=-1
        scrNTTEFullMergedBasicSoundAt(x,y,sndCrystalPropBreak,1.4+scrNTTEFullSourceRandomRange(-0.1,0.1),4,64)
    }
    if(scrNTTEFullSourceRandom(5)<2*timescale) instance_create(x+scrNTTEFullSourceRandomRange(-12,12),y+scrNTTEFullSourceRandomRange(-12,12),Smoke)
    if(throes>0) {
        --throes;image_index=0;image_speed=0.4*timescale
        speed=scrNTTEFullSourceRandomRange(3,6)*timescale;direction=point_direction(x,y,xstart,ystart)+scrNTTEFullSourceRandomRange(-30,30);move_contact_solid(direction,4)
        var _clone=instance_create(x,y,NTTEFullCrystalClone),_eligible=[]
        _clone.creator=id;_clone.team=team;_clone.time=150
        for(var _i=0;_i<array_length(_clone.clone);++_i) {
            var _target=_clone.clone[_i]
            if(_target.size<3 && is_undefined(scrNTTEFullValue(_target,"intro",undefined))) array_push(_eligible,_target)
        }
        _clone.clone=_eligible
        scrNTTEFullCrystalBrainChunks(2,2,5);snd_play_hit(snd_hurt,0.3);scrNTTEFullTrenchShake(x,y,15)
    }
    else instance_destroy()
}
function scrNTTEFullCrystalBrainDeathDraw() {
    draw_self()
    if(sprite_index!=-1) return;
    var _flash=image_index<1,_offset=10/max(1,1+throes),_rng={random:1},_fog=gpu_get_fog()
    scrNTTEFullSourceRandomSeed(real(id)+throes,_rng);scrNTTEFullSourceRandom(1,_rng)
    if(_flash) gpu_set_fog(true,image_blend,0,0)
    for(var _i=0;_i<sprite_get_number(spr_part);++_i) draw_sprite_ext(spr_part,_i,
        x+scrNTTEFullSourceRandomRange(-_offset,_offset,_rng),y+scrNTTEFullSourceRandomRange(-_offset,_offset,_rng),
        image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    gpu_set_fog(_fog)
}
function scrNTTEFullCrystalBrainDeathDestroy() {
    var _corpse=scrNTTEFullCorpseDrop(id)
    _corpse.image_index=3
    scrNTTEFullWorldPickupDrop(100,0);scrNTTEFullWorldPickupDrop(50,0);scrRadDrop(x,y,raddrop)
    snd_play_hit_big(snd_dead,0.2);scrNTTEFullTrenchShake(x,y,30);scrNTTEFullCrystalBrainChunks(5,3,7)
}
