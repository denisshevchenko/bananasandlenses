{-# LANGUAGE OverloadedStrings #-}

module Misc (
      aHost
    , TagsReader
) where

import           Control.Monad.Reader (ReaderT)
import           Hakyll               (Rules, Tags)

aHost :: String
aHost = "http://bananasandlenses.net"

type TagsReader = ReaderT Tags Rules ()
