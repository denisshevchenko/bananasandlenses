{-# LANGUAGE QuasiQuotes #-}

module Markup.Episode (
    episodeTemplate
) where

import           Prelude                            hiding ( div, span )
import           Text.Blaze.Html5
import qualified Text.Blaze.Html5.Attributes        as A
import           Text.Blaze.Html.Renderer.Pretty    ( renderHtml )
import           Data.String.QQ
import           Hakyll.Web.Template

episodeTemplate :: Template
episodeTemplate = readTemplate . renderHtml $ raw

raw :: Html
raw = do
    div ! A.class_ "episode-h1" $ do
        div ! A.class_ "row" $ do
            div ! A.class_ "col-lg-2 col-md-3 col-sm-12 col-xs-12 episode-number-h1-area" $
                span ! A.class_ "episode-number-h1" $ "№ $episodeNumber$"

            div ! A.class_ "col-lg-10 col-md-9 col-sm-12 col-xs-12" $
                span $ "$title$"

    div ! A.class_ "episode-metadata" $ do
        div ! A.class_ "episode-date-inside" $ "$date$"
        div ! A.class_ "episode-tags" $ "$episodeTags$"

    div $ "$body$"
    div ! A.class_ "social-buttons-separator" $ ""
    
    div ! A.class_ "audio-record" $ do
        div $ preEscapedToHtml audioRecord
        div ! A.class_ "download-button-area" $
            a ! A.href "/audio/episode$episodeNumber$.mp3" ! A.id "sl-2" ! A.title "Скачать MP3" $
                i ! A.class_ "fa fa-download download-button" ! customAttribute "aria-hidden" "true" $ ""

    div ! A.id "socialButtons" $ preEscapedToHtml socialButtons
    div ! A.class_ "social-buttons-separator" $ ""
    div $ preEscapedToHtml disqusThread

audioRecord :: String
audioRecord = [s|
<audio controls style="width: 100%;"><source src="/audio/episode$episodeNumber$.mp3" type="audio/mp3"></audio>
|]

socialButtons :: String
socialButtons = [s|
<a href="https://twitter.com/share?hashtags=bananasandlenses" class="twitter-share-button" data-lang="ru" data-size="large">Твитнуть</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
|]

disqusThread :: String
disqusThread = [s|
<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = 'bananasandlenses'; // required: replace example with your forum shortname

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
|]
