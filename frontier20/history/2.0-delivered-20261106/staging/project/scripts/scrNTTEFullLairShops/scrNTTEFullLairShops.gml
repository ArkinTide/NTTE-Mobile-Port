// tepickups495..628,1549..2709,4611..4707. Native prompt input, original
// sibling-stock transactions, and real merged-weapon / OrchidBall products.
function scrNTTEFullShopSound(_sound,_gain=1,_pitch=1) { return snd_play(_sound,_pitch,_gain) }

function scrNTTEFullShopCrownKey() {
    switch(GameCont.crown) {
        case Crown.Love:return "love"
        case Crown.Life:return "life"
        case Crown.Guns:return "guns"
    }
    return scrNTTEFullCrownKey(GameCont.crown)
}

enum NTTEFullShopType { Basic, Weapon, Skill }

function scrNTTEFullShopRace(_player) {
    var _race=_player.race
    if (is_string(_race)) return _race
    switch (_race) {
        case Race.Venuz: return "venuz"
        case Race.Rogue: return "rogue"
    }
    return scrNTTEFullValue(_player,"ntte_full_race_key","")
}

function scrNTTEFullShopText(_text,_target=-1,_time=18) {
    var _popup=instance_create(x,y,PopupText)
    _popup.mytext=_text;_popup.ntte_translate=true; if(_target>=0) _popup.ntte_full_target=_target
    _popup.alarm[1]=_time
    return _popup
}

function scrNTTEFullShopPoolPick(_pool) {
    var _keys=variable_struct_get_names(_pool),_total=0
    for(var _i=0;_i<array_length(_keys);++_i) _total+=max(0,variable_struct_get(_pool,_keys[_i]))
    if (_total<=0) return undefined
    var _pick=random(_total)
    for(var _i=0;_i<array_length(_keys);++_i) {
        _pick-=max(0,variable_struct_get(_pool,_keys[_i]))
        if (_pick<0) return _keys[_i]
    }
    return undefined
}

function scrNTTEFullCatChestCreate() {
    sprite_index=scrNTTERefSprite("CatChest"); spr_dead=scrNTTERefSprite("CatChestOpen")
    snd_open=sndAmmoChest; on_open=scrNTTEFullCatChestOpen
}

function scrNTTEFullCatChestOpen(_opener) {
    scrNTTEFullShopSound(sndEnergySword,0.8,0.5+orandom(0.1)); scrNTTEFullShopSound(sndLuckyShotProc,0.7,0.8+orandom(0.1))
    if (instance_is(_opener,Player)) scrNTTEFullShopText("PICK ONE!",_opener.index)
    instance_create(x,y,PortalClear)
    var _hard=GameCont.hard,_pool={ammo:1,health:1,rads:1,bonus_ammo:(_hard>=6),bonus_health:(_hard>=6),
        hammerhead:0.3*(_hard>=10),spirit:0.3*(_hard>=12),turret:0.7*(GameCont.loops>0),
        coat:0,rogue:0,parrot:0,bone:0,bones:0,red:0}
    // The optional Defpack Tools soda pool only exists with that extension.
    with (Player) {
        switch(scrNTTEFullShopRace(id)) {
            case "venuz": if(!scrNTTEFullUnlockGet("skin:coat venuz")) _pool.coat++; break
            case "rogue": _pool.rogue++; break
            case "parrot": _pool.parrot++; break
        }
        var _front=scrNTTEFullWeaponRaw(wep),_back=scrNTTEFullWeaponRaw(bwep)
        if (_hard>=4 && (_front==wep_ntte_bone || _back==wep_ntte_bone)) _pool.bone=0.5
        if (scrNTTEIsScythe(_front) || scrNTTEIsScythe(_back)) _pool.bones++
        if (variable_global_exists("ntte_full_weapon_red") && is_callable(global.ntte_full_weapon_red)) {
            if (global.ntte_full_weapon_red(wep)>0 || global.ntte_full_weapon_red(bwep)>0) _pool.red++
        }
    }
    for(var _ang=-50;_ang<=50;_ang+=50) {
        var _shop=instance_create(x,y,NTTEFullChestShop)
        _shop.x+=lengthdir_x(28,_ang+90); _shop.y+=lengthdir_y(28,_ang+90)
        _shop.type=NTTEFullShopType.Basic; _shop.creator=id
        var _drop=scrNTTEFullShopPoolPick(_pool)
        if (!is_undefined(_drop)) { _shop.drop=_drop; variable_struct_set(_pool,_drop,variable_struct_get(_pool,_drop)-1) }
    }
}

function scrNTTEFullBatChestCreate() {
    sprite_index=scrNTTERefSprite("BatChest"); spr_dead=scrNTTERefSprite("BatChestOpen")
    snd_open=sndWeaponChest; big=false; setup=true; nochest=1
    curse=(GameCont.crown!=Crown.None && random(GameCont.crown==Crown.Curses ? 3:7)<(GameCont.crown==Crown.Curses ? 2:1))
    on_step=scrNTTEFullBatChestStep; on_open=scrNTTEFullBatChestOpen
}

