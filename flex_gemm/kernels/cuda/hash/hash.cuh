#define K_EMPTY 0xffffffff


// 32 bit Murmur3 hash
__forceinline__ __device__ uint32_t hash(uint32_t k, uint32_t N) {
    k ^= k >> 16;
    k *= 0x85ebca6b;
    k ^= k >> 13;
    k *= 0xc2b2ae35;
    k ^= k >> 16;
    return k % N;
}


__forceinline__ __device__ void linear_probing_insert(
    uint32_t* hashmap,
    const uint32_t keys,
    const uint32_t values,
    const int64_t N
) {
    uint32_t slot = hash(keys, N);
    while (true) {
        uint32_t prev = atomicCAS(&hashmap[slot], K_EMPTY, keys);
        if (prev == K_EMPTY || prev == keys) {
            hashmap[slot + N] = values;
            return;
        }
        slot = (slot + 1) % N;
    }
}


__forceinline__ __device__ uint32_t linear_probing_lookup(
    const uint32_t* hashmap,
    const uint32_t keys,
    const int64_t N
) {
    uint32_t slot = hash(keys, N);
    while (true) {
        uint32_t prev = hashmap[slot];
        if (prev == K_EMPTY) {
            return K_EMPTY;
        }
        if (prev == keys) {
            return hashmap[slot + N];
        }
        slot = (slot + 1) % N;
    }
}
