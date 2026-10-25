if lockstep_stop
	exit

if fainted {
	draw_self()
	exit
}

var _ntte_beetle_drawing=scrNTTEFullBeetleMenuVisible();
var _angle = image_angle + angle

wave += (0.4) * timescale

if wave > 6.2 {
	wave -= 6.2
}

if race == Race.Eyes {
	var _img = current_frame * 0.4
	
	if KeyCont.hold_spec[index] {
		var _sprite = scr_skill_get(mut_throne_butt) ? sprMindPowerTB : sprMindPower
		draw_sprite_ext(_sprite, _img % 3, x, y, right, 1, _angle, c_white, 1)
	}
	else if scr_ultra_get(Race.Eyes, UltraSkill.MonsterStyle) {
		draw_sprite_ext(sprEyesB, _img % 6, x, y, right, 1, _angle, 0xccfbc7, 1)
	}
}

if scr_weapon_get_type(wep) == 0 {
	wepright = wepflip
}
else wepright = right

if scr_weapon_get_type(bwep) == 0 {
	bwepright = bwepflip
}
else bwepright = right

var _backwep_angle = 90

if !_ntte_beetle_drawing && max_extra_weps > 0 && array_length(extra_weps) {
	var _count = array_length(extra_weps)
	
	_backwep_angle -= 5 * right
	
	for(var i = 0; i < _count; ++i) {
		draw_sprite_ext(scrNTTEFullSkinPlayerSprite(scr_weapon_get_sprite(extra_weps[i])), 0, x - right * (2 + i), y + swapanim,
			1, bwepright, _backwep_angle, merge_color(c_silver, c_black, i / _count), 1)
		
		_backwep_angle += (15 + i) * right
	}
}

if !_ntte_beetle_drawing && bwep != 0 && race != Race.Steroids {
	draw_sprite_ext(scrNTTEHeldSprite(bwep,true), 0, x - right * 2, y + swapanim,
		1, bwepright, _backwep_angle + 15 * right, c_silver, 1)
}

var _is_shielding = false

if race == Race.Crystal && !fainted && instance_exists(CrystalShield) {
	with CrystalShield {
		if creator == other.id && sprite_index != spr_disappear {
			_is_shielding = true; break
		}
	}
}

if !_ntte_beetle_drawing && scr_weapon_get_type(wep) == Ammo.Bolts && is_me && !_is_shielding && wep != wep_disc_gun {
    lasx = x
    lasy = y
    lasd = 0

    do {
        lasd += timescale
		
		lasx += lengthdir_x(2, gunangle)
        lasy += lengthdir_y(2, gunangle)
    }
	until position_meeting(lasx, lasy, Wall) or lasd > 1000

    draw_sprite_ext(sprLaserSightPlayer, -1, x, y, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
}

//DUAL WIELDING
if race == Race.Steroids && bwep != 0 && is_me {
    if scr_weapon_get_type(bwep) == Ammo.Bolts && bwep != wep_disc_gun {
        lasx = x
        lasy = y - 4
        lasd = 0

        do {
            lasd++lasx += lengthdir_x(2, gunangle)
            lasy += lengthdir_y(2, gunangle)
        } until position_meeting(lasx, lasy, Wall) or lasd > 1000

        draw_sprite_ext(sprLaserSightPlayer, -1, x, y - 4, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
    }

    draw_sprite_ext(scrNTTEHeldSprite(bwep,true), 0, x + lengthdir_x(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), y - 4 + lengthdir_y(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), 1, -bwepright, gunangle + (bwepangle * (1 - wkick / 20)), c_white, 1)
}

//DRAW DA GUNZ

var _shining_finger = trigger_fingers_shine

if !_ntte_beetle_drawing && back && !_is_shielding && wep {
	draw_sprite_ext(scrNTTEHeldSprite(wep), max(0, _shining_finger),
		x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
		y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))) - swapanim,
	1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)
}

if instance_exists(CoopController) && UberCont.opt_outlines {
	var pinst = scr_playerinstance_find(index)
	
	if pinst {
		gpu_set_fog(true, pinst.color, 0, 0)
		
	    draw_sprite_ext(sprite_index, image_index, x - 1, y, right, 1, _angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x + 1, y, right, 1, _angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y - 1, right, 1, _angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y + 1, right, 1, _angle, c_white, 1)
		
	    gpu_set_fog(0, 0, 0, 0)
	}
}

draw_sprite_ext(sprite_index, -1, x, y, right, 1, _angle, c_white, 1)

if !_ntte_beetle_drawing && !back && !_is_shielding && wep {
	draw_sprite_ext(scrNTTEHeldSprite(wep), max(0, trigger_fingers_shine),
		x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
		y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
	1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)
}

wkick = approach(wkick, 0, timescale)

if race == Race.Steroids {
    bwkick = approach(bwkick, 0, timescale)
}

if instance_exists(GameCont) && GameCont.underwater && race != 1 && race != 8 {
    draw_sprite(sprPlayerBubble, -1, x, y)
}

if infammo {
    draw_sprite(sprGunWarrant, infammo * 0.4, x, y)
}

scrNTTEDrawStatus()
scrNTTEFullBonusSpiritDraw()

// BEGIN NTTE CUZ CONNECTED TEST Player.Draw
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Player.Draw",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Player.Draw