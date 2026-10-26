// Scalar metadata is transcribed from the six original area modules. Geometry,
// encounters, transitions and rendering are separate implementations; allocating
// an ID here does not enable an unfinished area in normal runs.
function scrNTTEFullAreaInfo(_key) {
    if(is_real(_key)) _key=scrNTTEFullAreaKey(_key);
    switch(_key) {
        case "undergrowth": return {key:"undergrowth",area_id:207,subareas:1,goal:120,next_area:area_jungle,next_subarea:1,background:make_color_rgb(102,78,24),shadow:make_color_rgb(28,0,14),ambient:amb4,music:musUGUndergrowth,music_b:musUGUndergrowth,boss_music:"",boss_intro:""};
        case "coast": return {key:"coast",area_id:201,subareas:3,goal:100,next_area:202,next_subarea:1,
            background:make_color_rgb(42,145,205),shadow:c_black,ambient:amb0b,
            music:"mus.Coast",music_b:"mus.CoastB",boss_music:"mus.SealKing",boss_intro:""};
        case "oasis": return {key:"oasis",area_id:202,subareas:1,goal:130,next_area:area_scrapyards,next_subarea:3,
            background:#51d1c8,shadow:c_black,ambient:amb101,
            music:mus101,music_b:mus101,boss_music:"",boss_intro:""};
        case "pizza": return {key:"pizza",area_id:203,subareas:1,goal:50,next_area:area_scrapyards,next_subarea:1,
            background:#a04b63,shadow:#120014,ambient:amb102,
            music:mus102,music_b:mus102,boss_music:"",boss_intro:""};
        case "lair": return {key:"lair",area_id:204,subareas:1,goal:100,next_area:area_scrapyards,next_subarea:1,
            background:make_color_rgb(160,157,75),shadow:#120014,ambient:amb102,
            music:"mus.Lair",music_b:"mus.Lair",boss_music:"mus.BigShots",boss_intro:"mus.BigShotsIntro"};
        case "trench": return {key:"trench",area_id:205,subareas:3,goal:150,next_area:area_city,next_subarea:1,
            background:make_color_rgb(100,114,127),shadow:c_black,ambient:amb101,
            music:"mus.Trench",music_b:"mus.TrenchB",boss_music:"mus.PitSquid",boss_intro:"mus.PitSquidIntro"};
        case "red": return {key:"red",area_id:206,subareas:1,goal:60,next_area:206,next_subarea:1,
            background:make_color_rgb(235,0,67),shadow:make_color_rgb(16,0,24),ambient:amb104,
            music:"mus.Red",music_b:"mus.Red",boss_music:"mus.Tesseract",boss_intro:"mus.TesseractIntro"};
    }
    return undefined;
}
function scrNTTEFullAreaId(_key) {
    var _info=scrNTTEFullAreaInfo(_key);
    if(is_undefined(_info)) throw "NTTE unknown custom area: "+string(_key);
    return _info.area_id;
}
function scrNTTEFullAreaKey(_area) {
    switch(_area) {
        case 201: return "coast";
        case 202: return "oasis";
        case 203: return "pizza";
        case 204: return "lair";
        case 205: return "trench";
        case 206: return "red";
        case 207: return "undergrowth";
    }
    return "";
}
// Original areas/{coast,oasis,pizza,lair,trench,red}.area.gml area_name.
// Shared by the live HUD, roadmap, statistics and Red Warp prompts.
function scrNTTEFullAreaMapLabel(_area,_subarea) {
    var _key=is_string(_area)?_area:scrNTTEFullAreaKey(_area)
    switch(_key) {
        case "coast":return "@1("+string(scrNTTERefSprite("RouteIcon"))+":0)1-"+string(_subarea<=0?"?":_subarea);
        case "oasis":return "@1("+string(scrNTTERefSprite("RouteIcon"))+":0)2-"+string(_subarea);
        case "undergrowth":return "???";
        case "pizza":return "2-@2(sprSlice:0)";
        case "lair":return "2-?";
        case "trench":return "@1("+string(scrNTTERefSprite("RouteIcon"))+":0)3-"+string(_subarea);
        case "red":return "@(color:"+string(scrAreaGetBackroundColor(206))+")@3("+string(scrNTTERefSprite("RedText"))+":-0.8)";
    }
    return undefined;
}
function scrNTTEFullAreaMetadataTests() {
    // Original helpers use numeric booleans, e.g. motion_step(self,-1).
    // Check actual VM branching rather than borrowing another language's
    // nonzero truth rule when transcribing these callbacks.
    var _inputs=[-1,0,0.25,0.5,1],_truths=[];
    for(var _j=0;_j<array_length(_inputs);++_j) {
        var _numeric=_inputs[_j],_truth=false;
        if(_numeric) _truth=true;
        array_push(_truths,_truth);
    }
    scrNTTESmokeLog("GML NUMERIC BOOLEAN DIAG "+json_stringify(_truths));
    assert(!_truths[0] && !_truths[1] && !_truths[2] && !_truths[3] && _truths[4],
        "Native GML numeric boolean semantics changed source helper branching");
    var _keys=["coast","oasis","pizza","lair","trench","red"];
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_info=scrNTTEFullAreaInfo(_key);
        if(_info.area_id!=201+_i || scrNTTEFullAreaKey(_info.area_id)!=_key) throw "NTTE area registry mismatch";
        if(scrAreaGetMaxSubarea(_info.area_id)!=_info.subareas) throw "NTTE custom subarea hook missing";
        if(scrAreaGetBackroundColor(_info.area_id,false)!=_info.background) throw "NTTE custom background hook missing";
        if(scrAreaGetShadowColor(_info.area_id,false)!=_info.shadow) throw "NTTE custom shadow hook missing";
    }
    if(!is_undefined(scrNTTEFullAreaInfo(area_oasis))) throw "Native oasis ID was overwritten";
    scrNTTESmokeLog("PASS six custom-area metadata identities; generation not covered");
}

