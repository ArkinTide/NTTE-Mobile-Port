#define init
    global.sprBubblesHud 					= sprite_add("../sprites/Characters/Bubbles/sprBubblesHud.png", 				1, 9, 9);
    global.sprBubblesHudBack 				= sprite_add("../sprites/Characters/Bubbles/sprBubblesHudBack.png", 			1, 9, 9);
    global.sprBubblesHudSlice 				= sprite_add("../sprites/Characters/Bubbles/sprBubblesHudSlice.png", 			1, 9, 1);
    global.sprBubblesHudSliceEnd 			= sprite_add("../sprites/Characters/Bubbles/sprBubblesHudSliceEnd.png", 		6, 9, 1);
    global.sprBubblesHudSliceEnd2 			= sprite_add("../sprites/Characters/Bubbles/sprBubblesHudSliceEnd2.png", 		4, 9, 1);

/*
    global.sprAmalgamHud = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHud.png", 1, 0, 0);
    global.sprAmalgamBarSlice = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHudBarSlice.png", 1, 0, 0);
    global.sprAmalgamBarEnd = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHudBarEnd.png", 5, 0, 0);
    global.sprAmalgamHudLines = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHudLines.png", 1, 0, 0);
    global.sprAmalgamCorBarSlice = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHudCorBarSlice.png", 1, 0, 0);
    global.sprAmalgamCorBarEnd = sprite_add("../sprites/Characters/Amalgam/sprAmalgamHudCorBarEnd.png", 5, 0, 0);
*/    
#define player_hud(_player, _hudIndex, _hudSide)
	switch(_player.race){
		
		// BUBBLES HUD //
		case "bubbles":{    
	        
	        // Variables :
	        var _bubbleCharge		= _player.bubbles_bubbleCharge          
	        var _maxBubbleCharge	= _player.bubbles_maxBubbleCharge    
	        var _hudX				= player_is_active(1) ? (_hudSide ? -7 : 102): 102
	        var _hudY				= (_hudIndex >= 2 ? 11 : 11);
	        var _barX				= _hudX - 7;
	        var _barY				= _hudY - 7;
	        var _barMaxHeight		= 13;
	        var _barHeight			= 13;
	        var _barSize			= 13 - (_barMaxHeight * (_bubbleCharge / _maxBubbleCharge));
	        
	         // Hud Back:
	        draw_sprite(global.sprBubblesHudBack, 0, _hudX, _hudY);	        
	        draw_sprite_stretched(global.sprBubblesHudSlice, 0, _barX, _barY + _barSize, 13, 13 - _barSize);
	        
	        if(_barSize > 3){
	        	draw_sprite_part(global.sprBubblesHudSliceEnd, (current_frame * 0.4), 0, 0, 13, 3, _barX, _barY + _barSize - 3);
	        } else {
	        	draw_sprite_part(global.sprBubblesHudSliceEnd2, (current_frame * 0.4), 0, 0, 13, 3, _barX, _barY + _barSize - 3);	        	
	        }
	        
	        var _barEndWidth		= clamp(_barMaxHeight - _barSize, 0, _barHeight);
	        var _barEndX			= _barX + _barSize;
	
	        
	         // Hud Front:
	    	draw_sprite(global.sprBubblesHud, 0, _hudX, _hudY);
	       	        
	        break;
	    }
	}
	/*	
		// AMALGAM HUD //
	    case "amalgam": {    
	
	        // Variables :
	        var corrupted		  = _player.corrupted
	        var corruption_charge = _player.corruption_charge       
	        var corruption_max_charge = _player.corruption_max_charge  
	        var hudX = player_is_active(1)?(_hudSide ? 3 : 3): -14
	        var hudY = (_hudIndex >= 2 ? -7 : 48);
	        var barX = hudX + 2;
	        var barY = hudY + 2;
	        var barMaxSize = 45;
	        var barHeight = 7;
	        var barSize = barMaxSize*(corruption_charge/corruption_max_charge);
	        
	                
	        draw_sprite(global.sprAmalgamHud, 0, hudX, hudY);
	        
	        var barEndWidth = clamp(barMaxSize - barSize, 0, barHeight);
	        var barEndX = barX + barSize;
	
				// Hud when Not Corrupted:
			if corrupted = false {
			draw_sprite_stretched(global.sprAmalgamBarSlice, 0, barX, barY, barSize, barHeight);
			        
	        if round(barSize) >= 1 {
	            draw_sprite_part(global.sprAmalgamBarEnd, current_frame*0.4, 0, 0, barEndWidth, barHeight, barEndX, barY);
	        }
	        draw_sprite(global.sprAmalgamHudLines, 0, hudX, hudY);  
	        
			}
			
				// Hud when Corrupted:
			if corrupted = true {
			draw_sprite_stretched(global.sprAmalgamCorBarSlice, 0, barX, barY, barSize, barHeight);
			        
	        if round(barSize) >= 1 {
	            draw_sprite_part(global.sprAmalgamCorBarEnd, current_frame*0.4, 0, 0, barEndWidth, barHeight, barEndX, barY);
	        	}
			}
			
	        break
	    }
	}
    
    */
    
