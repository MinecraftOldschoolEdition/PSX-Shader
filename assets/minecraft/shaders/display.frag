#version 450
#define main psxBuiltinMain
#include <builtin>
#undef main
#include "lib/display.glsl"
void main() {
#if MCOSE_PIXELATE
    vec2 sourceSize = vec2(textureSize(sceneSampler, 0));
#if MCOSE_DISPLAY_RESOLUTION == 0
    float height = 360.0;
#elif MCOSE_DISPLAY_RESOLUTION == 1
    float height = 540.0;
#elif MCOSE_DISPLAY_RESOLUTION == 3
    float height = 1080.0;
#else
    float height = 720.0;
#endif
    height = min(height, sourceSize.y);
    vec2 grid = vec2(max(1.0, floor(sourceSize.x * height / sourceSize.y + 0.5)), height);
    vec2 uv = (floor(fragUv * grid) + 0.5) / grid;
    ivec2 size = textureSize(sceneSampler, 0);
    ivec2 texel = clamp(ivec2(uv * vec2(size)), ivec2(0), size - 1);
    outColor = vec4(texelFetch(sceneSampler, texel, 0).rgb, 1.0);
#else
    psxBuiltinMain();
#endif
#if MCOSE_RGB555
    // Preserve already-dithered polygons, and quantize sky/blended output too.
    outColor.rgb = floor(clamp(outColor.rgb, 0.0, 1.0) * 31.0 + 0.5) / 31.0;
#endif
}
