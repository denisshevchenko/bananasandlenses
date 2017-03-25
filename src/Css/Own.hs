module Css.Own (
    ownCss
) where

import           Clay
import           Data.Text                      ( Text )
import qualified Data.Text.Lazy                 as Lazy

-- | Наш собственный CSS, встраивается в <head>-секцию всех страниц.
-- Внимание: используйте 'renderWith compact' осторожно, она глючная.
ownCss :: Text
ownCss = Lazy.toStrict . render $ do
    let centerAlign   = textAlign . alignSide $ sideCenter
        leftAlign     = textAlign . alignSide $ sideLeft
        rightAlign    = textAlign . alignSide $ sideRight

        paddingTopPx    = paddingTop . px
        paddingBottomPx = paddingBottom . px
        paddingLeftPx   = paddingLeft . px
        paddingRightPx  = paddingRight . px

        marginTopPx     = marginTop . px
        marginBottomPx  = marginBottom . px
        marginRightPx   = marginRight . px
        marginAuto      = margin (px 0) auto (px 0) auto

        fontSizePx      = fontSize . px
        fontSizePct     = fontSize . pct
        fontWeight700   = fontWeight $ weight 700

        simpleLinks     = do
            a # hover   ? do
                "color" -: "black !important"
            a # link    ? do
                "color" -: "black !important"
            a # visited ? do
                "color" -: "black !important"
            a # active  ? do
                "color" -: "black !important"
    
    ---------------------------------------------

    importUrl "https://fonts.googleapis.com/css?family=Roboto+Condensed:400,400i,700&subset=cyrillic"

    body ? do
        fontFamily      ["Roboto Condensed"] [sansSerif]
        fontSizePx      20
        backgroundColor "#fcfaeb"
        lineHeight      $ pct 170

    simpleLinks

    ".footer" ? do
        marginAuto
        -- maxWidth        $ pct 86
        paddingTopPx    70
        paddingBottomPx 50
        color           "#777"
        fontSizePct     94

    ".left"   ? leftAlign
    ".right"  ? rightAlign
    ".center" ? centerAlign

    h1 ? do
        centerAlign
        fontSizePct     200
        paddingBottomPx 30
    
    h2 ? do
        fontSizePct     160
        paddingTopPx    30
        paddingBottomPx 25
    
    h3 ? do
        fontSizePct     140
        paddingTopPx    25
        paddingBottomPx 20

    a ? do
        color           "#2d3644"
        textDecoration  none
        borderBottom    dotted (px 1) "#333333"

    a # hover ? do
        color           "#5493ff"
        textDecoration  none
        borderBottom    solid (px 1) "#999999"

    a # visited ? do
        color           "#2d3644"
        textDecoration  none

    a # active ? do
        color           "#2d3644"
        textDecoration  none
        borderBottom    dotted (px 1) "#333333"
    
    "#authors-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#about-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "#tags-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "#categories-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#sl-1" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "#sl-2" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#sl-3" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#sl-4" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "#sl-5" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#go-home" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "#hakyll-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    "#github-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    ".github-icon" ? do
        fontSizePct     150

    "#mit-link" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"
    
    ".fpconf-link" ? do
        fontSizePct     120
    
    ".fby-link" ? do
        fontSizePct     120
    
    ".friends-separator" ? do
        paddingLeftPx   30

    ".top-part" ? do
        backgroundColor "#faefa0"
        marginBottomPx  65

    ".navigation" ? do
        paddingTopPx    30
        paddingBottomPx 30
        fontSizePct     120
    
    ".links" ? do
        marginTopPx     10
        fontSizePct     98
        paddingBottomPx 10

    ".logo-area" ? do
        centerAlign
    
    ".social-links" ? do
        rightAlign
        marginTopPx     10
        fontSizePct     155

    ".social-links-separator" ? do
        paddingTopPx    37

    ".links-separator" ? do
        paddingTopPx    19
    
    ".reddit-color" ? do
        color           "#FF4500"

    ".twitter-color" ? do
        color           "#1DA1F2"

    ".feeds-color" ? do
        color           "#ea4d41"

    ".github-color" ? do
        color           "#000"

    ".rss-color" ? do
        color           "#FF924A"

    ".episode-number" ? do
        fontSizePct     85
        border          solid (px 1) "#f04436"
        borderRadius    (px 3) (px 3) (px 3) (px 3)
        backgroundColor "#ea4d41"
        color           "#faebd7"
        paddingTopPx    3
        paddingBottomPx 3
        paddingLeftPx   5
        paddingRightPx  5

    ".episode-info" ? do
        color           "#777"
        fontSizePct     90
        leftAlign
        paddingTopPx    10
        paddingBottomPx 60

    ".episode-list" ? do
        padding         (px 0) (px 0) (px 0) (px 0)
        margin          (px 0) (px 0) (px 0) (px 0)
        listStyleType   none
        fontSizePct     110

    ".episode-list" ? li ? do
        marginTopPx     21
        paddingBottomPx 21

    ".episode-list" ? a ? do
        textDecoration  none

    ".episode-list" ? a # hover ? do
        textDecoration  none

    ".episode-comments" ? do
        paddingLeftPx   15
        paddingRightPx  5
        fontSizePct     90
        color           "#777"

    ".comments-link" ? do
        fontSizePct     90
        color           "#777"

    ".archive-button" ? do
        paddingTopPx    30
        fontSizePct     120
    
    ".undecorated" ? do
        textDecoration  none
        borderBottom    solid (px 0) "#ffffff"

    "img[src*='#center']" ? do
        marginAuto
        display         block
        maxWidth        $ pct 100

    ".social-buttons-separator" ? do
        paddingTopPx    40

    ".heart-color" ? do
        color           "#FF3A1D"

    ".tags-cloud" ? do
        centerAlign
        paddingTopPx    15
        paddingBottomPx 30
        marginAuto
        maxWidth        $ pct 75
        lineHeight      $ pct 240

    ".tag-default" ? do
        backgroundColor "#b6ddfe"
        border          solid (px 1) "#a0d1fa"
        borderRadius    (px 8) (px 8) (px 8) (px 8)
        color           inherit

    ".episode-title" ? do
        fontSizePct     115

    ".episode-number-in-list" ? do
        fontSizePct     115
        paddingBottomPx 10

    ".episode-description" ? do
        -- paddingLeftPx   90
        fontSizePct     75
        color           "#777"

    ".podcast-name" ? do
        fontSizePct     120
        fontWeight700

    ".episode-h1" ? do
        -- centerAlign
        fontSizePct     200
        paddingBottomPx 26

    ".episode-number-h1" ? do
        fontSizePct     90
        border          solid (px 1) "#f04436"
        borderRadius    (px 3) (px 3) (px 3) (px 3)
        backgroundColor "#ea4d41"
        color           "#faebd7"
        paddingTopPx    3
        paddingBottomPx 3
        paddingLeftPx   9
        paddingRightPx  9
    
    ".episode-number-h1-area" ? do
        paddingBottomPx 40

    ".episode-metadata" ? do
        leftAlign
        paddingBottomPx 20

    ".name-of-tag-in-episode" ? do
        border          solid (px 1) "#a0d1fa"
        borderRadius    (px 8) (px 8) (px 8) (px 8)
        backgroundColor "#b6ddfe"
        paddingTopPx    5
        paddingBottomPx 4
        paddingLeftPx   8
        paddingRightPx  8
        marginRightPx   20

    ".episode-date" ? do
        fontSizePct     95
        rightAlign
        paddingTopPx    5

    ".episode-date-inside" ? do
        fontSizePct     120

    ".episode-tags" ? do
        fontSizePct     90
        paddingTopPx    30
        paddingBottomPx 10

    ".audio-record" ? do
        paddingBottomPx 50
    
    ".download-button" ? do
        fontSizePct     140

    ".download-button-area" ? do
        centerAlign
        paddingTopPx    20
