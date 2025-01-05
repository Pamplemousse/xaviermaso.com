module Models exposing (Flags, Model, initialModel)

import Browser.Navigation exposing (Key)
import CatGifs.Models exposing (CatGif)
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)
import Routing exposing (Route)
import SocialMedia.Models exposing (SocialMedium)
import Talks.Models exposing (Talk)
import TiledList
import Url exposing (Url)
import Url.Parser


type alias Model =
    { socialMedia : List SocialMedium
    , catGifsUrl : Url
    , currentCatGif : WebData CatGif
    , key : Key
    , route : Maybe Route
    , projects : TiledList.Model Project
    , talks : TiledList.Model Talk
    }


type alias Flags =
    { projectsUrl : String
    , talksUrl : String
    , catGifsUrl : String
    }


initialModel : Key -> Url -> Url -> Model
initialModel key url catGifsUrl =
    let
        route =
            Url.Parser.parse Routing.routeParser url

        projects =
            TiledList.initialModel

        currentProject =
            case route of
                Just (Routing.ProjectsRoute id) ->
                    id

                _ ->
                    Nothing

        talks =
            TiledList.initialModel

        currentTalk =
            case route of
                Just (Routing.TalksRoute id) ->
                    id

                _ ->
                    Nothing
    in
    { catGifsUrl = catGifsUrl
    , currentCatGif = RemoteData.Loading
    , socialMedia = SocialMedia.Models.initialSocialMedia
    , key = key
    , route = route
    , projects = { projects | idCurrent = currentProject }
    , talks = { talks | idCurrent = currentTalk }
    }
