module Projects.Decoders exposing (decoder)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)
import Link
import Prng.Uuid as Uuid
import Projects.Models exposing (Project)
import TiledList exposing (idDecoder)


decoder : Decode.Decoder (List Project)
decoder =
    Decode.list projectDecoder


projectDecoder : Decode.Decoder Project
projectDecoder =
    Decode.succeed Project
        |> required "id" idDecoder
        |> required "title" Decode.string
        |> required "dates" Decode.string
        |> required "tags" Decode.string
        |> optional "links" (Decode.list Link.decoder) []
        |> optional "description" (Decode.map Just Decode.string) Nothing
