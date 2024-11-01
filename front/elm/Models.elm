module Models exposing (Flags, Model, initialModel)

import Browser.Navigation exposing (Key)
import CatGifs.Models exposing (..)
import Projects.Models
import RemoteData exposing (WebData)
import Routing exposing (Route)
import SocialMedia.Models exposing (SocialMedium, initialSocialMedia)
import Url exposing (Url)
import Url.Parser exposing (parse)


type alias Model =
    { socialMedia : List SocialMedium
    , catGifsUrl : String
    , currentCatGif : WebData CatGif
    , key : Browser.Navigation.Key
    , route : Maybe Route
    , projects : Projects.Models.Model
    }


type alias Flags =
    { projectsUrl : Projects.Models.Url
    , catGifsUrl : CatGifsUrl
    }


initialModel : Browser.Navigation.Key -> Url -> String -> Model
initialModel key url catGifsUrl =
    { catGifsUrl = catGifsUrl
    , currentCatGif = RemoteData.Loading
    , socialMedia = SocialMedia.Models.initialSocialMedia
    , key = key
    , route = Url.Parser.parse Routing.routeParser url
    , projects = Projects.Models.initialModel
    }