function scrNTTEFullBatChestSetup() {
    setup=false
    if (big) {
        nochest++; spr_shadow=shd32
        sprite_index=scrNTTERefSprite(curse ? "BatChestBigCursed":"BatChestBig")
        spr_dead=scrNTTERefSprite(curse ? "BatChestBigCursedOpen":"BatChestBigOpen")
        snd_open=curse ? sndBigCursedChest:sndBigWeaponChest
    }
    else if (curse) {
        sprite_index=scrNTTERefSprite("BatChestCursed"); spr_dead=scrNTTERefSprite("BatChestCursedOpen"); snd_open=sndCursedChest
    }
}

function scrNTTEFullBatChestStep() {
    if (setup) scrNTTEFullBatChestSetup()
    if (curse && random(16)<timescale) { var _fx=instance_create(x+orandom(8),y+orandom(8),Curse); _fx.depth=depth-1 }
}

function scrNTTEFullBatChestOpen(_opener) {
    if (setup) scrNTTEFullBatChestSetup()
    scrNTTEFullShopSound(sndEnergySword,0.8,0.5+orandom(0.1)); scrNTTEFullShopSound(sndEnergyScrewdriver,0.5,1.5+orandom(0.1))
    if (instance_is(_opener,Player)) scrNTTEFullShopText(big ? "PICK TWO!":"PICK ONE!",_opener.index)
    instance_create(x,y,PortalClear)
    if (big) { if (instance_is(_opener,Player)) scrNTTEFullShopSound(_opener.snd_chst); GameCont.nochest=0 }
    var _angle=50/(1+0.5*big),_shops=[]
    for(var _ang=-_angle*(1+big);_ang<=_angle*(1+big);_ang+=_angle) {
        var _shop=instance_create(x,y,NTTEFullChestShop)
        _shop.x+=lengthdir_x(28,_ang+90)*(3+big)/3; _shop.y+=lengthdir_y(28,_ang+90)
        _shop.type=NTTEFullShopType.Weapon; _shop.drop=wep_screwdriver; _shop.open+=big; _shop.curse=curse; _shop.creator=id
        array_push(_shops,_shop)
    }
    var _hard=max(1,GameCont.hard-1)+2*curse,_excluded=[],_weapon=scrNTTEFullWeaponDecide(0,_hard),_size=array_length(_shops)
    for(var _i=0;_i<_size;_i+=2) {
        var _next=_i+1
        _shops[_i].drop=(_next!=_size && (_i==0 || random(2)<1))
            ? scrNTTEFullWeaponMerge(wep_none,_weapon):scrNTTEFullWeaponMerge(_weapon,wep_none)
        array_push(_excluded,_weapon)
        var _stock=scrNTTEFullWeaponDecide(0,_hard,false,_excluded)
        if (_next<_size) _shops[_next].drop=scrNTTEFullWeaponMerge(_stock,_weapon)
        _weapon=_stock
    }
}

function scrNTTEFullRatChestCreate() {
    sprite_index=scrNTTERefSprite("RatChest"); spr_dead=scrNTTERefSprite("RatChestOpen")
    snd_open=sndEXPChest; on_open=scrNTTEFullRatChestOpen
}

function scrNTTEFullRatChestOpen(_opener) {
    scrNTTEFullShopSound(sndEnergySword,0.8,0.5+orandom(0.1)); scrNTTEFullShopSound(sndSkillPick,0.5,2+orandom(0.1))
    if (instance_is(_opener,Player)) scrNTTEFullShopText("PICK ONE!",_opener.index)
    instance_create(x,y,PortalClear)
    var _pool=[]
    for(var _skill=37;_skill>=1;--_skill)
        if (scrNTTEFullSkillGet(_skill)==0 && scrNTTEFullSkillAvailable(_skill,true)) array_push(_pool,_skill)
    _pool=array_shuffle(_pool)
    if (!array_length(_pool)) return;
    var _num=0
    for(var _ang=-35;_ang<=35;_ang+=70) {
        var _shop=instance_create(x,y,NTTEFullChestShop)
        _shop.x+=lengthdir_x(28,_ang+90); _shop.y+=lengthdir_y(28,_ang+90)
        _shop.type=NTTEFullShopType.Skill; _shop.creator=id; _shop.drop=_pool[_num mod array_length(_pool)]; _num++
    }
}

function scrNTTEFullChestShopCreate() {
    sprite_index=mskNone; image_speed=0.4*timescale; image_blend=c_white; image_alpha=0.7; depth=-8
    mask_index=mskWepPickup; friction=0.4*timescale*timescale; creator=noone
    prompt=scrNTTEFullPromptCreate(id); prompt.visible=false
    shine=1/16; open_state=0; open=1; wave=random(100); type=NTTEFullShopType.Basic
    drop=0; num=0; text=""; desc=""; curse=false; setup=true
}

