module About (
    createAboutPage
) where

import Misc                 ( TagsReader )
import Markup.About         ( aboutTemplate )
import Markup.Default       ( defaultTemplate )

import Control.Monad.Reader
import Hakyll

createAboutPage :: TagsReader
createAboutPage = do
    lift $ create ["about.html"] $ do
        route idRoute
        compile $ do
            let aboutContext = mconcat [ constField "title" "О подкасте"
                                       , defaultContext
                                       ]
            makeItem "" >>= applyTemplate aboutTemplate aboutContext
                        >>= applyTemplate defaultTemplate aboutContext
                        >>= relativizeUrls
    return ()
