module Projects.Update exposing (update)

import Projects.Messages exposing (Msg(..))
import Projects.Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkMsg _ ->
            ( model
            , Cmd.none
            )

        OnFetch response ->
            ( { model | all = response }
            , Cmd.none
            )

        ShowDescriptionOf element ->
            ( { model | current = Just element }
            , Cmd.none
            )

        CloseDescriptionOf _ ->
            ( { model | current = Nothing }
            , Cmd.none
            )
