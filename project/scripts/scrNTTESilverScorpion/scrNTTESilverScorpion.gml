// NTTE 2.062 tedesert.mod.gml: SilverScorpion + the active VenomFlak attack.
// SilverScorpionFlak/Devastator are commented-out experiments in the original.
function scrNTTESilverCreate() {
    ntte_silver_decision=90
    ntte_silver_fire=-1
    ntte_silver_ammo=0
    ntte_silver_death=false
    snd_hurt=sndSawedOffShotgun
    snd_dead=sndExploGuardianDeadCharge
    snd_mele=sndGoldScorpionMelee
    walkspeed=1.2; maxspeed=2.5;
    spr_shadow=shd48;
}

function scrNTTESilverStep() {
    if (lockstep_stop || hp<=0) return;
    var _decision=false,_fire=false
    ntte_silver_decision-=timescale
    if (ntte_silver_decision<=0) {
        _decision=true
        ntte_silver_decision=irandom_range(60,90)
        direction=random(360)
        ntte_walk=random_range(20,30)
        speed=max(speed,0.4*timescale)
        if (ntte_silver_ammo<=0) {
            scrTarget()
            var _seen=scrTargetIsVisible(target)
            if (instance_exists(target) && (hp<max_hp || _seen)) {
                gunangle=point_direction(x,y,target.x,target.y)
                if (target.x!=x) right=sign(target.x-x)
                direction=gunangle+orandom(40)
                if (!(random(192)<point_distance(x,y,target.x,target.y)-128)) {
                    ntte_silver_decision=irandom_range(75,120)
                    ntte_silver_fire=1
                }
            }
            else gunangle=direction
        }
    }
    // Alarm1_run exits the source Step before alarm2/movement. Do not let a
    // decision fire its newly armed one-tick timer in the same update.
    if(_decision) return;
    if (ntte_silver_fire>=0) {
        ntte_silver_fire-=timescale
        if (ntte_silver_fire<=0) {
            _fire=true
            ntte_silver_fire=-1
            if (ntte_silver_ammo<=0) {
                ntte_silver_ammo=10
                var _flak=scr_projectile_create(x,y,NTTEFullVenomFlak,gunangle,3)
                _flak.friction=0.2*timescale*timescale
                _flak.charge_time=30; _flak.ntte_venom_left=30;
                _flak.image_xscale*=1.25; _flak.image_yscale*=1.25;
                ++ntte_silver_flaks
                snd_play(sndGoldScorpionFire,random_range(1.2,1.4),1)
                snd_play(sndCrownGuardianFire,random_range(0.5,0.7),1)
                snd_play(sndGuardianAppear,random_range(0.5,0.7),1)
            }
            --ntte_silver_ammo
            if (ntte_silver_ammo>0) ntte_silver_fire=3
            scr_projectile_create(x,y,EnemyBullet2,
                gunangle+random_range(20,140)*((ntte_silver_ammo mod 2)<1 ? -1:1),3)
            ++ntte_shots
            snd_play_hit(sndScorpionFire,0.2)
            if (ntte_silver_ammo>0 && sprite_index!=spr_hurt) sprite_index=spr_fire
            else sprite_index=scrNTTEFullWorldEnemySprite()
        }
    }
    if (_fire) return;
    if (ntte_walk>0) {
        ntte_walk-=timescale
        speed+=1.2*timescale*timescale
    }
    speed=min(speed,2.5*timescale)
    if (sprite_index!=spr_fire) sprite_index=scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullSilverScorpionTests() {
    var _silver=instance_create(10080,10080,NTTESilverScorpion);
    scrNTTESmokeLog("SILVER STATS "+string([_silver.max_hp,_silver.meleedamage,_silver.size,_silver.spr_shadow,shd48]));
    assert(_silver.max_hp==70 && _silver.meleedamage==5 && _silver.size==3 && _silver.spr_shadow==shd48,
        "SilverScorpion source identity/stats changed");
    _silver.ntte_silver_decision=9999; _silver.ntte_silver_fire=timescale; _silver.gunangle=0;
    var _n=instance_number(NTTEFullVenomFlak),_bullets=instance_number(EnemyBullet2);
    with(_silver) scrNTTESilverStep();
    assert(_silver.ntte_silver_ammo==9 && instance_number(NTTEFullVenomFlak)==_n+1 && instance_number(EnemyBullet2)==_bullets+1,
        "SilverScorpion did not begin source ten-shot/full venom volley");
    var _flak=instance_find(NTTEFullVenomFlak,_n);
    assert(_flak.charge_time==30 && _flak.ntte_venom_left==30 && _flak.image_xscale==1.25
        && _flak.creator==_silver && _flak.team==_silver.team,"Silver customized flak charge/scale/ownership mismatch");
    with(_flak) scrNTTEFullVenomFlakStep();
    assert(abs(_flak.friction-0.2*timescale*timescale)<0.001,"Silver flak lost custom friction in actual Step");
    repeat(round(27/timescale)) with(_silver) scrNTTESilverStep();
    assert(_silver.ntte_silver_ammo==0 && _silver.ntte_shots==10 && instance_number(NTTEFullVenomFlak)==_n+1,
        "SilverScorpion repeated flak or changed source ten-shot count/timing");
    instance_destroy(_flak,false); instance_destroy(EnemyBullet2,false); instance_destroy(NTTEVenomPellet,false);
    _silver.hp=0;
    var _old_count=instance_number(NTTEFullVenomFlak);
    with(_silver) scrNTTESilverDeath();
    assert(instance_number(NTTEFullVenomFlak)==_old_count+1 && instance_number(EnemyBullet2)==12 && instance_number(NTTEVenomPellet)==12,
        "Silver death did not create source twelve venom/bullet pairs");
    var _deadflak=instance_find(NTTEFullVenomFlak,_old_count);
    assert(!_deadflak.charging && _deadflak.typ==2,"Silver death flak must retain source typ until its original alarm");
    with(EnemyBullet2) assert(creator==_silver && team==_silver.team,"Silver death bullet lost original creator chain");
    with(NTTEVenomPellet) assert(creator==_silver && team==_silver.team,"Silver death venom lost original creator chain");
    with(_silver) scrNTTESilverDeath();
    assert(instance_number(NTTEFullVenomFlak)==_old_count+1,"Silver death reward repeated");
    instance_destroy(_deadflak,false); instance_destroy(_silver,false);
    instance_destroy(EnemyBullet2,false); instance_destroy(NTTEVenomPellet,false);
    scrNTTESmokeLog("FULL SILVER: source stats, exact ten-shot volley, actual charged venom configuration, one-time death/flak child ownership OK");
}

function scrNTTESilverDeath() {
    if (hp>0 || ntte_silver_death || !instance_exists(GameCont)) return;
    ntte_silver_death=true
    instance_create(x,y,PortalClear)
    snd_play(sndSuperSlugger,random_range(1.3,1.5),1)
    scr_screenshake(30)
    for(var _i=0;_i<4;++_i) scrFX(x,y,AcidStreak,direction+45+_i*90,9)
    var _flak=scr_projectile_create(x,y,NTTEFullVenomFlak,direction,0)
    // Original death only clears charging; its existing alarm releases the
    // explosion later. Children inherit the original creator via source
    // projectile_create, just as native scr_damage_create does.
    _flak.charging=false;
    with(_flak) repeat(12) {
        scr_projectile_create(x,y,EnemyBullet2,random(360),random_range(3,5))
        scr_projectile_create(x,y,NTTEVenomPellet,random(360),random_range(8,12))
    }
    scrDrop(0,25)
}

function scrNTTEVenomFlakStep() {
    if (lockstep_stop) return;
    ntte_orb_age+=timescale
    if (!ntte_orb_fired && ntte_orb_age>=ntte_charge) {
        ntte_orb_fired=true
        typ=1
        if (instance_exists(creator)) with (creator) {
            motion_add(gunangle+180,2.5*timescale)
            wkick=min(wkick+9,16)
            snd_play(sndFlakCannon,0.8,0.4)
            snd_play(sndCrystalRicochet,random_range(1.4,1.8),0.8)
            snd_play(sndLightningRifleUpg,0.8,0.4)
        }
    }
    if (!ntte_orb_fired) {
        // Store launch speed while holding the projectile beside its creator.
        speed+=friction+0.3*(1+0.5*GameCont.loops)*timescale*timescale
        if (instance_exists(creator)) {
            var _dis=min(20,speed/timescale*1.5)
            ntte_orb_x=creator.x+lengthdir_x(_dis,direction)
            ntte_orb_y=creator.y+lengthdir_y(_dis,direction)
            if (creator.wkick<8) creator.wkick+=random_range(1,2)*timescale
        }
        x=ntte_orb_x-hspeed
        y=ntte_orb_y-vspeed
        xprevious=x; yprevious=y
        if (current_frame_active && random(4)<1) with (instance_create(x+orandom(4),y+orandom(4),AcidStreak)) {
            sprite_index=sprNTTEAcidPuff
            image_angle=other.direction+orandom(60)
            depth=-2
        }
    }
    else {
        if (ntte_orb_age>=ntte_charge+40) { instance_destroy(); return; }
        if (current_frame_active && random(3)<1) instance_create(x+orandom(2),y+orandom(2),Smoke)
    }
}

function scrNTTEVenomFlakDraw() {
    var _scale=ntte_orb_scale
    if (!ntte_orb_fired) _scale*=0.25+ntte_orb_age/max(1,ntte_charge)+0.1
    draw_sprite_ext(sprite_index,image_index,x,y,_scale,_scale,image_angle,image_blend,image_alpha)
}

function scrNTTEVenomFlakDeath() {
    // Silent instance_destroy(...,false) skips this event during room/portal cleanup.
    if (ntte_orb_done) return;
    ntte_orb_done=true
    instance_create(x,y,PortalClear)
    if (!instance_is(creator,Player)) scrNTTEFullPickupDropBody(50,0)
    for(var _i=0;_i<20;++_i) scrFX(x,y,Smoke,_i*18,4+random(4))
    scr_screenshake(20)
    sleep(10)
    snd_play(sndHeavyMachinegun,1,0.8)
    snd_play(sndSnowTankShoot,1.4,0.7)
    snd_play(sndFrogEggHurt,random_range(0.4,0.6),1)
    for(var _ang=0;_ang<360;_ang+=30) {
        if ((_ang mod 90)==0) {
            for(var _i=0;_i<=4;++_i) with (scr_projectile_create(x,y,NTTEVenomPellet,direction+_ang+orandom(2+_i),2*_i))
                move_contact_solid(direction,4+4*_i)
        }
        else with (scr_projectile_create(x,y,NTTEVenomPellet,direction+_ang+orandom(2),random_range(5.8,6.2)))
            move_contact_solid(direction,6)
    }
}
