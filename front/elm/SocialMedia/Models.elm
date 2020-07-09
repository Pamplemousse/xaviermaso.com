module SocialMedia.Models exposing (SocialMedium, initialSocialMedia)

import Messages exposing (Msg(..))


type alias SocialMedium =
    { altText : String
    , hrefTarget : String
    , imageClass : String
    }


initialSocialMedia : List SocialMedium
initialSocialMedia =
    [ { hrefTarget = "mailto:xavier.maso@net-c.com"
      , imageClass = "fa-envelope-o"
      , altText = "Email image link mailing to xavier.maso@net-c.com ."
      }
    , { hrefTarget = "https://mamot.fr/@Pamplemouss_"
      , imageClass = "fa-mastodon"
      , altText = "Mastodon image link for @Pamplemouss_."
      }
    , { hrefTarget = "https://twitter.com/Pamplemouss_"
      , imageClass = "fa-twitter"
      , altText = "Twitter image link for @Pamplemouss_."
      }
    , { hrefTarget = "https://github.com/Pamplemousse"
      , imageClass = "fa-github"
      , altText = "Github image link for Pamplemousse's account."
      }
    , { hrefTarget = "https://www.linkedin.com/pub/xavier-maso/39/4a/96b"
      , imageClass = "fa-linkedin"
      , altText = "Linkedin image link for Xavier Maso's linkedin profile."
      }
    ]
