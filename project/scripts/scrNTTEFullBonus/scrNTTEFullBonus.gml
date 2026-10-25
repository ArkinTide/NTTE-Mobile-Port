// tepickups::BonusChest/BonusPickup, source lines779..1223.
// Native coop ultra IDs differ from NTT: use the named sharing semantics.
function scrNTTEFullBonusSparkle(_frame=0) {
    var _fx=instance_create(x+orandom(4),y+orandom(4),FireFly);
    _fx.sprite_index=scrNTTERefSprite("BonusFX"); _fx.image_index=_frame; _fx.depth=depth-1;
}
function scrNTTEFullBonusChestStep() {
    wave+=timescale;
    if((wave mod 30)<timescale) scrNTTEFullBonusSparkle();
}
function scrNTTEFullBonusPickupStep() {
    if(pull_delay>0) pull_delay-=timescale;
    wave+=timescale;
    if(((wave mod 30)<timescale || pull_delay>0) && random(max(2,pull_delay))<1)
        scrNTTEFullBonusSparkle();
}
function scrNTTEFullBonusPickupPull(_who) {
    if(pull_delay>0) return false;
    if(random(2)<timescale && (point_distance(x,y,_who.x,_who.y)<pull_dis || instance_exists(Portal)))
        scrNTTEFullBonusSparkle(1);
    return true;
}
function scrNTTEFullBonusPopup(_health,_num) {
    var _text=loc(_health ? "NTTE:Bonus:Health":"NTTE:Bonus:Ammo",
        "@5(sprNTTERefBonusText:-0.3) "+(_health ? "HP":"AMMO"));
    var _popup=scrPopupCreate(x,y,loc_fmt("Pickups:AddAmmo","+%1 %2",_num,_text));
    _popup.ntte_full_target=index;
    return _popup;
}
// Source setup runs after a shell's caller configures its sprite (e.g. soda
// cans). Native EndStep observes the same final sprite once per new instance.
function scrNTTEFullBonusShellSetup() {
    if(sprite_index==sprSodaCan) return;
    var _touch=false;
    with(Player) if(scrNTTEFullValue(id,"bonus_ammo",0)!=0 && position_meeting(other.x,other.y,id)) _touch=true;
    if(!_touch) return;
    // Sprite bbox getters are inclusive, unlike instance bbox_right/bottom.
    var _heavy=sprite_get_bbox_right(sprite_index)+1-sprite_get_bbox_left(sprite_index)>3;
    sprite_index=scrNTTERefSprite(_heavy ? "BonusShellHeavy":"BonusShell");
    if(random(5)<1) image_blend=merge_color(image_blend,c_blue,0.25);
}
function scrNTTEFullBonusShellStep() {
    with(Shell) if(!variable_instance_exists(id,"ntte_bonus_shell_checked")) {
        ntte_bonus_shell_checked=true;
        scrNTTEFullBonusShellSetup();
    }
}
function scrNTTEFullBonusHealthBurst(_color,_direction,_speed) {
    var _fx=instance_create(x,y,BulletHit);
    _fx.sprite_index=sprThrowHit; _fx.image_xscale=random_range(2/3,1); _fx.image_yscale=_fx.image_xscale;
    _fx.image_blend=_color; _fx.image_speed=0.5*timescale; _fx.depth=-4;
    _fx.speed=(_speed+0.5)*timescale; _fx.direction=_direction;
}
function scrNTTEFullBonusHealthHit(_color,_direction,_speed) {
    if(scrNTTEFullValue(id,"bonus_health_flash",0)<=0) {
        var _prevx=x,_prevy=y;
        for(var _a=_direction;_a<=_direction+360;_a+=360/16) {
            var _nx=x+lengthdir_x(12,_a),_ny=y+lengthdir_y(12,_a);
            if(_a>_direction) {
                var _trail=instance_create(_nx,_ny,BoltTrail);
                _trail.image_xscale=point_distance(_nx,_ny,_prevx,_prevy)*1.1;
                _trail.image_yscale=1.5+dsin(_direction+_a);
                _trail.image_angle=point_direction(_nx,_ny,_prevx,_prevy);
                _trail.image_blend=_color; _trail.depth=-4;
                _trail.speed=_speed*timescale; _trail.direction=_direction;
                if(bonus_health!=0) _trail.image_yscale=max(1.7,_trail.image_yscale);
            }
            _prevx=_nx; _prevy=_ny;
        }
    }
    var _flash=instance_create(x,y,BulletHit);
    _flash.sprite_index=sprPortalClear; _flash.image_xscale=0.4; _flash.image_yscale=0.4;
    _flash.image_speed=timescale; _flash.depth=-3; _flash.speed=_speed*timescale; _flash.direction=_direction;
    var _hidden=instance_create(x,y,BulletHit);
    _hidden.visible=false; _hidden.sprite_index=sprImpactWrists; _hidden.image_blend=_color;
    _hidden.speed=_speed*timescale; _hidden.direction=_direction;
}
// CustomMimic + BonusMimic, with contact callbacks on the real successful hit.
function scrNTTEFullBonusMimicConfigure(_health) {
    ntte_bonus_health=_health; ntte_bonus_chest=false;
    var _key=_health ? "BonusHealthMimic":"BonusAmmoMimic";
    spr_idle=scrNTTERefSprite(_key+"Idle"); spr_walk=scrNTTERefSprite(_key+"Fire");
    spr_hurt=scrNTTERefSprite(_key+"Hurt"); spr_dead=scrNTTERefSprite(_key+"Dead");
    spr_chrg=scrNTTERefSprite(_key+"Tell"); sprite_index=spr_idle;
    mask_index=-1; max_hp=12; raddrop=_health ? 15:6; size=1;
    meleedamage=_health ? 4:3; maxspeed=2;
    hitid=[spr_walk,_health ? "OVERHEAL MIMIC":"OVERSTOCK MIMIC"];
    num=2; wave=random(90);
    tell_wait_min=_health ? 180:90; tell_wait_max=_health ? 480:240;
    ntte_bonus_tell_left=random_range(tell_wait_min,tell_wait_max);
}
function scrNTTEFullBonusMimicAfterCreate() {
    snd_hurt=sndMimicHurt; snd_dead=sndMimicDead; snd_mele=sndMimicMelee;
    snd_tell=ntte_bonus_health ? sndHPMimicTaunt:sndMimicSlurp;
    spr_shadow=shd24;
}
function scrNTTEFullBonusMimicStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy(); return; }
    scrNTTEFullBonusChestStep();
    ntte_bonus_tell_left-=timescale;
    if(ntte_bonus_tell_left<=0) {
        ntte_bonus_tell_left=random_range(tell_wait_min,tell_wait_max);
        sprite_index=spr_chrg; image_index=0; snd_play_hit(snd_tell,0.1); return;
    }
    speed=min(speed,maxspeed*timescale);
    if(sprite_index!=spr_chrg || image_index+image_speed>=image_number) sprite_index=scrNTTEFullWorldEnemySprite();
    if(sprite_index==spr_hurt) {
        scrTarget();
        if(instance_exists(target) && point_distance(x,y,target.x,target.y)<48) sprite_index=spr_walk;
    }
}
function scrNTTEFullBonusMimicContact(_player) {
    if(lockstep_stop || !instance_exists(_player)) return;
    // Preserve native contact gating and successful-hit side effects; the NTT
    // end_step lasthit check is represented by this direct success callback.
    if(meleedamage>0 && canmelee && scr_can_hit(_player) && !(scr_skill_get(mut_gamma_guts) && hp<=6)) {
        if(scr_hit(_player,meleedamage,hitid)) {
            with(_player) motion_add(point_direction(other.x,other.y,x,y),4*timescale);
            snd_play_hit(snd_mele);
            instance_create(_player.x,_player.y,ntte_bonus_health ? NTTEFullBonusHealthPickup:NTTEFullBonusAmmoPickup);
            // Original health mimics share their bite cooldown to prevent
            // simultaneous self-refilling health chains.
            if(ntte_bonus_health) {
                with(NTTEFullBonusHealthMimic) if(id!=other.id) {
                    if(canmelee) { canmelee=false; alarm[11]=30; }
                    else if(alarm[11]>0) alarm[11]=max(alarm[11],30);
                }
            }
        }
        canmelee=false; alarm[11]=30;
    }
    if(size<=2) motion_add(point_direction(_player.x,_player.y,x,y),timescale);
}
function scrNTTEFullBonusMimicDeath() {
    repeat(num) instance_create(x,y,ntte_bonus_health ? NTTEFullBonusHealthPickup:NTTEFullBonusAmmoPickup);
}
function scrNTTEFullBonusCreate(_health,_chest) {
    ntte_bonus_health=_health; ntte_bonus_chest=_chest;
    var _key=_health ? "BonusHealth":"BonusAmmo";
    wave=random(90);
    if(_chest) {
        sprite_index=scrNTTERefSprite(_key+"Chest"); spr_dead=scrNTTERefSprite(_key+"ChestOpen");
        spr_open=scrNTTERefSprite("BonusFXChestOpen"); on_step=scrNTTEFullBonusChestStep;
        num=2;
        if(!_health) {
            var _loaded=scr_ultra_get(Race.Steroids,UltraSkill.GetLoaded);
            if(_loaded!=0) {
                sprite_index=scrNTTERefSprite("BonusAmmoChestSteroids");
                spr_dead=scrNTTERefSprite("BonusAmmoChestSteroidsOpen"); num*=power(2,_loaded);
            }
        }
    } else {
        sprite_index=scrNTTERefSprite(_key+"Pickup");
        spr_open=scrNTTERefSprite("BonusFXPickupOpen"); spr_fade=scrNTTERefSprite("BonusFXPickupFade");
        pull_dis=30+30*scr_skill_get(mut_plutonium_hunger); pull_spd=4; pull_delay=9;
        num=1+scrCrownCheck(crwn_haste);
        on_step=scrNTTEFullBonusPickupStep; on_pull=scrNTTEFullBonusPickupPull;
    }
    if(_health) {
        var _stomach=scr_skill_get(mut_second_stomach);
        num=_chest ? 2*(1+_stomach):1+_stomach+scrCrownCheck(crwn_haste);
        snd_open=_stomach>0 ? sndHPPickupBig:sndHPPickup;
    } else if(!_chest) snd_open=sndAmmoPickup;
    on_open=scrNTTEFullBonusOpen;
}
function scrNTTEFullBonusOpen(_opener) {
    var _health=ntte_bonus_health,_chest=ntte_bonus_chest,_num=num;
    if(_chest && !instance_is(_opener,Player)) {
        repeat(2) {
            var _item=instance_create(x,y,_health ? NTTEFullBonusHealthPickup:NTTEFullBonusAmmoPickup);
            _item.num=_num/2;
        }
    } else {
        var _share=scr_ultra_get(Race.CoopUltra,_health ? UltraSkill.BloodBond:UltraSkill.GunBond);
        with((!instance_is(_opener,Player) || _share) ? Player:_opener) {
            if(_health) {
                bonus_health=scrNTTEFullValue(id,"bonus_health",0)+_num*30; bonus_health_flash=1;
                if(hp<max_hp) hp=min(hp+_num,max_hp);
                if(_chest && headloses>0) { headloses-=1; max_hp+=1; }
                scrNTTEFullBonusPopup(true,_num);
                var _heal=instance_create(x,y,HealFX);
                _heal.sprite_index=scrNTTERefSprite(scr_skill_get(mut_second_stomach)>0 ? "BonusHealBigFX":"BonusHealFX");
                _heal.depth=depth-1;
            } else {
                bonus_ammo=scrNTTEFullValue(id,"bonus_ammo",0)+_num*60; bonus_ammo_flash=1;
                var _wep=(_chest || bwep==wep_none) ? wep:choose(wep,bwep);
                var _type=scr_weapon_get_type(_wep);
                if(_type==Ammo.None || ammo[_type]>=typ_amax[_type]) _type=irandom_range(1,array_length(ammo)-1);
                if(ammo[_type]<typ_amax[_type]) ammo[_type]=min(ammo[_type]+round(_num),typ_amax[_type]);
                scrNTTEFullBonusPopup(false,_num);
            }
        }
    }
    snd_play(sndRogueCanister,_health ? 1.3:0.7,0.7);
    snd_play(sndRogueRifle,_chest ? 0.5:1.5);
    return false;
}

