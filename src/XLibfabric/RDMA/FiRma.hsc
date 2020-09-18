{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_rma.h>
module XLibfabric.RDMA.FiRma where
import System.Posix.Types.Iovec
import Foreign.Ptr
#strict_import

{- struct fi_rma_iov {
    uint64_t addr; size_t len; uint64_t key;
}; -}
#starttype struct fi_rma_iov
#field addr , CULong
#field len , CSize
#field key , CULong
#stoptype
{- struct fi_rma_ioc {
    uint64_t addr; size_t count; uint64_t key;
}; -}
#starttype struct fi_rma_ioc
#field addr , CULong
#field count , CSize
#field key , CULong
#stoptype
{- struct fi_msg_rma {
    const struct iovec * msg_iov;
    void * * desc;
    size_t iov_count;
    fi_addr_t addr;
    const struct fi_rma_iov * rma_iov;
    size_t rma_iov_count;
    void * context;
    uint64_t data;
}; -}
#starttype struct fi_msg_rma
#field msg_iov , Ptr <struct CIovec>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#field addr , CULong
#field rma_iov , Ptr <struct fi_rma_iov>
#field rma_iov_count , CSize
#field context , Ptr ()
#field data , CULong
#stoptype
{- struct fi_ops_rma {
    size_t size;
    ssize_t (* read)(struct fid_ep * ep,
                     void * buf,
                     size_t len,
                     void * desc,
                     fi_addr_t src_addr,
                     uint64_t addr,
                     uint64_t key,
                     void * context);
    ssize_t (* readv)(struct fid_ep * ep,
                      const struct iovec * iov,
                      void * * desc,
                      size_t count,
                      fi_addr_t src_addr,
                      uint64_t addr,
                      uint64_t key,
                      void * context);
    ssize_t (* readmsg)(struct fid_ep * ep,
                        const struct fi_msg_rma * msg,
                        uint64_t flags);
    ssize_t (* write)(struct fid_ep * ep,
                      const void * buf,
                      size_t len,
                      void * desc,
                      fi_addr_t dest_addr,
                      uint64_t addr,
                      uint64_t key,
                      void * context);
    ssize_t (* writev)(struct fid_ep * ep,
                       const struct iovec * iov,
                       void * * desc,
                       size_t count,
                       fi_addr_t dest_addr,
                       uint64_t addr,
                       uint64_t key,
                       void * context);
    ssize_t (* writemsg)(struct fid_ep * ep,
                         const struct fi_msg_rma * msg,
                         uint64_t flags);
    ssize_t (* inject)(struct fid_ep * ep,
                       const void * buf,
                       size_t len,
                       fi_addr_t dest_addr,
                       uint64_t addr,
                       uint64_t key);
    ssize_t (* writedata)(struct fid_ep * ep,
                          const void * buf,
                          size_t len,
                          void * desc,
                          uint64_t data,
                          fi_addr_t dest_addr,
                          uint64_t addr,
                          uint64_t key,
                          void * context);
    ssize_t (* injectdata)(struct fid_ep * ep,
                           const void * buf,
                           size_t len,
                           uint64_t data,
                           fi_addr_t dest_addr,
                           uint64_t addr,
                           uint64_t key);
}; -}
#starttype struct fi_ops_rma
#field size , CSize
#field read , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field readv , FunPtr (Ptr <struct fid_ep> -> Ptr <struct CIovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field readmsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_rma> -> CULong -> CLong)
#field write , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field writev , FunPtr (Ptr <struct fid_ep> -> Ptr <struct CIovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field writemsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_rma> -> CULong -> CLong)
#field inject , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CLong)
#field writedata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field injectdata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CULong -> CLong)
#stoptype
#cinline fi_read , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_readv , Ptr <struct fid_ep> -> Ptr <struct CIovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_readmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_rma> -> CULong -> IO CLong
#cinline fi_write , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_writev , Ptr <struct fid_ep> -> Ptr <struct CIovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_writemsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_rma> -> CULong -> IO CLong
#cinline fi_inject_write , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> IO CLong
#cinline fi_writedata , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_inject_writedata , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CULong -> IO CLong
