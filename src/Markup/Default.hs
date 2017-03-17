module Markup.Default (
    defaultTemplate
) where

import           Prelude                         hiding (div)

import           Data.Text                       (Text)
import           Hakyll.Web.Template             (Template, readTemplate)
import           Text.Blaze.Html.Renderer.Pretty (renderHtml)
import           Text.Blaze.Html5                (Html, a, body,
                                                  customAttribute, div,
                                                  docTypeHtml, i, img,
                                                  preEscapedToHtml, (!))
import qualified Text.Blaze.Html5.Attributes     as A

import           Markup.Footer
import           Markup.Head

defaultTemplate :: Template
defaultTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = docTypeHtml $ do
    commonHead
    body $ do
        div ! A.class_ "container-fluid top-part" $
            div ! A.class_ "container" $
                navigation
        div ! A.class_ "container" $
            lastPosts
        commonFooter

navigation :: Html
navigation =
    div ! A.class_ "navigation" $
        div ! A.class_ "row" $ do
            div ! A.class_ "col-lg-3 col-md-3 col-sm-12 col-xs-12" $ links
            div ! A.class_ "col-lg-6 col-md-6 col-sm-12 col-xs-12" $ logoArea
            div ! A.class_ "col-lg-3 col-md-3 col-sm-12 col-xs-12" $ feedLinks

logoArea :: Html
logoArea =
    div ! A.class_ "logo-area" $ do
        div ! A.class_ "podcast-name" $ "Бананы и Линзы"
        div $
            a ! A.href "/"
              ! A.title "Домой"
              ! A.id "go-home" $
                img ! A.src "/static/images/logo.png"
                    ! A.alt "Бананы и Линзы"
                    ! A.width "136"
        div ! A.class_ "podcast-description" $ "Подкаст о Haskell"

links :: Html
links =
    div ! A.class_ "links" $ do
        a ! A.href "/archive.html" ! A.id "tags-link" $ "Всё"
        div ! A.class_ "links-separator" $ ""
        a ! A.href "/tags.html" ! A.id "tags-link" $ "Темы"
        div ! A.class_ "links-separator" $ ""
        a ! A.href "/guest.html" ! A.id "tags-link" $ "Гостям"
        div ! A.class_ "links-separator" $ ""
        a ! A.href "/about.html" ! A.id "tags-link" $ "О проекте"

feedLinks :: Html
feedLinks =
    div ! A.class_ "social-links" $ do
        a ! A.href "/feed.xml" ! A.id "sl-1" ! A.title "Наш RSS" $
            i ! A.class_ "fa fa-rss feeds-color" ! customAttribute "aria-hidden" "true" $ ""

        div ! A.class_ "social-links-separator" $ ""
        
        a ! A.href "https://itunes.apple.com/ru/podcast/banany-i-linzy/id1037879859" ! A.id "sl-2" ! A.title "Мы в iTunes" $
            i ! A.class_ "fa fa-podcast feeds-color" ! customAttribute "aria-hidden" "true" $ ""

        div ! A.class_ "social-links-separator" $ ""

        a ! A.href "https://twitter.com/search?src=typd&q=%23bananasandlenses" ! A.id "sl-3" ! A.title "Мы в Twitter" $
            i ! A.class_ "fa fa-twitter feeds-color" ! customAttribute "aria-hidden" "true" $ ""

lastPosts :: Html
lastPosts =
    div ! A.id "content" $ preEscapedToHtml ("$body$" :: Text)
