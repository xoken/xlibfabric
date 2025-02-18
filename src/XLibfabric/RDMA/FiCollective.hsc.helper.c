#include <bindings.cmacros.h>
#include <stdint.h>
#include <rdma/fi_collective.h>

BC_INLINE4(fi_av_set, void*, void*, void**, void*, int)
BC_INLINE2(fi_av_set_union, void*, const *, int)
BC_INLINE2(fi_av_set_intersect, void*, const *, int)
BC_INLINE2(fi_av_set_diff, void*, const *, int)
BC_INLINE2(fi_av_set_insert, void*, fi_addr_t, int)
BC_INLINE2(fi_av_set_remove, void*, fi_addr_t, int)
BC_INLINE2(fi_av_set_addr, void*, fi_addr_t*, int)
BC_INLINE6(fi_join_collective, void*, fi_addr_t, const *, uint64_t, void**, void*, int)
BC_INLINE3(fi_barrier, void*, fi_addr_t, void*, ssize_t)
BC_INLINE9(fi_broadcast, void*, void*, size_t, void*, fi_addr_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE10(fi_alltoall, void*, const *, size_t, void*, void*, void*, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE11(fi_allreduce, void*, const *, size_t, void*, void*, void*, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE10(fi_allgather, void*, const *, size_t, void*, void*, void*, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE11(fi_reduce_scatter, void*, const *, size_t, void*, void*, void*, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE12(fi_reduce, void*, const *, size_t, void*, void*, void*, fi_addr_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE11(fi_scatter, void*, const *, size_t, void*, void*, void*, fi_addr_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE11(fi_gather, void*, const *, size_t, void*, void*, void*, fi_addr_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE4(fi_query_collective, void*, void*, uint64_t, int)
