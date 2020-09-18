{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_eq.h>
module XLibfabric.RDMA.FiEq where
import XLibfabric.RDMA.Fabric
import XLibfabric.RDMA.FiErrno
import Foreign.Ptr
#strict_import

{- enum fi_wait_obj {
    FI_WAIT_NONE,
    FI_WAIT_UNSPEC,
    FI_WAIT_SET,
    FI_WAIT_FD,
    FI_WAIT_MUTEX_COND,
    FI_WAIT_YIELD,
    FI_WAIT_POLLFD
}; -}
#integral_t enum fi_wait_obj
#num FI_WAIT_NONE
#num FI_WAIT_UNSPEC
#num FI_WAIT_SET
#num FI_WAIT_FD
#num FI_WAIT_MUTEX_COND
#num FI_WAIT_YIELD
#num FI_WAIT_POLLFD
{- struct fi_wait_attr {
    enum fi_wait_obj wait_obj; uint64_t flags;
}; -}
#starttype struct fi_wait_attr
#field wait_obj , <enum fi_wait_obj>
#field flags , CULong
#stoptype
{- struct fi_ops_wait {
    size_t size; int (* wait)(struct fid_wait * waitset, int timeout);
}; -}
#starttype struct fi_ops_wait
#field size , CSize
#field wait , FunPtr (Ptr <struct fid_wait> -> CInt -> CInt)
#stoptype
{- struct fid_wait {
    struct fid fid; struct fi_ops_wait * ops;
}; -}
#starttype struct fid_wait
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_wait>
#stoptype
{- struct fi_mutex_cond {
    pthread_mutex_t * mutex; pthread_cond_t * cond;
}; -}
#starttype struct fi_mutex_cond
#field mutex , Ptr <pthread_mutex_t>
#field cond , Ptr <pthread_cond_t>
#stoptype
{- struct fi_wait_pollfd {
    uint64_t change_index; size_t nfds; struct pollfd * fd;
}; -}
#starttype struct fi_wait_pollfd
#field change_index , CULong
#field nfds , CSize
#field fd , Ptr <struct pollfd>
#stoptype
{- struct fi_poll_attr {
    uint64_t flags;
}; -}
#starttype struct fi_poll_attr
#field flags , CULong
#stoptype
{- struct fi_ops_poll {
    size_t size;
    int (* poll)(struct fid_poll * pollset,
                 void * * context,
                 int count);
    int (* poll_add)(struct fid_poll * pollset,
                     struct fid * event_fid,
                     uint64_t flags);
    int (* poll_del)(struct fid_poll * pollset,
                     struct fid * event_fid,
                     uint64_t flags);
}; -}
#starttype struct fi_ops_poll
#field size , CSize
#field poll , FunPtr (Ptr <struct fid_poll> -> Ptr (Ptr ()) -> CInt -> CInt)
#field poll_add , FunPtr (Ptr <struct fid_poll> -> Ptr <struct fid> -> CULong -> CInt)
#field poll_del , FunPtr (Ptr <struct fid_poll> -> Ptr <struct fid> -> CULong -> CInt)
#stoptype
{- struct fid_poll {
    struct fid fid; struct fi_ops_poll * ops;
}; -}
#starttype struct fid_poll
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_poll>
#stoptype
{- struct fi_eq_attr {
    size_t size;
    uint64_t flags;
    enum fi_wait_obj wait_obj;
    int signaling_vector;
    struct fid_wait * wait_set;
}; -}
#starttype struct fi_eq_attr
#field size , CSize
#field flags , CULong
#field wait_obj , <enum fi_wait_obj>
#field signaling_vector , CInt
#field wait_set , Ptr <struct fid_wait>
#stoptype
{- enum {
    FI_NOTIFY,
    FI_CONNREQ,
    FI_CONNECTED,
    FI_SHUTDOWN,
    FI_MR_COMPLETE,
    FI_AV_COMPLETE,
    FI_JOIN_COMPLETE
}; -}
#num FI_NOTIFY
#num FI_CONNREQ
#num FI_CONNECTED
#num FI_SHUTDOWN
#num FI_MR_COMPLETE
#num FI_AV_COMPLETE
#num FI_JOIN_COMPLETE
{- struct fi_eq_entry {
    fid_t fid; void * context; uint64_t data;
}; -}
#starttype struct fi_eq_entry
#field fid , <fid_t>
#field context , Ptr ()
#field data , CULong
#stoptype
{- struct fi_eq_err_entry {
    fid_t fid;
    void * context;
    uint64_t data;
    int err;
    int prov_errno;
    void * err_data;
    size_t err_data_size;
}; -}
#starttype struct fi_eq_err_entry
#field fid , <fid_t>
#field context , Ptr ()
#field data , CULong
#field err , CInt
#field prov_errno , CInt
#field err_data , Ptr ()
#field err_data_size , CSize
#stoptype
{- struct fi_eq_cm_entry {
    fid_t fid; struct fi_info * info; uint8_t data[];
}; -}
#starttype struct fi_eq_cm_entry
#field fid , <fid_t>
#field info , Ptr <struct fi_info>
#field data , Ptr CUChar
#stoptype
{- struct fi_ops_eq {
    size_t size;
    ssize_t (* read)(struct fid_eq * eq,
                     uint32_t * event,
                     void * buf,
                     size_t len,
                     uint64_t flags);
    ssize_t (* readerr)(struct fid_eq * eq,
                        struct fi_eq_err_entry * buf,
                        uint64_t flags);
    ssize_t (* write)(struct fid_eq * eq,
                      uint32_t event,
                      const void * buf,
                      size_t len,
                      uint64_t flags);
    ssize_t (* sread)(struct fid_eq * eq,
                      uint32_t * event,
                      void * buf,
                      size_t len,
                      int timeout,
                      uint64_t flags);
    const char * (* strerror)(struct fid_eq * eq,
                              int prov_errno,
                              const void * err_data,
                              char * buf,
                              size_t len);
}; -}
#starttype struct fi_ops_eq
#field size , CSize
#field read , FunPtr (Ptr <struct fid_eq> -> Ptr CUInt -> Ptr () -> CSize -> CULong -> CLong)
#field readerr , FunPtr (Ptr <struct fid_eq> -> Ptr <struct fi_eq_err_entry> -> CULong -> CLong)
#field write , FunPtr (Ptr <struct fid_eq> -> CUInt -> Ptr () -> CSize -> CULong -> CLong)
#field sread , FunPtr (Ptr <struct fid_eq> -> Ptr CUInt -> Ptr () -> CSize -> CInt -> CULong -> CLong)
#field strerror , FunPtr (Ptr <struct fid_eq> -> CInt -> Ptr () -> CString -> CSize -> CString)
#stoptype
{- struct fid_eq {
    struct fid fid; struct fi_ops_eq * ops;
}; -}
#starttype struct fid_eq
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_eq>
#stoptype
{- enum fi_cq_format {
    FI_CQ_FORMAT_UNSPEC,
    FI_CQ_FORMAT_CONTEXT,
    FI_CQ_FORMAT_MSG,
    FI_CQ_FORMAT_DATA,
    FI_CQ_FORMAT_TAGGED
}; -}
#integral_t enum fi_cq_format
#num FI_CQ_FORMAT_UNSPEC
#num FI_CQ_FORMAT_CONTEXT
#num FI_CQ_FORMAT_MSG
#num FI_CQ_FORMAT_DATA
#num FI_CQ_FORMAT_TAGGED
{- struct fi_cq_entry {
    void * op_context;
}; -}
#starttype struct fi_cq_entry
#field op_context , Ptr ()
#stoptype
{- struct fi_cq_msg_entry {
    void * op_context; uint64_t flags; size_t len;
}; -}
#starttype struct fi_cq_msg_entry
#field op_context , Ptr ()
#field flags , CULong
#field len , CSize
#stoptype
{- struct fi_cq_data_entry {
    void * op_context;
    uint64_t flags;
    size_t len;
    void * buf;
    uint64_t data;
}; -}
#starttype struct fi_cq_data_entry
#field op_context , Ptr ()
#field flags , CULong
#field len , CSize
#field buf , Ptr ()
#field data , CULong
#stoptype
{- struct fi_cq_tagged_entry {
    void * op_context;
    uint64_t flags;
    size_t len;
    void * buf;
    uint64_t data;
    uint64_t tag;
}; -}
#starttype struct fi_cq_tagged_entry
#field op_context , Ptr ()
#field flags , CULong
#field len , CSize
#field buf , Ptr ()
#field data , CULong
#field tag , CULong
#stoptype
{- struct fi_cq_err_entry {
    void * op_context;
    uint64_t flags;
    size_t len;
    void * buf;
    uint64_t data;
    uint64_t tag;
    size_t olen;
    int err;
    int prov_errno;
    void * err_data;
    size_t err_data_size;
}; -}
#starttype struct fi_cq_err_entry
#field op_context , Ptr ()
#field flags , CULong
#field len , CSize
#field buf , Ptr ()
#field data , CULong
#field tag , CULong
#field olen , CSize
#field err , CInt
#field prov_errno , CInt
#field err_data , Ptr ()
#field err_data_size , CSize
#stoptype
{- enum fi_cq_wait_cond {
    FI_CQ_COND_NONE, FI_CQ_COND_THRESHOLD
}; -}
#integral_t enum fi_cq_wait_cond
#num FI_CQ_COND_NONE
#num FI_CQ_COND_THRESHOLD
{- struct fi_cq_attr {
    size_t size;
    uint64_t flags;
    enum fi_cq_format format;
    enum fi_wait_obj wait_obj;
    int signaling_vector;
    enum fi_cq_wait_cond wait_cond;
    struct fid_wait * wait_set;
}; -}
#starttype struct fi_cq_attr
#field size , CSize
#field flags , CULong
#field format , <enum fi_cq_format>
#field wait_obj , <enum fi_wait_obj>
#field signaling_vector , CInt
#field wait_cond , <enum fi_cq_wait_cond>
#field wait_set , Ptr <struct fid_wait>
#stoptype
{- struct fi_ops_cq {
    size_t size;
    ssize_t (* read)(struct fid_cq * cq, void * buf, size_t count);
    ssize_t (* readfrom)(struct fid_cq * cq,
                         void * buf,
                         size_t count,
                         fi_addr_t * src_addr);
    ssize_t (* readerr)(struct fid_cq * cq,
                        struct fi_cq_err_entry * buf,
                        uint64_t flags);
    ssize_t (* sread)(struct fid_cq * cq,
                      void * buf,
                      size_t count,
                      const void * cond,
                      int timeout);
    ssize_t (* sreadfrom)(struct fid_cq * cq,
                          void * buf,
                          size_t count,
                          fi_addr_t * src_addr,
                          const void * cond,
                          int timeout);
    int (* signal)(struct fid_cq * cq);
    const char * (* strerror)(struct fid_cq * cq,
                              int prov_errno,
                              const void * err_data,
                              char * buf,
                              size_t len);
}; -}
#starttype struct fi_ops_cq
#field size , CSize
#field read , FunPtr (Ptr <struct fid_cq> -> Ptr () -> CSize -> CLong)
#field readfrom , FunPtr (Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr CULong -> CLong)
#field readerr , FunPtr (Ptr <struct fid_cq> -> Ptr <struct fi_cq_err_entry> -> CULong -> CLong)
#field sread , FunPtr (Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr () -> CInt -> CLong)
#field sreadfrom , FunPtr (Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr CULong -> Ptr () -> CInt -> CLong)
#field signal , FunPtr (Ptr <struct fid_cq> -> CInt)
#field strerror , FunPtr (Ptr <struct fid_cq> -> CInt -> Ptr () -> CString -> CSize -> CString)
#stoptype
{- struct fid_cq {
    struct fid fid; struct fi_ops_cq * ops;
}; -}
#starttype struct fid_cq
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_cq>
#stoptype
{- enum fi_cntr_events {
    FI_CNTR_EVENTS_COMP
}; -}
#integral_t enum fi_cntr_events
#num FI_CNTR_EVENTS_COMP
{- struct fi_cntr_attr {
    enum fi_cntr_events events;
    enum fi_wait_obj wait_obj;
    struct fid_wait * wait_set;
    uint64_t flags;
}; -}
#starttype struct fi_cntr_attr
#field events , <enum fi_cntr_events>
#field wait_obj , <enum fi_wait_obj>
#field wait_set , Ptr <struct fid_wait>
#field flags , CULong
#stoptype
{- struct fi_ops_cntr {
    size_t size;
    uint64_t (* read)(struct fid_cntr * cntr);
    uint64_t (* readerr)(struct fid_cntr * cntr);
    int (* add)(struct fid_cntr * cntr, uint64_t value);
    int (* set)(struct fid_cntr * cntr, uint64_t value);
    int (* wait)(struct fid_cntr * cntr,
                 uint64_t threshold,
                 int timeout);
    int (* adderr)(struct fid_cntr * cntr, uint64_t value);
    int (* seterr)(struct fid_cntr * cntr, uint64_t value);
}; -}
#starttype struct fi_ops_cntr
#field size , CSize
#field read , FunPtr (Ptr <struct fid_cntr> -> CULong)
#field readerr , FunPtr (Ptr <struct fid_cntr> -> CULong)
#field add , FunPtr (Ptr <struct fid_cntr> -> CULong -> CInt)
#field set , FunPtr (Ptr <struct fid_cntr> -> CULong -> CInt)
#field wait , FunPtr (Ptr <struct fid_cntr> -> CULong -> CInt -> CInt)
#field adderr , FunPtr (Ptr <struct fid_cntr> -> CULong -> CInt)
#field seterr , FunPtr (Ptr <struct fid_cntr> -> CULong -> CInt)
#stoptype
{- struct fid_cntr {
    struct fid fid; struct fi_ops_cntr * ops;
}; -}
#starttype struct fid_cntr
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_cntr>
#stoptype
#cinline fi_trywait , Ptr <struct fid_fabric> -> Ptr (Ptr <struct fid>) -> CInt -> IO CInt
#cinline fi_wait , Ptr <struct fid_wait> -> CInt -> IO CInt
#cinline fi_poll , Ptr <struct fid_poll> -> Ptr (Ptr ()) -> CInt -> IO CInt
#cinline fi_poll_add , Ptr <struct fid_poll> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_poll_del , Ptr <struct fid_poll> -> Ptr <struct fid> -> CULong -> IO CInt
#cinline fi_eq_open , Ptr <struct fid_fabric> -> Ptr <struct fi_eq_attr> -> Ptr (Ptr <struct fid_eq>) -> Ptr () -> IO CInt
#cinline fi_eq_read , Ptr <struct fid_eq> -> Ptr CUInt -> Ptr () -> CSize -> CULong -> IO CLong
#cinline fi_eq_readerr , Ptr <struct fid_eq> -> Ptr <struct fi_eq_err_entry> -> CULong -> IO CLong
#cinline fi_eq_write , Ptr <struct fid_eq> -> CUInt -> Ptr () -> CSize -> CULong -> IO CLong
#cinline fi_eq_sread , Ptr <struct fid_eq> -> Ptr CUInt -> Ptr () -> CSize -> CInt -> CULong -> IO CLong
#cinline fi_eq_strerror , Ptr <struct fid_eq> -> CInt -> Ptr () -> CString -> CSize -> IO CString
#cinline fi_cq_read , Ptr <struct fid_cq> -> Ptr () -> CSize -> IO CLong
#cinline fi_cq_readfrom , Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr CULong -> IO CLong
#cinline fi_cq_readerr , Ptr <struct fid_cq> -> Ptr <struct fi_cq_err_entry> -> CULong -> IO CLong
#cinline fi_cq_sread , Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr () -> CInt -> IO CLong
#cinline fi_cq_sreadfrom , Ptr <struct fid_cq> -> Ptr () -> CSize -> Ptr CULong -> Ptr () -> CInt -> IO CLong
#cinline fi_cq_signal , Ptr <struct fid_cq> -> IO CInt
#cinline fi_cq_strerror , Ptr <struct fid_cq> -> CInt -> Ptr () -> CString -> CSize -> IO CString
#cinline fi_cntr_read , Ptr <struct fid_cntr> -> IO CULong
#cinline fi_cntr_readerr , Ptr <struct fid_cntr> -> IO CULong
#cinline fi_cntr_add , Ptr <struct fid_cntr> -> CULong -> IO CInt
#cinline fi_cntr_adderr , Ptr <struct fid_cntr> -> CULong -> IO CInt
#cinline fi_cntr_set , Ptr <struct fid_cntr> -> CULong -> IO CInt
#cinline fi_cntr_seterr , Ptr <struct fid_cntr> -> CULong -> IO CInt
#cinline fi_cntr_wait , Ptr <struct fid_cntr> -> CULong -> CInt -> IO CInt
