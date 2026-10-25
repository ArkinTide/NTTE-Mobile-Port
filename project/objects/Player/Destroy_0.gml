// BEGIN NTTE CUZ AUDIO TEST REAL OWNER DESTROY BEFORE
var _ntte_cuz_audio_death_owner=id;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicDeathBefore(_ntte_cuz_audio_death_owner); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST REAL OWNER DESTROY BEFORE
// BEGIN NTTE CUZ CONNECTED TEST OWNER DESTROY BEFORE
var _ntte_cuz_death_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { _ntte_cuz_death_sample=scrNTTEFullCuzConnectedDeathBefore(id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST OWNER DESTROY BEFORE
snd_stop(sndFishTB)

if race == Race.Melting && KeyCont.activeforever[index] {
    instance_create(x, y, MeltGhost)
}

KeyCont.activeforever[index] = 0

if scrCrownCheck(crwn_death) {
    snd_play_hit_big(sndExplosionXL, 0.2)

    repeat 10 {
        instance_create(x + orandom(1), y + orandom(1), Explosion)
        instance_create(x + orandom(1), y + orandom(1), Explosion)
    }
}

snd_play(snd_dead)

if (wep > 0) with (scrWeaponPickupCreate(x, y, wep)) {
	motion_add(other.direction, (other.hp * -0.2) * timescale)
	curse = other.curse
}

if (bwep > 0) with (scrWeaponPickupCreate(x, y, bwep)) {
	motion_add(other.direction, (other.hp * -0.2) * timescale)
	curse = other.bcurse
}

if (instance_number(Player) > 1) exit

audio_stop_sound(sndFrogLoop)
audio_stop_sound(sndFrogLoopButt)

if race == Race.Frog {
    var ang = random_angle

    repeat 14 {
        with instance_create(x, y, EnemyBullet1) {
            motion_add(ang, (4) * timescale)
            image_angle = direction
            team = other.team
            dmg = 2

            sprite_index = sprScorpionBullet
        }

        ang += 360 / 14
    }
}
else if race == Race.Cuz {
	var _ultra = scr_ultra_get(Race.Cuz, UltraSkill.Emotional)
	
	var _angle = 0,
		_count = 20 * (1 + _ultra),
		_step = 360 / _count
	
	repeat _count {
		scr_projectile_create(x, y, CuzTear, _angle, 6)
		_angle += _step
	}
}

snd_stop(sndEyesLoop)
snd_stop(sndEyesLoopUpg)
snd_stop(sndChickenLoop)
snd_stop(sndChickenHeadlessLoop)

if race != Race.BigDog {
    with instance_create(x, y, CorpseActive) {
        size = 1

        mask_index = other.mask_index
        motion_add(other.direction, other.speed)

        speed += (max(0, -other.hp / 5)) * timescale

        sprite_index = other.spr_dead
        image_xscale = other.right

        if speed > (16) * timescale speed = (16) * timescale
    }
} else {
    instance_create(x, y, BigDogExplo)
}

with MusCont {
    snd_stop(song)
    snd_play_loop(amb)
}

with CrownObject {
    persistent = false
}

if scr_player_is_local(index) {
	var _race = race
	
	UberCont.ctot_dead[_race] += 1
	
	scrPlayerUpdateBestRunStats(_race, true)
	
	if (!(UberCont.want_menu || UberCont.want_restart)) {
		scrUnlocksArea()
	}
	
	scrRaceUnlock(Race.Melting)
	
	if (!GameCont.win) scrSendDailyData()
}

if race == Race.Horror {
	scrRadDrop(x, y, GameCont.rad)
	GameCont.rad = 0
}

if GameCont.underwater && race != Race.Fish && race != Race.Robot {
    with (instance_create(x, y, Wind)) sprite_index = sprPlayerBubblePop
}

with (instance_find(UnlockScreen, 0)) alarm[0] = 45
// BEGIN NTTE CUZ CONNECTED TEST OWNER DESTROY AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedDeathAfter(_ntte_cuz_death_sample); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST OWNER DESTROY AFTER
// BEGIN NTTE CUZ AUDIO TEST REAL OWNER DESTROY AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicDeathAfter(_ntte_cuz_audio_death_owner); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST REAL OWNER DESTROY AFTER