varying vec2 v_vTexcoord;
uniform vec2 pixelSize;
bool eye(vec3 rgb) {
    if(rgb.r<=rgb.g+rgb.b) return false;
    vec3 c=floor(rgb*255.0+0.5);
    return all(equal(c,vec3(252,56,0))) || all(equal(c,vec3(199,0,0)))
        || all(equal(c,vec3(95,0,0))) || all(equal(c,vec3(163,5,5)))
        || all(equal(c,vec3(105,3,3))) || all(equal(c,vec3(255,0,0)))
        || all(equal(c,vec3(165,9,43))) || all(equal(c,vec3(194,42,0)))
        || all(equal(c,vec3(122,27,0))) || all(equal(c,vec3(156,20,31)))
        || all(equal(c,vec3(255,134,47))) || all(equal(c,vec3(99,9,17)))
        || all(equal(c,vec3(112,0,17))) || all(equal(c,vec3(210,32,71)))
        || all(equal(c,vec3(179,27,60)));
}
void main() {
    vec4 rgba=texture2D(gm_BaseTexture,v_vTexcoord);
    if(rgba.r>rgba.g+rgba.b && (eye(rgba.rgb)
        || eye(texture2D(gm_BaseTexture,v_vTexcoord-vec2(pixelSize.x,0.0)).rgb)
        || eye(texture2D(gm_BaseTexture,v_vTexcoord+vec2(pixelSize.x,0.0)).rgb)
        || eye(texture2D(gm_BaseTexture,v_vTexcoord-vec2(0.0,pixelSize.y)).rgb)
        || eye(texture2D(gm_BaseTexture,v_vTexcoord+vec2(0.0,pixelSize.y)).rgb)))
        gl_FragColor=rgba.grba;
    else gl_FragColor=vec4(0.0);
}
