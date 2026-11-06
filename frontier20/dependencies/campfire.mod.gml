#define init
global.created = false;
global.loaded = false;
global.level_loading = false;
global.chars = mod_get_names("race");

with instances_matching(CampChar,"campfire_char",true) instance_delete(self);
with instances_matching(CustomObject,"name","campfire_prop") instance_delete(self);

#macro anim_end (image_index + image_speed >= image_number || image_index + image_speed < 0)

#define level_start
//Loop Campfire corpses lmao
if (GameCont.area == 0 && array_length(global.chars))
{
	for (var aa = 0; aa < array_length(global.chars); aa++)
	{
		var _self = global.chars[aa];
	
		var _can = (!mod_script_exists("race", _self, "race_avail") || mod_script_call_nc("race", _self, "race_avail")) && (mod_script_exists("race", _self, "race_cf") && mod_script_call_nc("race", _self, "race_cf") != false);
		if (_can && !array_length(instances_matching(Player,"race",_self)) && (mod_script_exists("race", _self, "race_cf_corpse") && mod_script_call_nc("race", _self, "race_cf_corpse") != false))
		{
			with (instance_create(0, 0, CustomObject))
			{
				bskin = 0;
				wep = 1;
				maxhealth = 10;
				reload = 1;
				breload = 1;
				typ_ammo = [0,0,0,0,0,0];
				typ_amax = [0,0,0,0,0,0];
				mod_script_call_self("race", _self, "create");
				
				var _positioner = instance_create(x,y,CustomObject),
					_xpos = 0,
					_ypos = 0;
				
				with (_positioner)
				{
					mask_index = mskPlayerMenu;
					var _continue = true,
						_loops = 999;
					
					while(_continue && _loops > 0) 
					{
						// Move Somewhere
						x = xstart;
						y = ystart;
						move_contact_solid(random(360), random_range(8, 64) + random(random(64)));
						x = round(x);
						y = round(y);
						
						// Safe
						if (distance_to_object(instance_nearest(x, y, Corpse)) >= 16 && distance_to_object(instance_nearest(x, y, CampfireOff)) >= 16 &&  distance_to_object(instance_nearest(x, y, CampfireOff)) <= 160 && distance_to_object(instance_nearest(x, y, Wall)) >= 16 && !place_meeting(x, y, NightCactus) && place_meeting(x, y, Floor)) 
						{
							_continue = false;
							_xpos = x;
							_ypos = y;
							break;
						}
						else _loops --;
					}
				}
				
				with instance_create(_xpos, _ypos, Corpse) 
				{
					image_xscale = choose(-1,1);
					sprite_index = other.spr_dead
					campfire_corpse = true;
					image_speed = 0;
					image_index = image_number;
				}
				
				instance_delete(_positioner);
				instance_destroy();
			}
		}
	}
}
else with instances_matching(Corpse, "campfire_corpse", true)
{
	instance_destroy();	
}

#define step
if(instance_exists(GenCont) || instance_exists(Menu))
{
	global.level_loading = true;
}
else if(global.level_loading)
{
	global.level_loading = false;
	level_start();
}

