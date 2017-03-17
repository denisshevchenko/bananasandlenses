{-# LANGUAGE QuasiQuotes #-}

module Markup.EpisodesList (
    episodesList
) where

import Text.Blaze.Html5
import Data.String.QQ

episodesList :: Html
episodesList = preEscapedToHtml raw

raw :: String
raw = [s|
<ul class="episode-list">
    $for(episodes)$
        <li>
            <div class="row">
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
                    <div class="episode-title">
                        <span class="name-of-category">№ $episodeNumber$</span><a href="$url$">$title$</a><br/>
                        <span class="episode-description">$description$</span>
                    </div>
                </div>

                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="episode-date">
                        $date$
                    </div>
                </div>
            </div>
        </li>
    $endfor$
</ul>
|]
