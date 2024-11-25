module Talks.Models exposing (Conference, Talk, talksDefaultUrl)

import Date exposing (Date)
import Lang exposing (Lang)
import Link
import Url exposing (Protocol(..), Url)


type alias Id =
    Int


type alias Conference =
    { organisation : String
    , date : Date
    , duration : Int
    , lang : Lang
    , recording : Maybe Link.Model
    , slides : Maybe Link.Model
    , sources : Maybe Link.Model
    }


type alias Talk =
    { id : Id
    , title : String
    , description : String
    , conferences : List Conference
    }


talksDefaultUrl : Url
talksDefaultUrl =
    Url Https "www.xaviermaso.com" Nothing "api/talks" Nothing Nothing
