module Routing exposing (Route(..), blogPath, cvPath, facebookPath, meowPath, projectsPath, rootPath, routeParser)

import Browser.Navigation exposing (Key)
import Url.Parser exposing (..)


type Route
    = MainRoute
    | CVRoute
    | FacebookRoute
    | MeowRoute
    | ProjectsRoute


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map MainRoute top
        , map CVRoute (s cvPath)
        , map MeowRoute (s meowPath)
        , map ProjectsRoute (s projectsPath)
        , map FacebookRoute (s facebookPath)
        ]


blogPath : String
blogPath =
    "https://blog.xaviermaso.com"


cvPath : String
cvPath =
    "cv"


facebookPath : String
facebookPath =
    "facebook"


meowPath : String
meowPath =
    "meow"


projectsPath : String
projectsPath =
    "projects"


rootPath : String
rootPath =
    "/"
