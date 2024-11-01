module Routing exposing (Route(..), blogPath, cvPath, meowPath, projectsPath, rootPath, routeParser)

import Url.Parser exposing (Parser, map, oneOf, s, top)


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
