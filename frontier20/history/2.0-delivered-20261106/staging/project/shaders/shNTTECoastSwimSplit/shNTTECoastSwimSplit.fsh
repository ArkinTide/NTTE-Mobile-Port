varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D gradientTex;
uniform vec4 captureRect;
uniform vec4 gradientRect;
uniform vec4 gradientUV;
uniform float sinkFactor;
uniform float whiteRow;
void main() {
    vec2 world=captureRect.xy+v_vTexcoord*captureRect.zw;
    vec2 uv=(world-gradientRect.xy)/gradientRect.zw;
    float maskAlpha=0.0;
    if(uv.x>=0.0 && uv.y>=0.0 && uv.x<1.0 && uv.y<1.0)
        maskAlpha=texture2D(gradientTex,mix(gradientUV.xy,gradientUV.zw,uv)).a;
    vec4 rgba=texture2D(gm_BaseTexture,v_vTexcoord)*(1.0-maskAlpha)*sinkFactor;
    rgba.rgb=mix(rgba.rgb,vec3(1.0),whiteRow);
    gl_FragColor=rgba*v_vColour;
}
