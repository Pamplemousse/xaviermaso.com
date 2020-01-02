module CatGifs.Models exposing (..)

-- URL of the source providing GIF URLs.


type alias CatGifsUrl =
    String


type alias CatGif =
    { gifUrl : String -- URL of the GIF resource on the internet.
    }
