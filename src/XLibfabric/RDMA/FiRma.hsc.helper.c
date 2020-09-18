#include <bindings.cmacros.h>

BC_INLINE8(fi_read, void*, void*, size_t, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE8(fi_readv, void*, const *, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE3(fi_readmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE8(fi_write, void*, const *, size_t, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE8(fi_writev, void*, const *, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE3(fi_writemsg, void*, const *, uint64_t, ssize_t)
BC_INLINE6(fi_inject_write, void*, const *, size_t, fi_addr_t, uint64_t, uint64_t, ssize_t)
BC_INLINE9(fi_writedata, void*, const *, size_t, void*, uint64_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE7(fi_inject_writedata, void*, const *, size_t, uint64_t, fi_addr_t, uint64_t, uint64_t, ssize_t)
