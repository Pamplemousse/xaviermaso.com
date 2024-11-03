module Projects.Views exposing (renderCurrent)

import Colours exposing (Colour, toStringLight)
import Html exposing (Html, div, h1, h3, h4, i, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Html.Parser
import Html.Parser.Util
import Link
import Projects.Models exposing (Project)
import TiledList exposing (Msg(..))


renderCurrent : Colour -> Project -> Html (Msg Project)
renderCurrent colour project =
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
            [ div [ class ("list-component-description " ++ toStringLight colour) ]
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
