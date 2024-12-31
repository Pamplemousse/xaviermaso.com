module TiledList exposing (Id, Model, Msg(..), fetch, idDecoder, initialModel, update, view)

{-| A representation of a list of elements as tiles on a page.
Tiles can be clicked on to bring up the relevant element's details.
-}

import Colours exposing (Colour)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http exposing (expectJson)
import HttpErrorWrapper exposing (buildErrorMessage)
import Json.Decode as Decode
import Link
import Prng.Uuid
import RemoteData exposing (WebData)
import Url exposing (Url)


type Id
    = Uuid Prng.Uuid.Uuid


type alias Listable a =
    { a
        | id : Id
        , title : String
    }


type Msg a
    = OnFetch (WebData (List a))
    | LinkMsg Link.Msg
    | CloseDescriptionOfCurrent
    | ShowDescriptionOf Id


type alias Model a =
    { all : WebData (List a)
    , idCurrent : Maybe Id
    }


idDecoder : Decode.Decoder Id
idDecoder =
    Decode.map Uuid Prng.Uuid.decoder


initialModel : Model a
initialModel =
    { all = RemoteData.Loading
    , idCurrent = Nothing
    }


fetch : Decode.Decoder (List (Listable a)) -> Url -> Cmd (Msg (Listable a))
fetch decoder url =
    Http.get
        { url = url |> Url.toString
        , expect = expectJson (RemoteData.fromResult >> OnFetch) decoder
        }


update : Msg (Listable a) -> Model (Listable a) -> ( Model (Listable a), Cmd (Msg (Listable a)) )
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

        ShowDescriptionOf elementId ->
            ( { model | idCurrent = Just elementId }
            , Cmd.none
            )

        CloseDescriptionOfCurrent ->
            ( { model | idCurrent = Nothing }
            , Cmd.none
            )


type alias ColoredCurrentRenderer a =
    a -> Html (Msg a)


type alias CurrentRenderer a =
    Colour -> ColoredCurrentRenderer a


{-| The whole representation of a list: the tiles representing items, and the details whenever an element is clicked on.
-}
view : Model (Listable a) -> Int -> CurrentRenderer (Listable a) -> Colour -> Html (Msg (Listable a))
view { all, idCurrent } numberOfColumns renderCurrent colour =
    case all of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success elements ->
            let
                current =
                    Maybe.andThen (\x -> List.head (List.filter (\e -> e.id == x) elements)) idCurrent
            in
            div []
                [ viewCurrent current (renderCurrent colour)
                , viewAll elements numberOfColumns colour
                ]

        RemoteData.Failure error ->
            text (buildErrorMessage error)


{-| Represent the list as tiles.
-}
viewAll : List (Listable a) -> Int -> Colour -> Html (Msg (Listable a))
viewAll elements numberOfColumns colour =
    div [ class "row" ] (List.indexedMap (viewTile colour numberOfColumns) elements)


{-| Represent a single element of a list as a tile.
-}
viewTile : Colour -> Int -> Int -> Listable a -> Html (Msg (Listable a))
viewTile c numberOfColumns index element =
    let
        colour =
            let
                -- Alternating colours is dependent on the number of columns
                criteria =
                    case modBy 2 numberOfColumns of
                        -- with an even number of columns, we consider the rows 2 by 2 (so for 2 * numberOfColumns tiles)
                        0 ->
                            let
                                indexModuloTwoRows =
                                    modBy (2 * numberOfColumns) index

                                onFirstRow =
                                    indexModuloTwoRows < numberOfColumns
                            in
                            (onFirstRow && modBy 2 indexModuloTwoRows == 0) || (not onFirstRow && modBy 2 indexModuloTwoRows == 1)

                        -- with an odd number of columns
                        _ ->
                            modBy 2 index == 0
            in
            if criteria then
                Colours.toString c

            else
                Colours.toStringLight c

        width =
            12 // numberOfColumns
    in
    div [ class ("col-md-" ++ String.fromInt width), onClick (ShowDescriptionOf element.id) ]
        [ button [ class ("list-component-tile " ++ colour) ] [ element.title |> String.toLower |> text ]
        ]


{-| Represent the details of an element of the list.
Because rendering is heavily dependent on the details that the element has to show, let the caller provide the rendering logic.
-}
viewCurrent : Maybe (Listable a) -> ColoredCurrentRenderer (Listable a) -> Html (Msg (Listable a))
viewCurrent element renderCurrent =
    case element of
        Just something ->
            div []
                [ renderCurrent something
                ]

        Nothing ->
            text ""
