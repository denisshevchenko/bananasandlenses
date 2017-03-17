module Markup.Footer where

import           Prelude                        hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes    as A

commonFooter :: Html
commonFooter =
    footer ! A.class_ "footer" $
        div ! A.class_ "container" $ do
            div ! A.class_ "row" $ do
                div ! A.class_ "col-lg-4 col-md-4 col-sm-4 col-xs-4 left" $   copyright
                div ! A.class_ "col-lg-4 col-md-4 col-sm-4 col-xs-4 center" $ github
                div ! A.class_ "col-lg-4 col-md-4 col-sm-4 col-xs-4 right" $  hakyll
  where
    copyright = "© 2015-2017 «Бананы и Линзы»"

    github =
        a ! A.href "https://github.com/denisshevchenko/bananasandlenses" ! A.id "github-link" $ do
            i ! A.class_ "fa fa-github github-icon" ! customAttribute "aria-hidden" "true" $ ""

    hakyll =
        a ! A.href "http://jaspervdj.be/hakyll/" ! A.id "hakyll-link" $ do
            span "Мы"
            i ! A.class_ "fa fa-heart heart-color" ! customAttribute "aria-hidden" "true" $ ""
            span "Hakyll"
