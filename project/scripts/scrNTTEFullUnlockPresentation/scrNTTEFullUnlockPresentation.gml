// teassets.unlock_set3433..3551 / telib.unlock_splat1627..1649.
// Presentation does not award or infer ownership.
function scrNTTEFullUnlockCornerText(_x,_y,_text) {
    // The host rich-text renderer advances fa_bottom downward. Adapt this
    // source bottom anchor locally; plain native text retains its own path.
    var _normalized=string_hash_to_newline(scrNTTEFullDisplay(string(_text)));
    if(string_pos("@",_normalized)==0 && string_pos("\n",_normalized)==0) {
        scrNTTEFullDrawText(_x,_y,_text);return;
    }
    var _va=draw_get_valign();
    try {
        draw_set_valign(fa_top);
        scrNTTEFullDrawText(_x,_y-render_parse_text(_normalized).height,_normalized);
    } finally {draw_set_valign(_va);}
}
function scrNTTEFullUnlockPressed(_slot) {
    if(_slot!=0) return false;
    return (is_mobile && mouse_ui_clicked()) || key_check("fire",keystate_press) || input_gamepad_check_pressed(0,gp_face1)
        || keyboard_check_pressed(vk_enter);
}
function scrNTTEFullUnlockPendingPortrait() {
    if(instance_exists(Player) || scrGameIsPaused() || instance_exists(PauseButton)
        || instance_exists(Menu)) return false;
    var _pending=false;
    with(NTTEFullUnlockCont) {
        for(var _i=unlock_index;_i<array_length(unlock);++_i)
            if(unlock[_i].spr!=-1) { _pending=true;break; }
    }
    return _pending;
}
function scrNTTEFullUnlockSplat(_name,_text,_sprite,_sound) {
    if(!instance_exists(NTTEFullUnlockCont)) instance_create(0,0,NTTEFullUnlockCont);
    var _unlock={nam:[_name,_name],txt:_text,spr:_sprite,img:0,snd:_sound};
    with(NTTEFullUnlockCont) {
        if(splash_index>=array_length(unlock)-1 && splash_timer<=0) splash_delay=40;
        array_push(unlock,_unlock);
    }
    return _unlock;
}
function scrNTTEFullUnlockMetadata(_key,_value) {
    var _p=string_split(_key,":"),_n=array_length(_p),_name="",_text="",_sprite=-1,_sound=-1,_kind="";
    if(_n<2) return undefined;
    var _unlocked=(!is_real(_value) && !is_bool(_value)) || _value;
    _kind=_p[0];
    switch(_kind) {
        case "pack":
            var _packs=["coast","oasis","trench","lair","red","crown"];
            var _names=["BEACH GUNS","BUBBLE GUNS","TECH GUNS","SAWBLADE GUNS",
                "@3("+string(scrNTTERefSprite("RedText"))+":-0.8) GUNS","CROWNS"];
            var _texts=["GRAB YOUR FRIENDS","SOAP AND WATER","TERRORS FROM THE DEEP",
                "DEVICES OF TORTURE","SPACE BENDS AND BREAKS",""];
            var _i=array_get_index(_packs,_p[1]);
            _name=_i>=0 ? _names[_i]:_p[1];_text=_i>=0 ? _texts[_i]:"";
            break;
        case "race":
            var _race=scrNTTEFullRaceNumeric(_p[1]);
            if(_race<0) return undefined;
            _name=scrNTTEFullRaceText(_race,"name");_text=scrNTTEFullRaceText(_race,"unlock");
            if(_unlocked) {
                _sprite=scrNTTEFullRaceSprite(_race,"Portrait",0);
                _sound=scrNTTEFullRaceSound(_race,"Cnfm");
            }
            break;
        case "skin":
            if(_n>2) {
                var _race=scrNTTEFullRaceNumeric(_p[1]),_skin=real(_p[2]);
                if(_race<0) return undefined;
                var _skin_name=string_upper(scrNTTEFullRaceSkinAvailable(_race,_skin)
                    ? chr(65+_skin)+" SKIN":scrNTTEFullRaceSkinText(_race,_skin,false));
                _name=string_copy(_skin_name,max(1,string_length(_skin_name)-4),5)==" SKIN"
                    ? scrNTTEFullRaceText(_race,"name")+" "+_skin_name
                    : _skin_name+" "+scrNTTEFullRaceText(_race,"name");
                _text=scrNTTEFullRaceSkinText(_race,_skin,true);
                if(_unlocked) {
                    _sprite=scrNTTEFullRaceSprite(_race,"Portrait",_skin);
                    _sound=scrNTTEFullRaceSound(_race,"Cnfm");
                }
            }
            else {
                var _race=scrRaceGetNumericID(scrNTTEFullSkinRace(_p[1]));
                if(is_undefined(_race)) return undefined;
                var _skin_name=string_upper(scrNTTEFullSkinName(_p[1]));
                if(_skin_name=="") return undefined;
                _name=string_copy(_skin_name,max(1,string_length(_skin_name)-4),5)==" SKIN"
                    ? scrRaceGetName(_race)+" "+_skin_name:_skin_name+" "+scrRaceGetName(_race);
                _text=scrNTTEFullSkinUnlockText(_p[1]);
                if(_unlocked) {
                    _sprite=scrNTTEFullSkinSprite(_p[1],sprBigPortrait);
                    _sound=scr_race_get_sound(_race,"Cnfm");
                }
            }
            break;
        case "wep":
            switch(_p[1]) {
                case "trident":_name=scr_weapon_get_name(wep_ntte_trident);
                    _text=scr_weapon_get_text(wep_ntte_trident);break;
                case "scythe":_name=scr_weapon_get_name(wep_ntte_bone_scythe);
                    _text="A PACKAGE DEAL";break;
            }
            break;
        case "crown":
            switch(_p[1]) {
                case "crime":_name="CROWN OF CRIME";_text="STOLEN FROM THIEVES";break;
                case "red":_name="RED CROWN";
                    _text="EXPLORE THE @(color:"+string(make_color_rgb(235,0,67))+")OTHER SIDE";break;
                case "bonus":_name="CROWN OF BONUS";break;
            }
            // Original fallback asks weapon-provider crown_tip and is not a
            // valid crown-module query. Do not add an invented random tip.
            break;
        case "loadout":
            if(_p[1]=="crown" && _n>2) {
                switch(_p[2]) {
                    case "crime":_name="CROWN OF CRIME@s";break;
                    case "red":_name="RED CROWN@s";break;
                    case "bonus":_name="CROWN OF BONUS@s";break;
                }
                _text="FOR @w"+(_n>3 ? scrRaceGetName(scrRaceGetNumericID(_p[3])):"EVERYONE");
            }
            else if(_p[1]=="wep") {
                // Native port stores the original physical LWO as an encoded
                // graph at loadout:wep:<race>:main. Unpack for pure metadata.
                if(!is_struct(_value) || scrNTTEFullValue(_value,"version",0)!=1) return undefined;
                _name=scr_weapon_get_name(scrNTTEFullLoadoutWeaponUnpack(_value));_text="STORED!";
            }
            break;
    }
    if(_name=="") return undefined;
    if(!sprite_exists(_sprite)) _sprite=-1;
    if(!audio_exists(_sound)) _sound=-1;
    return {nam:_name,txt:_unlocked?_text:"LOCKED",spr:_sprite,snd:_sound,kind:_kind,unlocked:_unlocked};
}
function scrNTTEFullUnlockNotify(_key,_value) {
    var _data=scrNTTEFullUnlockMetadata(_key,_value);
    if(is_undefined(_data)) return undefined;
    switch(_data.kind) {
        case "pack":snd_play(_data.unlocked?sndGoldUnlock:sndCursedChest);break;
        case "race":snd_play(_data.unlocked?sndGoldUnlock:sndCursedChest,0.9,0.9);break;
        case "skin":snd_play(_data.unlocked?sndMenuBSkin:sndMenuASkin);break;
        case "loadout":
            var _p=string_split(_key,":");
            if(_p[1]=="wep") snd_play(_data.unlocked?sndGoldUnlock:sndCursedChest);
            break;
    }
    var _unlock=scrNTTEFullUnlockSplat(_data.nam,_data.txt,_data.spr,_data.snd);
    // Source tests _split[1]=="skin", not _split[0]; no valid supported key
    // enters its undefined _unlockSplat branch. Preserve the active result.
    if((is_real(_value) || is_bool(_value)) && _value) _unlock.nam[0]+=" UNLOCKED";
    return _unlock;
}

function scrNTTEFullUnlockCreate() {
 // Visual:
depth = UberCont.depth - 1;

 // Vars:
persistent            = true;
unlock                = [];
unlock_sprit          = sprNTTEFullUnlockMutationSplat;
unlock_image          = 0;
unlock_delay          = 50;
unlock_index          = 0;
unlock_porty          = 0;
unlock_delay_continue = 0;
splash_sprit          = sprNTTEFullUnlockUnlockPopupSplat;
splash_image          = 0;
splash_delay          = 0;
splash_index          = -1;
splash_texty          = 0;
splash_timer          = 0;
splash_timer_max      = 150;

}

function scrNTTEFullUnlockEndStep() {
if(instance_exists(Menu)){
	instance_destroy();
	exit;
}

depth = UberCont.depth - 1;

 // Animate Corner Popup:
if(splash_delay > 0) splash_delay -= timescale;
else{
	var _img = 0;
	if(instance_exists(Player) || scrGameIsPaused() || instance_exists(PauseButton)){
		if(splash_timer > 0){
			splash_timer -= timescale;

			_img = sprite_get_number(splash_sprit) - 1;

			 // Text Offset:
			if(splash_image >= _img && splash_texty > 0){
				splash_texty -= timescale;
			}
		}
		else{
			splash_texty = 2;

			 // Splash Next Unlock:
			if(splash_index < array_length(unlock) - 1){
				splash_index++;
				splash_timer = splash_timer_max;
			}
		}
	}
	splash_image += clamp(_img - splash_image, -1, 1) * timescale;
}

 // Game Over Splash:
if(instance_exists(UnlockScreen)) unlock_delay = 1;
else if(!instance_exists(Player) && !scrGameIsPaused() && !instance_exists(PauseButton)){
	while(
		unlock_index >= 0                   &&
		unlock_index < array_length(unlock) &&
		unlock[unlock_index].spr == -1
	){
		unlock_index++; // No Game Over Splash
	}

	if(unlock_index < array_length(unlock)){
		 // Disable Game Over Screen:

		 // Delay Unlocks:
		if(unlock_delay > 0){
			unlock_delay -= timescale;
			var _delayOver = (unlock_delay <= 0);

			unlock_delay_continue = 20;
			unlock_porty = 0;

			 // Screen Dim + Letterbox:
			with(TopCont){
				visible = _delayOver;
				if(darkness){
				   visible = true;
				   darkness = 2;
				}
			}
			scrLetterbox(_delayOver);

			 // Sound:
			if(_delayOver){
				snd_play(sndCharUnlock);
				snd_play(unlock[unlock_index].snd);
			}
		}
		else{
			 // Animate Unlock Splash:
			var _img = sprite_get_number(unlock_sprit) - 1;
			unlock_image += clamp(_img - unlock_image, -1, 1) * timescale;

			 // Portrait Offset:
			if(unlock_porty < 3){
				unlock_porty += timescale;
			}

			 // Next Unlock:
			if(unlock_delay_continue > 0) unlock_delay_continue -= timescale;
			else for(var i = 0; i < player_count; i++){
				if(scrNTTEFullUnlockPressed(i)){
					if(unlock_index < array_length(unlock)){
						unlock_index++;
						unlock_delay = 1;
					}
					break;
				}
			}
		}
	}

	 // Done:
	else{
		with(TopCont) visible=true;
		instance_destroy();
	}
}
}

function scrNTTEFullUnlockDraw() {
var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_col=draw_get_color(),_alpha=draw_get_alpha();
try {
// Epsilon native UnlockScreen's death dim; source TopCont fields are not present.
if(!instance_exists(Player) && unlock_delay<=0 && unlock_index<array_length(unlock)) {
    draw_set_color(c_black);draw_set_alpha(0.6);
    draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+view_height,false);
    draw_set_alpha(1);draw_set_color(c_white);
}
var	_vx = view_xview,
	_vy = view_yview,
	_gw = view_width,
	_gh = view_height;

 // Game Over Splash:
if(unlock_delay <= 0){
	if(unlock_image > 0){
		var	_unlock = unlock[unlock_index],
			_nam    = _unlock.nam[1],
			_spr    = _unlock.spr,
			_img    = _unlock.img,
			_x      = _gw / 2,
			_y      = _gh - 20;

		 // Unlock Portrait:
		var	_px = _vx + _x - 60,
			_py = _vy + _y + 9 + unlock_porty;

		draw_sprite(_spr, _img, _px, _py);

		 // Splash:
		draw_sprite(unlock_sprit, unlock_image, _vx + _x, _vy + _y);

		 // Unlock Name:
		var	_tx = _vx + _x,
			_ty = _vy + _y - 92 + (unlock_porty < 2);

		draw_set_font(global.language_font_bigname_default);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);

		var _t = string_upper(scrNTTEFullDisplay(_nam));
		scrNTTEFullDrawBigName(_tx,_ty,_t,c_white,1,1);

		 // Unlocked!
		_ty += font_get_string_height(_t) + 3;
		if(unlock_porty >= 3){
if(scrNTTEFullIsSimplifiedChinese()) {
    scrNTTEFullDrawBigName(_tx,_ty,"已解锁",c_white,1,0.5);
} else {
			draw_sprite_ext(sprNTTEFullUnlockTextUnlocked,4,_tx + 1,_ty,1,1,0,c_black,1);
			draw_sprite_ext(sprNTTEFullUnlockTextUnlocked,4,_tx,_ty + 1,1,1,0,c_black,1);
			draw_sprite_ext(sprNTTEFullUnlockTextUnlocked,4,_tx + 1,_ty + 1,1,1,0,c_black,1);
			
			draw_sprite(sprNTTEFullUnlockTextUnlocked, 4, _tx,     _ty);
}
		}

		 // Continue Button:
		if(unlock_delay_continue <= 0){
			var	_cx    = _x,
				_cy    = _y - 4,
				_blend = make_color_rgb(102, 102, 102);

			for(var i = 0; i < player_count; i++){
				if(point_in_rectangle(device_mouse_x(i)-view_xview, device_mouse_y(i)-view_yview, _cx - 64, _cy - 12, _cx + 64, _cy + 16)){
					_blend = c_white;
					break;
				}
			}

			if(scrNTTEFullIsSimplifiedChinese()) {
    draw_set_valign(fa_middle);scrNTTEFullDrawBigName(_vx+_cx,_vy+_cy,"继续",_blend,1,0.5);
} else draw_sprite_ext(sprNTTEFullUnlockUnlockContinue, 0, _vx + _cx, _vy + _cy, 1, 1, 0, _blend, 1);
		}
	}
}

 // Corner Popup:
