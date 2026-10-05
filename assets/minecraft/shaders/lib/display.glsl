vec2 psxResolution() {
#if MCOSE_RESOLUTION == 1
    return vec2(384.0, 240.0);
#elif MCOSE_RESOLUTION == 2
    return vec2(640.0, 480.0);
#else
    return vec2(320.0, 240.0);
#endif
}
// GP0(E1h): signed offset in 8-bit color space, then saturate and truncate to RGB555.
const int psxDither[16] = int[16](
    -4,  0, -3,  1,
     2, -2,  3, -1,
    -3,  1, -4,  0,
     3, -1,  2, -2);
vec3 psxColor(vec3 rgb, vec2 pixel) {
#if MCOSE_RGB555
    float offset = 0.0;
#if MCOSE_DITHER
    ivec2 p = ivec2(floor(pixel)) & ivec2(3);
    offset = float(psxDither[p.y * 4 + p.x]);
#endif
    return floor(clamp(floor(rgb * 255.0 + 0.5) + offset, 0.0, 255.0) / 8.0) / 31.0;
#else
    return rgb;
#endif
}
