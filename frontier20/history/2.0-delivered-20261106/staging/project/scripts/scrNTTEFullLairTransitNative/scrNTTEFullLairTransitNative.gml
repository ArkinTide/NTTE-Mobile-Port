// lair.area278..302. The single original Lair subarea ends in Scrapyards1.
function scrNTTEFullLairFinish() {
    GameCont.ntte_visits_lair=scrNTTEFullValue(GameCont,"ntte_visits_lair",0)+1
    GameCont.area=area_scrapyards;GameCont.subarea=1
}
function scrNTTEFullLairTransit() {
    GameCont.ntte_full_active_lair=false
}
