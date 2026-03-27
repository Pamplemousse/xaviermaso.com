module SocialMedia.Models exposing (SocialMedium, initialSocialMedia)

import Messages exposing (Msg(..))


type alias SocialMedium =
    { altText : String
    , hrefTarget : String
    , imageClass : String
    , label : String
    }


initialSocialMedia : List SocialMedium
initialSocialMedia =
    [ { hrefTarget = "mailto:contact@xaviermaso.com"
      , imageClass = "fa-envelope-o"
      , altText = "Email image link mailing to contact@xaviermaso.com."
      , label = "Send me an email"
      }
    , { hrefTarget = "https://matrix.to/#/@pamplemouss_:matrix.org"
      , imageClass = "fa-matrix-org"
      , altText = "Matrix image link for Xavier Maso's matrix profile."
      , label = "Contact me on Matrix"
      }
    , { hrefTarget = "https://mamot.fr/@Pamplemouss_"
      , imageClass = "fa-mastodon"
      , altText = "Mastodon image link for @Pamplemouss_."
      , label = "Follow me on Mastodon"
      }
    , { hrefTarget = "https://github.com/Pamplemousse"
      , imageClass = "fa-github"
      , altText = "Github image link for Pamplemousse's account."
      , label = "Follow me on Github"
      }
    , { hrefTarget = "https://www.linkedin.com/in/%F0%9F%8D%8A-xavier-maso-96b04a39/"
      , imageClass = "fa-linkedin"
      , altText = "Linkedin image link for Xavier Maso's linkedin profile."
      , label = "See my profile on LinkdIn"
      }
    ]
