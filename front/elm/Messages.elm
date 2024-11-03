module Messages exposing (Msg(..))

import Browser exposing (UrlRequest)
import CatGifs.Models exposing (CatGif)
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)
import TiledList
import Url exposing (Url)


type Msg
    = LinkClicked UrlRequest
    | UrlChanged Url
    | OnFetchCatGif (WebData CatGif)
    | NavigateTo String
    | RedirectTo String
    | ProjectsMsg (TiledList.Msg Project)
