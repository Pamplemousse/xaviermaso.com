module Messages exposing (Msg(..))

import Browser exposing (UrlRequest)
import CatGifs.Models exposing (CatGif)
import Projects.Messages
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)
import Url exposing (Url)


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnFetchCatGif (WebData CatGif)
    | NavigateTo String
    | RedirectTo String
    | ProjectsMsg Projects.Messages.Msg
