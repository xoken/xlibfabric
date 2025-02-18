#include <bindings.cmacros.h>
#include <stdint.h>
#include <rdma/fi_atomic.h>

BC_INLINE10(fi_atomic, void*, const *, size_t, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE10(fi_atomicv, void*, const *, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE3(fi_atomicmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE8(fi_inject_atomic, void*, const *, size_t, fi_addr_t, uint64_t, uint64_t, ssize_t)
BC_INLINE12(fi_fetch_atomic, void*, const *, size_t, void*, void*, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE13(fi_fetch_atomicv, void*, const *, void**, size_t, void*, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE6(fi_fetch_atomicmsg, void*, const *, void*, void**, size_t, uint64_t, ssize_t)
BC_INLINE14(fi_compare_atomic, void*, const *, size_t, void*, const *, void*, void*, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE16(fi_compare_atomicv, void*, const *, void**, size_t, const *, void**, size_t, void*, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE9(fi_compare_atomicmsg, void*, const *, const *, void**, size_t, void*, void**, size_t, uint64_t, ssize_t)
BC_INLINE4(fi_atomicvalid, void*, size_t*, int)
BC_INLINE4(fi_fetch_atomicvalid, void*, size_t*, int)
BC_INLINE4(fi_compare_atomicvalid, void*, size_t*, int)
BC_INLINE5(fi_query_atomic, void*, void*, uint64_t, int)
