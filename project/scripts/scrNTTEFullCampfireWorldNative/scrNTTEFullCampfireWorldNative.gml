// ntte.mod.gml:715..750. Native Corpse and NightBonePile are the original
// engine equivalents; availability gates stay closed until full race parity.
function scrNTTEFullCampfireCorpse(_race,_spawnX,_spawnY) {
    var _body=instance_create(_spawnX,_spawnY-16,Corpse)
    with(_body) {
        sprite_index=scrNTTEFullRaceSprite(_race,"Dead",0,sprMutant1Dead)
        image_index=image_number-1
        ntte_full_campfire_race=_race
        var _tries=1000
        while(_tries-->0) {
            x=xstart;y=ystart
            move_contact_solid(random(360),random_range(32,64)+random(random(64)))
            x=round(x);y=round(y)
            if(!collision_circle(x,y,12,Corpse,true,true)) break
        }
    }
    return _body
}
function scrNTTEFullCampfireDecorCandidates(_available,_selected) {
    var _races=[]
    for(var _i=0;_i<array_length(_available);++_i)
        if(array_get_index(_selected,_available[_i])<0) array_push(_races,_available[_i])
    return _races
}
function scrNTTEFullCampfireDecorLevelStart(_spawnX=10016,_spawnY=10016) {
    if(!instance_exists(GameCont) || GameCont.area!=area_campfire) return []
    var _available=[],_bodies=[]
    for(var _race=NTTEFullRace.Beetle;_race<=NTTEFullRace.Parrot;++_race)
        if(scrNTTEFullRaceAvailable(_race)) array_push(_available,_race)
    var _races=scrNTTEFullCampfireDecorCandidates(_available,scrNTTEFullRaceProgressSelected())
    for(var _i=0;_i<array_length(_races);++_i)
        array_push(_bodies,scrNTTEFullCampfireCorpse(_races[_i],_spawnX,_spawnY))
    // Source instance_delete removes these without death callbacks/rewards.
    with(NightBonePile) if(chance(1,3)) instance_destroy(id,false)
    return _bodies
}
