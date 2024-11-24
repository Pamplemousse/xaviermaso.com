module Models exposing (Flags, Model, initialModel)

import Browser.Navigation exposing (Key)
import CatGifs.Models exposing (CatGif)
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)
import Routing exposing (Route)
import SocialMedia.Models exposing (SocialMedium, initialSocialMedia)
import TiledList
import Url exposing (Url)
import Url.Parser exposing (parse)


type alias Model =
    { socialMedia : List SocialMedium
    , catGifsUrl : Url
    , currentCatGif : WebData CatGif
    , key : Key
    , route : Maybe Route
    , projects : TiledList.Model Project
    }


type alias Flags =
    { projectsUrl : String
    , catGifsUrl : String
    }


initialModel : Key -> Url -> Url -> Model
initialModel key url catGifsUrl =
    { catGifsUrl = catGifsUrl
    , currentCatGif = RemoteData.Loading
    , socialMedia = SocialMedia.Models.initialSocialMedia
    , key = key
    , route = Url.Parser.parse Routing.routeParser url
    , projects = TiledList.initialModel
    }
