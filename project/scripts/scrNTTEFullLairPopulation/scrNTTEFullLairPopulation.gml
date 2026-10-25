function scrNTTEFullLairChance(_numerator,_denominator) { return random(_denominator)<_numerator }
function scrNTTEFullLairObjectIs(_object,_parent) { return _object==_parent || object_is_ancestor(_object,_parent) }

// lair.ntte_setup_Turret and EnemyBullet1 replacement. Native Turret does not
// use the generic projectile factory, so dispatch from its actual firing alarm.
function scrNTTEFullLairTurretSetup() {
    if (!variable_instance_exists(id,"lair_turret")) lair_turret=GameCont.area==scrNTTEFullAreaId("lair")
    if (!lair_turret) return;
    spr_idle=scrNTTERefSprite("LairTurretAppear"); spr_walk=scrNTTERefSprite("LairTurretIdle")
    spr_hurt=scrNTTERefSprite("LairTurretHurt"); spr_dead=scrNTTERefSprite("LairTurretDead")
    spr_fire=scrNTTERefSprite("LairTurretFire"); hitid=[spr_idle,"LAIR TURRET"]
    sprite_index=spr_idle
}

function scrNTTEFullLairTurretFire() {
    if (!scrNTTEFullValue(id,"lair_turret",false)) return false
    if (ammo<=0) { sprite_index=spr_idle; alarm[1]=10+random(5); return true }
    ammo-=1; alarm[2]=3; sprite_index=spr_fire; snd_play_hit_big(sndTurretFire,0.2)
    var _bullet=scr_damage_create(x,y,EnemyBullet2)
    with (_bullet) {
        motion_add(other.gunangle+orandom(4),8*timescale); image_angle=direction
        var _puff=instance_create(x,y,AcidStreak)
        with (_puff) {
            sprite_index=scrNTTERefSprite("AcidPuff"); image_angle=other.direction+orandom(30)
            depth=other.depth-(image_angle>=180)
            var _streak=instance_create(x,y,AcidStreak)
            _streak.depth=depth
            with (_streak) motion_add(other.image_angle,(2+random(2))*timescale)
        }
        snd_play_hit(sndFrogEggSpawn3,0.4)
    }
    return true
}

// Original lair.ntte_begin_step reward, applied after native LevCont has
// built its actual icons. Epsilon has no NTT mutbutton/maxselect/alarm0 layer:
// its source-equivalent operation is pruning eligible SkillIcons and running
// its real alignment event again after adding the sole Silver Tongue choice.
function scrNTTEFullLairBeginStep() {
    if(!scrNTTEFullValue(GameCont,"ntte_lairmut",false) || !instance_exists(LevCont)
        || GameCont.skillpoints<=0 || GameCont.crownpoints>0) return;
    GameCont.ntte_lairmut=false
    if(scrNTTEFullSkillGet(NTTEFullSkill.SilverTongue)!=0) return;
    with(SkillIcon) if(scrNTTEFullSkillAvailable(skill)) instance_destroy()
    var _number=0
    with(SkillIcon) num=++_number
    var _icon=instance_create(0,0,SkillIcon)
    _icon.creator=instance_find(LevCont,0);_icon.num=++_number;_icon.skill=NTTEFullSkill.SilverTongue
    with(LevCont) event_user(0)
}

function scrNTTEFullLairStep() {
    if(lockstep_stop) return;
    with(NTTECatGas) if(speed<0.1*timescale) growspeed-=random(0.002*timescale)
    with(Turret) if(spr_idle==scrNTTERefSprite("LairTurretAppear")) {
        if(image_index+image_speed>=image_number || sprite_index!=spr_idle) {
            spr_idle=sprTurretAppear
            event_perform(ev_other,ev_animation_end)
            spr_idle=scrNTTERefSprite("LairTurretIdle");spr_walk=spr_idle;spr_hurt=scrNTTERefSprite("LairTurretHurt")
        }
    }
}

