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
    g <- alloca $ \fi_pep' -> do
                    alloca $ \hints' ->
                        alloca $ \fab' ->
                            alloca $ \eq_attr' ->
                                alloca $ \eq' ->
                                    alloca $ \pep' -> do
                                        poke eq_attr' (Eq.C'fi_eq_attr 0 0 1 0 nullPtr)
                                        return $ GlobalData fi_pep' hints' fab' eq_attr' eq' pep' False
    c <- start_server g
    print c
{-
data GlobalData = GlobalData {
        fi_pep :: Ptr (Ptr C'fi_info)
       --,fi :: Ptr C'fi_info
       ,hints :: Ptr C'fi_info
       ,fab :: Ptr (Ptr C'fid_fabric)
       ,eq_attr :: (Ptr Eq.C'fi_eq_attr)
       ,eq :: Ptr (Ptr C'fid_eq)
       ,pep :: Ptr (Ptr C'fid_pep)
       ,hmem_initialized :: Bool
    }


ctx_cnt :: Int
ctx_cnt = 2

closev_fid :: [Ptr C'fid_ep] -> IO ()
closev_fid = mapM_ close_fid

close_fid :: Ptr C'fid_ep -> IO ()
close_fid fep = do
    ret <- c'fi_close $ p'fid_ep'fid fep
    print ret

start_server :: GlobalData -> IO CInt
start_server GlobalData {..} = fabinit `retNonZero` init_oob
                                `retNonZero` (getinfo hints fi_pep)
                                `retNonZero` (peek fi_pep >>= \pp -> peek pp >>= \p -> c'fi_fabric (c'fi_info'fabric_attr p) fab nullPtr)
                                `retNonZero` (peek fab >>= \f -> c'fi_eq_open f eq_attr eq nullPtr)
                                `retNonZero` (peek fab >>= \f -> peek fi_pep >>= \vp -> c'fi_passive_ep f vp pep nullPtr)
                                `retNonZero` (peek pep >>= \pp -> peek eq >>= \e -> c'fi_pep_bind pp (p'fid_eq'fid e) 0)
                                `retNonZero` (peek pep >>= \pp -> c'fi_listen pp)

retNonZero :: (Num a, Eq a) => IO a -> IO a -> IO a
retNonZero a b = do
    a' <- a
    if a' == 0 
        then b
    else
        return a'
-}