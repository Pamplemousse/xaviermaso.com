module Projects.Commands exposing (fetchProjects, linkDecoder, projectDecoder, projectsDecoder)

import Http exposing (expectJson)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)
import Messages exposing (Msg)
import Projects.Models exposing (Link, Project, ProjectId, ProjectsUrl)
import RemoteData


fetchProjects : ProjectsUrl -> Cmd Msg
fetchProjects url =
    Http.get
        { url = url
        , expect = expectJson (RemoteData.fromResult >> Messages.OnFetchProjects) projectsDecoder
        }


projectsDecoder : Decode.Decoder (List Project)
projectsDecoder =
    Decode.list projectDecoder


projectDecoder : Decode.Decoder Project
projectDecoder =
    Decode.succeed Project
        |> required "id" Decode.int
        |> required "tileContent" Decode.string
        |> required "title" Decode.string
        |> required "dates" Decode.string
        |> required "tags" Decode.string
        |> optional "links" (Decode.list linkDecoder) []
        |> optional "description" (Decode.map Just Decode.string) Nothing


linkDecoder : Decode.Decoder Link
linkDecoder =
    Decode.succeed Link
        |> required "target" Decode.string
        |> optional "value" (Decode.map Just Decode.string) Nothing
