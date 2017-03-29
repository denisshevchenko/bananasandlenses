module Markup.Guest (
    guestTemplate
) where

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Hakyll.Web.Template

guestTemplate :: Template
guestTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    h1 "$title$"
    div ! A.class_ "about-us" $ do
        topics
        instruction
  where
    topics :: Html
    topics = do
        div $ do
            h3 $ "О чём можно рассказать"
            ul $ do
                li $ "Обо всём, связанном с разработкой на Haskell."
                li $ "Обо всём, связанном с изучением/обучением Haskell."
                li $ "Обо всём, связанном с фундаментальной теорией ФП."
    
        div $ do
            h3 $ "Как записываемся"
            ul $ do
                li $ do
                    span "Используем"
                    a ! A.href "https://wiki.mumble.info/wiki/Main_Page" $ "Mumble"
                    span ". Устанавливаете клиент, есть для Linux, для macOS и для Windows."
                li $ do
                    span "Server: "
                    strong $ span $ "bananasandlenses.mumble.com"
                li $ do
                    span "Port: "
                    strong $ span $ "63479"

    instruction :: Html
    instruction =
        div $ do
            preEscapedToHtml ("<br/>" :: String)
            span "По любым вопросам, связанным с участием в подкасте, незамедлительно обращайтесь к"
            a ! A.href "mailto:me@dshevchenko.biz" $ "Денису Шевченко"
            span " или "
            a ! A.href "mailto:alexander.vershilov@gmail.com" $ "Александру Вершилову"
            span "."
