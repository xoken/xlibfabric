{-# LANGUAGE ForeignFunctionInterface #-}

module Msg where

import Foreign.C.Types
import Foreign.C.String
import Foreign.Marshal.Array
import Foreign.Marshal.Alloc
import Foreign.Ptr

foreign import ccall "msg.c msg"
    run_msg :: CInt -> Ptr CString -> IO CInt

msg :: CInt -> [CString] -> IO Int
msg c v = alloca $ \ptr -> do
                pokeArray ptr v
                fmap fromIntegral $ run_msg c ptr