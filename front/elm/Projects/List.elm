module Projects.List exposing (..)

import Messages exposing (..)
import Projects.Models exposing (Project)
import Projects.Show exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import RemoteData exposing (WebData)


view : WebData (List Project) -> Html Msg
view response =
    div []
        [ maybeList response
        ]


maybeList : WebData (List Project) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success projects ->
            list projects

        RemoteData.Failure error ->
            text (toString error)


list : List Project -> Html Msg
list projects =
    div [ class "row" ] (List.indexedMap projectTile projects)



projectTile : Int -> Project -> Html Msg
projectTile index project =
    let
        color =
            if (index % 2 == 0) then "green" else "lightGreen"
    in
        div [ class "col-md-4", onClick (ShowDescriptionOf project.id) ] [
            button [ class ("tile-project " ++ color) ] [ text project.tileContent ]
            ]