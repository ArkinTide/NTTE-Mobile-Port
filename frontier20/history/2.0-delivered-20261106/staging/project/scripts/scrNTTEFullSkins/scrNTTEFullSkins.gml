// Exact sprite remapping tables extracted from NTTE 2.062 skins/*.gml.
// Base asset names are kept as strings to allow explicit native aliases.
function scrNTTEFullSkinRace(_skin) {
    switch(_skin) {
        case "angler fish":return "fish"
        case "bat eyes":return "eyes"
        case "bonus robot":return "robot"
        case "coat venuz":return "venuz"
        case "cool frog":return "frog"
        case "orchid plant":return "plant"
        case "red crystal":return "crystal"
    }
    return ""
}
function scrNTTEFullSkinAvailable(_skin) { return scrNTTEFullUnlockGet("skin:"+_skin) }
function scrNTTEFullSkinSpriteUncached(_skin,_sprite,_mode="body") {
    var _body=(_mode=="body"),_hud=(_mode=="hud")
    switch(_skin) {
        case "angler fish":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1Idle")) return scrNTTERefSprite("FishAnglerIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1Walk")) return scrNTTERefSprite("FishAnglerWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1Hurt")) return scrNTTERefSprite("FishAnglerHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1Dead")) return scrNTTERefSprite("FishAnglerDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1GoSit")) return scrNTTERefSprite("FishAnglerGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant1Sit")) return scrNTTERefSprite("FishAnglerSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("FishAnglerPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("FishAnglerLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("FishAnglerMapIcon")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("AnglerAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("AnglerBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("AnglerCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("AnglerDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("AnglerGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("AnglerLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("AnglerMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("AnglerNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("AnglerPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("AnglerRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("AnglerScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("AnglerShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("AnglerSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("AnglerSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("AnglerWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGuitar")) return scrNTTERefSprite("AnglerGuitar")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("AnglerBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("AnglerDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("AnglerGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("AnglerNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("AnglerRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("AnglerTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("AnglerTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("AnglerTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("AnglerTunnellerHUD")
            break
        case "bat eyes":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3Idle")) return scrNTTERefSprite("EyesBatIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3Walk")) return scrNTTERefSprite("EyesBatWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3Hurt")) return scrNTTERefSprite("EyesBatHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3Dead")) return scrNTTERefSprite("EyesBatDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3GoSit")) return scrNTTERefSprite("EyesBatGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant3Sit")) return scrNTTERefSprite("EyesBatSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("EyesBatPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("EyesBatLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("EyesBatMapIcon")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("BatAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("BatBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("BatCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("BatDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("BatGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("BatLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("BatMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("BatNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("BatPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("BatRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("BatScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("BatShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("BatSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("BatSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("BatWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("BatBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("BatDisk")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("BatGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("BatNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("BatRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("BatTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("BatTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("BatTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("BatTunnellerHUD")
            break
        case "bonus robot":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8Idle")) return scrNTTERefSprite("RobotBonusIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8Walk")) return scrNTTERefSprite("RobotBonusWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8Hurt")) return scrNTTERefSprite("RobotBonusHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8Dead")) return scrNTTERefSprite("RobotBonusDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8GoSit")) return scrNTTERefSprite("RobotBonusGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant8Sit")) return scrNTTERefSprite("RobotBonusSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("RobotBonusPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("RobotBonusLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("RobotBonusMapIcon")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("BonusAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("BonusBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("BonusCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("BonusDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("BonusGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("BonusLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("BonusMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("BonusNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("BonusPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("BonusRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("BonusScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("BonusShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("BonusSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("BonusSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("BonusWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("BonusBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("BonusDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("BonusGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("BonusNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("BonusRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("BonusTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("BonusTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("BonusTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("BonusTunnellerHUD")
            break
        case "coat venuz":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6Idle")) return scrNTTERefSprite("YVCoatIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6Walk")) return scrNTTERefSprite("YVCoatWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6Hurt")) return scrNTTERefSprite("YVCoatHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6Dead")) return scrNTTERefSprite("YVCoatDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6GoSit")) return scrNTTERefSprite("YVCoatGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant6Sit")) return scrNTTERefSprite("YVCoatSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("YVCoatPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("YVCoatLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("YVCoatMapIcon")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("CoatAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("CoatBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("CoatCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("CoatDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("CoatGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("CoatLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("CoatMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("CoatNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("CoatPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("CoatRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("CoatScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("CoatShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("CoatSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("CoatSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("CoatWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("CoatBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("CoatDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("CoatGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("CoatNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("CoatRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("CoatTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("CoatTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("CoatTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("CoatTunnellerHUD")
            break
        case "cool frog":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15Idle")) return scrNTTERefSprite("FrogCoolIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15Walk")) return scrNTTERefSprite("FrogCoolWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15Hurt")) return scrNTTERefSprite("FrogCoolHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15Dead")) return scrNTTERefSprite("FrogCoolDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15GoSit")) return scrNTTERefSprite("FrogCoolGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant15Sit")) return scrNTTERefSprite("FrogCoolSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("FrogCoolPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("FrogCoolLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("FrogCoolMapIcon")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprHorrorBullet")) return scrNTTERefSprite("IDPDHorrorBullet")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprHorrorBulletHit")) return scrNTTEFullNativeSprite("sprIDPDBulletHit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprHorrorHit")) return scrNTTEFullNativeSprite("sprIDPDBulletHit")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("CoolAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("CoolBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("CoolCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("CoolDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldFrogBlaster")) return scrNTTERefSprite("CoolFrogPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("CoolGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("CoolLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("CoolMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("CoolNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("CoolPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("CoolRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("CoolScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("CoolShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("CoolSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("CoolSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("CoolWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("CoolBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("CoolDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("CoolGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("CoolNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("CoolRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("CoolTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("CoolTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("CoolTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("CoolTunnellerHUD")
            break
        case "orchid plant":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5Idle")) return scrNTTERefSprite("PlantOrchidIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5Walk")) return scrNTTERefSprite("PlantOrchidWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5Hurt")) return scrNTTERefSprite("PlantOrchidHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5Dead")) return scrNTTERefSprite("PlantOrchidDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5GoSit")) return scrNTTERefSprite("PlantOrchidGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant5Sit")) return scrNTTERefSprite("PlantOrchidSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("PlantOrchidPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("PlantOrchidLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("PlantOrchidMapIcon")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprTangle")) return scrNTTERefSprite("PlantOrchidTangle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprTangleSeed")) return scrNTTERefSprite("PlantOrchidTangleSeed")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("OrchidAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("OrchidBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("OrchidCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("OrchidDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldFrogBlaster")) return scrNTTERefSprite("OrchidFrogPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprFrogBlaster")) return scrNTTERefSprite("OrchidFrogPistolRusty")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("OrchidGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("OrchidLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("OrchidMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("OrchidNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("OrchidPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("OrchidRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("OrchidScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("OrchidShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("OrchidSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("OrchidSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("OrchidWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("OrchidBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("OrchidDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("OrchidGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("OrchidNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("OrchidRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("OrchidTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("OrchidTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("OrchidTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("OrchidTunnellerHUD")
            break
        case "red crystal":
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2Idle")) return scrNTTERefSprite("CrystalRedIdle")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2Walk")) return scrNTTERefSprite("CrystalRedWalk")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2Hurt")) return scrNTTERefSprite("CrystalRedHurt")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2Dead")) return scrNTTERefSprite("CrystalRedDead")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2GoSit")) return scrNTTERefSprite("CrystalRedGoSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMutant2Sit")) return scrNTTERefSprite("CrystalRedSit")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprBigPortrait")) return scrNTTERefSprite("CrystalRedPortrait")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprLoadoutSkin")) return scrNTTERefSprite("CrystalRedLoadout")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprMapIcon")) return scrNTTERefSprite("CrystalRedMapIcon")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprShield")) return scrNTTERefSprite("CrystalRedShield")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprShieldDisappear")) return scrNTTERefSprite("CrystalRedShieldDisappear")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprCrystalShieldIdleFront")) return scrNTTERefSprite("CrystalRedShieldIdleFront")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprCrystalShieldWalkFront")) return scrNTTERefSprite("CrystalRedShieldWalkFront")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprCrystalShieldIdleBack")) return scrNTTERefSprite("CrystalRedShieldIdleBack")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprCrystalShieldWalkBack")) return scrNTTERefSprite("CrystalRedShieldWalkBack")
            if(_body && _sprite==scrNTTEFullNativeSprite("sprCrystTrail")) return scrNTTERefSprite("CrystalRedTrail")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldARifle")) return scrNTTERefSprite("RedAssaultRifle")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldBazooka")) return scrNTTERefSprite("RedBazooka")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldCrossbow")) return scrNTTERefSprite("RedCrossbow")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDiscgun")) return scrNTTERefSprite("RedDiscGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNader")) return scrNTTERefSprite("RedGrenadeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldLaserGun")) return scrNTTERefSprite("RedLaserPistol")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldMachinegun")) return scrNTTERefSprite("RedMachinegun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNukeLauncher")) return scrNTTERefSprite("RedNukeLauncher")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldPlasmaGun")) return scrNTTERefSprite("RedPlasmaGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRevolver")) return scrNTTERefSprite("RedRevolver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldScrewdriver")) return scrNTTERefSprite("RedScrewdriver")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldShotgun")) return scrNTTERefSprite("RedShotgun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSlugger")) return scrNTTERefSprite("RedSlugger")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldSplinterGun")) return scrNTTERefSprite("RedSplinterGun")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldWrench")) return scrNTTERefSprite("RedWrench")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprBoltGold")) return scrNTTERefSprite("RedBolt")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldDisc")) return scrNTTERefSprite("RedDisc")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldGrenade")) return scrNTTERefSprite("RedGrenade")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldNuke")) return scrNTTERefSprite("RedNuke")
            if(!_body && _sprite==scrNTTEFullNativeSprite("sprGoldRocket")) return scrNTTERefSprite("RedRocket")
            if(!_body && _sprite==scrNTTERefSprite("GoldTeleportGun")) return scrNTTERefSprite("RedTeleportGun")
            if(!_body && _sprite==scrNTTERefSprite("GoldTrident")) return scrNTTERefSprite("RedTrident")
            if(!_body && _sprite==scrNTTERefSprite("GoldTunneller")) return scrNTTERefSprite("RedTunneller")
            if(_hud && _sprite==scrNTTERefSprite("TunnellerHUD")) return scrNTTERefSprite("RedTunnellerHUD")
            break
    }
    return _sprite
}
function scrNTTEFullNativeSprite(_name) {
    // HorrorBullet.Create in the native runner uses sprHorrorHit for this NTT alias.
    if(_name=="sprHorrorBulletHit") return sprHorrorHit
    if(variable_global_exists("ntte_full_sprite_aliases") && is_struct(global.ntte_full_sprite_aliases) && variable_struct_exists(global.ntte_full_sprite_aliases,_name))
        return variable_struct_get(global.ntte_full_sprite_aliases,_name)
    var _sprite=asset_get_index(_name)
    if(_sprite<0) throw "NTTE native sprite alias missing: "+_name
    return _sprite
}
function scrNTTEFullSkinName(_skin) {
    switch(_skin) {
        case "angler fish":return "ABYSSAL"
        case "bat eyes":return "BAT"
        case "bonus robot":return "BONUS"
        case "coat venuz":return "COAT"
        case "cool frog":return "COOL"
        case "orchid plant":return "GILDED"
        case "red crystal":return "RED"
    }
    return ""
}
function scrNTTEFullSkinLock(_skin) {
    switch(_skin) {
        case "angler fish":return "DEFEAT A @yGOLDEN ANGLER"
        case "bat eyes":return "REACH MAX @rCRIME @wBOUNTY"
        case "bonus robot":return "PLAY 8 HOURS OF NT:TE"
        case "coat venuz":return "BUY A COAT"
        case "cool frog":return "REACH @q@(color:"+string(make_color_rgb(255,110,25))+")COMBO x100"
        case "orchid plant":return "REROLL ???"
        case "red crystal":return "REACH @(color:"+string(make_color_rgb(235,0,67))+")@3("+string(scrNTTERefSprite("RedText"))+":-0.8)"
    }
    return ""
}
function scrNTTEFullSkinUnlockText(_skin) {
    switch(_skin) {
        case "angler fish":return "FOR DEFEATING A @yGOLDEN ANGLER"
        case "bat eyes":return "FOR REACHING MAX @rCRIME @wBOUNTY"
        case "bonus robot":return "FOR PLAYING 8 HOURS OF NT:TE"
        case "coat venuz":return "FOR BUYING A COAT"
        case "cool frog":return "REACHED @q@(color:"+string(make_color_rgb(255,110,25))+")COMBO x100"
        case "orchid plant":return "FOR REROLLING HEAVY HEART"
        case "red crystal":return "FOR REACHING @(color:"+string(make_color_rgb(235,0,67))+")@3("+string(scrNTTERefSprite("RedText"))+":-0.8)"
    }
    return ""
}
function scrNTTEFullSkinTip(_skin) {
    switch(_skin) {
        case "angler fish":return choose("SO BRIGHT OUT", "MISSED THE SUN", "SHAPED BY THE DEPTHS", "LOST YOUR MIND")
        case "bat eyes":return choose("THE DANGER", "TREAD LIGHTLY", "SAY MY NAME")
        case "bonus robot":return choose("RECYCLE", "MK 600", "YOU ARE TERMINATED")
        case "coat venuz":return choose("GUNS THAT SEW THREADSES", "FRESH FIT", "IS THAT DESIGNER", "DROWNING IN STYLE")
        case "orchid plant":return choose("YOU LOOK SO GOOD", "MILLION DOLLAR SMILE", "SHINY LIKE A LIMOUSINE", "ALL THAT TWINKLES IS GOLD", "PUMP YOUR VEINS WITH GUSHING GOLD")
        case "red crystal":return choose("NEVER MORE ALIVE", "FAMILY CAN WAIT")
        case "cool frog":return scrNTTEFullCoolFrogTip()
    }
    return ""
}
function scrNTTEFullSkinSwap(_skin,_swap) {
    switch(_skin) {
        case "angler fish":{snd_play(sndOasisMelee, 0.75, 1.2);
	return _swap;}
        case "bat eyes":{snd_play(sndSwapHammer, 1.2, 2/3);
	return _swap;}
        case "bonus robot":{snd_play(sndSwapEnergy, 1.2, 0.8);
	return _swap;}
        case "coat venuz":{snd_play(choose(sndMenuASkin, sndMenuBSkin), 1.1, 1.2);
	return _swap;}
        case "cool frog":{snd_play(sndPizzaBoxBreak, 1.3, 1.25);
	return _swap;}
        case "orchid plant":{snd_play(sndMoneyPileBreak, 1.2, 1.45);
	return _swap;}
        case "red crystal":{var _voice=snd_play(sndHyperCrystalChargeExplo,0.6,0.5);if(_voice>=0) audio_sound_set_track_position(_voice,1.55);
	return _swap;}
    }
    return _swap
}
function scrNTTEFullCoolFrogTip() {
    if(random(5)<1 && GameCont.level>=10) {
        return choose("SLIME TIME","TOO MUCH PIZZA","MAKE SURE YOU FLUSH","WANNA SEE A FROG?",
            "@q@(color:"+string(choose(make_color_rgb(255,230,70),make_color_rgb(50,210,255),make_color_rgb(255,110,25),make_color_rgb(255,110,150)))+")COMBO x"+string(GameCont.kills))
    }
    var _pet=asset_get_index("NTTEFullPet"),_cool=false
    if(_pet>=0) with(_pet) if(scrNTTEFullValue(id,"pet","")=="CoolGuy") _cool=true
    return choose("JUST A COOL FROG","WHAT THE COOL","TOO COOL FOR SCHOOL","STRAIGHT FROM THE SEWERS",
        "ROCKIN' THE SHADES","FROGGING AROUND",_cool ? "@(color:"+string(make_color_rgb(255,110,150))+")FUNKY":"")
}

// Cache resolved IDs, including unchanged ordinary weapons. Art remains live.
function scrNTTEFullSkinSpriteCacheState() {
    static _state={entries:{},count:0,limit:2048}
    return _state
}
function scrNTTEFullSkinSprite(_skin,_sprite,_mode="body") {
    if(scrNTTEFullSkinRace(_skin)=="") return _sprite
    if(variable_global_exists("ntte_full_sprite_aliases") && is_struct(global.ntte_full_sprite_aliases))
        return scrNTTEFullSkinSpriteUncached(_skin,_sprite,_mode)
    if(!is_numeric(_sprite) || _sprite<0 || _sprite!=floor(_sprite) || !is_string(_mode))
        return scrNTTEFullSkinSpriteUncached(_skin,_sprite,_mode)
    var _kind=(_mode=="body")?"body":((_mode=="hud")?"hud":"weapon"),
        _key=_skin+"|"+_kind+"|"+string(_sprite),_state=scrNTTEFullSkinSpriteCacheState()
    if(variable_struct_exists(_state.entries,_key)) return _state.entries[$ _key]
    var _value=scrNTTEFullSkinSpriteUncached(_skin,_sprite,_mode)
    if(_state.count<_state.limit) {_state.entries[$ _key]=_value;_state.count+=1}
    return _value
}

function scrNTTEFullSkinSpriteCacheTests() {
    var _state=scrNTTEFullSkinSpriteCacheState(),_entries=_state.entries,_count=_state.count,_limit=_state.limit,
        _aliases=variable_global_exists("ntte_full_sprite_aliases")?global.ntte_full_sprite_aliases:undefined,
        _seed=random_get_seed(),_dynamic=-1,_queries=0,_bench=[],
        _skins=["angler fish","bat eyes","bonus robot","coat venuz","cool frog","orchid plant","red crystal"],
        _body=["FishAnglerIdle","EyesBatIdle","RobotBonusIdle","YVCoatIdle","FrogCoolIdle","PlantOrchidIdle","CrystalRedIdle"],
        _idle=[sprMutant1Idle,sprMutant3Idle,sprMutant8Idle,sprMutant6Idle,sprMutant15Idle,sprMutant5Idle,sprMutant2Idle],
        _tags=["Angler","Bat","Bonus","Coat","Cool","Orchid","Red"],_modes=["body","weapon","hud"],
        _inputs=[sprShield,sprShieldDisappear,sprHorrorBullet,sprHorrorHit,sprTangle,sprTangleSeed,scrNTTERefSprite("TunnellerHUD")]
    try {
        global.ntte_full_sprite_aliases=undefined;_state.limit=2048
        for(var _w=0;_w<=maxwep;++_w) {
            if(sprite_exists(wep_sprt[_w])) array_push(_inputs,wep_sprt[_w])
            if(sprite_exists(wep_lout[_w])) array_push(_inputs,wep_lout[_w])
        }
        for(var _s=0;_s<7;++_s) {
            var _skin=_skins[_s]
            assert(scrNTTEFullSkinSprite(_skin,_idle[_s],"body")==scrNTTERefSprite(_body[_s]),"Original skin body changed: "+_skin)
            assert(scrNTTEFullSkinSprite(_skin,sprGoldRevolver,"weapon")==scrNTTERefSprite(_tags[_s]+"Revolver"),"Original skin golden gun changed: "+_skin)
            assert(scrNTTEFullSkinSprite(_skin,sprBoltGold,"weapon")==scrNTTERefSprite(_tags[_s]+"Bolt"),"Original skin bolt changed: "+_skin)
            assert(scrNTTEFullSkinSprite(_skin,scrNTTERefSprite("TunnellerHUD"),"hud")==scrNTTERefSprite(_tags[_s]+"TunnellerHUD"),"Original skin HUD changed: "+_skin)
            for(var _m=0;_m<3;++_m) {
                _state.entries={};_state.count=0
                for(var _i=0;_i<array_length(_inputs);++_i) {
                    var _spr=_inputs[_i],_mode=_modes[_m],_expected=scrNTTEFullSkinSpriteUncached(_skin,_spr,_mode)
                    assert(scrNTTEFullSkinSprite(_skin,_spr,_mode)==_expected && scrNTTEFullSkinSprite(_skin,_spr,_mode)==_expected,"Skin cold/hot mapping changed")
                    _queries+=2
                }
            }
        }
        _state.entries={};_state.count=0
        assert(scrNTTEFullSkinSprite("missing-skin",sprRevolver,"weapon")==sprRevolver && _state.count==0,"Unknown skin polluted cache")
        global.ntte_full_sprite_aliases={sprGoldRevolver:sprRevolver}
        assert(scrNTTEFullSkinSprite("angler fish",sprRevolver,"weapon")==scrNTTERefSprite("AnglerRevolver"),"Live alias not observed")
        global.ntte_full_sprite_aliases.sprGoldRevolver=sprShotgun
        assert(scrNTTEFullSkinSprite("angler fish",sprRevolver,"weapon")==sprRevolver
            && scrNTTEFullSkinSprite("angler fish",sprShotgun,"weapon")==scrNTTERefSprite("AnglerRevolver"),"Mutable alias retained stale mapping")
        global.ntte_full_sprite_aliases=undefined
        _dynamic=sprite_duplicate(sprRevolver)
        var _first=scrNTTEFullSkinSprite("angler fish",_dynamic,"weapon")
        sprite_assign(_dynamic,sprShotgun)
        assert(_first==_dynamic && scrNTTEFullSkinSprite("angler fish",_dynamic,"weapon")==_dynamic
            && sprite_get_width(_dynamic)==sprite_get_width(sprShotgun),"Dynamic sprite art identity changed")
        _state.entries={};_state.count=0;_state.limit=2
        scrNTTEFullSkinSprite("angler fish",sprRevolver,"weapon");scrNTTEFullSkinSprite("angler fish",sprShotgun,"weapon")
        repeat(3) assert(scrNTTEFullSkinSprite("red crystal",sprGoldRevolver,"hud")==scrNTTERefSprite("RedRevolver"),"Capacity fallback result changed")
        assert(_state.count==2,"Skin cache exceeded capacity or flushed")
        _state.entries={};_state.count=0;_state.limit=2048
        var _sample=[sprRevolver,sprShotgun,sprGoldRevolver,sprBoltGold,scrNTTERefSprite("GoldTrident"),scrNTTERefSprite("TunnellerHUD")]
        for(var _s=0;_s<7;++_s) for(var _m=1;_m<3;++_m) for(var _i=0;_i<6;++_i) array_push(_bench,[_skins[_s],_sample[_i],_modes[_m]])
        for(var _i=0;_i<array_length(_bench);++_i) {var _q=_bench[_i];scrNTTEFullSkinSprite(_q[0],_q[1],_q[2])}
        var _old=[],_new=[],_sink=0
        for(var _trial=0;_trial<5;++_trial) {
            var _start=get_timer()
            repeat(24) for(var _i=0;_i<array_length(_bench);++_i) {var _q=_bench[_i];_sink+=real(scrNTTEFullSkinSpriteUncached(_q[0],_q[1],_q[2]))}
            array_push(_old,get_timer()-_start);_start=get_timer()
            repeat(24) for(var _i=0;_i<array_length(_bench);++_i) {var _q=_bench[_i];_sink+=real(scrNTTEFullSkinSprite(_q[0],_q[1],_q[2]))}
            array_push(_new,get_timer()-_start)
        }
        array_sort(_old,true);array_sort(_new,true)
        assert(_state.count>0 && _new[2]<_old[2]*0.8,"Skin cache did not improve hot-query CPU cost")
        assert(random_get_seed()==_seed,"Skin cache consumed RNG")
        scrNTTESmokeLog("SKIN CACHE "+json_stringify({compared_queries:_queries,old_median_us:_old[2],new_median_us:_new[2],ratio:_new[2]/max(1,_old[2]),mobile_device_tested:false,sink:_sink}))
    } finally {
        if(sprite_exists(_dynamic)) sprite_delete(_dynamic)
        global.ntte_full_sprite_aliases=_aliases;_state.entries=_entries;_state.count=_count;_state.limit=_limit
    }
}
