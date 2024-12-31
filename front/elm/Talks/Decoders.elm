module Talks.Decoders exposing (decoder)

import Decoders exposing (decodeDate)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)
import Lang
import Link
import Talks.Models exposing (Conference, Talk)
import TiledList exposing (idDecoder)


decoder : Decode.Decoder (List Talk)
decoder =
    Decode.list talkDecoder


talkDecoder : Decode.Decoder Talk
talkDecoder =
    Decode.succeed Talk
        |> required "id" idDecoder
        |> required "title" Decode.string
        |> required "description" Decode.string
        |> required "conferences" (Decode.list conferenceDecoder)


conferenceDecoder : Decode.Decoder Conference
conferenceDecoder =
    Decode.succeed Conference
        |> required "organisation" Decode.string
        |> required "date" decodeDate
        |> required "duration" Decode.int
        |> required "lang" Lang.decoder
        |> optional "recording" (Decode.map Just (Link.decoderWithDefaultValue "📺 recording")) Nothing
        |> optional "slides" (Decode.map Just (Link.decoderWithDefaultValue "📜 slides")) Nothing
        |> optional "sources" (Decode.map Just (Link.decoderWithDefaultValue "🧑\u{200D}💻 sources")) Nothing
