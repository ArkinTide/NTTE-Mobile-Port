// Details+ 1.1 by wigglercola. Native adaptation of the supplied source.
// Decorative work runs once per generated world or explicit option change.
function scrDPEnabled() {
    return instance_exists(UberCont) && scrNTTEFullValue(UberCont,"opt_detailsplus",true);
}
function scrDPRemember() {
    if(is_struct(scrNTTEFullValue(id,"dp_original",undefined))) return false;
    dp_original={sprite:sprite_index,index:image_index,scale:image_xscale,depth:depth};
    return true;
}
function scrDPRestore() {
    var _old=scrNTTEFullValue(id,"dp_original",undefined);
    if(!is_struct(_old)) return;
    sprite_index=_old.sprite;image_index=_old.index;image_xscale=_old.scale;depth=_old.depth;
    if(variable_struct_exists(_old,"shadow")) spr_shadow=_old.shadow;
    dp_original=undefined;
}
function scrDPStatic(_x,_y,_sprite,_index,_depth,_scale=1) {
    var _d=instance_create(_x,_y,DPStaticDecor);
    _d.sprite_index=_sprite;_d.image_index=_index;_d.image_speed=0;
    _d.depth=_depth;_d.image_xscale=_scale;_d.mask_index=mskNone;
    return _d;
}
function scrDPStatueSprites(_area) {
    switch(_area) {
        case area_desert:return [sprDPDesertProtoStatueDecal,sprDPDesertProtoStatueDecalDead];
        case area_scrapyards:return [sprDPScrapyardProtoStatueDecal,sprDPScrapyardProtoStatueDecalDead];
        case area_city:return [sprDPCityProtoStatueDecal,sprDPCityProtoStatueDecalDead];
        case area_palace:return [sprDPPalaceProtoStatueDecal,sprDPPalaceProtoStatueDecalDead];
        case 201:return [sprDPCoastProtoStatueDecal,sprDPCoastProtoStatueDecalDead];
        case 205:return [sprDPTrenchProtoStatueDecal,sprDPTrenchProtoStatueDecalDead];
    }
    return undefined;
}
function scrDPStatueEnsure(_owner,_sprites,_dead=false) {
    if(!is_array(_sprites) || !instance_exists(_owner)) return noone;
    var _found=noone;
    with(DPStatueDecor) if(dp_owner==_owner) {_found=id;break;}
    if(instance_exists(_found)) return _found;
    var _d=instance_create(_owner.x,_owner.y,DPStatueDecor);
    _d.dp_owner=_owner;_d.dp_dead=_dead;_d.dp_sprites=_sprites;
    _d.sprite_index=_sprites[_dead?1:0];_d.image_index=_dead?1:0;
    _d.image_speed=_dead?0:0.4*timescale;_d.depth=_dead?0:-1;
    _d.mask_index=mskNone;
    return _d;
}
function scrDPStatueCorpseLink(_owner,_corpse) {
    if(_owner.object_index!=ProtoStatue) return;
    _corpse.dp_statue_sprites=scrDPStatueSprites(GameCont.area);
    with(DPStatueDecor) if(dp_owner==_owner) {
        dp_owner=_corpse;dp_dead=true;sprite_index=dp_sprites[1];
        image_index=0;image_speed=0.4*timescale;depth=0;
    }
}
function scrDPStatueStep() {
    if(lockstep_stop) return;
    if(!instance_exists(dp_owner)) {instance_destroy();return;}
    if(dp_dead) {
        if(image_index+image_speed>=image_number) {image_index=image_number-1;image_speed=0;}
    } else {x=dp_owner.x;y=dp_owner.y;}
}
function scrDPStatueDraw() {
    var _fog=!dp_dead && instance_exists(dp_owner) && dp_owner.nexthurt>=current_frame+4;
    if(_fog) gpu_set_fog(true,c_white,0,0);
    draw_self();
    if(_fog) gpu_set_fog(false,0,0,0);
}
function scrDPScorchSprites(_floor) {
    switch(_floor) {
        case sprFloor1:return [[sprDPDesertScorchTop],[sprDPDesertScorch]];
        case sprFloor1B:case sprDPFloorDesertBOut:
            return [[sprDPDesertBScorchTop],[sprDPDesertBScorch]];
        case sprFloor5:return [[sprDPCityScorchTop,sprDPCityScorchTop2],[sprDPCityScorch,sprDPCityScorch2]];
        case sprFloor5Explo:return [[sprDPCityScorchTop,sprDPCityScorchTop2],[sprDPCityExploScorch,sprDPCityExploScorch2]];
        case sprFloor5B:return [[sprDPCityBScorchTop,sprDPCityBScorchTop2],[sprDPCityBScorch,sprDPCityBScorch2]];
        case sprFloor0:return [[sprDPCampfireScorchTop],[sprDPCampfireScorch]];
        case sprFloor101:return [[sprDPOasisScorchTop],[sprDPOasisScorch]];
    }
    if(_floor==scrNTTERefSprite("FloorCoast")) return [[sprDPDesertScorchTop],[sprDPDesertScorch]];
    if(_floor==scrNTTERefSprite("FloorTrench")) return [[sprDPTrenchScorchTop],[sprDPTrenchScorch]];
    return undefined;
}
function scrDPScorchSync() {
    if(!scrDPEnabled()) {scrDPRestore();return;}
    if(is_struct(scrNTTEFullValue(id,"dp_original",undefined)) || sprite_index!=sprScorch) return;
    var _f=instance_nearest(x-16,y-16,Floor);
    if(!instance_exists(_f)) return;
    var _sprites=scrDPScorchSprites(_f.sprite_index);
    if(!is_array(_sprites)) return;
    scrDPRemember();
    var _seed=random_get_seed();
    dp_variant=irandom(array_length(_sprites[0])-1);dp_flip=choose(1,-1);
    random_set_seed(_seed);
    sprite_index=_sprites[1][dp_variant];image_xscale=dp_flip;
    dp_scorch_top=_sprites[0][dp_variant];
}
function scrDPScorchTopDraw() {
    if(scrDPEnabled() && is_struct(scrNTTEFullValue(id,"dp_original",undefined)))
        draw_sprite_ext(dp_scorch_top,image_index,x,y,dp_flip,1,0,c_white,1);
    else draw_sprite(sprScorchTop,image_index,x,y);
}
function scrDPApply(_generation=false) {
    if(!instance_exists(GameCont) || instance_exists(Menu) || instance_exists(MenuGen)
        || (!_generation && instance_exists(GenCont))) return false;
    var _on=scrDPEnabled(),_seed=random_get_seed();
    try {
        if(!_on) {
            with(DPStaticDecor) instance_destroy(id,false);
            with(DPStatueDecor) instance_destroy(id,false);
            with(Detail) {
                if(scrNTTEFullValue(id,"dp_added",false)) instance_destroy(id,false);
                else scrDPRestore();
            }
            with(Floor) scrDPRestore();
            with(Wall) scrDPRestore();
            with(ProtoStatue) scrDPRestore();
            with(Scorch) scrDPRestore();
            return true;
        }
        var _area=GameCont.area,_statues=scrDPStatueSprites(_area);
        if(is_array(_statues)) with(ProtoStatue) {
            if(scrDPRemember()) {dp_original.shadow=spr_shadow;depth=1;spr_shadow=mskNone;}
            scrDPStatueEnsure(id,_statues);
        }
        with(Corpse) {
            var _sprites=scrNTTEFullValue(id,"dp_statue_sprites",undefined);
            if(is_array(_sprites)) scrDPStatueEnsure(id,_sprites,true);
        }
        var _details=scrNTTEFullInstances(Detail);
        for(var _i=0;_i<array_length(_details);++_i) with(_details[_i]) {
            if(scrNTTEFullValue(id,"dp_added",false) || !scrDPRemember()) continue;
            if(_area==area_desert && random(3)<1) {sprite_index=sprDPDetailDesertB;continue;}
            // Only original Detail instances expand. Children never recurse.
            repeat(irandom_range(0,13)) {
                var _dx=x+random_range(-18,18),_dy=y+random_range(-18,18);
                var _d=instance_create(_dx,_dy,Detail);
                if(instance_exists(_d)) {
                    _d.dp_added=true;_d.sprite_index=sprite_index;
                    if(!place_meeting(_dx,_dy,Floor)) instance_destroy(_d,false);
                }
            }
        }
        if(_area==area_desert) with(Floor) if(styleb && scrDPRemember()) {
            depth=8;sprite_index=sprDPFloorDesertBOut;image_index=irandom(image_number-1);
            scrDPStatic(x+choose(0,1,-1),y-1,sprDPSnowFloorDesertB,image_index,depth+1);
            if(random(6)<1) {
                var _big=random(2)<1,_spr=_big?sprDPDetailDesertMudBig:sprDPDetailDesertMudB,
                    _xx=x+(_big?16+random_range(-6,6):random(32)),
                    _yy=y+(_big?16+random_range(-6,6):random(32)),_index=irandom(sprite_get_number(_spr)-1);
                if(!_big && random(3)<1) _index=choose(4,5);
                scrDPStatic(_xx,_yy,_spr,_index,depth-1,choose(-1,1));
            }
            var _walls=ds_list_create();
            try {
                collision_rectangle_list(x,y-16,x+24,y+32,Wall,false,true,_walls,false);
                for(var _j=0;_j<ds_list_size(_walls);++_j) with(_walls[| _j]) {
                    // The source rectangle selects wall origins, not bbox overlap.
                    if(x<other.x || x>other.x+24 || y<other.y-16 || y>other.y+32) continue;
                    if(sprite_index==sprWall1Bot && scrDPRemember()) sprite_index=sprDPWallDesertBotB;
                }
            } finally {ds_list_destroy(_walls);}
        }
        if(_area==area_oasis || _area==202) with(Floor) if(styleb && sprite_index==sprFloor101B && scrDPRemember()) {
            sprite_index=sprDPFloorOasisBOut;image_index=choose(0,1);
        }
        with(Scorch) scrDPScorchSync();
        return true;
    } finally {random_set_seed(_seed);}
}
function scrDPOptionsChanged() {
    var _on=scrDPEnabled();
    if(scrNTTEFullValue(global,"dp_option_last",undefined)==_on) return;
    global.dp_option_last=_on;scrDPApply();
}
function scrDPLevelTick() {
    if(!scrNTTEFullValue(id,"dp_level_synced",false) && !instance_exists(GenCont) && !instance_exists(Menu)) {
        dp_level_synced=scrDPApply();
    }
}
