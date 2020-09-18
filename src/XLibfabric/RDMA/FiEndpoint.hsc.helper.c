#include <bindings.cmacros.h>

BC_INLINE4(fi_passive_ep, void*, void*, void**, void*, int)
BC_INLINE4(fi_endpoint, void*, void*, void**, void*, int)
BC_INLINE4(fi_scalable_ep, void*, void*, void**, void*, int)
BC_INLINE3(fi_ep_bind, void*, void*, uint64_t, int)
BC_INLINE3(fi_pep_bind, void*, void*, uint64_t, int)
BC_INLINE3(fi_scalable_ep_bind, void*, void*, uint64_t, int)
BC_INLINE1(fi_enable, void*, int)
BC_INLINE2(fi_cancel, fid_t, void*, ssize_t)
BC_INLINE5(fi_setopt, fid_t, int, int, const *, size_t, int)
BC_INLINE5(fi_getopt, fid_t, int, int, void*, size_t*, int)
BC_INLINE3(fi_ep_alias, void*, void**, uint64_t, int)
BC_INLINE5(fi_tx_context, void*, int, void*, void**, void*, int)
BC_INLINE5(fi_rx_context, void*, int, void*, void**, void*, int)
BC_INLINE1(fi_rx_size_left, void*, ssize_t)
BC_INLINE1(fi_tx_size_left, void*, ssize_t)
BC_INLINE4(fi_stx_context, void*, void*, void**, void*, int)
BC_INLINE4(fi_srx_context, void*, void*, void**, void*, int)
BC_INLINE6(fi_recv, void*, void*, size_t, void*, fi_addr_t, void*, ssize_t)
BC_INLINE6(fi_recvv, void*, const *, void**, size_t, fi_addr_t, void*, ssize_t)
BC_INLINE3(fi_recvmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE6(fi_send, void*, const *, size_t, void*, fi_addr_t, void*, ssize_t)
BC_INLINE6(fi_sendv, void*, const *, void**, size_t, fi_addr_t, void*, ssize_t)
BC_INLINE3(fi_sendmsg, void*, const *, uint64_t, ssize_t)
BC_INLINE4(fi_inject, void*, const *, size_t, fi_addr_t, ssize_t)
BC_INLINE7(fi_senddata, void*, const *, size_t, void*, uint64_t, fi_addr_t, void*, ssize_t)
BC_INLINE5(fi_injectdata, void*, const *, size_t, uint64_t, fi_addr_t, ssize_t)
