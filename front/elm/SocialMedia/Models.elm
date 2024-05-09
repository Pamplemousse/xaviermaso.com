module SocialMedia.Models exposing (SocialMedium, initialSocialMedia)

import Messages exposing (Msg(..))


type alias SocialMedium =
    { altText : String
    , hrefTarget : String
    , imageClass : String
    }


initialSocialMedia : List SocialMedium
initialSocialMedia =
    [ { hrefTarget = "mailto:contact@xaviermaso.com"
      , imageClass = "fa-envelope-o"
      , altText = "Email image link mailing to contact@xaviermaso.com."
      }
    , { hrefTarget = "https://matrix.to/#/@pamplemouss_:matrix.org"
      , imageClass = "fa-matrix-org"
      , altText = "Matrix image link for Xavier Maso's matrix profile."
      }
    , { hrefTarget = "https://mamot.fr/@Pamplemouss_"
      , imageClass = "fa-mastodon"
      , altText = "Mastodon image link for @Pamplemouss_."
      }
    , { hrefTarget = "https://stackexchange.com/users/2615988/pamplemouss?tab=accounts"
      , imageClass = "fa-stack-overflow"
      , altText = "Stack Overflow image link for Xavier Maso's Stack Exchange profile."
      }
    , { hrefTarget = "https://github.com/Pamplemousse"
      , imageClass = "fa-github"
      , altText = "Github image link for Pamplemousse's account."
      }
    , { hrefTarget = "https://www.linkedin.com/in/%F0%9F%8D%8A-xavier-maso-96b04a39/"
      , imageClass = "fa-linkedin"
      , altText = "Linkedin image link for Xavier Maso's linkedin profile."
      }
    ]
