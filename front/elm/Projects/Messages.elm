module Projects.Messages exposing (Msg(..))

import Link
import Projects.Models exposing (Project)
import RemoteData exposing (WebData)


type Msg
    = OnFetch (WebData (List Project))
    | LinkMsg Link.Msg
    | CloseDescriptionOf Project
    | ShowDescriptionOf Project
