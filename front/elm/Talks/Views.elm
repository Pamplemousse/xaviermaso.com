module Talks.Views exposing (renderCurrent)

import Colours exposing (Colour, toStringLight)
import Date exposing (format, year)
import Html exposing (Html, a, br, div, h1, h3, i, li, span, text, ul)
import Html.Attributes exposing (class, href)
import Html.Extra exposing (viewMaybe)
import Lang
import Link
import Talks.Models exposing (Conference, Talk)
import Talks.Routing exposing (path)
import TiledList exposing (Msg(..))


renderCurrent : Colour -> Talk -> Html (Msg Talk)
renderCurrent colour talk =
    let
        allYears =
            talk.conferences |> List.map (\c -> c.date |> year)

        yearMin =
            allYears |> List.minimum

        yearMax =
            allYears |> List.maximum

        dates =
            case ( yearMin, yearMax ) of
                ( Just min, Just max ) ->
                    Just
                        (case min == max of
                            True ->
                                String.fromInt max

                            False ->
                                String.fromInt min ++ "-" ++ String.fromInt max
                        )

                _ ->
                    Nothing

        displayDates =
            dates |> viewMaybe (\ds -> h3 [ class "date" ] [ text ds ])
    in
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ div [ class ("list-component-description " ++ toStringLight colour) ]
                [ h1 [] [ text talk.title ]
                , displayDates
                , div [ class "row" ]
                    [ div
                        [ class "col-md-12 textDesc" ]
                        [ text talk.description ]
                    ]
                , renderConferences talk.conferences
                , a [ href ("/" ++ path) ]
                    [ i [ class "fa fa-close fa-2x close" ]
                        []
                    ]
                ]
            ]
        ]


renderConferences : List Conference -> Html (Msg Talk)
renderConferences conferences =
    if List.isEmpty conferences then
        div [] []

    else
        div []
            [ br [] []
            , div [ class "textDesc" ] [ text "Presented at the following venues:" ]
            , conferences |> List.sortWith (\x -> \y -> Date.compare x.date y.date) |> List.reverse |> List.map renderConference |> ul [ class "list-group list-group-flush" ]
            ]


renderConference : Conference -> Html (Msg Talk)
renderConference c =
    let
        date =
            c.date |> format "MMMM y"

        recording =
            c.recording |> viewMaybe (Link.view >> Html.map LinkMsg >> (\s -> div [] [ s, span [ class "textDesc" ] [ text (" (" ++ (c.duration |> String.fromInt) ++ "min)") ] ]))

        slides =
            c.slides |> viewMaybe (Link.view >> Html.map LinkMsg)

        sources =
            c.sources |> viewMaybe (Link.view >> Html.map LinkMsg)
    in
    li [ class "list-group-item" ]
        [ div [ class "me-auto" ]
            [ div [ class "row" ]
                [ div [ class "col-md-2 textDesc" ] [ text date ]
                , div [ class "col-md-3 textDesc" ] [ text ("[" ++ (c.lang |> Lang.toString) ++ "] " ++ c.organisation) ]
                , div [ class "col-md-2" ] [ sources ]
                , div [ class "col-md-2" ] [ slides ]
                , div [ class "col-md-3" ] [ recording ]
                ]
            ]
        ]
