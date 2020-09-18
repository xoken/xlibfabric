{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <rdma/fi_errno.h>
module XLibfabric.RDMA.FiErrno where
import Foreign.Ptr
#strict_import

{- enum {
    FI_EOTHER = 256,
    FI_ETOOSMALL = 257,
    FI_EOPBADSTATE = 258,
    FI_EAVAIL = 259,
    FI_EBADFLAGS = 260,
    FI_ENOEQ = 261,
    FI_EDOMAIN = 262,
    FI_ENOCQ = 263,
    FI_ECRC = 264,
    FI_ETRUNC = 265,
    FI_ENOKEY = 266,
    FI_ENOAV = 267,
    FI_EOVERRUN = 268,
    FI_ERRNO_MAX
}; -}
#num FI_EOTHER
#num FI_ETOOSMALL
#num FI_EOPBADSTATE
#num FI_EAVAIL
#num FI_EBADFLAGS
#num FI_ENOEQ
#num FI_EDOMAIN
#num FI_ENOCQ
#num FI_ECRC
#num FI_ETRUNC
#num FI_ENOKEY
#num FI_ENOAV
#num FI_EOVERRUN
#num FI_ERRNO_MAX
#ccall fi_strerror , CInt -> IO CString
