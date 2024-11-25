module Lang exposing (Lang(..), decoder, toString)

import Json.Decode as Decode exposing (Decoder)


type Lang
    = EN
    | FR


decoder : Decoder Lang
decoder =
    Decode.andThen
        (\s ->
            case fromString s of
                Ok l ->
                    Decode.succeed l

                Err e ->
                    Decode.fail e
        )
        Decode.string


fromString : String -> Result String Lang
fromString s =
    case s of
        "FR" ->
            Ok FR

        "EN" ->
            Ok EN

        _ ->
            Err "invalid language"


toString : Lang -> String
toString l =
    case l of
        FR ->
            "FR"

        EN ->
            "EN"