if(splash_image > 0){
	 // Splash:
	var	_x = _vx + _gw,
		_y = _vy + _gh;

	draw_sprite(splash_sprit, splash_image, _x, _y);

	 // Unlock Text:
	if(splash_texty < 2){
		var	_unlock = unlock[splash_index],
			_nam    = scrNTTEFullDisplay(_unlock.nam[0]),
			_txt    = scrNTTEFullDisplay(_unlock.txt),
			_tx     = _x - 4,
			_ty     = _y - 16 + splash_texty;

		draw_set_font(global.language_font_default);
		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);

		 // Title:
		if(_nam != ""){
			scrNTTEFullUnlockCornerText(_tx,_ty,_nam);
		}

		 // Description:
		if(splash_texty <= 0){
			_ty += font_get_string_height(_nam + " ");
			scrNTTEFullUnlockCornerText(_tx,_ty,"@s"+_txt);
		}
	}
}
} finally {draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_col);draw_set_alpha(_alpha);}
}

// BEGIN NTTE NATIVE ACHIEVEMENTS
// Fixed IDs are append-only. Original host achievement IDs 0..58 never move.
function scrNTTEFullAchievementKeys() {
    return ["pack:coast","pack:oasis","pack:trench","pack:lair","pack:red","pack:crown",
        "race:parrot","race:beetle","skin:parrot:1","skin:beetle:1","skin:angler fish",
        "skin:bat eyes","skin:bonus robot","skin:coat venuz","skin:cool frog","skin:orchid plant",
        "skin:red crystal","wep:trident","wep:scythe","crown:crime","crown:red",
        "loadout:crown:bonus","loadout:crown:crime","loadout:crown:red"]
}
function scrNTTEFullAchievementMetadataInit() {
    var _names=["BEACH GUNS","BUBBLE GUNS","TECH GUNS","SAWBLADE GUNS","RED GUNS","CROWNS",
        "PARROT","BEETLE","PARROT B SKIN","BEETLE B SKIN","ABYSSAL FISH","BAT EYES","BONUS ROBOT",
        "COAT Y.V.","COOL FROG","GILDED PLANT","RED CRYSTAL","TRIDENT","BONE SCYTHE",
        "CROWN OF CRIME","RED CROWN","CROWN OF BONUS STORED","CROWN OF CRIME STORED","RED CROWN STORED"],
        _texts=["GRAB YOUR FRIENDS","SOAP AND WATER","TERRORS FROM THE DEEP","DEVICES OF TORTURE",
        "SPACE BENDS AND BREAKS","DISCOVER AN NTTE CROWN","REACH COAST","OPEN THE CHEST",
        "COMPLETE THE AQUATIC ROUTE","HOLD 6 WEAPONS IN ONE HAND","DEFEAT A GOLDEN ANGLER",
        "REACH MAX CRIME BOUNTY","PLAY 8 HOURS OF NT:TE","BUY A COAT","REACH COMBO x100",
        "REROLL ???","REACH THE OTHER SIDE","SCEPTER OF THE SEA","A PACKAGE DEAL","STOLEN FROM THIEVES",
        "EXPLORE THE OTHER SIDE","FOR EVERYONE","FOR EVERYONE","FOR EVERYONE"]
    for(var _i=0;_i<array_length(_names);++_i)
        scrAchievementCreate(59+_i,false,0,"NTTE: "+_names[_i],_texts[_i])
}
function scrNTTEFullAchievementLegacyInit(_reconcile=false) {
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _earned_ready=is_struct(scrNTTEFullValue(global.ntte_full_progress,"achievement_earned",undefined))
    var _legacy_ready=is_struct(scrNTTEFullValue(global.ntte_full_progress,"achievement_legacy",undefined)),
        _custom_ready=is_struct(scrNTTEFullValue(global.ntte_full_progress,"achievement_custom",undefined)),
        _version=scrNTTEFullValue(global.ntte_full_progress,"achievement_sync_version",0)
    if(!is_real(_version)) _version=0
    if(!_reconcile && _earned_ready && _legacy_ready && _custom_ready && _version>=2) return;
    var _keys=scrNTTEFullAchievementKeys(),_dirty=false
    // Native public/debug saves can retain only options. Remember actual
    // earned NTTE achievements in their own already-persistent progress file.
    if(!_earned_ready) {
        global.ntte_full_progress.achievement_earned={};_dirty=true;
    }
    if(!_legacy_ready) {global.ntte_full_progress.achievement_legacy={};_dirty=true;}
    if(!_custom_ready) {global.ntte_full_progress.achievement_custom={};_dirty=true;}
    // Original NTTE stores the completed unlock itself, not an independent
    // achievement. Recover those exact permanent keys even when an older
    // build already latched an empty legacy directory. Historical files have
    // no source-mode marker; their permanent flags retain their original
    // ownership meaning. Runtime availability, a held weapon, discovered
    // modules and custom loadout access are never evidence of an achievement.
    // Later custom events keep their own exclusion marker before saving the
    // same source content flag, so menu/startup reconciliation cannot award it.
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_native=save_get_value("achievement",string(59+_i),false),
            _value=scrNTTEFullUnlockGet(_key,false)
        if((is_real(_native) || is_bool(_native)) && _native==true
            && !scrNTTEFullValue(global.ntte_full_progress.achievement_earned,_key,false)) {
            global.ntte_full_progress.achievement_earned[$ _key]=true;_dirty=true;
        }
        if((is_real(_value) || is_bool(_value)) && _value==true
            && !scrNTTEFullValue(global.ntte_full_progress.achievement_custom,_key,false)
            && !scrNTTEFullValue(global.ntte_full_progress.achievement_legacy,_key,false)
            && !scrNTTEFullValue(global.ntte_full_progress.achievement_earned,_key,false)) {
            global.ntte_full_progress.achievement_legacy[$ _key]=true;_dirty=true;
        }
    }
    if(_version<2) {global.ntte_full_progress.achievement_sync_version=2;_dirty=true;}
    if(_dirty) scrNTTEFullProgressSave()
}
function scrNTTEFullAchievementLegacyGet(_id) {
    var _i=_id-59
    if(_i<0 || !variable_global_exists("ntte_full_progress")) return false;
    var _keys=scrNTTEFullAchievementKeys()
    if(_i>=array_length(_keys)) return false;
    return scrNTTEFullValue(scrNTTEFullValue(global.ntte_full_progress,"achievement_legacy",{}),_keys[_i],false)
        || scrNTTEFullValue(scrNTTEFullValue(global.ntte_full_progress,"achievement_earned",{}),_keys[_i],false)
}
function scrNTTEFullAchievementRemember(_id) {
    var _i=_id-59
    if(_i<0) return false;
    var _keys=scrNTTEFullAchievementKeys()
    if(_i>=array_length(_keys)) return false;
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    if(!is_struct(scrNTTEFullValue(global.ntte_full_progress,"achievement_earned",undefined)))
        global.ntte_full_progress.achievement_earned={}
    if(scrNTTEFullValue(global.ntte_full_progress.achievement_earned,_keys[_i],false)) return false;
    global.ntte_full_progress.achievement_earned[$ _keys[_i]]=true
    return true
}
function scrNTTEFullAchievementAward(_key,_value) {
    if(!(is_real(_value) || is_bool(_value)) || _value!=true) return false;
    var _index=array_get_index(scrNTTEFullAchievementKeys(),_key)
    if(_index<0) return false;
    scrNTTEFullAchievementLegacyInit()
    if(scrAchievementIsUnlocked(59+_index)) return false;
    if(scrGameIsCustomMode()) {
        // UnlockSet persists this marker together with the source flag, even
        // when the content was already true and its notification is deduped.
        if(scrNTTEFullValue(global.ntte_full_progress.achievement_custom,_key,false)) return false;
        global.ntte_full_progress.achievement_custom[$ _key]=true
        return true;
    }
    scrAchievementUnlock(59+_index)
    return false;
}

