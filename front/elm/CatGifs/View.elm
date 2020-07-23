module CatGifs.View exposing (view)

import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Http
import Messages exposing (..)
import Models exposing (Model)
import RemoteData exposing (WebData)


view : Model -> Html Msg
view model =
    case model.currentCatGif of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success catGif ->
            div [ class "row" ]
                [ div [ class "col-md-4 col-md-offset-4" ]
                    [ img [ src catGif.gifUrl ] []
                    ]
                ]

        RemoteData.Failure error ->
            text (Debug.toString error)