function scrNTTEFullChestShopSetup() {
    setup=false; num=1; text=""; desc=""; sprite_index=sprAmmo; image_blend=c_white
    if (type==NTTEFullShopType.Basic) {
        if (GameCont.loops>0) switch(drop) {
            case "ammo":drop="ammo_chest";break
            case "health":drop="health_chest";break
            case "rads":drop="rads_chest";break
        }
        switch(scrNTTEFullShopCrownKey()) {
            case "love":
                switch(drop) {
                    case "health":case "rads":case "hammerhead":case "spirit":case "red":drop="ammo";break
                    case "health_chest":case "rads_chest":drop="ammo_chest";break
                    case "bonus_health":drop="bonus_ammo";break
                    case "bonus_health_chest":drop="bonus_ammo_chest";break
                }
                break
            case "life":if(drop=="health")drop="ammo";break
            case "guns":if(drop=="ammo")drop="health";break
            case "bonus":
                switch(drop) {
                    case "ammo":drop="bonus_ammo";break
                    case "ammo_chest":drop="bonus_ammo_chest";break
                    case "health":drop="bonus_health";break
                    case "health_chest":drop="bonus_health_chest";break
                }
                break
        }
        var _color=c_white
        switch(drop) {
            case "ammo":num=2;text="AMMO";desc="2 PICKUPS";sprite_index=sprAmmo;_color=c_yellow;break
            case "health":num=2;text="HEALTH";desc="2 PICKUPS";sprite_index=sprHP;break
            case "rads":num=25;text="RADS";desc="25 RADS";sprite_index=sprBigRad;_color=make_color_rgb(120,230,60);break
            case "ammo_chest":text="AMMO";desc="1 CHEST";sprite_index=scr_ultra_get(Race.Steroids,UltraSkill.GetLoaded) ? sprAmmoChestSteroids:sprAmmoChest;_color=c_yellow;break
            case "health_chest":text="HEALTH";desc="1 CHEST";sprite_index=sprHealthChest;break
            case "rads_chest":text="RADS";desc="45 RADS";sprite_index=sprRadChestBig;_color=make_color_rgb(120,230,60);break
            case "bonus_ammo":text="OVERSTOCK";desc="@5(sprNTTERefBonusText:0) AMMO";sprite_index=scrNTTERefSprite("BonusAmmoPickup");_color=make_color_rgb(100,255,255);break
            case "bonus_ammo_chest":text="OVERSTOCK";desc="1 CHEST";sprite_index=scrNTTERefSprite(scr_ultra_get(Race.Steroids,UltraSkill.GetLoaded) ? "BonusAmmoChestSteroids":"BonusAmmoChest");_color=make_color_rgb(100,255,255);break
            case "bonus_health":text="OVERHEAL";desc="@5(sprNTTERefBonusText:0) HEALTH";sprite_index=scrNTTERefSprite("BonusHealthPickup");_color=make_color_rgb(200,160,255);break
            case "bonus_health_chest":text="OVERHEAL";desc="1 CHEST";sprite_index=scrNTTERefSprite("BonusHealthChest");_color=make_color_rgb(200,160,255);break
            case "coat":text="COAT";desc="STYLISH";sprite_index=scrNTTERefSprite("YVCoat");_color=make_color_rgb(230,204,32);break
            case "rogue":text="PORTAL STRIKE";desc="1 PICKUP";sprite_index=sprRogueAmmo;_color=make_color_rgb(140,180,255);break
            case "parrot":
                num=6;text="FEATHERS";desc="6 FEATHERS";sprite_index=scrNTTERefSprite("Race.parrot.0.Feather")
                _color=make_color_rgb(255,120,120);image_xscale=-1.2;image_yscale=1.2
                var _parrot=noone,_distance=infinity
                with(Player) if(scrNTTEFullShopRace(id)=="parrot") {
                    var _d=point_distance(x,y,other.x,other.y)
                    if(_d<_distance) {_distance=_d;_parrot=id}
                }
                if(instance_exists(_parrot)) {
                    if(_parrot.bskin==1) _color=make_color_rgb(0,220,255)
                    sprite_index=scrNTTERefSprite("Race.parrot."+string(clamp(_parrot.bskin,0,1))+".Feather")
                }
                break
            case "infammo":num=90;text="INFINITE AMMO";desc="FOR A MOMENT";sprite_index=sprFishA;shine=1;break
            case "hammerhead":text="BONUS @yHAMMERHEAD";desc="+10 TILES";sprite_index=scrNTTERefSprite("HammerHeadPickup");_color=make_color_rgb(180,30,255);break
            case "spirit":text="BONUS SPIRIT";desc="LIVE FOREVER";sprite_index=scrNTTERefSprite("SpiritPickup");_color=make_color_rgb(255,200,140);break
            case "bone":text="BONE";desc="BONE";sprite_index=sprBone;_color=make_color_rgb(220,220,60);break
            case "bones":num=30;text="BONES";desc="30 BONES";sprite_index=scrNTTERefSprite("BonePickupBig",0);_color=make_color_rgb(220,220,60);break
            case "red":text="AMMO";desc="1 PICKUP";sprite_index=scrNTTERefSprite("RedAmmoPickup");_color=make_color_rgb(255,120,120);break
            case "turret":text="TURRET";desc="EXTRA OFFENSE";sprite_index=scrNTTERefSprite("LairTurretIdle");_color=make_color_rgb(200,160,180);image_xscale=0.9;image_yscale=0.9;break
            default:throw "Unknown original ChestShop basic product: "+string(drop)
        }
        image_blend=_color
    }
    else if (type==NTTEFullShopType.Weapon) {
        var _merged=scrNTTEFullWeaponHasMerge(drop)
        text=(curse ? "CURSED ":"")+(_merged ? "MERGED ":"")+"WEAPON"
        desc=scr_weapon_get_name(drop); sprite_index=scr_weapon_get_sprite(drop)
        var _hue=[0,40,120,0,160,80],_stock=scrNTTEFullWeaponRaw(drop),_front=_stock
        if (_merged) _front=scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(drop,1))
        if (_stock==wep_none) _stock=_front
        if (_front==wep_none) _front=_stock
        var _a=_hue[clamp(scr_weapon_get_type(_stock),0,5)],_b=_hue[clamp(scr_weapon_get_type(_front),0,5)],_diff=abs(_a-_b) mod 256
        if (_diff>128) _diff-=256
        image_blend=_merged ? merge_color(make_color_hsv((min(_a,_b)+_diff/2+256) mod 256,255,255),c_white,0.5)
            : merge_color(make_color_hsv(_a,255,255),c_white,0.2)
        if (curse) image_blend=merge_color(image_blend,c_fuchsia,0.5)
    }
    else {
        text=scr_skill_get_name(drop); desc=scr_skill_get_text(drop)
        if (string_char_at(desc,string_length(desc))!="#") desc+="#"
        desc+="@wTEMPORARILY"
        var _icon=drop>=30 ? scrNTTEFullSkillIcon(drop):[sprSkillIconHUD,drop]
        sprite_index=_icon[0]; image_index=_icon[1]; image_speed=0; image_blend=make_color_rgb(130,255,100)
    }
    image_alpha=-abs(image_alpha); prompt.text=text+"#@s"+desc
    if (scrNTTEFullShopCrownKey()=="crime") scrNTTEFullCrimeAlert(xstart,ystart,120,30)
}

