module Markup.Archive (
    archiveTemplate
) where

import Markup.EpisodesList                  ( episodesList )

import Prelude                              hiding ( div, span )
import Text.Blaze.Html5
import Text.Blaze.Html.Renderer.Pretty      ( renderHtml )
import Hakyll.Web.Template

archiveTemplate :: Template
archiveTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    h1 "$title$"
    episodesList
