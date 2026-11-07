function scrEnemyApplyCreationEffects() {
    // Frontier's native CustomEnemy is a one-HP carrier. Its real authored
    // maxhealth setter applies HP effects after its boss flag and stats exist.
    var _fr_custom=object_get_name(object_index)=="FRCustomEnemy"
    var _scarier=scr_skill_get(mut_scarier_face)
    var _defer_scarier=_scarier>0 && string_pos("NTTE",object_get_name(object_index))==1
    if(_defer_scarier) {
        ntte_full_scarier_creation_pending=true
        ntte_full_scarier_creation_count=_scarier
        ntte_full_scarier_creation_luck=false
    }
	if (!_fr_custom && scrGameIsCustomMode()) {
		var _m;
		
		if (scrEnemyIsBoss(id)) {
			_m = scrCustomParam("boss_health") / 100
		}
		else {
			_m = scrCustomParam("enemy_health") / 100
		}
		
		if (_m != 1) {
			max_hp = max(1, floor(max_hp * _m))
			if (hp > max_hp) hp = max_hp
		}
	}
	
	if (!_fr_custom && !_defer_scarier && _scarier) {
		hp = floor(hp * power(0.8,_scarier))
		
		if max_hp > hp {
			max_hp = hp
		}
	}
	
	if UberCont.hardmode {
		raddrop = floor(raddrop * 0.5)
	}
	
	if scrCrownCheck(crwn_blood) {
		raddrop -= 1
	}
	
	if !_fr_custom {
        // Keep the original native condition and roll order intact. The
        // separate carrier branch must skip the condition itself, including
        // its random call on runtimes without boolean short-circuiting.
        if scrCrownCheck(crwn_luck) && random(1) <= 0.1 && !scrEnemyIsBoss(id) {
            // Defer the result, not the original random roll. Altering HP
            // here would make the later Scary Face calculation shrink 1 to 0.
            if(_defer_scarier) ntte_full_scarier_creation_luck=true
            else hp = 1
        }
	}
}

function scrNTTEFullEnemyCreationHPFinish() {
    // Called only at the final leaf Create boundary. Inherited constructors
    // may replace health or derive a variant after enemy.Create returns.
    // Apply only the skipped HP mutation; never roll Luck or change drops.
    // GML's dynamic instance accessor raises for an absent field before ??
    // can supply a default. Every leaf calls here, including SF-free actors.
    if(!variable_instance_exists(id,"ntte_full_scarier_creation_pending")) return;
    if(!ntte_full_scarier_creation_pending) return;
    ntte_full_scarier_creation_pending=false;
    hp=floor(hp*power(0.8,ntte_full_scarier_creation_count))
    if(max_hp>hp) max_hp=hp
    if(ntte_full_scarier_creation_luck) hp=1
}

function scrEnemyIsBoss(_enemy) {
	gml_pragma("forceinline")
	// BEGIN NTTE SOURCE BOSS FLAG CLASSIFICATION
	return instance_exists(_enemy) && (variable_instance_exists(_enemy,"boss")
		? _enemy.boss : object_is_ancestor(_enemy.object_index, bossenemy))
	// END NTTE SOURCE BOSS FLAG CLASSIFICATION
}
