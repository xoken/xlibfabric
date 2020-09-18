{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_tagged.h>
module XLibfabric.RDMA.FiTagged where
import Foreign.Ptr
import System.Posix.Types.Iovec
#strict_import

{- struct fi_msg_tagged {
    const struct iovec * msg_iov;
    void * * desc;
    size_t iov_count;
    fi_addr_t addr;
    uint64_t tag;
    uint64_t ignore;
    void * context;
    uint64_t data;
}; -}
#starttype struct fi_msg_tagged
#field msg_iov , Ptr <struct iovec>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#field addr , CULong
#field tag , CULong
#field ignore , CULong
#field context , Ptr ()
#field data , CULong
#stoptype
{- struct fi_ops_tagged {
    size_t size;
    ssize_t (* recv)(struct fid_ep * ep,
                     void * buf,
                     size_t len,
                     void * desc,
                     fi_addr_t src_addr,
                     uint64_t tag,
                     uint64_t ignore,
                     void * context);
    ssize_t (* recvv)(struct fid_ep * ep,
                      const struct iovec * iov,
                      void * * desc,
                      size_t count,
                      fi_addr_t src_addr,
                      uint64_t tag,
                      uint64_t ignore,
                      void * context);
    ssize_t (* recvmsg)(struct fid_ep * ep,
                        const struct fi_msg_tagged * msg,
                        uint64_t flags);
    ssize_t (* send)(struct fid_ep * ep,
                     const void * buf,
                     size_t len,
                     void * desc,
                     fi_addr_t dest_addr,
                     uint64_t tag,
                     void * context);
    ssize_t (* sendv)(struct fid_ep * ep,
                      const struct iovec * iov,
                      void * * desc,
                      size_t count,
                      fi_addr_t dest_addr,
                      uint64_t tag,
                      void * context);
    ssize_t (* sendmsg)(struct fid_ep * ep,
                        const struct fi_msg_tagged * msg,
                        uint64_t flags);
    ssize_t (* inject)(struct fid_ep * ep,
                       const void * buf,
                       size_t len,
                       fi_addr_t dest_addr,
                       uint64_t tag);
    ssize_t (* senddata)(struct fid_ep * ep,
                         const void * buf,
                         size_t len,
                         void * desc,
                         uint64_t data,
                         fi_addr_t dest_addr,
                         uint64_t tag,
                         void * context);
    ssize_t (* injectdata)(struct fid_ep * ep,
                           const void * buf,
                           size_t len,
                           uint64_t data,
                           fi_addr_t dest_addr,
                           uint64_t tag);
}; -}
#starttype struct fi_ops_tagged
#field size , CSize
#field recv , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field recvv , FunPtr (Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field recvmsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_tagged> -> CULong -> CLong)
#field send , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> Ptr () -> CLong)
#field sendv , FunPtr (Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> Ptr () -> CLong)
#field sendmsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_tagged> -> CULong -> CLong)
#field inject , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CLong)
#field senddata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> CLong)
#field injectdata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> CLong)
#stoptype
#cinline fi_trecv , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_trecvv , Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_trecvmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_tagged> -> CULong -> IO CLong
#cinline fi_tsend , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_tsendv , Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_tsendmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg_tagged> -> CULong -> IO CLong
#cinline fi_tinject , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> IO CLong
#cinline fi_tsenddata , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_tinjectdata , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CULong -> IO CLong
