module Context (
    episodeContext
) where

import           Data.Time                      (TimeLocale(..))
import           Misc                           (aHost)

import qualified Text.Blaze.Html5               as H
import qualified Text.Blaze.Html5.Attributes    as A
import           Text.Blaze.Html                (toHtml, toValue, (!))

import Hakyll

simpleRenderQuottedLink :: String
                        -> Maybe FilePath
                        -> Maybe H.Html
simpleRenderQuottedLink tag = fmap $ \filePath -> -- Формируем тег <a href...>
    H.a ! A.class_ "name-of-tag-in-episode" ! A.href (toValue $ toUrl filePath) $ toHtml tag

-- Превращает имя ссылки в ссылку, ведущую к списку эпизодов по данной теме.
quottedTagField :: String
                -> Tags
                -> Context a
quottedTagField = tagsFieldWith getTags simpleRenderQuottedLink mconcat

-- Локализация в данном случае задаётся только для русских названий месяцев.
-- Остальные поля типа TimeLocale инициализированы пустыми значениями.
ruTimeLocale :: TimeLocale
ruTimeLocale =  TimeLocale { wDays  = []
                           , months = [("января",   "jan"),  ("февраля", "feb"),
                                       ("марта",    "mar"),  ("апреля",  "apr"),
                                       ("мая",      "may"),  ("июня",    "jun"),
                                       ("июля",     "jul"),  ("августа", "aug"),
                                       ("сентября", "sep"),  ("октября", "oct"),
                                       ("ноября",   "nov"),  ("декабря", "dec")]
                           , knownTimeZones = []
                           , amPm = ("", "")
                           , dateTimeFmt = ""
                           , dateFmt = ""
                           , timeFmt = ""
                           , time12Fmt = ""
                           }

-- Основной контекст выпусков.
episodeContext :: Tags -> Context String
episodeContext tags = mconcat
    [ constField                "host"            aHost
    , dateFieldWith             ruTimeLocale      "date" "%_d %B %Y"
    , dateField                 "episodePubDate"  "%a, %_d %b %Y %H:%M:%S GMT"
    , quottedTagField           "episodeTags"     tags
    , defaultContext
    ]
