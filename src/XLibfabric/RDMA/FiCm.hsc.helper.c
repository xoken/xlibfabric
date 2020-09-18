#include <bindings.cmacros.h>

BC_INLINE3(fi_setname, fid_t, void*, size_t, int)
BC_INLINE3(fi_getname, fid_t, void*, size_t*, int)
BC_INLINE3(fi_getpeer, void*, void*, size_t*, int)
BC_INLINE1(fi_listen, void*, int)
BC_INLINE4(fi_connect, void*, const *, const *, size_t, int)
BC_INLINE3(fi_accept, void*, const *, size_t, int)
BC_INLINE4(fi_reject, void*, fid_t, const *, size_t, int)
BC_INLINE2(fi_shutdown, void*, uint64_t, int)
BC_INLINE5(fi_join, void*, const *, uint64_t, void**, void*, int)
BC_INLINE1(fi_mc_addr, void*, fi_addr_t)
