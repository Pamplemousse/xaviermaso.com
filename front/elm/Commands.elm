module Commands exposing (fetchData)

import CatGifs.Commands exposing (fetchCatGif)
import CatGifs.Models exposing (CatGifsUrl)
import Messages exposing (Msg)
import Projects.Commands exposing (fetchProjects)
import Projects.Models exposing (ProjectsUrl)


fetchData : ProjectsUrl -> CatGifsUrl -> Cmd Msg
fetchData projectsUrl catGifsUrl =
    Cmd.batch
        [ fetchProjects projectsUrl
        , fetchCatGif catGifsUrl
        ]
