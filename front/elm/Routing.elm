module Routing exposing (..)

import Models exposing (Route(..))
import Projects.Models exposing (ProjectId)

import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map MainRoute top
        , map ProjectsRoute (s "projects")
        , map CVRoute (s "cv")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute


projectsPath : String
projectsPath =
    "#projects"


cvPath : String
cvPath =
    "#cv"