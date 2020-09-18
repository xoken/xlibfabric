{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_cm.h>
module XLibfabric.RDMA.FiCm where
import Foreign.Ptr
import XLibfabric.RDMA.FiEndpoint
#strict_import

{- struct fid_mc {
    struct fid fid; fi_addr_t fi_addr;
}; -}
#starttype struct fid_mc
#field fid , <struct fid>
#field fi_addr , CULong
#stoptype
{- struct fi_ops_cm {
    size_t size;
    int (* setname)(fid_t fid, void * addr, size_t addrlen);
    int (* getname)(fid_t fid, void * addr, size_t * addrlen);
    int (* getpeer)(struct fid_ep * ep, void * addr, size_t * addrlen);
    int (* connect)(struct fid_ep * ep,
                    const void * addr,
                    const void * param,
                    size_t paramlen);
    int (* listen)(struct fid_pep * pep);
    int (* accept)(struct fid_ep * ep,
                   const void * param,
                   size_t paramlen);
    int (* reject)(struct fid_pep * pep,
                   fid_t handle,
                   const void * param,
                   size_t paramlen);
    int (* shutdown)(struct fid_ep * ep, uint64_t flags);
    int (* join)(struct fid_ep * ep,
                 const void * addr,
                 uint64_t flags,
                 struct fid_mc * * mc,
                 void * context);
}; -}
#starttype struct fi_ops_cm
#field size , CSize
#field setname , FunPtr (<fid_t> -> Ptr () -> CSize -> CInt)
#field getname , FunPtr (<fid_t> -> Ptr () -> Ptr CSize -> CInt)
#field getpeer , FunPtr (Ptr <struct fid_ep> -> Ptr () -> Ptr CSize -> CInt)
#field connect , FunPtr (Ptr <struct fid_ep> -> Ptr () -> Ptr () -> CSize -> CInt)
#field listen , FunPtr (Ptr <struct fid_pep> -> CInt)
#field accept , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> CInt)
#field reject , FunPtr (Ptr <struct fid_pep> -> <fid_t> -> Ptr () -> CSize -> CInt)
#field shutdown , FunPtr (Ptr <struct fid_ep> -> CULong -> CInt)
#field join , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CULong -> Ptr (Ptr <struct fid_mc>) -> Ptr () -> CInt)
#stoptype
#cinline fi_setname , <fid_t> -> Ptr () -> CSize -> IO CInt
#cinline fi_getname , <fid_t> -> Ptr () -> Ptr CSize -> IO CInt
#cinline fi_getpeer , Ptr <struct fid_ep> -> Ptr () -> Ptr CSize -> IO CInt
#cinline fi_listen , Ptr <struct fid_pep> -> IO CInt
#cinline fi_connect , Ptr <struct fid_ep> -> Ptr () -> Ptr () -> CSize -> IO CInt
#cinline fi_accept , Ptr <struct fid_ep> -> Ptr () -> CSize -> IO CInt
#cinline fi_reject , Ptr <struct fid_pep> -> <fid_t> -> Ptr () -> CSize -> IO CInt
#cinline fi_shutdown , Ptr <struct fid_ep> -> CULong -> IO CInt
#cinline fi_join , Ptr <struct fid_ep> -> Ptr () -> CULong -> Ptr (Ptr <struct fid_mc>) -> Ptr () -> IO CInt
#cinline fi_mc_addr , Ptr <struct fid_mc> -> IO CULong
