module Commands exposing (fetchData)

import CatGifs.Commands exposing (fetchCatGif)
import CatGifs.Models exposing (CatGifsUrl)
import Messages exposing (Msg(..))
import Projects.Decoders
import Projects.Models
import TiledList


fetchData : Projects.Models.Url -> CatGifsUrl -> Cmd Msg
fetchData projectsUrl catGifsUrl =
    Cmd.batch
        [ Cmd.map ProjectsMsg (TiledList.fetch Projects.Decoders.decoder projectsUrl)
        , fetchCatGif catGifsUrl
        ]
