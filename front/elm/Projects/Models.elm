module Projects.Models exposing (Id, Link, Model, Project, Url, initialModel)

import RemoteData exposing (WebData)


type alias Id =
    Int


type alias Url =
    String


type alias Link =
    { target : String
    , value : Maybe String
    }


type alias Project =
    { id : Id
    , tileContent : String
    , title : String
    , dates : String
    , tags : String
    , links : List Link
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
