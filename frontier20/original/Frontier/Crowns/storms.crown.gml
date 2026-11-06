#define init
	global.sprCrownStormsIdle = sprite_add("../sprites/crowns/sprCrownStormsIdle.png", 1, 8, 8);
	global.sprCrownStormsWalk = sprite_add("../sprites/crowns/sprCrownStormsWalk.png", 6, 8, 8);
	global.sprCrownStormsIcon = sprite_add("../sprites/crowns/sprCrownStormsIcon.png", 1, 12, 16);

#define crown_object

	spr_idle = global.sprCrownStormsIdle
	spr_walk = global.sprCrownStormsWalk;

	 // Sound:
	if(instance_is(other, CrownIcon)){
		sound_play_pitch(sndCrownProtection, 1.1);
		sound_play_pitchvol(sndExplosion, 1.2, 0.9)
		sound_play_pitchvol(sndExplosionS, 0.7, 0.9)
		sound_play_pitchvol(sndLightningPistolUpg, 0.7, 0.9)
		sound_play_pitchvol(sndLightningCannonUpg, 1, 0.9)
	}

#define crown_name      	return loc("Frontier:CrownStorms:0", "CROWN OF STORMS");
#define crown_text      	return loc("Frontier:CrownStorms:0", "@sMORE @(color:6983599)METEOROLOGICAL @sAND @(color:6983599)WEATHER EVENTS");
#define crown_tip       	return "UNPREDICTABLE FORECAST";
#define crown_button    	sprite_index = global.sprCrownStormsIcon;
#define crown_avail     	return (GameCont.loops <= 0);

#define step
	// The Crown's actual functionality is just handled by Frontier_Events, this is just for nice little particles
	with(Crown){
		if (random(25) < 1){
    		with instance_create(x, y, Breath){
        		direction    = random(360)
        		image_angle  = direction
        		image_xscale = random(1)
        		image_yscale = image_xscale
        		image_blend  = make_colour_rgb(50, 57, 62)
    		}
		}
		if (random(50) < 1){
    		with instance_create(x, y, LightningHit){
        		direction    = random(360)
        		image_angle  = direction
        		image_xscale = random(0.7)
        		image_yscale = image_xscale
    		}
		}	
	}