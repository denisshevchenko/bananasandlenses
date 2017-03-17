module Markup.Index (
    indexTemplate
) where

import           Markup.EpisodesList                ( episodesList )

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Hakyll.Web.Template

indexTemplate :: Template
indexTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    episodesList
    buttonToEpisodesArchive
  where
    buttonToEpisodesArchive = 
        div ! A.class_ "archive-button" $ 
            a ! A.href "/archive.html" ! A.id "sl-3" $ do
                i ! A.class_ "fa fa-backward" ! customAttribute "aria-hidden" "true" $ ""
                preEscapedToHtml ("&nbsp;" :: String)
                span "$others$"
