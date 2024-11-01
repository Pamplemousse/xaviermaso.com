module Projects.Messages exposing (Msg(..))

import Projects.Models exposing (Project)
import RemoteData exposing (WebData)


type Msg
    = OnFetch (WebData (List Project))
    | CloseDescriptionOf Project
    | ShowDescriptionOf Project
