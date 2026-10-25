// Source ntte3242..3309 and5474..5565. Capacity is a live fixed slot array;
// map metadata survives player death and is separate from physical pet IDs.
function scrNTTEFullPetIconSprite(_pet,_skin=0) {
    var _name="Pet"+_pet+"Icon"
    switch(_pet) {
        case "Parrot":if(_skin==1) _name="PetParrotBIcon";break
        case "CoolGuy":if(_skin=="peas") _name="PetPeasIcon";break
        case "Spider":if(_skin==1) _name="PetSpiderCursedIcon";break
        case "Weapon":if(_skin==1) _name="PetWeaponCursedIcon";break
        // Source Twins_sprite outside an actual Pet context returns the
        // combined icon; the roadmap stores species/skin, not an instance.
        case "Twins":_name="PetTwinsIcon";break
    }
    return scrNTTERefSprite(_name)
}
function scrNTTEFullPetPlayerSystemsStep() {
    if(!instance_exists(GameCont) || !instance_exists(Player)) return;
    if(!variable_instance_exists(GameCont,"ntte_pet_max")) GameCont.ntte_pet_max=1
    if(!is_array(scrNTTEFullValue(GameCont,"ntte_pet_icon",undefined))) GameCont.ntte_pet_icon=[]
    if(!variable_global_exists("pet_max")) global.pet_max=GameCont.ntte_pet_max
    if(!variable_global_exists("pet_max_last")) global.pet_max_last=global.pet_max
    if(global.pet_max!=global.pet_max_last) GameCont.ntte_pet_max+=global.pet_max-global.pet_max_last
    global.pet_max=GameCont.ntte_pet_max;global.pet_max_last=global.pet_max
    with(Player) {
        if(!is_array(scrNTTEFullValue(id,"ntte_pet",undefined))) ntte_pet=[]
        if(!is_numeric(scrNTTEFullValue(id,"ntte_pet_max",undefined))) ntte_pet_max=GameCont.ntte_pet_max
        var _max=max(0,ntte_pet_max)
        while(array_length(ntte_pet)<_max) array_push(ntte_pet,noone)
        while(array_length(ntte_pet)>_max) {
            var _empty=-1
            for(var _slot=0;_slot<array_length(ntte_pet);++_slot) if(!instance_exists(ntte_pet[_slot])) {_empty=_slot;break}
            if(_empty>=0) {array_delete(ntte_pet,_empty,1);continue}
            var _last=array_pop(ntte_pet)
            if(instance_exists(_last)) {
                _last.leader=noone;_last.can_take=true;_last.persistent=false
                var _fx=instance_create(_last.x+_last.hspeed,_last.y+_last.vspeed,HealFX)
                _fx.sprite_index=scrNTTERefSprite("PetLost");_fx.image_xscale=choose(-1,1)
                _fx.image_speed=0.5*timescale;_fx.friction=timescale*timescale/8;_fx.depth=-9
            }
        }
        var _icons=undefined
        for(var _slot=0;_slot<array_length(ntte_pet);++_slot) if(instance_exists(ntte_pet[_slot])) {
            var _pet=ntte_pet[_slot]
            if(is_undefined(_icons)) _icons=[]
            array_push(_icons,[_pet.pet,_pet.mod_type,_pet.mod_name,_pet.bskin])
        }
        GameCont.ntte_pet_icon[index]=_icons
    }
}
function scrNTTEFullPetMapLayout(_index,_x,_y) {
    var _rows=[],_lists=scrNTTEFullValue(GameCont,"ntte_pet_icon",undefined)
    if(!is_array(_lists) || _index<0 || _index>=array_length(_lists) || !is_array(_lists[_index])) return _rows
    var _angle=30,_direction=0,_distance=10
    if(player_count>1) {
        var _d=90-360/player_count*_index
        if(player_count==2) _d+=45
        _x+=lengthdir_x(2*player_count,_d);_y+=lengthdir_y(2*player_count,_d);_angle=_d
    }
    for(var _i=0;_i<array_length(_lists[_index]);++_i) {
        var _icon=_lists[_index][_i],_sprite=scrNTTEFullPetGetSprite(_icon[0],_icon[1],_icon[2],_icon[3],"icon")
        if(sprite_exists(_sprite)) array_push(_rows,{sprite:_sprite,image:0.4*current_frame,
            x:_x+floor(lengthdir_x(_distance,_angle+_direction)),y:_y+floor(lengthdir_y(_distance,_angle+_direction))})
        _direction+=60/(1+floor(_direction/360))
        if((_direction mod 360)==0) _distance+=8
    }
    return _rows
}
function scrNTTEFullPetMapDraw(_index,_x,_y) {
    var _rows=scrNTTEFullPetMapLayout(_index,_x,_y),_color=instance_exists(Menu)?merge_color(c_white,c_black,0.9):c_white
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _r=_rows[_i]
        draw_sprite_ext(_r.sprite,_r.image,_r.x,_r.y,1,1,0,_color,1)
    }
}
