module CatGif.Messages exposing (Msg(..))

import CatGif.Models exposing (CatGif)
import RemoteData exposing (WebData)


type Msg
    = OnFetchCatGif (WebData CatGif)
