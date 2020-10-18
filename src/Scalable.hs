{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE FlexibleContexts #-}


module Scalable where

import Data.Bits (shiftR)
import Foreign.Marshal.Array
import Foreign.Marshal.Alloc
import Foreign.Storable
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr
import System.Environment
import XLibfabric.RDMA.Fabric hiding (C'fid_cq, C'fid_ep, C'fid_pep, C'fid_eq, C'fid_av, C'fid_domain)
import XLibfabric.RDMA.FiEndpoint
import XLibfabric.RDMA.FiEq
import XLibfabric.RDMA.FiCm
import XLibfabric.RDMA.FiDomain hiding (C'fi_cq_attr)

{- IMPORTS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

#include <rdma/fi_errno.h>
#include <rdma/fi_endpoint.h>
#include <rdma/fi_cm.h>

#include <shared.h>
-}

{- GLOBAL VARS
static int ctx_cnt = 2;
static int rx_ctx_bits = 0;
static struct fid_ep *sep;
static struct fid_ep **tx_ep, **rx_ep;
static struct fid_cq **txcq_array;
static struct fid_cq **rxcq_array;
static fi_addr_t *remote_rx_addr;
#define DATA 0x12345670
-}

data Env = Env {
    ctx_cnt :: CInt -- 2
   ,rx_ctx_bits :: CInt -- 0
   ,sep :: Ptr C'fid_ep
   ,tx_ep :: Ptr (Ptr C'fid_ep)
   ,rx_ep :: Ptr (Ptr C'fid_ep)
   ,txcq_array :: Ptr (Ptr C'fid_cq)
   ,rxcq_array :: Ptr (Ptr C'fid_cq)
   ,remote_rx_addr :: (Ptr C'fi_addr_t)
   ,cq_attr :: Ptr C'fi_cq_attr
   ,av_attr :: C'fi_av_attr
   ,av :: Ptr C'fid_av
   ,hints :: Ptr (Ptr C'fi_info)
   ,fi :: Ptr (Ptr C'fi_info)
   ,domain :: Ptr C'fid_domain
   ,buf :: Ptr CChar
   ,tx_buf :: Ptr CChar
   ,rx_buf :: Ptr CChar
   ,mr_desc :: Ptr ()
}
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

closev_fid :: [Ptr C'fid_ep] -> IO ()
closev_fid = mapM_ close_fid

close_fid :: Ptr C'fid_ep -> IO ()
close_fid fep = do
    ret <- c'fi_close $ p'fid_ep'fid fep
    print ret

free_res :: Env -> IO ()
free_res Env {..} = do
    closev_fid rx_ep ctx_cnt
    closev_fid tx_ep ctx_cnt
    closev_fid rxcq_array ctx_cnt
    closev_fid txcq_array ctx_cnt

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

ft_alloc_ep_res a = return 0

alloc_ep_res :: Env -> IO CInt
alloc_ep_res (env@Env {..}) = do
    poke (p'fi_av_attr'rx_ctx_bits av_attr) $ ctxShiftR (ctx_cnt, rx_ctx_bits)
    ret <- ft_alloc_ep_res fi
    if ret == 0
        then do
            --txcq_array = calloc(ctx_cnt, sizeof *txcq_array);
            --rxcq_array = calloc(ctx_cnt, sizeof *rxcq_array);
            --tx_ep = calloc(ctx_cnt, sizeof *tx_ep);
            --rx_ep = calloc(ctx_cnt, sizeof *rx_ep);
            --remote_rx_addr = calloc(ctx_cnt, sizeof *remote_rx_addr);
            mapM_ (\i -> do
                            (c'fi_tx_context sep i nullPtr (plusPtr tx_ep (i*(sizeOf tx_ep))) nullPtr)
                            (c'fi_cq_open domain cq_attr (plusPtr txcq_array (i*(sizeOf txcq_array))) nullPtr)
                            (c'fi_rx_context sep i nullPtr (plusPtr rx_ep (i*(sizeOf rx_ep))) nullPtr)
                            (c'fi_cq_open domain cq_attr (plusPtr rxcq_array (i*(sizeOf rxcq_array))) nullPtr))
                  [0 .. (ctx_cnt - 1)]     
        else
            return ret

ctxShiftR :: (Int, Int) -> Int
ctxShiftR (c,r) | shifted <= 0 = r+1
                | otherwise = ctxShiftR (c,r+1)
                where shifted = c `shiftR` r

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
{-
bind_ep_res = do
    (fi_scalable_ep_bind sep (p'fid_av'fid av) 0) |->
    mapM_ (\i -> (fi_ep_bind) |-> fi_enable) [0 .. (ctx_cnt - 1)] |->
    (fi_ep_bind |-> fi_enable |-> fi_recv) |->
    fi_enable
-}
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
    alloca $ \comp -> do
        ret <- doWhile (fmap (\x -> (x, -11)) (c'fi_cq_read cq comp 1)) (\(x,ret) -> x < 0 && ret == -11)
        if ret /= 1
            then do
                print $ "fi_cq_read: " <> show ret
                return ret
            else
                return 0 
            
doWhile a f = do
    a' <- a
    if f a'
        then doWhile a f
        else return a'

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
    let ret = 0
        tb = castPtr tx_buf
        rb = castPtr rx_buf
    if True -- (opts.dst_addr)
        then do
            run_test_send env 0 0
        else do
            run_test_recv env 0 0

run_test_send (env@Env {..}) 2 ret = return ret
run_test_send (env@Env {..}) i 0 = return 0
run_test_send (env@Env {..}) i _ = do
    print $ "Posting send for ctx: " ++ show i
    poke tb[0] (datum + i)
    (c'fi_send tx_ep[i] tx_buf tx_size mr_desc remote_rx_addr[i] nullPtr) |-> (wait_for_comp env txcq_array[i]) >>= \r -> env run_test_send (i + 1) r

run_test_recv (env@Env {..}) 0 ret = return ret
run_test_recv (env@Env {..}) i 0 = return 0
run_test_recv (env@Env {..}) i _ = do
    print $ "wait for recv completion for ctx: " ++ show i
    wait_for_comp env rxcq_array[i]
    peek rb[0]  >>= \r -> run_test_recv env (i + 1) r

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

init_fabric :: Env -> IO CInt
init_fabric (env@Env {..}) = do
    ret <- ft_getinfo hints fi
    if ret == 0
        then do
            fi' <- peek fi
            fi'' <- peek fi'
            let domain_attr = c'domain_attr fi''
            let ctxcnt = minimum [ctx_cnt, c'tx_ctx_cnt domain_attr, r'tx_ctx_cnt domain_attr]
            if ctxcnt <= 0
                then do
                    print "Provider doesn't support contexts"
                    return 1
                else do
                    --fi->ep_attr->tx_ctx_cnt = ctx_cnt;
                    --fi->ep_attr->rx_ctx_cnt = ctx_cnt;
                    --
                    let ep_attr_ptr = c'fi_info'ep_attr fi
                    ep_attr <- peek ep_attr_ptr
                    poke ep_attr_ptr $ ep_attr {c'fi_ep_attr'tx_ctx_cnt = ctxcnt, c'fi_ep_attr'rx_ctx_cnt = ctxcnt}
                    ft_open_fabric_res |-> (c'fi_scalable_ep domain fi sep nullPtr) |-> (poke sep >>= alloc_ep_res) |-> bind_ep_res        
        else
            return ret

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
    -- based on opts do init_av_a or init_av_b
    (mapM_ (\x -> c'fi_rx_addr remote_fi_addr x rx_ctx_bits) [0 .. (ctx_cnt - 1)] >> recv fi_recvrx_ep[0] rx_buf rx_size mr_desc 0 nullPtr) |->
        (wait_for_comp txcq_array)

init_av_a (env@Env {..}) = do
    alloca $ \addrlen ->
        poke 256
            (ft_av_insert av c'fi_info'dest_addr 1 remote_fi_addr 0 nullPtr) |->
            (fi_getname p'fid_ep'fid tx_buf addrlen) |->
            (peek addrlen >>= \al -> fi_send tx_ep[0] tx_buf al mr_desc remote_fi_addr nullPtr) |->
            (wait_for_comp env rxcq_array[0])

init_av_b (env@Env {..}) = do
    (wait_for_comp env rxcq_array[0]) |->
        (ft_av_insert av rx_buf 1 remote_fi_addr 0 nullPtr) |->
        (fi_send tx_ep[0] tx_buf 1 mr_desc remote_fi_addr nullPtr)
    

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

run :: Env -> IO CInt
run env = init_fabric env |-> init_av env |-> run_test env

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
    alloca $ \e'sep -> allocaArray 2 $ \e'tx_ep -> allocaArray 2 $ \e'rx_ep -> allocaArray 2 $ \e'txcq_array ->
        allocaArray 2 $ \e'rxcq_array -> alloca $ \e'remote_rx_addr -> alloca $ \e'cq_attr -> alloca $ \e'av_attr -> alloca $ \e'av ->
            alloca $ \e'hints -> alloca $ \e'fi -> alloca $ \e'domain ->
                alloca $ \e'buf -> alloca $ \e'tx_buf -> alloca $ \e'rx_buf -> alloca $ \e'mr_desc -> do
                    h <- c'fi_allocinfo
                    poke e'hints h
                    let env = Env 2
                                0
                                e'sep
                                e'tx_ep
                                e'rx_ep
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
                    run env

    

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

retNonZero :: (Num a, Eq a) => IO a -> IO a -> IO a
retNonZero a b = do
    a' <- a
    if a' == 0 
        then b
    else
        return a'

(|->) = retNonZero