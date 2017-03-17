module Archive (
    createPageWithAllEpisodes
) where

import Context              ( episodeContext )
import Misc                 ( TagsReader )
import Markup.Archive       ( archiveTemplate )
import Markup.Default       ( defaultTemplate )

import Control.Monad.Reader
import Hakyll

createPageWithAllEpisodes :: TagsReader
createPageWithAllEpisodes = do
    tags <- ask
    lift $ create ["archive.html"] $ do
        route idRoute
        compile $ do
            allEpisodes <- recentFirst =<< loadAll "episodes/**"
            let archiveContext = mconcat [ listField "episodes" (episodeContext tags) (return allEpisodes)
                                         , constField "title" "Все выпуски"
                                         , defaultContext
                                         ]

            makeItem "" >>= applyTemplate archiveTemplate archiveContext
                        >>= applyTemplate defaultTemplate archiveContext
                        >>= relativizeUrls
    return ()
