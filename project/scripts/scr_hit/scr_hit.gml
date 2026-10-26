/// @function scr_hit
/// @param instance
/// @param amount
/// @param {Enum.HitId|Array} hitid=HitId.None
function scr_hit(_instance, _amount, _hitid = HitId.None, _ntte_raw = false, _ntte_direction = undefined, _ntte_force = 0) {

    if(scrUGHasHurt(_instance)) return scrUGHurt(_instance,_amount,is_undefined(_ntte_direction)?scrNTTEFullValue(id,"direction",0):_ntte_direction,_ntte_force);
    // NTTE callback direction/force: raw0, explicit native projectile args
    if(_ntte_raw==1) { _ntte_direction=0; _ntte_force=0; }
    else if(is_undefined(_ntte_direction)) _ntte_direction=scrNTTEFullValue(id,"direction",0);
    if(scrUGHasHurt(_instance)) return scrUGHurt(_instance,_amount,_ntte_direction,_ntte_force);
    // NTTE Weapon Mimic source hurt after raw/explicit direction normalization.
    if(instance_is(_instance,NTTEFullPetWeaponBoss))
        return scrNTTEFullWeaponMimicBossHurt(_instance,_amount,_ntte_direction,_ntte_force,id);
    // NTTE SawTrap authored CustomHitme hurt, logical force.
    if(instance_is(_instance,NTTEFullSawTrap))
        return scrNTTEFullSawTrapHurt(_instance,_amount,_ntte_direction,_ntte_force/timescale,id);
    // NTTE TrafficCrab original hurt callback
    if(instance_is(_instance,NTTEFullTrafficCrab)) {
        scrNTTEFullTrafficCrabHurt(_instance,_amount,_ntte_direction,_ntte_force,id); return true;
    }
    // NTTE Tesseract complete authored hurt callback.
    if(instance_is(_instance,NTTEFullTesseract))
        return scrNTTEFullTesseractHurt(_instance,_amount,_ntte_direction,_ntte_force,id);
    // NTTE CrystalBrain complete authored hurt callback.
    if(instance_is(_instance,NTTEFullCrystalBrain))
        return scrNTTEFullCrystalBrainHurt(_instance,_amount,_ntte_direction,_ntte_force,id);
    // NTTE RedSpider complete authored hurt callback.
    if(instance_is(_instance,NTTEFullRedSpider))
        return scrNTTEFullRedSpiderHurt(_instance,_amount,_ntte_direction,_ntte_force,id);
    // NTTE PitSquid complete authored hurt callback.
    if(instance_is(_instance,NTTEFullPitSquid))
        return scrNTTEFullPitSquidHit(_instance,_amount,_ntte_direction,_ntte_force,id);
    if(instance_is(_instance,NTTEFullPitSquidArm))
        return scrNTTEFullPitSquidArmHit(_instance,_amount,_ntte_direction,_ntte_force,id,_hitid);

    // NTTE Coast original hurt callbacks
    if(instance_is(_instance,NTTEFullCoastBossBecome)) {
        scrNTTEFullCoastBossBecomeHurt(_instance,_amount,_ntte_direction,_ntte_force,id); return true;
    }
    if(instance_is(_instance,NTTEFullCoastBoss)) {
        scrNTTEFullCoastBossHurt(_instance,_amount,_ntte_direction,_ntte_force,id); return true;
    }

    if(instance_is(_instance,NTTEFullPalanking)) {
        scrNTTEFullPalankingHurt(_instance,_amount,_ntte_direction,_ntte_force,id);
        return true;
    }
    if(scrNTTEFullPetInterceptHit(_instance,_amount,id)) return true;
    if(scrNTTEFullSewerBossBlocksHit(_instance,id)) return false;
    if(scrNTTEFullMortarInterceptHit(_instance,_amount)) return true;
    if(scrNTTEFullWorldInterceptHit(_instance,_amount)) return true
	if (scrNTTECatBlocksHit(_instance,id)) return false
	if (scrNTTEAlbinoInterceptHit(_instance,_amount)) return true
	if ((_amount>0 || _ntte_raw) && scrNTTESewerInterceptHit(_instance)) return false
	with (_instance) {
		if (instance_is(self, Player)) {
			var _adj = scrCustomParam("damage_to_player", 0)
			if (_amount != 0 && _adj != 0) _amount = max(1, _amount + _adj)
			if (scrPlayerProcTakeDamage(_amount)) return false
			if (is_array(_hitid) || (_hitid >= 0 && _hitid != HitId.Player)) {
				if (scr_player_is_local(index) && _amount > 0) GameCont.deathcause = _hitid
			}
			if(_amount>0) ntte_last_hit=_hitid;
			drawlowhp = 30
		}
		
		if (_amount > 0 || _ntte_raw) {
			nexthurt = current_frame + 6
			// BEGIN NTTE LAIR BATTLE EXIT READONLY ACCEPTED HP LOSS BEFORE
            var _ntte_lair_battle_exit_hp_sample=undefined;
            if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
                _ntte_lair_battle_exit_hp_sample=scrNTTEFullLairBattleExitBossLossBefore(_amount,_hitid,other.id,_ntte_raw);
            // END NTTE LAIR BATTLE EXIT READONLY ACCEPTED HP LOSS BEFORE
            hp -= _amount
            // BEGIN NTTE LAIR BATTLE EXIT READONLY ACCEPTED HP LOSS AFTER
            if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
                scrNTTEFullLairBattleExitBossLossAfter(_ntte_lair_battle_exit_hp_sample);
            // END NTTE LAIR BATTLE EXIT READONLY ACCEPTED HP LOSS AFTER
		}
		
		sprite_index = spr_hurt
		image_index = 0
		
		snd_play_hit(snd_hurt, 0.2)
        if(instance_is(id,NTTEFullSeal)) scrNTTEFullSealHurt();
        if((_amount>0 || _ntte_raw) && (instance_is(id,NTTEFullAngler) || instance_is(id,NTTEFullAnglerGold))) scrNTTEFullAnglerHurt()
        if((_amount>0 || _ntte_raw) && instance_is(id,NTTEFullBatBoss)) scrNTTEFullBatBossHurt(_amount,other.id);
        if((_amount>0 || _ntte_raw) && instance_is(id,NTTEFullCatBoss)) scrNTTEFullCatBossHurt(_amount,other.id,_ntte_direction,_ntte_force);
        if(instance_is(id,NTTEFullCatDoor)) scrNTTEFullCatDoorHurt(_amount,other.id);
        if((_amount>0 || _ntte_raw) && instance_is(id,NTTEFullBloomingAssassinHide)) scrNTTEFullBloomingAssassinHideHurt();
		
		if (instance_is(id,NTTEBat)) scrNTTEBatHurt(_amount,other.id)
        scrNTTEFullHurtParityAfter(id,_amount,_ntte_direction,_ntte_force,other.id);
		if (global.__debug_health) {
			if (is_array(_hitid) || _hitid >= 0) {
				print(real(id), object_get_name(object_index), $"{hp}/{max_hp}", "was hit by", _amount, "from", scrDeathCauseGetName(_hitid), $"({object_get_name(other.object_index)})")
			}
			else {
				print(real(id), object_get_name(object_index), $"{hp}/{max_hp}", "was hit by", _amount, "from", _hitid, $"({object_get_name(other.object_index)})")
			}
		}
		
		return true
	}
	
	return false
}

