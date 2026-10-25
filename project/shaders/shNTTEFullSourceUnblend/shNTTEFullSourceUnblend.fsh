varying vec2 v_vTexcoord;
uniform float blendPower;
void main() {
    vec4 rgba=texture2D(gm_BaseTexture,v_vTexcoord);
    if(rgba.a>0.0) {
        float factor=pow(abs(rgba.a),1.0-blendPower);
        rgba=vec4(rgba.rgb/factor,pow(abs(rgba.a),blendPower));
    }
    gl_FragColor=rgba;
}
