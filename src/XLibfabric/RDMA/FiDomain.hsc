{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_domain.h>
module XLibfabric.RDMA.FiDomain where
import XLibfabric.RDMA.FiEq hiding (C'fi_cntr_attr, C'fi_cq_attr)
import XLibfabric.RDMA.Fabric hiding (C'fid_cntr, C'fid_cq, C'fid_eq, C'fi_eq_attr, C'fid_poll, C'fid_wait, C'fi_wait_attr, C'fid_av, C'fid_domain, C'fid_mr)
import Foreign.Ptr
import Common
#strict_import

{- struct fi_av_attr {
    enum fi_av_type type;
    int rx_ctx_bits;
    size_t count;
    size_t ep_per_node;
    const char * name;
    void * map_addr;
    uint64_t flags;
}; -}
#starttype struct fi_av_attr
#field type , <enum fi_av_type>
#field rx_ctx_bits , CInt
#field count , CSize
#field ep_per_node , CSize
#field name , CString
#field map_addr , Ptr ()
#field flags , CULong
#stoptype
{- struct fi_av_set_attr {
    size_t count;
    fi_addr_t start_addr;
    fi_addr_t end_addr;
    uint64_t stride;
    size_t comm_key_size;
    uint8_t * comm_key;
    uint64_t flags;
}; -}
#starttype struct fi_av_set_attr
#field count , CSize
#field start_addr , CULong
#field end_addr , CULong
#field stride , CULong
#field comm_key_size , CSize
#field comm_key , Ptr CUChar
#field flags , CULong
#stoptype
{- struct fid_av_set; -}
#opaque_t struct fid_av_set
{- struct fi_ops_av {
    size_t size;
    int (* insert)(struct fid_av * av,
                   const void * addr,
                   size_t count,
                   fi_addr_t * fi_addr,
                   uint64_t flags,
                   void * context);
    int (* insertsvc)(struct fid_av * av,
                      const char * node,
                      const char * service,
                      fi_addr_t * fi_addr,
                      uint64_t flags,
                      void * context);
    int (* insertsym)(struct fid_av * av,
                      const char * node,
                      size_t nodecnt,
                      const char * service,
                      size_t svccnt,
                      fi_addr_t * fi_addr,
                      uint64_t flags,
                      void * context);
    int (* remove)(struct fid_av * av,
                   fi_addr_t * fi_addr,
                   size_t count,
                   uint64_t flags);
    int (* lookup)(struct fid_av * av,
                   fi_addr_t fi_addr,
                   void * addr,
                   size_t * addrlen);
    const char * (* straddr)(struct fid_av * av,
                             const void * addr,
                             char * buf,
                             size_t * len);
    int (* av_set)(struct fid_av * av,
                   struct fi_av_set_attr * attr,
                   struct fid_av_set * * av_set,
                   void * context);
}; -}
#starttype struct fi_ops_av
#field size , CSize
#field insert , FunPtr (Ptr <struct fid_av> -> Ptr () -> CSize -> Ptr CULong -> CULong -> Ptr () -> CInt)
#field insertsvc , FunPtr (Ptr <struct fid_av> -> CString -> CString -> Ptr CULong -> CULong -> Ptr () -> CInt)
#field insertsym , FunPtr (Ptr <struct fid_av> -> CString -> CSize -> CString -> CSize -> Ptr CULong -> CULong -> Ptr () -> CInt)
#field remove , FunPtr (Ptr <struct fid_av> -> Ptr CULong -> CSize -> CULong -> CInt)
#field lookup , FunPtr (Ptr <struct fid_av> -> CULong -> Ptr () -> Ptr CSize -> CInt)
#field straddr , FunPtr (Ptr <struct fid_av> -> Ptr () -> CString -> Ptr CSize -> CString)
#field av_set , FunPtr (Ptr <struct fid_av> -> Ptr <struct fi_av_set_attr> -> Ptr (Ptr <struct fid_av_set>) -> Ptr () -> CInt)
#stoptype
{- struct fid_av {
    struct fid fid; struct fi_ops_av * ops;
}; -}
#starttype struct fid_av
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_av>
#stoptype
{- struct fid_mr {
    struct fid fid; void * mem_desc; uint64_t key;
}; -}
#starttype struct fid_mr
#field fid , <struct fid>
#field mem_desc , Ptr ()
#field key , CULong
#stoptype
{- enum fi_hmem_iface {
    FI_HMEM_SYSTEM = 0, FI_HMEM_CUDA, FI_HMEM_ROCR, FI_HMEM_ZE
}; -}
#integral_t enum fi_hmem_iface
#num FI_HMEM_SYSTEM
#num FI_HMEM_CUDA
#num FI_HMEM_ROCR
#num FI_HMEM_ZE
{- struct fi_mr_attr {
    const struct iovec * mr_iov;
    size_t iov_count;
    uint64_t access;
    uint64_t offset;
    uint64_t requested_key;
    void * context;
    size_t auth_key_size;
    uint8_t * auth_key;
    enum fi_hmem_iface iface;
    union {
        uint64_t reserved; int cuda; int ze;
    } device;
}; -}
#starttype struct fi_mr_attr
#field mr_iov , Ptr <struct iovec>
#field iov_count , CSize
#field access , CULong
#field offset , CULong
#field requested_key , CULong
#field context , Ptr ()
#field auth_key_size , CSize
#field auth_key , Ptr CUChar
#field iface , <enum fi_hmem_iface>
#field device.reserved, CULong
#field device.cuda, CInt
#field device.ze, CInt
#stoptype
{- struct fi_mr_modify {
    uint64_t flags; struct fi_mr_attr attr;
}; -}
#starttype struct fi_mr_modify
#field flags , CULong
#field attr , <struct fi_mr_attr>
#stoptype
{- struct fi_hmem_override_ops {
    size_t size;
    ssize_t (* copy_from_hmem_iov)(void * dest,
                                   size_t size,
                                   enum fi_hmem_iface iface,
                                   uint64_t device,
                                   const struct iovec * hmem_iov,
                                   size_t hmem_iov_count,
                                   uint64_t hmem_iov_offset);
    ssize_t (* copy_to_hmem_iov)(enum fi_hmem_iface iface,
                                 uint64_t device,
                                 const struct iovec * hmem_iov,
                                 size_t hmem_iov_count,
                                 uint64_t hmem_iov_offset,
                                 const void * src,
                                 size_t size);
}; -}
#starttype struct fi_hmem_override_ops
#field size , CSize
#field copy_from_hmem_iov , FunPtr (Ptr () -> CSize -> <enum fi_hmem_iface> -> CULong -> Ptr <struct iovec> -> CSize -> CULong -> CLong)
#field copy_to_hmem_iov , FunPtr (<enum fi_hmem_iface> -> CULong -> Ptr <struct iovec> -> CSize -> CULong -> Ptr () -> CSize -> CLong)
#stoptype
{- enum fi_datatype {
    FI_INT8,
    FI_UINT8,
    FI_INT16,
    FI_UINT16,
    FI_INT32,
    FI_UINT32,
    FI_INT64,
    FI_UINT64,
    FI_FLOAT,
    FI_DOUBLE,
    FI_FLOAT_COMPLEX,
    FI_DOUBLE_COMPLEX,
    FI_LONG_DOUBLE,
    FI_LONG_DOUBLE_COMPLEX,
    FI_DATATYPE_LAST,
    FI_VOID = 256
}; -}
#integral_t enum fi_datatype
#num FI_INT8
#num FI_UINT8
#num FI_INT16
#num FI_UINT16
#num FI_INT32
#num FI_UINT32
#num FI_INT64
#num FI_UINT64
#num FI_FLOAT
#num FI_DOUBLE
#num FI_FLOAT_COMPLEX
#num FI_DOUBLE_COMPLEX
#num FI_LONG_DOUBLE
#num FI_LONG_DOUBLE_COMPLEX
#num FI_DATATYPE_LAST
#num FI_VOID
{- enum fi_op {
    FI_MIN,
    FI_MAX,
    FI_SUM,
    FI_PROD,
    FI_LOR,
    FI_LAND,
    FI_BOR,
    FI_BAND,
    FI_LXOR,
    FI_BXOR,
    FI_ATOMIC_READ,
    FI_ATOMIC_WRITE,
    FI_CSWAP,
    FI_CSWAP_NE,
    FI_CSWAP_LE,
    FI_CSWAP_LT,
    FI_CSWAP_GE,
    FI_CSWAP_GT,
    FI_MSWAP,
    FI_ATOMIC_OP_LAST,
    FI_NOOP = 256
}; -}
#integral_t enum fi_op
#num FI_MIN
#num FI_MAX
#num FI_SUM
#num FI_PROD
#num FI_LOR
#num FI_LAND
#num FI_BOR
#num FI_BAND
#num FI_LXOR
#num FI_BXOR
#num FI_ATOMIC_READ
#num FI_ATOMIC_WRITE
#num FI_CSWAP
#num FI_CSWAP_NE
#num FI_CSWAP_LE
#num FI_CSWAP_LT
#num FI_CSWAP_GE
#num FI_CSWAP_GT
#num FI_MSWAP
#num FI_ATOMIC_OP_LAST
#num FI_NOOP
{- enum fi_collective_op {
    FI_BARRIER,
    FI_BROADCAST,
    FI_ALLTOALL,
    FI_ALLREDUCE,
    FI_ALLGATHER,
    FI_REDUCE_SCATTER,
    FI_REDUCE,
    FI_SCATTER,
    FI_GATHER
}; -}
#integral_t enum fi_collective_op
#num FI_BARRIER
#num FI_BROADCAST
#num FI_ALLTOALL
#num FI_ALLREDUCE
#num FI_ALLGATHER
#num FI_REDUCE_SCATTER
#num FI_REDUCE
#num FI_SCATTER
#num FI_GATHER
{- struct fi_atomic_attr; -}
#opaque_t struct fi_atomic_attr
{- struct fi_cq_attr; -}
#opaque_t struct fi_cq_attr
{- struct fi_cntr_attr; -}
#opaque_t struct fi_cntr_attr
{- struct fi_collective_attr; -}
#opaque_t struct fi_collective_attr
{- struct fi_ops_domain {
    size_t size;
    int (* av_open)(struct fid_domain * domain,
                    struct fi_av_attr * attr,
                    struct fid_av * * av,
                    void * context);
    int (* cq_open)(struct fid_domain * domain,
                    struct fi_cq_attr * attr,
                    struct fid_cq * * cq,
                    void * context);
    int (* endpoint)(struct fid_domain * domain,
                     struct fi_info * info,
                     struct fid_ep * * ep,
                     void * context);
    int (* scalable_ep)(struct fid_domain * domain,
                        struct fi_info * info,
                        struct fid_ep * * sep,
                        void * context);
    int (* cntr_open)(struct fid_domain * domain,
                      struct fi_cntr_attr * attr,
                      struct fid_cntr * * cntr,
                      void * context);
    int (* poll_open)(struct fid_domain * domain,
                      struct fi_poll_attr * attr,
                      struct fid_poll * * pollset);
    int (* stx_ctx)(struct fid_domain * domain,
                    struct fi_tx_attr * attr,
                    struct fid_stx * * stx,
                    void * context);
    int (* srx_ctx)(struct fid_domain * domain,
                    struct fi_rx_attr * attr,
                    struct fid_ep * * rx_ep,
                    void * context);
    int (* query_atomic)(struct fid_domain * domain,
                         enum fi_datatype datatype,
                         enum fi_op op,
                         struct fi_atomic_attr * attr,
                         uint64_t flags);
    int (* query_collective)(struct fid_domain * domain,
                             enum fi_collective_op coll,
                             struct fi_collective_attr * attr,
                             uint64_t flags);
}; -}
#starttype struct fi_ops_domain
#field size , CSize
#field av_open , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_av_attr> -> Ptr (Ptr <struct fid_av>) -> Ptr () -> CInt)
#field cq_open , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_cq_attr> -> Ptr (Ptr <struct fid_cq>) -> Ptr () -> CInt)
#field endpoint , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> CInt)
#field scalable_ep , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> CInt)
#field cntr_open , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_cntr_attr> -> Ptr (Ptr <struct fid_cntr>) -> Ptr () -> CInt)
#field poll_open , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_poll_attr> -> Ptr (Ptr <struct fid_poll>) -> CInt)
#field stx_ctx , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_tx_attr> -> Ptr (Ptr <struct fid_stx>) -> Ptr () -> CInt)
#field srx_ctx , FunPtr (Ptr <struct fid_domain> -> Ptr <struct fi_rx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> CInt)
#field query_atomic , FunPtr (Ptr <struct fid_domain> -> <enum fi_datatype> -> <enum fi_op> -> Ptr <struct fi_atomic_attr> -> CULong -> CInt)
#field query_collective , FunPtr (Ptr <struct fid_domain> -> <enum fi_collective_op> -> Ptr <struct fi_collective_attr> -> CULong -> CInt)
#stoptype
{- struct fi_ops_mr {
    size_t size;
    int (* reg)(struct fid * fid,
                const void * buf,
                size_t len,
                uint64_t access,
                uint64_t offset,
                uint64_t requested_key,
                uint64_t flags,
                struct fid_mr * * mr,
                void * context);
    int (* regv)(struct fid * fid,
                 const struct iovec * iov,
                 size_t count,
                 uint64_t access,
                 uint64_t offset,
                 uint64_t requested_key,
                 uint64_t flags,
                 struct fid_mr * * mr,
                 void * context);
    int (* regattr)(struct fid * fid,
                    const struct fi_mr_attr * attr,
                    uint64_t flags,
                    struct fid_mr * * mr);
}; -}
#starttype struct fi_ops_mr
#field size , CSize
#field reg , FunPtr (Ptr <struct fid> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CULong -> Ptr (Ptr <struct fid_mr>) -> Ptr () -> CInt)
#field regv , FunPtr (Ptr <struct fid> -> Ptr <struct iovec> -> CSize -> CULong -> CULong -> CULong -> CULong -> Ptr (Ptr <struct fid_mr>) -> Ptr () -> CInt)
#field regattr , FunPtr (Ptr <struct fid> -> Ptr <struct fi_mr_attr> -> CULong -> Ptr (Ptr <struct fid_mr>) -> CInt)
#stoptype
{- struct fid_domain {
    struct fid fid; struct fi_ops_domain * ops; struct fi_ops_mr * mr;
}; -}
#starttype struct fid_domain
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_domain>
#field mr , Ptr <struct fi_ops_mr>
#stoptype
#cinline fi_domain , Ptr <struct fid_fabric> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_domain>) -> Ptr () -> IO CInt
#cinline fi_domain_bind , Ptr <struct fid_domain> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_cq_open , Ptr <struct fid_domain> -> Ptr <struct fi_cq_attr> -> Ptr (Ptr <struct fid_cq>) -> Ptr () -> IO CInt
#cinline fi_cntr_open , Ptr <struct fid_domain> -> Ptr <struct fi_cntr_attr> -> Ptr (Ptr <struct fid_cntr>) -> Ptr () -> IO CInt
#cinline fi_wait_open , Ptr <struct fid_fabric> -> Ptr <struct fi_wait_attr> -> Ptr (Ptr <struct fid_wait>) -> IO CInt
#cinline fi_poll_open , Ptr <struct fid_domain> -> Ptr <struct fi_poll_attr> -> Ptr (Ptr <struct fid_poll>) -> IO CInt
#cinline fi_mr_reg , Ptr <struct fid_domain> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CULong -> Ptr (Ptr <struct fid_mr>) -> Ptr () -> IO CInt
#cinline fi_mr_regv , Ptr <struct fid_domain> -> Ptr <struct iovec> -> CSize -> CULong -> CULong -> CULong -> CULong -> Ptr (Ptr <struct fid_mr>) -> Ptr () -> IO CInt
#cinline fi_mr_regattr , Ptr <struct fid_domain> -> Ptr <struct fi_mr_attr> -> CULong -> Ptr (Ptr <struct fid_mr>) -> IO CInt
#cinline fi_mr_desc , Ptr <struct fid_mr> -> IO (Ptr ())
#cinline fi_mr_key , Ptr <struct fid_mr> -> IO CULong
#cinline fi_mr_raw_attr , Ptr <struct fid_mr> -> Ptr CULong -> Ptr CUChar -> Ptr CSize -> CULong -> IO CInt
#cinline fi_mr_map_raw , Ptr <struct fid_domain> -> CULong -> Ptr CUChar -> CSize -> Ptr CULong -> CULong -> IO CInt
#cinline fi_mr_unmap_key , Ptr <struct fid_domain> -> CULong -> IO CInt
#cinline fi_mr_bind , Ptr <struct fid_mr> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_mr_refresh , Ptr <struct fid_mr> -> Ptr <struct iovec> -> CSize -> CULong -> IO CInt
#cinline fi_mr_enable , Ptr <struct fid_mr> -> IO CInt
#cinline fi_av_open , Ptr <struct fid_domain> -> Ptr <struct fi_av_attr> -> Ptr (Ptr <struct fid_av>) -> Ptr () -> IO CInt
#cinline fi_av_bind , Ptr <struct fid_av> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_av_insert , Ptr <struct fid_av> -> Ptr () -> CSize -> Ptr CULong -> CULong -> Ptr () -> IO CInt
#cinline fi_av_insertsvc , Ptr <struct fid_av> -> CString -> CString -> Ptr CULong -> CULong -> Ptr () -> IO CInt
#cinline fi_av_insertsym , Ptr <struct fid_av> -> CString -> CSize -> CString -> CSize -> Ptr CULong -> CULong -> Ptr () -> IO CInt
#cinline fi_av_remove , Ptr <struct fid_av> -> Ptr CULong -> CSize -> CULong -> IO CInt
#cinline fi_av_lookup , Ptr <struct fid_av> -> CULong -> Ptr () -> Ptr CSize -> IO CInt
#cinline fi_av_straddr , Ptr <struct fid_av> -> Ptr () -> CString -> Ptr CSize -> IO CString
#cinline fi_rx_addr , CULong -> CInt -> CInt -> IO CULong
