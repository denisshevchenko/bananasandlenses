module Episodes (
    createEpisodes
) where

import Context              ( episodeContext )
import Misc                 ( TagsReader )
import Markup.Episode       ( episodeTemplate )
import Markup.Default       ( defaultTemplate )

import Data.List.Split      ( splitOn )
import Data.Monoid          ( (<>) )
import Control.Monad.Reader
import Hakyll

removeEpisodeDate :: Routes
removeEpisodeDate = customRoute (\ep -> episodeNameWithoutDate $ toFilePath ep)
  where
    episodeNameWithoutDate path = "episode" <> (splitOn "-" path) !! 3

createEpisodes :: TagsReader
createEpisodes = do
    tags <- ask
    lift $ match "episodes/**" $ do
        route $ removeEpisodeDate `composeRoutes` setExtension "html"
        -- Для превращения Markdown в HTML используем pandocCompiler
        compile $ pandocCompiler
              >>= applyTemplate episodeTemplate (episodeContext tags)
              >>= applyTemplate defaultTemplate (episodeContext tags)
              >>= relativizeUrls
    return ()
