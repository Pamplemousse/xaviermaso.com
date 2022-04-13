module SocialMedia.View exposing (view)

import Html exposing (Html, a, div, i)
import Html.Attributes exposing (alt, class, href, rel, target)
import Messages exposing (..)
import Models exposing (Model)
import SocialMedia.Models exposing (SocialMedium)


formatSocialLogo : SocialMedium -> Html Msg
formatSocialLogo socialMedium =
    a [ href socialMedium.hrefTarget, rel "noreferrer", target "_blank" ]
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
