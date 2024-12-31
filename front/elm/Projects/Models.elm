module Projects.Models exposing (Project, projectsDefaultUrl)

import Link
import TiledList exposing (Id)
import Url exposing (Protocol(..), Url)


type alias Project =
    { id : Id
    , title : String
    , dates : String
    , tags : String
    , links : List Link.Model
    , description : Maybe String
    }


projectsDefaultUrl : Url
projectsDefaultUrl =
    Url Https "www.xaviermaso.com" Nothing "api/projects" Nothing Nothing