// Original area_effect callbacks run from the native BackCont alarm, retaining
// the player's particles setting and native camera rather than a second timer.
function scrNTTEFullAreaEffect() {
    if(GameCont.area==scrNTTEFullAreaId("red")) { scrNTTEFullRedEffect(); return true }

    if(GameCont.area==scrNTTEFullAreaId("coast")) { scrNTTEFullCoastEffect(); return true }

    if(GameCont.area==scrNTTEFullAreaId("pizza")) { scrNTTEFullPizzaEffect(); return true }

    if(GameCont.area==scrNTTEFullAreaId("oasis")) { scrNTTEFullOasisEffect(); return true }

    var _key=scrNTTEFullAreaKey(GameCont.area)
    if(_key!="lair" && _key!="trench") return false
    alarm[0]=(_key=="lair" ? irandom_range(1,120):irandom_range(30,50))
    if(instance_exists(GenCont)) return true
    var _players=[]
    with(Player) if(scrNTTEFullPlayerActive(id)) array_push(_players,id)
    if(_key=="trench") {
        if(random(4)<1) with(NTTEFullPet) instance_create(x,y,Bubble)
        if(random(4)<1 && array_length(_players)>0) {
            for(var _i=0;_i<array_length(_players);++_i) with(_players[_i]) instance_create(x,y,Bubble)
            return true
        }
    }
    if(!array_length(_players)) return true
    var _seen=[]
    with(Floor) if(bbox_left<view_xview+view_width && bbox_right>view_xview
        && bbox_top<view_yview+view_height && bbox_bottom>view_yview) array_push(_seen,id)
    if(!array_length(_seen)) return true
    var _floor=_seen[irandom(array_length(_seen)-1)]
    instance_create(random_range(_floor.bbox_left,_floor.bbox_right),random_range(_floor.bbox_top,_floor.bbox_bottom)-(_key=="lair" ? 8:0),_key=="lair" ? Drip:Bubble)
    return true
}

function scrNTTEFullLairCreate(_x,_y,_kind) {
    if (!is_string(_kind) && object_exists(_kind)) return instance_create(_x,_y,_kind)
    switch(_kind) {
        case "ChairFront": case "ChairSide": case "Cabinet": case "Couch": case "Table":
            return scrNTTEFullLairPropCreate(_x,_y,_kind)
        case "NewTable": return scrNTTEFullLairPropCreate(_x,_y,"Table")
        case "CatLight": return scrNTTEFullLairLight(_x,_y)
        case "SewerRug":
            var _rug=instance_create(_x,_y,Carpet)
            _rug.sprite_index=scrNTTERefSprite("Rug"); _rug.image_index=(GameCont.area==area_pizza_sewers || GameCont.area==scrNTTEFullAreaId("pizza"))
            _rug.image_speed=0
            return _rug
        default: return scrNTTEFullSystemsCreate(_kind,_x,_y)
    }
}

function scrNTTEFullLairEnemies(_x,_y,_number) {
    var _kind=choose(NTTECat,NTTEBat)
    repeat(_number+round(random_range(1.5,2)*GameCont.loops)) instance_create(_x,_y,_kind)
}

// Real per-floor area callbacks, called by native population before its
// vanilla spawn-area switch. Keep the native driver for density/chests/IDPD.
function scrNTTEFullAreaPopEnemies(_area) {
    if(_area==scrNTTEFullAreaId("red")) { scrNTTEFullRedPopEnemies(); return true }

    if(_area==scrNTTEFullAreaId("coast")) { scrNTTEFullCoastPopEnemies(); return true }

    if(_area==scrNTTEFullAreaId("pizza")) { scrNTTEFullPizzaPopEnemies(); return true }

    if(_area==scrNTTEFullAreaId("oasis")) { scrNTTEFullOasisPopEnemies(); return true }

    if (_area==scrNTTEFullAreaId("trench")) { scrNTTEFullTrenchPopEnemies(); return true }
    if (_area!=scrNTTEFullAreaId("lair")) return false
    var _px=x+16,_py=y+16
    if (GameCont.loops>0 && random(4)<1) instance_create(_px,_py,styleb ? BecomeTurret:choose(Molesarge,Jock))
    if (!place_meeting(x,y,Wall) && random(20)<1) repeat(irandom_range(3,7)) instance_create(_px,_py,Rat)
    else if (random(8)<1) {
        var _cat=instance_create(_px,_py,NTTECat)
        if (random(2)<1) with (_cat) {
            scrNTTECatHide(); ntte_cat_cantravel=true; ntte_cat_timer=random_range(30,900)
        }
    }
    return true
}

