#version 450
#include "lib/interpolation.glsl"
vec4 psxTexture(sampler2D image, vec2 uv);
#define texture psxTexture
// Shadow the built-in main's inputs with the chosen interpolation. Its original
// lighting, alpha test and cloud-face logic consume those intact values.
#define main() psxBuiltinMain(vec2 fragUv, vec4 fragColor)
#include <builtin>
#undef main
#undef texture
#include "lib/display.glsl"
layout(location = 13) flat in float psxTerrainMask;
#include "lib/role.glsl"
layout(location = 10) noperspective in vec2 psxScreenUv;
layout(location = 11) smooth in vec2 psxPerspectiveUv;
layout(location = 12) smooth in vec4 psxPerspectiveColor;
vec4 psxTexture(sampler2D image, vec2 uv) {
#if MCOSE_NEAREST
    if (psxTerrainDraw()) {
        ivec2 size = textureSize(image, 0);
        return texelFetch(image, min(ivec2(fract(uv) * vec2(size)), size - 1), 0);
    }
#endif
    return texture(image, uv);
}
void main() {
    bool terrain = psxTerrainDraw();
    psxBuiltinMain(terrain ? fragUv : psxPerspectiveUv,
                   terrain ? fragColor : psxPerspectiveColor);
    if (psxWorldDraw()) outColor.rgb = psxColor(outColor.rgb, psxScreenUv * psxResolution());
}
