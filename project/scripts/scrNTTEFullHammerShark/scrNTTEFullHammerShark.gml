// teoasis.mod.gml901..1084. Physical velocity/acceleration use native timescale.
function scrNTTEFullHammerSharkCreate() {
    spr_idle=scrNTTERefSprite("HammerSharkIdle"); spr_walk=spr_idle; spr_hurt=scrNTTERefSprite("HammerSharkHurt")
    spr_dead=scrNTTERefSprite("HammerSharkDead"); spr_chrg=scrNTTERefSprite("HammerSharkChrg")
    sprite_index=spr_idle; hitid=[spr_idle,"HAMMERHEAD"]; depth=-2; mask_index=mskScorpion
    max_hp=40; raddrop=12; size=2; walk=0; walkspeed=0.8; maxspeed=4; meleedamage=4
    ntte_hammer_direction=random(360); direction=ntte_hammer_direction
    rotate=0; charge=0; charge_dir=0; charge_wait=0; ntte_hammer_alarm=40+random(20)
}
function scrNTTEFullHammerSharkAfterCreate() {
    spr_shadow=shd48; spr_shadow_y=2; snd_hurt=sndSalamanderHurt; snd_dead=sndOasisDeath; snd_mele=sndBigBanditMeleeHit
    direction=ntte_hammer_direction; gunangle=direction; alarm[1]=-1
}
function scrNTTEFullHammerSharkAlarm() {
    ntte_hammer_alarm=30+random(20); scrTarget()
    if (instance_exists(target) && point_distance(x,y,target.x,target.y)<256) {
        var _dir=point_direction(x,y,target.x,target.y),_dis=point_distance(x,y,target.x,target.y)
        if (scrNTTEFullWorldTargetVisible()) {
            if (_dis<96 && random(4)<3) {
                charge=15+random(10); charge_wait=15; charge_dir=_dir; snd_play(sndHammerHeadEnd,0.6,0.25)
            }
            else { scrNTTEFullWorldWalk(_dir+orandom(20),30); rotate=orandom(20) }
        }
        else if (hp<max_hp && random(3)<1) {
            charge=30; charge_wait=15; charge_dir=_dir; ntte_hammer_alarm=charge+charge_wait+random(10)
            snd_play(sndHammerHeadEnd,0.6,0.25)
        }
        else { scrNTTEFullWorldWalk(_dir+orandom(90),random_range(20,30)); rotate=orandom(30) }
    }
    else { scrNTTEFullWorldWalk(direction,30); rotate=orandom(30); ntte_hammer_alarm+=random(walk) }
}
function scrNTTEFullHammerSharkStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_hammer_alarm-=timescale
    if (ntte_hammer_alarm<=0) scrNTTEFullHammerSharkAlarm()
    scrNTTEFullWorldWalkStep()
    if (sprite_index!=spr_chrg || image_index+image_speed>=image_number) sprite_index=scrNTTEFullWorldEnemySprite()
    if (rotate!=0) {
        rotate-=clamp(rotate,-timescale,timescale); direction+=rotate*timescale
        if (speed!=0) scrNTTEFullWorldLook(direction)
    }
    if (charge>0 || charge_wait>0) {
        var _wanted=charge_dir+sin(charge/5)*20
        direction=_wanted+angle_difference(direction,_wanted)*power(2/3,timescale)
        scrNTTEFullWorldLook(direction)
    }
    if (charge_wait>0) {
        charge_wait-=timescale
        x+=(orandom(1)-lengthdir_x(charge_wait/5,charge_dir))*timescale
        y+=(orandom(1)-lengthdir_y(charge_wait/5,charge_dir))*timescale
        sprite_index=choose(spr_hurt,spr_chrg)
        if (charge_wait<=0) { snd_play(sndRatkingCharge,0.4+random(0.2)); scrNTTEFullTrenchShake(x,y,15) }
    }
    else if (charge>0) {
        charge-=timescale
        if (sprite_index!=spr_hurt) sprite_index=spr_chrg
        motion_add(direction,3*timescale*timescale); scrNTTEFullWorldLook(direction)
        // Source probes one movement step forward, then restores the position.
        var _px=x,_py=y,_walls=[]
        x+=hspeed; y+=vspeed
        var _list=ds_list_create(); instance_place_list(x,y,Wall,_list,false)
        for(var _i=0;_i<ds_list_size(_list);++_i) array_push(_walls,_list[|_i])
        ds_list_destroy(_list)
        for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) {
            if (random(2)<1) with(instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,Hammerhead)) motion_add(random(360),timescale)
            instance_create(x,y,Smoke); snd_play(sndHammerHeadProc,0.75,0.5)
            instance_create(x,y,FloorExplo); instance_destroy()
        }
        x=_px; y=_py
        if (current_frame_active) with(instance_create(x+orandom(8),y+8,Dust)) speed=timescale
        if ((charge mod 5)<timescale) scrNTTEFullTrenchShake(x,y,10)
        if (charge<=0) snd_play(sndRatkingChargeEnd,0.6)
    }
}
function scrNTTEFullHammerSharkDeath() { if(hp<=0) scrNTTEFullWorldPickupDrop(30,8,0) }
