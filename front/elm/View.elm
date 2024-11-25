module View exposing (view)

import Browser exposing (Document)
import CatGifs.View exposing (..)
import Colours exposing (Colour(..))
import Html exposing (Html, a, br, button, div, h6, object, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Projects.Views
import Routing exposing (blogPath, cvPath, meowPath, projectsPath, rootPath, talksPath)
import SocialMedia.View exposing (view)
import Talks.Views
import TiledList


view : Model -> Document Msg
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

                Routing.TalksRoute ->
                    { title = "XM | Talks"
                    , body = [ layoutify (talksView model) ]
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
        [ div [ class "list-component-header" ]
            [ text "Sometimes I like to spend time and energy working on tech-related things. Here some of the most notable, if not glorious, not-solely-professional ventures I have or had going." ]
        , Html.map ProjectsMsg
            (TiledList.view
                model.projects
                3
                Projects.Views.renderCurrent
                Green
            )
        ]


meowView : Model -> Html Msg
meowView model =
    div []
        [ CatGifs.View.view model.currentCatGif
        ]


talksView : Model -> Html Msg
talksView model =
    div []
        [ div [ class "list-component-header" ]
            [ text "As a firm believer in education for everyone, at all times, I sometimes give presentations where I share knowledge and communicate feedback about things I have explored." ]
        , Html.map TalksMsg
            (TiledList.view
                model.talks
                2
                Talks.Views.renderCurrent
                Magenta
            )
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
            [ div [ class ("message " ++ Colours.toStringLight Orange) ]
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
        (List.map
            (\( colour, action, text_ ) ->
                div [ class "col-md-3" ]
                    [ button [ class ("tile " ++ Colours.toString colour), onClick action ] [ text text_ ]
                    ]
            )
            [ ( Blue, RedirectTo blogPath, "Blog" )
            , ( Green, NavigateTo projectsPath, "Projects" )
            , ( Orange, NavigateTo cvPath, "CV" )
            , ( Magenta, NavigateTo talksPath, "Talks" )
            ]
        )


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
