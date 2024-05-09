module View exposing (view)

import Browser exposing (Document)
import CatGifs.View exposing (..)
import Html exposing (Html, a, br, button, div, h6, i, object, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import HttpErrorWrapper exposing (buildErrorMessage)
import Messages exposing (..)
import Models exposing (Model)
import Projects.View exposing (..)
import Routing exposing (blogPath, cvPath, meowPath, projectsPath, rootPath)
import SocialMedia.View exposing (view)


view : Model -> Browser.Document Msg
view model =
    let
        layoutify =
            layout model
    in
    case model.route of
        Just route ->
            case route of
                Routing.MainRoute ->
                    { title = "XM | Main"
                    , body = [ layoutify mainView ]
                    }

                Routing.CVRoute ->
                    { title = "XM | CV"
                    , body = [ layoutify cvView ]
                    }

                Routing.MeowRoute ->
                    { title = "XM | Meow"
                    , body = [ layoutify (meowView model) ]
                    }

                Routing.ProjectsRoute ->
                    { title = "XM | Projects"
                    , body = [ layoutify (projectsView model) ]
                    }

        Nothing ->
            { title = "XM | 404"
            , body = [ layoutify notFoundView ]
            }


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]


projectsView : Model -> Html Msg
projectsView model =
    div []
        [ Projects.View.view model.projects model.currentProjects
        ]


meowView : Model -> Html Msg
meowView model =
    div []
        [ CatGifs.View.view model.currentCatGif
        ]


cvView : Html Msg
cvView =
    div [ class "row" ]
        [ object
            [ class "col-md-12"
            , attribute "type" "application/pdf"
            , attribute "data" "xaviermaso.pdf"
            , style "height" "80em"
            ]
            [ div [ class "message lightOrange" ]
                [ br [] []
                , div [] [ text "Oops !" ]
                , br [] []
                , br [] []
                , div [] [ text "The necessary plug-in seems to be missing." ]
                , br [] []
                , br [] []
                , a [ href "xaviermaso.pdf" ] [ text "Download the CV in PDF format." ]
                ]
            ]
        ]


mainView : Html Msg
mainView =
    div [ class "row" ]
        [ div [ class "col-md-4" ]
            [ button [ class "tile blue", onClick (RedirectTo blogPath) ] [ text "Blog" ]
            ]
        , div [ class "col-md-4" ]
            [ button [ class "tile green", onClick (NavigateTo projectsPath) ] [ text "Projects" ]
            ]
        , div [ class "col-md-4" ]
            [ button [ class "tile orange", onClick (NavigateTo cvPath) ] [ text "CV" ]
            ]
        ]


formatTextLine : String -> Html Msg
formatTextLine textline =
    div [ class "row textline" ]
        [ text textline ]


nameLine : Html Msg
nameLine =
    div [ class "row" ]
        [ div [ class "name text-end", onClick (NavigateTo rootPath) ]
            [ text "Xavier Maso" ]
        ]


footer : Html Msg
footer =
    div [ class "row footer" ]
        [ div [ class "col-md-2 offset-md-10" ]
            [ div [ class "section" ]
                [ h6 [ onClick (NavigateTo meowPath) ]
                    [ text "Such reserved rights." ]
                ]
            ]
        ]


layout : Model -> Html Msg -> Html Msg
layout model content =
    div [ class "container" ]
        [ nameLine
        , SocialMedia.View.view model
        , content
        , footer
        ]
