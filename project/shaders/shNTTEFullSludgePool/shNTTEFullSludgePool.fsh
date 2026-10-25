varying vec2 v_vTexcoord;
uniform vec2 pixelSize;
uniform vec3 sludgeRGB;
void main() {
    vec4 rgba = texture2D(gm_BaseTexture,v_vTexcoord);
    vec4 south = texture2D(gm_BaseTexture,v_vTexcoord+vec2(0.0,pixelSize.y));
    // Compare 8-bit channels as in source. Quantization avoids mobile shader
    // precision changing exact integer RGB equality for representable pixels.
    vec3 rgb8 = floor(rgba.rgb*255.0+0.5);
    vec3 sludge8 = floor(sludgeRGB*255.0+0.5);
    vec3 south8 = floor(south.rgb*255.0+0.5);
    if(all(equal(rgb8,sludge8)) && all(equal(south8,vec3(133.0,249.0,26.0))))
        gl_FragColor=rgba;
    else gl_FragColor=vec4(0.0);
}
