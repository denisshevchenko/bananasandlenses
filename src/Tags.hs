module Tags (
      buildEpisodesTags
    , createPageWithAllTags
    , convertTagsToLinks
) where

import           Markup.Tags                        ( tagsTemplate )
import           Markup.Episodes                    ( episodesTemplate )
import           Markup.Default                     ( defaultTemplate )
import           Context                            ( episodeContext )
import           Misc                               ( TagsReader )

import           Data.List                          ( intercalate )
import           Control.Monad.Reader
import           Text.Blaze.Html                    ( toValue, (!) )
import           Text.Blaze.Html.Renderer.String    ( renderHtml )
import qualified Text.Blaze.Html5                   as H
import qualified Text.Blaze.Html5.Attributes        as A
import           Hakyll

-- Функция извлекает из всех статей значения поля tags и собирает их в кучу.
buildEpisodesTags :: MonadMetadata m => m Tags
buildEpisodesTags = buildTags "episodes/**" $ fromCapture "tags/*.html"

-- Функция отрисовывает тег-ссылку вместе со значком, отражающим количество публикаций,
-- соответствующих данному тегу. Например, количество статей данного автора.
-- За основу взяты исходники Hakyll.
createTagLinkWithBadge :: Double
                       -> Double
                       -> String
                       -> String
                       -> Int
                       -> Int
                       -> Int
                       -> String
createTagLinkWithBadge = createGenericTagLinkWithBadge id

createGenericTagLinkWithBadge :: (String -> String)
                              -> Double
                              -> Double
                              -> String
                              -> String
                              -> Int
                              -> Int
                              -> Int
                              -> String
{-# INLINE createGenericTagLinkWithBadge #-}
createGenericTagLinkWithBadge convert
                              smallestFontSizeInPercent
                              biggestFontSizeInPercent
                              tag
                              url
                              count
                              min'
                              max' =
    let diff     = 1 + fromIntegral max' - fromIntegral min'
        relative = (fromIntegral count - fromIntegral min') / diff
        size     = floor $ smallestFontSizeInPercent + relative * (biggestFontSizeInPercent - smallestFontSizeInPercent) :: Int
    in renderHtml $ do
        -- Формируем стандартный тег <a href...>
        H.a ! A.style (toValue $ "font-size: " ++ show size ++ "%")
            ! A.href (toValue url) $
            H.preEscapedToHtml $ convert tag
        H.span ! A.style (toValue $ "font-size: " ++ show size ++ "%") $ 
            H.preEscapedToHtml $ "&nbsp;<span class=\"tag tag-default\">" ++ show count ++ "</span>"

-- Отрисовываем облако с тегами-ссылками, имеющими количественные значки.
renderTagCloudWithBadges :: Double
                         -> Double
                         -> Tags
                         -> Compiler String
renderTagCloudWithBadges smallestFontSizeInPercent
                         biggestFontSizeInPercent
                         specificTags =
    renderTagCloudWith tagLinkRenderer
                       concatenateLinksWithSpaces
                       smallestFontSizeInPercent
                       biggestFontSizeInPercent
                       specificTags
  where
    tagLinkRenderer = createTagLinkWithBadge
    concatenateLinksWithSpaces = intercalate "<span style=\"padding-left: 20px;\"></span>"

-- Вспомогательная функция, формирующая страницу с облаком определённых тегов.
createPageWithTagsCloud :: Tags
                        -> Identifier
                        -> Double
                        -> Double
                        -> String
                        -> String
                        -> Template
                        -> Rules ()
createPageWithTagsCloud specificTags
                        pageWithSpecificTags
                        smallestFontSizeInPercent
                        biggestFontSizeInPercent
                        pageTitle
                        cloudName
                        specificTemplate =
    create [pageWithSpecificTags] $ do
        route idRoute
        compile $ do
            let renderedCloud _ = renderTagCloudWithBadges smallestFontSizeInPercent
                                                           biggestFontSizeInPercent
                                                           specificTags
                tagsContext = mconcat [ constField "title" pageTitle
                                      , field cloudName renderedCloud
                                      , defaultContext
                                      ]

            makeItem "" >>= applyTemplate specificTemplate tagsContext
                        >>= applyTemplate defaultTemplate tagsContext
                        >>= relativizeUrls

-- Формируем страницу с облаком тематических тегов.
createPageWithAllTags :: TagsReader
createPageWithAllTags = do
    tags <- ask
    lift $ createPageWithTagsCloud tags
                                   "tags.html"
                                   110
                                   220
                                   "Темы"
                                   "tagsCloud"
                                   tagsTemplate
    return ()

convertSpecificTagsToLinks :: Tags -> String -> Rules ()
convertSpecificTagsToLinks tags aTitle =
    tagsRules tags $ \tag pattern -> do
        let nameOfTag = tag
            title = renderHtml $ H.preEscapedToHtml $ aTitle ++ " " ++ nameOfTag
        route idRoute
        compile $ do
            episodes <- recentFirst =<< loadAll pattern
            let taggedEpisodesContext = mconcat [ listField "episodes" (episodeContext tags) (return episodes)
                                             , constField "title" title
                                             , defaultContext
                                             ]

            makeItem "" >>= applyTemplate episodesTemplate taggedEpisodesContext
                        >>= applyTemplate defaultTemplate taggedEpisodesContext
                        >>= relativizeUrls

-- Делаем тематические теги ссылками, что позволит отфильтровать эпизоды по тегам.
convertTagsToLinks :: TagsReader
convertTagsToLinks = do
    tags <- ask
    lift $ convertSpecificTagsToLinks tags "Всё по теме"
    return ()
