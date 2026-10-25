// ntte.mod1921..2049. Root pipeline calls this after actual world events and
// Silver Tongue crates, before TopSpawns. Source always consumes stray RNG.
function scrNTTEFullWallPropsLevelStart(_sx=10016,_sy=10016) {
    var _main=true,_mx=0,_my=0,_radius=48+16*GameCont.loops,_strays=8+irandom(4)+2*GameCont.loops,
        _walls=scrNTTEFullInstances(Wall),_eligible=[],_out={enemies:[],props:[]}
    for(var _i=0;_i<array_length(_walls);++_i) if(_walls[_i].topspr!=-1) array_push(_eligible,_walls[_i])
    _eligible=array_shuffle(_eligible)
    for(var _i=0;_i<array_length(_eligible);++_i) with(_eligible[_i]) {
        if(place_meeting(x,y,PortalClear) || place_meeting(x,y,TopPot)) continue
        switch(topspr) {
            case sprWall1Top:
                if(chance(1,400) && !place_meeting(x,y+16,Bones))
                    array_push(_out.enemies,scrNTTEFullWallEnemyCreateAt((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2))
                break
            case sprWall4Top:
                var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
                if(point_distance(_cx,_cy,_sx,_sy)>64) {
                    if(_main) {
                        _main=false;_mx=_cx;_my=_cy
                        var _enemy=scrNTTEFullWallEnemyCreateAt(_cx,_cy)
                        if(instance_exists(_enemy)) {
                            _enemy.special=true
                            with(_enemy.target) { sprite_index=scrNTTERefSprite("WallSpider");image_index=irandom(image_number-1) }
                            array_push(_out.enemies,_enemy)
                        }
                        sprite_index=scrNTTERefSprite("WallSpiderBot");image_index=irandom(image_number-1)
                        var _small=scrNTTEFullInstances(TopSmall)
                        for(var _j=0;_j<array_length(_small);++_j) with(_small[_j]) {
                            if(chance(1,3) && point_distance((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,_mx,_my)<=_radius)
                                array_push(_out.enemies,scrNTTEFullWallEnemyCreateAt((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2))
                        }
                    }
                    else if(chance(2,3) && point_distance(_cx,_cy,_mx,_my)<=_radius)
                        array_push(_out.enemies,scrNTTEFullWallEnemyCreateAt(_cx,_cy))
                    else if(_strays>0) {
                        _strays--
                        array_push(_out.enemies,scrNTTEFullWallEnemyCreateAt(_cx,_cy))
                    }
                }
                if(chance(1,12) && distance_to_object(TopPot)>64 && distance_to_object(Bones)>96)
                    array_push(_out.props,scrNTTEFullTopCreate(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),choose(Crystal,Crystal,Cocoon),-1,-1))
                break
            case sprWall100Top:
                if(chance(1,40)) array_push(_out.props,scrNTTEFullTopCreate(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Torch,-1,-1))
                break
            case sprWall104Top:
                // Epsilon combines original CrystalProp and InvCrystal in
                // native Crystal; the area palette supplies cursed coloration.
                if(chance(1,12) && distance_to_object(TopPot)>64 && distance_to_object(Bones)>96)
                    array_push(_out.props,scrNTTEFullTopCreate(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),choose(Crystal,Crystal,Cocoon),-1,-1))
                break
        }
    }
    _out.main_created=!_main;_out.main_x=_mx;_out.main_y=_my;_out.strays_left=_strays;_out.radius=_radius
    return _out
}
