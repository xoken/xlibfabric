#include <bindings.cmacros.h>
#include <rdma/fi_domain.h>
#include <stdint.h>

BC_INLINE4(fi_domain, void*, void*, void**, void*, int)
BC_INLINE3(fi_domain_bind, void*, void*, uint64_t, int)
BC_INLINE4(fi_cq_open, void*, void*, void**, void*, int)
BC_INLINE4(fi_cntr_open, void*, void*, void**, void*, int)
BC_INLINE3(fi_wait_open, void*, void*, void**, int)
BC_INLINE3(fi_poll_open, void*, void*, void**, int)
BC_INLINE9(fi_mr_reg, void*, const *, size_t, uint64_t, uint64_t, uint64_t, uint64_t, void**, void*, int)
BC_INLINE9(fi_mr_regv, void*, const *, size_t, uint64_t, uint64_t, uint64_t, uint64_t, void**, void*, int)
BC_INLINE4(fi_mr_regattr, void*, const *, uint64_t, void**, int)
BC_INLINE1(fi_mr_desc, void*, void*)
BC_INLINE1(fi_mr_key, void*, uint64_t)
BC_INLINE5(fi_mr_raw_attr, void*, uint64_t*, uint8_t*, size_t*, uint64_t, int)
BC_INLINE6(fi_mr_map_raw, void*, uint64_t, uint8_t*, size_t, uint64_t*, uint64_t, int)
BC_INLINE2(fi_mr_unmap_key, void*, uint64_t, int)
BC_INLINE3(fi_mr_bind, void*, void*, uint64_t, int)
BC_INLINE4(fi_mr_refresh, void*, const *, size_t, uint64_t, int)
BC_INLINE1(fi_mr_enable, void*, int)
BC_INLINE4(fi_av_open, void*, void*, void**, void*, int)
BC_INLINE3(fi_av_bind, void*, void*, uint64_t, int)
BC_INLINE6(fi_av_insert, void*, const *, size_t, fi_addr_t*, uint64_t, void*, int)
BC_INLINE6(fi_av_insertsvc, void*, const char*, const char*, fi_addr_t*, uint64_t, void*, int)
BC_INLINE8(fi_av_insertsym, void*, const char*, size_t, const char*, size_t, fi_addr_t*, uint64_t, void*, int)
BC_INLINE4(fi_av_remove, void*, fi_addr_t*, size_t, uint64_t, int)
BC_INLINE4(fi_av_lookup, void*, fi_addr_t, void*, size_t*, int)
BC_INLINE4(fi_av_straddr, void*, const *, char*, size_t*, const char*)
BC_INLINE3(fi_rx_addr, fi_addr_t, int, int, fi_addr_t)
