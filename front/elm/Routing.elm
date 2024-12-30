module Routing exposing (Route(..), blogPath, cvPath, meowPath, rootPath, routeParser)

import Projects.Routing
import Talks.Routing
import TiledList
import Url.Parser exposing (Parser, map, oneOf, s, top)


type Route
    = MainRoute
    | CVRoute
    | MeowRoute
    | ProjectsRoute TiledList.Route
    | TalksRoute TiledList.Route


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map MainRoute top
        , map CVRoute (s cvPath)
        , map MeowRoute (s meowPath)
        , map ProjectsRoute (TiledList.parser Projects.Routing.path)
        , map TalksRoute (TiledList.parser Talks.Routing.path)
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


rootPath : String
rootPath =
    "/"