function scrNTTEFullChestShopTrade(_player) {
    if (open<=0 || !instance_exists(_player)) return false
    if (setup) scrNTTEFullChestShopSetup()
    var _x=xstart,_y=ystart-4,_num=num
    if (type==NTTEFullShopType.Weapon) _num+=scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)
    while(_num>0) {
        var _dec=1
        if (type==NTTEFullShopType.Basic) {
            switch(drop) {
                case "ammo":instance_create(_x+orandom(2),_y+orandom(2),AmmoPickup);break
                case "health":instance_create(_x+orandom(2),_y+orandom(2),HPPickup);break
                case "rads":_dec=_num;var _rads=scrNTTEFullRadDrop(_x,_y,_num,random(360),4);break
                case "ammo_chest":case "health_chest":case "bonus_ammo_chest":case "bonus_health_chest":
                    if(drop=="ammo_chest") instance_create(_x,_y-2,AmmoChest)
                    else if(drop=="health_chest") instance_create(_x,_y-2,HealthChest)
                    else scrNTTEFullSystemsCreate(drop=="bonus_ammo_chest" ? "BonusAmmoChest":"BonusHealthChest",_x,_y-2)
                    repeat(3) { var _fx=instance_create(_x,_y,Dust); with(_fx) motion_add(90+orandom(60),4*timescale) }
                    instance_create(_x,_y,FXChestOpen)
                    if(string_pos("bonus",drop)==1) {var _fx=instance_create(_x,_y,AnimParticle);_fx.sprite_index=sprGunWarrantDisappear}
                    scrNTTEFullShopSound(drop=="ammo_chest" || drop=="bonus_ammo_chest" ? sndChest:sndHealthChest,drop=="ammo_chest" || drop=="bonus_ammo_chest" ? 3:1.5,0.6+random(0.2))
                    break
                case "rads_chest":
                    var _chest=instance_create(_x,_y-6,RadChest)
                    _chest.spr_idle=sprRadChestBig;_chest.spr_hurt=sprRadChestBigHurt;_chest.spr_dead=sprRadChestBigDead
                    instance_create(_chest.x,_chest.y,ExploderExplo);scrNTTEFullShopSound(sndRadMaggotDie,1,0.6+random(0.2));break
                case "bonus_ammo":case "bonus_health":
                    var _pickup=scrNTTEFullSystemsCreate(drop=="bonus_ammo" ? "BonusAmmoPickup":"BonusHealthPickup",_x,_y)
                    _pickup.pull_delay=0;var _fx=instance_create(_x,_y,AnimParticle);_fx.sprite_index=sprGunWarrantDisappear;break
                case "coat":
                    scrNTTEFullUnlockSet("skin:coat venuz",true)
                    if(scrNTTEFullShopRace(_player)=="venuz") with(_player) {
                        bskin=scrNTTEFullSkinNativeId("coat venuz")
                        with(scr_playerinstance_find(index)) skin=other.bskin
                        var _names=["Idle","Walk","Hurt","Dead","GoSit","Sit"],_fields=["spr_idle","spr_walk","spr_hurt","spr_dead","spr_gosit","spr_sit"]
                        for(var _i=0;_i<6;++_i) variable_instance_set(id,_fields[_i],scr_race_get_sprite(race,_names[_i],spr_idle,bskin))
                        sprite_index=spr_hurt;image_index=0;scrNTTEFullShopSound(snd_chst)
                        repeat(2) {var _fx=instance_create(x+orandom(8),y+orandom(8),CaveSparkle);_fx.depth=depth-1}
                    }
                    if(!variable_global_exists("ntte_full_weapon_skin") || !is_callable(global.ntte_full_weapon_skin))
                        throw "Coat Venuz tagged weapon skin adapter not integrated"
                    var _weapon=global.ntte_full_weapon_skin(wep_golden_revolver,"coat venuz",id)
                    var _pickup=scrWeaponPickupCreate(_x,_y,_weapon);_pickup.ammo=true
                    scrNTTEFullShopSound(sndMenuASkin)
                    break
                case "rogue":var _pickup=instance_create(_x+orandom(2),_y+orandom(2),RogueAmmo);with(_pickup) motion_add(point_direction(x,y,_player.x,_player.y),3*timescale);break
                case "parrot":_dec=_num;var _chester=scrNTTEFullSystemsCreate("ParrotChester",_x,_y);_chester.num=_num;break
                case "infammo":_dec=_num;_player.infammo=_num;_player.reload=max(_player.reload,1);break
                case "hammerhead":scrNTTEFullSystemsCreate("HammerHeadPickup",_x,_y);instance_create(_x,_y,Hammerhead);break
                case "spirit":scrNTTEFullSystemsCreate("SpiritPickup",_x,_y);instance_create(_x,_y,ImpactWrists);break
                case "bone":var _pickup=scrWeaponPickupCreate(_x,_y,wep_ntte_bone);_pickup.ammo=true;with(_pickup) motion_set(point_direction(x,y,_player.x,_player.y)+orandom(8),4*timescale);instance_create(_x,_y,Dust);scrNTTEFullShopSound(sndBloodGamble,1,0.8);break
                case "bones":
                    _dec=(_num>10 ? 10:1);var _pickup=scrNTTEFullSystemsCreate(_num>10 ? "BoneBigPickup":"BonePickup",_x,_y)
                    with(_pickup) motion_set(random(360),(3+random(1))*timescale);break
                case "red":scrNTTEFullSystemsCreate("RedAmmoPickup",_x,_y);scrNTTEFullCrystalBrainEffect(_x,_y);break
                case "turret":
                    var _turret=instance_create(_x,_y-4,Turret)
                    _turret.x=_turret.xstart;_turret.y=_turret.ystart;_turret.max_hp*=2;_turret.hp*=2;_turret.depth=-3
                    _turret.team=team_player;_turret.ntte_charmed=true
                    var _charm=instance_create(_turret.x,_turret.y,NTTEFullShopCharm);_charm.target=_turret;_charm.time=900
                    break
            }
            instance_create(_x,_y,WepSwap);scrNTTEFullShopSound(sndGunGun,0.5,1.2+random(0.4));scrNTTEFullShopSound(sndAmmoChest,0.8,0.5+random(0.2))
        }
        else if (type==NTTEFullShopType.Weapon) {
            var _drop=drop,_weapon=undefined
            while(true) {
                var _part=scrNTTEFullWeaponRaw(_drop)
                if (_part==wep_none) _part=scrNTTEFullWeaponRaw(_player.wep)
                _weapon=is_undefined(_weapon) ? _part:scrNTTEFullWeaponMerge(_weapon,_part)
                if (scrNTTEFullWeaponHasMerge(_drop)) _drop=scrNTTEFullWeaponMergedPart(_drop,1)
                else break
            }
            var _pickup=scrWeaponPickupCreate(_x,_y,_weapon);_pickup.ammo=true;_pickup.curse=curse
            with(_pickup) motion_set(point_direction(x,y,_player.x,_player.y)+orandom(8),5*timescale)
            scrNTTEFullShopSound(scrNTTEFullWeaponSwapSound(_weapon));scrNTTEFullShopSound(sndGunGun,0.6,0.8+random(0.4));scrNTTEFullShopSound(sndPlasmaBigExplode,0.8,0.6+random(0.2))
            if (curse) scrNTTEFullShopSound(sndCursedPickup,1.4,1+orandom(0.2))
            instance_create(_x,_y,GunGun)
        }
        else {
            _dec=_num
            var _orb=instance_create(_x,_y,NTTEFullOrchidBall)
            _orb.skill=drop;_orb.num=_num;_orb.type="portal";_orb.creator=creator
            _orb.direction=point_direction(x,y,_x,_y);_orb.direction+=90*sign(angle_difference(90,_orb.direction))+orandom(30)
            repeat(25*_num) {var _rad=instance_create(_x,_y,Rad);with(_rad) motion_add(random(360),random(5)*timescale)}
            var _fx=instance_create(_x,_y,BulletHit);_fx.sprite_index=sprGuardianBulletHit
            scrNTTEFullShopSound(sndNothingSmallball,2/3,1.4+orandom(0.1));scrNTTEFullShopSound(sndMut,1.5,0.7+random(0.1))
        }
        _num-=_dec
    }
    if(text!="") scrNTTEFullShopText(text,_player.index)
    if(desc!="") scrNTTEFullShopText(desc+"@w!",_player.index)
    scrNTTEFullShopSound(sndGammaGutsProc,0.6,1.4+random(0.1))
    var _group=creator,_chosen=id
    with(NTTEFullChestShop) if(creator==_group && (_group!=noone || id==_chosen)) {
        if(--open<=0) open_state+=random(1/3)
    }
    open_state=3/4;open=0
    if(scrNTTEFullShopCrownKey()=="crime") {
        GameCont.ntte_crime_active=true
        var _bounty=scrNTTEFullValue(GameCont,"ntte_crime_bounty",0)
        if(_bounty<3) {
            GameCont.ntte_crime_bounty=min(_bounty+1,3)
            if(GameCont.ntte_crime_bounty>=3 && scrPlayerCountRace(Race.Eyes)>0) scrNTTEFullUnlockSet("skin:bat eyes",true)
        }
        var _alerts=scrNTTEFullCrimeAlert(xstart,ystart,60,15)
        if(array_length(_alerts)>1) {_alerts[1].flash=max(_alerts[1].flash,6);_alerts[1].snd_flash=sndCrownRandom}
    }
    return true
}

