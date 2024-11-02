module Link exposing (Model, Msg(..), decoder, view)

{-| This represent a link to an external resource used as a reference.
-}

import Html exposing (..)
import Html.Attributes exposing (href, rel, target)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)


type alias Model =
    { target : String
    , value : Maybe String
    }


type Msg
    = Msg Never


decoder : Decode.Decoder Model
decoder =
    Decode.succeed Model
        |> required "target" Decode.string
        |> optional "value" (Decode.map Just Decode.string) Nothing


view : Model -> Html Msg
view link =
    let
        link_value =
            case link.value of
                Nothing ->
                    link.target

                Just value ->
                    value
    in
    h3 []
        [ a [ href link.target, rel "noreferrer", target "_blank" ] [ text link_value ]
        ]