// BEGIN NTTE SIMPLIFIED CHINESE DISPLAY
// Gameplay identities, merge grammar and persistent keys remain in English.
function scrNTTEFullIsSimplifiedChinese() {
    return variable_global_exists("language_current") && is_struct(global.language_current)
        && scrNTTEFullValue(global.language_current,"Init:Id","")=="Simplified Chinese"
}
function scrNTTEFullLocalizeInstall() {
    if(!variable_global_exists("ntte_zh_dictionary")) scrNTTEFullLocalizeDictionary()
    global.ntte_zh_keys=variable_struct_get_names(global.ntte_zh_dictionary)
    global.ntte_zh_cache={}
    if(!variable_global_exists("language_store") || !is_struct(global.language_store)) return;
    var _cn=scrNTTEFullValue(global.language_store,"Simplified Chinese",undefined)
    if(!is_struct(_cn)) return;
    _cn[$ "CharacterPrefOptions:ParrotToggle"]="鹦鹉技能切换"
    _cn[$ "NTTE:Pet:Info:Weapon.petlib.mod:0:Name"]="武器箱怪"
    _cn[$ "NTTE:Pet:Info:Weapon.petlib.mod:1:Name"]="武器箱怪"
    _cn[$ "NTTE:Pet:Info:Scorpion.petlib.mod:0:Name"]="银蝎子宝宝"
    _cn[$ "NTTE:Pet:Info:CoolGuy.petlib.mod:0:Name"]="酷蛙"
    // Reuse existing Chinese names for ordinary components of merged weapons.
    if(variable_global_exists("wep_name") && is_array(wep_name)) {
        for(var _id=1;_id<array_length(wep_name);++_id) {
            var _en=wep_name[_id],_zh=scrNTTEFullValue(_cn,"Weapons:"+string(_id)+":Name",undefined)
            if(is_string(_en) && is_string(_zh) && _en!=_zh && string_pos("@",_en)==0)
                global.ntte_zh_dictionary[$ string_upper(_en)]=_zh
        }
    }
    global.ntte_zh_keys=variable_struct_get_names(global.ntte_zh_dictionary)
    array_sort(global.ntte_zh_keys,function(_a,_b){return string_length(_b)-string_length(_a)})
    global.ntte_zh_cache={}
}
function scrNTTEFullLocalizeKey(_key,_text) {
    if(!scrNTTEFullIsSimplifiedChinese()) return _text;
    var _parts=string_split(string(_key),":"),_kind=_parts[0]
    if(_kind=="Weapons" && array_length(_parts)>2 && _parts[2]=="Name") return scrNTTEFullWeaponNameDisplay(_text);
    if(_kind=="NTTE" && string_pos(":Area",string(_key))>0 && string_upper(_text)=="RED") return "红晶洞窟";
    if(array_contains(["Weapons","Skills","Crowns","Races","NTTE","Achievements"],_kind))
        return scrNTTEFullDisplay(_text)
    return _text
}
function scrNTTEFullWeaponNameDisplay(_text) {
    if(!scrNTTEFullIsSimplifiedChinese() || !is_string(_text)) return _text;
    if(!variable_global_exists("ntte_zh_dictionary")) scrNTTEFullLocalizeInstall()
    var _upper=string_upper(_text),_direct=scrNTTEFullValue(global.ntte_zh_dictionary,_upper,undefined)
    if(_upper!="BAT" && !is_undefined(_direct)) return scrNTTEFullDisplay(_text);
    var _words=string_split(_text," ")
    for(var _i=0;_i<array_length(_words);++_i) if(string_upper(_words[_i])=="BAT") _words[_i]="棒球棍"
    return scrNTTEFullDisplay(string_join_ext(" ",_words))
}
function scrNTTEFullTextWordChar(_char) {
    return _char!="" && string_pos(string_upper(_char),"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'")>0
}
function scrNTTEFullTranslatePlain(_text) {
    var _upper=string_upper(_text),_out="",_pos=1,_length=string_length(_text)
    while(_pos<=_length) {
        var _match=false
        if(_pos==1 || !scrNTTEFullTextWordChar(string_char_at(_text,_pos-1))) {
            for(var _k=0;_k<array_length(global.ntte_zh_keys);++_k) {
                var _key=global.ntte_zh_keys[_k],_n=string_length(_key)
                if(string_pos("@",_key)>0 || string_pos("#",_key)>0 || _pos+_n-1>_length) continue;
                if(string_copy(_upper,_pos,_n)==_key && !scrNTTEFullTextWordChar(string_char_at(_text,_pos+_n))) {
                    _out+=global.ntte_zh_dictionary[$ _key];_pos+=_n;_match=true;break
                }
            }
        }
        if(!_match) _out+=string_char_at(_text,_pos++)
    }
    return _out
}
function scrNTTEFullDisplay(_text) {
    if(!is_string(_text) || !scrNTTEFullIsSimplifiedChinese()) return _text;
    // Timers/counters change every frame. Numeric-only strings need no phrase
    // scan or cache entry and must keep the native rendering cost small.
    var _has_latin=false
    for(var _scan=1;_scan<=string_length(_text);++_scan) {
        var _code=ord(string_char_at(_text,_scan))
        if((_code>=65 && _code<=90) || (_code>=97 && _code<=122)) {_has_latin=true;break;}
    }
    if(!_has_latin && string_pos("@",_text)==0) return _text;
    if(!variable_global_exists("ntte_zh_keys")) scrNTTEFullLocalizeInstall()
    var _cached=scrNTTEFullValue(global.ntte_zh_cache,_text,undefined)
    if(!is_undefined(_cached)) return _cached;
    var _direct=scrNTTEFullValue(global.ntte_zh_dictionary,string_upper(_text),undefined),_out=""
    if(!is_undefined(_direct)) _out=_direct
    else {
        // Copy rich-text control sequences byte-for-byte; translate only their
        // visible text runs. This is called by NTTE presentation consumers.
        var _pos=1,_start=1,_length=string_length(_text)
        while(_pos<=_length) {
            if(string_char_at(_text,_pos)!="@") {_pos++;continue;}
            _out+=scrNTTEFullTranslatePlain(string_copy(_text,_start,_pos-_start))
            var _tagstart=_pos++;if(_pos>_length) {_out+="@";_start=_pos;break;}
            if(string_pos(string_char_at(_text,_pos),"123456789")>0 && string_char_at(_text,_pos+1)=="(") _pos++
            if(string_char_at(_text,_pos)=="(") {
                var _depth=1;_pos++
                while(_pos<=_length && _depth>0) {
                    var _ch=string_char_at(_text,_pos++)
                    if(_ch=="(") _depth++;else if(_ch==")") _depth--
                }
            } else _pos++
            var _tag=string_copy(_text,_tagstart,_pos-_tagstart)
            _out+=scrNTTEFullLocalizeTag(_tag)
            _start=_pos
        }
        _out+=scrNTTEFullTranslatePlain(string_copy(_text,_start,_length-_start+1))
    }
    if(array_length(variable_struct_get_names(global.ntte_zh_cache))>=2048) global.ntte_zh_cache={}
    global.ntte_zh_cache[$ _text]=_out
    return _out
}
function scrNTTEFullLocalizeTag(_tag) {
    var _open=string_pos("(",_tag)
    if(_open<=0) return _tag;
    var _name=string_copy(_tag,_open+1,string_length(_tag)-_open-1),
        _colon=string_pos(":",_name),_comma=string_pos(",",_name)
    if(_colon>0) _name=string_copy(_name,1,_colon-1)
    if(_comma>0) _name=string_copy(_name,1,_comma-1)
    var _keys=["RedText","BonusText","BonusHUDText"]
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _sprite=scrNTTERefSprite(_keys[_i])
        if(_name==_keys[_i] || _name==string(_sprite)
            || (sprite_exists(_sprite) && _name==sprite_get_name(_sprite)))
            return _i==0?"红晶洞窟":"无限"
    }
    return _tag
}
function scrNTTEFullMenuTranslationEnabled() {
    return instance_exists(id) && variable_instance_exists(id,"category")
        && category!=OptionCategory.NTTE_Credits
        && category>=OptionCategory.NTTE && category<=OptionCategory.NTTE_PetDetails
}
function scrNTTEFullDrawMenuText(_x,_y,_text,_xs=1,_ys=_xs,_angle=0,_blend=draw_get_color(),_alpha=draw_get_alpha()) {
    draw_text_nt(_x,_y,scrNTTEFullMenuDisplay(_text),_xs,_ys,_angle,_blend,_alpha)
}
function scrNTTEFullDrawMenuBigName(_x,_y,_text,_color=draw_get_color(),_alpha=draw_get_alpha(),_scale=0.65,_angle=0) {
    draw_text_bigname(_x,_y,scrNTTEFullMenuDisplay(_text),_color,_alpha,_scale,_angle)
}
function scrNTTEFullMenuDisplay(_text) {
    if(!scrNTTEFullMenuTranslationEnabled() || !scrNTTEFullIsSimplifiedChinese()) return _text;
    if(category==OptionCategory.NTTE_Pets || category==OptionCategory.NTTE_PetDetails) {
        if(string_upper(_text)=="SCORPION") return "银蝎子宝宝";
        if(string_upper(_text)=="WEAPON") return "武器箱怪";
    }
    return scrNTTEFullDisplay(_text)
}
function scrNTTEFullDrawText(_x,_y,_text,_xs=1,_ys=_xs,_angle=0,_blend=draw_get_color(),_alpha=draw_get_alpha()) {
    draw_text_nt(_x,_y,scrNTTEFullDisplay(_text),_xs,_ys,_angle,_blend,_alpha)
}
function scrNTTEFullDrawBigName(_x,_y,_text,_color=draw_get_color(),_alpha=draw_get_alpha(),_scale=0.65,_angle=0) {
    draw_text_bigname(_x,_y,scrNTTEFullDisplay(_text),_color,_alpha,_scale,_angle)
}
function scrNTTEFullBossIntroChineseName() {
    if(!scrNTTEFullIsSimplifiedChinese()) return undefined;
    var _key=string_upper(UberCont.ntte_full_intro_key),_names={
        BIGFISH:"大鱼",CATBAT:"大人物组合",PALANKING:"海豹王",PETWEAPON:"武器箱怪",PETWEAPONCURSED:"诅咒武器箱怪",
        SEALKING:"海豹王",ANGLER:"灯笼鱼",GOLDENANGLER:"黄金灯笼鱼",PITSQUID:"幽灵蛸",
        BIGSHOTS:"大人物组合",BIGCAT:"大猫",BIGBAT:"大蝙蝠",CRYSTALHEART:"红晶之心",
        REDCRYSTALHEART:"红晶之心",CHAOSCRYSTALHEART:"混沌之心",TESSERACT:"超立方"}
    return scrNTTEFullValue(_names,_key,scrNTTEFullDisplay(UberCont.ntte_full_intro_key))
}
// Native object fallback names are presentation context, not general words:
// Last is the Captain, while ordinary English "last" has another meaning.
function scrNTTEFullNativeEnemyChineseName(_object_name) {
    var _names={BANDIT:"盗贼",MAGGOT:"蛆虫",BIGMAGGOT:"巨型蛆虫",RADMAGGOT:"辐射蛆虫",
        GOLDSCORPION:"黄金蝎子",RAVEN:"渡鸦",GATOR:"短吻鳄",MELEEBANDIT:"暗杀者",
        WEPMIMIC:"武器箱怪",INVSPIDER:"诅咒水晶蜘蛛"},_key=string_upper(_object_name),
        _name=scrNTTEFullValue(_names,_key,undefined)
    if(!is_undefined(_name)) return _name;
    var _bosses={BANDITBOSS:["BigBandit","大强盗"],SCRAPBOSS:["BigDog","巨犬"],
        FROGQUEEN:["BallMom","母亲"],HYPERCRYSTAL:["HyperCrystal","超级水晶"],
        LILHUNTER:["LilHunter","小猎人"],TECHNOMANCER:["TechnoMancer","科技术士"],
        LAST:["Captain","舰长"],NOTHING:["Throne1","王座"],NOTHING2:["Throne2","王座 Ⅱ"]},
        _boss=scrNTTEFullValue(_bosses,_key,undefined)
    return is_array(_boss)?loc("Bosses",_boss[0],_boss[1]):undefined
}
function scrNTTEFullEnemyDisplayName(_inst) {
    var _raw=scrNTTEFullEnemyName(_inst)
    if(!scrNTTEFullIsSimplifiedChinese()) return _raw;
    if(!is_array(scrNTTEFullValue(_inst,"hitid",undefined))) {
        var _name=scrNTTEFullNativeEnemyChineseName(object_get_name(_inst.object_index))
        if(!is_undefined(_name)) return _name;
    }
    return scrNTTEFullDisplay(_raw)
}
function scrNTTEFullAnnihilationEntryDisplay(_entry) {
    var _raw=string_upper(_entry.text)
    if(!scrNTTEFullIsSimplifiedChinese()) return _raw;
    if(_entry.text==scrNTTEFullPlural(string_lower(_entry.object_name))) {
        var _name=scrNTTEFullNativeEnemyChineseName(_entry.object_name)
        if(!is_undefined(_name)) return _name;
    }
    return scrNTTEFullDisplay(_raw)
}