function scrNTTEFullChestShopStep() {
    if(lockstep_stop) return;
    if(setup) scrNTTEFullChestShopSetup()
    wave+=timescale
    if(image_index<1 && shine!=1) image_index-=image_speed*(1-random(shine*timescale))
    if(random(8*(open>0 ? 1:max(0.001,open_state)))<timescale) {
        var _distance=point_distance(xstart,ystart,x,y),_angle=point_direction(xstart,ystart,x,y)+orandom(8)
        _distance=open>0 ? random(_distance):random_range(_distance*(1-open_state),_distance)
        var _fx=instance_create(xstart+lengthdir_x(_distance,_angle)+orandom(4),ystart+lengthdir_y(_distance,_angle)+orandom(4),BulletHit)
        with(_fx) motion_add(_angle+choose(0,180),random(0.5)*timescale)
        _fx.image_blend=image_blend
        if(type==NTTEFullShopType.Skill) {_fx.sprite_index=sprEatRad;_fx.depth=depth+choose(-1,1)}
        else {_fx.sprite_index=sprLightning;_fx.image_alpha=1.5*_distance/max(0.001,point_distance(xstart,ystart,x,y))*random(abs(image_alpha));_fx.depth=depth-1}
        if(curse && random(5)<1) instance_create(xstart+lengthdir_x(_distance,_angle)+orandom(4),ystart+lengthdir_x(_distance,_angle)+orandom(4),Curse)
    }
    if(instance_exists(prompt)) prompt.visible=open>0
    if(open>0) {
        open_state+=(1-open_state)*0.15*timescale
        with(CrownObject) if(point_distance(x,y,other.x,other.y)<32) {
            var _alerts=scrNTTEFullValue(id,"ntte_crime_alert",[])
            for(var _i=0;_i<array_length(_alerts);++_i) if(instance_exists(_alerts[_i])) _alerts[_i].speed=0
        }
        if(!instance_exists(Player) && open_state>=1) open=0
        var _player=noone
        if(instance_exists(prompt) && prompt.pick>=0) with(Player) if(index==other.prompt.pick) {_player=id;break}
        if(!instance_exists(_player)) {
            var _shocks=scrNTTEFullInstances(PortalShock)
            for(var _i=0;_i<array_length(_shocks);++_i) {
                var _shock=_shocks[_i]
                if(!place_meeting(x,y,_shock)) continue
                var _nearest=id,_distance=point_distance(x,y,_shock.x,_shock.y)
                with(NTTEFullChestShop) if(open>0 && place_meeting(x,y,_shock)) {
                    var _dist=point_distance(x,y,_shock.x,_shock.y)
                    if(_dist<_distance) {_distance=_dist;_nearest=id}
                }
                if(_nearest==id) {_player=instance_nearest(x,y,Player);break}
            }
        }
        if(instance_exists(_player)) scrNTTEFullChestShopTrade(_player)
    }
    else {open_state-=0.04*timescale;if(open_state<=0) instance_destroy()}
}

