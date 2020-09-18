{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_endpoint.h>
module XLibfabric.RDMA.FiEndpoint where
import Foreign.Ptr
import Common
import XLibfabric.RDMA.Fabric hiding (C'fid_ep, C'fid_stx, C'fid_pep)
import XLibfabric.RDMA.FiDomain hiding (C'fid_domain)
#strict_import

{- struct fi_msg {
    const struct iovec * msg_iov;
    void * * desc;
    size_t iov_count;
    fi_addr_t addr;
    void * context;
    uint64_t data;
}; -}
#starttype struct fi_msg
#field msg_iov , Ptr <struct iovec>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#field addr , CULong
#field context , Ptr ()
#field data , CULong
#stoptype
{- enum {
    FI_OPT_ENDPOINT
}; -}
#num FI_OPT_ENDPOINT
{- enum {
    FI_OPT_MIN_MULTI_RECV,
    FI_OPT_CM_DATA_SIZE,
    FI_OPT_BUFFERED_MIN,
    FI_OPT_BUFFERED_LIMIT,
    FI_OPT_SEND_BUF_SIZE,
    FI_OPT_RECV_BUF_SIZE,
    FI_OPT_TX_SIZE,
    FI_OPT_RX_SIZE
}; -}
#num FI_OPT_MIN_MULTI_RECV
#num FI_OPT_CM_DATA_SIZE
#num FI_OPT_BUFFERED_MIN
#num FI_OPT_BUFFERED_LIMIT
#num FI_OPT_SEND_BUF_SIZE
#num FI_OPT_RECV_BUF_SIZE
#num FI_OPT_TX_SIZE
#num FI_OPT_RX_SIZE
{- struct fi_ops_ep {
    size_t size;
    ssize_t (* cancel)(fid_t fid, void * context);
    int (* getopt)(fid_t fid,
                   int level,
                   int optname,
                   void * optval,
                   size_t * optlen);
    int (* setopt)(fid_t fid,
                   int level,
                   int optname,
                   const void * optval,
                   size_t optlen);
    int (* tx_ctx)(struct fid_ep * sep,
                   int index,
                   struct fi_tx_attr * attr,
                   struct fid_ep * * tx_ep,
                   void * context);
    int (* rx_ctx)(struct fid_ep * sep,
                   int index,
                   struct fi_rx_attr * attr,
                   struct fid_ep * * rx_ep,
                   void * context);
    ssize_t (* rx_size_left)(struct fid_ep * ep);
    ssize_t (* tx_size_left)(struct fid_ep * ep);
}; -}
#starttype struct fi_ops_ep
#field size , CSize
#field cancel , FunPtr (<fid_t> -> Ptr () -> CLong)
#field getopt , FunPtr (<fid_t> -> CInt -> CInt -> Ptr () -> Ptr CSize -> CInt)
#field setopt , FunPtr (<fid_t> -> CInt -> CInt -> Ptr () -> CSize -> CInt)
#field tx_ctx , FunPtr (Ptr <struct fid_ep> -> CInt -> Ptr <struct fi_tx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> CInt)
#field rx_ctx , FunPtr (Ptr <struct fid_ep> -> CInt -> Ptr <struct fi_rx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> CInt)
#field rx_size_left , FunPtr (Ptr <struct fid_ep> -> CLong)
#field tx_size_left , FunPtr (Ptr <struct fid_ep> -> CLong)
#stoptype
{- struct fi_ops_msg {
    size_t size;
    ssize_t (* recv)(struct fid_ep * ep,
                     void * buf,
                     size_t len,
                     void * desc,
                     fi_addr_t src_addr,
                     void * context);
    ssize_t (* recvv)(struct fid_ep * ep,
                      const struct iovec * iov,
                      void * * desc,
                      size_t count,
                      fi_addr_t src_addr,
                      void * context);
    ssize_t (* recvmsg)(struct fid_ep * ep,
                        const struct fi_msg * msg,
                        uint64_t flags);
    ssize_t (* send)(struct fid_ep * ep,
                     const void * buf,
                     size_t len,
                     void * desc,
                     fi_addr_t dest_addr,
                     void * context);
    ssize_t (* sendv)(struct fid_ep * ep,
                      const struct iovec * iov,
                      void * * desc,
                      size_t count,
                      fi_addr_t dest_addr,
                      void * context);
    ssize_t (* sendmsg)(struct fid_ep * ep,
                        const struct fi_msg * msg,
                        uint64_t flags);
    ssize_t (* inject)(struct fid_ep * ep,
                       const void * buf,
                       size_t len,
                       fi_addr_t dest_addr);
    ssize_t (* senddata)(struct fid_ep * ep,
                         const void * buf,
                         size_t len,
                         void * desc,
                         uint64_t data,
                         fi_addr_t dest_addr,
                         void * context);
    ssize_t (* injectdata)(struct fid_ep * ep,
                           const void * buf,
                           size_t len,
                           uint64_t data,
                           fi_addr_t dest_addr);
}; -}
#starttype struct fi_ops_msg
#field size , CSize
#field recv , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> Ptr () -> CLong)
#field recvv , FunPtr (Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> Ptr () -> CLong)
#field recvmsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg> -> CULong -> CLong)
#field send , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> Ptr () -> CLong)
#field sendv , FunPtr (Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> Ptr () -> CLong)
#field sendmsg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg> -> CULong -> CLong)
#field inject , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CLong)
#field senddata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> Ptr () -> CLong)
#field injectdata , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> CLong)
#stoptype
{- struct fi_ops_cm; -}
#opaque_t struct fi_ops_cm
{- struct fi_ops_rma; -}
#opaque_t struct fi_ops_rma
{- struct fi_ops_tagged; -}
#opaque_t struct fi_ops_tagged
{- struct fi_ops_atomic; -}
#opaque_t struct fi_ops_atomic
{- struct fi_ops_collective; -}
#opaque_t struct fi_ops_collective
{- struct fid_ep {
    struct fid fid;
    struct fi_ops_ep * ops;
    struct fi_ops_cm * cm;
    struct fi_ops_msg * msg;
    struct fi_ops_rma * rma;
    struct fi_ops_tagged * tagged;
    struct fi_ops_atomic * atomic;
    struct fi_ops_collective * collective;
}; -}
#starttype struct fid_ep
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_ep>
#field cm , Ptr <struct fi_ops_cm>
#field msg , Ptr <struct fi_ops_msg>
#field rma , Ptr <struct fi_ops_rma>
#field tagged , Ptr <struct fi_ops_tagged>
#field atomic , Ptr <struct fi_ops_atomic>
#field collective , Ptr <struct fi_ops_collective>
#stoptype
{- struct fid_pep {
    struct fid fid; struct fi_ops_ep * ops; struct fi_ops_cm * cm;
}; -}
#starttype struct fid_pep
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_ep>
#field cm , Ptr <struct fi_ops_cm>
#stoptype
{- struct fid_stx {
    struct fid fid; struct fi_ops_ep * ops;
}; -}
#starttype struct fid_stx
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_ep>
#stoptype
#cinline fi_passive_ep , Ptr <struct fid_fabric> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_pep>) -> Ptr () -> IO CInt
#cinline fi_endpoint , Ptr <struct fid_domain> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> IO CInt
#cinline fi_scalable_ep , Ptr <struct fid_domain> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> IO CInt
#cinline fi_ep_bind , Ptr <struct fid_ep> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_pep_bind , Ptr <struct fid_pep> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_scalable_ep_bind , Ptr <struct fid_ep> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_enable , Ptr <struct fid_ep> -> IO CInt
#cinline fi_cancel , <fid_t> -> Ptr () -> IO CLong
#cinline fi_setopt , <fid_t> -> CInt -> CInt -> Ptr () -> CSize -> IO CInt
#cinline fi_getopt , <fid_t> -> CInt -> CInt -> Ptr () -> Ptr CSize -> IO CInt
#cinline fi_ep_alias , Ptr <struct fid_ep> -> Ptr (Ptr <struct fid_ep>) -> CULong -> IO CInt
#cinline fi_tx_context , Ptr <struct fid_ep> -> CInt -> Ptr <struct fi_tx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> IO CInt
#cinline fi_rx_context , Ptr <struct fid_ep> -> CInt -> Ptr <struct fi_rx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> IO CInt
#cinline fi_rx_size_left , Ptr <struct fid_ep> -> IO CLong
#cinline fi_tx_size_left , Ptr <struct fid_ep> -> IO CLong
#cinline fi_stx_context , Ptr <struct fid_domain> -> Ptr <struct fi_tx_attr> -> Ptr (Ptr <struct fid_stx>) -> Ptr () -> IO CInt
#cinline fi_srx_context , Ptr <struct fid_domain> -> Ptr <struct fi_rx_attr> -> Ptr (Ptr <struct fid_ep>) -> Ptr () -> IO CInt
#cinline fi_recv , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> Ptr () -> IO CLong
#cinline fi_recvv , Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> Ptr () -> IO CLong
#cinline fi_recvmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg> -> CULong -> IO CLong
#cinline fi_send , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> Ptr () -> IO CLong
#cinline fi_sendv , Ptr <struct fid_ep> -> Ptr <struct iovec> -> Ptr (Ptr ()) -> CSize -> CULong -> Ptr () -> IO CLong
#cinline fi_sendmsg , Ptr <struct fid_ep> -> Ptr <struct fi_msg> -> CULong -> IO CLong
#cinline fi_inject , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> IO CLong
#cinline fi_senddata , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> Ptr () -> IO CLong
#cinline fi_injectdata , Ptr <struct fid_ep> -> Ptr () -> CSize -> CULong -> CULong -> IO CLong
