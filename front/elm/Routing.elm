module Routing exposing (Route(..), blogPath, cvPath, meowPath, rootPath, routeParser)

import Projects.Routing
import Talks.Routing
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
        , map ProjectsRoute (s Projects.Routing.path)
        , map TalksRoute (s Talks.Routing.path)
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
