module Markup.Guest (
    guestTemplate
) where

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Hakyll.Web.Template
import           Data.Text                          ( Text )

guestTemplate :: Template
guestTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    h1 "$title$"
    div ! A.class_ "about-us" $ do
        toHtml intro
        instruction
  where
    intro :: Text
    intro = "Мы всегда рады гостям. Вскоре здесь появится пошаговая инструкция." 
    
    instruction :: Html
    instruction =
        div $ do
            preEscapedToHtml ("<br/>" :: String)
            span "По любым вопросам, связанным с участием в подкасте, обращайтесь к"
            a ! A.href "mailto:me@dshevchenko.biz" $ "Денису Шевченко"
            span " или "
            a ! A.href "mailto:alexander.vershilov@gmail.com" $ "Александру Вершилову"
            span "."
