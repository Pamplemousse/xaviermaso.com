module Projects.View exposing (currentProjectView, view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import HttpErrorWrapper exposing (buildErrorMessage)
import Projects.List exposing (view)
import Projects.Messages exposing (Msg)
import Projects.Models exposing (Model, Project)
import Projects.Show exposing (view)
import RemoteData


view : Model -> Html Msg
view { all, current } =
    case all of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success ps ->
            div []
                [ div [ class "projects-header" ] [ text "Sometimes I like to spend time and energy working on tech-related things. Here some of the most notable, if not glorious, not-solely-professional ventures I have or had going." ]
                , currentProjectView current
                , Projects.List.view ps
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
