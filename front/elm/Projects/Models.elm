module Projects.Models exposing (Link, Project, ProjectId, ProjectsUrl)


type alias ProjectId =
    Int


type alias ProjectsUrl =
    String


type alias Link =
    { target : String
    , value : Maybe String
    }


type alias Project =
    { id : ProjectId
    , tileContent : String
    , title : String
    , dates : String
    , tags : String
    , links : List Link
    , description : Maybe String
    }
