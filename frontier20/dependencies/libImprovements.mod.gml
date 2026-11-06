#define init
	global.isLoaded = true;

#define step
if (instance_exists(LevCont)){
    
    // scrolling mutbuttons
    var button_count = instance_number(mutbutton) - array_length(instances_matching(mutbutton, "skill", 0));
    
    if (button_count){
        if ((button_count + 1) * sprite_get_width(sprSkillIcon) * 1.2 > game_width){
            var _animating = instances_matching_ge(mutbutton, "alarm0", 0);
            var animating_count = array_length(_animating);
            
            with(LevCont){
                if (!animating_count){
					var _canMoveRight = array_length(instances_matching_le(instances_matching_gt(mutbutton, "num", floor(maxselect / 2)-1.5), "num", floor(maxselect / 2)-0.5));
					var _canMoveLeft = array_length(instances_matching_gt(instances_matching_le(mutbutton, "num", floor(maxselect / 2)+1.5), "num", floor(maxselect / 2)+0.5));
					var _canMove = array_length(instances_matching(mutbutton, "num", select));
					with(mutbutton){
                        if (mouse_x < game_width/2 - sprite_get_width(sprSkillIcon)*3
						&& (_canMoveRight || !_canMoveLeft)){
                            num += 0.2 * current_time_scale;
							if(mouse_x < game_width/2 - sprite_get_width(sprSkillIcon)*6){
								num += 0.2 * current_time_scale;
							}
							other.select = floor(other.maxselect / 2) + num-floor(num);
                        } else if (mouse_x > game_width/2 + sprite_get_width(sprSkillIcon)*3
						&& (_canMoveLeft || !_canMoveRight)){
							if(mouse_x > game_width/2 + sprite_get_width(sprSkillIcon)*6){
								num -= 0.2 * current_time_scale;
							}
                            num -= 0.2 * current_time_scale;
							other.select = floor(other.maxselect / 2) + num-floor(num);
                        } else if(other.select > floor(other.maxselect / 2) + 2 && _canMove){
							num--;
						} else if(other.select < floor(other.maxselect / 2) - 2 && _canMove){
							num++;
						} else{
							if(abs(round(num) - num) < 0.1){
								num = round(num);
							}else if(round(num) < num){
								num -= 0.1 * current_time_scale;
							}else if(round(num) > num){
								num += 0.1 * current_time_scale;
							}
						}
					}
					if(!(mouse_x < game_width/2 - sprite_get_width(sprSkillIcon)*3 || mouse_x > game_width/2 + sprite_get_width(sprSkillIcon)*3)){
						if(select > floor(maxselect / 2) + 2){
							select = floor(maxselect / 2) + 2;
						}else if(select < floor(maxselect / 2) - 2){
							select = floor(maxselect / 2) - 2;
						}
					}
                }
            }
        }
        
        // crown train sets num to decimal...
        else{
            LevCont.maxselect = button_count - 1;
            var _max = button_count;
            
            with(mutbutton){
				if(("skill" in self && skill == 0) || ("crown" in self && crown == 0)){
					_max++;
				}
                num = --_max;
            }
        }
    }
}