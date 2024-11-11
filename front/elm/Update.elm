module Update exposing (update)

import Browser
import Browser.Navigation exposing (load, pushUrl)
import CatGifs.Commands exposing (fetchCatGif)
import Messages exposing (Msg(..))
import Models exposing (..)
import Projects.Messages exposing (Msg(..))
import Projects.Update
import Routing exposing (Route(..), routeParser)
import Tuple exposing (mapBoth)
import Url
import Url.Parser exposing (parse)


update : Messages.Msg -> Model -> ( Model, Cmd Messages.Msg )
update msg model =
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
            let
                route =
                    Url.Parser.parse Routing.routeParser url

                command =
                    case route of
                        Just MeowRoute ->
                            fetchCatGif model.catGifsUrl

                        _ ->
                            Cmd.none

                voidCurrent m =
                    { m | current = Nothing }

                voidedModel =
                    { model
                        | projects = voidCurrent model.projects
                    }
            in
            ( { voidedModel | route = route }
            , command
            )

        Messages.OnFetchCatGif response ->
            ( { model | currentCatGif = response }
            , Cmd.none
            )

        NavigateTo path ->
            let
                command =
                    pushUrl model.key path
            in
            ( model, command )

        ProjectsMsg pMsg ->
            Projects.Update.update pMsg model.projects
                |> mapBoth
                    ((\m ps -> { m | projects = ps }) model)
                    (Cmd.map ProjectsMsg)

        RedirectTo path ->
            let
                command =
                    load path
            in
            ( model, command )
