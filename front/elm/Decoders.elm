module Decoders exposing (decodeDate, decodeUrl)

import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import Url exposing (Protocol(..), Url)


decodeDate : Decoder Date
decodeDate =
    Decode.andThen
        (\s ->
            case Date.fromIsoString s of
                Ok l ->
                    Decode.succeed l

                Err e ->
                    Decode.fail e
        )
        Decode.string


decodeUrl : Decoder (Maybe Url)
decodeUrl =
    Decode.map Url.fromString Decode.string
