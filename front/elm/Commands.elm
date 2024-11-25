module Commands exposing (fetchData)

import CatGifs.Commands exposing (fetchCatGif)
import Messages exposing (Msg(..))
import Projects.Decoders
import Talks.Decoders
import TiledList
import Url exposing (Url)


fetchData : Url -> Url -> Url -> Cmd Msg
fetchData projectsUrl talksUrl catGifsUrl =
    Cmd.batch
        [ Cmd.map ProjectsMsg (TiledList.fetch Projects.Decoders.decoder projectsUrl)
        , Cmd.map TalksMsg (TiledList.fetch Talks.Decoders.decoder talksUrl)
        , fetchCatGif catGifsUrl
        ]
