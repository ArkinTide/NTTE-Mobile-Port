#define init
	global.sprTrinket 					    = sprite_add_weapon("../Sprites/Trinkets/sprReservation.png",			10, 7);
	global.sprTrinketHud 					= sprite_add("../sprites/trinkets/sprReservation.png",					1, 10, 7);
	#macro trinketPower                     mod_script_call("mod", "Trinkets", "trinket_get", index, mod_current) + GameCont.tk_trinketPower[index];
	
	global.lastCounts						= [0, 0, 0, 0];

#define trinket_name    	return "RESERVATION";
#define trinket_text    	return "@wMORE @(color:4419071)MEAL CHESTS";
#define trinket_ttip    	return "ALL YOU CAN EAT";  
#define trinket_sprt    	return global.sprTrinket;
#define trinket_sprt_hud	return global.sprTrinketHud;
#define trinket_area    	return 6;
#define trinket_swap    	return sndSwapGold;               

#define trinket_step
	 // if trinket power changes, alter stat change:
	if(tk_trinketReservation != trinketPower){
		stats_lose();
		tk_trinketReservation = trinketPower;
		global.lastCounts[index]= tk_trinketReservation;
		stats_gain();
	}

#define trinket_take
	if("tk_trinketReservation" not in self){
		tk_trinketReservation	= 0;
		global.lastCounts[index]= tk_trinketReservation;
	}
	
#define trinket_lose
	 // Fully Lose Stats if last one:
	if(mod_script_call("mod", "Trinkets", "trinket_get", index, mod_current) = 1){
		stats_lose();
		tk_trinketReservation	= 0;
		global.lastCounts[index]= tk_trinketReservation;
	}
	
#define trinket_lose_death(_index)
	GameCont.fr_mealChestChance -= (global.lastCounts[_index]);
	global.lastCounts[_index] = 0;
	
#define stats_gain
	GameCont.fr_mealChestChance += (tk_trinketReservation);
	
#define stats_lose
	GameCont.fr_mealChestChance -= (tk_trinketReservation);
	
	
