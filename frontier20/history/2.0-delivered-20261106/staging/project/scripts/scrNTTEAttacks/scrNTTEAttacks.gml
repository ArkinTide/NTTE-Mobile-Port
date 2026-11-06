// Attacks use the native damage/team/creator pipeline; no NTT loader required.
function scrNTTEShot(_kind, _dir, _speed, _big = false) {
    var _p = scr_projectile_create(x, y, NTTEAttack, _dir, _speed)
    with (_p) {
        kind = _kind
        big = _big
        scrNTTEConfigureAttack()
    }
    return _p
}

function scrNTTESlash(_kind, _damage, _sprite, _state = undefined, _scale = 1) {
    var _l = 20 * scr_skill_get(mut_long_arms), _d = gunangle,
        _p = scr_projectile_create(x+lengthdir_x(_l,_d), y+lengthdir_y(_l,_d), NTTESwing, _d, 2+3*scr_skill_get(mut_long_arms))
    with (_p) {
        kind = _kind
        damage = _damage
        sprite_index = _sprite
        mask_index = _sprite
        state = _state
        image_index = 0
        image_speed = 0.4 * timescale
        image_xscale = _scale
        image_yscale = _scale * sign(other.wepangle == 0 ? 1 : other.wepangle)
    }
    return _p
}

