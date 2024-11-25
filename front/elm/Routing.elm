module Routing exposing (Route(..), blogPath, cvPath, meowPath, projectsPath, rootPath, routeParser, talksPath)

import Url.Parser exposing (Parser, map, oneOf, s, top)


type Route
    = MainRoute
    | CVRoute
    | MeowRoute
    | ProjectsRoute
    | TalksRoute


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map MainRoute top
        , map CVRoute (s cvPath)
        , map MeowRoute (s meowPath)
        , map ProjectsRoute (s projectsPath)
        , map TalksRoute (s talksPath)
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


talksPath : String
talksPath =
    "talks"