if (instance_exists(Menu))
{
	if (!global.created)
	{
		global.created = true;
		
		for (var aa = 0; aa < array_length(global.chars); aa++)
		{
			var _self = global.chars[aa];
			
			if ((!mod_script_exists("race", _self, "race_avail") || mod_script_call_nc("race", _self, "race_avail")) && (mod_script_exists("race", _self, "race_cf") && mod_script_call_nc("race", _self, "race_cf")) && !array_length(instances_matching(CampChar, "race", _self)))
			{
				// Positioner
				var _xpos = 0, _ypos = 0;
				if (mod_script_exists("race", _self, "race_cf_positioner"))
				{
					var _pos = mod_script_call_nc("race", _self, "race_cf_positioner");
					_xpos = _pos.x;
					_ypos = _pos.y;
				}
				else
				{
					var _positioner = instance_create(Campfire.x, Campfire.y, CustomObject),
						_loops = 999;
						
					with (_positioner) 
					{
						mask_index = mskPlayerMenu;
						while(_loops > 0)
						{
							// Move Somewhere
							x = xstart;
							y = ystart;
							move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
							x = round(x);
							y = round(y);
							// Safe
							if(distance_to_object(instance_nearest(x, y, CampChar)) >= 16 && distance_to_object(instance_nearest(x, y, Campfire)) >= 24 && distance_to_object(instance_nearest(x, y, Campfire)) <= 240 && distance_to_object(instance_nearest(x, y, TV)) >= 32 && distance_to_object(instance_nearest(x, y, Campfire)) >= 12)
							{
								_xpos = x;
								_ypos = y;
								break;
							}
							else _loops --;
						}
					}
				}
				
				with campchar_create(_self, _xpos, _ypos)
				{
					//Couple
					if (mod_script_exists("race", _self, "race_cf_couple") && mod_exists("race",mod_script_call_nc("race", _self, "race_cf_couple")) && !array_length(instances_matching(CampChar,"race",mod_script_call_nc("race", _self, "race_cf_couple"))))
					{
						couple = mod_script_call_nc("race", _self, "race_cf_couple");
						var _c = couple;
						
						with campchar_create(_c,xpos,ypos)
						{
							//Couple
							couple = mod_script_call_nc("race",_c, "race_cf_couple");
							couple_char = other;
							other.couple_char = self;
							
							campchar_sprites(_c);
						}
					}
					
					campchar_sprites(_self);
					
					//Prop
					var _depth = depth;
					if (mod_script_exists("race", _self, "race_cf_prop")) with instance_create(x,y,CustomObject)
					{
						name = "cfire_prop"
						sprite_index = mod_script_call_nc("race", _self, "race_cf_prop");
						depth = _depth - sign(mod_script_call_nc("race", _self, "race_cf_proptyp")) * 2;
						mask_index = mskNone;
					}
				}
				
				instance_delete(_positioner);
		    }
		}
	}
}
else global.created = false;
	
global.loaded = true;

script_bind_step(campchar_select,0);

#define campchar_select
with CampChar if ("campfire_char" in self)
{
	var _selected = false;
	
	//Check if Character is selected
	for(var i = 0; i < maxp; i++) if player_is_active(i)
	{
		if (player_get_race(i) == race) with (instance_create(0, 0, Revive))
		{
			var _selected = true;
			
			//Checks if you're playing on Local Multiplayer
			var _local = false;
			for(var j = 0; j < maxp; j++)
			{
				if(j != i && player_get_uid(j) == player_get_uid(i))
				{
					_local = true;
					break;
				}
			}
			
			//Only pans camera if you're NOT on Local
			var shake = UberCont.opt_shake;
			if (!_local)
			{
				//view_object[i] = id;
				//view_pan_factor[i] = 10;
				UberCont.opt_shake = 1.15;
				instance_change(Player,false);
				p = i;
				gunangle = point_direction(64,64,other.x,other.y);
				weapon_post(0,point_distance(64,64,other.x,other.y)/10*current_time_scale,0);
			}
			
			instance_delete(self);
			UberCont.opt_shake = shake;
		} 
	}
	
	couple_selected = _selected;
	
	//Animation
	if (couple == noone) 
	{
		if (anim_end)
		{
			if (_selected)
			{
				if (sprite_index != spr_slcted)
				{
					if (sprite_index == spr_slcting)
					{
						sprite_index = spr_slcted;
					}
					else sprite_index = spr_slcting;
				}
			}
			else
			{
				if (sprite_index != spr_noslct)
				{
					if (sprite_index == spr_deslcting)
					{
						sprite_index = spr_noslct;
					}
					else sprite_index = spr_deslcting;
				}
			}
			
			image_index = 0;
		}
	}
	else
	{
	//Couple Animation (God bless Gepsi fr fr)
		if (anim_end)
		{
			if(_selected)
			{
				if(sprite_index == spr_couple_slcted)
				{
					sprite_index = spr_couple_unswap;
				}
				else if (sprite_index != spr_slcted)
				{
					if (sprite_index == spr_slcting) {
						sprite_index = spr_slcted;
					}
					else if (sprite_index == spr_couple_unswap)
					{
						sprite_index = spr_slcted;
					}
					else sprite_index = spr_slcting;
				}
			}else
			{
				if (couple_char.couple_selected)
				{
					if (sprite_index == spr_noslct || sprite_index == spr_couple_slcting)
					{
						if (sprite_index == spr_couple_slcting)
						{
							sprite_index = spr_couple_slcted;
						}
						else sprite_index = spr_couple_slcting;
					}
					else if (sprite_index != spr_couple_slcted)
					{
						if (sprite_index == spr_couple_swap)
						{
							sprite_index = spr_couple_slcted;
						}
						else sprite_index = spr_couple_swap;
					}
				}
				else if (sprite_index != spr_noslct)
				{
					if (sprite_index == spr_deslcting)
					{
						sprite_index = spr_noslct;
					} 
					else sprite_index = spr_deslcting;
				}
			}
			
			image_index = 0;
		}
		else
		{
			image_index = couple_char.image_index;
		}
	}
}

