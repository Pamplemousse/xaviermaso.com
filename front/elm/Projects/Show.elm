module Projects.Show exposing (view)

import Html exposing (Html, div, h1, h3, h4, i, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Html.Parser exposing (run)
import Html.Parser.Util exposing (toVirtualDom)
import Link
import Projects.Messages exposing (Msg(..))
import Projects.Models exposing (Project)


view : Project -> Html Msg
view project =
    let
        descriptionNode =
            case project.description of
                Just description ->
                    case Html.Parser.run description of
                        Ok parsedNodes ->
                            Html.Parser.Util.toVirtualDom parsedNodes

                        _ ->
                            []

                Nothing ->
                    []
    in
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ div [ class "project-description lightGreen" ]
                [ h1 [] [ text project.title ]
                , h3
                    [ class "date" ]
                    [ text project.dates ]
                , h4 [] [ text project.tags ]
                , div [ class "row" ]
                    [ div
                        [ class "col-md-12 textDesc" ]
                        descriptionNode
                    ]
                , div [] (project.links |> List.map (Link.view >> Html.map LinkMsg))
                , i
                    [ class "fa fa-close fa-2x close"
                    , onClick (CloseDescriptionOf project)
                    ]
                    []
                ]
            ]
        ]
