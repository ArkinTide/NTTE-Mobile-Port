// Focused consumer of Defpack Tools draw_bloom lines501..515, source hash
// 834848d637cc87ea5e40795e776d8da7077943a32e6f3fa6ab7c5596388ae669.
// Five vendored factories assign these exact defbloom records. The other
// original draw_bloom branches only concern unimported Defpack weapons.
function scrFRIrisBloomDraw() {
    if(!scrFREnabled()) return;
    // The source-family query includes CustomSlash and de-duplicates any
    // overlapping selectors while retaining native Slash collisions.
    var _actors=scrFRInstances([FRCustomProjectile,FRCustomObject]);
    for(var _i=0;_i<array_length(_actors);++_i) {
        var _actor=_actors[_i];
        if(!variable_instance_exists(_actor,"defbloom") || is_undefined(_actor.defbloom)) continue;
        with(_actor) {
            var _sprite=scrFRLQGet(defbloom,"sprite",sprite_index),
                _angle=scrFRLQGet(defbloom,"angle",image_angle);
            draw_sprite_ext(_sprite,image_index,x,y,defbloom.xscale*image_xscale,
                defbloom.yscale*image_yscale,_angle,image_blend,defbloom.alpha*image_alpha);
        }
    }
}
