module Main exposing (initialState, main, subscriptions)

import Browser exposing (application)
import Browser.Navigation exposing (Key)
import Commands exposing (fetchData)
import Messages exposing (Msg(..))
import Models exposing (Flags, Model, initialModel)
import Update exposing (update)
import Url exposing (Url)
import View exposing (view)


initialState : Flags -> Url -> Key -> ( Model, Cmd Msg )
initialState flags url key =
    ( initialModel key url flags.catGifsUrl, fetchData flags.projectsUrl flags.catGifsUrl )


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
