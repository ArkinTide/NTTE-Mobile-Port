/*	                
	This is the Boss package of Lib, for
	functions to help with boss creation
*/

/*
	Scripts:
		#define draw_text_bn(_x, _y, _string, _angle)
		#define boss_hp(_hp)
		#define boss_intro_setup(_name, _mainspr, _backspr, _namespr)
		#define boss_intro(_name, _introSound, _music)
		#define boss_dead
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("draw_text_bn");
	addScript("boss_hp");
	addScript("boss_intro_setup");
	addScript("boss_intro");
	addScript("boss_dead");
	
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
#define draw_text_bn(_x, _y, _string, _angle)
	/*
		Draw big portrait name text
		Portrait names use an angle of 1.5
		
		Ex:
			draw_set_font(fntBigName)
			draw_text_bn(x, y, "FISH", 1.5);
	*/
	
	_string = string_upper(_string);
	
	var _col = draw_get_color();
	draw_set_color(c_black);
	draw_text_transformed(_x + 1, _y,     _string, 1, 1, _angle);
	draw_text_transformed(_x,     _y + 2, _string, 1, 1, _angle);
	draw_text_transformed(_x + 1, _y + 2, _string, 1, 1, _angle);
	draw_set_color(_col);
	draw_text_transformed(_x,     _y,     _string, 1, 1, _angle);
	
#define boss_hp(_hp)
	var _players = 0;
	for(var i = 0; i < maxp; i++){
		_players += player_is_active(i);
	}
	return round(_hp * (1 + (1/3 * GameCont.loops)) * (1 + (0.5 * (_players - 1))));
	
#define boss_intro_setup(_name, _mainspr, _backspr, _namespr)
	/*
		Sets up a boss intro
		//You can pass a string in for _namespr
		//UNTESTED, LMK IF THERE ARE ISSUES
	*/
var main = surface_create(492,240);
surface_set_target(main);
draw_clear_alpha(c_white, 0);
draw_sprite(_mainspr, 0, 0, 0);
surface_reset_target();
surface_save(main, _name+"_main.png");
surface_destroy(main);

var back = surface_create(492,240);
surface_set_target(back);
draw_clear_alpha(c_white, 0);
draw_sprite(_backspr, 0, 0, 0);
surface_reset_target();
surface_save(back, _name+"_main.png");
surface_destroy(back);

var name = surface_create(181,75);
surface_set_target(name);
draw_clear_alpha(c_white, 0);
if(is_string(_namespr)){
	draw_text_bn(0, 20, string_upper(_namespr), 1.5);
}else{
	draw_sprite(_namespr, 0, 0, 0);
}
surface_reset_target();
surface_save(name, _name+"_main.png");
surface_destroy(name);

	
#define boss_intro(_name, _introSound, _music)
	/*
		Plays a given boss's intro and their music.
		//You can pass null in for _introSound and _music
	*/
	
	 // Music:
	with(MusCont){
		alarm_set(2, 1);
		alarm_set(3, -1);
	}
	
	 // Bind begin_step to fix TopCont.darkness flash
	if(_name != ""){
		with(script_bind_begin_step(boss_intro_step, 0)){
			boss    = _name;
			loops   = 0;
			intro   = true;
			sprites = [
				[_name+"_main.png", sprBossIntro,          0],
				[_name+"_back.png", sprBossIntroBackLayer, 0],
				[_name+"_name.png", sprBossName,           0]
			];
			
			music = _music;
			
			 // Preload Sprites:
			with(sprites){
				if(!file_loaded(self[0])){
					file_load(self[0]);
				}
			}
			
			return self;
		}
	}
	
	if(_introSound != null){
		sound_play(_introSound);
	}
	
	return noone;

#define boss_intro_step
	if(intro){
		intro = false;
		
		 // Preload Sprites:
		with(sprites){
			if(!file_loaded(self[0])){
				other.intro = true;
				break;
			}
		}
		
		 // Boss Intro Time:
		if(!intro && UberCont.opt_bossintros == true && GameCont.loops <= loops){
			 // Replace Big Bandit's Intro:
			with(sprites){
				if(file_exists(self[0])){
					sprite_replace_image(self[1], self[0], self[2]);
				}
			}
			
			 // Call Big Bandit's Intro:
			var	_lastSub   = GameCont.subarea,
				_lastLoop  = GameCont.loops,
				_lastIntro = UberCont.opt_bossintros;
				
			GameCont.loops          = 0;
			UberCont.opt_bossintros = true;
			
			with(instance_create(0, 0, BanditBoss)){
				with(self){
					event_perform(ev_alarm, 6);
				}
				sound_stop(sndBigBanditIntro);
				instance_delete(self);
			}
			
			with(MusCont){
				alarm_set(3, -1);
			}
			
			GameCont.subarea        = _lastSub;
			GameCont.loops          = _lastLoop;
			UberCont.opt_bossintros = _lastIntro;
		}
		if(music != null){
			sound_play_music(music);
		}
	}
	
	 // End:
	else{
		with(sprites){
			sprite_restore(self[1]);
		}
		instance_destroy();
	}

#define boss_dead
	//Call this when your boss dies to set the music... I might add more later, but for now it's just a nice thing to have
	with(MusCont) alarm_set(1, 1);