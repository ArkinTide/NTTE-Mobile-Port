// ntte1299..1383,3836..3858,5679..5707. Guarded artifact room and its
// actual staircase controller. Natural post-generation hook is owned by root.
function scrNTTEFullQuestPointInFloors(_x,_y,_floors) {
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i]
        if(instance_exists(_f) && _x>=_f.bbox_left && _x<_f.bbox_right && _y>=_f.bbox_top && _y<_f.bbox_bottom) return true
    }
    return false
}
function scrNTTEFullQuestPalaceAtAnchor(_anchor) {
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST PROVIDER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProvider(_anchor); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST PROVIDER
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST PROVIDER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProvider(_anchor); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST PROVIDER
    if(!instance_exists(_anchor) || !scrNTTEFullQuestArtifactAvailable(1)) return undefined
    array_push(GameCont.ntte_quest_spawned_part_index_list,1)
    // FloorNormal assigned to a variable in NTT is a snapshot: a live query
    // here would terminate the hallway on its own newly-created shrine tiles.
    var _old=scrNTTEFullInstances(Floor,true),_room=undefined,_stairs=[]
    scrNTTEFullFloorSetAlign(32,32)
    try {
        _room=scrNTTEFullFloorRoomCreate(_anchor.x,_anchor.y,4,4,"",90,0,256)
        for(var _i=0;_i<array_length(_room.floors);++_i) _room.floors[_i].sprite_index=scrNTTERefSprite("FloorPalaceShrine")
        var _hx=_room.x+choose(-16,16),_hy=_room.y2-16
        while(_room.ystart-_hy>16 && !scrNTTEFullQuestPointInFloors(_hx,_hy,_old)) {
            if(!scrNTTEFullQuestPointInFloors(_hx,_hy,scrNTTEFullInstances(Floor,true))) {
                var _f=scrNTTEFullFloorSet(_hx-16,_hy-16,true)
                _f.sprite_index=scrNTTERefSprite("FloorPalaceStairs");_f.image_index=1;_f.depth=8
                array_push(_stairs,instance_create(_f.x,_f.y-5,NTTEFullPalaceStairs))
            }
            _hy+=32
        }
        var _center=scrNTTEFullFloorFill(_room.x,_room.y,2,2),_pillars=[]
        for(var _i=0;_i<array_length(_center);++_i) {
            _center[_i].sprite_index=scrNTTERefSprite("FloorPalaceShrineRoomSmall");_center[_i].image_index=_i
        }
        for(var _i=0;_i<4;++_i) if(irandom(3)<3)
            array_push(_pillars,scrNTTEFullWorldCreateRequired("QuestPillar",lerp(_room.x1+16,_room.x2-16,_i div 2),lerp(_room.y1+16,_room.y2-16,_i mod 2)))
        return {room:_room,stairs:_stairs,center:_center,pillars:_pillars,chest:scrNTTEFullQuestArtifactChest(_room.x,_room.y,1),old_floors:_old}
    }
    finally { scrNTTEFullFloorResetAlign() }
}
function scrNTTEFullQuestPalaceGenerate() {
    // Source examines only the first NothingInactive, even when already owned.
    var _anchor=instance_find(NothingInactive,0)
    return scrNTTEFullQuestPalaceAtAnchor(_anchor)
}
function scrNTTEFullPalaceStairsCreate() { mask_index=mskFloor;visible=false }
function scrNTTEFullQuestPlayerHasFeet(_actor) {
    var _kind=scrNTTEFullValue(_actor,"footkind",undefined)
    if(is_numeric(_kind)) return _kind!=0
    // Epsilon has no ordinary NTT footkind field. Its real floating Horror and
    // native Venuz-B footstep suppression map to NTT's explicit no-feet gate.
    return _actor.race!=Race.Horror && !(_actor.race==Race.Venuz && _actor.bskin==SkinLetter.B)
}
function scrNTTEFullPalaceStairsBegin() {
    var _players=scrNTTEFullInstances(Player)
    for(var _i=0;_i<array_length(_players);++_i) {
        var _p=_players[_i],_touch=false
        with(_p) _touch=place_meeting(x,y,other.id)
        if(!_touch || !scrNTTEFullQuestPlayerHasFeet(_p) || !scrNTTEFullPlayerActive(_p)) continue
        with(_p) {
            if(sprite_index==spr_walk && roll==0) {
                if(round(image_index)==footstep+2 || footextra==true) {
                    var _sound=asset_get_index("sndFoot"+(place_meeting(x,y,Carpet)?"Sho":"Met")+"Rock"+string(irandom_range(1,6)))
                    if(_sound>=0) snd_play(_sound,(vspeed>0?0.8:1)+orandom(0.1),0.3)
                }
                if(scrNTTEFullValue(id,"ntte_stairslow",0)<=0) {
                    var _dust=instance_create(x,y,Dust);/* NTTE DUST LIFETIME palace-stairs */ if(instance_exists(_dust)) {_dust.sprite_index=sprSmoke }
                }
            }
            ntte_stairslow=5
        }
    }
}
// Player.Step call immediately after native floor friction selection. Epsilon
// velocities are logical*timescale and acceleration/friction logical*ts^2.
function scrNTTEFullQuestStairPlayerStep() {
    var _left=scrNTTEFullValue(id,"ntte_stairslow",0)
    if(_left<=0) return;
    if(roll==false) {
        if(abs(vspeed)>0.2*timescale && scr_skill_get(mut_extra_feet)<=0) {
            var _goal=(0.45+maxspeed/timescale/4)*timescale*timescale
            if(friction<_goal) friction=lerp(friction,_goal,_left/5)
        }
    }
    else if(scr_skill_get(mut_throne_butt)<=0) vspeed+=0.4*timescale*timescale
    ntte_stairslow-=timescale
}
