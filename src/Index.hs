{-# LANGUAGE OverloadedStrings #-}

module Index (
    createIndexPage
) where

import Context              ( episodeContext )
import Misc                 ( TagsReader )
import Markup.Index         ( indexTemplate )
import Markup.Default       ( defaultTemplate )

import Control.Monad.Reader
import Hakyll

createIndexPage :: TagsReader
createIndexPage = do
    tags <- ask
    lift $ create ["index.html"] $ do
        route idRoute
        compile $ do
            last5Episodes <- fmap (take 5) . recentFirst =<< loadAll "episodes/**"
            let indexContext = mconcat [ listField "episodes" (episodeContext tags) (return last5Episodes)
                                       , constField "title" "Подкаст о Haskell"
                                       , constField "others" "Предыдущие выпуски"
                                       , defaultContext
                                       ]
            makeItem "" >>= applyTemplate indexTemplate indexContext
                        >>= applyTemplate defaultTemplate indexContext
                        >>= relativizeUrls
    return ()
