{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_trigger.h>
module XLibfabric.RDMA.FiTrigger where
import Foreign.Ptr
#strict_import

{- enum fi_trigger_event {
    FI_TRIGGER_THRESHOLD
}; -}
#integral_t enum fi_trigger_event
#num FI_TRIGGER_THRESHOLD
{- enum fi_op_type {
    FI_OP_RECV,
    FI_OP_SEND,
    FI_OP_TRECV,
    FI_OP_TSEND,
    FI_OP_READ,
    FI_OP_WRITE,
    FI_OP_ATOMIC,
    FI_OP_FETCH_ATOMIC,
    FI_OP_COMPARE_ATOMIC,
    FI_OP_CNTR_SET,
    FI_OP_CNTR_ADD
}; -}
#integral_t enum fi_op_type
#num FI_OP_RECV
#num FI_OP_SEND
#num FI_OP_TRECV
#num FI_OP_TSEND
#num FI_OP_READ
#num FI_OP_WRITE
#num FI_OP_ATOMIC
#num FI_OP_FETCH_ATOMIC
#num FI_OP_COMPARE_ATOMIC
#num FI_OP_CNTR_SET
#num FI_OP_CNTR_ADD
{- struct fi_trigger_threshold {
    struct fid_cntr * cntr; size_t threshold;
}; -}
#starttype struct fi_trigger_threshold
#field cntr , Ptr <struct fid_cntr>
#field threshold , CSize
#stoptype
{- struct fi_op_msg {
    struct fid_ep * ep; struct fi_msg msg; uint64_t flags;
}; -}
#starttype struct fi_op_msg
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg>
#field flags , CULong
#stoptype
{- struct fi_op_tagged {
    struct fid_ep * ep; struct fi_msg_tagged msg; uint64_t flags;
}; -}
#starttype struct fi_op_tagged
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg_tagged>
#field flags , CULong
#stoptype
{- struct fi_op_rma {
    struct fid_ep * ep; struct fi_msg_rma msg; uint64_t flags;
}; -}
#starttype struct fi_op_rma
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg_rma>
#field flags , CULong
#stoptype
{- struct fi_op_atomic {
    struct fid_ep * ep; struct fi_msg_atomic msg; uint64_t flags;
}; -}
#starttype struct fi_op_atomic
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg_atomic>
#field flags , CULong
#stoptype
{- struct fi_op_fetch_atomic {
    struct fid_ep * ep;
    struct fi_msg_atomic msg;
    struct fi_msg_fetch fetch;
    uint64_t flags;
}; -}
#starttype struct fi_op_fetch_atomic
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg_atomic>
#field fetch , <struct fi_msg_fetch>
#field flags , CULong
#stoptype
{- struct fi_op_compare_atomic {
    struct fid_ep * ep;
    struct fi_msg_atomic msg;
    struct fi_msg_fetch fetch;
    struct fi_msg_compare compare;
    uint64_t flags;
}; -}
#starttype struct fi_op_compare_atomic
#field ep , Ptr <struct fid_ep>
#field msg , <struct fi_msg_atomic>
#field fetch , <struct fi_msg_fetch>
#field compare , <struct fi_msg_compare>
#field flags , CULong
#stoptype
{- struct fi_op_cntr {
    struct fid_cntr * cntr; uint64_t value;
}; -}
#starttype struct fi_op_cntr
#field cntr , Ptr <struct fid_cntr>
#field value , CULong
#stoptype
{- struct fi_triggered_context {
    enum fi_trigger_event event_type;
    union {
        struct fi_trigger_threshold threshold; void * internal[3];
    } trigger;
}; -}
#starttype struct fi_triggered_context
#field event_type , <enum fi_trigger_event>
#field trigger , 
#stoptype
{- struct fi_triggered_context2 {
    enum fi_trigger_event event_type;
    union {
        struct fi_trigger_threshold threshold; void * internal[7];
    } trigger;
}; -}
#starttype struct fi_triggered_context2
#field event_type , <enum fi_trigger_event>
#field trigger , 
#stoptype
{- struct fi_deferred_work {
    struct fi_context2 context;
    uint64_t threshold;
    struct fid_cntr * triggering_cntr;
    struct fid_cntr * completion_cntr;
    enum fi_op_type op_type;
    union {
        struct fi_op_msg * msg;
        struct fi_op_tagged * tagged;
        struct fi_op_rma * rma;
        struct fi_op_atomic * atomic;
        struct fi_op_fetch_atomic * fetch_atomic;
        struct fi_op_compare_atomic * compare_atomic;
        struct fi_op_cntr * cntr;
    } op;
}; -}
#starttype struct fi_deferred_work
#field context , <struct fi_context2>
#field threshold , CULong
#field triggering_cntr , Ptr <struct fid_cntr>
#field completion_cntr , Ptr <struct fid_cntr>
#field op_type , <enum fi_op_type>
#field op , 
#stoptype
