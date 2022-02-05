module CatGifs.Commands exposing (..)

import CatGifs.Models exposing (CatGif, CatGifsUrl)
import Http exposing (expectJson)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (requiredAt)
import Messages exposing (Msg)
import RemoteData


fetchCatGif : CatGifsUrl -> Cmd Msg
fetchCatGif url =
    Http.get
        { url = url
        , expect = expectJson (RemoteData.fromResult >> Messages.OnFetchCatGif) decodeCatGifUrl
        }


decodeCatGifUrl : Decode.Decoder CatGif
decodeCatGifUrl =
    Decode.succeed CatGif
        |> requiredAt [ "data", "images", "original", "url" ] Decode.string
