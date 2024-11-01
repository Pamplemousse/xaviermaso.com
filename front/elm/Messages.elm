module Messages exposing (Msg(..))

import Browser exposing (UrlRequest)
import CatGifs.Models exposing (CatGif)
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)
import Url exposing (Url)


type Msg
    = OnFetchProjects (WebData (List Project))
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnFetchCatGif (WebData CatGif)
    | NavigateTo String
    | RedirectTo String
    | CloseDescriptionOf Project
    | ShowDescriptionOf Project
