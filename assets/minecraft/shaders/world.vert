#version 450
#include "lib/interpolation.glsl"
#define main psxBuiltinMain
#include <builtin>
#undef main
#include "lib/display.glsl"
layout(location = 13) flat out float psxTerrainMask;
#include "lib/role.glsl"
layout(location = 10) noperspective out vec2 psxScreenUv;
layout(location = 11) smooth out vec2 psxPerspectiveUv;
layout(location = 12) smooth out vec4 psxPerspectiveColor;
void main() {
    psxBuiltinMain();
    psxTerrainMask = 0.0;
#ifdef MCOSE_TERRAIN_CUBE_INPUT
    psxTerrainMask = mcoseTerrainCube() ? 1.0 : 0.0;
#endif
    psxPerspectiveUv = fragUv;
    psxPerspectiveColor = fragColor;
    // Preserve homogeneous depth and clipping. Never quantize a point behind the eye.
#if MCOSE_WOBBLE
    if (psxTerrainDraw() && gl_Position.w > 0.0001) {
        vec2 grid = psxResolution();
        vec2 pixel = (gl_Position.xy / gl_Position.w * 0.5 + 0.5) * grid;
        gl_Position.xy = (floor(pixel) / grid * 2.0 - 1.0) * gl_Position.w;
    }
#endif
    psxScreenUv = gl_Position.xy / max(abs(gl_Position.w), 0.0001) * 0.5 + 0.5;
}
