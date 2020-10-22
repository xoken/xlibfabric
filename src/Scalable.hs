{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Scalable where

import Data.Bits
import Foreign (Storable(..))
import Foreign.C.String
import Foreign.C.Types
import Foreign.CStorable (CStorable(..))
import Foreign.Marshal.Alloc
import Foreign.Marshal.Array
import Foreign.Marshal.Utils
import Foreign.Ptr
import Foreign.Storable
import GHC.Generics (Generic(..))
import System.Environment
import XLibfabric.RDMA.Fabric hiding
    ( C'fid_av
    , C'fid_cntr
    , C'fid_cq
    , C'fid_domain
    , C'fid_ep
    , C'fid_eq
    , C'fid_pep
    , C'fid_wait
    )
import XLibfabric.RDMA.FiCm
import XLibfabric.RDMA.FiDomain as FD hiding (C', C'fi_cntr_attr)
import XLibfabric.RDMA.FiEndpoint
import XLibfabric.RDMA.FiEq as Eq

{- GLOBAL VARS
static int ctx_cnt = 2;
static int rx_ctx_bits = 0;
static struct fid_ep *sep;
static struct fid_ep **tx_ep, **rx_ep;
static struct fid_cq **txcq_array;
static struct fid_cq **rxcq_array;
static fi_addr_t *remote_rx_addr;
DATA 0x12345670
-}
data Env =
    Env
        { ctx_cnt :: CInt -- 2
        , rx_ctx_bits :: CInt -- 0
        , sep :: Ptr (Ptr C'fid_ep)
        , tx_ep :: Ptr (Ptr C'fid_ep)
        , rx_ep :: Ptr (Ptr C'fid_ep)
        , rxcq :: Ptr (Ptr C'fid_cq)
        , txcq :: Ptr (Ptr C'fid_cq)
        , txcq_array :: Ptr (Ptr C'fid_cq)
        , rxcq_array :: Ptr (Ptr C'fid_cq)
        , remote_rx_addr :: (Ptr C'fi_addr_t)
        , cq_attr :: Ptr C'fi_cq_attr
        , av_attr :: Ptr C'fi_av_attr
        , av :: Ptr C'fid_av
        , hints :: Ptr (Ptr C'fi_info)
        , fi :: Ptr (Ptr C'fi_info)
        , domain :: Ptr (Ptr FD.C'fid_domain)
        , buf :: Ptr CChar
        , tx_buf :: Ptr ()
        , rx_buf :: Ptr ()
        , mr_desc :: Ptr ()
        , remote_fi_addr :: Ptr CULong
        , rx_size :: CSize
        , tx_size :: CSize
        , fab :: Ptr (Ptr C'fid_fabric)
        , eq_attr :: (Ptr Eq.C'fi_eq_attr)
        , eq :: Ptr (Ptr C'fid_eq)
        , opts :: Ptr C'ft_opts
        , node :: Ptr (CString)
        , service :: Ptr (CString)
        , flags :: Ptr CULong
        , cntr_attr :: Ptr C'fi_cntr_attr
        , rxcntr :: Ptr (Ptr C'fid_cntr)
        , txcntr :: Ptr (Ptr C'fid_cntr)
        , waitset :: Ptr C'fid_wait
        }

-- C'ft_opts
data C'ft_opts =
    C'ft_opts
        { c'ft_opts'iterations :: CInt
        , c'ft_opts'warmup_iterations :: CInt
        , c'ft_opts'transfer_size :: CSize
        , c'ft_opts'window_size :: CInt
        , c'ft_opts'av_size :: CInt
        , c'ft_opts'verbose :: CInt
        , c'ft_opts'tx_cq_size :: CInt
        , c'ft_opts'rx_cq_size :: CInt
        , c'ft_opts'src_port :: Ptr CChar
        , c'ft_opts'dst_port :: Ptr CChar
        , c'ft_opts'src_addr :: Ptr CChar
        , c'ft_opts'dst_addr :: Ptr CChar
        , c'ft_opts'av_name :: Ptr CChar
        , c'ft_opts'sizes_enabled :: CInt
        , c'ft_opts'options :: CInt
        , c'ft_opts'comp_method :: CUInt
        , c'ft_opts'machr :: CInt
        , c'ft_opts'rma_op :: CUInt
        , c'ft_opts'oob_port :: Ptr CChar
        , c'ft_opts'argc :: CInt
        , c'ft_opts'num_connections :: CInt
        , c'ft_opts'address_format :: CInt
        , c'ft_opts'mr_mode :: CULong
        , c'ft_opts'force_prefix :: CInt
        , c'ft_opts'iface :: CUInt
        , c'ft_opts'device :: CULong
        , c'ft_opts'argv :: Ptr (Ptr CChar)
        }
    deriving (Eq, Show, Generic, CStorable)

instance Storable C'ft_opts where
    peek = cPeek
    poke = cPoke
    alignment = cAlignment
    sizeOf = cSizeOf

init_opts =
    C'ft_opts
        1000
        10
        1024
        64
        1
        0
        0
        0
        nullPtr
        nullPtr
        nullPtr
        nullPtr
        nullPtr
        1
        ((1 `shiftL` 3) .|. (1 `shiftL` 4))
        0
        0
        2
        nullPtr
        0
        2
        0
        ((1 `shiftL` 2) .|. (1 `shiftL` 4) .|. (1 `shiftL` 5) .|. (1 `shiftL` 6))
        0
        0
        0
        nullPtr

{-
defEnv = do
    alloca $ \e'sep -> allocaArray 2 $ \e'tx_ep -> allocaArray 2 $ \e'rx_ep -> allocaArray 2 $ \e'txcq_array ->
        allocaArray 2 $ \e'rxcq_array -> alloca $ \e'remote_rx_addr -> alloca $ \e'av_attr -> alloca $ \e'av ->
            alloca $ \e'hints -> alloca $ \e'fi -> alloca $ \e'domain ->
                alloca $ \e'buf -> alloca $ \e'tx_buf -> alloca $ \e'rx_buf -> alloca $ \e'mr_desc ->
                    let env = Env 2
                                0
                                e'sep
                                e'tx_ep
                                e'rx_ep
                                e'txcq_array
                                e'rxcq_array
                                e'remote_rx_addr
                                e'av_attr
                                e'av
                                e'hints
                                e'fi
                                e'domain
                                e'buf
                                e'tx_buf
                                e'rx_buf
                                e'mr_desc
                    return env-}
datum = 0x12345670

closev_fid_ep :: Ptr C'fid_ep -> Int -> IO ()
closev_fid_ep p n = do
    print $ "closev_fid_ep called"
    mapM_ (\i -> close_fid (p'fid_ep'fid $ advancePtr p i)) [0 .. (n - 1)]

close_fid :: Ptr C'fid -> IO ()
close_fid fid = do
    print $ "close_fid called"
    ret <- c'fi_close $ fid
    print ret

closev_fid_cq :: Ptr C'fid_cq -> Int -> IO ()
closev_fid_cq p n = do
    print $ "closev_fid_cq called"
    mapM_ (\i -> close_fid (p'fid_cq'fid $ advancePtr p i)) [0 .. (n - 1)]

free_res :: Env -> IO ()
free_res Env {..} = do
    print $ "free_res called"
    peek rx_ep >>= \r -> closev_fid_ep r $ fromIntegral ctx_cnt
    peek tx_ep >>= \t -> closev_fid_ep t $ fromIntegral ctx_cnt
    peek rxcq_array >>= \r -> closev_fid_cq r $ fromIntegral ctx_cnt
    peek txcq_array >>= \t -> closev_fid_cq t $ fromIntegral ctx_cnt

{- free_res
static void free_res(void)
{
    if (rx_ep) {
        FT_CLOSEV_FID(rx_ep, ctx_cnt);
        free(rx_ep);
        rx_ep = NULL;
    }
    if (tx_ep) {
        FT_CLOSEV_FID(tx_ep, ctx_cnt);
        free(tx_ep);
        tx_ep = NULL;
    }
    if (rxcq_array) {
        FT_CLOSEV_FID(rxcq_array, ctx_cnt);
        free(rxcq_array);
        rxcq_array = NULL;
    }
    if (txcq_array) {
        FT_CLOSEV_FID(txcq_array, ctx_cnt);
        free(txcq_array);
        txcq_array = NULL;
    }
}
-}
--alloc_ep_res :: Env -> IO CInt
alloc_ep_res (env@Env {..}) = do
    print $ "alloc_ep_res called"
    poke (p'fi_av_attr'rx_ctx_bits av_attr) $ ctxShiftR (ctx_cnt, rx_ctx_bits)
    ret <- ft_alloc_ep_res env
    if ret == 0
            --txcq_array = calloc(ctx_cnt, sizeof *txcq_array);
            --rxcq_array = calloc(ctx_cnt, sizeof *rxcq_array);
            --tx_ep = calloc(ctx_cnt, sizeof *tx_ep);
            --rx_ep = calloc(ctx_cnt, sizeof *rx_ep);
            --remote_rx_addr = calloc(ctx_cnt, sizeof *remote_rx_addr);
        then do
            s <- peek sep
            mapM_
                (\i -> do
                     d <- peek domain
                     (c'fi_tx_context s i nullPtr (advancePtr tx_ep $ fromIntegral i) nullPtr)
                     (c'fi_cq_open d cq_attr (advancePtr txcq_array $ fromIntegral i) nullPtr)
                     (c'fi_rx_context s i nullPtr (advancePtr rx_ep $ fromIntegral i) nullPtr)
                     (c'fi_cq_open d cq_attr (advancePtr rxcq_array $ fromIntegral i) nullPtr))
                [0 .. (ctx_cnt - 1)] >>
                return 0
        else return ret

ctxShiftR :: (CInt, CInt) -> CInt
ctxShiftR (c, r)
    | shifted <= 0 = r + 1
    | otherwise = ctxShiftR (c, r + 1)
  where
    shifted = c `shiftR` (fromIntegral $ r)

{- alloc_ep_res
static int alloc_ep_res(struct fid_ep *sep)
{
    int i, ret;

    /* Get number of bits needed to represent ctx_cnt */
    while (ctx_cnt >> ++rx_ctx_bits);

    av_attr.rx_ctx_bits = rx_ctx_bits;

    ret = ft_alloc_ep_res(fi);
    if (ret)
        return ret;

    txcq_array = calloc(ctx_cnt, sizeof *txcq_array);
    rxcq_array = calloc(ctx_cnt, sizeof *rxcq_array);
    tx_ep = calloc(ctx_cnt, sizeof *tx_ep);
    rx_ep = calloc(ctx_cnt, sizeof *rx_ep);
    remote_rx_addr = calloc(ctx_cnt, sizeof *remote_rx_addr);

    if (!buf || !txcq_array || !rxcq_array || !tx_ep || !rx_ep || !remote_rx_addr) {
        perror("malloc");
        return -1;
    }

    for (i = 0; i < ctx_cnt; i++) {
        ret = fi_tx_context(sep, i, NULL, &tx_ep[i], NULL);
        if (ret) {
            FT_PRINTERR("fi_tx_context", ret);
            return ret;
        }

        ret = fi_cq_open(domain, &cq_attr, &txcq_array[i], NULL);
        if (ret) {
            FT_PRINTERR("fi_cq_open", ret);
            return ret;
        }

        ret = fi_rx_context(sep, i, NULL, &rx_ep[i], NULL);
        if (ret) {
            FT_PRINTERR("fi_rx_context", ret);
            return ret;
        }

        ret = fi_cq_open(domain, &cq_attr, &rxcq_array[i], NULL);
        if (ret) {
            FT_PRINTERR("fi_cq_open", ret);
            return ret;
        }
    }

    return 0;
}
-}
bind_ep_res (env@(Env {..})) = do
    print $ "bind_ep_res called"
    s <- peek sep
    (c'fi_scalable_ep_bind s (p'fid_av'fid av) 0) |->
        (mapM_
             (\i ->
                  peek tx_ep >>= \t ->
                      peek txcq_array >>= \tcq ->
                          (c'fi_ep_bind (advancePtr t i) (p'fid_cq'fid $ advancePtr tcq i) 2048) |->
                          (c'fi_enable (advancePtr t i)))
             [0 .. (fromIntegral $ ctx_cnt - 1)] >>
         return 0) |->
        (mapM_
             (\i ->
                  peek rx_ep >>= \r ->
                      peek rxcq_array >>= \rcq ->
                          (c'fi_ep_bind (advancePtr r i) (p'fid_cq'fid $ advancePtr rcq i) 1024) |->
                          (c'fi_enable (advancePtr r i)) |->
                          (c'fi_recv (advancePtr r i) rx_buf (fromIntegral $ max rx_size 256) mr_desc 0 nullPtr))
             [0 .. (fromIntegral $ ctx_cnt - 1)] >>
         return 0) |->
        (c'fi_enable s)
    return 0

{- bind_ep_res
static int bind_ep_res(void)
{
    int i, ret;

    ret = fi_scalable_ep_bind(sep, &av->fid, 0);
    if (ret) {
        FT_PRINTERR("fi_scalable_ep_bind", ret);
        return ret;
    }

    for (i = 0; i < ctx_cnt; i++) {
        ret = fi_ep_bind(tx_ep[i], &txcq_array[i]->fid, FI_SEND);
        if (ret) {
            FT_PRINTERR("fi_ep_bind", ret);
            return ret;
        }

        ret = fi_enable(tx_ep[i]);
        if (ret) {
            FT_PRINTERR("fi_enable", ret);
            return ret;
        }
    }

    for (i = 0; i < ctx_cnt; i++) {
        ret = fi_ep_bind(rx_ep[i], &rxcq_array[i]->fid, FI_RECV);
        if (ret) {
            FT_PRINTERR("fi_ep_bind", ret);
            return ret;
        }

        ret = fi_enable(rx_ep[i]);
        if (ret) {
            FT_PRINTERR("fi_enable", ret);
            return ret;
        }

        ret = fi_recv(rx_ep[i], rx_buf, MAX(rx_size, FT_MAX_CTRL_MSG),
                  mr_desc, 0, NULL);
        if (ret) {
            FT_PRINTERR("fi_recv", ret);
            return ret;
        }
    }

    ret = fi_enable(sep);
    if (ret) {
        FT_PRINTERR("fi_enable", ret);
        return ret;
    }

    return 0;
}
-}
wait_for_comp (env@Env {..}) cq = do
    print $ "wait_fro_comp called"
    alloca $ \comp -> do
        ret <- doWhile (fmap (\x -> (x, -11)) (c'fi_cq_read cq comp 1)) (\(x, ret) -> x < 0 && ret == -11)
        if ret /= 1
            then do
                print $ "fi_cq_read: " <> show ret
                return ret
            else return 0

doWhile a f = do
    a' <- a
    if f a'
        then doWhile a f
        else return $ fst a'

{- wait_for_comp
static int wait_for_comp(struct fid_cq *cq)
{
    struct fi_cq_entry comp;
    int ret;

    do {
        ret = fi_cq_read(cq, &comp, 1);
    } while (ret < 0 && ret == -FI_EAGAIN);

    if (ret != 1)
        FT_PRINTERR("fi_cq_read", ret);
    else
        ret = 0;

    return ret;
}
-}
run_test (env@Env {..}) = do
    print $ "run_test called"
    let ret = 0
        tb = castPtr tx_buf
        rb = castPtr rx_buf
    da <- peek opts
    if c'ft_opts'dst_addr da /= nullPtr -- (opts.dst_addr)
        then do
            run_test_send tb env 0 0
        else do
            run_test_recv rb env 0 0

run_test_send _ (env@Env {..}) 2 ret = return $ fromIntegral ret
run_test_send _ (env@Env {..}) i 0 = return 0
run_test_send tb (env@Env {..}) i _ = do
    print $ "Posting send for ctx: " ++ show i
    poke tb (datum + i)
    t <- peek tx_ep
    tcq <- peek txcq_array
    rra <- peek $ advancePtr remote_rx_addr i
    (c'fi_send (advancePtr t i) tx_buf tx_size mr_desc rra nullPtr) |->
        (wait_for_comp env (advancePtr tcq i) >>= \r -> run_test_send tb env (i + 1) r)

run_test_recv _ _ 0 ret = return ret
run_test_recv _ _ _ 0 = return 0
run_test_recv rb (env@Env {..}) i _ = do
    print $ "wait for recv completion for ctx: " ++ show i
    rcq <- peek rxcq_array
    wait_for_comp env (advancePtr rcq i)
    peek rb >>= \r -> run_test_recv rb env (i + 1) r

{- run_test
static int run_test()
{
    int ret = 0, i;
    uint32_t data;
    uint32_t *tb = (uint32_t *)tx_buf;
    uint32_t *rb = (uint32_t *)rx_buf;

    if (opts.dst_addr) {
        for (i = 0; i < ctx_cnt && !ret; i++) {
            fprintf(stdout, "Posting send for ctx: %d\n", i);
            tb[0] = DATA + i;
            ret = fi_send(tx_ep[i], tx_buf, tx_size, mr_desc,
                      remote_rx_addr[i], NULL);
            if (ret) {
                FT_PRINTERR("fi_send", ret);
                return ret;
            }

            ret = wait_for_comp(txcq_array[i]);
        }
    } else {
        for (i = 0; i < ctx_cnt && !ret; i++) {
            fprintf(stdout, "wait for recv completion for ctx: %d\n", i);
            ret = wait_for_comp(rxcq_array[i]);

            data = DATA + i;
            if (memcmp(&data, rx_buf, 4) != 0) {
                fprintf(stdout, "failed compare expected 0x%x,"
                    " read 0x%x\n", data, rb[0]);
            }
        }
    }

    return ret;
}
-}
--init_fabric :: Env -> IO CInt
init_fabric (env@Env {..}) = do
    print $ "init_fabric called"
    ret <- ft_getinfo env
    if ret == 0
        then do
            print $ "ft_getinfo return 0"
            fi' <- peek fi
            fi'' <- peek fi'
            let domain_attr = c'fi_info'domain_attr fi''
            da <- peek domain_attr
            let ctxcnt =
                    minimum [fromIntegral $ ctx_cnt, c'fi_domain_attr'tx_ctx_cnt da, c'fi_domain_attr'rx_ctx_cnt da]
            if ctxcnt <= 0
                then do
                    print "Provider doesn't support contexts"
                    return 1
                else do
                    let ep_attr_ptr = c'fi_info'ep_attr fi''
                    ep_attr <- peek ep_attr_ptr
                    poke ep_attr_ptr $ ep_attr {c'fi_ep_attr'tx_ctx_cnt = ctxcnt, c'fi_ep_attr'rx_ctx_cnt = ctxcnt}
                    d <- peek domain
                    ft_open_fabric_res env |-> (print "c'fi_scalable_ep called" >> c'fi_scalable_ep d fi' sep nullPtr) |->
                        (alloc_ep_res env) |->
                        (bind_ep_res env)
        else return ret

{- init_fabric
static int init_fabric(void)
{
    int ret;
    ret = ft_getinfo(hints, &fi);
    if (ret)
        return ret;

    /* Check the optimal number of TX and RX contexts supported by the provider */
    ctx_cnt = MIN(ctx_cnt, fi->domain_attr->tx_ctx_cnt);
    ctx_cnt = MIN(ctx_cnt, fi->domain_attr->rx_ctx_cnt);
    if (!ctx_cnt) {
        fprintf(stderr, "Provider doesn't support contexts\n");
        return 1;
    }

    fi->ep_attr->tx_ctx_cnt = ctx_cnt;
    fi->ep_attr->rx_ctx_cnt = ctx_cnt;

    ret = ft_open_fabric_res();
    if (ret)
        return ret;

    ret = fi_scalable_ep(domain, fi, &sep, NULL);
    if (ret) {
        FT_PRINTERR("fi_scalable_ep", ret);
        return ret;
    }

    ret = alloc_ep_res(sep);
    if (ret)
        return ret;

    ret = bind_ep_res();
    return ret;
}
-}
init_av (env@Env {..}) = do
    print $ "init_av called"
    da <- peek opts
    if c'ft_opts'dst_addr da /= nullPtr
        then init_av_a env
        else init_av_b env
    r <- peek rx_ep
    tcq <- peek txcq_array
    rfa <- peek remote_fi_addr
    (mapM_ (\x -> c'fi_rx_addr rfa x rx_ctx_bits) [0 .. (ctx_cnt - 1)] >> c'fi_recv r rx_buf rx_size mr_desc 0 nullPtr) |->
        (wait_for_comp env tcq)

init_av_a (env@Env {..}) = do
    alloca $ \addrlen -> do
        t <- peek tx_ep
        poke addrlen 256
        s <- peek sep
        fi' <- peek fi
        fi'' <- peek fi'
        rcq <- peek rxcq_array
        rfa <- peek remote_fi_addr
        (ft_av_insert av (c'fi_info'dest_addr fi'') 1 remote_fi_addr 0 nullPtr) |->
            (c'fi_getname (p'fid_ep'fid s) tx_buf addrlen) |->
            (peek addrlen >>= \al -> c'fi_send t tx_buf al mr_desc rfa nullPtr) |->
            (wait_for_comp env rcq)

init_av_b (env@Env {..}) = do
    t <- peek tx_ep
    rcq <- peek rxcq_array
    rfa <- peek remote_fi_addr
    ((wait_for_comp env rcq) |-> (ft_av_insert av rx_buf 1 remote_fi_addr 0 nullPtr)) |->
        (c'fi_send t tx_buf 1 mr_desc rfa nullPtr)

{- init_av
static int init_av(void)
{
    size_t addrlen;
    int ret, i;

    if (opts.dst_addr) {
        ret = ft_av_insert(av, fi->dest_addr, 1, &remote_fi_addr, 0, NULL);
        if (ret)
            return ret;

        addrlen = FT_MAX_CTRL_MSG;
        ret = fi_getname(&sep->fid, tx_buf, &addrlen);
        if (ret) {
            FT_PRINTERR("fi_getname", ret);
            return ret;
        }

        ret = fi_send(tx_ep[0], tx_buf, addrlen,
                  mr_desc, remote_fi_addr, NULL);
        if (ret) {
            FT_PRINTERR("fi_send", ret);
            return ret;
        }

        ret = wait_for_comp(rxcq_array[0]);
        if (ret)
            return ret;
    } else {
        ret = wait_for_comp(rxcq_array[0]);
        if (ret)
            return ret;

        ret = ft_av_insert(av, rx_buf, 1, &remote_fi_addr, 0, NULL);
        if (ret)
            return ret;

        ret = fi_send(tx_ep[0], tx_buf, 1,
                  mr_desc, remote_fi_addr, NULL);
        if (ret) {
            FT_PRINTERR("fi_send", ret);
            return ret;
        }
    }

    for (i = 0; i < ctx_cnt; i++)
        remote_rx_addr[i] = fi_rx_addr(remote_fi_addr, i, rx_ctx_bits);

    ret = fi_recv(rx_ep[0], rx_buf, rx_size, mr_desc, 0, NULL);
    if (ret) {
        FT_PRINTERR("fi_recv", ret);
        return ret;
    }

    ret = wait_for_comp(txcq_array[0]);
    return ret;
}
-}
run :: Env -> IO CLong
run env = do
    print $ "run called"
    (init_fabric env) |-> (init_av env) |-> (run_test env)

{- run
static int run(void)
{
    int ret = 0;

    ret = init_fabric();
    if (ret)
        return ret;

    ret = init_av();
    if (ret)
        return ret;

    ret = run_test();

    /*TODO: Add a local finalize applicable for scalable ep */
    //ft_finalize(fi, tx_ep[0], txcq_array[0], rxcq_array[0], remote_rx_addr[0]);

    return ret;
}
-}
scalable :: IO ()
scalable = do
    print $ "scalable called"
    alloca $ \e'sep ->
        allocaArray 2 $ \e'tx_ep ->
            allocaArray 2 $ \e'rx_ep ->
                alloca $ \e'rxcq ->
                    alloca $ \e'txcq ->
                        allocaArray 2 $ \e'txcq_array ->
                            allocaArray 2 $ \e'rxcq_array ->
                                alloca $ \e'remote_rx_addr ->
                                    alloca $ \e'cq_attr ->
                                        alloca $ \e'av_attr ->
                                            alloca $ \e'av ->
                                                alloca $ \e'hints ->
                                                    alloca $ \e'fi ->
                                                        alloca $ \e'domain ->
                                                            alloca $ \e'buf ->
                                                                alloca $ \e'tx_buf ->
                                                                    alloca $ \e'rx_buf ->
                                                                        alloca $ \e'mr_desc ->
                                                                            alloca $ \e'remote_fi_addr ->
                                                                                alloca $ \e'fab ->
                                                                                    alloca $ \e'eq_attr ->
                                                                                        alloca $ \e'eq ->
                                                                                            alloca $ \e'opts ->
                                                                                                alloca $ \e'node ->
                                                                                                    alloca $ \e'service ->
                                                                                                        alloca $ \e'flags ->
                                                                                                            alloca $ \e'cntr_attr ->
                                                                                                                alloca $ \e'rxcntr ->
                                                                                                                    alloca $ \e'txcntr ->
                                                                                                                        alloca $ \e'waitset -> do
                                                                                                                            poke
                                                                                                                                e'eq_attr
                                                                                                                                (Eq.C'fi_eq_attr
                                                                                                                                     0
                                                                                                                                     0
                                                                                                                                     1
                                                                                                                                     0
                                                                                                                                     nullPtr)
                                                                                                                            h <-
                                                                                                                                c'fi_allocinfo
                                                                                                                            if h ==
                                                                                                                               nullPtr
                                                                                                                                then print
                                                                                                                                         "EXIT FAILURE"
                                                                                                                                else do
                                                                                                                                    poke
                                                                                                                                        e'hints
                                                                                                                                        h
                                                                                                                                    poke
                                                                                                                                        e'opts
                                                                                                                                        init_opts
                                                                                                                                    let env =
                                                                                                                                            Env
                                                                                                                                                2
                                                                                                                                                0
                                                                                                                                                e'sep
                                                                                                                                                e'tx_ep
                                                                                                                                                e'rx_ep
                                                                                                                                                e'txcq
                                                                                                                                                e'rxcq
                                                                                                                                                e'txcq_array
                                                                                                                                                e'rxcq_array
                                                                                                                                                e'remote_rx_addr
                                                                                                                                                e'cq_attr
                                                                                                                                                e'av_attr
                                                                                                                                                e'av
                                                                                                                                                e'hints
                                                                                                                                                e'fi
                                                                                                                                                e'domain
                                                                                                                                                e'buf
                                                                                                                                                e'tx_buf
                                                                                                                                                e'rx_buf
                                                                                                                                                e'mr_desc
                                                                                                                                                e'remote_fi_addr
                                                                                                                                                256
                                                                                                                                                256
                                                                                                                                                e'fab
                                                                                                                                                e'eq_attr
                                                                                                                                                e'eq
                                                                                                                                                e'opts
                                                                                                                                                e'node
                                                                                                                                                e'service
                                                                                                                                                e'flags
                                                                                                                                                e'cntr_attr
                                                                                                                                                e'txcntr
                                                                                                                                                e'rxcntr
                                                                                                                                                e'waitset
                                                                                                                                    run
                                                                                                                                        env >>
                                                                                                                                        return
                                                                                                                                            ()

{- main
int main(int argc, char **argv)
{
    int ret, op;

    opts = INIT_OPTS;
    opts.options = FT_OPT_SIZE;

    hints = fi_allocinfo();
    if (!hints)
        return EXIT_FAILURE;

    while ((op = getopt(argc, argv, "h" ADDR_OPTS INFO_OPTS)) != -1) {
        switch (op) {
        default:
            ft_parse_addr_opts(op, optarg, &opts);
            ft_parseinfo(op, optarg, hints, &opts);
            break;
        case '?':
        case 'h':
            ft_usage(argv[0], "An RDM client-server example with scalable endpoints.\n");
            return EXIT_FAILURE;
        }
    }

    if (optind < argc)
        opts.dst_addr = argv[optind];

    hints->ep_attr->type = FI_EP_RDM;
    hints->caps = FI_MSG | FI_NAMED_RX_CTX;
    hints->domain_attr->mr_mode = opts.mr_mode;

    ret = run();

    free_res();
    /* Closes the scalable ep that was allocated in the test */
    FT_CLOSE_FID(sep);
    ft_free_res();
    return ft_exit_code(ret);
}
-}
-- Utils
(|->) :: (Integral a, Num b) => IO a -> IO b -> IO b
a |-> b = do
    print $ "|-> called"
    a' <- a
    case a' of
        0 -> return $ fromIntegral a'
        _ -> b

{-
retNonZero :: (Integral a, Eq a) => IO a -> IO b -> IO b
retNonZero a b = do
    a' <- a
    if a' == 0
        then b
        else return $ fromIntegral a'
        
(|->) = retNonZero
-}
ft_getinfo env@(Env {..}) = do
    poke flags 0
    ret <- ft_read_addr_opts env
    if ret /= 0
        then return ret
        else do
            h_ <- peek hints
            h <- peek h_
            let eap = c'fi_info'ep_attr $ h
            ea <- peek eap
            poke eap $ ea {c'fi_ep_attr'type = 3}
            let ty = c'fi_ep_attr'type ea
            h' <- peek h_
            o <- peek opts
            if ((c'ft_opts'options o) .&. ft_opt_enable_hmem) == 0
                then do
                    da <- peek $ c'fi_info'domain_attr h'
                    let caps = c'fi_info'caps h'
                        mr_mode = c'fi_domain_attr'mr_mode $ da
                    poke (c'fi_info'domain_attr h') (da {c'fi_domain_attr'mr_mode = mr_mode .|. 16})
                    let h'' = h' {c'fi_info'caps = caps .|. 0}
                    poke h_ h''
                    return 0
                else return 0
            h_ <- peek hints
            f_ <- peek flags
            n <- peek node
            s <- peek service
            c'fi_getinfo ft_fiversion n s f_ h_ fi
            return 0

{-
int ft_getinfo(struct fi_info *hints, struct fi_info **info)
{
	char *node, *service;
	uint64_t flags = 0;
	int ret;

	ret = ft_read_addr_opts(&node, &service, hints, &flags, &opts);
	if (ret)
		return ret;

	if (!hints->ep_attr->type)
		hints->ep_attr->type = FI_EP_RDM;

	if (opts.options & FT_OPT_ENABLE_HMEM) {
		hints->caps |= FI_HMEM;
		hints->domain_attr->mr_mode |= FI_MR_HMEM;
	}

	ret = fi_getinfo(FT_FIVERSION, node, service, flags, hints, info);
	if (ret) {
		FT_PRINTERR("fi_getinfo", ret);
		return ret;
	}

	if (!ft_check_prefix_forced(*info, &opts)) {
		FT_ERR("Provider disabled requested prefix mode.");
		return -FI_ENODATA;
	}

	return 0;
}
-}
ft_read_addr_opts env@(Env {..}) = do
    o <- peek opts
    if (c'ft_opts'dst_addr o) /= nullPtr && ((c'ft_opts'src_addr o /= nullPtr) || (c'ft_opts'oob_port o == nullPtr))
        then do
            if c'ft_opts'dst_port o == nullPtr
                then return 0 -- opts->dst_port = default_port -- will set this in init_opts
                else return 0
            ret <- getaddr env
            if ret == 0
                then do
                    poke node $ c'ft_opts'dst_addr o
                    poke service $ c'ft_opts'dst_port o
                    return 0
                else return 0
        else do
            if c'ft_opts'dst_port o == nullPtr
                then return 0 -- opts->src_port = default_port -- will set this in init_opts
                else return 0
            poke node $ c'ft_opts'src_addr o
            poke service $ c'ft_opts'src_port o
            return 0

{-
int ft_read_addr_opts(char **node, char **service, struct fi_info *hints,
		uint64_t *flags, struct ft_opts *opts)
{
	int ret;

	if (opts->dst_addr && (opts->src_addr || !opts->oob_port)){
		if (!opts->dst_port)
			opts->dst_port = default_port;

		ret = ft_getsrcaddr(opts->src_addr, opts->src_port, hints);
		if (ret)
			return ret;
		*node = opts->dst_addr;
		*service = opts->dst_port;
	} else {
		if (!opts->src_port)
			opts->src_port = default_port;

		*node = opts->src_addr;
		*service = opts->src_port;
		*flags = FI_SOURCE;
	}

	return 0;
}
-}
fi_source :: CULong
fi_source = 1 `shiftL` 57

ft_fiversion = (1 `shiftL` 16) .|. 9

ft_opt_enable_hmem = 1 `shiftL` 17

getaddr env@(Env {..}) = do
    alloca $ \fi_ -> do
        h <- peek hints
        h_ <- peek h
        fl_ <- peek flags
        s <- peek service
        n <- peek node
        if (node == nullPtr && service == nullPtr)
            then do
                if ((fl_ .|. fi_source) /= 0)
                    then do
                        poke h $ h_ {c'fi_info'src_addr = nullPtr, c'fi_info'src_addrlen = 0}
                    else do
                        poke h $ h_ {c'fi_info'dest_addr = nullPtr, c'fi_info'dest_addrlen = 0}
                return 0
            else do
                ret <- c'fi_getinfo ft_fiversion n s fl_ h fi_
                if ret /= 0
                    then do
                        print $ "fi_getinfo: " ++ show ret
                        return ret
                    else do
                        f_ <- peek fi_
                        f__ <- peek f_
                        poke h $ h_ {c'fi_info'addr_format = c'fi_info'addr_format f__}
                        fl_ <- peek flags
                        if ((fl_ .&. fi_source) /= 0)
                            then do
                                let srcaddrlenp = p'fi_info'src_addrlen h
                                poke srcaddrlenp (c'fi_info'src_addrlen f__)
                                srcaddr <- peek $ p'fi_info'src_addr h
                                moveBytes srcaddr (c'fi_info'src_addr f__) (fromIntegral $ c'fi_info'src_addrlen f__)
                                c'fi_freeinfo f_
                                return 0
                            else do
                                let destaddrlenp = p'fi_info'dest_addrlen h
                                poke destaddrlenp (c'fi_info'dest_addrlen f__)
                                destaddr <- peek $ p'fi_info'dest_addr h
                                moveBytes destaddr (c'fi_info'dest_addr f__) (fromIntegral $ c'fi_info'dest_addrlen f__)
                                c'fi_freeinfo f_
                                return 0

{-
static int dupaddr(void **dst_addr, size_t *dst_addrlen,
		void *src_addr, size_t src_addrlen)
{
	*dst_addr = malloc(src_addrlen);
	if (!*dst_addr) {
		FT_ERR("address allocation failed");
		return EAI_MEMORY;
	}
	*dst_addrlen = src_addrlen;
	memcpy(*dst_addr, src_addr, src_addrlen);
	return 0;
}


static int getaddr(char *node, char *service,
			struct fi_info *hints, uint64_t flags)
{
	int ret;
	struct fi_info *fi;

	if (!node && !service) {
		if (flags & FI_SOURCE) {
			hints->src_addr = NULL;
			hints->src_addrlen = 0;
		} else {
			hints->dest_addr = NULL;
			hints->dest_addrlen = 0;
		}
		return 0;
	}

	ret = fi_getinfo(FT_FIVERSION, node, service, flags, hints, &fi);
	if (ret) {
		FT_PRINTERR("fi_getinfo", ret);
		return ret;
	}
	hints->addr_format = fi->addr_format;

	if (flags & FI_SOURCE) {
		ret = dupaddr(&hints->src_addr, &hints->src_addrlen,
				fi->src_addr, fi->src_addrlen);
	} else {
		ret = dupaddr(&hints->dest_addr, &hints->dest_addrlen,
				fi->dest_addr, fi->dest_addrlen);
	}

	fi_freeinfo(fi);
	return ret;
}
-}
ft_av_insert a b c d e f = do
    ret <- c'fi_av_insert a b c d e f
    if ret < 0
        then do
            print $ "fi_av_insert error: " ++ show ret
            return ret
        else if ret /= (fromIntegral c)
                 then do
                     print $
                         "fi_av_insert: number of addresses inserted = " ++
                         show ret ++ "; number of addresses given = " ++ show c
                     return (-1)
                 else return 0

{-
int ft_av_insert(struct fid_av *av, void *addr, size_t count, fi_addr_t *fi_addr,
        uint64_t flags, void *context)
{
    int ret;

    ret = fi_av_insert(av, addr, count, fi_addr, flags, context);
    if (ret < 0) {
        FT_PRINTERR("fi_av_insert", ret);
        return ret;
    } else if (ret != count) {
        FT_ERR("fi_av_insert: number of addresses inserted = %d;"
                   " number of addresses given = %zd\n", ret, count);
        return -EXIT_FAILURE;
    }

    return 0;
}
-}
ft_open_fabric_res Env {..} = do
    print "ft_open_fabric_res called"
    fi' <- peek fi
    fi'' <- peek fi'
    fab' <- peek fab
    (c'fi_fabric (c'fi_info'fabric_attr fi'') fab nullPtr) |-> (c'fi_eq_open fab' eq_attr eq nullPtr) |->
        (c'fi_domain fab' fi' domain nullPtr)

{-
int ft_open_fabric_res(void)
{
    int ret;

    ret = fi_fabric(fi->fabric_attr, &fabric, NULL);
    if (ret) {
        FT_PRINTERR("fi_fabric", ret);
        return ret;
    }

    ret = fi_eq_open(fabric, &eq_attr, &eq, NULL);
    if (ret) {
        FT_PRINTERR("fi_eq_open", ret);
        return ret;
    }

    ret = fi_domain(fabric, fi, &domain, NULL);
    if (ret) {
        FT_PRINTERR("fi_domain", ret);
        return ret;
    }

    return 0;
}
-}
ft_alloc_ep_res env@(Env {..}) = do
    ft_alloc_msgs |->
        (do o <- peek opts
            d <- peek domain
            fi_ <- peek fi
            fi__ <- peek fi_
            let fmt_ = p'fi_cq_attr'format cq_attr
            fmt_v <- peek fmt_
            txattr <- peek $ p'fi_info'tx_attr fi_
            rxattr <- peek $ p'fi_info'rx_attr fi_
            if fmt_v == 0
                then do
                    if c'fi_info'caps fi__ .&. (1 `shiftL` 3) /= 0
                        then poke fmt_ 4
                        else poke fmt_ 1
                    return 0
                else do
                    return 0
            ft_cq_set_wait_attr env
            let s_ = p'fi_cq_attr'size cq_attr
                tasp = p'fi_tx_attr'size txattr
                rasp = p'fi_rx_attr'size rxattr
            tasv <- peek tasp
            rasv <- peek rasp
            if c'ft_opts'tx_cq_size o /= 0
                then poke s_ (fromIntegral $ c'ft_opts'tx_cq_size o)
                else poke s_ tasv
            if (c'ft_opts'options o) .&. (1 `shiftL` 10) /= 0
                then do
                    s' <- peek s_
                    if c'ft_opts'rx_cq_size o /= 0
                        then poke s_ (s' + (fromIntegral $ c'ft_opts'rx_cq_size o))
                        else poke s_ $ s' + rasv
                    return 0
                else return 0
            ret <- c'fi_cq_open d cq_attr txcq $ castPtr txcq
            if ret /= 0
                then do
                    print $ "fi_cq_open: " ++ show ret
                    return ret
                else return 0
            if (c'ft_opts'options o) .&. (1 `shiftL` 10) /= 0
                then do
                    txcq_ <- peek txcq
                    poke rxcq txcq_
                    return 0
                else return 0
            if (c'ft_opts'options o) .&. (1 `shiftL` 6) /= 0
                then do
                    ret' <- ft_cntr_open env txcntr
                    if ret' /= 0
                        then do
                            print $ "fi_cntr_open: " ++ show ret'
                            return ret'
                        else return 0
                else return 0
            if (c'ft_opts'options o) .&. (1 `shiftL` 10) == 0
                then do
                    ft_cq_set_wait_attr env
                    let tasp = p'fi_tx_attr'size txattr
                        asp = p'fi_rx_attr'size rxattr
                    tasv <- peek tasp
                    asv <- peek rasp
                    if c'ft_opts'tx_cq_size o /= 0
                        then poke s_ (fromIntegral $ c'ft_opts'rx_cq_size o)
                        else poke s_ asv
                    ret <- c'fi_cq_open d cq_attr rxcq $ castPtr rxcq
                    if ret /= 0
                        then do
                            print $ "fi_cq_open: " ++ show ret
                            return ret
                        else return 0
                else return 0
            if (c'ft_opts'options o) .&. (1 `shiftL` 5) /= 0
                then do
                    ret'' <- ft_cntr_open env rxcntr
                    if ret'' /= 0
                        then do
                            print $ "fi_cntr_open: " ++ show ret''
                            return ret''
                        else return 0
                else return 0
            fi_ <- peek fi
            ep_ <- peek $ p'fi_info'ep_attr fi_
            let typ = p'fi_ep_attr'type $ ep_
            ty <- peek typ
            if ty `elem` [c'FI_EP_DGRAM, c'FI_EP_RDM]
                then do
                    return 0
                else do
                    return 0)

{-
int ft_alloc_ep_res(struct fi_info *fi)
{
	int ret;

	ret = ft_alloc_msgs();
	if (ret)
		return ret;

	if (cq_attr.format == FI_CQ_FORMAT_UNSPEC) {
		if (fi->caps & FI_TAGGED)
			cq_attr.format = FI_CQ_FORMAT_TAGGED;
		else
			cq_attr.format = FI_CQ_FORMAT_CONTEXT;
	}

	if (opts.options & FT_OPT_CQ_SHARED) {
		ft_cq_set_wait_attr();
		cq_attr.size = 0;

		if (opts.tx_cq_size)
			cq_attr.size += opts.tx_cq_size;
		else
			cq_attr.size += fi->tx_attr->size;

		if (opts.rx_cq_size)
			cq_attr.size += opts.rx_cq_size;
		else
			cq_attr.size += fi->rx_attr->size;

		ret = fi_cq_open(domain, &cq_attr, &txcq, &txcq);
		if (ret) {
			FT_PRINTERR("fi_cq_open", ret);
			return ret;
		}
		rxcq = txcq;
	}

	if (!(opts.options & FT_OPT_CQ_SHARED)) {
		ft_cq_set_wait_attr();
		if (opts.tx_cq_size)
			cq_attr.size = opts.tx_cq_size;
		else
			cq_attr.size = fi->tx_attr->size;

		ret = fi_cq_open(domain, &cq_attr, &txcq, &txcq);
		if (ret) {
			FT_PRINTERR("fi_cq_open", ret);
			return ret;
		}
	}
=============================================
	if (opts.options & FT_OPT_TX_CNTR) {
		ret = ft_cntr_open(&txcntr);
		if (ret) {
			FT_PRINTERR("fi_cntr_open", ret);
			return ret;
		}
	}

	if (!(opts.options & FT_OPT_CQ_SHARED)) {
		ft_cq_set_wait_attr();
		if (opts.rx_cq_size)
			cq_attr.size = opts.rx_cq_size;
		else
			cq_attr.size = fi->rx_attr->size;

		ret = fi_cq_open(domain, &cq_attr, &rxcq, &rxcq);
		if (ret) {
			FT_PRINTERR("fi_cq_open", ret);
			return ret;
		}
	}

	if (opts.options & FT_OPT_RX_CNTR) {
		ret = ft_cntr_open(&rxcntr);
		if (ret) {
			FT_PRINTERR("fi_cntr_open", ret);
			return ret;
		}
	}

	if (fi->ep_attr->type == FI_EP_RDM || fi->ep_attr->type == FI_EP_DGRAM) {
		if (fi->domain_attr->av_type != FI_AV_UNSPEC)
			av_attr.type = fi->domain_attr->av_type;

		if (opts.av_name) {
			av_attr.name = opts.av_name;
		}
		av_attr.count = opts.av_size;
		ret = fi_av_open(domain, &av_attr, &av, NULL);
		if (ret) {
			FT_PRINTERR("fi_av_open", ret);
			return ret;
		}
	}
	return 0;
}
-}
ft_cntr_open env@(Env {..}) cntr = do
    ft_cntr_set_wait_attr env
    d <- peek domain
    c'fi_cntr_open d cntr_attr cntr $ castPtr cntr

{-
int ft_cntr_open(struct fid_cntr **cntr)
{
	ft_cntr_set_wait_attr();
	return fi_cntr_open(domain, &cntr_attr, cntr, cntr);
}
-}
ft_cq_set_wait_attr Env {..} = do
    o <- peek opts
    let obj = p'fi_cq_attr'wait_obj cq_attr
        cond = p'fi_cq_attr'wait_cond cq_attr
        set = p'fi_cq_attr'wait_set cq_attr
    case c'ft_opts'comp_method o of
        1 -> do
            poke obj 1 -- FI_WAIT_UNSPEC
            poke cond 1 -- FI_CQ_COND_NONE
        2 -> do
            poke obj 2 -- FI_WAIT_SET
            poke cond 1 -- FI_CQ_COND_NONE
            poke set waitset -- waitset
        3 -> do
            poke obj 3 -- FI_WAIT_FD
            poke cond 1 -- FI_CQ_COND_NONE
        4 -> do
            poke obj 5 -- FI_WAIT_YIELD
            poke cond 1 -- FI_CQ_COND_NONE
        otherwise -> do
            poke obj 0 -- FI_WAIT_NONE

{-
static void ft_cq_set_wait_attr(void)
{
	switch (opts.comp_method) {
	case FT_COMP_SREAD:
		cq_attr.wait_obj = FI_WAIT_UNSPEC;
		cq_attr.wait_cond = FI_CQ_COND_NONE;
		break;
	case FT_COMP_WAITSET:
		assert(waitset);
		cq_attr.wait_obj = FI_WAIT_SET;
		cq_attr.wait_cond = FI_CQ_COND_NONE;
		cq_attr.wait_set = waitset;
		break;
	case FT_COMP_WAIT_FD:
		cq_attr.wait_obj = FI_WAIT_FD;
		cq_attr.wait_cond = FI_CQ_COND_NONE;
		break;
	case FT_COMP_YIELD:
		cq_attr.wait_obj = FI_WAIT_YIELD;
		cq_attr.wait_cond = FI_CQ_COND_NONE;
		break;
	default:
		cq_attr.wait_obj = FI_WAIT_NONE;
		break;
	}
}
-}
ft_cntr_set_wait_attr Env {..} = do
    o <- peek opts
    let obj = p'fi_cq_attr'wait_obj cq_attr
    case c'ft_opts'comp_method o of
        1 -> do
            poke obj 1 -- FI_WAIT_UNSPEC
        2 -> do
            poke obj 2 -- FI_WAIT_SET
        3 -> do
            poke obj 3 -- FI_WAIT_FD
        4 -> do
            poke obj 5 -- FI_WAIT_YIELD
        otherwise -> do
            poke obj 0 -- FI_WAIT_NONE

{-
static void ft_cntr_set_wait_attr(void)
{
	switch (opts.comp_method) {
	case FT_COMP_SREAD:
		cntr_attr.wait_obj = FI_WAIT_UNSPEC;
		break;
	case FT_COMP_WAITSET:
		assert(waitset);
		cntr_attr.wait_obj = FI_WAIT_SET;
		break;
	case FT_COMP_WAIT_FD:
		cntr_attr.wait_obj = FI_WAIT_FD;
		break;
	case FT_COMP_YIELD:
		cntr_attr.wait_obj = FI_WAIT_YIELD;
		break;
	default:
		cntr_attr.wait_obj = FI_WAIT_NONE;
		break;
	}
}
-}
ft_alloc_msgs = return 0{-
ft_alloc_msgs env@(Env {..}) = do
    let alignment = 1
    if ft_check_opts env (1 `shiftL` 12)
        then return 0
        else do
            return 0


static int ft_alloc_msgs(void)
{
	int ret;
	long alignment = 1;

	if (ft_check_opts(FT_OPT_SKIP_MSG_ALLOC))
		return 0;

	if (opts.options & FT_OPT_ALLOC_MULT_MR) {
		ft_set_tx_rx_sizes(&tx_mr_size, &rx_mr_size);
		rx_size = FT_MAX_CTRL_MSG + ft_rx_prefix_size();
		tx_size = FT_MAX_CTRL_MSG + ft_tx_prefix_size();
		buf_size = rx_size + tx_size;
	} else {
		ft_set_tx_rx_sizes(&tx_size, &rx_size);
		tx_mr_size = 0;
		rx_mr_size = 0;
		buf_size = MAX(tx_size, FT_MAX_CTRL_MSG) * opts.window_size +
			   MAX(rx_size, FT_MAX_CTRL_MSG) * opts.window_size;
	}

	if (opts.options & FT_OPT_ALIGN && !(opts.options & FT_OPT_USE_DEVICE)) {
		alignment = sysconf(_SC_PAGESIZE);
		if (alignment < 0)
			return -errno;
		buf_size += alignment;

		ret = posix_memalign((void **) &buf, (size_t) alignment,
				buf_size);
		if (ret) {
			FT_PRINTERR("posix_memalign", ret);
			return ret;
		}
	} else {
		ret = ft_hmem_alloc(opts.iface, opts.device, (void **) &buf, buf_size);
		if (ret)
			return ret;
	}
	ret = ft_hmem_memset(opts.iface, opts.device, (void *) buf, 0, buf_size);
	if (ret)
		return ret;
	rx_buf = buf;

	if (opts.options & FT_OPT_ALLOC_MULT_MR)
		tx_buf = (char *) buf + MAX(rx_size, FT_MAX_CTRL_MSG);
	else
		tx_buf = (char *) buf + MAX(rx_size, FT_MAX_CTRL_MSG) * opts.window_size;

	remote_cq_data = ft_init_cq_data(fi);

	mr = &no_mr;
	if (!ft_mr_alloc_func && !ft_check_opts(FT_OPT_SKIP_REG_MR)) {
		ret = ft_reg_mr(buf, buf_size, ft_info_to_mr_access(fi),
				FT_MR_KEY, &mr, &mr_desc);
		if (ret)
			return ret;
	} else {
		if (ft_mr_alloc_func) {
			assert(!ft_check_opts(FT_OPT_SKIP_REG_MR));
			ret = ft_mr_alloc_func();
			if (ret)
				return ret;
		}
	}

	ret = ft_alloc_ctx_array(&tx_ctx_arr, &tx_mr_bufs, tx_buf,
				 tx_mr_size, FT_TX_MR_KEY);
	if (ret)
		return -FI_ENOMEM;

	ret = ft_alloc_ctx_array(&rx_ctx_arr, &rx_mr_bufs, rx_buf,
				 rx_mr_size, FT_RX_MR_KEY);
	if (ret)
		return -FI_ENOMEM;

	return 0;
}
-}