// Source ntte_step: the countdown starts after the first actual loss; merely
// holding a bonus does not drain it. Restore before native death/health lerp.
function scrNTTEFullBonusPlayerStep() {
    if(lockstep_stop || !scrNTTEFullPlayerActive(id)) return;
    if(scrNTTEFullValue(id,"bonus_ammo",0)!=0) {
        var _used=0,_save=scrNTTEFullValue(id,"bonus_ammo_save",[]);
        bonus_ammo_tick=scrNTTEFullValue(id,"bonus_ammo_tick",0);
        for(var _i=min(array_length(ammo),array_length(_save))-1;_i>=0;--_i) {
            var _diff=_save[_i]-ammo[_i];
            if(_diff>0 && (_save[_i]<=typ_amax[_i] || bonus_ammo_tick!=0)) {
                ammo[_i]+=_diff; _used+=_diff;
            }
        }
        bonus_ammo_save=array_create(array_length(ammo));
        array_copy(bonus_ammo_save,0,ammo,0,array_length(ammo));
        var _states=[scrNTTEFullValue(id,"ntte_state",undefined),scrNTTEFullValue(id,"bntte_state",undefined)];
        var _internal=scrNTTEFullValue(id,"bonus_ammo_save_internal",[]);
        bonus_ammo_save_internal=[];
        for(var _i=0;_i<2;++_i) {
            var _state=_states[_i];
            if(!is_struct(_state)) { bonus_ammo_save_internal[_i]=[undefined,0]; continue; }
            var _w=_state.weapon;
            // Source lwo entries with both ammo and cost; bones/tridents have no cost.
            var _eligible=_w==wep_ntte_sawblade_gun || _w==wep_ntte_sawblade_cannon
                || _w==wep_ntte_pizza_cutter || _w==wep_ntte_vampire || scrNTTEIsScythe(_w);
            if(_eligible && _i<array_length(_internal)) {
                var _prev=_internal[_i];
                var _diff=_prev[1]-_state.ammo;
                if(_prev[0]==_state && _diff>0) {
                    _state.ammo+=_diff; _used+=_diff;
                }
            }
            bonus_ammo_save_internal[_i]=[_state,_state.ammo];
        }
        drawempty=0; drawemptyb=0;
        bonus_ammo_max=max(abs(scrNTTEFullValue(id,"bonus_ammo_max",0)),abs(bonus_ammo));
        if(bonus_ammo>0) {
            if(bonus_ammo_tick==0 && _used>0) bonus_ammo_tick=1;
            var _last=bonus_ammo,_tick=bonus_ammo_tick*timescale;
            bonus_ammo-=_tick;
            if(bonus_ammo<=0) {
                bonus_ammo=0; bonus_ammo_max=0; bonus_ammo_tick=0; bonus_ammo_flash=0; bonus_ammo_save=[]; bonus_ammo_save_internal=[];
            } else if((_last mod 30)<_tick) {
                var _fx=instance_create(x,y,WepSwap); _fx.sprite_index=sprGunWarrant;
                _fx.image_angle=gunangle-90; _fx.image_blend=c_aqua; _fx.creator=id;
            }
        }
        if(_used>0 || bonus_ammo==0) {
            snd_play(choose(sndGruntFire,sndRogueRifle),(0.6+random(1))/clamp(_used,1,3),0.8+0.1*_used);
            var _fx=instance_create(x,y,WepSwap);
            _fx.sprite_index=sprImpactWrists; _fx.image_blend=merge_color(c_aqua,choose(c_white,c_blue),random(0.4));
            _fx.image_speed=0.35*timescale; _fx.creator=id;
            if(bonus_ammo!=0) {
                _fx.image_index=max(2-_fx.image_speed,3-_used/3);
                _fx.image_xscale=min(1.2,0.425+0.075*_used); _fx.image_yscale=_fx.image_xscale;
            } else {
                snd_play(sndLaserCannon,1.4+random(0.2),0.8); snd_play(sndEmpty,0.8+random(0.1));
            }
            bonus_ammo_flash=1;
        }
    }
    if(scrNTTEFullValue(id,"bonus_health",0)!=0) {
        var _color=merge_color(c_aqua,c_blue,random(0.4)),_effect_dir=direction;
        if(abs(scrNTTEFullValue(id,"bonus_health_max",0))<abs(bonus_health)) {
            if(scrNTTEFullValue(id,"bonus_health_max",0)==0) lsthealth=min(lsthealth,hp,max_hp);
            bonus_health_max=bonus_health;
        }
        var _heal=ceil(lsthealth)-hp;
        if(_heal>0) hp+=_heal;
        drawlowhp=0;
        bonus_health_tick=scrNTTEFullValue(id,"bonus_health_tick",0);
        if(bonus_health>0) {
            if(bonus_health_tick==0 && _heal>0) bonus_health_tick=1;
            var _last=bonus_health,_tick=bonus_health_tick*timescale;
            bonus_health-=_tick;
            if(bonus_health<=0) {
                bonus_health=0; bonus_health_max=0; bonus_health_tick=0; bonus_health_flash=0;
                sprite_index=spr_hurt; image_index=0;
                snd_play(sndLaserCannon,1.4+random(0.2),0.8); snd_play(sndEmpty,0.8+random(0.1));
                scrNTTEFullBonusHealthBurst(_color,_effect_dir,0.5);
            } else if((_last mod 15)<_tick) {
                var _len=random_range(4,12),_dir=wave*8;
                var _fx=instance_create(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir),FireFly);
                _fx.sprite_index=scrNTTERefSprite("BonusFX"); _fx.depth=depth-1;
            }
        }
        if(_heal>0) {
            snd_play(sndRogueAim,2+random(0.5),0.7); snd_play(sndHPPickup,0.6+random(0.1),0.7);
            scrNTTEFullBonusHealthHit(_color,_effect_dir,0.5);
            bonus_health_flash=1;
        }
    }
}
// These snapshots contain live weapon structs. Never serialize them: JSON
// would duplicate their identities and can carry bound weapon methods.
function scrNTTEFullBonusSaveField(_key) {
    return _key!="bonus_ammo_save_internal" && _key!="bonus_ammo_save";
}
function scrNTTEFullBonusAfterLoad() {
    bonus_ammo_save=[];
    bonus_ammo_save_internal=[];
    // Timer/max/flash are ordinary saved values. Rebase ammo on the first
    // resumed step so loading never refunds an unrelated restored weapon.
}
// Source level_start marks all eligible originals once, even a failed random
// roll. Runtime crown setup processes only later unmarked drops.
function scrNTTEFullBonusLevelStart(_forced=undefined) {
    if(!scrNTTEFullFeatureReady("bonus") && is_undefined(_forced)) return;
    var _normal=GameCont.hard>1 && instance_number(enemy)>instance_number(HostileHorror);
    var _crown=scrNTTEFullCrownKey(GameCont.crown)=="bonus";
    var _list=scrNTTEFullInstances([AmmoPickup,HPPickup,AmmoChest,HealthChest,Mimic,SuperMimic]);
    for(var _i=0;_i<array_length(_list);++_i) {
        var _inst=_list[_i];
        if(!instance_exists(_inst) || variable_instance_exists(_inst,"bonus_pickup_check")) continue;
        _inst.bonus_pickup_check=(random(6)<1 && _normal && GameCont.hard>8) || _crown;
        if(!is_undefined(_forced)) _inst.bonus_pickup_check=_forced;
        if(!_inst.bonus_pickup_check) continue;
        var _key="";
        if((instance_is(_inst,AmmoChest) && !instance_is(_inst,IDPDChest)) || instance_is(_inst,Mimic)) _key="Ammo";
        else if(instance_is(_inst,HealthChest) || instance_is(_inst,SuperMimic)) _key="Health";
        if(_key!="") {
            scrNTTEFullLairChestCreate(_inst.x,_inst.y,"Bonus"+_key+(instance_is(_inst,enemy) ? "Mimic":"Chest"),true);
            instance_destroy(_inst,false);
        }
    }
}
function scrNTTEFullBonusCrownStep() {
    if(!scrNTTEFullFeatureReady("bonus") || instance_exists(GenCont) || lockstep_stop) return;
    if(scrNTTEFullCrownKey(GameCont.crown)!="bonus") return;
    var _list=scrNTTEFullInstances([AmmoPickup,HPPickup,AmmoChest,HealthChest,Mimic,SuperMimic]);
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) scrNTTEFullBonusCrownSetup(_list[_i]);
}
function scrNTTEFullBonusCrownTests() {
    var _crown=GameCont.crown,_p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"bonus_ammo",0);
    GameCont.crown=NTTEFullCrown.Bonus; _p.bonus_ammo=0;
    var _item=instance_create(40000,40000,AmmoPickup),_n=instance_number(NTTEFullBonusAmmoPickup);
    assert(scrNTTEFullBonusCrownSetup(_item) && !instance_exists(_item) && instance_number(NTTEFullBonusAmmoPickup)==_n+1,
        "Bonus crown failed actual dynamic ammo replacement");
    _item=instance_create(40020,40000,HPPickup); _item.bonus_pickup_check=false;
    assert(!scrNTTEFullBonusCrownSetup(_item) && instance_exists(_item),"Bonus crown retried a source-marked failed replacement");
    instance_destroy(_item,false);
    _item=instance_create(40040,40000,HealthChest); var _open=instance_create(_item.xstart,_item.ystart,ChestOpen);
    // Native ChestOpen has no default sprite; real chest opening supplies it.
    _open.sprite_index=sprHealthChestOpen;
    assert(!scrNTTEFullBonusCrownSetup(_item) && instance_exists(_item) && _item.bonus_pickup_check,
        "Bonus crown replaced a chest inside existing open shell");
    instance_destroy(_item,false); instance_destroy(_open,false);
    _item=instance_create(40060,40000,SuperMimic); _n=instance_number(NTTEFullBonusAmmoMimic);
    assert(scrNTTEFullBonusCrownSetup(_item) && instance_number(NTTEFullBonusAmmoMimic)==_n+1,
        "Bonus crown did not preserve source dynamic health-mimic to ammo-mimic conversion");
    _item=instance_create(40080,40000,HealthChest); _n=instance_number(NTTEFullBonusHealthChest);
    scrNTTEFullBonusLevelStart(true);
    assert(!instance_exists(_item) && instance_number(NTTEFullBonusHealthChest)==_n+1,
        "Level-start bonus conversion lost original health identity");
    instance_destroy(NTTEFullBonusAmmoMimic,false); instance_destroy(NTTEFullBonusAmmoPickup,false);
    instance_destroy(NTTEFullBonusHealthChest,false); GameCont.crown=_crown; _p.bonus_ammo=_old;
    scrNTTESmokeLog("FULL BONUS CROWN: actual dynamic replacement, source marked failures/open shells, true mimic and level-start health distinction OK; helper fixture only");
}
function scrNTTEFullBonusHUDData(_p,_health) {
    var _prefix=_health ? "bonus_health":"bonus_ammo";
    var _value=scrNTTEFullValue(_p,_prefix,0);
    if(_value<=0) return undefined;
    var _tick=scrNTTEFullValue(_p,_prefix+"_tick",0);
    var _max=scrNTTEFullValue(_p,_prefix+"_max",_value);
    var _flash=scrNTTEFullValue(_p,_prefix+"_flash",0);
    var _spr=scrNTTERefSprite((_health ? "BonusHealth":"BonusAmmo")+"HUDFill"+(_tick==0 ? "":"Drain"));
    return {value:_value,tick:_tick,flash:_flash,sprite:_spr,
        width:sprite_get_width(_spr)*clamp(_value/max(0.001,_max),0,1),
        height:sprite_get_height(_spr),extra:ceil(_value/(_health ? 30:60))-1,
        // Epsilon's healthbar is 17px right of the original NTT custom HUD.
        x:_health ? 22:(UberCont.coop ? 22:5),y:_health ? 7:49,
        prefix:_prefix,flashout:!_health && _value<=2*_tick};
}
function scrNTTEFullBonusHUD(_p) {
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    var _col=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog();
    draw_set_color(c_white); draw_set_alpha(1);
    for(var _i=0;_i<2;++_i) {
        var _health=_i==1,_d=scrNTTEFullBonusHUDData(_p,_health);
        if(is_undefined(_d)) continue;
        var _x=_d.x,_y=_d.y,_spr=_d.sprite,_img=_d.flash;
        if(_d.flashout) {
            gpu_set_fog(true,c_white,0,0);
            draw_sprite(scrNTTERefSprite("BonusAmmoHUD"),0,_x,_y);
            gpu_set_fog(_fog);
        } else {
            if(_health) {
                draw_sprite(sprHealthBar,2,_x-2,_y-3);
                if(_p.max_hp>0 && _p.lsthealth<_p.hp && !instance_exists(GenCont) && !instance_exists(LevCont)) _img=1;
            } else draw_sprite(scrNTTERefSprite("BonusAmmoHUD"),0,_x,_y);
            draw_sprite_ext(_spr,0,_x,_y,1,1,0,make_color_hsv(_p.wave mod 256,80,80),1);
            draw_sprite_part(_spr,_img,0,0,_d.width,_d.height,_x,_y);
            scrNTTEFullBonusHUDLabel(_x,_y,sprite_get_width(_spr),_d.height,_d.extra);
        }
        if(_d.flash>0 && instance_exists(_p)) {
            var _flash=_d.flash+0.4*timescale;
            variable_instance_set(_p,_d.prefix+"_flash",_flash>=sprite_get_number(_spr) ? 0:_flash);
        }
    }
    gpu_set_fog(_fog); draw_set_font(_font); draw_set_halign(_ha); draw_set_valign(_va);
    draw_set_color(_col); draw_set_alpha(_alpha);
}
function scrNTTEFullBonusHUDSaveTests() {
    scrNTTEFullBonusHUDLabelTests();
    var _p=instance_find(Player,0);
    _p.bonus_ammo=180; _p.bonus_ammo_max=240; _p.bonus_ammo_tick=1; _p.bonus_ammo_flash=1;
    _p.bonus_health=60; _p.bonus_health_max=90; _p.bonus_health_tick=0; _p.bonus_health_flash=1;
    with(_p) scrNTTEFullBonusPlayerStep();
    var _before=_p.bonus_ammo,_d=scrNTTEFullBonusHUDData(_p,false);
    assert(_d.extra==2 && _d.sprite==scrNTTERefSprite("BonusAmmoHUDFillDrain") && _d.width<sprite_get_width(_d.sprite),
        "Bonus HUD lost source timer/count/partial fill");
    var _s=surface_create(160,64),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    surface_set_target(_s); draw_clear_alpha(c_black,0); scrNTTEFullBonusHUD(_p); surface_reset_target();
    assert(_p.bonus_ammo==_before && _p.bonus_ammo_flash>1 && _p.bonus_health_flash>1,
        "Bonus HUD changed gameplay timer or did not animate both flashes");
    assert(draw_get_font()==_font && draw_get_halign()==_ha && draw_get_valign()==_va,"Bonus HUD leaked text render state");
    surface_free(_s);
    var _buf=buffer_create(65536,buffer_grow,1);
    scrSavegamePlayers(_buf,false); buffer_seek(_buf,buffer_seek_start,0);
    assert(buffer_read(_buf,buffer_u8)==SavegamePart.PlayerData,"Bonus test missing real native player save section");
    var _rows=json_parse(buffer_read(_buf,buffer_string)),_found=false;
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _row=_rows[_i];
        if(scrNTTEFullValue(_row,"bonus_ammo",0)!=_before) continue;
        _found=true;
        assert(!variable_struct_exists(_row,"bonus_ammo_save_internal") && !variable_struct_exists(_row,"bonus_ammo_save"),
            "Native save serialized live bonus weapon snapshots");
        assert(_row.bonus_ammo_tick==1 && _row.bonus_health_tick==0 && _row.bonus_health_max==90,
            "Native continuation lost bonus activation/max state");
    }
    buffer_delete(_buf); assert(_found,"Bonus state was absent from native save");
    with(_p) scrNTTEFullBonusAfterLoad();
    assert(array_length(_p.bonus_ammo_save_internal)==0 && _p.bonus_ammo_tick==1,"Bonus load did not rebase live snapshots");
    _p.bonus_ammo=0; _p.bonus_health=0; _p.bonus_health_max=0;
    scrNTTESmokeLog("FULL BONUS HUD/SAVE: source counts/drain fill, actual surface render, flash/state restoration and native JSON snapshot exclusion OK");
}
function scrNTTEFullBonusPickupSmoke() {
    var _p=instance_find(Player,0),_old_hp=_p.hp,_old_lst=_p.lsthealth;
    scrNTTESmokeLog("BONUS PICKUP ENTRY DIAG "+json_stringify({health:scrNTTEFullValue(_p,"bonus_health",0),
        max:scrNTTEFullValue(_p,"bonus_health_max",0),tick:scrNTTEFullValue(_p,"bonus_health_tick",0),hp:_p.hp,lst:_p.lsthealth}))
    var _ammo=_p.ammo[Ammo.Bullets];
    _p.bonus_ammo=0; _p.bonus_health=0; _p.bonus_health_max=0; _p.bonus_health_tick=0; _p.bonus_ammo_tick=0; _p.bonus_ammo_save=[];
    var _item=instance_create(_p.x,_p.y,NTTEFullBonusAmmoPickup);
    _item.num=2;
    with(_item) scrNTTEFullCustomPickupOpen(_p);
    assert(!instance_exists(_item) && _p.bonus_ammo==120,"Bonus ammo actual contact failed120ticks grant");
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(_p.bonus_ammo==120,"Bonus ammo drained before spending ammo");
    _p.ammo[Ammo.Bullets]=max(0,_p.ammo[Ammo.Bullets]-1);
    var _before=_p.bonus_ammo_save[Ammo.Bullets];
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(_p.ammo[Ammo.Bullets]==_before && abs(_p.bonus_ammo-(120-timescale))<0.001,"Bonus ammo failed native reserve restore/start timer");
    var _old_wep=_p.wep,_old_state=scrNTTEFullValue(_p,"ntte_state",undefined),_old_inf=_p.infammo;
    _p.wep=wep_ntte_sawblade_gun; _p.infammo=0;
    var _state=undefined;
    with(_p) _state=scrNTTEState();
    with(_p) scrNTTEFullBonusPlayerStep();
    with(_p) scrNTTESpend(_state,1,true);
    assert(_state.ammo==2,"Bonus internal test did not spend a real disc");
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(_state.ammo==3 && _state.outstanding==1,"Bonus ammo failed identity-preserving internal weapon restore");
    _p.wep=_old_wep; _p.ntte_state=_old_state; _p.infammo=_old_inf;
    _item=instance_create(_p.x,_p.y,NTTEFullBonusHealthChest); _item.num=2;
    with(_item) scrNTTEFullCustomChestOpen(_p);
    assert(!instance_exists(_item) && _p.bonus_health==60,"Bonus health actual chest failed60tick grant");
    with(_p) scrNTTEFullBonusPlayerStep();
    var _before=_p.hp;
    _p.hp-=3;
    with(_p) scrNTTEFullBonusPlayerStep();
    scrNTTESmokeLog("BONUS HEALTH RESTORE DIAG "+json_stringify({hp:_p.hp,expectedHp:_before,
        health:_p.bonus_health,expectedHealth:60-timescale,tick:_p.bonus_health_tick,lst:_p.lsthealth}))
    assert(_p.hp==_before && abs(_p.bonus_health-(60-timescale))<0.001,"Bonus health did not restore damage/start timer");
    _p.bonus_health=timescale; _p.bonus_health_tick=1;
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(_p.bonus_health==0 && _p.bonus_health_max==0,"Bonus health timer did not expire/clear");
    _item=instance_create(10080,10080,NTTEFullBonusAmmoChest);
    var _portal=instance_create(10080,10080,PortalShock),_n=instance_number(NTTEFullBonusAmmoPickup);
    with(_item) scrNTTEFullCustomChestOpen(_portal);
    assert(instance_number(NTTEFullBonusAmmoPickup)==_n+2,"Portal opened bonus chest did not split into two pickups");
    instance_destroy(_portal,false); instance_destroy(NTTEFullBonusAmmoPickup,false);
    _p.ammo[Ammo.Bullets]=_ammo; _p.hp=_old_hp; _p.lsthealth=_old_lst;
    _p.bonus_ammo=0; _p.bonus_ammo_save=[]; _p.bonus_ammo_save_internal=[]; _p.bonus_ammo_tick=0; _p.bonus_health=0; _p.bonus_health_tick=0;
    scrNTTESmokeLog("FULL BONUS: original chest/pickup grants, idle retention, actual reserve/internal weapon/health restore, activation/expiry and portal split OK; mimics/HUD not covered");
}
function scrNTTEFullTextMarkupTests() {
    var _text=render_parse_text("@(color:123)AB@wC");
    var _plain=render_parse_text("ABC"),_found=false;
    for(var _l=0;_l<array_length(_text.lines);++_l) {
        var _parts=_text.lines[_l].strings;
        for(var _i=0;_i<array_length(_parts);++_i) {
            var _part=_parts[_i];
            if(_part.type==TextRenderFragment.Color && _part.color==123) _found=true;
            assert(_part.type!=TextRenderFragment.Sprite,"Numeric RGB markup became a sprite");
        }
    }
    assert(_found && _text.width==_plain.width && _text.height==_plain.height,
        "Numeric RGB markup altered text layout or lost color");
    _text=render_parse_text("@5(sprNTTERefBonusText:-0.3) HP");
    _found=false;
    for(var _i=0;_i<array_length(_text.lines[0].strings);++_i) {
        var _part=_text.lines[0].strings[_i];
        if(_part.type!=TextRenderFragment.Sprite) continue;
        _found=true;
        assert(_part.sprite_index==scrNTTERefSprite("BonusText") && _part.image_index==-0.3
            && _part.ntt_slots==5 && _part.ntt_width==5*font_get_string_width("A"),
            "Documented NTT slot width/colon animation markup changed");
    }
    assert(_found && _text.width==5*font_get_string_width("A")+font_get_string_width(" HP"),
        "NTT slot markup printed literal parentheses or changed reserved layout");
    _text=render_parse_text("@(sprNTTERefBonusText,2)"); _found=false;
    for(var _i=0;_i<array_length(_text.lines[0].strings);++_i) {
        var _part=_text.lines[0].strings[_i];
        if(_part.type==TextRenderFragment.Sprite) { _found=true; assert(_part.image_index==2,"Native comma frame syntax regressed"); }
    }
    assert(_found,"Native comma sprite syntax lost");
    scrNTTESmokeLog("FULL TEXT: original NTT numeric RGB markup preserves native string layout and color resets OK");
}
function scrNTTEFullBonusVisualTests() {
    var _p=instance_find(Player,0),_hp=_p.hp,_lst=_p.lsthealth;
    var _bonus=scrNTTEFullValue(_p,"bonus_ammo",0);
    _p.bonus_ammo=60;
    var _shell=instance_create(_p.x,_p.y,Shell),_heavy=instance_create(_p.x,_p.y,HeavyShell);
    var _can=instance_create(_p.x,_p.y,Shell); _can.sprite_index=sprSodaCan;
    with(_shell) scrNTTEFullBonusShellSetup(); with(_heavy) scrNTTEFullBonusShellSetup(); with(_can) scrNTTEFullBonusShellSetup();
    assert(_shell.sprite_index==scrNTTERefSprite("BonusShell") && _heavy.sprite_index==scrNTTERefSprite("BonusShellHeavy")
        && _can.sprite_index==sprSodaCan,"Bonus setup lost real shell weight or soda-can exception");
    var _count=instance_number(BoltTrail);
    _p.bonus_health=60; _p.bonus_health_max=60; _p.bonus_health_tick=0; _p.bonus_health_flash=0; _p.lsthealth=_p.hp;
    _p.hp-=2;
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(_p.hp==_hp && instance_number(BoltTrail)==_count+16,"Bonus health damage did not restore HP and emit source ring");
    _count=instance_number(BoltTrail); _p.hp-=1;
    with(_p) scrNTTEFullBonusPlayerStep();
    assert(instance_number(BoltTrail)==_count,"Bonus flash cooldown repeated the source ring");
    var _popup=noone;
    with(_p) _popup=scrNTTEFullBonusPopup(false,3);
    assert(_popup.ntte_full_target==_p.index,"Bonus localized popup lost player screen ownership");
    if(scrNTTEFullIsSimplifiedChinese()) {
        assert(string_pos("无限",_popup.mytext)>0 && string_pos("弹药",_popup.mytext)>0
            && string_pos("sprNTTERefBonusText",_popup.mytext)==0,
            "Bonus popup lost translated Chinese caption");
    } else {
        assert(string_pos("@5(sprNTTERefBonusText:-0.3)",_popup.mytext)>0,
            "Bonus popup lost original animated English caption");
    }
    var _surface=surface_create(120,32);
    surface_set_target(_surface); draw_clear_alpha(c_black,0); scrNTTEFullDrawText(0,0,_popup.mytext); surface_reset_target(); surface_free(_surface);
    instance_destroy(_shell,false); instance_destroy(_heavy,false); instance_destroy(_can,false); instance_destroy(_popup,false);
    _p.hp=_hp; _p.lsthealth=_lst; _p.bonus_ammo=_bonus; _p.bonus_health=0; _p.bonus_health_max=0; _p.bonus_health_tick=0;
    scrNTTESmokeLog("FULL BONUS VISUALS: actual light/heavy/soda shells, 16-segment hit ring/cooldown and localized icon popup surface render OK");
}
function scrNTTEFullBonusMimicSmoke() {
    var _p=instance_find(Player,0),_oldhp=_p.hp,_nexthurt=_p.nexthurt;
    var _m=instance_create(10080,10080,NTTEFullBonusAmmoMimic);
    assert(_m.hp==12 && _m.size==1 && _m.raddrop==6 && _m.meleedamage==3,"Bonus ammo mimic source stats changed");
    var _n=instance_number(NTTEFullBonusAmmoPickup);
    _p.nexthurt=0;
    with(_m) scrNTTEFullBonusMimicContact(_p);
    assert(_p.hp==_oldhp-3 && instance_number(NTTEFullBonusAmmoPickup)==_n+1 && !_m.canmelee,
        "Bonus ammo mimic real bite failed damage/drop/cooldown");
    with(_m) scrNTTEFullBonusMimicContact(_p);
    assert(instance_number(NTTEFullBonusAmmoPickup)==_n+1,"Mimic repeated reward during cooldown");
    _m.hp=0; instance_destroy(_m);
    assert(instance_number(NTTEFullBonusAmmoPickup)==_n+3,"Ammo mimic death did not drop two bonus items");
    var _a=instance_create(10080,10080,NTTEFullBonusHealthMimic),_b=instance_create(10090,10080,NTTEFullBonusHealthMimic);
    assert(_a.hp==12 && _a.raddrop==15 && _a.meleedamage==4 && _a.tell_wait_min==180,"Bonus health mimic source stats changed");
    _p.nexthurt=0;
    with(_a) scrNTTEFullBonusMimicContact(_p);
    assert(!_b.canmelee && _b.alarm[11]>=30,"Health mimic failed shared bite cooldown");
    _a.ntte_bonus_tell_left=timescale;
    with(_a) scrNTTEFullBonusMimicStep();
    assert(_a.sprite_index==_a.spr_chrg && _a.image_index==0 && _a.ntte_bonus_tell_left>=180,
        "Health mimic source tell animation/timing changed");
    instance_destroy(_a,false); instance_destroy(_b,false);
    instance_destroy(NTTEFullBonusAmmoPickup,false); instance_destroy(NTTEFullBonusHealthPickup,false);
    _p.hp=_oldhp; _p.nexthurt=_nexthurt;
    scrNTTESmokeLog("FULL BONUS MIMICS: source stats/tell, actual bite damage/reward, native cooldown, shared health cooldown and two death drops OK");
}

