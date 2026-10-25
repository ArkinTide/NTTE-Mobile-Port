// Original tegeneral5305..5610. The visible TopPot owns native wall/floor
// collision. The controller retains eye animation and releases real occupants.
function scrNTTEFullWallEnemyCreateAt(_x,_y) {
    var _area=GameCont.area,_sprite=-1,_touch=scrNTTEFullRectInstances(_x,_y,_x,_y,[TopSmall,Wall])
    for(var _i=0;_i<array_length(_touch);++_i) with (_touch[_i]) {
        var _s=instance_is(id,Wall) ? topspr:sprite_index
        if (_s==sprWall1Top || _s==sprWall1Trans) _area=area_desert
        if (_s==sprWall4Top || _s==sprWall4Trans) _area=area_caves
    }
    if (_area==area_desert) _sprite=scrNTTERefSprite("WallBandit")
    if (_area==area_caves) _sprite=scrNTTERefSprite(position_meeting(_x,_y,Wall) ? "WallSpiderling":"WallSpiderlingTrans")
    if (!sprite_exists(_sprite)) return noone
    var _enemy=instance_create(_x,_y,NTTEFullWallEnemy)
    with (_enemy) {
        visible=false; sprite_index=_sprite; image_index=irandom(image_number-1); image_speed=0
        mask_index=-1; area=_area; special=false; eyeblink=random(10000); eyedir=90
        if (area==area_desert) image_xscale=choose(-1,1)
        if (area==area_caves && place_meeting(x,y,Wall)) {
            var _walls=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall)
            for(var _j=0;_j<array_length(_walls);++_j) with (_walls[_j]) if (topspr==sprWall4Top && place_meeting(x,y,_enemy)) topindex=irandom(1)
        }
        target=instance_create(x,y,TopPot)
        with (target) {
            name="NTTEWallEnemy"; x=other.x; y=other.y
            mask_index=other.mask_index; sprite_index=other.sprite_index; image_index=other.image_index; image_speed=other.image_speed
            image_xscale=other.image_xscale; image_yscale=other.image_yscale; image_angle=other.image_angle; image_blend=other.image_blend; image_alpha=other.image_alpha
        }
    }
    return _enemy
}
function scrNTTEFullWallEnemyStep() {
    if (lockstep_stop) return;
    if (!instance_exists(target)) { instance_destroy(); return }
    x=target.x; y=target.y
    if (area==area_desert) {
        eyeblink+=timescale
        var _dir=90,_players=[],_n=instance_number(Player)
        for(var _i=0;_i<_n;++_i) { var _p=instance_find(Player,_i); if (_p.visible) array_push(_players,_p) }
        var _near=scrNTTEFullWorldNearestRectPoint(x,y,x,y,_players)
        if (instance_exists(_near) && point_distance(x,y,_near.x,_near.y)<8+64*(position_meeting(x,y,Wall) ? 1:2)*(instance_exists(enemy) ? 2:1)) {
            _dir=_near.y<y-8 ? 270+30*sin(eyeblink/40):point_direction(x,y-8,_near.x,_near.y)
        }
        eyedir=(eyedir+angle_difference(_dir,eyedir)*(1-power(0.8,timescale))+360) mod 360
        var _num=0.5+0.5*(angle_difference(eyedir,270)/120),_blink=((eyeblink mod 250)<6 || (eyeblink mod 300)<6)
        with (target) {
            image_index=0
            if (distance_to_object(projectile)<8) other.eyeblink=-random_range(3,6)
            else if (_num>=0 && _num<=1 && !_blink) {
                if (sign(image_xscale)<0) _num=1-_num
                image_index=round(lerp(1,image_number-1,_num))
            }
        }
    }
    else if (area==area_caves && special>0 && random(90)<special*timescale) {
        with (instance_create(x+orandom(12),y-8+orandom(12),CaveSparkle)) { sprite_index=scrNTTERefSprite("PetSparkle"); depth=-9 }
    }
}
function scrNTTEFullWallEnemyLaunch(_target,_zs,_speed,_dir) {
    var _bag=instance_create(_target.x,_target.y,NTTEFullBackpackPickup)
    _bag.target=_target; _bag.zspeed=_zs; _bag.speed=_speed*timescale; _bag.direction=_dir
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    return _bag
}
function scrNTTEFullWallEnemyDestroy() {
    if (instance_exists(target)) { x=target.x; y=target.y; instance_destroy(target) }
    if (!place_meeting(x,y,Floor)) return;
    if (area==area_desert) {
        var _object=Bandit
        if (scrCrownCheck(NTTEFullCrown.Crime) && scrNTTEFullValue(GameCont,"ntte_crime_active",false)) _object=Gator
        with (instance_create(x,y,_object)) {
            if (scrNTTEFullPortalPointSeen(x,y,-1)) {
                var _alert=scrNTTEAlertCreate(x,y,scrNTTERefSprite(instance_is(id,Gator) ? "GatorPatchAlert":"BanditAlert"),id)
                _alert.alert_hold=60; _alert.blink=15; _alert.flash=6
            }
            if (instance_is(id,Gator)) {
                spr_idle=scrNTTERefSprite("PatchGatorIdle"); spr_walk=scrNTTERefSprite("PatchGatorWalk"); spr_hurt=scrNTTERefSprite("PatchGatorHurt"); spr_dead=scrNTTERefSprite("PatchGatorDead"); hitid=[spr_idle,"GATOR"]
            }
            var _floors=scrNTTEFullInstances(Floor,true),_near=scrNTTEFullWorldNearestRectBBox(x,y,x,y,_floors)
            if (instance_exists(_near)) direction=point_direction(x,y,(_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2)+orandom(30)
            scrNTTEFullWallEnemyLaunch(id,random_range(2.5,5),random_range(1,2.5),direction)
            var _pickup_types=[HPPickup,AmmoPickup,RogueAmmo,WepPickup,NTTEFullCustomPickup,NTTEPickup,chestprop]
            var _before=scrNTTEFullInstances(_pickup_types)
            scrNTTEFullWorldPickupDrop(100/scrNTTEFullPickupChanceMultiplier(),0)
            var _pickups=scrNTTEFullInstances(_pickup_types)
            for(var _i=0;_i<array_length(_pickups);++_i) if (array_get_index(_before,_pickups[_i])<0) {
                var _bag=instance_create(_pickups[_i].x,_pickups[_i].y,NTTEFullBackpackPickup)
                _bag.target=_pickups[_i]; _bag.direction=direction+orandom(60)
                with (_bag) scrNTTEFullBackpackPickupEndStep()
            }
            wkick=8
            if (random(15)<1) with (instance_create(x,y,Shell)) {
                motion_set(other.direction+orandom(60),4*timescale); sprite_index=sprSodaCan; image_index=irandom(image_number-1); image_speed=0
            }
            snd_play(sndWallBreakCrystal,2+random(0.5),1.6)
        }
    }
    else if (area==area_caves) {
        if (special) {
            with (scrNTTEFullPetCreate(x,y,"Spider")) {
                sprite_index=spr_hurt; snd_play(sndSpiderMelee,0.6+random(0.2),1.5)
                var _alert=scrNTTEAlertCreate(x,y,spr_icon,id)
                _alert.alert_x--; _alert.alert_color=make_color_rgb(16,226,165); _alert.blink=15; _alert.flash=6
            }
        }
        else repeat(irandom_range(1,3)) {
            if (random(5)<3) with (instance_create(x,y,NTTEFullSpiderling)) {
                sprite_index=spr_hurt; snd_play(sndSpiderHurt,0.5+random(0.3),1.5)
                scrNTTEFullWallEnemyLaunch(id,random_range(2,4),random_range(1,2.5),random(360))
            }
            with (instance_create(x+orandom(8),y-8+orandom(8),CaveSparkle)) { sprite_index=scrNTTERefSprite("PetSparkle"); depth=-3 }
        }
    }
}
function scrNTTEFullWallEnemySmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_desert; scrNTTEFullFloorSetAlign(32,32,43000,43000); scrNTTEFullFloorFill(43000,43000,3)
    var _wall=instance_create(43000,43000,Wall),_e=scrNTTEFullWallEnemyCreateAt(43008,43008)
    assert(instance_exists(_e) && instance_exists(_e.target) && _e.target.name=="NTTEWallEnemy" && _e.sprite_index==scrNTTERefSprite("WallBandit"),"WallEnemy omitted source TopPot/sprite/area controller")
    var _bandits=instance_number(Bandit)
    instance_destroy(_e)
    assert(instance_number(Bandit)==_bandits+1 && instance_number(NTTEFullBackpackPickup)>0,"WallEnemy did not release and launch a real Bandit")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign()
    scrNTTESmokeLog("FULL WORLD WALLENEMY SOURCE TOPPOT/SPRITE/AREA/REAL BANDIT RELEASE AND AIRBORNE WRAPPER OK")
}
