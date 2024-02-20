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


view : WebData (List Project) -> ( Maybe Project, Maybe Project ) -> Html Msg
view receivedProjects currentProjects =
    case receivedProjects of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success projects ->
            div []
                [ div [ class "projects-header" ] [ text "Sometimes I like to spend time and energy working on tech-related things. Here some of the most notable, if not glorious, not-solely-professional ventures I have or had going." ]
                , currentProjectView (first currentProjects)
                , Projects.List.view projects
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
