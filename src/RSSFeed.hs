module RSSFeed (
    setupRSSFeed
) where

import Misc                 ( TagsReader, aHost )
import Context              ( episodeContext )

import Control.Monad.Reader
import Hakyll

setupRSSFeed :: TagsReader
setupRSSFeed = do
    tags <- ask
    lift $ create ["feed.xml"] $ do
        route idRoute
        compile $ do
            allEpisodes <- recentFirst =<< loadAll "episodes/**"
            let feedContext = mconcat [ listField "allEpisodes" (episodeContext tags) (return allEpisodes)      
                                      , constField "host" aHost
                                      , defaultContext
                                      ]
            makeItem ""
                >>= loadAndApplyTemplate "templates/feed.xml" feedContext
                >>= relativizeUrls
    return ()
