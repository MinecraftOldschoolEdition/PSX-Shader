bool psxWorldDraw() {
    int flags = int(pushData.params0.y);
    return (flags & 32) != 0
#if MCOSE_HAND
        || (flags & 4) != 0
#endif
        ;
}

// GPU chunks contain only supported cubes. CPU batches carry per-block geometry
// classification so a torch and a stone cube can safely share one draw.
bool psxTerrainDraw() {
    return (int(pushData.params0.y) & 32) != 0
        && ((pushData.params0.x > 1.5 && pushData.params0.x < 2.5)
            || (pushData.params0.x > 0.5 && pushData.params0.x < 1.5 && psxTerrainMask > 0.5));
}
