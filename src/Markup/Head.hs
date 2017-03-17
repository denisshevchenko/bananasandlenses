{-# LANGUAGE QuasiQuotes #-}

module Markup.Head (
    commonHead
) where

import           Css.Own                        ( ownCss )
import           Misc                           ( aHost )

import           Prelude                        hiding ( div, span, head )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes    as A
import           Data.Monoid

commonHead :: Html
commonHead = head $ do
    title "$title$ ~ Бананы и Линзы"
    
    meta ! A.charset "utf-8"

    -- Для мобильных экранов.
    meta ! A.name "viewport"
         ! A.content "width=device-width, initial-scale=1.0"
    
    meta ! A.name "description"
         ! A.content ""
    
    meta ! A.name "author"
         ! A.content ""

    link ! A.rel "icon"
         ! A.type_ "image/png"
         ! A.href (toValue $ imgRoot <> "favicon.ico")
    
    cssLink "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
    cssLink "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css"
    style $ toHtml ownCss 
    
    -- RSS feed.
    link ! A.rel "alternate"
         ! A.type_ "application/rss+xml"
         ! A.title "RSS"
         ! A.href (toValue $ aHost ++ "/feed.xml")
  where
    cssLink :: String -> Html
    cssLink url = link ! A.rel "stylesheet" ! A.href (toValue url)

    imgRoot :: String
    imgRoot = "/static/images/"
