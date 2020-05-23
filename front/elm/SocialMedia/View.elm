module SocialMedia.View exposing (view)

import Html exposing (Html, a, div, i)
import Html.Attributes exposing (alt, class, href, target)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Models exposing (Model)
import SocialMedia.Models exposing (SocialMedium)


formatSocialLogo : SocialMedium -> Html Msg
formatSocialLogo socialMedium =
    let
        attribute =
            case socialMedium.clickAction of
                Just action ->
                    onClick action

                _ ->
                    target "_blank"
    in
    a [ href socialMedium.hrefTarget, attribute ]
        [ i [ class ("fa social-icon " ++ socialMedium.imageClass), alt socialMedium.altText ] []
        ]


view : Model -> Html Msg
view model =
    div [ class "row top-line" ]
        [ div [ class "col-md-8" ]
            [ div [ class "col-md-8" ]
                [ div [ class "row social" ]
                    (List.map formatSocialLogo model.socialMedia)
                ]
            ]
        ]
