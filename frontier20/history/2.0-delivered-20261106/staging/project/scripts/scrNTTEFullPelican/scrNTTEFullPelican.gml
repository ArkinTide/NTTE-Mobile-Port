// tecoast3147..3336. Uses logical timers in place of integer alarm1/2.
function scrNTTEFullPelicanCreate() {
    spr_idle=scrNTTERefSprite("PelicanIdle"); spr_walk=scrNTTERefSprite("PelicanWalk")
    spr_hurt=scrNTTERefSprite("PelicanHurt"); spr_dead=scrNTTERefSprite("PelicanDead"); spr_chrg=scrNTTERefSprite("PelicanChrg")
    // Imported base frame0 is the exact original hammer raster. shnWep's
    // generated shine frames remain a shared importer precision dependency.
    spr_weap=scrNTTERefSprite("Base.PelicanHammer"); sprite_index=spr_idle; hitid=[spr_idle,"PELICAN"]
    mask_index=object_get_mask(RhinoFreak); depth=-2; max_hp=45; raddrop=20; size=2
    walk=0; walkspeed=0.6; maxspeed=3; dash=0; dash_factor=1.25; chrg_time=24
    wepangle=choose(-140,140); ntte_pelican_decide_left=30+irandom(60); ntte_pelican_charge_left=-1
}
function scrNTTEFullPelicanAfterCreate() {
    spr_shadow=shd32; spr_shadow_y=6; snd_hurt=sndGatorHit; snd_dead=sndGatorDie
    gunangle=random(360); direction=gunangle; alarm[1]=-1; alarm[2]=-1
}
function scrNTTEFullPelicanDecision() {
    ntte_pelican_decide_left=40+random(20)
    if (ntte_pelican_charge_left>=0) with (instance_create(x+lengthdir_x(18,gunangle+wepangle),y+lengthdir_y(18,gunangle+wepangle),ThrowHit)) {
        image_speed=0.5*timescale; depth=-3
    }
    scrTarget()
    if (scrNTTEFullWorldTargetVisible() && point_distance(x,y,target.x,target.y)<320) {
        var _distance=point_distance(x,y,target.x,target.y)
        scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        if (((_distance<128 && random(3)<2) || random(hp)<1) && ntte_pelican_charge_left<0) {
            ntte_pelican_charge_left=chrg_time; ntte_pelican_decide_left=chrg_time-10
            scrNTTEFullWorldWalk(gunangle+180+orandom(10),5)
            with (instance_create(x,y,NTTEFullAssassinNotice)) depth=-3
            snd_play(sndRavenHit,0.5+random(0.1))
        }
        else scrNTTEFullWorldWalk(gunangle+orandom(10),random_range(20,30))
    }
    else {
        ntte_pelican_decide_left=90+random(30)
        scrNTTEFullWorldWalk(random(360),random_range(10,15)); scrNTTEFullWorldLook(direction)
    }
}
function scrNTTEFullPelicanAttack() {
    ntte_pelican_decide_left=40+random(20); ntte_pelican_charge_left=-1
    dash=12; motion_set(gunangle,maxspeed*timescale)
    var _slash=scr_projectile_create(x,y,EnemySlash,gunangle,(dash-2)*dash_factor)
    _slash.sprite_index=sprHeavySlash; _slash.friction=0.4*timescale*timescale; _slash.damage=10
    wkick=-4; wepangle=-wepangle
    scr_screenshake(20)
    snd_play(sndEnergyHammer); snd_play(sndHammer,0.75); snd_play(sndRavenScreech,0.5+random(0.1))
    return _slash
}
function scrNTTEFullPelicanStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_pelican_decide_left-=timescale
    if (ntte_pelican_decide_left<=0) scrNTTEFullPelicanDecision()
    if (ntte_pelican_charge_left>=0) {
        ntte_pelican_charge_left-=timescale
        if (ntte_pelican_charge_left<=0) scrNTTEFullPelicanAttack()
    }
    scrNTTEFullWorldWalkStep()
    if (dash>0) {
        dash-=timescale; motion_add(direction,dash*dash_factor*timescale*timescale)
        if (sprite_index!=spr_hurt) sprite_index=dash>0 ? spr_chrg:spr_walk
        if (current_frame_active) {
            instance_create(x+orandom(3),y+random(6),Dust)
            with (instance_create(x+orandom(3),y+random(6),Dust)) motion_add(other.direction+orandom(45),(4+random(1))*other.dash_factor*timescale)
        }
    }
    // The source assigns enemy_sprite after its temporary dash pose; preserve
    // that ordering, including the walk sprite selected during movement.
    sprite_index=scrNTTEFullWorldEnemySprite()
}
function scrNTTEFullPelicanDraw() {
    var _charge=max(ntte_pelican_charge_left,0),_offset=sign(wepangle)*(60*(_charge/chrg_time))
    var _angle=gunangle+(wepangle-_offset)*(1-wkick/20)
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,_angle),y-lengthdir_y(wkick,_angle),1,1,_angle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullPelicanKnockback(_force) {
    // Native projectile knockback is physical speed; original speed was logical.
    return dash>0 ? min(_force,speed-timescale):_force
}
function scrNTTEFullPelicanDeath() {
    if (hp<=0) { scrNTTEFullWorldPickupDrop(60,20,0); scrNTTEFullWorldPickupDrop(80,0,1) }
    // Source cool_hammer is a weapon_sprt wrapper, requiring merged/native
    // weapon-state rendering integration before the drop is visually identical.
}
function scrNTTEFullPelicanSmoke() {
    var _p=instance_create(10080,10048,NTTEFullPelican)
    assert(_p.hp==45 && _p.raddrop==20 && _p.size==2 && _p.chrg_time==24 && _p.spr_shadow_y==6,"Pelican original stats/shadow/charge duration changed")
    var _old=_p.wepangle,_slash=noone
    with (_p) _slash=scrNTTEFullPelicanAttack()
    assert(_p.dash==12 && _p.wepangle==-_old && _p.wkick==-4 && _p.ntte_pelican_decide_left>=40 && _p.ntte_pelican_decide_left<=60,"Pelican attack timing/hammer reversal changed")
    assert(instance_is(_slash,EnemySlash) && _slash.damage==10 && _slash.sprite_index==sprHeavySlash && abs(_slash.speed-12.5*timescale)<=0.00001,"Pelican heavy slash lost original10damage/12.5speed")
    assert(abs(_slash.friction-0.4*timescale*timescale)<=0.00001 && _slash.team==team_enemy,"Pelican heavy slash lost logical friction/faction")
    var _reduced=0
    with (_p) _reduced=scrNTTEFullPelicanKnockback(20*timescale)
    assert(abs(_reduced-2*timescale)<=0.00001,"Pelican dash knockback limit changed")
    instance_destroy(_slash,false); instance_destroy(_p,false)
    scrNTTESmokeLog("FULL WORLD PELICAN45HP/24TELL + DASH12/HEAVY SLASH10/12.5SPEED + HAMMER REVERSAL/KNOCKBACK LIMIT OK")
}
