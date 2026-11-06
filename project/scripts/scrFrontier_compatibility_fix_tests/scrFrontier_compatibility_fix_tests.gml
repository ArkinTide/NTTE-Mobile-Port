// Execute the actual reported callback with and without an optional scorpion
// floor. Previously the ordinary desert pass threw before reaching its decal.
function scrFRMeteorScorpCompatTests() {
    var _parked=scrNTTEFullInstances([Floor,SnowFloor,Wall,TopSmall,TopPot,Bones,
        BigSkull,FRCustomObject,FRCustomProp,FRCustomHitme]),
        _area=GameCont.area,_seed=random_get_seed();
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    var _before=scrNTTEFullInstances(all);
    try {
        GameCont.area=area_desert;
        var _floor=instance_create(194000,194000,Floor),
            _decal=instance_create(194016,194016,Bones),
            _events=global.fr_module_vars[$ "mod:Frontier_Events"];
        _decal.name="NTTEBigDecal";
        for(var _pass=0;_pass<3;++_pass) {
            var _scorpion=_pass==1;
            _floor.sprite_index=_scorpion?frMacro_Frontier_Events_mod_gml__tespr.FloorScorpion:sprFloor1;
            scrFRInvokeHere(fr_Frontier_Events_mod_gml_MeteorShower_compatsprite,[]);
            var _expected=_scorpion?_events.sprCompatBigTopDecalDesertScorpion:_events.sprCompatBigTopDecalDesert;
            assert(_decal.sprite_index==_expected,
                "MeteorShower compatibility did not distinguish ordinary/scorpion desert decals");
        }
        scrNTTESmokeLog("PASS FRONTIER actual MeteorShower_compatsprite ordinary/scorpion/ordinary paths without uninitialized local");
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        GameCont.area=_area;random_set_seed(_seed);
    }
}

// Run the authored chest collision path, including its stored script reference.
// Calling ToolKitChest_open directly would miss the original dispatch failure.
function scrFRToolKitChestTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _player=instance_find(Player,0),_difficulty=GameCont.hard,_seed=random_get_seed(),
        _pickups=global.fr_module_vars[$ "mod:libPickups"],_chests=_pickups.libChests,
        _module="mod:Frontier_Pickups",_loaded=global.fr_initialized[$ _module];
    try {
        _player.x=195000;_player.y=195000;_player.speed=0;
        // At the minimum difficulty the source pool permits only the Wrench;
        // the other authored drop must always be its guaranteed Screwdriver.
        GameCont.hard=0;
        var _chest=scrFRModCallArray("mod","Frontier_Pickups","ToolKitChest_create",[_player.x,_player.y]);
        assert(instance_exists(_chest) && is_array(_chest.on_open)
            && !is_string(_chest.on_open[2]),"Toolkit fixture lost its actual stored source callback");
        global.fr_initialized[$ _module]=false;
        with(_chest) {
            var _ignored=scrFRModCallArray(on_open[0],on_open[1],on_open[2],[]);
            assert(is_undefined(_ignored),"Native callback bypassed its module's loaded-state gate");
        }
        global.fr_initialized[$ _module]=_loaded;
        with(_chest) scrFRInvokeHere(fr_dependencies_libPickups_mod_gml_LibChest_basestep,[]);
        assert(!instance_exists(_chest),"Actual source toolkit chest did not open on player collision");
        var _created=scrNTTEFullMergedRuntimeNew(_before),_count=0,_screwdriver=0,_wrench=0;
        for(var _i=0;_i<array_length(_created);++_i) {
            var _item=_created[_i];
            if(!instance_exists(_item) || !instance_is(_item,WepPickup)) continue;
            _count++;
            if(_item.wep==wep_screwdriver) _screwdriver++;
            if(_item.wep==wep_wrench) _wrench++;
            assert(_item.ammo==1 && _item.sprite_index==scr_weapon_get_sprite(_item.wep)
                && _item.name==scr_weapon_get_name(_item.wep),
                "Toolkit native pickup lost source weapon, ammo or artwork assignment");
        }
        assert(_count==2 && _screwdriver==1 && _wrench==1,
            "Authored toolkit callback was skipped or its guaranteed screwdriver/tool pool changed");
        scrNTTESmokeLog("PASS FRONTIER actual toolkit chest collision opens its stored callback and creates guaranteed Screwdriver plus source-pool Wrench");
    } finally {
        global.fr_initialized[$ _module]=_loaded;
        _pickups.libChests=_chests;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_players);
        GameCont.hard=_difficulty;random_set_seed(_seed);
    }
}
