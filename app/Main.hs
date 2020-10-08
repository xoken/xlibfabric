{-# LANGUAGE OverloadedStrings #-}
module Main where

import Foreign.Marshal.Array
import Foreign.C.String
import System.Environment
import XLibfabric.RDMA.Fabric
--import Msg

main :: IO ()
main = do
    a <- getArgs
    b <- c'fi_allocinfo
    {-case a of
        [] -> do
            withCString "xlibfabric" $ \ptrx -> msg 1 [ptrx]
        (addr:_) -> withCString "xlibfabric" $ \ptrx -> withCString addr $ \ptra -> msg 1 [ptrx,ptra]
    -}
    print a
    print b
