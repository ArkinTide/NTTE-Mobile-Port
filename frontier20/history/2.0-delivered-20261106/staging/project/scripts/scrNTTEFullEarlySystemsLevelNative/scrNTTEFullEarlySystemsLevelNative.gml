// ntte.mod.gml 291..349,378..381,414..502. The coordinating canonical
// pipeline interleaves the world-owned BigBandit/Cactus/Spiderling providers.
function scrNTTEFullGroundedLevelStart() {
    var _count=0
    with(WepPickup) if((wep==wep_guitar || wep==wep_black_sword)
        && !scrNTTEFullValue(id,"roll",false)) {
        var _pickup=id,_ground=instance_create(xstart,ystart,NTTEFullWepPickupGrounded)
        _ground.target=_pickup
        with(_ground) move_contact_solid(random(360),random_range(24,32))
        scrNTTEFullWorldBudge(_ground,NTTEFullWepPickupGrounded,32)
        with(Player) if(scrNTTEFullValue(id,"nearwep",noone)==_pickup) nearwep=noone
        _count++
    }
    return _count
}
function scrNTTEFullCrimeLevelStart(_normal) {
    if(scrNTTEFullCrownKey(GameCont.crown)!="crime") return false
    scrNTTEFullCrimeAreaStart(_normal,instance_exists(scrNTTEFullWorldEventGet("GatorAmbush")),10016,10016)
    return true
}
function scrNTTEFullManholeLevelStart() {
    var _count=0
    with(PizzaEntrance) {
        instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,NTTEFullManhole)
        instance_destroy(id,false)
        _count++
    }
    return _count
}
function scrNTTEFullBackpackLevelStart(_normal) {
    if(GameCont.hard<=4 || GameCont.area==area_hq) return 0
    // Source consumes the 1/12 roll before checking normal-area eligibility.
    if(!(GameCont.area==area_campfire || (random(12)<1 && _normal))) return 0
    var _floors=scrNTTEFullLoadingShuffle(scrNTTEFullInstances(Floor,true)),_count=0,_selected=false
    // NTTE BACKPACK FIRST SOURCE CANDIDATE ONLY
    for(var _i=0;_i<array_length(_floors);++_i) {
        with(_floors[_i]) {
        if(distance_to_object(Player)>80 && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) {
            _selected=true
            var _rebel=0,_rogue=0,_bodies=scrNTTEFullInstances([Player,Revive])
            for(var _j=0;_j<array_length(_bodies);++_j) with(_bodies[_j]) {
                if(race==Race.Rebel) _rebel++
                if(GameCont.area==area_campfire && ((race==Race.Rogue && GameCont.loops<=1)
                    || scrNTTEFullWeaponRaw(wep)==wep_rogue_rifle || scrNTTEFullWeaponRaw(bwep)==wep_rogue_rifle)) _rogue++
            }
            var _num=max(1,_rogue)+scr_skill_get(mut_open_mind),_cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
            if(_num>0) {
                repeat(_num) {
                    // Evaluate the source coordinate draws before choosing
                    // the chest type; constructors consume their own RNG.
                    var _x=_cx+orandom(4),_y=_cy-6+orandom(min(4,_num-1)),_kind="RogueBackpack"
                    if(_rogue<=0) _kind=random(4)<_rebel+scrNTTEFullValue(GameCont,"ntte_backpack_opened",false)
                        ? "AllyBackpack":"Backpack"
                    scrNTTEFullLairChestCreate(_x,_y,_kind,true)
                    _count++
                }
                if(GameCont.area!=area_campfire) instance_create(_cx+orandom(8),_cy+irandom(8),NTTEFullBackpacker)
                instance_create(_cx,_cy,PortalClear)
            }
            break
        }
        }
        if(_selected) break
    }
    return _count
}
function scrNTTEFullAllyBackpackCreate() {
    sprite_index=scrNTTERefSprite("AllyBackpack");spr_dead=scrNTTERefSprite("AllyBackpackOpen")
    curse=0;ally=1+scr_ultra_get(Race.Rebel,UltraSkill.Riot)
}
function scrNTTEFullRogueBackpackCreate() {
    sprite_index=scrNTTERefSprite("RogueBackpack");spr_dead=scrNTTERefSprite("RogueBackpackOpen")
    spr_shadow=shd16;spr_shadow_y=2;snd_open=choose(sndMenuASkin,sndMenuBSkin);num=2
    on_open=scrNTTEFullRogueBackpackOpen
}
function scrNTTEFullRogueBackpackOpen(_opener) {
    if(snd_open==sndMenuASkin || snd_open==sndMenuBSkin) snd_play(sndWeaponChest,0.5)
    if(num>0) {
        var _angle=random(360)
        for(var _dir=_angle;_dir<_angle+360;_dir+=360/num) {
            var _ammo=instance_create(x,y,RogueAmmo)
            scrNTTEFullBackpackWrap(_ammo,_dir)
        }
    }
    if(!instance_is(_opener,Player)) return;
    var _upgraded=false,_x=x,_y=y
    with(_opener) {
        if(scrNTTEFullWeaponRaw(wep)==wep_rogue_rifle) {
            wep=wep_ntte_rogue_carbine;ntte_state=scrNTTENewState(wep)
            drawempty=30;swapmove=1;swapanim=-1;_upgraded=true
        }
        else if(scrNTTEFullWeaponRaw(bwep)==wep_rogue_rifle) {
            bwep=wep_ntte_rogue_carbine;bntte_state=scrNTTENewState(bwep)
            drawemptyb=30;_upgraded=true
        }
        if(_upgraded) {
            scrPopupCreate(x,y,scr_weapon_get_name(wep_ntte_rogue_carbine))
            var _explosion=scr_damage_create(_x,_y,PopoExplosion)
            _explosion.sprite_index=sprRogueExplosion;_explosion.mask_index=mskExplosion
            snd_play_hit_big(sndIDPDNadeExplo,0.2)
            snd_play(snd_chst);snd_play(scrNTTEFullWeaponSwapSound(wep_ntte_rogue_carbine),0.6)
        }
    }
}
