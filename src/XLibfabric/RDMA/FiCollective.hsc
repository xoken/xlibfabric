{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_collective.h>
module XLibfabric.RDMA.FiCollective where
import Foreign.Ptr
import XLibfabric.RDMA.FiAtomic
import XLibfabric.RDMA.FiDomain
import XLibfabric.RDMA.FiCm
#strict_import

{- struct fi_ops_av_set {
    size_t size;
    int (* set_union)(struct fid_av_set * dst,
                      const struct fid_av_set * src);
    int (* intersect)(struct fid_av_set * dst,
                      const struct fid_av_set * src);
    int (* diff)(struct fid_av_set * dst,
                 const struct fid_av_set * src);
    int (* insert)(struct fid_av_set * set, fi_addr_t addr);
    int (* remove)(struct fid_av_set * set, fi_addr_t addr);
    int (* addr)(struct fid_av_set * set, fi_addr_t * coll_addr);
}; -}
#starttype struct fi_ops_av_set
#field size , CSize
#field set_union , FunPtr (Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> CInt)
#field intersect , FunPtr (Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> CInt)
#field diff , FunPtr (Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> CInt)
#field insert , FunPtr (Ptr <struct fid_av_set> -> CULong -> CInt)
#field remove , FunPtr (Ptr <struct fid_av_set> -> CULong -> CInt)
#field addr , FunPtr (Ptr <struct fid_av_set> -> Ptr CULong -> CInt)
#stoptype
{- struct fid_av_set {
    struct fid fid; struct fi_ops_av_set * ops;
}; -}
#starttype struct fid_av_set
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_av_set>
#stoptype
{- struct fi_collective_attr {
    enum fi_op op;
    enum fi_datatype datatype;
    struct fi_atomic_attr datatype_attr;
    size_t max_members;
    uint64_t mode;
}; -}
#starttype struct fi_collective_attr
#field op , <enum fi_op>
#field datatype , <enum fi_datatype>
#field datatype_attr , <struct fi_atomic_attr>
#field max_members , CSize
#field mode , CULong
#stoptype
{- struct fi_collective_addr {
    const struct fid_av_set * set; fi_addr_t coll_addr;
}; -}
#starttype struct fi_collective_addr
#field set , Ptr <struct fid_av_set>
#field coll_addr , CULong
#stoptype
{- struct fi_msg_collective {
    const struct fi_ioc * msg_iov;
    void * * desc;
    size_t iov_count;
    fi_addr_t coll_addr;
    fi_addr_t root_addr;
    enum fi_collective_op coll;
    enum fi_datatype datatype;
    enum fi_op op;
    void * context;
}; -}
#starttype struct fi_msg_collective
#field msg_iov , Ptr <struct fi_ioc>
#field desc , Ptr (Ptr ())
#field iov_count , CSize
#field coll_addr , CULong
#field root_addr , CULong
#field coll , <enum fi_collective_op>
#field datatype , <enum fi_datatype>
#field op , <enum fi_op>
#field context , Ptr ()
#stoptype
{- struct fi_ops_collective {
    size_t size;
    ssize_t (* barrier)(struct fid_ep * ep,
                        fi_addr_t coll_addr,
                        void * context);
    ssize_t (* broadcast)(struct fid_ep * ep,
                          void * buf,
                          size_t count,
                          void * desc,
                          fi_addr_t coll_addr,
                          fi_addr_t root_addr,
                          enum fi_datatype datatype,
                          uint64_t flags,
                          void * context);
    ssize_t (* alltoall)(struct fid_ep * ep,
                         const void * buf,
                         size_t count,
                         void * desc,
                         void * result,
                         void * result_desc,
                         fi_addr_t coll_addr,
                         enum fi_datatype datatype,
                         uint64_t flags,
                         void * context);
    ssize_t (* allreduce)(struct fid_ep * ep,
                          const void * buf,
                          size_t count,
                          void * desc,
                          void * result,
                          void * result_desc,
                          fi_addr_t coll_addr,
                          enum fi_datatype datatype,
                          enum fi_op op,
                          uint64_t flags,
                          void * context);
    ssize_t (* allgather)(struct fid_ep * ep,
                          const void * buf,
                          size_t count,
                          void * desc,
                          void * result,
                          void * result_desc,
                          fi_addr_t coll_addr,
                          enum fi_datatype datatype,
                          uint64_t flags,
                          void * context);
    ssize_t (* reduce_scatter)(struct fid_ep * ep,
                               const void * buf,
                               size_t count,
                               void * desc,
                               void * result,
                               void * result_desc,
                               fi_addr_t coll_addr,
                               enum fi_datatype datatype,
                               enum fi_op op,
                               uint64_t flags,
                               void * context);
    ssize_t (* reduce)(struct fid_ep * ep,
                       const void * buf,
                       size_t count,
                       void * desc,
                       void * result,
                       void * result_desc,
                       fi_addr_t coll_addr,
                       fi_addr_t root_addr,
                       enum fi_datatype datatype,
                       enum fi_op op,
                       uint64_t flags,
                       void * context);
    ssize_t (* scatter)(struct fid_ep * ep,
                        const void * buf,
                        size_t count,
                        void * desc,
                        void * result,
                        void * result_desc,
                        fi_addr_t coll_addr,
                        fi_addr_t root_addr,
                        enum fi_datatype datatype,
                        uint64_t flags,
                        void * context);
    ssize_t (* gather)(struct fid_ep * ep,
                       const void * buf,
                       size_t count,
                       void * desc,
                       void * result,
                       void * result_desc,
                       fi_addr_t coll_addr,
                       fi_addr_t root_addr,
                       enum fi_datatype datatype,
                       uint64_t flags,
                       void * context);
    ssize_t (* msg)(struct fid_ep * ep,
                    const struct fi_msg_collective * msg,
                    struct fi_ioc * resultv,
                    void * * result_desc,
                    size_t result_count,
                    uint64_t flags);
}; -}
#starttype struct fi_ops_collective
#field size , CSize
#field barrier , FunPtr (Ptr <struct fid_ep> -> CULong -> Ptr () -> CLong)
#field broadcast , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> CLong)
#field alltoall , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> CLong)
#field allreduce , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> CLong)
#field allgather , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> CLong)
#field reduce_scatter , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> CLong)
#field reduce , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> CLong)
#field scatter , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> CLong)
#field gather , FunPtr (Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> CLong)
#field msg , FunPtr (Ptr <struct fid_ep> -> Ptr <struct fi_msg_collective> -> Ptr <struct fi_ioc> -> Ptr (Ptr ()) -> CSize -> CULong -> CLong)
#stoptype
#cinline fi_av_set , Ptr <struct fid_av> -> Ptr <struct fi_av_set_attr> -> Ptr (Ptr <struct fid_av_set>) -> Ptr () -> IO CInt
#cinline fi_av_set_union , Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> IO CInt
#cinline fi_av_set_intersect , Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> IO CInt
#cinline fi_av_set_diff , Ptr <struct fid_av_set> -> Ptr <struct fid_av_set> -> IO CInt
#cinline fi_av_set_insert , Ptr <struct fid_av_set> -> CULong -> IO CInt
#cinline fi_av_set_remove , Ptr <struct fid_av_set> -> CULong -> IO CInt
#cinline fi_av_set_addr , Ptr <struct fid_av_set> -> Ptr CULong -> IO CInt
#cinline fi_join_collective , Ptr <struct fid_ep> -> CULong -> Ptr <struct fid_av_set> -> CULong -> Ptr (Ptr <struct fid_mc>) -> Ptr () -> IO CInt
#cinline fi_barrier , Ptr <struct fid_ep> -> CULong -> Ptr () -> IO CLong
#cinline fi_broadcast , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> IO CLong
#cinline fi_alltoall , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> IO CLong
#cinline fi_allreduce , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> IO CLong
#cinline fi_allgather , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> IO CLong
#cinline fi_reduce_scatter , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> IO CLong
#cinline fi_reduce , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> <enum fi_op> -> CULong -> Ptr () -> IO CLong
#cinline fi_scatter , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> IO CLong
#cinline fi_gather , Ptr <struct fid_ep> -> Ptr () -> CSize -> Ptr () -> Ptr () -> Ptr () -> CULong -> CULong -> <enum fi_datatype> -> CULong -> Ptr () -> IO CLong
#cinline fi_query_collective , Ptr <struct fid_domain> -> <enum fi_collective_op> -> Ptr <struct fi_collective_attr> -> CULong -> IO CInt
