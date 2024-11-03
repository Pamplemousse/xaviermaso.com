module Colours exposing (Colour(..), toString, toStringLight)


type Colour
    = Blue
    | Green
    | Orange


toString : Colour -> String
toString c =
    case c of
        Blue ->
            "blue"

        Green ->
            "green"

        Orange ->
            "orange"


toStringLight : Colour -> String
toStringLight c =
    case c of
        Blue ->
            "lightBlue"

        Green ->
            "lightGreen"

        Orange ->
            "lightOrange"
