{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Main where

import Foreign.Marshal.Array
import Foreign.Marshal.Alloc
import Foreign.Storable
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr
import System.Environment
import XLibfabric.RDMA.Fabric hiding (C'fid_ep, C'fid_pep, C'fid_eq)
import XLibfabric.RDMA.FiEndpoint
import XLibfabric.RDMA.FiEq as Eq
import XLibfabric.RDMA.FiCm
import Scalable

main :: IO ()
main = do
    a <- getArgs
    b <- c'fi_allocinfo
    --case a of
        --[] -> do
            --withCString "xlibfabric" $ \ptrx -> msg 1 [ptrx]
        --(addr:_) -> do
            --withCString "xlibfabric" $ \ptrx -> withCString addr $ \ptra -> msg 1 [ptrx,ptra]-}
    print a
    print b
    scalable