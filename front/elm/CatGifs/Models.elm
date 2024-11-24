module CatGifs.Models exposing (CatGif, cat500, catGifDefaultUrl)

import Url exposing (Protocol(..), Url)


cat500 : Url
cat500 =
    Url Https "http.cat" Nothing "images/500.jpg" Nothing Nothing


catGifDefaultUrl : Url
catGifDefaultUrl =
    Url Https "api.giphy.com" Nothing "v1/gifs/random" (Just "tag=cat") Nothing


type alias CatGif =
    { gifUrl : Url -- URL of the GIF resource on the internet.
    }
