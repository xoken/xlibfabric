module Main where

import Lib
import XLibfabric.RDMA.FiErrorNo

main :: IO ()
main = return fiE2Big >>= print