function scrNTTEFullLocalizeDictionary() {
    var _rows=[["ANNIHILATION", "湮灭之相"], ["BAT EARS", "蝙蝠双耳"], ["COMPASSION", "同情"], ["LEAD RIBS", "铸铅肋骨"], ["MAGNETIC PULSE", "核磁脉冲"], ["FLOWER'S BLESSING", "兰花祝福"], ["SILVER TONGUE", "银舌"], ["TOAD BREATH", "蟾蜍呼吸"], ["REROLL", "重掷变异"], ["DESTROY", "消灭"], ["SEE BETTER IN THE @DDARK", "在@d黑暗@s中看得更清楚"], ["EXTRA @WPET @SSLOT", "额外一个@w宠物@s栏位"], ["MORE @GRADS @SFROM @WENEMIES", "@w敌人@s掉落更多@g辐射"], ["CHANCE @BI.D.P.D. @SDIE @WON ENTRY", "@bI.D.P.D.@s有概率在@w出现时@s死亡"], ["FIND @WSMUGGLED GOODS#@STHE FAMILY CONCEDES", "寻找@w走私物资#@s家族作出让步"], ["@GTOXIC GAS @SIS @WBREATHABLE", "可以@w呼吸@g毒气"], ["GOODBYE", "再见"], ["ECHOLOCATION IS UNDERRATED", "回声定位不可小觑"], ["NEW BEST FRIEND", "新的挚友"], ["HIGHER THRESHOLD", "更高的阈值"], ["SHORT CIRCUIT", "短路"], ["DIPLOMACY", "外交手段"], ["CORROSION", "腐蚀"], ["CROWN OF BONUS", "奖励王冠"], ["CROWN OF CRIME", "罪恶王冠"], ["RED CROWN", "红晶王冠"], ["@BBONUS AMMO PICKUPS#@SREPLACE @WAMMO @SAND @WHP DROPS", "@b无限弹药包#@s替代@w弹药@s和@w医疗@s掉落"], ["FIND @WSMUGGLED GOODS#@SA @RPRICE @SON YOUR HEAD", "寻找@w走私物资#@s你的头上有了@r悬赏"], ["CHAOTIC @RCRYSTAL HEARTS#@SSMALLER @WAREAS", "混沌的@r红晶之心#@s更小的@w区域"], ["ALL EXTRA", "额外奖励"], ["THE @WFAMILY@S DOESN'T FORGIVE", "@w家族@s不会宽恕"], ["THE @RBAT'S@S EXPERIMENTS", "@r蝙蝠@s的实验"], ["THE @RCAT'S@S RESOURCES", "@r猫@s的物资"], ["FULL OF LIFE", "生机勃勃"], ["SO CRAMPED", "真拥挤"], ["BEETLE", "甲虫"], ["PARROT", "鹦鹉"], ["BEETLE CHEST", "解密宝箱"], ["MERGE WEAPONS", "融合武器"], ["MANY FRIENDS", "朋友多多"], ["@RCHARM ENEMIES", "@r魅惑敌人"], ["OPEN THE CHEST", "打开宝箱"], ["REACH COAST", "到达海滩"], ["FOR OPENING THE CHEST", "打开宝箱后解锁"], ["FOR REACHING COAST", "到达海滩后解锁"], ["PARTS OF @WMERGED WEAPONS @SCAN BE REPLACED#BY WEAPONS OF THE SAME @YAMMO TYPE", "可用相同@y弹药类型@s的武器#替换@w融合武器@s的组件"], ["@WPICKUPS @SGIVE @RFEATHERS@S", "拾取@w掉落物@s可获得@r羽毛@s"], ["CRITICAL THORAX", "临界胸廓"], ["AUXILIARY MANDIBLES", "辅助下颚"], ["BIRDS OF A FEATHER", "敌以羽聚"], ["FLOCK TOGETHER", "鸟以群分"], ["THE @YBEETLE CHEST @SOPENS WITH A @WBLAST#@SAND @WAPPEARS @SWHEN NEEDED", "@y解密宝箱@s开启时发生@w爆炸#@s并在需要时@w出现"], ["@WMERGED WEAPON @SSTOCKS#ARE @RTRIGGER-HAPPY", "@w融合武器@s的枪托#会@r自动开火"], ["CAN CHARM MULTIPLE ENEMIES#@RFEATHERS @SLAST @WLONGER", "可以同时魅惑多个敌人#@r羽毛@s维持@w更久"], ["@WINCOMING DAMAGE @SIS SPLIT#WITH @RFEATHERED @SENEMIES", "受到的@w伤害@s由#被@r羽毛@s魅惑的敌人分担"], ["PARROT ABILITY TOGGLE", "鹦鹉技能切换"], ["PARROT B SKIN", "鹦鹉 B 皮肤"], ["BEETLE B SKIN", "甲虫 B 皮肤"], ["COMPLETE THE AQUATIC ROUTE", "完成整条水域路线"], ["HOLD 6 WEAPONS IN ONE HAND", "在一只手中融合六件武器"], ["ABYSSAL", "深渊"], ["ABYSSAL FISH", "深渊鱼"], ["BAT EYES", "蝙蝠眼睛"], ["BONUS ROBOT", "奖励机器人"], ["COAT Y.V.", "风衣 Y.V."], ["COOL FROG", "酷蛙"], ["GILDED PLANT", "镀金植物"], ["RED CRYSTAL", "红晶"], ["DEFEAT A GOLDEN ANGLER", "击败黄金灯笼鱼"], ["DEFEAT A @YGOLDEN ANGLER", "击败@y黄金灯笼鱼"], ["FOR DEFEATING A @YGOLDEN ANGLER", "击败@y黄金灯笼鱼@s后解锁"], ["REACH MAX CRIME BOUNTY", "达到最高犯罪赏金"], ["REACH MAX @RCRIME @WBOUNTY", "达到最高@r犯罪@w赏金"], ["FOR REACHING MAX @RCRIME @WBOUNTY", "达到最高@r犯罪@w赏金@s后解锁"], ["PLAY 8 HOURS OF NT:TE", "累计游玩 NT:TE 八小时"], ["FOR PLAYING 8 HOURS OF NT:TE", "累计游玩 NT:TE 八小时后解锁"], ["BUY A COAT", "购买一件风衣"], ["FOR BUYING A COAT", "购买风衣后解锁"], ["REACH COMBO X100", "达到 100 倍连击"], ["REROLL ???", "重掷 ???"], ["FOR REROLLING HEAVY HEART", "重掷沉重之心后解锁"], ["REACH THE OTHER SIDE", "到达另一侧"], ["FRESH FIT", "焕然一新的穿搭"], ["DROWNING IN STYLE", "时髦地沉入水中"], ["SHAPED BY THE DEPTHS", "由深渊塑造"], ["LOST YOUR MIND", "失去理智"], ["FROGGING AROUND", "蛙趣横生"], ["SAY MY NAME", "叫出我的名字"], ["WHAT THE COOL", "酷得离谱"], ["STYLISH", "时髦"], ["ROCKIN' THE SHADES", "墨镜真酷"], ["SHINY LIKE A LIMOUSINE", "像豪华轿车一样闪亮"], ["IS THAT DESIGNER", "这是名牌吗"], ["YOU LOOK SO GOOD", "你看起来真不错"], ["SO BRIGHT OUT", "外面真亮"], ["MISSED THE SUN", "想念阳光"], ["NEVER MORE ALIVE", "从未如此鲜活"], ["FOR A MOMENT", "片刻之间"], ["TOO COOL FOR SCHOOL", "酷到不想上学"], ["JUST A COOL FROG", "只是一只酷蛙"], ["WANNA SEE A FROG?", "想看看青蛙吗？"], ["PUMP YOUR VEINS WITH GUSHING GOLD", "让奔涌的黄金注入血管"], ["ALL THAT TWINKLES IS GOLD", "闪闪发光的都是金子"], ["STRAIGHT FROM THE SEWERS", "来自下水道"], ["TOO MUCH PIZZA", "披萨吃多了"], ["MAKE SURE YOU FLUSH", "记得冲水"], ["SLIME TIME", "黏液时间"], ["LIVE FOREVER", "永生"], ["YOU ARE TERMINATED", "你被终结了"], ["THE DANGER", "危险本身"], ["MILLION DOLLAR SMILE", "价值百万的微笑"], ["ENERGY BAT", "能量球拍"], ["TELEPORT GUN", "传送枪"], ["SUPER TELEPORT GUN", "超级传送枪"], ["GOLDEN TELEPORT GUN", "黄金传送枪"], ["ROGUE CARBINE", "叛警卡宾枪"], ["BEETLE PISTOL", "甲虫爆射手枪"], ["BEETLE BLASTER", "甲虫爆射手枪"], ["VENOM RIFLE", "毒液步枪"], ["VAMPIRE", "吸血鬼"], ["DEMATERIALIZER", "物质分解器"], ["BONE", "骨头"], ["BONE SCYTHE", "骨镰刀"], ["BONE SHOTBOW", "骨霰弹十字弩"], ["BONE SLUGBOW", "骨独头弹十字弩"], ["HARPOON LAUNCHER", "鱼叉发射器"], ["NET LAUNCHER", "网状发射器"], ["NET GUN", "网状发射器"], ["CLAM SHIELD", "蛤盾"], ["TRIDENT", "三叉戟"], ["GOLDEN TRIDENT", "黄金三叉戟"], ["BUBBLE RIFLE", "气泡步枪"], ["BUBBLE BAT", "气泡球拍"], ["BUBBLE SHOTGUN", "气泡霰弹枪"], ["BUBBLE MINIGUN", "气泡速射机枪"], ["BUBBLE CANNON", "气泡加农炮"], ["HYPER BUBBLER", "高阶气泡发射器"], ["TESLA COIL", "特斯拉线圈"], ["LIGHTNING RING LAUNCHER", "电环发射器"], ["SUPER LIGHTNING RING LAUNCHER", "超级电环发射器"], ["ELECTROPLASMA RIFLE", "等离子电球步枪"], ["ELECTROPLASMA SHOTGUN", "等离子电球霰弹枪"], ["ELECTROPLASMA CANNON", "等离子电球加农炮"], ["QUASAR BLASTER", "类行星爆射枪"], ["QUASAR RIFLE", "类行星步枪"], ["QUASAR CANNON", "类行星加农炮"], ["ULTRA QUASAR RIFLE", "终极类行星步枪"], ["SAWBLADE GUN", "锯片发射器"], ["BAT DISC LAUNCHER", "锯片发射器"], ["SAWBLADE CANNON", "锯片加农炮"], ["BAT DISC CANNON", "锯片加农炮"], ["PIZZA CUTTER", "披萨切割机"], ["TUNNELLER", "掘地者"], ["GOLDEN TUNNELLER", "黄金掘地者"], ["ANNIHILATOR", "湮灭者"], ["ENTANGLER", "纠缠者"], ["ANCIENT ARTIFACT", "古代组件"], ["GUARDED ARTIFACT", "守卫组件"], ["STOLEN ARTIFACT", "被窃组件"], ["MISSING ARTIFACT", "遗失组件"], ["EGGPLANT", "茄子"], ["LOST BUT NOT FORGOTTEN", "丢失但未被遗忘"], ["DON'T BLINK", "别眨眼"], ["POSITION INDETERMINABLE", "位置不确定"], ["LUXURY TRAVEL", "豪华旅行"], ["THERE'S NO TALKING TO THEM", "无需多言"], ["A PIERCING STING", "穿心刺痛"], ["BONE THE FISH", "给鱼骨头"], ["REASSEMBLED", "重新装配"], ["MARROW FROM A HUNDRED MUTANTS", "来自一百个变异体的骨髓"], ["RADIATION DETERIORATES BONES", "辐射使骨骼退化"], ["REEL IT IN", "收线"], ["CATCH OF THE DAY", "一天的渔获"], ["ROYAL GUARD", "皇家护卫"], ["SCEPTER OF THE SEA", "深海王权"], ["SHINE THROUGH THE SKY", "划破天际"], ["REFRESHING", "焕然一新"], ["SUMMERTIME FUN", "夏日欢愉"], ["SOAP EVERYWHERE", "到处都是肥皂"], ["KING OF THE BUBBLES", "气泡之王"], ["POWER WASHER", "动力清洗机"], ["LIMITED POWER", "能力有限"], ["JELLY TECHNOLOGY", "水母科技"], ["EYE OF THE STORM", "暴风眼"], ["DEEP SEA WEAPONRY", "深海武器"], ["WHERE'S THE PEANUT BUTTER", "形影分离"], ["BRAIN EXPANDING", "大脑扩张"], ["SO FLEXIBLE", "如此灵活"], ["BLINDING LIGHT", "耀眼之光"], ["PULSATING", "脉冲"], ["THE GREEN SUN", "绿日"], ["ROCKET POWERED RECOIL DAMPENING", "正在抑制推进器产生的后坐力"], ["LIKE DISCS BUT SMARTER", "像圆盘，但比它聪明"], ["LIKE DISCS BUT @YSMARTER", "像圆盘，但比它@y聪明"], ["FOR THE CIVILIZED TURTLE", "献给有教养的乌龟"], ["THEY STAND NO CHANCE", "他们没有机会"], ["FULL CIRCLE", "完整的圆"], ["KEY TO THE MULTIVERSE", "多元宇宙的钥匙"], ["YET ANOTHER RED KEY", "又一把红钥匙"], ["BEND THE CONTINUUM", "折叠连续体"], ["SPLIT THE CONTINUUM", "分裂连续体"], ["MAKING NEW FRIENDS", "结交新朋友"], ["GOLDEN GOD", "黄金之神"], ["SECRETS LIE WITHIN", "秘密就在其中"], ["UNCONVENTIONAL WEAPONRY", "非常规武器"], ["BRING IT BACK", "把它带回来"], ["HARDLY FOUND, EASILY LOST", "难拾易失"], ["A PACKAGE DEAL", "成套出售"], ["GUNS THAT SEW THREADSES", "缝合命运之枪"], ["EXTRA OFFENSE", "额外攻势"], ["TREAD LIGHTLY", "小心脚下"], ["RECYCLE", "回收利用"], ["PORTAL STRIKE", "传送打击"], ["FAMILY CAN WAIT", "家族可以等等"], ["INFINITE AMMO", "无限弹药"], ["SCORPION", "蝎子"], ["SALAMANDER", "蝾螈"], ["SPIDER", "水晶蜘蛛"], ["CURSED SPIDER", "诅咒水晶蜘蛛"], ["SLAUGHTER", "屠宰者"], ["OCTO", "八爪鱼"], ["MIMIC", "宝箱怪"], ["PRISM", "诅咒棱镜"], ["ORCHID", "螳螂"], ["TWINS", "双子棱镜"], ["TWIN", "单子棱镜"], ["WEAPON MIMIC", "武器箱怪"], ["WEAPON", "武器"], ["CUZ", "Y.C."], ["YUNG CUZ", "Y.C."], ["GUARDIAN", "I.D.P.D.能量守护者"], ["SPIT VENOM", "喷吐毒液"], ["ROCKSLIDE", "落石"], ["HIGH ON THE FOOD CHAIN", "食物链的高处"], ["BACKPACK BUDDY", "背包伙伴"], ["PARROTS RETRIEVE @WPICKUPS", "鹦鹉会取回@w掉落物"], ["HANDY", "得心应手"], ["THEY LIKE YOU", "它们喜欢你"], ["HAND OVER HAND", "交替前进"], ["BUBBLE BLOWIN'", "吹泡泡"], ["BABY", "小家伙"], ["JAWS", "大白鲨"], ["VICIOUS", "凶猛"], ["BRAIN WAVES", "脑电波"], ["TEAMWORK", "团队合作"], ["JUMP ROPE", "跳绳"], ["BRING FORTH THE MOLLUSK", "召唤软体动物"], ["STINK BEAN", "臭豆子"], ["JUST A COOL GUY", "只是个酷家伙"], ["BRO", "兄弟"], ["HIGH SCORE!", "高分！"], ["BACKWARD CAPS ARE COOL", "反戴帽子真酷"], ["VEHICULAR COMBAT", "载具战斗"], ["NITROUS", "氮气加速"], ["PUNT", "飞踢"], ["EXTERNAL STORAGE", "外部仓库"], ["GUN DEALER", "军火商"], ["WHAT YOU NEED", "你需要的东西"], ["BUY SOMETHING", "买点东西"], ["STUCK A BIT", "有点卡住了"], ["SITUATION STICKY", "棘手的处境"], ["A BIT STUCK", "有点黏住了"], ["STICKY SITUATION", "黏糊糊的处境"], ["GROSS", "真恶心"], ["COCOONED", "作茧"], ["STRANGE GEOMETRY", "奇异几何"], ["CURSED REFRACTION", "诅咒折射"], ["YEAH OH ", "好耶 "], ["LIGHT BEAMS", "光束"], ["SUBSPACE HIGHWAY THROUGH YOUR HEAD", "穿过脑海的亚空间公路"], ["WROUGHT FROM THE SOURCE", "源头铸就"], ["AN ELEGANT DANCE", "优雅之舞"], ["ELEGANT", "优雅"], ["FLORID", "绚丽"], ["GENETIC MAGIC", "基因魔法"], ["YOU WERE THE KING OF KARAT FLOWERS", "你曾是金色花朵之王"], ["MUTUAL RESPECT", "相互尊重"], ["RESPECT MUTUAL", "彼此尊重"], ["WALKING WEAPON", "行走的武器"], ["WEAPON WALKING", "武器在行走"], ["YUNG CUZ IS LAZY", "小表弟很懒"], ["CUZ IS STILL LEARNING", "表弟仍在学习"], ["BE A ROLE MODEL", "做个好榜样"], ["NO TIME FOR GAMES", "没空玩游戏"], ["MEMENTO", "纪念品"], ["BLACK BOX", "黑匣子"], ["DEFECTIVE", "故障品"], ["PRESS @1(SPRKEYSMALL:PICK) TO CHANGE MODES", "按@1(sprKeySmall:pick)切换模式"], ["THE @RSCYTHE @SCAN DO SO MUCH MORE", "@r骨镰刀@s还有更多用途"], ["PRESS @1(SPRKEYSMALL:PICK) TO REARRANGE A FEW @RBONES", "按@1(sprKeySmall:pick)重新排列@r骨头"], ["JUST PRESS @1(SPRKEYSMALL:PICK) ALREADY", "快按@1(sprKeySmall:pick)吧"], ["PLEASE PRESS @1(SPRKEYSMALL:PICK)", "请按@1(sprKeySmall:pick)"], ["DESERT", "沙漠"], ["SEWERS", "下水道"], ["PIZZA", "披萨下水道"], ["SCRAPYARD", "废弃停车场"], ["MANSION", "Y.V.大厦"], ["CAVES", "水晶洞窟"], ["CURSED CAVES", "诅咒洞窟"], ["CITY", "冰封都市"], ["JUNGLE", "丛林"], ["LABS", "实验室"], ["PALACE", "宫殿"], ["CAMPFIRE", "营地"], ["HEADQUARTERS", "I.D.P.D.总部"], ["VAULT", "王冠密室"], ["CRIB", "Y.V.老家"], ["COAST", "海滩"], ["OASIS", "绿洲"], ["TRENCH", "海沟"], ["LAIR", "巢穴"], ["RED", "红晶"], ["QUEST", "终极解密"], ["BANDIT CAMP", "盗贼营地"], ["SCORPION CITY", "蝎子巢"], ["MAGGOT PARK", "蛆堆"], ["BLOCKED ROOM", "封闭房间"], ["GATOR AMBUSH", "鳄鱼据点"], ["GATOR DEN", "鳄鱼金库"], ["RAVEN ARENA", "斗兽场"], ["FIRE PIT", "旋转十字喷火陷阱"], ["SEAL PLAZA", "海豹都市"], ["MUTANT VATS", "培养基地"], ["PALACE SHRINE", "辐射神龛"], ["BURIED VAULT", "王冠密室遗址"], ["EEL GRAVE", "电鳗之墓"], ["SOMETHING IN THE DISTANCE", "远处有什么东西"], ["SECRETS IN THE", "秘密藏在"], ["WALLS", "墙壁中"], ["ARCHAEOLOGY", "考古"], ["ANCIENT", "古老的"], ["STRUCTURES", "建筑"], ["BANDITS", "盗贼"], ["THE SOUND OF", "传来一阵"], ["FLIES", "苍蝇声"], ["THE AIR", "空气中"], ["STINGS", "带着刺痛"], ["WHERE ARE WE GOING", "我们正去往何处"], ["RADIOACTIVE SEWAGE", "放射性污水"], ["SMELLS", "闻起来"], ["WORSE THAN YOU THINK", "比想象中更糟"], ["ACID RAIN", "酸雨"], ["RUNOFF", "径流"], ["THE WASTELAND WEAPON TRADE", "废土军火交易"], ["THESE PIPES RUN", "这些管道"], ["EVERYWHERE", "无处不在"], ["DISTANT CHATTER", "远处的交谈声"], ["ENTER", "进入"], ["THE RING", "竞技场"], ["RAIN DROPS", "雨滴"], ["TURN TO", "化作"], ["STEAM", "蒸汽"], ["DISTANT RELATIVES", "远亲"], ["SPECIMENS", "实验标本"], ["RAD MANIPULATION", "操控辐射"], ["IS", "是"], ["KINDA TRICKY", "有点棘手"], ["FINAL PROVISIONS", "最后的补给"], ["WAITING FOR YOU", "正在等你"], ["AMBUSHED", "遭遇埋伏"], ["EELS", "电鳗"], ["NEVER", "永不"], ["FORGET", "遗忘"], ["BIG MAGGOTS NEST", "大型蛆虫窝"], ["BABY SCORPION", "蝎子宝宝"], ["GOLDEN BABY SCORPION", "黄金蝎子宝宝"], ["PATCH ALLIGATOR", "独眼短吻鳄"], ["CAMPER BANDIT", "营地盗贼"], ["HIKER BANDIT", "旅者盗贼"], ["SILVER SCORPION", "银蝎子"], ["BIG FISH", "大鱼"], ["CAT", "猫"], ["BABY ALLIGATOR", "短吻鳄宝宝"], ["BONE ALLIGATOR", "骷髅短吻鳄"], ["ALBINO ALLIGATOR", "白化短吻鳄"], ["BONE RAVEN", "骷髅渡鸦"], ["SAW TRAP", "锯齿陷阱"], ["MINER BANDIT", "矿工盗贼"], ["BABY CRYSTAL SPIDER", "水晶蜘蛛宝宝"], ["CRYSTAL BAT", "水晶蝙蝠"], ["CRYSTAL MORTAR", "水晶迫击炮"], ["SKEAL", "骷髅海豹"], ["CURSED BABY CRYSTAL SPIDER", "诅咒水晶蜘蛛宝宝"], ["CURSED CRYSTAL BAT", "诅咒水晶蝙蝠"], ["CURSED CRYSTAL MORTAR", "诅咒水晶迫击炮"], ["SNOW CAT", "雪地猫"], ["SNOW SEAL", "雪地海豹"], ["PORTAL GUARDIAN", "传送门守护者"], ["SECURITY", "安保"], ["DIVER BANDIT", "潜水员盗贼"], ["TRAFFIC CRAB", "路障寄居蟹"], ["GULL", "海鸥"], ["PELICAN", "鹈鹕"], ["ANGLER", "灯笼鱼"], ["SEAL", "海豹"], ["HEAVY SEAL", "重型海豹"], ["BLOOMING ASSASSIN", "花丛暗杀者"], ["SEAL KING", "海豹王"], ["PUFFER", "河豚"], ["HAMMER SHARK", "锤头鲨"], ["FISH FREAK", "鱼类异形怪"], ["EEL", "电鳗"], ["ELITE EEL", "精英电鳗"], ["JELLYFISH", "水母"], ["ELITE JELLYFISH", "精英水母"], ["GOLDEN ANGLER", "黄金灯笼鱼"], ["PIT SQUID", "幽灵蛸"], ["BAT", "蝙蝠"], ["LAIR TURRET", "巢穴炮塔"], ["BIG SHOTS", "大人物组合"], ["BIG CAT", "大猫"], ["BIG BAT", "大蝙蝠"], ["RED CRYSTAL SPIDER", "红晶蜘蛛"], ["RED CRYSTAL BRAIN", "红晶之脑"], ["RED CRYSTAL HEART", "红晶之心"], ["CHAOS CRYSTAL HEART", "混沌之心"], ["TESSERACT", "超立方"], ["CURSED AMMO CHEST", "诅咒弹药箱"], ["HUGE WEAPON CHEST", "巨型武器箱"], ["SUNKEN CHEST", "宝藏箱"], ["BONUS AMMO", "无限弹药"], ["BONUS HEALTH", "无限医疗"], ["BONUS AMMO PICKUP", "无限弹药包"], ["BONUS AMMO CHEST", "无限弹药箱"], ["BONUS HEALTH PICKUP", "无限医疗包"], ["BONUS HEALTH CHEST", "无限医疗箱"], ["BONUS @YHAMMERHEAD", "额外@y锤头"], ["BONUS SPIRIT", "额外光环"], ["HAMMERHEAD PICKUP", "锤头包"], ["HAMMERHEAD CHEST", "锤头箱"], ["SPIRIT PICKUP", "光环包"], ["SPIRIT CHEST", "光环箱"], ["RED AMMO PICKUP", "红色弹药包"], ["RED AMMO CHEST", "红色弹药补给罐"], ["RED CHEST", "红晶箱"], ["CAT CHEST", "猫箱"], ["BAT CHEST", "蝙蝠箱"], ["RAT CHEST", "老鼠箱"], ["BURIED VAULT CHEST", "尘封的密室箱"], ["PURPLE PROTO CHEST", "紫原初武器箱"], ["ORCHID CHEST", "兰花箱"], ["VAULT FLOWER", "密室兰花"], ["PALACE ALTAR", "辐射神龛"], ["HUGE BEETLE CHEST", "巨型解密宝箱"], ["BACKPACK", "背包"], ["ALLY BACKPACK", "盟军小匪背包"], ["ROGUE BACKPACK", "叛警背包"], ["WALL CRATE", "板条箱"], ["BONE PICKUP", "骨头碎片"], ["BIG BONE PICKUP", "骨头碎块"], ["OVERSTOCK MIMIC", "无限弹药箱怪"], ["OVERHEAL MIMIC", "无限医疗箱怪"], ["CURSED MIMIC", "诅咒弹药箱怪"], ["OVERSTOCK", "无限弹药"], ["OVERHEAL", "无限医疗"], ["PICK ONE!", "选择一项！"], ["PICK TWO!", "选择两项！"], ["6 FEATHERS", "六根羽毛"], ["30 BONES", "三十块骨头"], ["1 CHEST", "一个箱子"], ["1 PICKUP", "一个掉落物"], ["2 PICKUPS", "两个掉落物"], ["+10 TILES", "增加十格"], ["25 RADS", "二十五辐射"], ["45 RADS", "四十五辐射"], ["OPTIONS", "设置"], ["STATS", "统计"], ["CREDITS", "感谢名单"], ["PETS", "宠物"], ["PET", "宠物"], ["MUTANTS", "变异体"], ["UNLOCKS", "解锁记录"], ["UNLOCKED", "已解锁"], ["LOCKED", "未解锁"], ["UNKNOWN", "未知"], ["NONE", "无"], ["USE SHADERS", "使用着色器"], ["REMINDERS", "设置提醒"], ["FOOTPRINTS", "足迹"], ["NTTE INTROS", "NTTE 入场动画"], ["PETS OUTLINE", "宠物描边"], ["CHARM OUTLINE", "友方单位描边"], ["VISUAL QUALITY: MAIN", "主要视觉质量"], ["VISUAL QUALITY: MINOR", "次要视觉质量"], ["AUTO", "自动"], ["ON", "开启"], ["OFF", "关闭"], ["KILLS", "击杀数"], ["LOOPS", "循环数"], ["RUNS", "游玩局数"], ["DEATHS", "死亡数"], ["WINS", "胜利数"], ["TIME", "时间"], ["SPENT", "消耗数"], ["CHARMED", "魅惑数"], ["BEST AREA", "最远关卡"], ["BEST KILLS", "最高击杀数"], ["BONES", "骨头"], ["FOUND", "发现次数"], ["OWNED", "携带时间"], ["DAMAGE", "伤害"], ["HEALED", "治疗量"], ["SHOTS", "射击次数"], ["HITS", "命中次数"], ["BLOCKED", "格挡次数"], ["BOUGHT", "购买次数"], ["SOLD", "出售次数"], ["COLLECTED", "收集数"], ["FETCHED", "取回数"], ["AROUND", "陪伴时间"], ["BATTLE", "战斗"], ["PLAYTIME", "游戏时间"], ["ARCING", "电弧时间"], ["SPECIAL THANKS", "特殊感谢"], ["LEAD PROGRAMMER", "主程序"], ["SPRITE ARTIST", "美术"], ["PROGRAMMER", "程序"], ["MUSIC", "音乐"], ["SOUND DESIGN", "音效设计"], ["TRAILERS", "宣传片"], ["WEAPON SPRITES", "武器美术"], ["PROGRAMMING", "程序"], ["IOS PORT", "iOS 移植"], ["BEACH GUNS", "海滩武器"], ["BUBBLE GUNS", "气泡武器"], ["TECH GUNS", "科技武器"], ["SAWBLADE GUNS", "锯片武器"], ["RED GUNS", "红晶武器"], ["CROWNS", "王冠"], ["GRAB YOUR FRIENDS", "带上你的朋友"], ["SOAP AND WATER", "肥皂与水"], ["TERRORS FROM THE DEEP", "深海恐惧"], ["DEVICES OF TORTURE", "折磨装置"], ["SPACE BENDS AND BREAKS", "空间扭曲并破裂"], ["DISCOVER AN NTTE CROWN", "发现一顶 NTTE 王冠"], ["STOLEN FROM THIEVES", "从盗贼手中夺来"], ["EXPLORE THE OTHER SIDE", "探索另一侧"], ["CROWN OF BONUS STORED", "奖励王冠已存入"], ["CROWN OF CRIME STORED", "罪恶王冠已存入"], ["RED CROWN STORED", "红晶王冠已存入"], ["FOR EVERYONE", "所有角色均可使用"], ["STORED!", "已存入！"], ["HEALTH", "生命"], ["AMMO", "弹药"], ["RADS", "辐射"], ["FEATHERS", "羽毛"], ["COAT", "风衣"], ["TURRET", "炮塔"], ["GOLDEN", "黄金"], ["CURSED", "诅咒"], ["MERGED", "融合"], ["STOCK", "枪托"], ["FRONT", "前部"], ["PARTS", "组件"], ["CONTINUUM", "连续体"], ["BEND", "折叠"], ["SPLIT", "分裂"], ["THE", ""], ["FOR", "为"], ["ON ENTRY", "出现时"], ["SMUGGLED GOODS", "走私物资"], ["BOUNTY", "赏金"], ["CRIME", "犯罪"], ["PUNTED", "踢飞的"], ["ENEMIES", "敌人"], ["EXPLODE", "爆炸"], ["FEATHERED", "被羽毛魅惑的"], ["GUN", "枪"], ["PISTOL", "手枪"], ["REVOLVER", "左轮手枪"], ["RIFLE", "步枪"], ["SHOTGUN", "霰弹枪"], ["LAUNCHER", "发射器"], ["BLASTER", "爆射枪"], ["CANNON", "加农炮"], ["ULTRA", "终极"], ["HYPER", "高阶"], ["SUPER", "超级"], ["ENERGY", "能量"], ["BUBBLE", "气泡"], ["QUASAR", "类行星"], ["ELECTROPLASMA", "等离子电球"], ["LIGHTNING", "闪电"], ["SAWBLADE", "锯片"], ["PORTAL", "传送门"], ["BIGFISH", "大鱼"], ["CATBAT", "大人物组合"], ["PALANKING", "海豹王"], ["PETWEAPON", "武器箱怪"], ["PETWEAPONCURSED", "诅咒武器箱怪"], ["PITSQUID", "幽灵蛸"], ["BONUS", "奖励"], ["COOL", "酷"], ["GILDED", "镀金"], ["SKIN", "皮肤"], ["SCYTHE", "骨镰刀"], ["PRESS", "按"], ["TO CHANGE MODES", "切换模式"], ["CAN DO SO MUCH MORE", "还有更多用途"], ["TO REARRANGE A FEW", "重新排列"], ["JUST PRESS", "快按"], ["ALREADY", "吧"], ["PLEASE PRESS", "请按"], ["REACH", "到达"], ["REACHED", "已到达"], ["REACH COMBO", "达到连击"], ["COMBO", "连击"], ["FUNKY", "放克时刻"], ["DEFEAT A", "击败"], ["FOR DEFEATING A", "解锁条件：击败"], ["REACH MAX", "达到最高"], ["FOR REACHING MAX", "解锁条件：达到最高"], ["FOR REACHING", "解锁条件：到达"], ["EXPLORE THE", "探索"], ["OTHER SIDE", "另一侧"], ["EVERYONE", "所有角色"], ["UNLOCKED!", "已解锁！"], ["CONTINUE", "继续"], ["ANNIHILATED", "已湮灭"], ["DESTROYS", "消灭"], ["ALL", "所有"], ["AND", "和"], ["FOR THE NEXT", "接下来"], ["LEVELS", "个关卡"], ["THROUGH THE", "持续至"], ["UNTIL THE", "持续至"], ["NEXT LEVEL", "下一关"], ["TEMPORARILY", "临时生效"], ["DROP", "放下"], ["PUNTED ENEMIES EXPLODE", "被踢飞的敌人会爆炸"], ["TURN EM ON!", "打开它们吧！"], ["PUMP IT UP!", "把音量调高吧！"], ["SEE BETTER IN THE", "看得更清楚："], ["DARK", "黑暗"], ["EXTRA", "额外"], ["SLOT", "栏位"], ["MORE", "更多"], ["FROM", "来自"], ["CHANCE", "有概率"], ["DIE", "死亡"], ["FIND", "寻找"], ["THE FAMILY CONCEDES", "家族作出让步"], ["TOXIC GAS", "毒气"], ["BREATHABLE", "可以呼吸"], ["BONUS AMMO PICKUPS", "无限弹药包"], ["REPLACE", "替代"], ["HP DROPS", "医疗掉落"], ["PRICE", "悬赏"], ["ON YOUR HEAD", "加诸你身"], ["CHAOTIC", "混沌的"], ["CRYSTAL HEARTS", "红晶之心"], ["SMALLER", "更小的"], ["AREAS", "区域"], ["FAMILY", "家族"], ["DOESN'T FORGIVE", "不会宽恕"], ["BAT'S", "蝙蝠的"], ["EXPERIMENTS", "实验"], ["CAT'S", "猫的"], ["RESOURCES", "物资"], ["CHARM ENEMIES", "魅惑敌人"], ["PARTS OF", "组件："], ["MERGED WEAPONS", "融合武器"], ["CAN BE REPLACED", "可以替换"], ["BY WEAPONS OF THE SAME", "使用相同类型的武器："], ["AMMO TYPE", "弹药类型"], ["PICKUPS", "掉落物"], ["GIVE", "给予"], ["OPENS WITH A", "开启时产生"], ["BLAST", "爆炸"], ["APPEARS", "出现"], ["WHEN NEEDED", "需要时"], ["MERGED WEAPON", "融合武器"], ["STOCKS", "枪托"], ["ARE", "会"], ["TRIGGER-HAPPY", "自动开火"], ["CAN CHARM MULTIPLE ENEMIES", "可以魅惑多个敌人"], ["LAST", "维持"], ["LONGER", "更久"], ["INCOMING DAMAGE", "受到的伤害"], ["IS SPLIT", "由其分担"], ["WITH", "与"], ["LIKE DISCS BUT", "像圆盘，但比它"], ["SMARTER", "聪明"], ["PARROTS RETRIEVE", "鹦鹉会取回"], ["HAMMERHEAD", "铁头"], ["RHINO SKIN", "犀牛皮"], ["EXTRA FEET", "迅足"], ["PLUTONIUM HUNGER", "钚能贪食"], ["RABBIT PAW", "兔爪"], ["THRONE BUTT", "王座之臀"], ["LUCKY SHOT", "幸运一击"], ["BLOODLUST", "嗜血"], ["GAMMA GUTS", "辐射之身"], ["SECOND STOMACH", "第二胃袋"], ["BACK MUSCLE", "背肌强化"], ["SCARIER FACE", "惊悚面容"], ["EUPHORIA", "欢欣"], ["LONG ARMS", "长臂"], ["BOILING VEINS", "热血沸腾"], ["SHOTGUN SHOULDERS", "霰弹回旋"], ["RECYCLE GLAND", "回收腺体"], ["RECYCLE GLANDS", "回收腺体"], ["LASER BRAIN", "激光脑"], ["LAST WISH", "最终心愿"], ["EAGLE EYES", "鹰眼"], ["IMPACT WRISTS", "超强腕力"], ["BOLT MARROW", "追踪箭矢"], ["STRESS", "紧张"], ["TRIGGER FINGERS", "神速扳机"], ["SHARP TEETH", "利齿"], ["PATIENCE", "耐心"], ["HAMMER HEAD", "铁头"], ["STRONG SPIRIT", "强韧灵魂"], ["OPEN MIND", "开放思维"], ["HEAVY HEART", "沉重之心"], ["SALAMANDER - @WPUNTED @SENEMIES @REXPLODE@S", "蝾螈 - @w被踢飞的敌人@s会@r爆炸@s"], ["FOR HOLDING 6 WEAPONS IN ONE HAND", "在一只手中融合六件武器后解锁"], ["HOLD 6 WEAPONS#IN ONE HAND", "在一只手中#融合六件武器"], ["FOR BEATING THE AQUATIC ROUTE", "完成整条水域路线后解锁"], ["COMPLETE THE#AQUATIC ROUTE", "完成整条#水域路线"], ["DONATE", "捐赠"], ["BLESSING", "祝福"], ["SHARE", "分享"], ["CHOOSE", "选择"], ["REVIVE", "复活"], ["ESCAPE", "逃离"], ["MOUNT", "骑乘"], ["DISMOUNT", "下坐骑"], ["UNLOCK", "解锁"], ["WARP", "跃迁"], ["ANNIHILATIONS", "湮灭之相"], ["BAT EARSES", "蝙蝠双耳"], ["COMPASSIONS", "同情"], ["LEAD RIBSES", "铸铅肋骨"], ["MAGNETIC PULSES", "核磁脉冲"], ["SILVER TONGUES", "银舌"], ["TOAD BREATHS", "蟾蜍呼吸"], ["REROLLS", "重掷变异"], ["GOODBYES", "再见"], ["ECHOLOCATION IS UNDERRATEDS", "回声定位不可小觑"], ["NEW BEST FRIENDS", "新的挚友"], ["HIGHER THRESHOLDS", "更高的阈值"], ["SHORT CIRCUITS", "短路"], ["DIPLOMACIES", "外交手段"], ["CORROSIONS", "腐蚀"], ["CROWN OF BONUSES", "奖励王冠"], ["CROWN OF CRIMES", "罪恶王冠"], ["RED CROWNS", "红晶王冠"], ["ALL EXTRAS", "额外奖励"], ["FULL OF LIVES", "生机勃勃"], ["SO CRAMPEDS", "真拥挤"], ["BEETLES", "甲虫"], ["PARROTS", "鹦鹉"], ["BEETLE CHESTS", "解密宝箱"], ["MERGE WEAPONSES", "融合武器"], ["MANY FRIENDSES", "朋友多多"], ["OPEN THE CHESTS", "打开宝箱"], ["REACH COASTS", "到达海滩"], ["FOR OPENING THE CHESTS", "打开宝箱后解锁"], ["FOR REACHING COASTS", "到达海滩后解锁"], ["CRITICAL THORAXES", "临界胸廓"], ["AUXILIARY MANDIBLESES", "辅助下颚"], ["BIRDS OF A FEATHERS", "敌以羽聚"], ["FLOCK TOGETHERS", "鸟以群分"], ["PARROT ABILITY TOGGLES", "鹦鹉技能切换"], ["PARROT B SKINS", "鹦鹉 B 皮肤"], ["BEETLE B SKINS", "甲虫 B 皮肤"], ["COMPLETE THE AQUATIC ROUTES", "完成整条水域路线"], ["ABYSSALS", "深渊"], ["BAT EYESES", "蝙蝠眼睛"], ["BONUS ROBOTS", "奖励机器人"], ["COOL FROGS", "酷蛙"], ["GILDED PLANTS", "镀金植物"], ["RED CRYSTALS", "红晶"], ["DEFEAT A GOLDEN ANGLERS", "击败黄金灯笼鱼"], ["REACH MAX CRIME BOUNTIES", "达到最高犯罪赏金"], ["BUY A COATS", "购买一件风衣"], ["FOR BUYING A COATS", "购买风衣后解锁"], ["FOR REROLLING HEAVY HEARTS", "重掷沉重之心后解锁"], ["REACH THE OTHER SIDES", "到达另一侧"], ["FRESH FITS", "焕然一新的穿搭"], ["DROWNING IN STYLES", "时髦地沉入水中"], ["SHAPED BY THE DEPTHSES", "由深渊塑造"], ["LOST YOUR MINDS", "失去理智"], ["FROGGING AROUNDS", "蛙趣横生"], ["SAY MY NAMES", "叫出我的名字"], ["WHAT THE COOLS", "酷得离谱"], ["STYLISHES", "时髦"], ["SHINY LIKE A LIMOUSINES", "像豪华轿车一样闪亮"], ["IS THAT DESIGNERS", "这是名牌吗"], ["YOU LOOK SO GOODS", "你看起来真不错"], ["SO BRIGHT OUTS", "外面真亮"], ["MISSED THE SUNS", "想念阳光"], ["NEVER MORE ALIVES", "从未如此鲜活"], ["FOR A MOMENTS", "片刻之间"], ["TOO COOL FOR SCHOOLS", "酷到不想上学"], ["JUST A COOL FROGS", "只是一只酷蛙"], ["PUMP YOUR VEINS WITH GUSHING GOLDS", "让奔涌的黄金注入血管"], ["ALL THAT TWINKLES IS GOLDS", "闪闪发光的都是金子"], ["STRAIGHT FROM THE SEWERSES", "来自下水道"], ["TOO MUCH PIZZAS", "披萨吃多了"], ["MAKE SURE YOU FLUSHES", "记得冲水"], ["SLIME TIMES", "黏液时间"], ["LIVE FOREVERS", "永生"], ["YOU ARE TERMINATEDS", "你被终结了"], ["THE DANGERS", "危险本身"], ["MILLION DOLLAR SMILES", "价值百万的微笑"], ["ENERGY BATS", "能量球拍"], ["TELEPORT GUNS", "传送枪"], ["SUPER TELEPORT GUNS", "超级传送枪"], ["GOLDEN TELEPORT GUNS", "黄金传送枪"], ["ROGUE CARBINES", "叛警卡宾枪"], ["BEETLE PISTOLS", "甲虫爆射手枪"], ["BEETLE BLASTERS", "甲虫爆射手枪"], ["VENOM RIFLES", "毒液步枪"], ["VAMPIRES", "吸血鬼"], ["DEMATERIALIZERS", "物质分解器"], ["BONE SCYTHES", "骨镰刀"], ["BONE SHOTBOWS", "骨霰弹十字弩"], ["BONE SLUGBOWS", "骨独头弹十字弩"], ["HARPOON LAUNCHERS", "鱼叉发射器"], ["NET LAUNCHERS", "网状发射器"], ["NET GUNS", "网状发射器"], ["CLAM SHIELDS", "蛤盾"], ["TRIDENTS", "三叉戟"], ["GOLDEN TRIDENTS", "黄金三叉戟"], ["BUBBLE RIFLES", "气泡步枪"], ["BUBBLE BATS", "气泡球拍"], ["BUBBLE SHOTGUNS", "气泡霰弹枪"], ["BUBBLE MINIGUNS", "气泡速射机枪"], ["BUBBLE CANNONS", "气泡加农炮"], ["HYPER BUBBLERS", "高阶气泡发射器"], ["TESLA COILS", "特斯拉线圈"], ["LIGHTNING RING LAUNCHERS", "电环发射器"], ["SUPER LIGHTNING RING LAUNCHERS", "超级电环发射器"], ["ELECTROPLASMA RIFLES", "等离子电球步枪"], ["ELECTROPLASMA SHOTGUNS", "等离子电球霰弹枪"], ["ELECTROPLASMA CANNONS", "等离子电球加农炮"], ["QUASAR BLASTERS", "类行星爆射枪"], ["QUASAR RIFLES", "类行星步枪"], ["QUASAR CANNONS", "类行星加农炮"], ["ULTRA QUASAR RIFLES", "终极类行星步枪"], ["BAT DISC LAUNCHERS", "锯片发射器"], ["SAWBLADE CANNONS", "锯片加农炮"], ["BAT DISC CANNONS", "锯片加农炮"], ["PIZZA CUTTERS", "披萨切割机"], ["TUNNELLERS", "掘地者"], ["GOLDEN TUNNELLERS", "黄金掘地者"], ["ANNIHILATORS", "湮灭者"], ["ENTANGLERS", "纠缠者"], ["ANCIENT ARTIFACTS", "古代组件"], ["GUARDED ARTIFACTS", "守卫组件"], ["STOLEN ARTIFACTS", "被窃组件"], ["MISSING ARTIFACTS", "遗失组件"], ["EGGPLANTS", "茄子"], ["LOST BUT NOT FORGOTTENS", "丢失但未被遗忘"], ["POSITION INDETERMINABLES", "位置不确定"], ["LUXURY TRAVELS", "豪华旅行"], ["A PIERCING STINGS", "穿心刺痛"], ["REASSEMBLEDS", "重新装配"], ["MARROW FROM A HUNDRED MUTANTSES", "来自一百个变异体的骨髓"], ["RADIATION DETERIORATES BONESES", "辐射使骨骼退化"], ["REEL IT INS", "收线"], ["CATCH OF THE DAYS", "一天的渔获"], ["ROYAL GUARDS", "皇家护卫"], ["SCEPTER OF THE SEAS", "深海王权"], ["SHINE THROUGH THE SKIES", "划破天际"], ["REFRESHINGS", "焕然一新"], ["SUMMERTIME FUNS", "夏日欢愉"], ["SOAP EVERYWHERES", "到处都是肥皂"], ["KING OF THE BUBBLESES", "气泡之王"], ["POWER WASHERS", "动力清洗机"], ["LIMITED POWERS", "能力有限"], ["JELLY TECHNOLOGIES", "水母科技"], ["EYE OF THE STORMS", "暴风眼"], ["DEEP SEA WEAPONRIES", "深海武器"], ["BRAIN EXPANDINGS", "大脑扩张"], ["SO FLEXIBLES", "如此灵活"], ["BLINDING LIGHTS", "耀眼之光"], ["PULSATINGS", "脉冲"], ["THE GREEN SUNS", "绿日"], ["ROCKET POWERED RECOIL DAMPENINGS", "正在抑制推进器产生的后坐力"], ["LIKE DISCS BUT SMARTERS", "像圆盘，但比它聪明"], ["FOR THE CIVILIZED TURTLES", "献给有教养的乌龟"], ["THEY STAND NO CHANCES", "他们没有机会"], ["FULL CIRCLES", "完整的圆"], ["KEY TO THE MULTIVERSES", "多元宇宙的钥匙"], ["YET ANOTHER RED KEYS", "又一把红钥匙"], ["BEND THE CONTINUUMS", "折叠连续体"], ["SPLIT THE CONTINUUMS", "分裂连续体"], ["MAKING NEW FRIENDSES", "结交新朋友"], ["GOLDEN GODS", "黄金之神"], ["SECRETS LIE WITHINS", "秘密就在其中"], ["UNCONVENTIONAL WEAPONRIES", "非常规武器"], ["BRING IT BACKS", "把它带回来"], ["A PACKAGE DEALS", "成套出售"], ["GUNS THAT SEW THREADSESES", "缝合命运之枪"], ["EXTRA OFFENSES", "额外攻势"], ["TREAD LIGHTLIES", "小心脚下"], ["RECYCLES", "回收利用"], ["PORTAL STRIKES", "传送打击"], ["FAMILY CAN WAITS", "家族可以等等"], ["INFINITE AMMOES", "无限弹药"], ["SCORPIONS", "蝎子"], ["SALAMANDERS", "蝾螈"], ["SPIDERS", "水晶蜘蛛"], ["CURSED SPIDERS", "诅咒水晶蜘蛛"], ["SLAUGHTERS", "屠宰者"], ["OCTOES", "八爪鱼"], ["MIMICS", "宝箱怪"], ["PRISMS", "诅咒棱镜"], ["ORCHIDS", "螳螂"], ["TWINSES", "双子棱镜"], ["WEAPON MIMICS", "武器箱怪"], ["WEAPONS", "武器"], ["CUZES", "Y.C."], ["YUNG CUZES", "Y.C."], ["GUARDIANS", "I.D.P.D.能量守护者"], ["SPIT VENOMS", "喷吐毒液"], ["ROCKSLIDES", "落石"], ["HIGH ON THE FOOD CHAINS", "食物链的高处"], ["BACKPACK BUDDIES", "背包伙伴"], ["HANDIES", "得心应手"], ["THEY LIKE YOUS", "它们喜欢你"], ["HAND OVER HANDS", "交替前进"], ["BABIES", "小家伙"], ["JAWSES", "大白鲨"], ["VICIOUSES", "凶猛"], ["BRAIN WAVESES", "脑电波"], ["TEAMWORKS", "团队合作"], ["JUMP ROPES", "跳绳"], ["BRING FORTH THE MOLLUSKS", "召唤软体动物"], ["STINK BEANS", "臭豆子"], ["JUST A COOL GUYS", "只是个酷家伙"], ["BROES", "兄弟"], ["BACKWARD CAPS ARE COOLS", "反戴帽子真酷"], ["VEHICULAR COMBATS", "载具战斗"], ["NITROUSES", "氮气加速"], ["PUNTS", "飞踢"], ["EXTERNAL STORAGES", "外部仓库"], ["GUN DEALERS", "军火商"], ["WHAT YOU NEEDS", "你需要的东西"], ["BUY SOMETHINGS", "买点东西"], ["STUCK A BITS", "有点卡住了"], ["SITUATION STICKIES", "棘手的处境"], ["A BIT STUCKS", "有点黏住了"], ["STICKY SITUATIONS", "黏糊糊的处境"], ["GROSSES", "真恶心"], ["COCOONEDS", "作茧"], ["STRANGE GEOMETRIES", "奇异几何"], ["CURSED REFRACTIONS", "诅咒折射"], ["YEAH OH S", "好耶 "], ["LIGHT BEAMSES", "光束"], ["SUBSPACE HIGHWAY THROUGH YOUR HEADS", "穿过脑海的亚空间公路"], ["WROUGHT FROM THE SOURCES", "源头铸就"], ["AN ELEGANT DANCES", "优雅之舞"], ["ELEGANTS", "优雅"], ["FLORIDS", "绚丽"], ["GENETIC MAGICS", "基因魔法"], ["YOU WERE THE KING OF KARAT FLOWERSES", "你曾是金色花朵之王"], ["MUTUAL RESPECTS", "相互尊重"], ["RESPECT MUTUALS", "彼此尊重"], ["WALKING WEAPONS", "行走的武器"], ["WEAPON WALKINGS", "武器在行走"], ["YUNG CUZ IS LAZIES", "小表弟很懒"], ["CUZ IS STILL LEARNINGS", "表弟仍在学习"], ["BE A ROLE MODELS", "做个好榜样"], ["NO TIME FOR GAMESES", "没空玩游戏"], ["MEMENTOES", "纪念品"], ["BLACK BOXES", "黑匣子"], ["DEFECTIVES", "故障品"], ["DESERTS", "沙漠"], ["SEWERSES", "下水道"], ["PIZZAS", "披萨下水道"], ["SCRAPYARDS", "废弃停车场"], ["MANSIONS", "Y.V.大厦"], ["CAVESES", "水晶洞窟"], ["CURSED CAVESES", "诅咒洞窟"], ["CITIES", "冰封都市"], ["JUNGLES", "丛林"], ["LABSES", "实验室"], ["PALACES", "宫殿"], ["CAMPFIRES", "营地"], ["HEADQUARTERSES", "I.D.P.D.总部"], ["VAULTS", "王冠密室"], ["CRIBS", "Y.V.老家"], ["COASTS", "海滩"], ["OASISES", "绿洲"], ["TRENCHES", "海沟"], ["LAIRS", "巢穴"], ["REDS", "红晶"], ["QUESTS", "终极解密"], ["BANDIT CAMPS", "盗贼营地"], ["SCORPION CITIES", "蝎子巢"], ["MAGGOT PARKS", "蛆堆"], ["BLOCKED ROOMS", "封闭房间"], ["GATOR AMBUSHES", "鳄鱼据点"], ["GATOR DENS", "鳄鱼金库"], ["RAVEN ARENAS", "斗兽场"], ["FIRE PITS", "旋转十字喷火陷阱"], ["SEAL PLAZAS", "海豹都市"], ["MUTANT VATSES", "培养基地"], ["PALACE SHRINES", "辐射神龛"], ["BURIED VAULTS", "王冠密室遗址"], ["EEL GRAVES", "电鳗之墓"], ["SOMETHING IN THE DISTANCES", "远处有什么东西"], ["SECRETS IN THES", "秘密藏在"], ["WALLSES", "墙壁中"], ["ARCHAEOLOGIES", "考古"], ["ANCIENTS", "古老的"], ["STRUCTURESES", "建筑"], ["BANDITSES", "盗贼"], ["THE SOUND OFS", "传来一阵"], ["FLIESES", "苍蝇声"], ["THE AIRS", "空气中"], ["STINGSES", "带着刺痛"], ["WHERE ARE WE GOINGS", "我们正去往何处"], ["RADIOACTIVE SEWAGES", "放射性污水"], ["SMELLSES", "闻起来"], ["WORSE THAN YOU THINKS", "比想象中更糟"], ["ACID RAINS", "酸雨"], ["RUNOFFS", "径流"], ["THE WASTELAND WEAPON TRADES", "废土军火交易"], ["THESE PIPES RUNS", "这些管道"], ["EVERYWHERES", "无处不在"], ["DISTANT CHATTERS", "远处的交谈声"], ["ENTERS", "进入"], ["THE RINGS", "竞技场"], ["RAIN DROPSES", "雨滴"], ["TURN TOES", "化作"], ["STEAMS", "蒸汽"], ["DISTANT RELATIVESES", "远亲"], ["SPECIMENSES", "实验标本"], ["RAD MANIPULATIONS", "操控辐射"], ["ISES", "是"], ["KINDA TRICKIES", "有点棘手"], ["FINAL PROVISIONSES", "最后的补给"], ["WAITING FOR YOUS", "正在等你"], ["AMBUSHEDS", "遭遇埋伏"], ["EELSES", "电鳗"], ["NEVERS", "永不"], ["FORGETS", "遗忘"], ["BIG MAGGOTS NESTS", "大型蛆虫窝"], ["BABY SCORPIONS", "蝎子宝宝"], ["GOLDEN BABY SCORPIONS", "黄金蝎子宝宝"], ["PATCH ALLIGATORS", "独眼短吻鳄"], ["CAMPER BANDITS", "营地盗贼"], ["HIKER BANDITS", "旅者盗贼"], ["SILVER SCORPIONS", "银蝎子"], ["CATS", "猫"], ["BABY ALLIGATORS", "短吻鳄宝宝"], ["BONE ALLIGATORS", "骷髅短吻鳄"], ["ALBINO ALLIGATORS", "白化短吻鳄"], ["BONE RAVENS", "骷髅渡鸦"], ["SAW TRAPS", "锯齿陷阱"], ["MINER BANDITS", "矿工盗贼"], ["BABY CRYSTAL SPIDERS", "水晶蜘蛛宝宝"], ["CRYSTAL BATS", "水晶蝙蝠"], ["CRYSTAL MORTARS", "水晶迫击炮"], ["SKEALS", "骷髅海豹"], ["CURSED BABY CRYSTAL SPIDERS", "诅咒水晶蜘蛛宝宝"], ["CURSED CRYSTAL BATS", "诅咒水晶蝙蝠"], ["CURSED CRYSTAL MORTARS", "诅咒水晶迫击炮"], ["SNOW CATS", "雪地猫"], ["SNOW SEALS", "雪地海豹"], ["PORTAL GUARDIANS", "传送门守护者"], ["SECURITIES", "安保"], ["DIVER BANDITS", "潜水员盗贼"], ["TRAFFIC CRABS", "路障寄居蟹"], ["GULLS", "海鸥"], ["PELICANS", "鹈鹕"], ["ANGLERS", "灯笼鱼"], ["SEALS", "海豹"], ["HEAVY SEALS", "重型海豹"], ["BLOOMING ASSASSINS", "花丛暗杀者"], ["SEAL KINGS", "海豹王"], ["PUFFERS", "河豚"], ["HAMMER SHARKS", "锤头鲨"], ["FISH FREAKS", "鱼类异形怪"], ["ELITE EELS", "精英电鳗"], ["GOLDEN ANGLERS", "黄金灯笼鱼"], ["PIT SQUIDS", "幽灵蛸"], ["BATS", "蝙蝠"], ["LAIR TURRETS", "巢穴炮塔"], ["BIG SHOTSES", "大人物组合"], ["BIG CATS", "大猫"], ["BIG BATS", "大蝙蝠"], ["RED CRYSTAL SPIDERS", "红晶蜘蛛"], ["RED CRYSTAL BRAINS", "红晶之脑"], ["RED CRYSTAL HEARTS", "红晶之心"], ["CHAOS CRYSTAL HEARTS", "混沌之心"], ["TESSERACTS", "超立方"], ["CURSED AMMO CHESTS", "诅咒弹药箱"], ["HUGE WEAPON CHESTS", "巨型武器箱"], ["SUNKEN CHESTS", "宝藏箱"], ["BONUS AMMOES", "无限弹药"], ["BONUS HEALTHS", "无限医疗"], ["BONUS AMMO CHESTS", "无限弹药箱"], ["BONUS HEALTH PICKUPS", "无限医疗包"], ["BONUS HEALTH CHESTS", "无限医疗箱"], ["BONUS SPIRITS", "额外光环"], ["HAMMERHEAD PICKUPS", "锤头包"], ["HAMMERHEAD CHESTS", "锤头箱"], ["SPIRIT PICKUPS", "光环包"], ["SPIRIT CHESTS", "光环箱"], ["RED AMMO PICKUPS", "红色弹药包"], ["RED AMMO CHESTS", "红色弹药补给罐"], ["RED CHESTS", "红晶箱"], ["CAT CHESTS", "猫箱"], ["BAT CHESTS", "蝙蝠箱"], ["RAT CHESTS", "老鼠箱"], ["BURIED VAULT CHESTS", "尘封的密室箱"], ["PURPLE PROTO CHESTS", "紫原初武器箱"], ["ORCHID CHESTS", "兰花箱"], ["VAULT FLOWERS", "密室兰花"], ["PALACE ALTARS", "辐射神龛"], ["HUGE BEETLE CHESTS", "巨型解密宝箱"], ["BACKPACKS", "背包"], ["ALLY BACKPACKS", "盟军小匪背包"], ["ROGUE BACKPACKS", "叛警背包"], ["WALL CRATES", "板条箱"], ["BONE PICKUPS", "骨头碎片"], ["BIG BONE PICKUPS", "骨头碎块"], ["OVERSTOCK MIMICS", "无限弹药箱怪"], ["OVERHEAL MIMICS", "无限医疗箱怪"], ["CURSED MIMICS", "诅咒弹药箱怪"], ["OVERSTOCKS", "无限弹药"], ["OVERHEALS", "无限医疗"], ["OPTIONSES", "设置"], ["STATSES", "统计"], ["CREDITSES", "感谢名单"], ["PETSES", "宠物"], ["MUTANTSES", "变异体"], ["UNLOCKSES", "解锁记录"], ["UNLOCKEDS", "已解锁"], ["LOCKEDS", "未解锁"], ["UNKNOWNS", "未知"], ["NONES", "无"], ["USE SHADERSES", "使用着色器"], ["REMINDERSES", "设置提醒"], ["FOOTPRINTSES", "足迹"], ["NTTE INTROSES", "NTTE 入场动画"], ["PETS OUTLINES", "宠物描边"], ["CHARM OUTLINES", "友方单位描边"], ["AUTOES", "自动"], ["ONS", "开启"], ["OFFS", "关闭"], ["KILLSES", "击杀数"], ["LOOPSES", "循环数"], ["RUNSES", "游玩局数"], ["DEATHSES", "死亡数"], ["WINSES", "胜利数"], ["TIMES", "时间"], ["SPENTS", "消耗数"], ["CHARMEDS", "魅惑数"], ["BEST AREAS", "最远关卡"], ["BEST KILLSES", "最高击杀数"], ["BONESES", "骨头"], ["FOUNDS", "发现次数"], ["OWNEDS", "携带时间"], ["DAMAGES", "伤害"], ["HEALEDS", "治疗量"], ["SHOTSES", "射击次数"], ["HITSES", "命中次数"], ["BLOCKEDS", "格挡次数"], ["BOUGHTS", "购买次数"], ["SOLDS", "出售次数"], ["COLLECTEDS", "收集数"], ["FETCHEDS", "取回数"], ["AROUNDS", "陪伴时间"], ["BATTLES", "战斗"], ["PLAYTIMES", "游戏时间"], ["ARCINGS", "电弧时间"], ["SPECIAL THANKSES", "特殊感谢"], ["LEAD PROGRAMMERS", "主程序"], ["SPRITE ARTISTS", "美术"], ["PROGRAMMERS", "程序"], ["MUSICS", "音乐"], ["SOUND DESIGNS", "音效设计"], ["TRAILERSES", "宣传片"], ["WEAPON SPRITESES", "武器美术"], ["PROGRAMMINGS", "程序"], ["IOS PORTS", "iOS 移植"], ["BEACH GUNSES", "海滩武器"], ["BUBBLE GUNSES", "气泡武器"], ["TECH GUNSES", "科技武器"], ["SAWBLADE GUNSES", "锯片武器"], ["RED GUNSES", "红晶武器"], ["CROWNSES", "王冠"], ["GRAB YOUR FRIENDSES", "带上你的朋友"], ["SOAP AND WATERS", "肥皂与水"], ["TERRORS FROM THE DEEPS", "深海恐惧"], ["DEVICES OF TORTURES", "折磨装置"], ["SPACE BENDS AND BREAKSES", "空间扭曲并破裂"], ["DISCOVER AN NTTE CROWNS", "发现一顶 NTTE 王冠"], ["STOLEN FROM THIEVESES", "从盗贼手中夺来"], ["EXPLORE THE OTHER SIDES", "探索另一侧"], ["CROWN OF BONUS STOREDS", "奖励王冠已存入"], ["CROWN OF CRIME STOREDS", "罪恶王冠已存入"], ["RED CROWN STOREDS", "红晶王冠已存入"], ["FOR EVERYONES", "所有角色均可使用"], ["HEALTHS", "生命"], ["AMMOES", "弹药"], ["RADSES", "辐射"], ["FEATHERSES", "羽毛"], ["COATS", "风衣"], ["TURRETS", "炮塔"], ["GOLDENS", "黄金"], ["CURSEDS", "诅咒"], ["MERGEDS", "融合"], ["FRONTS", "前部"], ["PARTSES", "组件"], ["CONTINUUMS", "连续体"], ["BENDS", "折叠"], ["SPLITS", "分裂"], ["THES", ""], ["FORS", "为"], ["ON ENTRIES", "出现时"], ["SMUGGLED GOODSES", "走私物资"], ["BOUNTIES", "赏金"], ["CRIMES", "犯罪"], ["PUNTEDS", "踢飞的"], ["ENEMIESES", "敌人"], ["EXPLODES", "爆炸"], ["FEATHEREDS", "被羽毛魅惑的"], ["GUNS", "枪"], ["PISTOLS", "手枪"], ["REVOLVERS", "左轮手枪"], ["RIFLES", "步枪"], ["SHOTGUNS", "霰弹枪"], ["LAUNCHERS", "发射器"], ["BLASTERS", "爆射枪"], ["CANNONS", "加农炮"], ["ULTRAS", "终极"], ["HYPERS", "高阶"], ["SUPERS", "超级"], ["ENERGIES", "能量"], ["BUBBLES", "气泡"], ["QUASARS", "类行星"], ["ELECTROPLASMAS", "等离子电球"], ["LIGHTNINGS", "闪电"], ["SAWBLADES", "锯片"], ["PORTALS", "传送门"], ["CATBATS", "大人物组合"], ["PALANKINGS", "海豹王"], ["PETWEAPONS", "武器箱怪"], ["PETWEAPONCURSEDS", "诅咒武器箱怪"], ["PITSQUIDS", "幽灵蛸"], ["BONUSES", "奖励"], ["COOLS", "酷"], ["GILDEDS", "镀金"], ["SKINS", "皮肤"], ["SCYTHES", "骨镰刀"], ["PRESSES", "按"], ["TO CHANGE MODESES", "切换模式"], ["CAN DO SO MUCH MORES", "还有更多用途"], ["TO REARRANGE A FEWS", "重新排列"], ["JUST PRESSES", "快按"], ["ALREADIES", "吧"], ["PLEASE PRESSES", "请按"], ["REACHES", "到达"], ["REACHEDS", "已到达"], ["REACH COMBOES", "达到连击"], ["COMBOES", "连击"], ["FUNKIES", "放克时刻"], ["DEFEAT AS", "击败"], ["FOR DEFEATING AS", "解锁条件：击败"], ["REACH MAXES", "达到最高"], ["FOR REACHING MAXES", "解锁条件：达到最高"], ["FOR REACHINGS", "解锁条件：到达"], ["EXPLORE THES", "探索"], ["OTHER SIDES", "另一侧"], ["EVERYONES", "所有角色"], ["CONTINUES", "继续"], ["ANNIHILATEDS", "已湮灭"], ["DESTROYSES", "消灭"], ["ALLS", "所有"], ["ANDS", "和"], ["FOR THE NEXTS", "接下来"], ["LEVELSES", "个关卡"], ["THROUGH THES", "持续至"], ["UNTIL THES", "持续至"], ["NEXT LEVELS", "下一关"], ["TEMPORARILIES", "临时生效"], ["DROPS", "放下"], ["PUNTED ENEMIES EXPLODES", "被踢飞的敌人会爆炸"], ["SEE BETTER IN THES", "看得更清楚："], ["DARKS", "黑暗"], ["EXTRAS", "额外"], ["SLOTS", "栏位"], ["MORES", "更多"], ["FROMS", "来自"], ["CHANCES", "有概率"], ["DIES", "死亡"], ["FINDS", "寻找"], ["THE FAMILY CONCEDESES", "家族作出让步"], ["TOXIC GASES", "毒气"], ["BREATHABLES", "可以呼吸"], ["BONUS AMMO PICKUPSES", "无限弹药包"], ["REPLACES", "替代"], ["HP DROPSES", "医疗掉落"], ["PRICES", "悬赏"], ["ON YOUR HEADS", "加诸你身"], ["CHAOTICS", "混沌的"], ["CRYSTAL HEARTSES", "红晶之心"], ["SMALLERS", "更小的"], ["AREASES", "区域"], ["FAMILIES", "家族"], ["EXPERIMENTSES", "实验"], ["RESOURCESES", "物资"], ["CHARM ENEMIESES", "魅惑敌人"], ["PARTS OFS", "组件："], ["MERGED WEAPONSES", "融合武器"], ["CAN BE REPLACEDS", "可以替换"], ["BY WEAPONS OF THE SAMES", "使用相同类型的武器："], ["AMMO TYPES", "弹药类型"], ["PICKUPSES", "掉落物"], ["GIVES", "给予"], ["OPENS WITH AS", "开启时产生"], ["BLASTS", "爆炸"], ["APPEARSES", "出现"], ["WHEN NEEDEDS", "需要时"], ["STOCKSES", "枪托"], ["ARES", "会"], ["TRIGGER-HAPPIES", "自动开火"], ["CAN CHARM MULTIPLE ENEMIESES", "可以魅惑多个敌人"], ["LASTS", "维持"], ["LONGERS", "更久"], ["INCOMING DAMAGES", "受到的伤害"], ["IS SPLITS", "由其分担"], ["WITHS", "与"], ["LIKE DISCS BUTS", "像圆盘，但比它"], ["SMARTERS", "聪明"], ["PARROTS RETRIEVES", "鹦鹉会取回"], ["HAMMERHEADS", "铁头"], ["RHINO SKINS", "犀牛皮"], ["EXTRA FEETS", "迅足"], ["PLUTONIUM HUNGERS", "钚能贪食"], ["RABBIT PAWS", "兔爪"], ["THRONE BUTTS", "王座之臀"], ["LUCKY SHOTS", "幸运一击"], ["BLOODLUSTS", "嗜血"], ["GAMMA GUTSES", "辐射之身"], ["SECOND STOMACHES", "第二胃袋"], ["BACK MUSCLES", "背肌强化"], ["SCARIER FACES", "惊悚面容"], ["EUPHORIAS", "欢欣"], ["LONG ARMSES", "长臂"], ["BOILING VEINSES", "热血沸腾"], ["SHOTGUN SHOULDERSES", "霰弹回旋"], ["RECYCLE GLANDSES", "回收腺体"], ["LASER BRAINS", "激光脑"], ["LAST WISHES", "最终心愿"], ["EAGLE EYESES", "鹰眼"], ["IMPACT WRISTSES", "超强腕力"], ["BOLT MARROWS", "追踪箭矢"], ["STRESSES", "紧张"], ["TRIGGER FINGERSES", "神速扳机"], ["SHARP TEETHS", "利齿"], ["PATIENCES", "耐心"], ["HAMMER HEADS", "铁头"], ["STRONG SPIRITS", "强韧灵魂"], ["OPEN MINDS", "开放思维"], ["HEAVY HEARTS", "沉重之心"], ["FOR BEATING THE AQUATIC ROUTES", "完成整条水域路线后解锁"], ["DONATES", "捐赠"], ["BLESSINGS", "祝福"], ["SHARES", "分享"], ["CHOOSES", "选择"], ["REVIVES", "复活"], ["ESCAPES", "逃离"], ["MOUNTS", "骑乘"], ["DISMOUNTS", "下坐骑"], ["WARPS", "跃迁"]]
    array_push(_rows,["COOLGUY","酷蛙"],["COOLGUY?","酷蛙？"])
    global.ntte_zh_dictionary={}
    for(var _i=0;_i<array_length(_rows);++_i) global.ntte_zh_dictionary[$ _rows[_i][0]]=_rows[_i][1]
}
