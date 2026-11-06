#macro wep_ntte_bubble_bat 134
#macro wep_ntte_bubble_rifle 135
#macro wep_ntte_bubble_shotgun 136
#macro wep_ntte_bubble_minigun 137
#macro wep_ntte_bubble_cannon 138
#macro wep_ntte_hyper_bubbler 139
#macro wep_ntte_electroplasma_rifle 140
#macro wep_ntte_electroplasma_shotgun 141
#macro wep_ntte_electroplasma_cannon 142
#macro wep_ntte_dematerializer 143
#macro wep_ntte_energy_bat 144
#macro wep_ntte_tesla_coil 145
#macro wep_ntte_vampire 146
#macro wep_ntte_sawblade_gun 147
#macro wep_ntte_sawblade_cannon 148
#macro wep_ntte_pizza_cutter 149
#macro wep_ntte_harpoon_launcher 150
#macro wep_ntte_net_launcher 151
#macro wep_ntte_clam_shield 152
#macro wep_ntte_teleport_gun 153
#macro wep_ntte_super_teleport_gun 154
#macro wep_ntte_quasar_blaster 155
#macro wep_ntte_quasar_rifle 156
#macro wep_ntte_quasar_cannon 157
#macro wep_ntte_ultra_quasar_rifle 158
#macro wep_ntte_bone 159
#macro wep_ntte_bone_scythe 160
#macro wep_ntte_bone_shotbow 161
#macro wep_ntte_bone_slugbow 162
#macro wep_ntte_trident 163
#macro wep_ntte_annihilator 164
#macro wep_ntte_entangler 165
#macro wep_ntte_tunneller 166
#macro wep_ntte_golden_teleport_gun 167
#macro wep_ntte_golden_trident 168
#macro wep_ntte_golden_tunneller 169
#macro wep_ntte_ancient_artifact 170
#macro wep_ntte_guarded_artifact 171
#macro wep_ntte_stolen_artifact 172
#macro wep_ntte_missing_artifact 173

