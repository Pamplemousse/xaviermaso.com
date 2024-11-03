module Projects.Models exposing (Project, Url)

import Link


type alias Id =
    Int


type alias Url =
    String


type alias Project =
    { id : Id
    , title : String
    , dates : String
    , tags : String
    , links : List Link.Model
    , description : Maybe String
    }
