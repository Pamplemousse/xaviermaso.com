module CatGifs.Commands exposing (..)

import CatGifs.Models exposing (CatGif, cat500)
import Decoders exposing (decodeUrl)
import Http exposing (expectJson)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (requiredAt)
import Messages exposing (Msg)
import RemoteData
import Url exposing (Protocol(..), Url)


fetchCatGif : Url -> Cmd Msg
fetchCatGif url =
    Http.get
        { url = url |> Url.toString
        , expect = expectJson (RemoteData.fromResult >> Messages.OnFetchCatGif) decodeCatGif
        }


decodeCatGif : Decode.Decoder CatGif
decodeCatGif =
    Decode.succeed CatGif
        |> requiredAt [ "data", "images", "original", "url" ] (Decode.map (Maybe.withDefault cat500) decodeUrl)
