#include <bindings.cmacros.h>
#include <stdint.h>

BC_INLINE8(fi_trecv, void*, void*, size_t, void*, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE8(fi_trecvv, void*, const *, void**, size_t, fi_addr_t, uint64_t, uint64_t, void*, ssize_t)
BC_INLINE3(fi_trecvmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE7(fi_tsend, void*, const *, size_t, void*, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE7(fi_tsendv, void*, const *, void**, size_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE3(fi_tsendmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE5(fi_tinject, void*, const *, size_t, fi_addr_t, uint64_t, ssize_t)
BC_INLINE8(fi_tsenddata, void*, const *, size_t, void*, uint64_t, fi_addr_t, uint64_t, void*, ssize_t)
BC_INLINE6(fi_tinjectdata, void*, const *, size_t, uint64_t, fi_addr_t, uint64_t, ssize_t)
