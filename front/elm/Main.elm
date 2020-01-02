module Main exposing (initialState, main, subscriptions)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Commands exposing (fetchData)
import Messages exposing (Msg(..))
import Models exposing (Flags, Model, initialModel)
import Routing exposing (Route)
import Update exposing (update)
import Url exposing (Url)
import Url.Parser exposing (parse)
import View exposing (view)


initialState : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
initialState flags url key =
    ( initialModel key url flags.catGifsUrl, fetchData flags.projectsUrl flags.catGifsUrl )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Flags Model Msg
main =
    Browser.application
        { init = initialState
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
