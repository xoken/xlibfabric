module Main where

import Foreign.Marshal.Array
import System.Environment
import XLibfabric.RDMA.Fabric

main :: IO ()
main = do
    hints <- c'fi_allocinfo
    a <- getArgs
    print hints
    print a
