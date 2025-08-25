#include <torch/extension.h>
#include "hash/api.h"
#include "spconv/api.h"


PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
    // Hash functions
    m.def("hashmap_insert_cuda", &hashmap_insert_cuda);
    m.def("hashmap_lookup_cuda", &hashmap_lookup_cuda);
    m.def("hashmap_insert_3d_cuda", &hashmap_insert_3d_cuda);
    m.def("hashmap_lookup_3d_cuda", &hashmap_lookup_3d_cuda);
   
    // Convolution functions
    m.def("hashmap_build_submanifold_conv_neighbour_map_cuda", &hashmap_build_submanifold_conv_neighbour_map_cuda);
    m.def("neighbor_map_post_process_for_masked_implicit_gemm_1", &neighbor_map_post_process_for_masked_implicit_gemm_1);
    m.def("neighbor_map_post_process_for_masked_implicit_gemm_2", &neighbor_map_post_process_for_masked_implicit_gemm_2);
}
