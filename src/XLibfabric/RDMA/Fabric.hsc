{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fabric.h>
module XLibfabric.RDMA.Fabric where
import Foreign.Ptr
import XLibfabric.RDMA.FiErrno
#strict_import

{- enum {
    FI_PATH_MAX = 256, FI_NAME_MAX = 64, FI_VERSION_MAX = 64
}; -}
#num FI_PATH_MAX
#num FI_NAME_MAX
#num FI_VERSION_MAX
#ccall fi_version , IO CUInt
{-
{- struct fid; -}
#opaque_t struct fid
{- struct fid_fabric; -}
#opaque_t struct fid_fabric
-}
{- struct fid_domain; -}
#opaque_t struct fid_domain
{- struct fid_av; -}
#opaque_t struct fid_av
{- struct fid_wait; -}
#opaque_t struct fid_wait
{- struct fid_poll; -}
#opaque_t struct fid_poll
{- struct fid_eq; -}
#opaque_t struct fid_eq
{- struct fid_cq; -}
#opaque_t struct fid_cq
{- struct fid_cntr; -}
#opaque_t struct fid_cntr
{- struct fid_ep; -}
#opaque_t struct fid_ep
{- struct fid_pep; -}
#opaque_t struct fid_pep
{- struct fid_stx; -}
#opaque_t struct fid_stx
{- struct fid_mr; -}
#opaque_t struct fid_mr
{- struct fid_nic; -}
{-
#opaque_t struct fid_nic
{- struct fi_ioc {
    void * addr; size_t count;
}; -}
-}
#starttype struct fi_ioc
#field addr , Ptr ()
#field count , CSize
#stoptype
{- enum {
    FI_FORMAT_UNSPEC,
    FI_SOCKADDR,
    FI_SOCKADDR_IN,
    FI_SOCKADDR_IN6,
    FI_SOCKADDR_IB,
    FI_ADDR_PSMX,
    FI_ADDR_GNI,
    FI_ADDR_BGQ,
    FI_ADDR_MLX,
    FI_ADDR_STR,
    FI_ADDR_PSMX2,
    FI_ADDR_IB_UD,
    FI_ADDR_EFA
}; -}
#num FI_FORMAT_UNSPEC
#num FI_SOCKADDR
#num FI_SOCKADDR_IN
#num FI_SOCKADDR_IN6
#num FI_SOCKADDR_IB
#num FI_ADDR_PSMX
#num FI_ADDR_GNI
#num FI_ADDR_BGQ
#num FI_ADDR_MLX
#num FI_ADDR_STR
#num FI_ADDR_PSMX2
#num FI_ADDR_IB_UD
#num FI_ADDR_EFA
{- typedef uint64_t fi_addr_t; -}
#synonym_t fi_addr_t , CULong
{- enum fi_av_type {
    FI_AV_UNSPEC, FI_AV_MAP, FI_AV_TABLE
}; -}
#integral_t enum fi_av_type
#num FI_AV_UNSPEC
#num FI_AV_MAP
#num FI_AV_TABLE
{- enum fi_mr_mode {
    FI_MR_UNSPEC, FI_MR_BASIC, FI_MR_SCALABLE
}; -}
#integral_t enum fi_mr_mode
#num FI_MR_UNSPEC
#num FI_MR_BASIC
#num FI_MR_SCALABLE
{- enum fi_progress {
    FI_PROGRESS_UNSPEC, FI_PROGRESS_AUTO, FI_PROGRESS_MANUAL
}; -}
#integral_t enum fi_progress
#num FI_PROGRESS_UNSPEC
#num FI_PROGRESS_AUTO
#num FI_PROGRESS_MANUAL
{- enum fi_threading {
    FI_THREAD_UNSPEC,
    FI_THREAD_SAFE,
    FI_THREAD_FID,
    FI_THREAD_DOMAIN,
    FI_THREAD_COMPLETION,
    FI_THREAD_ENDPOINT
}; -}
#integral_t enum fi_threading
#num FI_THREAD_UNSPEC
#num FI_THREAD_SAFE
#num FI_THREAD_FID
#num FI_THREAD_DOMAIN
#num FI_THREAD_COMPLETION
#num FI_THREAD_ENDPOINT
{- enum fi_resource_mgmt {
    FI_RM_UNSPEC, FI_RM_DISABLED, FI_RM_ENABLED
}; -}
#integral_t enum fi_resource_mgmt
#num FI_RM_UNSPEC
#num FI_RM_DISABLED
#num FI_RM_ENABLED
{- enum fi_ep_type {
    FI_EP_UNSPEC,
    FI_EP_MSG,
    FI_EP_DGRAM,
    FI_EP_RDM,
    FI_EP_SOCK_STREAM,
    FI_EP_SOCK_DGRAM
}; -}
#integral_t enum fi_ep_type
#num FI_EP_UNSPEC
#num FI_EP_MSG
#num FI_EP_DGRAM
#num FI_EP_RDM
#num FI_EP_SOCK_STREAM
#num FI_EP_SOCK_DGRAM
{- enum {
    FI_PROTO_UNSPEC,
    FI_PROTO_RDMA_CM_IB_RC,
    FI_PROTO_IWARP,
    FI_PROTO_IB_UD,
    FI_PROTO_PSMX,
    FI_PROTO_UDP,
    FI_PROTO_SOCK_TCP,
    FI_PROTO_MXM,
    FI_PROTO_IWARP_RDM,
    FI_PROTO_IB_RDM,
    FI_PROTO_GNI,
    FI_PROTO_RXM,
    FI_PROTO_RXD,
    FI_PROTO_MLX,
    FI_PROTO_NETWORKDIRECT,
    FI_PROTO_PSMX2,
    FI_PROTO_SHM,
    FI_PROTO_MRAIL,
    FI_PROTO_RSTREAM,
    FI_PROTO_RDMA_CM_IB_XRC,
    FI_PROTO_EFA
}; -}
#num FI_PROTO_UNSPEC
#num FI_PROTO_RDMA_CM_IB_RC
#num FI_PROTO_IWARP
#num FI_PROTO_IB_UD
#num FI_PROTO_PSMX
#num FI_PROTO_UDP
#num FI_PROTO_SOCK_TCP
#num FI_PROTO_MXM
#num FI_PROTO_IWARP_RDM
#num FI_PROTO_IB_RDM
#num FI_PROTO_GNI
#num FI_PROTO_RXM
#num FI_PROTO_RXD
#num FI_PROTO_MLX
#num FI_PROTO_NETWORKDIRECT
#num FI_PROTO_PSMX2
#num FI_PROTO_SHM
#num FI_PROTO_MRAIL
#num FI_PROTO_RSTREAM
#num FI_PROTO_RDMA_CM_IB_XRC
#num FI_PROTO_EFA
{- enum {
    FI_TC_UNSPEC = 0,
    FI_TC_DSCP = 0x100,
    FI_TC_LABEL = 0x200,
    FI_TC_BEST_EFFORT = FI_TC_LABEL,
    FI_TC_LOW_LATENCY,
    FI_TC_DEDICATED_ACCESS,
    FI_TC_BULK_DATA,
    FI_TC_SCAVENGER,
    FI_TC_NETWORK_CTRL
}; -}
#num FI_TC_UNSPEC
#num FI_TC_DSCP
#num FI_TC_LABEL
#num FI_TC_BEST_EFFORT
#num FI_TC_LOW_LATENCY
#num FI_TC_DEDICATED_ACCESS
#num FI_TC_BULK_DATA
#num FI_TC_SCAVENGER
#num FI_TC_NETWORK_CTRL
#cinline fi_tc_dscp_set , CUChar -> IO CUInt
#cinline fi_tc_dscp_get , CUInt -> IO CUChar
{- struct fi_tx_attr {
    uint64_t caps;
    uint64_t mode;
    uint64_t op_flags;
    uint64_t msg_order;
    uint64_t comp_order;
    size_t inject_size;
    size_t size;
    size_t iov_limit;
    size_t rma_iov_limit;
    uint32_t tclass;
}; -}
#starttype struct fi_tx_attr
#field caps , CULong
#field mode , CULong
#field op_flags , CULong
#field msg_order , CULong
#field comp_order , CULong
#field inject_size , CSize
#field size , CSize
#field iov_limit , CSize
#field rma_iov_limit , CSize
#field tclass , CUInt
#stoptype
{- struct fi_rx_attr {
    uint64_t caps;
    uint64_t mode;
    uint64_t op_flags;
    uint64_t msg_order;
    uint64_t comp_order;
    size_t total_buffered_recv;
    size_t size;
    size_t iov_limit;
}; -}
#starttype struct fi_rx_attr
#field caps , CULong
#field mode , CULong
#field op_flags , CULong
#field msg_order , CULong
#field comp_order , CULong
#field total_buffered_recv , CSize
#field size , CSize
#field iov_limit , CSize
#stoptype
{- struct fi_ep_attr {
    enum fi_ep_type type;
    uint32_t protocol;
    uint32_t protocol_version;
    size_t max_msg_size;
    size_t msg_prefix_size;
    size_t max_order_raw_size;
    size_t max_order_war_size;
    size_t max_order_waw_size;
    uint64_t mem_tag_format;
    size_t tx_ctx_cnt;
    size_t rx_ctx_cnt;
    size_t auth_key_size;
    uint8_t * auth_key;
}; -}
#starttype struct fi_ep_attr
#field type , <enum fi_ep_type>
#field protocol , CUInt
#field protocol_version , CUInt
#field max_msg_size , CSize
#field msg_prefix_size , CSize
#field max_order_raw_size , CSize
#field max_order_war_size , CSize
#field max_order_waw_size , CSize
#field mem_tag_format , CULong
#field tx_ctx_cnt , CSize
#field rx_ctx_cnt , CSize
#field auth_key_size , CSize
#field auth_key , Ptr CUChar
#stoptype
{- struct fi_domain_attr {
    struct fid_domain * domain;
    char * name;
    enum fi_threading threading;
    enum fi_progress control_progress;
    enum fi_progress data_progress;
    enum fi_resource_mgmt resource_mgmt;
    enum fi_av_type av_type;
    int mr_mode;
    size_t mr_key_size;
    size_t cq_data_size;
    size_t cq_cnt;
    size_t ep_cnt;
    size_t tx_ctx_cnt;
    size_t rx_ctx_cnt;
    size_t max_ep_tx_ctx;
    size_t max_ep_rx_ctx;
    size_t max_ep_stx_ctx;
    size_t max_ep_srx_ctx;
    size_t cntr_cnt;
    size_t mr_iov_limit;
    uint64_t caps;
    uint64_t mode;
    uint8_t * auth_key;
    size_t auth_key_size;
    size_t max_err_data;
    size_t mr_cnt;
    uint32_t tclass;
}; -}
#starttype struct fi_domain_attr
#field domain , Ptr <struct fid_domain>
#field name , CString
#field threading , <enum fi_threading>
#field control_progress , <enum fi_progress>
#field data_progress , <enum fi_progress>
#field resource_mgmt , <enum fi_resource_mgmt>
#field av_type , <enum fi_av_type>
#field mr_mode , CInt
#field mr_key_size , CSize
#field cq_data_size , CSize
#field cq_cnt , CSize
#field ep_cnt , CSize
#field tx_ctx_cnt , CSize
#field rx_ctx_cnt , CSize
#field max_ep_tx_ctx , CSize
#field max_ep_rx_ctx , CSize
#field max_ep_stx_ctx , CSize
#field max_ep_srx_ctx , CSize
#field cntr_cnt , CSize
#field mr_iov_limit , CSize
#field caps , CULong
#field mode , CULong
#field auth_key , Ptr CUChar
#field auth_key_size , CSize
#field max_err_data , CSize
#field mr_cnt , CSize
#field tclass , CUInt
#stoptype
{- struct fi_fabric_attr {
    struct fid_fabric * fabric;
    char * name;
    char * prov_name;
    uint32_t prov_version;
    uint32_t api_version;
}; -}
#starttype struct fi_fabric_attr
#field fabric , Ptr <struct fid_fabric>
#field name , CString
#field prov_name , CString
#field prov_version , CUInt
#field api_version , CUInt
#stoptype
{- struct fi_info {
    struct fi_info * next;
    uint64_t caps;
    uint64_t mode;
    uint32_t addr_format;
    size_t src_addrlen;
    size_t dest_addrlen;
    void * src_addr;
    void * dest_addr;
    fid_t handle;
    struct fi_tx_attr * tx_attr;
    struct fi_rx_attr * rx_attr;
    struct fi_ep_attr * ep_attr;
    struct fi_domain_attr * domain_attr;
    struct fi_fabric_attr * fabric_attr;
    struct fid_nic * nic;
}; -}
#starttype struct fi_info
#field next , Ptr <struct fi_info>
#field caps , CULong
#field mode , CULong
#field addr_format , CUInt
#field src_addrlen , CSize
#field dest_addrlen , CSize
#field src_addr , Ptr ()
#field dest_addr , Ptr ()
#field handle , <fid_t>
#field tx_attr , Ptr <struct fi_tx_attr>
#field rx_attr , Ptr <struct fi_rx_attr>
#field ep_attr , Ptr <struct fi_ep_attr>
#field domain_attr , Ptr <struct fi_domain_attr>
#field fabric_attr , Ptr <struct fi_fabric_attr>
#field nic , Ptr <struct fid_nic>
#stoptype
{- struct fi_device_attr {
    char * name;
    char * device_id;
    char * device_version;
    char * vendor_id;
    char * driver;
    char * firmware;
}; -}
#starttype struct fi_device_attr
#field name , CString
#field device_id , CString
#field device_version , CString
#field vendor_id , CString
#field driver , CString
#field firmware , CString
#stoptype
{- enum fi_bus_type {
    FI_BUS_UNSPEC, FI_BUS_UNKNOWN = FI_BUS_UNSPEC, FI_BUS_PCI
}; -}
#integral_t enum fi_bus_type
#num FI_BUS_UNSPEC
#num FI_BUS_UNKNOWN
#num FI_BUS_PCI
{- struct fi_pci_attr {
    uint16_t domain_id;
    uint8_t bus_id;
    uint8_t device_id;
    uint8_t function_id;
}; -}
#starttype struct fi_pci_attr
#field domain_id , CUShort
#field bus_id , CUChar
#field device_id , CUChar
#field function_id , CUChar
#stoptype
{- struct fi_bus_attr {
    enum fi_bus_type bus_type;
    union {
        struct fi_pci_attr pci;
    } attr;
}; -}
#starttype struct fi_bus_attr
#field bus_type , <enum fi_bus_type>
#field attr.pci , <struct fi_pci_attr>
#stoptype
{- enum fi_link_state {
    FI_LINK_UNKNOWN, FI_LINK_DOWN, FI_LINK_UP
}; -}
#integral_t enum fi_link_state
#num FI_LINK_UNKNOWN
#num FI_LINK_DOWN
#num FI_LINK_UP
{- struct fi_link_attr {
    char * address;
    size_t mtu;
    size_t speed;
    enum fi_link_state state;
    char * network_type;
}; -}
#starttype struct fi_link_attr
#field address , CString
#field mtu , CSize
#field speed , CSize
#field state , <enum fi_link_state>
#field network_type , CString
#stoptype
{- enum {
    FI_CLASS_UNSPEC,
    FI_CLASS_FABRIC,
    FI_CLASS_DOMAIN,
    FI_CLASS_EP,
    FI_CLASS_SEP,
    FI_CLASS_RX_CTX,
    FI_CLASS_SRX_CTX,
    FI_CLASS_TX_CTX,
    FI_CLASS_STX_CTX,
    FI_CLASS_PEP,
    FI_CLASS_INTERFACE,
    FI_CLASS_AV,
    FI_CLASS_MR,
    FI_CLASS_EQ,
    FI_CLASS_CQ,
    FI_CLASS_CNTR,
    FI_CLASS_WAIT,
    FI_CLASS_POLL,
    FI_CLASS_CONNREQ,
    FI_CLASS_MC,
    FI_CLASS_NIC,
    FI_CLASS_AV_SET
}; -}
#num FI_CLASS_UNSPEC
#num FI_CLASS_FABRIC
#num FI_CLASS_DOMAIN
#num FI_CLASS_EP
#num FI_CLASS_SEP
#num FI_CLASS_RX_CTX
#num FI_CLASS_SRX_CTX
#num FI_CLASS_TX_CTX
#num FI_CLASS_STX_CTX
#num FI_CLASS_PEP
#num FI_CLASS_INTERFACE
#num FI_CLASS_AV
#num FI_CLASS_MR
#num FI_CLASS_EQ
#num FI_CLASS_CQ
#num FI_CLASS_CNTR
#num FI_CLASS_WAIT
#num FI_CLASS_POLL
#num FI_CLASS_CONNREQ
#num FI_CLASS_MC
#num FI_CLASS_NIC
#num FI_CLASS_AV_SET
{- struct fi_eq_attr; -}
#opaque_t struct fi_eq_attr
{- struct fi_wait_attr; -}
#opaque_t struct fi_wait_attr
{- struct fi_ops {
    size_t size;
    int (* close)(struct fid * fid);
    int (* bind)(struct fid * fid, struct fid * bfid, uint64_t flags);
    int (* control)(struct fid * fid, int command, void * arg);
    int (* ops_open)(struct fid * fid,
                     const char * name,
                     uint64_t flags,
                     void * * ops,
                     void * context);
    int (* tostr)(const struct fid * fid, char * buf, size_t len);
    int (* ops_set)(struct fid * fid,
                    const char * name,
                    uint64_t flags,
                    void * ops,
                    void * context);
}; -}
#starttype struct fi_ops
#field size , CSize
#field close , FunPtr (Ptr <struct fid> -> CInt)
#field bind , FunPtr (Ptr <struct fid> -> Ptr <struct fid> -> CULong -> CInt)
#field control , FunPtr (Ptr <struct fid> -> CInt -> Ptr () -> CInt)
#field ops_open , FunPtr (Ptr <struct fid> -> CString -> CULong -> Ptr (Ptr ()) -> Ptr () -> CInt)
#field tostr , FunPtr (Ptr <struct fid> -> CString -> CSize -> CInt)
#field ops_set , FunPtr (Ptr <struct fid> -> CString -> CULong -> Ptr () -> Ptr () -> CInt)
#stoptype
{- struct fid {
    size_t fclass; void * context; struct fi_ops * ops;
}; -}
#starttype struct fid
#field fclass , CSize
#field context , Ptr ()
#field ops , Ptr <struct fi_ops>
#stoptype
#ccall fi_getinfo , CUInt -> CString -> CString -> CULong -> Ptr <struct fi_info> -> Ptr (Ptr <struct fi_info>) -> IO CInt
#ccall fi_freeinfo , Ptr <struct fi_info> -> IO ()
#ccall fi_dupinfo , Ptr <struct fi_info> -> IO (Ptr <struct fi_info>)
#cinline fi_allocinfo , IO (Ptr <struct fi_info>)

#globalvar fid_t , Ptr (<struct fid>)

{- struct fi_ops_fabric {
    size_t size;
    int (* domain)(struct fid_fabric * fabric,
                   struct fi_info * info,
                   struct fid_domain * * dom,
                   void * context);
    int (* passive_ep)(struct fid_fabric * fabric,
                       struct fi_info * info,
                       struct fid_pep * * pep,
                       void * context);
    int (* eq_open)(struct fid_fabric * fabric,
                    struct fi_eq_attr * attr,
                    struct fid_eq * * eq,
                    void * context);
    int (* wait_open)(struct fid_fabric * fabric,
                      struct fi_wait_attr * attr,
                      struct fid_wait * * waitset);
    int (* trywait)(struct fid_fabric * fabric,
                    struct fid * * fids,
                    int count);
}; -}
#starttype struct fi_ops_fabric
#field size , CSize
#field domain , FunPtr (Ptr <struct fid_fabric> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_domain>) -> Ptr () -> CInt)
#field passive_ep , FunPtr (Ptr <struct fid_fabric> -> Ptr <struct fi_info> -> Ptr (Ptr <struct fid_pep>) -> Ptr () -> CInt)
#field eq_open , FunPtr (Ptr <struct fid_fabric> -> Ptr <struct fi_eq_attr> -> Ptr (Ptr <struct fid_eq>) -> Ptr () -> CInt)
#field wait_open , FunPtr (Ptr <struct fid_fabric> -> Ptr <struct fi_wait_attr> -> Ptr (Ptr <struct fid_wait>) -> CInt)
#field trywait , FunPtr (Ptr <struct fid_fabric> -> Ptr (Ptr <struct fid>) -> CInt -> CInt)
#stoptype
{- struct fid_fabric {
    struct fid fid; struct fi_ops_fabric * ops; uint32_t api_version;
}; -}
#starttype struct fid_fabric
#field fid , <struct fid>
#field ops , Ptr <struct fi_ops_fabric>
#field api_version , CUInt
#stoptype
#ccall fi_fabric , Ptr <struct fi_fabric_attr> -> Ptr (Ptr <struct fid_fabric>) -> Ptr () -> IO CInt
{- struct fid_nic {
    struct fid fid;
    struct fi_device_attr * device_attr;
    struct fi_bus_attr * bus_attr;
    struct fi_link_attr * link_attr;
    void * prov_attr;
}; -}
#starttype struct fid_nic
#field fid , <struct fid>
#field device_attr , Ptr <struct fi_device_attr>
#field bus_attr , Ptr <struct fi_bus_attr>
#field link_attr , Ptr <struct fi_link_attr>
#field prov_attr , Ptr ()
#stoptype
#cinline fi_close , Ptr <struct fid> -> IO CInt
{- struct fi_alias {
    struct fid * * fid; uint64_t flags;
}; -}
#starttype struct fi_alias
#field fid , Ptr (Ptr <struct fid>)
#field flags , CULong
#stoptype
{- struct fi_mr_raw_attr {
    uint64_t flags;
    uint64_t * base_addr;
    uint8_t * raw_key;
    size_t * key_size;
}; -}
#starttype struct fi_mr_raw_attr
#field flags , CULong
#field base_addr , Ptr CULong
#field raw_key , Ptr CUChar
#field key_size , Ptr CSize
#stoptype
{- struct fi_mr_map_raw {
    uint64_t flags;
    uint64_t base_addr;
    uint8_t * raw_key;
    size_t key_size;
    uint64_t * key;
}; -}
#starttype struct fi_mr_map_raw
#field flags , CULong
#field base_addr , CULong
#field raw_key , Ptr CUChar
#field key_size , CSize
#field key , Ptr CULong
#stoptype
{- enum {
    FI_GETFIDFLAG,
    FI_SETFIDFLAG,
    FI_GETOPSFLAG,
    FI_SETOPSFLAG,
    FI_ALIAS,
    FI_GETWAIT,
    FI_ENABLE,
    FI_BACKLOG,
    FI_GET_RAW_MR,
    FI_MAP_RAW_MR,
    FI_UNMAP_KEY,
    FI_QUEUE_WORK,
    FI_CANCEL_WORK,
    FI_FLUSH_WORK,
    FI_REFRESH,
    FI_DUP,
    FI_GETWAITOBJ
}; -}
#num FI_GETFIDFLAG
#num FI_SETFIDFLAG
#num FI_GETOPSFLAG
#num FI_SETOPSFLAG
#num FI_ALIAS
#num FI_GETWAIT
#num FI_ENABLE
#num FI_BACKLOG
#num FI_GET_RAW_MR
#num FI_MAP_RAW_MR
#num FI_UNMAP_KEY
#num FI_QUEUE_WORK
#num FI_CANCEL_WORK
#num FI_FLUSH_WORK
#num FI_REFRESH
#num FI_DUP
#num FI_GETWAITOBJ
#cinline fi_control , Ptr <struct fid> -> CInt -> Ptr () -> IO CInt
#cinline fi_alias , Ptr <struct fid> -> Ptr (Ptr <struct fid>) -> CULong -> IO CInt
#cinline fi_open_ops , Ptr <struct fid> -> CString -> CULong -> Ptr (Ptr ()) -> Ptr () -> IO CInt
#cinline fi_set_ops , Ptr <struct fid> -> CString -> CULong -> Ptr () -> Ptr () -> IO CInt
{- enum fi_type {
    FI_TYPE_INFO,
    FI_TYPE_EP_TYPE,
    FI_TYPE_CAPS,
    FI_TYPE_OP_FLAGS,
    FI_TYPE_ADDR_FORMAT,
    FI_TYPE_TX_ATTR,
    FI_TYPE_RX_ATTR,
    FI_TYPE_EP_ATTR,
    FI_TYPE_DOMAIN_ATTR,
    FI_TYPE_FABRIC_ATTR,
    FI_TYPE_THREADING,
    FI_TYPE_PROGRESS,
    FI_TYPE_PROTOCOL,
    FI_TYPE_MSG_ORDER,
    FI_TYPE_MODE,
    FI_TYPE_AV_TYPE,
    FI_TYPE_ATOMIC_TYPE,
    FI_TYPE_ATOMIC_OP,
    FI_TYPE_VERSION,
    FI_TYPE_EQ_EVENT,
    FI_TYPE_CQ_EVENT_FLAGS,
    FI_TYPE_MR_MODE,
    FI_TYPE_OP_TYPE,
    FI_TYPE_FID,
    FI_TYPE_COLLECTIVE_OP,
    FI_TYPE_HMEM_IFACE
}; -}
#integral_t enum fi_type
#num FI_TYPE_INFO
#num FI_TYPE_EP_TYPE
#num FI_TYPE_CAPS
#num FI_TYPE_OP_FLAGS
#num FI_TYPE_ADDR_FORMAT
#num FI_TYPE_TX_ATTR
#num FI_TYPE_RX_ATTR
#num FI_TYPE_EP_ATTR
#num FI_TYPE_DOMAIN_ATTR
#num FI_TYPE_FABRIC_ATTR
#num FI_TYPE_THREADING
#num FI_TYPE_PROGRESS
#num FI_TYPE_PROTOCOL
#num FI_TYPE_MSG_ORDER
#num FI_TYPE_MODE
#num FI_TYPE_AV_TYPE
#num FI_TYPE_ATOMIC_TYPE
#num FI_TYPE_ATOMIC_OP
#num FI_TYPE_VERSION
#num FI_TYPE_EQ_EVENT
#num FI_TYPE_CQ_EVENT_FLAGS
#num FI_TYPE_MR_MODE
#num FI_TYPE_OP_TYPE
#num FI_TYPE_FID
#num FI_TYPE_COLLECTIVE_OP
#num FI_TYPE_HMEM_IFACE
#ccall fi_tostr , Ptr () -> <enum fi_type> -> IO CString
{- enum fi_param_type {
    FI_PARAM_STRING, FI_PARAM_INT, FI_PARAM_BOOL, FI_PARAM_SIZE_T
}; -}
#integral_t enum fi_param_type
#num FI_PARAM_STRING
#num FI_PARAM_INT
#num FI_PARAM_BOOL
#num FI_PARAM_SIZE_T
{- struct fi_param {
    const char * name;
    enum fi_param_type type;
    const char * help_string;
    const char * value;
}; -}
#starttype struct fi_param
#field name , CString
#field type , <enum fi_param_type>
#field help_string , CString
#field value , CString
#stoptype
#ccall fi_getparams , Ptr (Ptr <struct fi_param>) -> Ptr CInt -> IO CInt
#ccall fi_freeparams , Ptr <struct fi_param> -> IO ()
{- struct fi_context {
    void * internal[4];
}; -}
#starttype struct fi_context
#array_field internal , Ptr ()
#stoptype
{- struct fi_context2 {
    void * internal[8];
}; -}
#starttype struct fi_context2
#array_field internal , Ptr ()
#stoptype
{- struct fi_recv_context {
    struct fid_ep * ep; void * context;
}; -}
#starttype struct fi_recv_context
#field ep , Ptr <struct fid_ep>
#field context , Ptr ()
#stoptype
