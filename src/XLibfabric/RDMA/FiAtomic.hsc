{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_atomic.h>
module XLibfabric.RDMA.FiAtomic where
import Foreign.Ptr
import XLibfabric.RDMA.FiRma
import XLibfabric.RDMA.FiDomain hiding (C'fid_domain, C'fi_atomic_attr)
import XLibfabric.RDMA.Fabric hiding (C'fid_ep)
import XLibfabric.RDMA.FiEndpoint hiding (C'fi_ops_rma, C'fi_ops_atomic)
#strict_import

{- struct fi_atomic_attr {
    size_t count; size_t size;
}; -}
#starttype struct fi_atomic_attr
#field count , CSize
#field size , CSize
#stoptype
{- struct fi_msg_atomic {
    const struct fi_ioc * msg_iov;
    void * * desc;
    size_t iov_count;
    fi_addr_t addr;
    const struct fi_rma_ioc * rma_iov;
    size_t rma_iov_count;
    enum fi_datatype datatype;
    enum fi_op op;
    void * context;
    uint64_t data;
}; -}
#starttype struct fi_msg_atomic
#field msg_iov , Ptr <struct fi_ioc>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#field addr , CULong
#field rma_iov , Ptr <struct fi_rma_ioc>
#field rma_iov_count , CSize
#field datatype , <enum fi_datatype>
#field op , <enum fi_op>
#field context , Ptr ()
#field data , CULong
#stoptype
{- struct fi_msg_fetch {
    struct fi_ioc * msg_iov; void * * desc; size_t iov_count;
}; -}
#starttype struct fi_msg_fetch
#field msg_iov , Ptr <struct fi_ioc>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#stoptype
{- struct fi_msg_compare {
    const struct fi_ioc * msg_iov; void * * desc; size_t iov_count;
}; -}
#starttype struct fi_msg_compare
#field msg_iov , Ptr <struct fi_ioc>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#stoptype
{- struct fi_ops_atomic {
    size_t size;
    ssize_t (* write)(struct fid_ep * ep,
                      const void * buf,
                      size_t count,
                      void * desc,
                      fi_addr_t dest_addr,
                      uint64_t addr,
                      uint64_t key,
                      enum fi_datatype datatype,
                      enum fi_op op,
                      void * context);
    ssize_t (* writev)(struct fid_ep * ep,
                       const struct fi_ioc * iov,
                       void * * desc,
                       size_t count,
                       fi_addr_t dest_addr,
                       uint64_t addr,
                       uint64_t key,
                       enum fi_datatype datatype,
                       enum fi_op op,
                       void * context);
    ssize_t (* writemsg)(struct fid_ep * ep,
                         const struct fi_msg_atomic * msg,
                         uint64_t flags);
    ssize_t (* inject)(struct fid_ep * ep,
                       const void * buf,
                       size_t count,
                       fi_addr_t dest_addr,
                       uint64_t addr,
                       uint64_t key,
                       enum fi_datatype datatype,
                       enum fi_op op);
    ssize_t (* readwrite)(struct fid_ep * ep,
                          const void * buf,
                          size_t count,
                          void * desc,
                          void * result,
                          void * result_desc,
                          fi_addr_t dest_addr,
                          uint64_t addr,
                          uint64_t key,
                          enum fi_datatype datatype,
                          enum fi_op op,
                          void * context);
    ssize_t (* readwritev)(struct fid_ep * ep,
                           const struct fi_ioc * iov,
                           void * * desc,
                           size_t count,
                           struct fi_ioc * resultv,
                           void * * result_desc,
                           size_t result_count,
                           fi_addr_t dest_addr,
                           uint64_t addr,
                           uint64_t key,
                           enum fi_datatype datatype,
                           enum fi_op op,
                           void * context);
    ssize_t (* readwritemsg)(struct fid_ep * ep,
                             const struct fi_msg_atomic * msg,
                             struct fi_ioc * resultv,
                             void * * result_desc,
                             size_t result_count,
                             uint64_t flags);
    ssize_t (* compwrite)(struct fid_ep * ep,
                          const void * buf,
                          size_t count,
                          void * desc,
                          const void * compare,
                          void * compare_desc,
                          void * result,
                          void * result_desc,
                          fi_addr_t dest_addr,
                          uint64_t addr,
                          uint64_t key,
                          enum fi_datatype datatype,
                          enum fi_op op,
                          void * context);
    ssize_t (* compwritev)(struct fid_ep * ep,
                           const struct fi_ioc * iov,
                           void * * desc,
                           size_t count,
                           const struct fi_ioc * comparev,
                           void * * compare_desc,
                           size_t compare_count,
                           struct fi_ioc * resultv,
                           void * * result_desc,
                           size_t result_count,
                           fi_addr_t dest_addr,
                           uint64_t addr,
                           uint64_t key,
                           enum fi_datatype datatype,
                           enum fi_op op,
                           void * context);
    ssize_t (* compwritemsg)(struct fid_ep * ep,
                             const struct fi_msg_atomic * msg,
                             const struct fi_ioc * comparev,
                             void * * compare_desc,
                             size_t compare_count,
                             struct fi_ioc * resultv,
                             void * * result_desc,
                             size_t result_count,
                             uint64_t flags);
    int (* writevalid)(struct fid_ep * ep,
                       enum fi_datatype datatype,
                       enum fi_op op,
                       size_t * count);
    int (* readwritevalid)(struct fid_ep * ep,
                           enum fi_datatype datatype,
                           enum fi_op op,
                           size_t * count);
    int (* compwritevalid)(struct fid_ep * ep,
                           enum fi_datatype datatype,
                           enum fi_op op,
                           size_t * count);
}; -}
#starttype struct fi_ops_atomic
#field size , CSize
#field write , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field writev , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field writemsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> CULong -> CLong)
#field inject , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CLong)
#field readwrite , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field readwritev , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field readwritemsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CLong)
#field compwrite , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field compwritev , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> CLong)
#field compwritemsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CLong)
#field writevalid , FunPtr (Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> CInt)
#field readwritevalid , FunPtr (Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> CInt)
#field compwritevalid , FunPtr (Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> CInt)
#stoptype
#cinline fi_atomic , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_atomicv , Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_atomicmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> CULong -> IO CLong
#cinline fi_inject_atomic , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> IO CLong
#cinline fi_fetch_atomic , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_fetch_atomicv , Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_fetch_atomicmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> IO CLong
#cinline fi_compare_atomic , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_compare_atomicv , Ptr <struct fid_ep> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> Ptr () -> IO CLong
#cinline fi_compare_atomicmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_atomic> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> IO CLong
#cinline fi_atomicvalid , Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> IO CInt
#cinline fi_fetch_atomicvalid , Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> IO CInt
#cinline fi_compare_atomicvalid , Ptr <struct fid_ep> -> <enum fi_datatype> -> <enum fi_op> -> Ptr CSize -> IO CInt
#cinline fi_query_atomic , Ptr <struct fid_domain> -> <enum fi_datatype> -> <enum fi_op> -> Ptr <struct fi_atomic_attr> -> CULong -> IO CInt
