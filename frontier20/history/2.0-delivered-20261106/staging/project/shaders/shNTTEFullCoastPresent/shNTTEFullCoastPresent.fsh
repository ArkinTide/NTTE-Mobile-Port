varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 waterTint;
void main() {
    vec4 texel=texture2D(gm_BaseTexture,v_vTexcoord);
    // In particular, never turn empty framebuffer pixels into opaque fog.
    if(texel.a<=0.0) discard;
    vec3 rgb=mix(texel.rgb,waterTint.rgb,waterTint.a);
    gl_FragColor=vec4(rgb*v_vColour.rgb,texel.a*v_vColour.a);
}
