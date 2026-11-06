// tepickups original Spirit/HammerHead/RedAmmo pickups and their chests,
// plus OrchidChest. Real CustomChest/CustomPickup ancestry owns opening,
// attraction, fading, portal collection, persistence and collision behavior.
function scrNTTEFullRedAmmoState() {
    if(!variable_instance_exists(id,"ntte_red_ammo")) ntte_red_ammo=0
    if(!variable_instance_exists(id,"ntte_red_amax")) ntte_red_amax=4
    if(!variable_instance_exists(id,"ntte_red_amax_muscle")) ntte_red_amax_muscle=0
    var _muscle=scr_skill_get(mut_back_muscle)
    if(ntte_red_amax_muscle!=_muscle) {
        ntte_red_amax-=4*ntte_red_amax_muscle
        ntte_red_amax_muscle=_muscle;ntte_red_amax+=4*ntte_red_amax_muscle
    }
}
function scrNTTEFullRedAmmoWeaponCost(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_cost=scrNTTERedCost(scrNTTEFullWeaponRaw(_model))
    if(scrNTTEFullWeaponHasMerge(_model)==true) {
        var _merge=_model.temerge
        if(current_frame>_merge.fire_frame
            ? (((current_frame-_merge.fire_frame)%60)<30 && !_merge.is_part)
            : (_merge.wep_fire_frame>=_merge.fire_frame))
            return scrNTTEFullRedAmmoWeaponCost(_merge.wep[0])
    }
    return _cost
}
function scrNTTEFullRewardPopup(_num,_text) {
    var _popup=scrPopupCreate(x,y,"+"+string(_num)+" "+_text)
    _popup.ntte_full_target=index
}
function scrNTTEFullSpiritGrant(_opener) {
    var _num=num
    with(instance_is(_opener,Player)?_opener:Player) {
        if(!variable_instance_exists(id,"bonus_spirit")) bonus_spirit=[]
        if(_num>0) repeat(_num) {array_push(bonus_spirit,{});snd_play(sndStrongSpiritGain)}
        else if(_num<0) repeat(-_num) {
            for(var _i=array_length(bonus_spirit)-1;_i>=0;--_i) {
                var _token=bonus_spirit[_i]
                if(scrNTTEFullValue(_token,"active",true)) {
                    _token.active=false;_token.sprite_index=sprStrongSpirit;_token.image_index=0
                    snd_play(sndStrongSpiritLost);break
                }
            }
        }
        scrNTTEFullRewardPopup(_num,"@yBONUS @wSPIRIT"+((abs(_num)==1)?"":"S"))
    }
}
function scrNTTEFullSpiritHaloStep() {
    wave+=timescale
    if(!ntte_halo_static) {
        img_halo+=instance_is(id,NTTEFullSpiritChest)?0.4*timescale:image_speed
        if(img_halo>=sprite_get_number(spr_halo)) {
            // Native Epsilon's static halo is StrongSpirit frame0; original
            // NTT exposes that frame as the separate sprHalo asset.
            img_halo=0;spr_halo=sprStrongSpirit;ntte_halo_static=true
        }
    }
}
function scrNTTEFullSpiritHaloDraw() {
    for(var _i=0;_i<num;++_i) draw_sprite(spr_halo,img_halo,x,y+3+sin(wave*0.1)-7*_i)
}
function scrNTTEFullSpiritChestCreate() {
    sprite_index=scrNTTERefSprite("SpiritChest");spr_dead=scrNTTERefSprite("SpiritChestOpen")
    spr_halo=sprStrongSpiritRefill;img_halo=0;ntte_halo_static=false;num=2;wave=random(90)
    snd_open=sndWeaponChest;snd_play(sndStrongSpiritGain,1.2+random(0.2),0.7)
    on_step=scrNTTEFullSpiritHaloStep;on_open=scrNTTEFullSpiritChestOpen
}
function scrNTTEFullSpiritChestOpen(_opener) {
    if(instance_is(_opener,Player)) scrNTTEFullSpiritGrant(_opener)
    else if(num>0) repeat(num) instance_create(x,y,NTTEFullSpiritPickup)
}
function scrNTTEFullSpiritPickupCreate() {
    sprite_index=scrNTTERefSprite("SpiritPickup");spr_halo=sprStrongSpiritRefill;img_halo=0;ntte_halo_static=false
    snd_open=sndAmmoPickup;snd_fade=sndStrongSpiritLost;snd_play(sndStrongSpiritGain,1.4+random(0.3),0.7)
    num=1+scrCrownCheck(crwn_haste);ntte_full_fade_timer=scrNTTEFullPickupAlarm(90+random(30),0.2)
    pull_dis=30+30*scr_skill_get(mut_plutonium_hunger);pull_spd=4;pull_delay=30;wave=random(90)
    on_step=scrNTTEFullSpiritPickupStep;on_pull=scrNTTEFullSpiritPickupPull
    on_open=scrNTTEFullSpiritGrant;on_fade=scrNTTEFullSpiritPickupFade
}
function scrNTTEFullSpiritPickupStep() {
    if(pull_delay>0) pull_delay-=timescale
    scrNTTEFullSpiritHaloStep()
}
function scrNTTEFullSpiritPickupPull(_who) {return pull_delay<=0;}
function scrNTTEFullSpiritPickupFade() {
    // Native Epsilon's equivalent one-shot spirit animation uses this class;
    // NTT calls the same plain sprite effect StrongSpirit.
    for(var _i=0;_i<num;++_i) {
        var _fx=instance_create(x,y+3-7*_i,StrongSpiritRefill)
        _fx.sprite_index=sprStrongSpirit
    }
    instance_create(x,y,HPPickup)
}
function scrNTTEFullHammerGrant(_opener) {
    var _num=num
    with(instance_is(_opener,Player)?_opener:Player) {
        hammerhead+=_num;scrNTTEFullRewardPopup(_num,"@y"+loc("Skills:26:Name","HAMMERHEAD"))
    }
    snd_play(sndHammerHeadProc);sleep(20)
}
function scrNTTEFullHammerHaloStep() {
    img_halo+=instance_is(id,NTTEFullHammerHeadChest)?0.4*timescale:image_speed
    if(img_halo>=sprite_get_number(spr_halo)) {
        img_halo%=sprite_get_number(spr_halo)
        spr_halo=scrNTTERefSprite(instance_is(id,NTTEFullHammerHeadChest)?"HammerHeadChestEffect":"HammerHeadPickupEffect")
    }
}
function scrNTTEFullHammerHaloDraw() {draw_sprite(spr_halo,img_halo,x,y);}
function scrNTTEFullHammerChestCreate() {
    sprite_index=scrNTTERefSprite("HammerHeadChest");spr_open=sprHammerHead
    spr_dead=scrNTTERefSprite("HammerHeadChestOpen");spr_halo=scrNTTERefSprite("HammerHeadChestEffectSpawn");img_halo=0
    snd_open=sndBigWeaponChest;num=20;on_step=scrNTTEFullHammerHaloStep;on_open=scrNTTEFullHammerChestOpen
}
function scrNTTEFullHammerChestOpen(_opener) {
    if(instance_is(_opener,Player)) scrNTTEFullHammerGrant(_opener)
    else if(num>0) repeat(ceil(num/10)) instance_create(x,y,NTTEFullHammerHeadPickup)
    snd_play(sndHammerHeadProc);sleep(20)
}
function scrNTTEFullHammerPickupCreate() {
    sprite_index=scrNTTERefSprite("HammerHeadPickup");spr_open=sprHammerHead;spr_fade=sprHammerHead
    spr_halo=scrNTTERefSprite("HammerHeadPickupEffectSpawn");img_halo=0
    snd_open=sndLuckyShotProc;snd_fade=sndHammerHeadEnd
    num=10+scrCrownCheck(crwn_haste);pull_dis=30+30*scr_skill_get(mut_plutonium_hunger);pull_spd=4
    on_step=scrNTTEFullHammerHaloStep;on_open=scrNTTEFullHammerGrant;on_fade=scrNTTEFullHammerPickupFade
}
function scrNTTEFullHammerPickupFade() {
    repeat(1+irandom(2)) with(instance_create(x,y,Smoke)) speed=random(2)*timescale
    snd_play_hit(sndBurn,0.4)
}
function scrNTTEFullRedAmmoGrant(_opener) {
    var _num=num
    with(instance_is(_opener,Player)?_opener:Player) {
        if(variable_instance_exists(id,"ntte_red_ammo")) {
            scrNTTEFullRedAmmoState();ntte_red_ammo=min(ntte_red_ammo+_num,ntte_red_amax)
            scrNTTEFullRewardPopup(_num,"@rRED AMMO")
        }
    }
}
function scrNTTEFullRedAmmoChestCreate() {
    sprite_index=scrNTTERefSprite("RedAmmoChest");spr_dead=scrNTTERefSprite("RedAmmoChestOpen");spr_shadow_y=-3
    snd_open=sndRogueCanister;num=1;on_open=scrNTTEFullRedAmmoChestOpen
}
function scrNTTEFullRedAmmoChestOpen(_opener) {
    if(instance_is(_opener,Player) && variable_instance_exists(_opener,"ntte_red_ammo")) scrNTTEFullRedAmmoGrant(_opener)
    else {var _item=instance_create(x,y,NTTEFullRedAmmoPickup);_item.num=num;}
}
function scrNTTEFullRedAmmoPickupCreate() {
    sprite_index=scrNTTERefSprite("RedAmmoPickup");snd_open=sndRogueCanister;snd_fade=sndPickupDisappear
    num=1+scrCrownCheck(crwn_haste);on_pull=scrNTTEFullRedAmmoPickupPull;on_open=scrNTTEFullRedAmmoGrant
}
function scrNTTEFullRedAmmoPickupPull(_who) {
    return scrNTTEFullRedAmmoWeaponCost(_who.wep)>0 || scrNTTEFullRedAmmoWeaponCost(_who.bwep)>0
}
function scrNTTEFullOrchidChestCreate() {
    sprite_index=scrNTTERefSprite("OrchidChest");spr_dead=scrNTTERefSprite("OrchidChestOpen")
    snd_open=sndChest;num=1;alive=true;on_step=scrNTTEFullOrchidChestStep;on_open=scrNTTEFullOrchidChestOpen
}
function scrNTTEFullOrchidChestStep() {
    if(alive && random(5)<timescale) instance_create(x+orandom(7),y+orandom(6),NTTEFullVaultFlowerSparkle)
}
function scrNTTEFullOrchidChestOpen(_opener) {
    var _target=instance_is(_opener,Player)?_opener:instance_nearest(x,y,Player)
    repeat(5) {
        var _debris=instance_create(x,y,Feather)
        with(_debris) {
            sprite_index=scrNTTERefSprite(other.alive?"VaultFlowerDebris":"VaultFlowerWiltedDebris")
            image_index=irandom(image_number-1);image_angle=orandom(30);image_speed=0;depth=other.depth-1
            direction=random(360);speed=random(3)*timescale;rot*=0.5
        }
    }
    if(alive) {
        var _ball=instance_create(x,y,NTTEFullOrchidBall)
        if(instance_is(_target,Player)) _ball.target=_target
        _ball.num=num;_ball.creator=id;_ball.direction=90+orandom(45)
        repeat(10) with(instance_create(x+orandom(5),y+random(5),NTTEFullVaultFlowerSparkle)) {
            direction=90;speed=random(1)*timescale
        }
        with(instance_create(x,y-10,FXChestOpen)) {
            sprite_index=sprMutant6Dead;image_index=12;image_xscale=0.75;image_yscale=image_xscale
        }
        snd_play(sndUncurse,0.9+random(0.2),1);snd_play(sndJungleAssassinWake,0.9+random(0.2),0.8);snd_play(sndWallBreakBrick,1,0.6)
    }
    else repeat(5) with(instance_create(x,y,NTTEFullBonePickup)) scrNTTEFullNativeMotionAddFT(id,random(360),random(4))
}