instance_destroy();

#define campchar_create(_char,_x,_y)
with instance_create(_x,_y,CampChar)
{
	spr_shadow_x = mod_script_call_nc("race", _char, "race_cf_shadowx");
	spr_shadow_y = mod_script_call_nc("race", _char, "race_cf_shadowy");
	sprite_index = mskNone;
	
	//Important
	campfire_char = true;
	num = 0.1;
	race = _char;
	mask_index = mskPlayerMenu;
	image_speed = 0.4;
	if (mod_script_exists("race",_char,"race_cf_depth")) depth = mod_script_call_nc("race",_char,"race_cf_depth");
	
	//Couple
	couple = noone;
	couple_char = noone;
	couple_selected = false;
	
	//Spawn Particles
	if (mod_script_exists("race",_char,"race_cf_spawnparticles") && !global.loaded) mod_script_call_self("race",_char,"race_cf_spawnparticles");
	//Character Set
	character_set_id = (mod_script_exists("race",_char,"race_cf_characterset"))  ? mod_script_call_nc("race",_char,"race_cf_characterset") : undefined;
	
	return id;
}

#define campchar_sprites(_char)
with (instances_matching(CampChar, "race", _char))
{
	//Couple Animations
	if (mod_script_exists("race", _char, "race_cf_couple") && mod_exists("race",mod_script_call_nc("race", _char, "race_cf_couple")))
	{
		spr_slcted = mod_script_call_nc("race", _char, "race_cf_couple_sprselectedn"); //SELF IS SELECTED
		spr_noslct = mod_script_call_nc("race", _char, "race_cf_couple_sprnotselectedn"); //SELF IS NOT SELECTED
		spr_slcting = mod_script_call_nc("race", _char, "race_cf_couple_sprselectingn"); //SELF IS BEING SELECTED
		spr_deslcting = mod_script_call_nc("race", _char, "race_cf_couple_sprdeselectingn"); //SELF IS BEING DESELECTED
		
		spr_couple_slcted = mod_script_call_nc("race", _char, "race_cf_couple_sprselected"); //PARTNER IS SELECTED
		spr_couple_slcting = mod_script_call_nc("race", _char, "race_cf_couple_sprselecting"); //PARTNER IS BEING SELECTED
		spr_couple_deslcting = mod_script_call_nc("race", _char, "race_cf_couple_sprdeselecting"); //PARTNER IS BEING DESELECTED
		spr_couple_swap = mod_script_call_nc("race", _char, "race_cf_couple_sprswapping"); //SELF IS BEING NOT SELECTED, PARTNER IS
		spr_couple_unswap = mod_script_call_nc("race", _char, "race_cf_couple_sprdeswapping"); //PARTNER IS BEING NOT SELECTED, SELF IS
		
		partner_xoffset = mod_script_call_nc("race", _char, "race_cf_couple_xoffset");
		partner_yoffset = mod_script_call_nc("race", _char, "race_cf_couple_yoffset");
	}
	else
	{
		spr_slcted = mod_script_call_nc("race", _char, "race_cf_sprselected"); //SELF IS SELECTED
		spr_noslct = mod_script_call_nc("race", _char, "race_cf_sprnotselected"); //SELF IS NOT SELECTED
		spr_slcting = mod_script_call_nc("race", _char, "race_cf_sprselecting"); //SELF IS BEING SELECTED
		spr_deslcting = mod_script_call_nc("race", _char, "race_cf_sprdeselecting"); //SELF IS BEING DESELECTED
	}
	
	if("partner_xoffset" in self) x += partner_xoffset;
	if("partner_yoffset" in self) y += partner_yoffset;
		
	sprite_index = spr_noslct;
}