module CatGifs.Commands exposing (..)

import CatGifs.Models exposing (CatGif, CatGifsUrl)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required)
import Messages exposing (Msg)
import RemoteData


fetchCatGif : CatGifsUrl -> Cmd Msg
fetchCatGif url =
    Http.get url decodeCatGifUrl
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchCatGif


decodeCatGifUrl : Decode.Decoder CatGif
decodeCatGifUrl =
    Decode.succeed CatGif
        |> required "data" (Decode.field "image_url" Decode.string)
