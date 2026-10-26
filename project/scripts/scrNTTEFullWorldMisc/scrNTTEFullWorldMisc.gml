// tecaves MinerBandit and native lighting passes; tescrapyard quest props.
function scrNTTEFullMinerBanditAfterCreate() {
    spr_idle=scrNTTERefSprite("MinerBanditIdle"); spr_walk=scrNTTERefSprite("MinerBanditWalk")
    spr_hurt=scrNTTERefSprite("MinerBanditHurt"); spr_dead=scrNTTERefSprite("MinerBanditDead")
    sprite_index=spr_idle; hitid=[spr_idle,"MINER BANDIT"]; max_hp=8; hp=max_hp
    light_angle=gunangle; light_visible=true; scrNTTEFullWorldLook(gunangle)
}

function scrNTTEFullMinerBanditStep() {
    if (lockstep_stop) return;
    light_angle+=angle_difference(gunangle,light_angle)*(1-power(0.75,timescale))
    if ((current_frame mod 3)<timescale) {
        light_visible=random(10)>=1
        if (GameCont.area==area_cursed_caves) light_visible=!light_visible
    }
}

// Call inside scrDarkness's existing gray and black passes. Original NTT draws
// world coordinates using an engine matrix; Epsilon's target uses view-local.
function scrNTTEFullWorldDarkDraw(_gray,_vx,_vy) {
    scrUGDark(_gray,_vx,_vy);
    scrNTTEFullRedWorldDarkDraw(_gray,_vx,_vy);

    // tesewers6173..6252. Light sprites belong in both actual darkness passes;
    // additive foreground drawing alone does not open the opaque dark surface.
    with(NTTEFullCatLight) if(visible && bbox_left<_vx+view_width+16*_gray && bbox_right>_vx-16*_gray
        && bbox_top<_vy+view_height+8*_gray && bbox_bottom>_vy-8*_gray) {
        var _xs=image_xscale+16*_gray/sprite_get_width(sprite_index),
            _ys=image_yscale+8*_gray/sprite_get_height(sprite_index),_color=draw_get_color()
        // Original fog recolors the white mask to the current gray/black pass.
        gpu_set_fog(true,_color,0,0)
        draw_sprite_ext(sprite_index,image_index,x-_vx,y-_vy,_xs,_ys,image_angle,image_blend,abs(image_alpha))
        gpu_set_fog(false,0,0,0)
    }
    with(NTTEFullPizzaManholeCover) {
        if(_gray) draw_circle(xstart-_vx,ystart-_vy-16,40+random(2),false)
        else draw_sprite_ext(scrNTTERefSprite("CatLightThin"),0,xstart-_vx,ystart-_vy-32,1/3.5,1/4.25,orandom(1),c_white,1)
    }
    with(NTTEFullPizzaTV) {
        if(_gray) draw_circle(x-_vx,y-_vy,64+random(2),false)
        else { var _scale=1+orandom(0.025); draw_sprite_ext(scrNTTERefSprite("CatLight"),0,x-_vx,y-_vy-5,_scale/3.5,_scale/2.5,0,c_white,1) }
    }
    var _ld=60+60*_gray,_la=15+5*_gray,_cd=6+3*_gray,_cr=12+12*_gray
    with (NTTEFullMinerBandit) {
        var _x=x-_vx,_y=y-_vy
        if (light_visible) {
            var _off=_la+orandom(1),_x2=_x+lengthdir_x(_ld,light_angle+_off),_y2=_y+lengthdir_y(_ld,light_angle+_off)
            var _x3=_x+lengthdir_x(_ld,light_angle-_off),_y3=_y+lengthdir_y(_ld,light_angle-_off)
            draw_triangle(_x,_y,_x2,_y2,_x3,_y3,false)
            draw_circle(_x+lengthdir_x(_ld,light_angle),_y+lengthdir_y(_ld,light_angle),point_distance(_x2,_y2,_x3,_y3)/2,false)
        }
        draw_circle(_x+lengthdir_x(_cd,light_angle),_y+lengthdir_y(_cd,light_angle),_cr+orandom(1),false)
    }
    var _r=30+60*_gray+1+sin(current_frame/80)
    with (NTTEFullBigCrystalProp) draw_circle(x-_vx,y-_vy,_r,false)
    with (NTTEFullMortar) if (sprite_index==spr_fire) {
        // The port uses a logical tell timer instead of native integer alarm1.
        draw_circle(x-_vx+6*right,y-_vy-16,abs(24-ntte_mortar_shot_left+orandom(4))+24*_gray,false)
    }
    with (NTTEFullMortarPlasma) draw_circle(x-_vx,y-_vy-z,32+32*_gray+orandom(1),false)
    with (NTTEFullGhost) {
        draw_primitive_begin(pr_trianglefan)
        draw_vertex(x-_vx,y-_vy)
        var _n=dark_vertices,_l=(48+64*_gray)*dark_scale+random(2)
        for(var _d=0;_d<=360;_d+=360/_n) draw_vertex(x-_vx+lengthdir_x(_l,_d+90),y-_vy+lengthdir_y(_l,_d+90))
        draw_primitive_end()
    }
}