function scrNTTEFireAll(_w, _primary) {
    if(scrUGWeaponFire(_w,_primary)) return;
    if(scrNTTEFullCrabbonePhysicalFire(_w,_primary)) return;
    if(scrNTTEFullCrabboneFire(_w,_primary)) return;
    if(_w==wep_ntte_dematerializer) {scrNTTEFullDematerializerFire(_primary);return;}
    if(_w==wep_ntte_vampire) {scrNTTEFullVampireFire(_primary);return;}
    if(_w==wep_ntte_tesla_coil) {scrNTTEFullTeslaWeaponFire(_primary);return;}
    if(scrNTTEFullQuasarWeaponIs(_w)) {scrNTTEFullQuasarWeaponFire(_w,_primary);return;}
    if(scrNTTEFullElectroWeaponIs(_w)) {scrNTTEFullElectroWeaponFire(_w,_primary);return;}
    if(scrNTTEIsTrident(_w)) {scrNTTEFullTridentFire(_w,_primary);return;}
    if(_w==wep_ntte_pizza_cutter) {scrNTTEFullPizzaWeaponFire(_primary);return;}
    if(scrNTTEIsTunnel(scrNTTEFullWeaponRaw(_w))) { scrNTTEFullTunnellerFire(_w,_primary); return; }
    // NTTE original weapon_fire_init charge lifecycle inside merged mounts.
    if(scrNTTEFullMergedRuntimeChargeRaw(_w,_primary)) return;
    if(scrNTTEFullWeaponRaw(_w)==wep_ntte_entangler) { scrNTTEFullEntanglerFire(_primary); return; }
    if(scrNTTEFullWeaponRaw(_w)==wep_ntte_annihilator) { scrNTTEFullRedWeaponFire(_primary); return; }
    if(scrNTTEFullBubbleWeaponIs(_w)) {scrNTTEFullBubbleWeaponFire(_w,_primary);return;}
    var _s = scrNTTEState(), _d = gunangle, _p = noone,
        _charge = _s.charge / max(1,scrNTTEChargeMax(_w)), _brain = scr_skill_get(mut_laser_brain)
    scrNTTEMuscle(_s)
    switch (_w) {
        case wep_ntte_bubble_bat:
            scrNTTEFullBubbleBatWeaponFire(_primary)
            return;
        case wep_ntte_bubble_rifle:
        case wep_ntte_bubble_minigun:
            // Schedule the remaining rounds in logical frames, charging ammo once.
            _p = scrNTTEShot(NTTEKind.Bubble, _d+orandom(12*accuracy),9)
            _p.burst_left = _w == wep_ntte_bubble_rifle ? 1 : 2
            _p.burst_delay = 2
            _p.burst_creator = id
            _p.burst_primary = _primary
            snd_play(sndGrenade,1.7,0.5)
            break
        case wep_ntte_bubble_shotgun:
            repeat(5) {
                _p = scrNTTEShot(NTTEKind.Bubble,_d+orandom(12*accuracy),random_range(9,10))
                with (_p) {
                    var _shift = random(32)
                    move_contact_solid(direction,_shift)
                }
            }
            snd_play(sndShotgun,1.5,0.7)
            break
        case wep_ntte_bubble_cannon:
            scrNTTEShot(NTTEKind.Bubble,_d+orandom(6*accuracy),9,true)
            snd_play(sndPlasmaBig,0.7)
            break
        case wep_ntte_hyper_bubbler:
            _p = scrNTTEShot(NTTEKind.HyperBubble,_d+orandom(3*accuracy),20)
            snd_play(sndHyperSlugger)
            break
        case wep_ntte_electroplasma_rifle:
        case wep_ntte_electroplasma_shotgun:
        case wep_ntte_electroplasma_cannon:
        case wep_ntte_dematerializer:
            scrNTTEFirePlasma(_w,_s,_primary)
            break
        case wep_ntte_energy_bat:
            scrNTTEFullEnergyBatWeaponFire(_primary)
            return;
        case wep_ntte_sawblade_gun:
        case wep_ntte_sawblade_cannon:
            scrNTTEFullDiscWeaponFire(_w,_s,_primary)
            return;
        case wep_ntte_pizza_cutter:
            scrNTTESlash(NTTESwingKind.Normal,_s.ammo>0 ? 20:8, _s.ammo>0 ? sprHeavySlash:sprSlash)
            if (_charge >= 1 && scrNTTESpend(_s,1,true)) {
                _p = scrNTTEFullPizzaDiscFire(_s,_primary)
            }
            snd_play(sndHammer)
            break
        case wep_ntte_tesla_coil:
        case wep_ntte_vampire:
            scrNTTEFireCoil(_w,_primary,_s)
            return;
        case wep_ntte_harpoon_launcher:
            scrNTTEFullHarpoonLauncherFire()
            return;
        case wep_ntte_net_launcher:
            scrNTTEFullNetLauncherFire()
            return;
        case wep_ntte_clam_shield:
            scrNTTEFullClamFire(_s);
            return;
        case wep_ntte_teleport_gun:
        case wep_ntte_golden_teleport_gun:
        case wep_ntte_super_teleport_gun:
            scrNTTEFullPortalWeaponFire(_w,_primary,_s)
            break
        case wep_ntte_quasar_blaster:
        case wep_ntte_quasar_rifle:
        case wep_ntte_ultra_quasar_rifle:
        case wep_ntte_quasar_cannon:
            scrNTTEFireBeam(_w,_primary,_s)
            break
        case wep_ntte_bone_scythe:
        case wep_ntte_bone_shotbow:
        case wep_ntte_bone_slugbow:
            _p=scrNTTEFullScytheFire(_w,_primary,_s);
            break;
        case wep_ntte_trident:
        case wep_ntte_golden_trident:
            if (_charge >= 1) {
                if (!scrNTTESpend(_s,1,false)) break
                _p = scrNTTEShot(NTTEKind.Trident,_d,_w == wep_ntte_golden_trident ? 23.4:18)
                _p.sprite_index = scr_weapon_get_sprite(_w)
                _p.state = _s
                _p.state_epoch = _s.epoch
                _p.refund = 0
                _p.throw_curse = curse
                _p.cursed = curse>0
                _p.weapon = _w
            }
            else {
                for(var _i=-1;_i<=1;++_i) {
                    _p = scrNTTESlash(NTTESwingKind.Normal,20,sprShank,undefined,0.8)
                    _p.direction += _i*10
                    _p.image_angle = _p.direction
                    _p.shank = true
                }
            }
            snd_play(sndAssassinAttack,1.3)
            break
        case wep_ntte_annihilator:
        case wep_ntte_entangler:
        case wep_ntte_tunneller:
        case wep_ntte_golden_tunneller:
            var _cost = scrNTTERedCost(_w), _red = _charge >= 1 && ntte_red_ammo >= _cost
            if (_red && !infammo && !global.__debug_infammo) ntte_red_ammo -= _cost
            if (_w == wep_ntte_annihilator) {
                if (_red) scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullRedBullet,_d,16)
                else scrNTTESlash(NTTESwingKind.Normal,12,sprNTTERedSlash)
            }
            else if (_w == wep_ntte_entangler) {
                scrNTTESlash(_red ? NTTESwingKind.Clone:NTTESwingKind.Normal,_red ? 200:20,
                    _red ? sprNTTERedMegaSlash:sprNTTERedHeavySlash)
            }
            else if (_red) {
                _p = scrNTTEShot(NTTEKind.Tunnel,_d+orandom(4*accuracy),4,_w==wep_ntte_golden_tunneller)
            }
            else {
                // Three short thrusts, separated by four logical frames.
                _p = scrNTTEShot(NTTEKind.Shank,_d,3)
                _p.burst_left = 2
                _p.burst_delay = 4
                _p.burst_creator = id
                _p.burst_primary = _primary
            }
            snd_play(_red ? sndHyperCrystalSearch:sndWrench,0.9)
            break
        default:
            if (scrNTTEIsBone(_w)) {
                if (!scrNTTESpend(_s,1,false)) break
                _p = scrNTTEShot(NTTEKind.Bone,_d,16)
                _p.sprite_index = scr_weapon_get_sprite(_w)
                _p.state = _s
                _p.state_epoch = _s.epoch
                _p.refund = 0
                _p.throw_curse = curse
                _p.weapon = _w
                _p.cursed = curse>0
                snd_play(sndBloodGamble,1.2)
            }
            else show_error("Unimplemented NTTE weapon " + string(_w),true)
    }
    if (instance_exists(_p)) {
        _p.primary = _primary
        if (instance_is(_p,NTTEAttack) && _p.burst_left>0) scrNTTEStartSalvo(_p)
    }
    if(scrNTTEIsScythe(_w)) return;
    if (_w==wep_ntte_harpoon_launcher) scr_weapon_post(_d,6,8,-20)
    else scr_weapon_post(_d,6,3,5)
}

