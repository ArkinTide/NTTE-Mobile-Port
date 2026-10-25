// tecaves.mod.gml2994..3115. Source RedSpider, actual incoming Vlasma.
function scrNTTEFullRedSpiderCreate() {
    name="RedSpider"
    spr_idle=scrNTTERefSprite("RedSpiderIdle");spr_walk=scrNTTERefSprite("RedSpiderWalk")
    spr_hurt=scrNTTERefSprite("RedSpiderHurt");spr_dead=scrNTTERefSprite("RedSpiderDead")
    sprite_index=spr_idle;hitid=[spr_idle,"RED SPIDER"];depth=-2;mask_index=mskSpider
    max_hp=14;raddrop=4;size=1;walk=0;walkspeed=0.6;maxspeed=4;meleedamage=2
    ntte_red_spider_seen=false;ntte_red_spider_decide=irandom_range(30,60)
}
function scrNTTEFullRedSpiderAfterCreate() {
    spr_shadow=shd24;snd_hurt=sndSpiderHurt;snd_dead=sndSpiderDead;snd_mele=sndSpiderMelee
    canmelee=true;alarm[1]=-1
}
function scrNTTEFullRedEnemyLook(_angle) {
    gunangle=_angle
    var _face=((_angle%360)+360)%360
    if(_face<90 || _face>270) right=1
    else if(_face>90 && _face<270) right=-1
}
function scrNTTEFullRedEnemyWalk(_angle,_ticks) {
    direction=_angle;walk=_ticks
    // Literal source enemy_walk compares logical speed with friction_raw.
    if(speed/timescale<friction) speed=friction*timescale
}
function scrNTTEFullRedSpiderDecision() {
    ntte_red_spider_decide=irandom_range(10,30)
    if(instance_exists(Player)) target=instance_nearest(x,y,Player)
    else if(!instance_exists(target)) target=noone
    if(instance_exists(target)) {
        if(!ntte_red_spider_seen && !collision_line(x,y,target.x,target.y,Wall,false,false)) ntte_red_spider_seen=true
        if(random(3)<2 && point_distance(x,y,target.x,target.y)<96) {
            ntte_red_spider_decide=45;walk=0;speed/=2
            var _angle=point_direction(x,y,target.x,target.y)
            scrNTTEFullRedEnemyLook(_angle)
            for(var _i=-1;_i<=1;++_i) {
                var _dir=_i*90+round(_angle/45)*45+orandom(2),
                    _shot=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(128,_dir),
                        y+lengthdir_y(128,_dir),NTTEFullVlasmaBullet,_dir+180,1)
                _shot.sprite_index=scrNTTERefSprite("EnemyVlasmaBullet")
                _shot.target=id;_shot.target_x=x;_shot.target_y=y
                _shot.my_sound=scrNTTEFullMergedBasicSoundAt(_shot.x,_shot.y,sndHyperCrystalSpawn,0.9+random(0.3),0.8,320)
            }
        }
        else if(ntte_red_spider_seen) {
            scrNTTEFullRedEnemyWalk(point_direction(x,y,target.x,target.y)+orandom(10),15)
            scrNTTEFullRedEnemyLook(direction)
        }
        else {scrNTTEFullRedEnemyWalk(random(360),10);scrNTTEFullRedEnemyLook(direction)}
    }
    else {
        scrNTTEFullRedEnemyWalk(random(360),random_range(5,10));scrNTTEFullRedEnemyLook(direction)
        ntte_red_spider_decide+=walk
    }
}
function scrNTTEFullRedSpiderStep() {
    if(lockstep_stop) return;
    if(hp<=0) {instance_destroy();return;}
    if(ntte_red_spider_decide>0) {
        ntte_red_spider_decide-=timescale
        if(ntte_red_spider_decide<=0) {ntte_red_spider_decide=-1;scrNTTEFullRedSpiderDecision()}
    }
    if(walk>0) {walk-=timescale;speed+=walkspeed*timescale*timescale}
    if(speed>maxspeed*timescale) speed=maxspeed*timescale
    sprite_index=scrNTTEFullWorldEnemySprite()
}
function scrNTTEFullRedSpiderDraw() {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullRedSpiderHurt(_target,_damage,_direction,_force,_attacker) {
    // Full authored callback, entered once by ordinary, raw and NP adapters.
    with(_target) {
        hp-=_damage;nexthurt=current_frame+6
        scrNTTEFullNativeMotionAddFT(id,is_undefined(_direction)?0:_direction,_force/timescale)
        snd_play_hit(snd_hurt,0.2);sprite_index=spr_hurt;image_index=0
        ntte_red_spider_seen=true
    }
    return true
}
function scrNTTEFullRedSpiderDeath() {
    if(hp>0) return;
    scrNTTEFullWorldPickupDrop(20,0)
    var _impact=scrNTTEFullMergedBasicProjectileCreate(x,y,PlasmaImpact)
    scrNTTEFullVlasmaTeam(_impact,scrNTTERefSprite("EnemyPlasmaImpact"))
    _impact.mask_index=mskPopoPlasmaImpact
    scrNTTEFullWorldWallClear(_impact)
    snd_play_hit_big(sndPlasmaHit,0.2)
}