// scrShadows renders into its view-local shadow surface.
function scrNTTEFullWorldExtraShadowDraw(_vx,_vy) {
    scrUGShadows(_vx,_vy);
    scrNTTEFullRedBossShadowDraw(_vx,_vy);

    with (NTTEFullCrystalBrainDeath) if (visible) draw_sprite(spr_shadow,0,x-_vx+spr_shadow_x,y-_vy+spr_shadow_y)
    with (NTTEFullGhost) if (visible) draw_sprite(spr_shadow,0,x-_vx+spr_shadow_x,y-_vy+spr_shadow_y)
    with (NTTEFullBeetleChestOpen) if (visible) draw_sprite(spr_shadow,0,x-_vx+spr_shadow_x,y-_vy+spr_shadow_y)
    with (NTTEFullCoastBoss) scrNTTEFullCoastBossTrainShadows(_vx,_vy)
}

function scrNTTEFullQuestPillarCreate() {
    var _num=irandom_range(1,2),_key="QuestPillar"+string(_num)
    spr_idle=scrNTTERefSprite(_key+"Idle"); spr_hurt=scrNTTERefSprite(_key+"Hurt"); spr_dead=scrNTTERefSprite(_key+"Dead")
    sprite_index=spr_idle; depth=-1; mask_index=mskBandit; max_hp=80; size=3
}

function scrNTTEFullQuestPillarAfterCreate() {
    spr_shadow=shd24; snd_hurt=sndNothingHurtHigh; snd_dead=sndNothingHurtLow
}

function scrNTTEFullQuestTorchAfterCreate() {
    spr_idle=scrNTTERefSprite("QuestTorchIdle"); spr_hurt=scrNTTERefSprite("QuestTorchHurt"); spr_dead=scrNTTERefSprite("QuestTorchDead")
    sprite_index=spr_idle; spr_shadow=shd24; spr_shadow_y=-5; depth=-1; mask_index=mskBandit
    snd_hurt=sndNothingHurtHigh; snd_dead=sndNothingHurtLow; max_hp=40; hp=max_hp
}

function scrNTTEFullWorldMiscSmoke() {
    var _ol=GameCont.loops,_oa=GameCont.area; GameCont.loops=0
    var _miner=instance_create(10080,10048,NTTEFullMinerBandit)
    assert(_miner.hp==8 && _miner.light_visible && _miner.sprite_index==scrNTTERefSprite("MinerBanditIdle"),"MinerBandit original protective8HP/light/art changed")
    _miner.light_angle=0; _miner.gunangle=90
    with (_miner) scrNTTEFullMinerBanditStep()
    assert(abs(_miner.light_angle-90*(1-power(0.75,timescale)))<=0.00001,"Miner helmet turn is no longer time-independent1/4lerp")
    var _pillar=instance_create(10080,10048,NTTEFullQuestPillar)
    assert(_pillar.hp==80 && _pillar.size==3 && _pillar.snd_dead==sndNothingHurtLow,"Quest pillar original health/size/audio changed")
    assert(_pillar.spr_idle==scrNTTERefSprite("QuestPillar1Idle") || _pillar.spr_idle==scrNTTERefSprite("QuestPillar2Idle"),"Quest pillar selected invalid original variant")
    var _torch=instance_create(10080,10048,NTTEFullQuestTorch)
    assert(instance_is(_torch,Torch) && _torch.hp==40 && _torch.spr_shadow_y==-5,"Quest torch lost native light/death inheritance or original stats")
    instance_destroy(_miner,false); instance_destroy(_pillar,false); instance_destroy(_torch,false)
    GameCont.loops=_ol; GameCont.area=_oa
    scrNTTESmokeLog("FULL WORLD MINER BANDIT8HP/TIME-INDEPENDENT HELMET TURN + QUEST PILLAR80/VARIANTS + TORCH40/NATIVE LIGHT OK")
}
