module Colours exposing (Colour(..), toString, toStringLight)


type Colour
    = Blue
    | Green
    | Magenta
    | Orange


toString : Colour -> String
toString c =
    case c of
        Blue ->
            "blue"

        Green ->
            "green"

        Magenta ->
            "magenta"

        Orange ->
            "orange"


toStringLight : Colour -> String
toStringLight c =
    case c of
        Blue ->
            "lightBlue"

        Green ->
            "lightGreen"

        Magenta ->
            "lightMagenta"

        Orange ->
            "lightOrange"