function scrNTTEFirePlasma(_w,_s,_primary) {
    var _last = noone
    with (NTTEAttack) if (creator == other.id && kind == NTTEKind.Plasma && state == _s) {
        if (other.wep == wep_ntte_dematerializer && hyper) {
            life = 19
            _last = id
        }
        else _last = id
    }
    if (_w == wep_ntte_dematerializer && instance_exists(_last) && _last.hyper) return;
    var _num = _w == wep_ntte_electroplasma_shotgun ? 5:1,
        _side = (_s.combo mod 2) ? -1:1
    _s.combo += 1
    for(var _i=0;_i<_num;++_i) {
        var _d = gunangle + (_num==5 ? (_i-2)*(20+orandom(6))*accuracy:
            (_w == wep_ntte_electroplasma_rifle ? _side*(17+orandom(7))*accuracy:orandom(4*accuracy))),
            _p = scrNTTEShot(NTTEKind.Plasma,_d,_w==wep_ntte_electroplasma_cannon ? 6:4.4,_w==wep_ntte_electroplasma_cannon)
        _p.state = _s
        _p.tether = _last
        _p.primary = _primary
        if (_w==wep_ntte_electroplasma_rifle) {
            _p.burst_left = 2
            _p.burst_delay = 3
            _p.burst_creator = id
            _p.burst_primary = _primary
        }
        if (_w==wep_ntte_dematerializer) with (_p) {
            hyper = true
            tether = creator
            life = 19
            speed = 0
            move_contact_solid(direction,480)
        }
        _last = _p
        if (_p.burst_left>0) scrNTTEStartSalvo(_p)
    }
    snd_play(sndPlasmaRifle,0.9)
}
