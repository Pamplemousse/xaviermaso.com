module Main exposing (initialState, main, subscriptions)

import Browser exposing (application)
import Browser.Navigation exposing (Key)
import CatGifs.Models exposing (catGifDefaultUrl)
import Commands exposing (fetchData)
import Decoders exposing (decodeUrl)
import Json.Decode exposing (decodeString)
import Messages exposing (Msg(..))
import Models exposing (Flags, Model, initialModel)
import Projects.Models exposing (projectsDefaultUrl)
import Update exposing (update)
import Url exposing (Protocol(..), Url)
import View exposing (view)


initialState : Flags -> Url -> Key -> ( Model, Cmd Msg )
initialState flags url key =
    let
        wrap v =
            [ "\"", v, "\"" ] |> String.concat

        toUrl : Url -> String -> Url
        toUrl default =
            wrap >> decodeString decodeUrl >> Result.map (Maybe.withDefault default) >> Result.withDefault default

        catGifUrl =
            flags.catGifsUrl |> toUrl catGifDefaultUrl

        projectsUrl =
            flags.projectsUrl |> toUrl projectsDefaultUrl
    in
    ( initialModel key url catGifUrl
    , fetchData projectsUrl catGifUrl
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program Flags Model Msg
main =
    application
        { init = initialState
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
