// ntte.level_start:1112..1116 and1754..1765. These are unconditional
// area-specific providers after generic Weapon Mimic arena generation.
function scrNTTEFullPetWorldLevelStart() {
    var _pet=noone
    switch(GameCont.area) {
        case area_cursed_caves:
            var _chest=instance_furthest(10016,10016,CursedBigChest)
            if(instance_exists(_chest)) _pet=scrNTTEFullPetCreate(_chest.x,_chest.y,"Prism")
            // Original retains the BigCursedChest beside its Prism.
            break
        case area_mansion:
            var _chest=instance_nearest(10016,10016,GoldChest)
            if(instance_exists(_chest)) {
                _pet=scrNTTEFullPetCreate(_chest.x,_chest.y,"Mimic")
                // The source inner with reads the pet's own curse (default0),
                // not the removed chest's curse. Keep source gold selector.
                _pet.wep=scrNTTEFullWeaponDecide(0,1+2*_pet.curse+GameCont.hard,true,undefined,_pet)
                instance_destroy(_chest,false)
            }
            break
    }
    return _pet
}