// area_sprite and area_setup_floor from the six original area modules.
function scrNTTEFullAreaFloorSprite(_area,_style=false,_explo=false) {
    if(_area==207) return _explo?sprUGFloorUndergrowthExplo:(_style?sprUGFloorUndergrowthB:sprUGFloorUndergrowth);
    switch(scrNTTEFullAreaKey(_area)) {
        case "coast": return _explo?sprFloor1Explo:scrNTTERefSprite(_style?"FloorCoastB":"FloorCoast");
        case "oasis": return _explo?sprFloor101Explo:(_style?sprFloor101B:sprFloor101);
        case "pizza": return _explo?sprFloor102Explo:(_style?sprFloor102B:sprFloor102);
        case "lair": return scrNTTERefSprite(_explo?"FloorLairExplo":(_style?"FloorLairB":"FloorLair"));
        case "trench": return scrNTTERefSprite(_explo?"FloorTrenchExplo":(_style?"FloorTrenchB":"FloorTrench"));
        case "red": return scrNTTERefSprite(_explo?"FloorRedExplo":(_style?"FloorRedB":"FloorRed"));
    }
    return -1;
}
function scrNTTEFullAreaFloorSetup(_area,_explo=false) {
    area=_area;
    traction=1;
    var _sprite=scrNTTEFullAreaFloorSprite(_area,styleb,_explo);
    if(_sprite<0) return;
    sprite_index=_sprite;
    if(_explo) return;
    switch(scrNTTEFullAreaKey(_area)) {
        case "undergrowth":material=styleb?1:4;if(styleb) depth=8;break;
        case "coast": material=1; break;
        case "oasis": material=styleb?4:1; if(styleb) depth=8; break;
        case "pizza": material=styleb?6:2; if(styleb) depth=8; break;
        case "lair": material=styleb?3:2; if(styleb) depth=8; break;
        case "trench": material=styleb?0:4; if(styleb) { depth=9; traction=0.1; } break;
        case "red": material=2; if(styleb) depth=8; break;
    }
}
function scrNTTEFullAreaDetailSprite(_area) {
    if(_area==207) return sprUGDetailUndergrowth;
    switch(scrNTTEFullAreaKey(_area)) {
        case "coast": return scrNTTERefSprite("DetailCoast");
        case "oasis": return sprDetail101;
        case "pizza": return sprDetail102;
        case "lair": return scrNTTERefSprite("DetailLair");
        case "trench": return scrNTTERefSprite("DetailTrench");
        case "red": return scrNTTERefSprite("DetailRed");
    }
    return -1;
}
function scrNTTEFullAreaWallSprite(_area,_part) {
    if(_area==207) { switch(_part) {case "Top":return sprUGWallUndergrowthTop;case "Bot":return sprUGWallUndergrowthBot;case "Out":return sprUGWallUndergrowthOut;case "Trans":return sprUGWallUndergrowthTrans;case "Debris":return sprUGDebrisUndergrowth;} }
    var _key=scrNTTEFullAreaKey(_area),_base=_area,_name="";
    switch(_key) {
        case "coast": _base=1; break;
        case "oasis": _base=101; break;
        case "pizza": _base=102; break;
        case "lair": _name="Lair"; break;
        case "trench": _name="Trench"; break;
        case "red": _name="Red"; break;
    }
    if(_name!="") return scrNTTERefSprite(_part=="Debris"?"Debris"+_name:"Wall"+_name+_part);
    return asset_get_index(_part=="Debris"?"sprDebris"+string(_base):"sprWall"+string(_base)+_part);
}
function scrNTTEFullAreaTerrainSmoke() {
    var _keys=["coast","oasis","pizza","lair","trench","red"],_oldarea=GameCont.area;
    scrNTTESmokeLog("AREA TERRAIN CONTEXT DIAG "+json_stringify({area:GameCont.area,
        subarea:GameCont.subarea,lastarea:GameCont.lastarea,
        coastActive:scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)}));
    var _materials=[[1,1],[1,4],[2,6],[2,3],[4,0],[2,2]];
    for(var _i=0;_i<6;++_i) {
        GameCont.area=scrNTTEFullAreaId(_keys[_i]);
        var _f=instance_create(28000+64*_i,28000,Floor);
        assert(_f.area==GameCont.area && _f.sprite_index==scrNTTEFullAreaFloorSprite(GameCont.area),"Custom area floor creation lost original art/area metadata");
        assert(_f.material==_materials[_i][0],"Custom area ordinary floor material differs from source");
        _f.styleb=true;
        with(_f) scrNTTEFullAreaFloorSetup(area);
        assert(_f.sprite_index==scrNTTEFullAreaFloorSprite(GameCont.area,true) && _f.material==_materials[_i][1],"Custom area styled floor art/material differs from source");
        if(_keys[_i]=="trench") assert(_f.depth==9 && _f.traction==0.1,"Trench pit floor lost depth/traction");
        var _detail=instance_create(_f.x+16,_f.y+16,Detail);
        if(instance_exists(_detail)) {
            assert(_detail.sprite_index==scrNTTEFullAreaDetailSprite(GameCont.area),"Custom area detail artwork differs from source");
            instance_destroy(_detail,false);
        }
        assert(sprite_exists(scrNTTEFullAreaFloorSprite(GameCont.area,false,true)),"Custom area destroyed-floor art missing");
        instance_destroy(_f,false);
        var _wall=instance_create(28000+64*_i,28200,Wall);
        assert(instance_exists(_wall),"Area terrain fixture Wall was removed by an active runtime area constructor: "+_keys[_i]);
        assert(_wall.sprite_index==scrNTTEFullAreaWallSprite(GameCont.area,"Bot")
            && _wall.topspr==scrNTTEFullAreaWallSprite(GameCont.area,"Top")
            && _wall.outspr==scrNTTEFullAreaWallSprite(GameCont.area,"Out"),"Custom area wall sprite fields did not use original area mapping");
        instance_destroy(_wall,false);
        var _top=instance_create(28000+64*_i,28264,TopSmall);
        assert(instance_exists(_top) && _top.sprite_index==scrNTTEFullAreaWallSprite(GameCont.area,"Trans"),"Custom area transparent wall art missing");
        instance_destroy(_top,false);
        var _debris=instance_create(28000+64*_i,28328,Debris);
        assert(_debris.sprite_index==scrNTTEFullAreaWallSprite(GameCont.area,"Debris"),"Custom area debris art missing");
        instance_destroy(_debris,false);
    }
    GameCont.area=_oldarea;
    scrNTTESmokeLog("PASS six custom area terrain art/material/area metadata and trench pit depth/traction @"+string(30/timescale));
}