function scrNTTEFullShopCharmStep() {
    if(lockstep_stop) return;
    if(!instance_exists(target)) {instance_destroy();return;}
    time-=timescale
    if(time<=0) {target.hp=0;instance_destroy()}
}

function scrNTTEFullLairShopFoundationUnitTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0)
    GameCont.crown=Crown.None;GameCont.loops=0;GameCont.hard=3
    _player.race=Race.Fish;_player.wep=wep_revolver;_player.bwep=wep_none
    var _cat=scrNTTEFullLairChestCreate(38016,38016,"CatChest",true),_chest_id=_cat
    assert(_cat.object_index==NTTEFullCatChest && _cat.sprite_index==scrNTTERefSprite("CatChest"),"CatChest factory lost source type/visual")
    with(_cat) scrNTTEFullCustomChestOpen(_player)
    assert(!instance_exists(_cat),"CatChest original contact failed to open")
    var _shops=[],_drops={},_chosen=noone
    with(NTTEFullChestShop) if(creator==_chest_id) {
        scrNTTEFullChestShopSetup();array_push(_shops,id);variable_struct_set(_drops,string(drop),true)
        if(drop=="ammo") _chosen=id
    }
    assert(array_length(_shops)==3 && variable_struct_exists(_drops,"ammo") && variable_struct_exists(_drops,"health") && variable_struct_exists(_drops,"rads"),
        "CatChest failed source weighted-without-replacement basic pool")
    var _ammo=instance_number(AmmoPickup)
    _chosen.prompt.pick=_player.index
    with(_chosen) scrNTTEFullChestShopStep()
    assert(instance_number(AmmoPickup)==_ammo+2,"Actual CatShop prompt failed two-pickup source transaction")
    for(var _i=0;_i<array_length(_shops);++_i) assert(_shops[_i].open==0,"Buying CatShop did not close sibling options")
    var _rat=scrNTTEFullSystemsCreate("RatChest",38216,38016),_rat_id=_rat
    with(_rat) scrNTTEFullCustomChestOpen(_player)
    var _skills=[]
    with(NTTEFullChestShop) if(creator==_rat_id) {scrNTTEFullChestShopSetup();array_push(_skills,id)}
    assert(array_length(_skills)==2 && _skills[0].drop!=_skills[1].drop,"RatChest did not offer two distinct source-eligible mutations")
    var _orbs=instance_number(NTTEFullOrchidBall),_skill=_skills[0].drop
    _skills[0].prompt.pick=_player.index
    with(_skills[0]) scrNTTEFullChestShopStep()
    assert(instance_number(NTTEFullOrchidBall)==_orbs+1 && _skills[0].open==0 && _skills[1].open==0,
        "RatShop failed real temporary-mutation orb transaction")
    var _orb=instance_find(NTTEFullOrchidBall,_orbs)
    assert(_orb.skill==_skill && _orb.type=="portal" && _orb.creator==_rat_id,"RatShop changed original OrchidBall product/ownership")
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
    scrNTTESmokeLog("FULL LAIR SHOP: real Cat/Rat chest contact, weighted pool, native prompt purchase, sibling stock and temporary mutation orb OK @"+string(30/timescale))
}

function scrNTTEFullLairShopMergedUnitTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0)
    GameCont.crown=Crown.None;GameCont.loops=0;GameCont.hard=6
    _player.race=Race.Fish;_player.wep=wep_revolver;_player.bwep=wep_none
    var _bat=scrNTTEFullSystemsCreate("BatChest",38016,38016),_bat_id=_bat
    _bat.big=true;_bat.curse=false
    with(_bat) scrNTTEFullCustomChestOpen(_player)
    var _shops=[]
    with(NTTEFullChestShop) if(creator==_bat_id) {scrNTTEFullChestShopSetup();array_push(_shops,id)}
    assert(array_length(_shops)==5 && GameCont.nochest==0,"Big BatChest failed original five-option/two-pick setup")
    for(var _i=0;_i<5;++_i) assert(_shops[_i].open==2 && scrNTTEFullWeaponHasMerge(_shops[_i].drop),"BatChest substituted a nonmerged weapon product")
    var _picks=instance_number(WepPickup),_first=_shops[0]
    with(_first) assert(scrNTTEFullChestShopTrade(_player),"First actual merged purchase rejected")
    assert(instance_number(WepPickup)==_picks+1,"Merged trade emitted no real native WepPickup")
    var _pickup=instance_find(WepPickup,_picks)
    assert(scrNTTEFullWeaponHasMerge(_pickup.wep) && _first.open==0,"Merged trade failed current-weapon placeholder composition")
    for(var _i=1;_i<5;++_i) assert(_shops[_i].open==1,"First big purchase incorrectly consumed second sibling stock")
    with(_shops[1]) scrNTTEFullChestShopTrade(_player)
    for(var _i=0;_i<5;++_i) assert(_shops[_i].open<=0,"Second big purchase left active sibling stock")
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
    scrNTTESmokeLog("FULL BAT SHOP: source five merged options, current-weapon placeholder composition, actual WepPickup and shared two-pick stock OK @"+string(30/timescale))
}

function scrNTTEFullLairTurretUnitTests() {
    var _area=GameCont.area,_before=scrNTTEFullInstances(all)
    GameCont.area=scrNTTEFullAreaId("lair")
    var _turret=instance_create(38016,38016,Turret)
    assert(_turret.lair_turret && _turret.spr_fire==scrNTTERefSprite("LairTurretFire"),"Native Turret.Create missed source Lair setup")
    _turret.ammo=1;_turret.gunangle=0
    var _count=instance_number(EnemyBullet2),_effects=instance_number(AcidStreak)
    with(_turret) event_perform(ev_alarm,2)
    assert(_turret.ammo==0 && instance_number(EnemyBullet2)==_count+1 && instance_number(AcidStreak)==_effects+2,
        "Native Lair Turret fire did not replace the bullet and original acid FX")
    var _bullet=instance_find(EnemyBullet2,_count)
    assert(_bullet.creator==_turret && _bullet.team==_turret.team && abs(_bullet.speed-8*timescale)<0.001,
        "Lair projectile replacement lost source ownership, team or speed")
    _turret.image_index=_turret.image_number-0.1
    scrNTTEFullLairStep()
    assert(_turret.spr_idle==scrNTTERefSprite("LairTurretIdle") && _turret.spr_walk==_turret.spr_idle,
        "Lair native appear animation never switched into source idle sprites")
    GameCont.area=area_desert
    var _plain=instance_create(38216,38016,Turret)
    assert(!_plain.lair_turret && _plain.spr_fire==sprTurretFire,"Lair turret hook changed unrelated native turret")
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    GameCont.area=_area
    scrNTTESmokeLog("FULL LAIR TURRET: real native Create/fire hook, replacement projectile faction/creator/speed and source acid FX OK @"+string(30/timescale))
}

function scrNTTEFullLairMutationRewardUnitTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_before=scrNTTEFullInstances(all)
    var _silver=scrNTTEFullSkillGet(NTTEFullSkill.SilverTongue),_vx=view_xview,_vy=view_yview
    scrNTTEFullSkillSet(NTTEFullSkill.SilverTongue,0)
    GameCont.area=scrNTTEFullAreaId("lair");GameCont.skillpoints=1;GameCont.crownpoints=0;GameCont.ultrapoints=0
    GameCont.ntte_lairmut=true
    var _menu=instance_create(0,0,LevCont)
    assert(instance_exists(_menu) && !GameCont.ntte_lairmut && GameCont.skillpoints==1,
        "Actual LevCont.Create did not consume source Lair reward flag while preserving mutation point")
    assert(instance_number(SkillIcon)==1 && SkillIcon.skill==NTTEFullSkill.SilverTongue,
        "Lair boss reward did not replace eligible mutation slate with Silver Tongue")
    scrNTTEFullLairBeginStep()
    assert(instance_number(SkillIcon)==1,"Consumed Lair reward created duplicate forced choices")
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    scrNTTEFullSkillSet(NTTEFullSkill.SilverTongue,_silver)
    scrNTTEFullAreaGeneratorRestore(_game);view_xview=_vx;view_yview=_vy
    scrNTTESmokeLog("FULL LAIR REWARD: actual native LevCont slate replacement, sole source Silver Tongue option and one-time flag consumption OK @"+string(30/timescale))
}


// Original projector beam and hologram draw, including the source blue-channel mask.
function scrNTTEFullChestShopDraw() {
	image_alpha = abs(image_alpha);
	
	var	_openState = clamp(open_state, 0, 1),
		_spr       = sprite_index,
		_img       = image_index,
		_xsc       = image_xscale * max((open > 0) * 0.8, _openState),
		_ysc       = image_yscale * max((open > 0) * 0.8, _openState),
		_ang       = image_angle + (8 * sin(wave / 12)),
		_col       = merge_color(c_black, image_blend, _openState),
		_alp       = image_alpha,
		_x         = x,
		_y         = y;
		
	if(type == NTTEFullShopType.Basic && x < xstart){
		_xsc *= -1;
	}
	
	 // Projector Beam:
	var	_sx = xstart,
		_sy = ystart,
		_d  = point_direction(_sx, _sy, _x, _y);
		
	//_d = angle_lerp(_d, 90, 1 - clamp(open_state, 0, 1));
	
	var	_w  = point_distance(_sx, _sy, _x, _y) * ((open > 0) ? _openState : min(_openState * 3, 1)),
		_h  = ((sqrt(sqr(sprite_get_width(_spr) * image_xscale * dsin(_d)) + sqr(sprite_get_height(_spr) * image_yscale * dcos(_d))) * 2/3) + random(2)) * max(0, (_openState - 0.5) * 2),
		_x1 = _sx + lengthdir_x(0.5, _d),
		_y1 = _sy + lengthdir_y(1,   _d),
		_x2 = _sx + lengthdir_x(_w, _d) + lengthdir_x(_h / 2, _d - 90),
		_y2 = _sy + lengthdir_y(_w, _d) + lengthdir_y(_h / 2, _d - 90),
		_x3 = _sx + lengthdir_x(_w, _d) - lengthdir_x(_h / 2, _d - 90),
		_y3 = _sy + lengthdir_y(_w, _d) - lengthdir_y(_h / 2, _d - 90);
		
	if(type == NTTEFullShopType.Weapon){
		_y2 = max(_y + 2, _y2);
		_y3 = max(_y + 2, _y3);
	}
	
	_x = _sx + lengthdir_x(_w, _d);
	_y = _sy + lengthdir_y(_w, _d);
	
	gpu_set_blendmode(bm_add);
	draw_set_color(merge_color(_col, c_blue, 0.4));
	
	 // Main:
	draw_primitive_begin(pr_trianglestrip);
	
	draw_set_alpha(_alp);
	draw_vertex(_x1, _y1);
	draw_set_alpha(_alp / 8);
	draw_vertex(_x2, _y2);
	draw_vertex(_x3, _y3);
	
	draw_primitive_end();
	
	 // Side Lines:
	draw_primitive_begin(pr_linestrip);
	
	draw_set_alpha(_alp / 3);
	draw_vertex(_x2, _y2);
	draw_set_alpha(0);
	draw_vertex(_x1, _y1);
	draw_set_alpha(_alp / 3);
	draw_vertex(_x3, _y3);
	
	draw_primitive_end();
	
	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	
	 // Projected Object:
	_x -= ((sprite_get_width(_spr) / 2) - sprite_get_xoffset(_spr)) * _xsc;
	_y += sin(wave / 20);
	
	gpu_set_colorwriteenable(true, true, false, true);
	draw_sprite_ext(_spr, _img, _x, _y, _xsc, _ysc, _ang, _col, _alp);
	gpu_set_colorwriteenable(true, true, true, true);
	
	gpu_set_blendmode_ext(bm_src_alpha, bm_one);
	draw_sprite_ext(_spr, _img, _x, _y, _xsc, _ysc, _ang, merge_color(_col, c_black, 0.5 + (0.1 * sin(wave / 8))), image_alpha * 1.5);
	gpu_set_blendmode(bm_normal);
	
	 // CustomObject:
	image_alpha = -abs(image_alpha);
	
	

}
