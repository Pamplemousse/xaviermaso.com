module CatGifs.View exposing (view)

import CatGifs.Models exposing (CatGif)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import HttpErrorWrapper exposing (buildErrorMessage)
import Messages exposing (Msg)
import RemoteData exposing (WebData)


view : WebData CatGif -> Html Msg
view currentCatGif =
    case currentCatGif of
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
            text (buildErrorMessage error)
