module Update exposing (update)

import Browser
import Browser.Navigation exposing (load, pushUrl)
import Messages exposing (..)
import Models exposing (..)
import Routing exposing (routeParser)
import Url exposing (Url)
import Url.Parser exposing (parse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ( currentSeriousProject, currentHack ) =
            model.currentProjects
    in
    case msg of
        LinkClicked urlRequest ->
            let
                command =
                    case urlRequest of
                        Browser.Internal url ->
                            pushUrl model.key (Url.toString url)

                        Browser.External href ->
                            load href
            in
            ( model, command )

        UrlChanged url ->
            ( { model | route = Url.Parser.parse Routing.routeParser url }
            , Cmd.none
            )

        Messages.OnFetchProjects response ->
            ( { model | projects = response }
            , Cmd.none
            )

        NavigateTo path ->
            let
                command =
                    pushUrl model.key path
            in
            ( model, command )

        RedirectTo path ->
            let
                command =
                    load path
            in
            ( model, command )

        ShowDescriptionOf project ->
            case project.seriousness of
                Just "hack" ->
                    ( { model | currentProjects = ( currentSeriousProject, Just project ) }
                    , Cmd.none
                    )

                _ ->
                    ( { model | currentProjects = ( Just project, currentHack ) }
                    , Cmd.none
                    )

        CloseProjectDescription project ->
            case project.seriousness of
                Just "hack" ->
                    ( { model | currentProjects = ( currentSeriousProject, Nothing ) }
                    , Cmd.none
                    )

                _ ->
                    ( { model | currentProjects = ( Nothing, currentHack ) }
                    , Cmd.none
                    )
