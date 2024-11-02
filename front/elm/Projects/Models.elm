module Projects.Models exposing (Id, Model, Project, Url, initialModel)

import Link
import RemoteData exposing (WebData)


type alias Id =
    Int


type alias Url =
    String


type alias Project =
    { id : Id
    , tileContent : String
    , title : String
    , dates : String
    , tags : String
    , links : List Link.Model
    , description : Maybe String
    }


type alias Model =
    { current : Maybe Project
    , all : WebData (List Project)
    }


initialModel : Model
initialModel =
    { all = RemoteData.Loading
    , current = Nothing
    }
