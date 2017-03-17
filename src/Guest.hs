module Guest (
    createGuestPage
) where

import Misc                 ( TagsReader )
import Markup.Guest         ( guestTemplate )
import Markup.Default       ( defaultTemplate )

import Control.Monad.Reader
import Hakyll

createGuestPage :: TagsReader
createGuestPage = do
    lift $ create ["guest.html"] $ do
        route idRoute
        compile $ do
            let guestContext = mconcat [ constField "title" "Приходите в гости"
                                       , defaultContext
                                       ]
            makeItem "" >>= applyTemplate guestTemplate guestContext
                        >>= applyTemplate defaultTemplate guestContext
                        >>= relativizeUrls
    return ()
