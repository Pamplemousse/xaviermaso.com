module Commands exposing (fetchData)

import CatGifs.Commands exposing (fetchCatGif)
import Messages exposing (Msg(..))
import Projects.Decoders
import TiledList
import Url exposing (Url)


fetchData : Url -> Url -> Cmd Msg
fetchData projectsUrl catGifsUrl =
    Cmd.batch
        [ Cmd.map ProjectsMsg (TiledList.fetch Projects.Decoders.decoder projectsUrl)
        , fetchCatGif catGifsUrl
        ]
