varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D pitMask;
void main() {
    float coverage=texture2D(pitMask,v_vTexcoord).a;
    if(coverage<=0.0) discard;
    vec3 rgb=texture2D(gm_BaseTexture,v_vTexcoord).rgb;
    gl_FragColor=vec4(rgb*v_vColour.rgb,coverage*v_vColour.a);
}
