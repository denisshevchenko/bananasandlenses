module Main where

import RSSFeed              ( setupRSSFeed )
import Episodes             ( createEpisodes )
import Tags                 ( createPageWithAllTags
                            , convertTagsToLinks
                            , buildEpisodesTags
                            )
import Archive              ( createPageWithAllEpisodes )
import About                ( createAboutPage )
import Guest                ( createGuestPage )
import Index                ( createIndexPage )

import Control.Monad.Reader ( runReaderT )
import Hakyll

main :: IO ()
main = hakyll $ do
    justCopy "static/images/*"
    prepareTemplates
    tags <- buildEpisodesTags
    runReaderT (    createEpisodes
                 >> createPageWithAllEpisodes
                 >> createPageWithAllTags
                 >> convertTagsToLinks
                 >> setupRSSFeed
                 >> createIndexPage
                 >> createAboutPage
                 >> createGuestPage
               ) tags
  where
    justCopy something = match something $ do
        route   idRoute
        compile copyFileCompiler
    prepareTemplates = match "templates/*" $
        compile templateCompiler
