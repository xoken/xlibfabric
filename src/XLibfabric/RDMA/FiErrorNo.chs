module XLibfabric.RDMA.FiErrorNo where

#include <rdma/fi_errno.h>

fiSuccess = {#const FI_SUCCESS #}
fiEPerm = {#const FI_EPERM #} -- Operation not permitted
fiENoEnt = {#const FI_ENOENT #} -- No such file or directory
fiEIntr = {#const FI_EINTR #} -- Interrupted system call
fiEIO = {#const FI_EIO #} -- I/O error
fiE2Big = {#const FI_E2BIG #} -- Argument list too long
fiEBadF = {#const FI_EBADF #} -- Bad file number
fiEAgain = {#const FI_EAGAIN #} -- Try again
fiENoMem = {#const FI_ENOMEM #} -- Out of memory
fiEAcces = {#const FI_EACCES #} -- Permission denied
fiEFault = {#const FI_EFAULT #} -- Bad address
fiEBusy = {#const FI_EBUSY #} -- Device or resource busy
fiENoDev = {#const FI_ENODEV #} -- No such device
fiEInval = {#const FI_EINVAL #} -- Invalid argument
fiEMFile = {#const FI_EMFILE #} -- Too many open files
fiENoSpc = {#const FI_ENOSPC #} -- No space left on device
fiENoSys = {#const FI_ENOSYS #} -- Function not implemented
fiEWouldBlock = {#const FI_EWOULDBLOCK #} -- Operation would block
fiENoMsg = {#const FI_ENOMSG #} -- No message of desired type
fiENoData = {#const FI_ENODATA #} -- No data available
fiEOverflow = {#const FI_EOVERFLOW #} -- Value too large for defined data type
fiEMsgSize = {#const FI_EMSGSIZE #} -- Message too long
fiENoProtoOpt = {#const FI_ENOPROTOOPT #} -- Protocol not available
fiEOpNotSupp = {#const FI_EOPNOTSUPP #} -- Operation not supported on transport endpoint
fiEAddrInUse = {#const FI_EADDRINUSE #} -- Address already in use
fiEAddrNotAvail = {#const FI_EADDRNOTAVAIL #} -- Cannot assign requested address
fiENetDown = {#const FI_ENETDOWN #} -- Network is down
fiENetUnreach = {#const FI_ENETUNREACH #} -- Network is unreachable
fiEConnAborted = {#const FI_ECONNABORTED #} -- Software caused connection abort
fiEConnReset = {#const FI_ECONNRESET #} -- Connection reset by peer
fiENoBufs = {#const FI_ENOBUFS #} -- No buffer space available
fiEIsConn = {#const FI_EISCONN #} -- Transport endpoint is already connected
fiENotConn = {#const FI_ENOTCONN #} -- Transport endpoint is not connected
fiEShutdown = {#const FI_ESHUTDOWN #} -- Cannot send after transport endpoint shutdown
fiETimedOut = {#const FI_ETIMEDOUT #} -- Connection timed out
fiEConnRefused = {#const FI_ECONNREFUSED #} -- Connection refused
fiEHostDown = {#const FI_EHOSTDOWN #} -- Host is down
fiEHostUnreach = {#const FI_EHOSTUNREACH #} -- No route to host
fiEAlready = {#const FI_EALREADY #} -- Operation already in progress
fiEInProgress = {#const FI_EINPROGRESS #} -- Operation now in progress
fiERemoteIO = {#const FI_EREMOTEIO #} -- Remote I/O error
fiECanceled = {#const FI_ECANCELED #} -- Operation Canceled
fiEKeyRejected = {#const FI_EKEYREJECTED #} -- Key was rejected by service

-- FI specific return values: >= 256
fiErrnoOffset = {#const FI_ERRNO_OFFSET #}

{# enum define FiSpecificErr { FI_EOTHER as FiEOther
                             , FI_ETOOSMALL as FiETooSmall
                             , FI_EOPBADSTATE as FiEOpBadState
                             , FI_EAVAIL as FiEAvail
                             , FI_EBADFLAGS as FiEBadFlags
                             , FI_ENOEQ as FiENoEq
                             , FI_ECRC as FiECrc
                             , FI_ETRUNC as FiETrunc
                             , FI_ENOKEY as FiENoKey
                             , FI_ENOAV as FiENoAv
                             , FI_EOVERRUN as FiEOverrun
                             , FI_ERRNO_MAX as FiErrnoMax
                             } #}

-- FI_EOTHER        = FI_ERRNO_OFFSET
-- FI_ETOOSMALL     = 257, Provided buffer is too small
-- FI_EOPBADSTATE   = 258, Operation not permitted in current state
-- FI_EAVAIL        = 259, Error available
-- FI_EBADFLAGS     = 260, Flags not supported
-- FI_ENOEQ         = 261, Missing or unavailable event queue
-- FI_EDOMAIN       = 262, Invalid resource domain
-- FI_ENOCQ         = 263, Missing or unavailable completion queue
-- FI_ECRC          = 264, CRC error
-- FI_ETRUNC        = 265, Truncation error
-- FI_ENOKEY        = 266, Required key not available
-- FI_ENOAV	        = 267, Missing or unavailable address vector
-- FI_EOVERRUN      = 268, Queue has been overrun
-- FI_ERRNO_MAX

{-
const char *fi_strerror(int errnum);
-}