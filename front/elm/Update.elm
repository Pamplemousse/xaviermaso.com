module Update exposing (update)

import Browser
import Browser.Navigation exposing (load, pushUrl)
import CatGifs.Commands exposing (fetchCatGif)
import Messages exposing (Msg(..))
import Models exposing (..)
import Routing exposing (Route(..), routeParser)
import TiledList
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
                    { m | idCurrent = Nothing }

                voidedModel =
                    { model
                        | projects = voidCurrent model.projects
                        , talks = voidCurrent model.talks
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
            TiledList.update pMsg model.projects
                |> mapBoth
                    ((\m ps -> { m | projects = ps }) model)
                    (Cmd.map ProjectsMsg)

        TalksMsg tMsg ->
            TiledList.update tMsg model.talks
                |> mapBoth
                    ((\m ts -> { m | talks = ts }) model)
                    (Cmd.map TalksMsg)
