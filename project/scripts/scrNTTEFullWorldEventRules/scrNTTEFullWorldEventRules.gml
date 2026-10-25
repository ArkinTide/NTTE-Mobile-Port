// Pure original event registration/eligibility. This is not a generator.
// Inputs are explicit so boundary conditions can be regression-tested without
// unlocking content, changing saves, or substituting simplified test rooms.
function scrNTTEFullWorldEventOrder() {
    return ["BlockedRoom","GatorAmbush","MaggotPark","ScorpionCity","BanditCamp","GatorDen","SewerPool","RavenArena","FirePit","SealPlaza","MutantVats","PopoAmbush","PalaceShrine","SeaCreature","EelGrave","BuriedVault"]
}

function scrNTTEFullWorldEventArea(_name) {
    switch (_name) {
        case "BanditCamp": case "BlockedRoom": case "MaggotPark": case "ScorpionCity": return area_desert
        case "SewerPool": case "GatorDen": return area_sewers
        case "RavenArena": case "FirePit": return area_scrapyards
        case "SealPlaza": case "YetiHideout": return area_city
        case "MutantVats": case "ButtonGame": return area_labs
        case "PalaceShrine": case "PopoAmbush": return area_palace
        case "SeaCreature": return scrNTTEFullAreaId("coast")
        case "EelGrave": return scrNTTEFullAreaId("trench")
    }
    return undefined
}

function scrNTTEFullWorldEventHard(_name) {
    if (_name=="BlockedRoom") return 1
    if (_name=="BanditCamp") return 3
    if (_name=="BuriedVault") return 5
    return 2
}

// _ctx fields correspond one-to-one to the expressions in teevents.mod.gml.
// pet_count specifically counts Pet("Scorpion") with scorpion_city > 0;
// pet_history_count is array_length(GameCont.ntte_pet_history), NOT total pets.
function scrNTTEFullWorldEventChance(_name,_ctx) {
    switch (_name) {
        case "BuriedVault": return _ctx.area==area_vault ? 1/2:((_ctx.safespawn>0 && _ctx.area!=scrNTTEFullAreaId("coast")) ? 1/(12+2*_ctx.buried_vaults):0)
        case "BanditCamp": return _ctx.subarea==3 ? 1/10:1/20
        case "BlockedRoom": return 1/3
        case "MaggotPark": return 1/50
        case "ScorpionCity": return _ctx.scorpion_city_pet_count
        case "SewerPool": return 1/5
        case "GatorAmbush": return _ctx.crime_bounty>=3 && _ctx.safespawn>0
        case "GatorDen": return _ctx.crime_unlocked ? 1/10:0
        case "RavenArena": return 1/40
        case "FirePit": return _ctx.subarea!=3 ? 1/12:0
        case "SealPlaza": return _ctx.coast_unlocked ? 1/18:0
        case "YetiHideout": return 1/100
        // JS/GML && in the source yields a Boolean, so the chance is 1/3
        // for any nonempty pet history, not history length divided by three.
        case "MutantVats": return _ctx.general_loaded ? (_ctx.pet_history_count>0)/3:0
        case "ButtonGame": return 1/4
        case "PalaceShrine": return (_ctx.subarea==2 && _ctx.palace_shrine_skill_count>0) ? 1/(1+max(0,_ctx.wepmuts)):0
        case "PopoAmbush": return _ctx.subarea==1 ? clamp((_ctx.popolevel-5)/10,0,1)/(1+_ctx.loops):0
        case "SeaCreature": return _ctx.player_alias=="blaac" ? (_ctx.subarea==2):(_ctx.subarea!=3 ? 1/25:0)
        case "EelGrave": return _ctx.trench_unlocked ? 1/10:0
    }
    show_error("Unknown original NTTE event: "+_name,true)
    return 0
}

function scrNTTEFullWorldEventEligible(_name,_ctx) {
    var _events=scrNTTEFullWorldEventOrder(),_registered=false
    for (var _i=0;_i<array_length(_events);++_i) if (_events[_i]==_name) { _registered=true; break }
    if (!_registered || _ctx.hard<scrNTTEFullWorldEventHard(_name)) return false
    var _area=scrNTTEFullWorldEventArea(_name)
    return is_undefined(_area) || _area==_ctx.area
}