#define draw_gui
	 // Player HUD Management:
	if(instance_exists(Player) && !instance_exists(PopoScene) && !instance_exists(MenuGen)){
		if(instance_exists(TopCont) || instance_exists(GenCont) || instance_exists(LevCont)){
			var _hudFade  = 0,
			    _hudIndex = 0,
			    _lastSeed = random_get_seed();
			    
			 // Game Win Fade Out:
			if(array_length(instances_matching(TopCont, "fadeout", true))){
				with(TopCont){
					_hudFade = clamp(fade, 0, 1);
				}
			}
			if(_hudFade > 0){
				 // GMS1 Partial Fix:
				try if(!null){}
				catch(_error){
					_hudFade = min(_hudFade, round(_hudFade));
				}
				
				 // Dim Drawing:
				if(_hudFade > 0){
					draw_set_fog(true, c_black, 0, 16000 / _hudFade);
				}
			}
			
			 // Draw Player HUD:
			for(var _isOnline = 0; _isOnline <= 1; _isOnline++){
				for(var _index = 0; _index < maxp; _index++){
					if(
						player_is_active(_index)
						&& (_hudIndex < 2 || !instance_exists(LevCont))
						&& (player_is_local_nonsync(_index) ^^ _isOnline)
					){
						var _hudVisible = false;
						
						 // HUD Visibility:
						for(var i = 0; true; i++){
							var _local = player_find_local_nonsync(i);
							if(!player_is_active(_local)){
								break;
							}
							if(player_get_show_hud(_index, _local)){
								_hudVisible = true;
								break;
							}
						}
						
						 // Draw HUD:
						if(_hudVisible || _isOnline == 0){
							if(_hudVisible){
								var _player = player_find(_index);
								if(instance_exists(_player)){
									 // Rad Canister / Co-op Offsets:
									var _playerNum = 0;
									for(var i = 0; i < maxp; i++){
										_playerNum += player_is_active(i);
									}
									if(_playerNum <= 1){
										d3d_set_projection_ortho(
											view_xview_nonsync - 17,
											view_yview_nonsync,
											game_width,
											game_height,
											0
										);
									}
									else draw_set_projection(2, _index);
									
									 // Draw:
									player_hud(_player, _hudIndex, _hudIndex % 2);
									
									draw_reset_projection();
								}
							}
							_hudIndex++;
						}
					}
				}
			}
			if(_hudFade > 0){
				draw_set_fog(false, 0, 0, 0);
			}
			random_set_seed(_lastSeed);
		}
	}
	
#define draw_pause
	 // Paused Player HUD Management:
	var _local = player_find_local_nonsync();
	if(player_is_active(_local)){
		 // Store Main Player’s Variables:
		if(instance_exists(Player)){
			global.hud_pause_vars = undefined;
			with(player_find(_local)){
				global.hud_pause_vars = {};
				with(variable_instance_get_names(self)){
					lq_set(global.hud_pause_vars, self, variable_instance_get(other, self));
				}
			}
		}
		
		 // Draw Main Player’s HUD:
		if(!instance_exists(BackMainMenu)){
			var _ref  = script_ref_create(draw_pause),
			    _vars = mod_variable_get(_ref[0], _ref[1], "hud_pause_vars");
			    
			if(!is_undefined(_vars)){
				for(var i = 0; player_is_active(player_find_local_nonsync(i)); i++){
					if(player_get_show_hud(_local, player_find_local_nonsync(i))){
						var _playerNum = 0,
						    _lastSeed  = random_get_seed();
						    
						 // View + Rad Canister Offset:
						for(var i = 0; i < maxp; i++){
							_playerNum += player_is_active(i);
						}
						d3d_set_projection_ortho(
							((_playerNum <= 1) ? -17 : 0),
							0,
							game_width,
							game_height,
							0
						);
						
						 // Draw:
						player_hud(global.hud_pause_vars, 0, false);
						
						draw_reset_projection();
						random_set_seed(_lastSeed);
						break;
					}
				}
			}
		}
	}