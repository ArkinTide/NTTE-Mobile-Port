attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
void main() {
    v_vTexcoord=in_TextureCoord;
    v_vColour=in_Colour;
    gl_Position=gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position,1.0);
}
