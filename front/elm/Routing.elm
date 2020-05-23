module Routing exposing (Route(..), blogPath, cvPath, meowPath, projectsPath, rootPath, routeParser)

import Browser.Navigation exposing (Key)
import Url.Parser exposing (..)


type Route
    = MainRoute
    | CVRoute
    | MeowRoute
    | ProjectsRoute


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map MainRoute top
        , map CVRoute (s cvPath)
        , map MeowRoute (s meowPath)
        , map ProjectsRoute (s projectsPath)
        ]


blogPath : String
blogPath =
    "https://blog.xaviermaso.com"


cvPath : String
cvPath =
    "cv"


meowPath : String
meowPath =
    "meow"


projectsPath : String
projectsPath =
    "projects"


rootPath : String
rootPath =
    "/"
