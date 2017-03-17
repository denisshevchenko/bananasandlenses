module Markup.About (
    aboutTemplate
) where

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Hakyll.Web.Template
import           Data.Text                          ( Text )

aboutTemplate :: Template
aboutTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    h1 "$title$"
    div ! A.class_ "about-us" $ do
        toHtml weAre
        contactUs
  where
    weAre :: Text
    weAre = "«Бананы и Линзы» — единственный русскоязычный подкаст, всецело посвящённый языку программирования Haskell. Мы используем этот прекрасный язык в своей повседневной работе и способствуем его распространению в русскоговорящей среде. Последние новости из мира Haskell, передовые разработки и интересные события — всё это в выпусках «Бананов и Линз»."

    contactUs :: Html
    contactUs =
        div $ do
            preEscapedToHtml ("<br/>" :: String)
            span "Если у вас есть вопросы, пожелания или предложения — напишите"
            a ! A.href "mailto:me@dshevchenko.biz" $ "Денису Шевченко"
            span " или "
            a ! A.href "mailto:alexander.vershilov@gmail.com" $ "Александру Вершилову"
            span "."