function scrNTTEAllInit() {
    scrNTTERegisterBulletWeapon(wep_ntte_bubble_bat, "BUBBLE BAT", "REFRESHING", 2, 18, false, 6, sprNTTEBubbleBat, sndSwapEnergy)
    wep_type[wep_ntte_bubble_bat] = 4
    wep_mele[wep_ntte_bubble_bat] = true
    scrNTTERegisterBulletWeapon(wep_ntte_bubble_rifle, "BUBBLE RIFLE", "REFRESHING", 2, 9, false, 6, sprNTTEBubbleRifle, sndSwapExplosive)
    wep_type[wep_ntte_bubble_rifle] = 4
    wep_mele[wep_ntte_bubble_rifle] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bubble_shotgun, "BUBBLE SHOTGUN", "SUMMERTIME FUN", 3, 23, false, 8, sprNTTEBubbleShotgun, sndSwapExplosive)
    wep_type[wep_ntte_bubble_shotgun] = 4
    wep_mele[wep_ntte_bubble_shotgun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bubble_minigun, "BUBBLE MINIGUN", "SOAP EVERYWHERE", 3, 3, true, 10, sprNTTEBubbleMinigun, sndSwapMotorized)
    wep_type[wep_ntte_bubble_minigun] = 4
    wep_mele[wep_ntte_bubble_minigun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bubble_cannon, "BUBBLE CANNON", "KING OF THE BUBBLES", 4, 30, false, 11, sprNTTEBubbleCannon, sndSwapExplosive)
    wep_type[wep_ntte_bubble_cannon] = 4
    wep_mele[wep_ntte_bubble_cannon] = false
    scrNTTERegisterBulletWeapon(wep_ntte_hyper_bubbler, "HYPER BUBBLER", "POWER WASHER", 3, 7, false, 15, sprNTTEHyperBubbler, sndSwapExplosive)
    wep_type[wep_ntte_hyper_bubbler] = 4
    wep_mele[wep_ntte_hyper_bubbler] = false
    scrNTTERegisterBulletWeapon(wep_ntte_electroplasma_rifle, "ELECTROPLASMA RIFLE", "DEEP SEA WEAPONRY", 5, 20, true, 7, sprNTTEElectroPlasmaRifle, sndSwapEnergy)
    wep_type[wep_ntte_electroplasma_rifle] = 5
    wep_mele[wep_ntte_electroplasma_rifle] = false
    scrNTTERegisterBulletWeapon(wep_ntte_electroplasma_shotgun, "ELECTROPLASMA SHOTGUN", "WHERE'S THE PEANUT BUTTER", 8, 27, false, 8, sprNTTEElectroPlasmaShotgun, sndSwapEnergy)
    wep_type[wep_ntte_electroplasma_shotgun] = 5
    wep_mele[wep_ntte_electroplasma_shotgun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_electroplasma_cannon, "ELECTROPLASMA CANNON", "BRAIN EXPANDING", 10, 50, false, 14, sprNTTEElectroPlasmaCannon, sndSwapEnergy)
    wep_type[wep_ntte_electroplasma_cannon] = 5
    wep_mele[wep_ntte_electroplasma_cannon] = false
    scrNTTERegisterBulletWeapon(wep_ntte_dematerializer, "DEMATERIALIZER", "ITS A GUN", 0, 18, true, 7, sprNTTEDematerializer, sndSwapEnergy)
    wep_type[wep_ntte_dematerializer] = 5
    wep_mele[wep_ntte_dematerializer] = false
    scrNTTERegisterBulletWeapon(wep_ntte_energy_bat, "ENERGY BAT", "LOST BUT NOT FORGOTTEN", 2, 12, false, 11, sprNTTEEnergyBat, sndSwapEnergy)
    wep_type[wep_ntte_energy_bat] = 5
    wep_mele[wep_ntte_energy_bat] = true
    scrNTTERegisterBulletWeapon(wep_ntte_tesla_coil, "TESLA COIL", "LIMITED POWER", 2, 8, true, 11, sprNTTETeslaCoil, sndSwapEnergy)
    wep_type[wep_ntte_tesla_coil] = 5
    wep_mele[wep_ntte_tesla_coil] = false
    scrNTTERegisterBulletWeapon(wep_ntte_vampire, "VAMPIRE", "HEMOELECTRICITY", 0, 5, true, 11, sprNTTEBatTether, sndSwapEnergy)
    wep_type[wep_ntte_vampire] = 0
    wep_mele[wep_ntte_vampire] = false
    scrNTTERegisterBulletWeapon(wep_ntte_sawblade_gun, "SAWBLADE GUN", "LIKE DISCS BUT SMARTER", 0, 8, true, 5, sprNTTEBatDiscLauncher, sndSwapEnergy)
    wep_type[wep_ntte_sawblade_gun] = 0
    wep_mele[wep_ntte_sawblade_gun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_sawblade_cannon, "SAWBLADE CANNON", "THEY STAND NO CHANCE", 0, 20, true, 11, sprNTTEBatDiscCannon, sndSwapEnergy)
    wep_type[wep_ntte_sawblade_cannon] = 0
    wep_mele[wep_ntte_sawblade_cannon] = false
    scrNTTERegisterBulletWeapon(wep_ntte_pizza_cutter, "PIZZA CUTTER", "FOR THE CIVILIZED TURTLE", 0, 24, true, 7, sprNTTEPizzaCutter, sndSwapEnergy)
    wep_type[wep_ntte_pizza_cutter] = 0
    wep_mele[wep_ntte_pizza_cutter] = true
    scrNTTERegisterBulletWeapon(wep_ntte_harpoon_launcher, "HARPOON LAUNCHER", "REEL IT IN", 1, 5, false, 4, sprNTTEHarpoonLauncher, sndSwapEnergy)
    wep_type[wep_ntte_harpoon_launcher] = 3
    wep_mele[wep_ntte_harpoon_launcher] = false
    scrNTTERegisterBulletWeapon(wep_ntte_net_launcher, "NET LAUNCHER", "CATCH OF THE DAY", 10, 36, false, 8, sprNTTENetGun, sndSwapEnergy)
    wep_type[wep_ntte_net_launcher] = 3
    wep_mele[wep_ntte_net_launcher] = false
    scrNTTERegisterBulletWeapon(wep_ntte_clam_shield, "CLAM SHIELD", "ROYAL GUARD", 0, 30, false, 6, sprNTTEClamShieldWep, sndSwapEnergy)
    wep_type[wep_ntte_clam_shield] = 0
    wep_mele[wep_ntte_clam_shield] = true
    scrNTTERegisterBulletWeapon(wep_ntte_teleport_gun, "TELEPORT GUN", "NTTE 2.062", 0, 10, true, 7, sprNTTETeleportGun, sndSwapEnergy)
    wep_type[wep_ntte_teleport_gun] = 0
    wep_mele[wep_ntte_teleport_gun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_super_teleport_gun, "SUPER TELEPORT GUN", "POSITION INDETERMINABLE", 0, 45, true, 18, sprNTTESuperTeleportGun, sndSwapEnergy)
    wep_type[wep_ntte_super_teleport_gun] = 0
    wep_mele[wep_ntte_super_teleport_gun] = false
    scrNTTERegisterBulletWeapon(wep_ntte_quasar_blaster, "QUASAR BLASTER", "SO FLEXIBLE", 3, 15, false, 9, sprNTTEQuasarBlaster, sndSwapEnergy)
    wep_type[wep_ntte_quasar_blaster] = 5
    wep_mele[wep_ntte_quasar_blaster] = false
    scrNTTERegisterBulletWeapon(wep_ntte_quasar_rifle, "QUASAR RIFLE", "BLINDING LIGHT", 10, 60, true, 16, sprNTTEQuasarRifle, sndSwapEnergy)
    wep_type[wep_ntte_quasar_rifle] = 5
    wep_mele[wep_ntte_quasar_rifle] = false
    scrNTTERegisterBulletWeapon(wep_ntte_quasar_cannon, "QUASAR CANNON", "PULSATING", 16, 159, false, 18, sprNTTEQuasarCannon, sndSwapEnergy)
    wep_type[wep_ntte_quasar_cannon] = 5
    wep_mele[wep_ntte_quasar_cannon] = false
    scrNTTERegisterBulletWeapon(wep_ntte_ultra_quasar_rifle, "ULTRA QUASAR RIFLE", "NTTE 2.062", 6, 30, true, 21, sprNTTEUltraQuasarBlaster, sndSwapEnergy)
    wep_type[wep_ntte_ultra_quasar_rifle] = 5
    wep_mele[wep_ntte_ultra_quasar_rifle] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bone, "BONE", "NTTE 2.062", 0, 6, false, 4, sprNTTEBone, sndSwapEnergy)
    wep_type[wep_ntte_bone] = 0
    wep_mele[wep_ntte_bone] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bone_scythe, "BONE SCYTHE", "NTTE 2.062", 0, 12, true, 19, sprNTTEScythe, sndSwapEnergy)
    wep_type[wep_ntte_bone_scythe] = 0
    wep_mele[wep_ntte_bone_scythe] = true
    scrNTTERegisterBulletWeapon(wep_ntte_bone_shotbow, "BONE SHOTBOW", "NTTE 2.062", 0, 18, true, -1, sprNTTEShotbow, sndSwapEnergy)
    wep_type[wep_ntte_bone_shotbow] = 0
    wep_mele[wep_ntte_bone_shotbow] = false
    scrNTTERegisterBulletWeapon(wep_ntte_bone_slugbow, "BONE SLUGBOW", "NTTE 2.062", 0, 15, false, -1, sprNTTESlugbow, sndSwapEnergy)
    wep_type[wep_ntte_bone_slugbow] = 0
    wep_mele[wep_ntte_bone_slugbow] = false
    scrNTTERegisterBulletWeapon(wep_ntte_trident, "TRIDENT", "NTTE 2.062", 0, 14, true, 7, sprNTTETrident, sndSwapEnergy)
    wep_type[wep_ntte_trident] = 0
    wep_mele[wep_ntte_trident] = false
    scrNTTERegisterBulletWeapon(wep_ntte_annihilator, "ANNIHILATOR", "NTTE 2.062", 0, 18, true, 22, sprNTTEAnnihilator, sndSwapEnergy)
    wep_type[wep_ntte_annihilator] = 0
    wep_mele[wep_ntte_annihilator] = true
    scrNTTERegisterBulletWeapon(wep_ntte_entangler, "ENTANGLER", "NTTE 2.062", 0, 20, true, 22, sprNTTEEntangler, sndSwapEnergy)
    wep_type[wep_ntte_entangler] = 0
    wep_mele[wep_ntte_entangler] = true
    scrNTTERegisterBulletWeapon(wep_ntte_tunneller, "TUNNELLER", "NTTE 2.062", 0, 24, true, 22, sprNTTETunneller, sndSwapEnergy)
    wep_type[wep_ntte_tunneller] = 0
    wep_mele[wep_ntte_tunneller] = false
    scrNTTERegisterBulletWeapon(wep_ntte_golden_teleport_gun, "GOLDEN TELEPORT GUN", "NTTE 2.062", 0, 10, true, -1, sprNTTEGoldTeleportGun, sndSwapEnergy)
    wep_type[wep_ntte_golden_teleport_gun] = 0
    wep_mele[wep_ntte_golden_teleport_gun] = false
    wep_gold[wep_ntte_golden_teleport_gun] = true
    scrNTTERegisterBulletWeapon(wep_ntte_golden_trident, "GOLDEN TRIDENT", "NTTE 2.062", 0, 14, true, -1, sprNTTEGoldTrident, sndSwapEnergy)
    wep_type[wep_ntte_golden_trident] = 0
    wep_mele[wep_ntte_golden_trident] = false
    wep_gold[wep_ntte_golden_trident] = true
    scrNTTERegisterBulletWeapon(wep_ntte_golden_tunneller, "GOLDEN TUNNELLER", "NTTE 2.062", 0, 24, true, -1, sprNTTEGoldTunneller, sndSwapEnergy)
    wep_type[wep_ntte_golden_tunneller] = 0
    wep_mele[wep_ntte_golden_tunneller] = false
    wep_gold[wep_ntte_golden_tunneller] = true
    scrNTTERegisterBulletWeapon(wep_ntte_ancient_artifact, "ANCIENT ARTIFACT", "NTTE 2.062", 0, 6, false, -1, sprNTTEArtifact0, sndSwapEnergy)
    wep_type[wep_ntte_ancient_artifact] = 0
    wep_mele[wep_ntte_ancient_artifact] = false
    scrNTTERegisterBulletWeapon(wep_ntte_guarded_artifact, "GUARDED ARTIFACT", "NTTE 2.062", 0, 6, false, -1, sprNTTEArtifact1, sndSwapEnergy)
    wep_type[wep_ntte_guarded_artifact] = 0
    wep_mele[wep_ntte_guarded_artifact] = false
    scrNTTERegisterBulletWeapon(wep_ntte_stolen_artifact, "STOLEN ARTIFACT", "NTTE 2.062", 0, 6, false, -1, sprNTTEArtifact2, sndSwapEnergy)
    wep_type[wep_ntte_stolen_artifact] = 0
    wep_mele[wep_ntte_stolen_artifact] = false
    scrNTTERegisterBulletWeapon(wep_ntte_missing_artifact, "MISSING ARTIFACT", "NTTE 2.062", 0, 6, false, -1, sprNTTEArtifact3, sndSwapEnergy)
    wep_type[wep_ntte_missing_artifact] = 0
    wep_mele[wep_ntte_missing_artifact] = false
    wep_rads[wep_ntte_ultra_quasar_rifle] = 50
}
