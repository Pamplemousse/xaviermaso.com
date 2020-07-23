module Projects.View exposing (currentProjectView, view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import HttpErrorWrapper exposing (buildErrorMessage)
import List exposing (filter)
import Messages exposing (..)
import Models exposing (Model)
import Projects.List exposing (view)
import Projects.Models exposing (Project)
import Projects.Show exposing (view)
import RemoteData exposing (WebData)
import Tuple exposing (first, second)


view : Model -> Html Msg
view model =
    case model.projects of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success projects ->
            let
                seriousProjects =
                    filter (\project -> project.seriousness /= Just "hack") projects

                hacks =
                    filter (\project -> project.seriousness == Just "hack") projects
            in
            div []
                [ div [ class "projects-header" ] [ text "serious stuff" ]
                , currentProjectView (first model.currentProjects)
                , Projects.List.view seriousProjects
                , div [ class "projects-header" ] [ text "less serious stuff" ]
                , currentProjectView (second model.currentProjects)
                , Projects.List.view hacks
                ]

        RemoteData.Failure error ->
            text (buildErrorMessage error)


currentProjectView : Maybe Project -> Html Msg
currentProjectView maybeProject =
    case maybeProject of
        Just project ->
            div []
                [ Projects.Show.view project
                ]

        Nothing ->
            text ""
