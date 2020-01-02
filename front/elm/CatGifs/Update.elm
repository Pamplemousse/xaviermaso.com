module CatGif.Update exposing (update)

import CatGif.Messages exposing (Msg(..))
import CatGif.Models exposing (CatGif)
import RemoteData exposing (WebData)
import Routing exposing (Route(..), routeParser)


update : Msg -> WebData CatGif
update msg =
    case msg of
        OnFetchCatGif response ->
            response