// Normal GenCont follows the same callbacks as the source's custom areas.
// The in-room generator owns its synchronous callback sequence separately.
function scrNTTEFullAreaGeneratorOnCreate() {
    // Compatibility wrapper. Real GenCont uses these explicit boundaries.
    scrNTTEFullAreaGeneratorPrepare();
    scrNTTEFullWorldEventsNativeSetup(id);
    scrNTTEFullAreaGeneratorBuild();
}
function scrNTTEFullAreaGeneratorPopulate() {
    var _builder=scrNTTEFullAreaNativeBuilder(GameCont.area);
    if(!is_struct(_builder)) return false;
    var _cb=method(id,_builder.populate); _cb();
    return true;
}
function scrNTTEFullAreaGeneratorStart() {
    if(scrNTTEFullValue(id,"ntte_full_sync_generation",false)) return;
    var _builder=scrNTTEFullAreaNativeBuilder(GameCont.area);
    if(is_struct(_builder) && is_callable(_builder.start)) { var _cb=method(id,_builder.start); _cb(); }
}

// NTTE CUSTOM AREA UPDATE CONSUMER BEGIN
// ntte.mod begin_step3063..3080. CoastTransit is the only source flag writer.
// Native RoomEnd already records the final destination in the waypoint arrays
// used by scrNTTEFullRoadmapData; no second history alias is needed here.
function scrNTTEFullCustomAreaUpdateBeginStep() {
    if(!instance_exists(GameCont) || lockstep_stop) return;
    if(!scrNTTEFullValue(GameCont,"ntte_area_update",false)) return;
    GameCont.ntte_area_update=false;
    with(GameCont) {
        if(subarea==1 && scrNTTEFullAreaKey(area)!="") {
            // Source chance(1,20) consumes one draw even at low HP/vault cap.
            var _selected=random(20)<1;
            if(!_selected) with(Player) if(hp<=1) { _selected=true; break; }
            if(_selected && crownvisits<3) proto=true;
        }
    }
}
// NTTE CUSTOM AREA UPDATE CONSUMER END