/// @function scr_hit_self
/// @param amount
/// @param {Enum.HitId|Array} hitid=HitId.None
function scr_hit_self(_amount, _hitid = HitId.None) {
	gml_pragma("forceinline")
	return scr_hit(id, _amount, _hitid)
}

/// @function scr_projectile_hit
/// @param instance
/// @param amount
/// @param knockback_amount=0
/// @param knockback_direction=direction
function scr_projectile_hit(_instance, _amount, _kb_amount = 0, _kb_direction = undefined, _ntte_native_direct = false, _ntte_hitid = undefined) {
    if(scrUGHasHurt(_instance)) return scrUGHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount);
    // NTTE Tesseract complete authored projectile callback.
    if(instance_is(_instance,NTTEFullTesseract))
        return scrNTTEFullTesseractHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id);
    // NTTE Weapon Mimic complete projectile hurt callback.
    if(instance_is(_instance,NTTEFullPetWeaponBoss))
        return scrNTTEFullWeaponMimicBossHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id);
    // NTTE SawTrap complete projectile callback.
    if(instance_is(_instance,NTTEFullSawTrap))
        return scrNTTEFullSawTrapHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount/timescale,id);
    // NTTE CrystalBrain complete authored projectile callback.
    if(instance_is(_instance,NTTEFullCrystalBrain))
        return scrNTTEFullCrystalBrainHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id);
    // NTTE RedSpider complete authored projectile callback.
    if(instance_is(_instance,NTTEFullRedSpider))
        return scrNTTEFullRedSpiderHurt(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id);
    // NTTE TrafficCrab original projectile hurt callback
    if(instance_is(_instance,NTTEFullTrafficCrab)) {
        var _dir=is_undefined(_kb_direction) ? scrNTTEFullValue(id,"direction",0):_kb_direction;
        scrNTTEFullTrafficCrabHurt(_instance,_amount,_dir,_kb_amount,id); return true;
    }

    // NTTE PitSquid complete authored projectile callback.
    if(instance_is(_instance,NTTEFullPitSquid)) {
        if(_amount<=0 && !_ntte_native_direct) return false;
        return scrNTTEFullPitSquidHit(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id);
    }

    // NTTE PitSquidArm full native projectile callback
    if(instance_is(_instance,NTTEFullPitSquidArm)) {
        if(_amount<=0 && !_ntte_native_direct) return false;
        return scrNTTEFullPitSquidArmHit(_instance,_amount,is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction,_kb_amount,id,
            is_undefined(_ntte_hitid)?scrNTTEFullValue(id,"hitid",HitId.None):_ntte_hitid);
    }

    // NTTE Coast original projectile hurt callbacks
    if(instance_is(_instance,NTTEFullCoastBossBecome) || instance_is(_instance,NTTEFullCoastBoss)) {
        var _dir=is_undefined(_kb_direction) ? scrNTTEFullValue(id,"direction",0):_kb_direction;
        if(instance_is(_instance,NTTEFullCoastBossBecome)) scrNTTEFullCoastBossBecomeHurt(_instance,_amount,_dir,_kb_amount,id);
        else scrNTTEFullCoastBossHurt(_instance,_amount,_dir,_kb_amount,id);
        return true;
    }

    if(instance_is(_instance,NTTEFullPalanking)) {
        if(_amount<=0 && !_ntte_native_direct) return false;
        scrNTTEFullPalankingHurt(_instance,_amount,is_undefined(_kb_direction)?direction:_kb_direction,_kb_amount,id);
        return true;
    }
    if(instance_is(_instance,NTTEFullBigMaggotSpawn) && _instance.hp<=1) _kb_amount=0;
    with(_instance) if(instance_is(id,NTTEFullPelican)) _kb_amount=scrNTTEFullPelicanKnockback(_kb_amount);
    if (instance_is(_instance,NTTEFullBloomingAssassinHide)) _kb_amount/=2;
    if (instance_is(_instance,NTTEFullCatBoss) && _instance.ntte_full_dash>0) _kb_amount=0;
    if (instance_is(_instance,NTTEAlbinoGator) && _instance.ntte_albino_spirit_ready) _kb_amount/=4
    // Hurt callbacks can forward a non-projectile source (GammaGuts/raw hit).
    // Carry the original cause explicitly rather than reading projectile-only
    // fields from that source or changing its identity/creator attribution.
    var _cause=_ntte_hitid;
    if(is_undefined(_cause) && (_amount>0 || _ntte_native_direct)) _cause=scrNTTEFullValue(id,"hitid",HitId.None);
	if (_amount > 0 || _ntte_native_direct) && scr_hit(_instance, _amount, _cause, _ntte_native_direct ? 2:false, is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction, _kb_amount) {
		if _kb_amount != 0 {
			if is_undefined(_kb_direction) {
				_kb_direction = direction
			}
			
			with (_instance) motion_add(_kb_direction, _kb_amount)
		}
		
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_hit
/// @param destroy=true
/// @param check_inframes=true
function scr_projectile_generic_hit(_destroy = true, _inframes = true) {
	if scr_can_hit(other.id, _inframes) && scr_projectile_hit(other.id, damage, knockback_speed) {
		if (_destroy) instance_destroy()
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_bullet_hit
/// @param recycle_gland_yield=1
function scr_projectile_generic_bullet_hit(_gland = 1) {
	if scr_can_hit(other.id, false) && scr_projectile_hit(other.id, damage, knockback_speed) {
		if (instance_is(creator, Player) && scr_skill_get(mut_recycle_gland) && random(1) < 0.6) {
			with (creator) {
				scrPlayerGiveAmmo(id, Ammo.Bullets, _gland)
			}
			
			snd_play_hit(sndRecGlandProc)
			instance_create(x, y, RecycleGland)
		}
		
		instance_destroy()
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_shell_hit
/// @param pointblank_bonus=1
function scr_projectile_generic_shell_hit(_bonus_amount = 1) {
	if scr_can_hit(other.id, false) {
		var _amount = damage + (bonus * _bonus_amount)
		
		if scr_projectile_hit(other.id, _amount, knockback_speed) {
			instance_destroy()
			return true
		}
	}
	
	return false
}

function scr_projectile_generic_plasma_hit() {
	// 接触类持续伤害按 30Hz 逻辑帧结算（同 laser，详见上）。
	// plasma 与目标持续重叠期间每物理帧命中一次：60 帧下「伤害 / 屏幕震动 / 收缩 / 反推」
	// 频率全部翻倍（实测：plasma ball 抖动频率过高、伤害同样过密）。
	// 门控后 60 帧 = 每 2 物理帧一次 → 与 30 帧真实时间一致；球体收缩步进也随之对齐
	//（60 帧下每 2 帧缩 0.1 → 存活帧数翻倍但真实时长与 30 帧相同）。
	// 30 帧 ts=1 → current_frame_active 恒真 → 行为逐帧不变。
	if (!current_frame_active) return false
	// 曾经在这里加「每 2 逻辑帧」的隔帧门控——**已撤销**：
	// 实测（10.17 NEW2b）30 帧的 plasma 对玩家/对道具都是「每 1 帧命中一次」（30/s），
	// 隔帧会把 60 帧砍成 15/s（半速），且每轮推进 2 逻辑帧只回退 1 物理帧 → 球会**穿过目标**。
	
	if scr_can_hit(other.id, false) {
		var _amount = floor(damage * (image_xscale + image_yscale) * 0.5)
		
		if scr_projectile_hit(other.id, _amount, knockback_speed) {
			instance_create(x, y, Smoke)
			snd_play(sndPlasmaHit)
			scr_screenshake(6)
			image_xscale -= 0.1
			image_yscale -= 0.1
			x -= hspeed
			y -= vspeed
			return true
		}
	}
	
	return false
}

/// @function scr_projectile_generic_grenade_hit
/// @param can_overkill_pierce=false
function scr_projectile_generic_grenade_hit(_pierce = false) {
	if scr_can_hit(other.id, false) {
		var _hp = other.hp
		if scr_projectile_hit(other.id, damage, knockback_speed) {
			if !_pierce || _hp > damage {
				instance_destroy()
			}
			
			return true
		}
	}
	
	return false
}

function scr_projectile_generic_flame_hit() {
	if scr_can_hit(other.id, true) {
		var _amount = damage
		
		if instance_is(other, Player) && scr_skill_get(mut_boiling_veins) {
			with other {
				if (hp - _amount) < veinsthreshold {
					_amount -= veinsthreshold - (hp - _amount)
				}
			}
		}
		
		return scr_hit(other.id, _amount, hitid)
	}
	
	return false
}

function scr_explosion_generic_hit() {
	if scr_can_hit(other.id, false) {
		var _amount = damage
		
		if instance_is(other, Player) && scr_skill_get(mut_boiling_veins) {
			with other {
				if (hp - _amount) < veinsthreshold {
					_amount -= veinsthreshold - (hp - _amount)
				}
			}
		}
		
		with (other) if (speed < (16) * timescale) {
			motion_add(point_direction(other.x, other.y, x, y), (6) * timescale)
			if (speed > (16) * timescale) speed = (16) * timescale
		}
		
		return scr_hit(other.id, _amount, hitid)
	}
	
	return false
}

function scr_projectile_generic_laser_hit() {
	// 接触类持续伤害按 30Hz 逻辑帧结算。
	// laser 光束在存活期间每物理帧都与目标重叠 → Collision_hitme 每帧命中一次；
	// 60 帧下命中频率翻倍（帧级伤害、非常密集）。门控后 = 每 2 物理帧结算一次，
	// 与 30 帧的「每逻辑帧一次」在真实时间上完全一致。
	// 30 帧 ts=1 → current_frame_active 恒真 → 行为逐帧不变（逐字节等价）。
	if (!current_frame_active) return false
	
	if scr_can_hit(other.id, false) && scr_projectile_hit(other.id, damage, knockback_speed) {
		with other {
			instance_create(bbox_center_x, bbox_center_y, Smoke)
		}
		
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_bolt_hit
/// @param can_overkill_pierce=true
function scr_projectile_generic_bolt_hit(_pierce=true) {
	if speed == 0 && !check_wall_hit_damage {
		return false
	}
	
	if scr_can_hit(other.id, false) {
		var _hp_last = other.hp
		
		if (!scr_projectile_hit(other.id, damage, knockback_speed)) return false
		
		if !_pierce || _hp_last >= (damage * 0.5) {
			var _target = other.id
			
			with instance_create(x, y, BoltStick) {
				sprite_index = other.sprite_index
				image_index = sprite_get_number(sprite_index) - 1
				image_angle = other.image_angle
	            target = _target
			}
			
			var _direction = direction,
				_speed = knockback_speed * 0.8
			
			with (other) motion_add_m(_direction, _speed, (16) * timescale)
			
			instance_destroy()
		}
		else motion_add_m(direction, knockback_speed)
		
		return true
	}
	
	return false
}
