module Commands exposing (fetchData)

import CatGifs.Commands exposing (fetchCatGif)
import CatGifs.Models exposing (CatGifsUrl)
import Messages exposing (Msg(..))
import Projects.Commands exposing (fetch)
import Projects.Models


fetchData : Projects.Models.Url -> CatGifsUrl -> Cmd Msg
fetchData projectsUrl catGifsUrl =
    Cmd.batch
        [ Cmd.map ProjectsMsg (fetch projectsUrl)
        , fetchCatGif catGifsUrl
        ]
