varying vec2 v_vTexcoord;
void main() {
    // Original Unblend argument[2] sets blendPower=1/pow(2,2)=1/4.
    vec4 rgba=texture2D(gm_BaseTexture,v_vTexcoord);
    if(rgba.a>0.0) rgba=vec4(rgba.rgb/pow(abs(rgba.a),0.75),pow(abs(rgba.a),0.25));
    gl_FragColor=rgba;
}
