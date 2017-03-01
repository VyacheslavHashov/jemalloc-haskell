{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString.Jemalloc
import System.Environment
import Control.Concurrent.Async
import qualified Data.ByteString as B

main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> putStrLn "No size number provided."
        [sizeStr] -> do
            let size = read sizeStr
            sums <- forConcurrently [1..10000] $ \ i -> do
                bs <- mallocByteString size
                return (B.foldl' (\ acc  _ -> acc + 1) 0 bs)
            print (sum sums)



