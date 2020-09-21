#include <bindings.cmacros.h>
#include <stdint.h>
#include <rdma/fabric.h>

BC_INLINE1(fi_tc_dscp_set, uint8_t, uint32_t)
BC_INLINE1(fi_tc_dscp_get, uint32_t, uint8_t)
BC_INLINE1(fi_allocinfo, void, struct fi_info*)
BC_INLINE1(fi_close, void*, int)
BC_INLINE3(fi_control, void*, int, void*, int)
BC_INLINE3(fi_alias, struct fid*, struct fid**, uint64_t, int)
BC_INLINE5(fi_open_ops, void*, const char*, uint64_t, void**, void*, int)
BC_INLINE5(fi_set_ops, void*, const char*, uint64_t, void*, void*, int)
