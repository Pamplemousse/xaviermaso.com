module Models exposing (Flags, Model, initialModel)

import Browser.Navigation exposing (Key)
import CatGifs.Models exposing (..)
import Projects.Models exposing (..)
import RemoteData exposing (WebData)
import Routing exposing (Route)
import SocialMedia.Models exposing (SocialMedium, initialSocialMedia)
import Url exposing (Url)
import Url.Parser exposing (parse)


type alias Model =
    { projects : WebData (List Project)
    , socialMedia : List SocialMedium
    , catGifsUrl : String
    , currentCatGif : WebData CatGif
    , currentProjects : ( Maybe Project, Maybe Project )
    , key : Browser.Navigation.Key
    , route : Maybe Route
    }


type alias Flags =
    { projectsUrl : ProjectsUrl
    , catGifsUrl : CatGifsUrl
    }


initialModel : Browser.Navigation.Key -> Url -> String -> Model
initialModel key url catGifsUrl =
    { projects = RemoteData.Loading
    , catGifsUrl = catGifsUrl
    , currentCatGif = RemoteData.Loading
    , socialMedia = SocialMedia.Models.initialSocialMedia
    , currentProjects = ( Nothing, Nothing )
    , key = key
    , route = Url.Parser.parse Routing.routeParser url
    }