function scrNTTEFullAreaPopProps(_area) {
    if(_area==scrNTTEFullAreaId("red")) { scrNTTEFullRedPopProps(); return true }

    if(_area==scrNTTEFullAreaId("coast")) { scrNTTEFullCoastPopProps(); return true }

    if(_area==scrNTTEFullAreaId("pizza")) { scrNTTEFullPizzaPopProps(); return true }

    if(_area==scrNTTEFullAreaId("oasis")) { scrNTTEFullOasisPopProps(); return true }

    if (_area==scrNTTEFullAreaId("trench")) { scrNTTEFullTrenchPopProps(); return true }
    if (_area!=scrNTTEFullAreaId("lair")) return false
    if (random(50)<1) scrNTTEFullAreaTopDecalCreate(x+16,y+16)
    return true
}

// tegeneral TopDecal_create: a factory function, not an actual named object.
function scrNTTEFullAreaTopDecalCreate(_x,_y) {
    var _object=noone,_sprite=-1
    switch(GameCont.area) {
        case area_campfire: _object=TopDecalNightDesert; break
        case area_desert: _object=TopDecalDesert; break
        case area_sewers: _object=TopDecalSewers; break
        case area_scrapyards: _object=TopDecalScrapyard; break
        case area_caves: _object=TopDecalCave; break
        case area_city: _object=TopDecalCity; break
        case area_palace: _object=TopDecalPalace; break
        case area_pizza_sewers: _object=TopDecalSewers; _sprite=sprTopDecalPizzaSewers; break
        case area_cursed_caves: _object=TopDecalCave; break
        case area_jungle: _object=TopDecalJungle; break
        case area_hq: _object=TopPot; break
        default:
            switch(scrNTTEFullAreaKey(GameCont.area)) {
                case "lair": _sprite=scrNTTERefSprite("TopDecalLair"); break
                case "trench": _sprite=scrNTTERefSprite("TopDecalTrench"); break
                case "pizza": _sprite=sprTopDecalPizzaSewers; break
            }
            if (sprite_exists(_sprite)) _object=TopPot
    }
    if (!object_exists(_object)) return noone
    var _decal=instance_create(_x,_y,_object)
    if (sprite_exists(_sprite)) {
        _decal.sprite_index=_sprite; _decal.image_speed=0; _decal.image_index=irandom(_decal.image_number-1)
        _decal.x=_x; _decal.y=_y
        with (_decal) event_perform_object(TopPot,ev_create,0)
    }
    if (GameCont.area==scrNTTEFullAreaId("trench") && random(6)<1 && point_distance(_decal.x,_decal.y,10016,10016)>128) {
        _decal.sprite_index=scrNTTERefSprite("TopDecalTrenchMine")
        var _mine=instance_create(_decal.x,_decal.y,NTTEFullTopDecalWaterMine); _mine.creator=_decal
    }
    return _decal
}