// Draw the original infinity artwork directly; its pixels do not require a font glyph.
function scrNTTEFullBonusHUDLabel(_x,_y,_width,_height,_extra) {
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_spr=scrNTTERefSprite("BonusHUDText"),
        _text=_extra>0?"+"+string(_extra):""
    draw_set_font(fntSmall);draw_set_halign(fa_left);draw_set_valign(fa_top)
    var _sw=sprite_get_width(_spr),_sh=sprite_get_height(_spr),_gap=_text!=""?1:0,
        _tw=string_width(_text),_th=_text!=""?max(13,string_height(_text)):0,
        _scale=min(1,(_width-2)/max(1,_sw+_gap+_tw),_height/max(1,_sh,_th)),
        _left=round(_x+(_width-(_sw+_gap+_tw)*_scale)/2),_top=round(_y+(_height-_sh*_scale)/2)
    draw_sprite_ext(_spr,0,_left+sprite_get_xoffset(_spr)*_scale,
        _top+sprite_get_yoffset(_spr)*_scale,_scale,_scale,0,c_white,1)
    if(_text!="") draw_text_transformed(_left+(_sw+_gap)*_scale,_y+(_height-_th*_scale)/2,_text,_scale,_scale,0)
    draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va)
}
function scrNTTEFullBonusHUDLabelTests() {
    var _s=surface_create(96,32),_ref=surface_create(96,32),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _state=scrNTTEFullCoastDrawState(),_camera=camera_create_view(0,0,96,32),_shader=shader_current(),_target=false
    assert(surface_exists(_s) && surface_exists(_ref),"Infinity label fixture allocation failed")
    gpu_push_state()
    try {
        shader_reset();gpu_set_fog(false,c_white,0,0);gpu_set_texfilter(false);gpu_set_blendmode(bm_normal)
        draw_set_color(c_white);draw_set_alpha(1)
        var _extras=[0,1,999,99999999]
        for(var _i=0;_i<array_length(_extras);++_i) {
            surface_set_target(_s);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,0)
            scrNTTEFullBonusHUDLabel(20,12,46,6,_extras[_i]);surface_reset_target();_target=false
            var _pixels=0
            for(var _y=0;_y<32;++_y) for(var _x=0;_x<96;++_x) if((surface_getpixel_ext(_s,_x,_y)>>24)&255) {
                _pixels++;assert(_x>=20 && _x<66 && _y>=12 && _y<18,"Infinity label exceeded bar: extra="+string(_extras[_i])+" x="+string(_x)+" y="+string(_y))
            }
            assert(_pixels>0,"Infinity label drew no artwork")
            if(_i==0) {
                surface_set_target(_ref);_target=true;camera_apply(_camera);draw_clear_alpha(c_black,0)
                draw_sprite(scrNTTERefSprite("BonusHUDText"),0,43,15);surface_reset_target();_target=false
                for(var _y=0;_y<32;++_y) for(var _x=0;_x<96;++_x)
                    assert(surface_getpixel_ext(_s,_x,_y)==surface_getpixel_ext(_ref,_x,_y),"Infinity artwork differed from original sprite")
            }
        }
        assert(draw_get_font()==_font && draw_get_halign()==_ha && draw_get_valign()==_va,"Infinity label leaked font state")
    } finally {
        if(_target) surface_reset_target()
        surface_free(_s);surface_free(_ref);camera_destroy(_camera);gpu_pop_state()
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("BONUS INFINITY original14x6 sprite / suffix fit / all pixels inside46x6 / draw-state restoration OK")
}
