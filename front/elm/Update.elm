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
import Url.Parser


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
                    Url.Parser.parse routeParser url

                newModel =
                    { model | route = route }
            in
            case route of
                Just MeowRoute ->
                    ( newModel
                    , fetchCatGif model.catGifsUrl
                    )

                Just (ProjectsRoute r) ->
                    TiledList.update (TiledList.UrlChanged r) model.projects
                        |> mapBoth (\ps -> { newModel | projects = ps }) (Cmd.map ProjectsMsg)

                Just (TalksRoute r) ->
                    TiledList.update (TiledList.UrlChanged r) model.talks
                        |> mapBoth (\ts -> { newModel | talks = ts }) (Cmd.map TalksMsg)

                _ ->
                    ( newModel
                    , Cmd.none
                    )

        Messages.OnFetchCatGif response ->
            ( { model | currentCatGif = response }
            , Cmd.none
            )

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