function scrNTTEFullLairPopExtras() {
    var _rooms=GameCont.ntte_full_lair_rooms
    for(var _i=0;_i<array_length(_rooms);++_i) {
        var _room=_rooms[_i]
        scrNTTEFullLairPopulateRoom(_room)
        for(var _j=0;_j<array_length(_room.floors);++_j) if (instance_exists(_room.floors[_j])) with (_room.floors[_j]) {
            if (!place_meeting(x,y,Wall) && !place_meeting(x,y,prop)) {
                if (random(16)<1 || (random(2)<1 && !array_length(scrNTTEFullRectInstances(x-96,y-96,x+96,y+96,NTTECatHole))))
                    instance_create(x+16,y+16,NTTECatHole)
            }
        }
    }
    var _floors=[]
    with (Floor) if (object_index==Floor && !styleb && !place_meeting(x,y,Wall)) array_push(_floors,id)
    if (array_length(_floors)>0) while(instance_number(enemy)<24) {
        var _floor=_floors[irandom(array_length(_floors)-1)]
        scrNTTEFullLairEnemies((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,1)
    }
    // Original CatDoor clean-up removes the precise wall behind the hinge,
    // then drops doors with floor extending through both sides of the seam.
    with (NTTEFullCatDoor) {
        var _angle=image_angle-90*image_yscale
        var _walls=scrNTTEFullRectInstances(x+lengthdir_x(8,_angle)+lengthdir_x(8,image_angle),
            y+lengthdir_y(8,_angle)+lengthdir_y(8,image_angle),
            x+lengthdir_x(8,_angle)+lengthdir_x(8,image_angle),
            y+lengthdir_y(8,_angle)+lengthdir_y(8,image_angle),Wall)
        for(var _i=0;_i<array_length(_walls);++_i) instance_destroy(_walls[_i])
        var _floor=collision_point((bbox_left+bbox_right)/2,bbox_bottom-6,Floor,false,false)
        if (instance_exists(_floor)) {
            var _delete=false
            for(var _i=0;_i<=180;_i+=180) {
                var _a=image_angle-90+_i
                if (position_meeting(_floor.x+lengthdir_x(32,_a),_floor.y+lengthdir_y(32,_a),Floor)) { _delete=true; break }
            }
            if (_delete) instance_destroy(id,false)
        }
    }
    // lair.area_pop_extras uses telib's dense, nearest-space wall search.
    with (enemy) scrNTTEFullWorldBudge(id,Wall)
    with (chestprop) scrNTTEFullLairLight(x,y-28)
    with (RadChest) scrNTTEFullLairLight(x,y-28)
    scrNTTEFullLairLight(10016,10016-48,true)
}

// telib.chest_create levelStart semantics, used by the original Lair room_pop.
// It is independent of ordinary level chest generation and never replaces a
// missing mod chest with a vanilla one. Crown of Love replacements are source.
function scrNTTEFullLairChestCreate(_x,_y,_object,_level_start=false) {
    // Current runners use typed asset references, which are valid objects but
    // do not pass is_real(). Keep source names separate from native assets.
    var _is_object=!is_string(_object) && object_exists(_object)
    if (is_string(_object) || (_is_object && (scrNTTEFullLairObjectIs(_object,chestprop) || scrNTTEFullLairObjectIs(_object,RadChest)
        || scrNTTEFullLairObjectIs(_object,Mimic) || scrNTTEFullLairObjectIs(_object,SuperMimic)))) {
        if (_is_object && scrNTTEFullLairObjectIs(_object,RadChest)) {
            if (_level_start) {
                for(var _i=0;_i<player_count;++_i) {
                    var _p=global.playerinstance_list[_i]
                    if (is_struct(_p) && _p.race==Race.Rogue) { _object=RogueChest; break }
                }
                if (random(2)<1) with (Player) if (hp<(max_hp+headloses)/2) { _object=HealthChest; break }
                if (instance_number(Player)<player_count) _object=HealthChest
            }
            if (random(3)<2 && scrCrownCheck(crwn_life)) _object=HealthChest
        }
        if (scrCrownCheck(crwn_love) && !(!is_string(_object) && object_exists(_object) && scrNTTEFullLairObjectIs(_object,AmmoChest))) {
            var _exceptions=[ProtoChest,RogueChest,"Backpack","BeetleChest","BonusAmmoChest","BonusAmmoMimic",
                "BuriedVaultChest","CatChest","CursedAmmoChest","CursedMimic","SunkenChest"]
            if (array_get_index(_exceptions,_object)<0) {
                var _name=is_string(_object) ? _object:object_get_name(_object)
                if (string_pos("Mimic",_name)>0) _object=Mimic
                else if (string_pos("Giant",_name)>0) _object=GiantAmmoChest
                else _object=AmmoChest
            }
        }
        if (_level_start) {
            if (random(4)<GameCont.nochest && _object==WeaponChest) _object=BigWeaponChest
            if (GameCont.area>=2 || GameCont.loops>=1) {
                if (random(11)<1 && !is_string(_object) && object_exists(_object) && scrNTTEFullLairObjectIs(_object,AmmoChest)) _object=Mimic
                if (random(51)<1 && !is_string(_object) && object_exists(_object) && scrNTTEFullLairObjectIs(_object,HealthChest)) _object=SuperMimic
            }
        }
    }
    // NTTE calls this counter `norads`; the native Epsilon GameCont stores
    // the same previous-level rad-chest count as `noradch`.
    var _snapshot=scrNTTEFullInstances(all),_rad=GameCont.noradch,_health=[]
    if (!_level_start) {
        GameCont.noradch=0
        with (Player) { array_push(_health,[id,hp]); hp=max_hp }
    }
    var _instance=is_string(_object) ? scrNTTEFullSystemsCreate(_object,_x,_y):instance_create(_x,_y,_object)
    if (!_level_start) {
        GameCont.noradch=_rad
        for(var _i=0;_i<array_length(_health);++_i) if (instance_exists(_health[_i][0])) _health[_i][0].hp=_health[_i][1]
    }
    if (!instance_exists(_instance)) {
        var _after=scrNTTEFullInstances([chestprop,RadChest,Mimic,SuperMimic])
        for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0
            && (!instance_exists(_instance) || _after[_i].id<_instance.id)) _instance=_after[_i]
    }
    return _instance
}

