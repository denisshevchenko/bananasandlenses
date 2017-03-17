module Markup.Episodes (
    episodesTemplate
) where

import           Markup.EpisodesList                ( episodesList )

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Hakyll.Web.Template

episodesTemplate :: Template
episodesTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    h1 "$title$"
    div ! A.id "taggedEpisodes" $ episodesList
