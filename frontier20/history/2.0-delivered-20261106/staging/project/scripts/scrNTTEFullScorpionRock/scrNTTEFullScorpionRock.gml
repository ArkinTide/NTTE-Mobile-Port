// tedesert.mod.gml2047..2132. The housed pet is supplied by systems-content.
function scrNTTEFullScorpionRockCreate() {
    spr_idle=scrNTTERefSprite("ScorpionRock"); spr_hurt=scrNTTERefSprite("ScorpionRockHurt")
    spr_dead=scrNTTERefSprite("ScorpionRockDead"); sprite_index=spr_idle
    max_hp=32; size=1; friendly=false
}

function scrNTTEFullScorpionRockAfterCreate() {
    spr_shadow=shd32; spr_shadow_y=-3; snd_hurt=sndHitRock; snd_dead=sndPillarBreak
    team=team_enemy
}

function scrNTTEFullScorpionRockStep() {
    if (lockstep_stop || sprite_index!=spr_idle) return;
    var _img=image_index-image_speed,_fac=0
    if (_img<1) _fac=0.975
    else if ((_img>=2 && _img<3) || (_img>=4 && _img<5)) _fac=0.9375
    // Native image_speed is already physical-frame scaled (NTT image_speed_raw).
    image_index-=image_speed*_fac
    if (image_index<1) {
        if (!friendly && !instance_exists(enemy)) friendly=true
        if (friendly && spr_idle==scrNTTERefSprite("ScorpionRock")) {
            spr_idle=scrNTTERefSprite("ScorpionRockAlly"); spr_hurt=scrNTTERefSprite("ScorpionRockAllyHurt")
            sprite_index=spr_idle; image_index=0
        }
    }
}

function scrNTTEFullScorpionRockDeath() {
    if (hp>0) return;
    repeat(3+irandom(3)) with (instance_create(x,y,Debris)) motion_set(random(360),(4+random(4))*timescale)
    if (friendly) scrNTTEFullPetCreate(x,y,"Scorpion")
    else instance_create(x,y,NTTEFullBabyScorpion)
    repeat(3) if (random(2)<1) instance_create(x,y,Maggot)
    if (random(100)<1) instance_create(x,y,NTTEFullSpiderling)
    scrNTTEFullWorldPickupDrop(60,10)
}

function scrNTTEFullScorpionRockSmoke() {
    var _rock=instance_create(10080,10048,NTTEFullScorpionRock),_enemy=instance_create(10080,10048,NTTEFullBabyScorpion)
    assert(_rock.hp==32 && _rock.team==team_enemy && _rock.size==1 && _rock.spr_shadow_y==-3,"ScorpionRock original32HP/team/shadow changed")
    _rock.image_index=0.5
    with (_rock) scrNTTEFullScorpionRockStep()
    assert(!_rock.friendly && _rock.spr_idle==scrNTTERefSprite("ScorpionRock"),"ScorpionRock became friendly before enemies were defeated")
    // The fixed smoke fixture has no other scenario state to preserve.
    instance_destroy(enemy,false)
    _rock.image_index=0.5
    with (_rock) scrNTTEFullScorpionRockStep()
    assert(_rock.friendly && _rock.spr_idle==scrNTTERefSprite("ScorpionRockAlly") && _rock.spr_hurt==scrNTTERefSprite("ScorpionRockAllyHurt") && _rock.image_index==0,"ScorpionRock did not change ally art at its original idle interval")
    var _pets=instance_number(NTTEFullPet)
    _rock.hp=0; instance_destroy(_rock)
    assert(instance_number(NTTEFullPet)==_pets+1,"Friendly ScorpionRock did not release the real Scorpion pet")
    var _last=instance_find(NTTEFullPet,instance_number(NTTEFullPet)-1)
    assert(_last.pet=="Scorpion" && _last.scorpion_city>0,"ScorpionRock released an incomplete pet")
    instance_destroy(_last,false)
    _rock=instance_create(10080,10048,NTTEFullScorpionRock)
    _rock.hp=0; var _babies=instance_number(NTTEFullBabyScorpion)
    instance_destroy(_rock)
    assert(instance_number(NTTEFullBabyScorpion)==_babies+1,"Hostile ScorpionRock did not release BabyScorpion")
    instance_destroy(NTTEFullBabyScorpion,false)
    scrNTTESmokeLog("FULL WORLD SCORPION ROCK32HP/SLOW IDLE/NO ENEMY ALLY SWITCH + REAL PET OR BABY RELEASE OK")
}