// Exact room_pop layout transcription from areas/lair.area.gml:804..1190.
function scrNTTEFullLairPopulateRoom(_room) {
 with (_room) {

	var	_x = 10000 + (x * 32), // Left
		_y = 10000 + (y * 32), // Top
		_w = w * 32, // Width
		_h = h * 32, // Height
		_cx = _x + (_w / 2), // Center X
		_cy = _y + (_h / 2); // Center Y
		
	switch(type){
		
		/// IMPORTANT ROOMS
		case "Start":
			
			scrNTTEFullLairCreate( _cx, _cy, "SewerRug");
			
			break;
			
		case "Boss":
			
			scrNTTEFullLairCreate( _cx, _cy, "CatHoleBig");
			
			 // Corner Columns:
			instance_create(_x + 80,      _y + 80,      Wall);
			instance_create(_x + _w - 96, _y + 80,      Wall);
			instance_create(_x + 80,      _y + _h - 96, Wall);
			instance_create(_x + _w - 96, _y + _h - 96, Wall);
			
			 // Spawn backup chests
			var	_chest = ["CatChest", "BatChest", ((GameCont.loops > 0) ? "RatChest" : RadChest)],
				_dis   = 176,
				_dir   = round(random(360)/90)*90;
				
			for(var i = 0; i < array_length(_chest); i++){
				scrNTTEFullLairChestCreate( 
					_cx + lengthdir_x(_dis, _dir + (i * 90)),
					_cy + lengthdir_y(_dis, _dir + (i * 90)),
					_chest[i],
					true
				);
			}
			
			break;
			
		/// SMALL ROOMS
		case "SmallClutter":
			
			 // Props:
			repeat(irandom_range(2, 4)){
				scrNTTEFullLairCreate( 
					_cx + orandom(24),
					_cy + orandom(24),
					choose("ChairFront", "ChairSide", "Table", "Cabinet")
				);
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, irandom(3));
			
			break;
			
		case "MediumClutter":
			
			 // Props:
			repeat(irandom_range(2, 6)){
				scrNTTEFullLairCreate( 
					_cx + orandom(32),
					_cy + orandom(32),
					choose("ChairFront", "ChairSide", "Table", "Cabinet")
				);
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, irandom(5));
			
			break;
			
		case "SmallPillars":
			
			 // Walls:
			instance_create(_x + 16,      _y + 16,      Wall);
			instance_create(_x + _w - 32, _y + 16,      Wall);
			instance_create(_x + 16,      _y + _h - 32, Wall);
			instance_create(_x + _w - 32, _y + _h - 32, Wall);
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1);
			
			break;
			
		case "SmallRing":
		case "WideSmallRing":
		case "TallSmallRing":
		case "MediumRing":
			
			 // Center Walls:
			instance_create(_cx - 16, _cy - 16, Wall);
			instance_create(_cx - 16, _cy,      Wall);
			instance_create(_cx,      _cy - 16, Wall);
			instance_create(_cx,      _cy,      Wall);
			
			 // Enemies:
			switch(type){
				case "WideSmallRing":
					scrNTTEFullLairEnemies(_cx + choose(-32, 32), _cy, 1);
					break;
					
				case "TallSmallRing":
					scrNTTEFullLairEnemies(_cx, _cy + choose(-32, 32), 1);
					break;
			}
			
			break;
			
		case "Table":
			
			 // Props:
			with(scrNTTEFullLairCreate( _cx, _cy, "NewTable")){
				if(scrNTTEFullLairChance(4, 5)){
					scrNTTEFullLairCreate( x + orandom(2), y - 18 + orandom(2), "ChairFront");
				}
				scrNTTEFullLairCreate( x, y - 32, "CatLight");
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1 + irandom(2));
			
			break;
			
		case "Toilet":
			
			 // Walls:
			for(var _oy = 0; _oy <= 1; _oy++){
				instance_create(_x + 32, _y + (_oy * 16), Wall);
			}
			instance_create(_x + _w - 16, _y + 48, Wall);
			
			 // Props:
			with(scrNTTEFullLairCreate( _x + 16 + orandom(2), _y + 12, "ChairFront")){
				with(scrNTTEFullLairCreate( x, y - 28, "CatLight")){
					sprite_index = scrNTTERefSprite("CatLightThin");
				}
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_x, _y, 1);
			
			break;
			
		case "SmallTriangle":
			
			 // Walls:
			for(var _off = 0; _off < min(_w, _h); _off += 32){
				instance_create(_x + _off + 16, _y + _off, Wall);
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1 + irandom(1));
			
			break;
			
		case "Vault":
			
			 // Corner Walls:
			instance_create(_x,           _y,           Wall);
			instance_create(_x + _w - 16, _y,           Wall);
			instance_create(_x,           _y + _h - 16, Wall);
			instance_create(_x + _w - 16, _y + _h - 16, Wall);
			
			 // Valuables:
			var	_ang = random(360),
				_num = random_range(2, 4);
				
			for(var d = _ang; d < _ang + 360; d += (360 / _num)){
				var	l = random(24),
					_px = _cx + lengthdir_x(l, d),
					_py = _cy + lengthdir_y(l, d);
					
				if(scrNTTEFullLairChance(1, 4)){
					scrNTTEFullLairChestCreate( _px, _py, "PizzaChest", true);
				}
				else scrNTTEFullLairCreate( _px, _py, choose("PizzaStack", "PizzaStack", MoneyPile));
			}
			
			 // Center Floor:
			for(var _f = 0; _f < array_length(floors); ++_f) with(floors[_f]) if(position_meeting(_cx, _cy, id)){
				sprite_index = sprFloor102B;
				material = 6;
			}
			
			break;
			
		/// LARGE ROOMS
		case "SmallAtrium":
			
			 // Walls:
			for(var _ox = -40; _ox <= 40; _ox += 80){
				for(var _oy = -40; _oy <= 40; _oy += 80){
					instance_create(_cx + _ox - 8,                    _cy + _oy - 8,                    Wall);
					instance_create(_cx + _ox - 8 - (16 * sign(_ox)), _cy + _oy - 8,                    Wall);
					instance_create(_cx + _ox - 8,                    _cy + _oy - 8 - (16 * sign(_oy)), Wall);
				}
			}
			
			 // Center Walls:
			instance_create(_cx - 16, _cy - 16, Wall);
			instance_create(_cx - 16, _cy,      Wall);
			instance_create(_cx,      _cy - 16, Wall);
			instance_create(_cx,      _cy,      Wall);
			
			 // Enemies & Lights:
			for(var d = 0; d <= 360; d += 90){
				var	_ox = _cx + lengthdir_x((_w / 2) - 24, d),
					_oy = _cy + lengthdir_y((_h / 2) - 24, d);
					
				scrNTTEFullLairEnemies(_ox, _oy, 1 + irandom(1));
				
				 // Lights:
				with(scrNTTEFullLairCreate( _ox, _oy - 48, "CatLight")){
					image_yscale *= 1.5;
				}
			}
			
			break;
			
		case "Lounge":
			
			 // Walls:
			instance_create(_x + 32,      _y,           Wall);
			instance_create(_x + 32,      _y + _h - 48, Wall);
			instance_create(_x + _w - 48, _y,           Wall);
			instance_create(_x + _w - 48, _y + _h - 48, Wall);
			
			 // Props:
			with(scrNTTEFullLairCreate( _cx + orandom(2), _y + 16 + orandom(2), "Couch")){
				scrNTTEFullLairCreate( x + orandom(2), y + 20 + orandom(2), "NewTable");
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _y + 16, 2);
			
			break;
			
		case "Dining":
			
			 // Props:
			with(scrNTTEFullLairCreate( _cx, _cy, "NewTable")){
				for(var _side = -1; _side <= 1; _side += 2){
					with(scrNTTEFullLairCreate( x + (24 * _side), y + orandom(2), "ChairSide")){
						image_xscale = _side;
					}
					scrNTTEFullLairCreate( x + (12 * _side), y - 18 + orandom(2), "ChairFront");
				}
				scrNTTEFullLairCreate( x, y - 32, "CatLight");
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1 + irandom(1));
			
			break;
			
		case "Cafeteria":
			
			 // Walls:
			for(var _oy = 1; _oy <= 2; _oy++){
				instance_create(_x,           _y + (_oy * 16) + 32,      Wall);
				instance_create(_x + _w - 16, _y + (_oy * 16) + 32,      Wall);
				instance_create(_x,           _y - (_oy * 16) + _h - 16, Wall);
				instance_create(_x + _w - 16, _y - (_oy * 16) + _h - 16, Wall);
			}
			
			/// Props:
				
				 // Vending machine:
				with(instance_create(_x + 48, _y + 16, SodaMachine)){
					spr_idle = scrNTTERefSprite("SodaMachineIdle");
					spr_hurt = scrNTTERefSprite("SodaMachineHurt");
					spr_dead = scrNTTERefSprite("SodaMachineDead");
					sprite_index = spr_idle;
				}
				
				 // Tables & Chairs:
				for(var _oy = 80; _oy < _h - 32; _oy += 32){
					with(scrNTTEFullLairCreate( _cx + orandom(2), _y + _oy + orandom(2), "NewTable")){
						 // Chairs:
						for(var _side = -1; _side <= 1; _side += 2){
							if(scrNTTEFullLairChance(2, 5)){
								with(scrNTTEFullLairCreate( x + (20 * _side) + orandom(2), y + orandom(2), "ChairSide")){
									image_xscale = _side;
								}
							}
						}
						if(scrNTTEFullLairChance(2, 5)){
							scrNTTEFullLairCreate( x + orandom(2), y - 14 + orandom(2), "ChairFront");
						}
						
						 // Lights:
						if(scrNTTEFullLairChance(2, 3)){
							scrNTTEFullLairCreate( x, y - 32, "CatLight");
						}
					}
				}
				
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 3 + irandom(1));
			
			break;
			
		case "Office":
			
			 // Walls:
			instance_create(_x + 16,      _y + 32,      Wall);
			instance_create(_x + _w - 32, _y + 32,      Wall);
			instance_create(_x + 16,      _y + _h - 16, Wall);
			instance_create(_x + _w - 32, _y + _h - 16, Wall);
			
			 // Props:
			with(scrNTTEFullLairCreate( _cx + orandom(2), _y + 26 + orandom(2), "NewTable")){
				scrNTTEFullLairCreate( 
					x + orandom(4),
					y - 16 + orandom(2),
					choose("ChairFront", "ChairFront", "ChairSide")
				);
				
				 // Cabinets:
				for(var _side = -1; _side <= 1; _side += 2){
					scrNTTEFullLairCreate( _cx + (_side * ((_w / 2) - 48)), _y + 42 + orandom(2), "Cabinet");
				}
				
				 // Light:
				scrNTTEFullLairCreate( x, y - 30, "CatLight");
			}
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1 + irandom(1));
			
			break;
			
		case "Garage":
			
			 // Walls:
			instance_create(_cx - 16, _y,           Wall);
			instance_create(_cx,      _y,           Wall);
			instance_create(_cx - 16, _y + _h - 16, Wall);
			instance_create(_cx,      _y + _h - 16, Wall);
			
			/// Props:
				
				 // Cars:
				for(var _oy = 32; _oy < _h; _oy += 32){
					instance_create(_x + 32 + orandom(2), _y + _oy + orandom(2), Car);
				}
				
				 // Tires:
				repeat(2){
					scrNTTEFullLairCreate( 
						_cx + irandom_range(24, (_w / 2) - 10),
						_y  + irandom_range(16, _h - 24),
						(scrNTTEFullLairChance(1, 10) ? choose("ChairFront", "ChairSide") : Tires)
					);
				}
				
				 // Lights:
				for(var _side = -1; _side <= 1; _side += 2){
					scrNTTEFullLairCreate( _cx + (((_w / 2) - 24) * _side), _cy - 32, "CatLight");
				}
				
			 // Enemies:
			scrNTTEFullLairEnemies(_cx, _cy, 1);
			
			break;
			
		case "LargeRing":
			
			 // Walls:
			instance_create(_cx - 32, _cy - 32, Wall);
			instance_create(_cx - 32, _cy + 16, Wall);
			instance_create(_cx + 16, _cy - 32, Wall);
			instance_create(_cx + 16, _cy + 16, Wall);
			
			 // Enemies:
			scrNTTEFullLairEnemies(_cx - 64, _cy - 64, 1);
			scrNTTEFullLairEnemies(_cx + 64, _cy - 64, 1);
			scrNTTEFullLairEnemies(_cx - 64, _cy + 64, 1);
			scrNTTEFullLairEnemies(_cx + 64, _cy + 64, 1);
			
			break;
	}
	

 }
}
