module Projects.List exposing (projectTile, view)

import Colours exposing (Colour(..))
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Projects.Messages exposing (..)
import Projects.Models exposing (Project)


view : List Project -> Html Msg
view projects =
    div [ class "row" ] (List.indexedMap projectTile projects)


projectTile : Int -> Project -> Html Msg
projectTile index project =
    let
        color =
            if modBy 2 index == 0 then
                Colours.toString Green

            else
                Colours.toStringLight Green
    in
    div [ class "col-md-4", onClick (ShowDescriptionOf project) ]
        [ button [ class ("tile-project " ++ color) ] [ (project.title |> String.toLower |> text) ]
        ]
