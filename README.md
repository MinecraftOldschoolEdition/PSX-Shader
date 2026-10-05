# PSX

Enable this resource pack, then select **PSX** in **Video Settings → Shaders** (Vulkan).
Its **Geometry and Textures** and **Display and Color** settings are saved only for this pack.

Low Resolution defaults to **720p** (1280×720 in a 16:9 window), with 360p, 540p
and 1080p choices. It preserves the window's aspect ratio and never exceeds the
source image resolution. HUD, menus and first-person model edges remain at native
resolution.

The independent Geometry Grid defaults to 320×240, with 384×240 and 640×480
choices. Full-cube terrain uses projected vertex snapping, affine texture
and vertex-color interpolation, and unfiltered texels. Camera motion naturally
makes those vertices wobble; there is no random jitter. A per-block geometry marker also enables these effects on CPU-built terrain
without applying them to detailed models sharing the same draw batch.

Clouds, entities, held items, torches, stairs, fences and other detailed block
models retain their original geometry, perspective-correct interpolation and
texture sampling. RGB555 color reduction and the PS1 signed 4×4 dither matrix
still apply; PSX Hand Colors controls those effects on held items. Turning Low
Resolution off retains native-resolution world pixels with the selected terrain
geometry and color effects. Existing geometry-grid preferences are preserved.

This recreates specific GPU traits, not a PlayStation emulator. Minecraft retains
its depth buffer, geometry, textures, lighting, transparency and gameplay. The pack
does not emulate ordering tables, texture palettes/VRAM, GTE arithmetic overflow,
interlace, or PS1 blend modes. Temporal upscaling can soften the intended effect;
native rendering gives the clearest result.

Hardware reference: [PSX-SPX GPU](https://psx-spx.consoledev.net/graphicsprocessingunitgpu/)
and [GTE](https://psx-spx.consoledev.net/geometrytransformationenginegte/).

Geometry Grid and Low Resolution Quality are stepped sliders. Drag a handle or
click the track; changes apply on release. Arrow keys adjust one step, and Home/End
select the endpoints after focusing a slider. This version requires the client
with shader sliders and CPU terrain geometry classification.
