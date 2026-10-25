// telabs.mod.gml1644..1994. Native enemy, source logical timers and genuine
// incoming Vlasma projectiles; HQ/Heart placement remains with world builders.
function scrNTTEFullPopoSecurityCreate() {
    wep_list=[scrNTTERefSprite("PopoSecurityMinigun"),scrNTTERefSprite("PopoSecurityCannon")]
    wep_index=irandom(array_length(wep_list)-1);spr_weap=wep_list[wep_index]
    spr_idle=scrNTTERefSprite("PopoSecurityIdle");spr_walk=scrNTTERefSprite("PopoSecurityWalk")
    spr_hurt=scrNTTERefSprite("PopoSecurityHurt");spr_dead=scrNTTERefSprite("PopoSecurityDead")
    sprite_index=spr_idle;hitid=[spr_idle,"SECURITY GUARD"];depth=-2
    mask_index=mskLilHunter;max_hp=95;raddrop=0;size=2;meleedamage=0
    ammo=0;walk=0;walkspeed=0.8;maxspeed=2.5;freeze=0
    queueswap=false;swap_kick=0;aim_x=xstart;aim_y=ystart
    ntte_security_decide=60;ntte_security_fire=-1
}
function scrNTTEFullPopoSecurityAfterCreate() {
    spr_shadow=shd24;spr_shadow_y=3;team=3;friction=0.4*timescale*timescale
    male=choose(true,false);snd_hurt=male?sndEliteGruntHurt:sndShielderHurtF
    snd_dead=male?sndEliteGruntDead:sndShielderDeadF
    wkick=0;right=1;gunangle=0;alarm[1]=-1;alarm[2]=-1
}
function scrNTTEFullPopoSecurityDecision() {
    ntte_security_decide=30
    if(queueswap) {
        queueswap=false;wep_index=(wep_index+1)%array_length(wep_list)
        spr_weap=wep_list[wep_index];swap_kick=1
        instance_create(x+lengthdir_x(10,gunangle),y+lengthdir_y(10,gunangle),WepSwap)
        snd_play_hit(sndSwapEnergy,0.3);ntte_security_decide=10
    }
    else if(ammo<=0) {
        // Source enemy_target prefers the nearest Player, retaining its prior
        // target only when no Player exists. Team3 is not a native team1 AI.
        if(instance_exists(Player)) target=instance_nearest(x,y,Player)
        else if(!instance_exists(target)) target=noone
        if(instance_exists(target) && (scrNTTEFullWorldTargetVisible() || random(600)<freeze)) {
            ntte_security_decide=random_range(10,20)
            scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
            if(point_distance(x,y,target.x,target.y)<128) {
                if(random(3)<2) ntte_security_fire=1
                else scrNTTEFullWorldWalk(gunangle+random_range(30,90)*choose(-1,1),random_range(10,20))
            }
            else scrNTTEFullWorldWalk(gunangle+orandom(30),random_range(10,20))
        }
        else if(random(3)<2) {
            ntte_security_decide=random_range(20,30)
            scrNTTEFullWorldWalk(random(360),random_range(20,40));scrNTTEFullWorldLook(direction)
        }
    }
}
function scrNTTEFullPopoSecurityAttack() {
    if(ammo<=0) ammo=wep_index==0?irandom_range(8,12):1
    if(ammo<=0) return;
    ntte_security_fire=1
    if(instance_exists(target)) {
        scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        var _distance=point_distance(x,y,target.x,target.y)+48
        aim_x=x+lengthdir_x(_distance,gunangle);aim_y=y+lengthdir_y(_distance,gunangle)
    }
    var _cannon=wep_index==1
    if(_cannon) {
        scrNTTEFullMergedBasicSoundAt(x,y,sndGruntFire,0.6+random(0.2),4,320)
        scrNTTEFullMergedBasicSoundAt(x,y,sndPlasmaBig,1.4+random(0.2),2,320)
    }
    else {
        ntte_security_fire=5
        scrNTTEFullMergedBasicSoundAt(x,y,sndEliteShielderFire,1.4+random(0.2),2,320)
    }
    wkick=8;scrNTTEFullNativeMotionAddFT(id,gunangle,_cannon?4:2)
    move_contact_solid(gunangle,_cannon?4:2)
    var _length=sprite_get_width(spr_weap)-sprite_get_xoffset(spr_weap)+4,
        _scatter=_cannon?5:3,_count=_cannon?irandom_range(4,7):irandom_range(2,3)
    repeat(_count) {
        var _trail=scrNTTEFullMergedStockFX([x+lengthdir_x(_length,gunangle),_scatter],
            [y+lengthdir_y(_length,gunangle),_scatter],[gunangle+180,random(2)],PlasmaTrail)
        scrNTTEFullVlasmaTeam(_trail,sprPopoPlasmaTrail)
    }
    var _shot=scrNTTEFullMergedBasicProjectileCreate(aim_x,aim_y,
        _cannon?NTTEFullVlasmaCannon:NTTEFullVlasmaBullet,gunangle+180)
    scrNTTEFullVlasmaTeam(_shot,sprPopoPlasmaTrail)
    _shot.target=id;_shot.target_x=x;_shot.target_y=y
    _shot.my_sound=snd_play_hit(sndEliteGruntRocketFly,0.3)
    scrNTTEFullMergedBasicSoundAt(_shot.x,_shot.y,sndPlasmaReload,1.3+random(0.3),0.5,320)
    ammo-=1
    if(ammo<=0) {
        ntte_security_fire=-1
        if(random(3)<2) {queueswap=true;ntte_security_decide=10}
        else ntte_security_decide=random_range(20,30)
    }
}
function scrNTTEFullPopoSecurityStep() {
    if(lockstep_stop) return;
    if(hp<=0) {instance_destroy();return}
    // Both original callbacks return void: alarm1 may start alarm2 and the
    // second timer is processed in this same source step, before movement.
    if(ntte_security_decide>0) {
        ntte_security_decide-=timescale
        if(ntte_security_decide<=0) {ntte_security_decide=-1;scrNTTEFullPopoSecurityDecision()}
    }
    if(ntte_security_fire>0) {
        ntte_security_fire-=timescale
        if(ntte_security_fire<=0) {ntte_security_fire=-1;scrNTTEFullPopoSecurityAttack()}
    }
    scrNTTEFullWorldWalkStep();sprite_index=scrNTTEFullWorldEnemySprite()
    if(swap_kick!=0) swap_kick=approach(swap_kick,0,timescale)
    with(Player) {
        if(speed>0 || hp<max_hp) other.freeze+=timescale
        if(!can_shoot) other.freeze+=3*timescale
    }
}
function scrNTTEFullPopoSecurityDraw() {
    var _flash=sprite_index==spr_hurt && image_index<1,
        _back=wep_list[(wep_index+1)%array_length(wep_list)]
    if(_flash) gpu_set_fog(true,c_white,0,0)
    draw_sprite_ext(_back,0,x,y+swap_kick,1,right,90+20*right,merge_color(image_blend,c_black,0.25),image_alpha)
    if(_flash) gpu_set_fog(false,c_white,0,0)
    if(gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,gunangle),y-swap_kick-lengthdir_y(wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if(gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullPopoSecurityDeath() {
    if(hp>0) return;
    for(var _i=0;_i<2;++_i) scrNTTEFullPickupDropBody(50,60,_i)
    with(enemy) if(variable_instance_exists(id,"freeze") && is_numeric(freeze)) freeze+=100
    with(WantVan) canspawn=true
    var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite("PopoAlert"),id)
    _alert.vspeed=-timescale;_alert.image_index=0;_alert.image_speed=0
    _alert.alert_color=make_color_rgb(245,184,0);_alert.alert_hold=30
    _alert.blink=10;_alert.flash=6;_alert.snd_flash=sndEliteIDPDPortalSpawn
    var _angle=random(360)
    for(var _dir=_angle;_dir<_angle+360;_dir+=180) {
        var _spawn=instance_create(x,y,IDPDSpawn)
        with(_spawn) {
            elite=true;freak=false;x=other.x;y=other.y
            move_contact_solid(_dir+orandom(30),random_range(32,128))
        }
        _alert=scrNTTEAlertCreate(_spawn.x,_spawn.y,scrNTTERefSprite("PopoEliteAlert"),_spawn)
        _alert.vspeed=-0.8*timescale;_alert.image_speed=0.1*timescale
        _alert.alert_sprite=scrNTTERefSprite("AlertIndicatorPopo");_alert.alert_x=-5;_alert.alert_y=5
        _alert.alert_hold=_spawn.alarm[0]+15;_alert.blink=15;_alert.flash=10;_alert.snd_flash=sndIDPDNadeAlmost
    }
}
