module TiledList exposing (Id, Model, Msg(..), Route, fetch, idDecoder, idFromString, initialModel, parser, update, view)

{-| A representation of a list of elements as tiles on a page.
Tiles can be clicked on to bring up the relevant element's details.
-}

import Colours exposing (Colour)
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class, href)
import Http exposing (expectJson)
import HttpErrorWrapper exposing (buildErrorMessage)
import Json.Decode as Decode
import Link
import Prng.Uuid
import RemoteData exposing (WebData)
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, custom, map, oneOf, s)


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
    | UrlChanged Route


type alias Model a =
    { all : WebData (List a)
    , idCurrent : Maybe Id
    }


type alias Route =
    Maybe Id


idDecoder : Decode.Decoder Id
idDecoder =
    Decode.map Uuid Prng.Uuid.decoder


idToString : Id -> String
idToString id =
    case id of
        Uuid i ->
            Prng.Uuid.toString i


idFromString : String -> Maybe Id
idFromString =
    Prng.Uuid.fromString >> Maybe.map Uuid


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


parser : String -> Parser (Route -> a) a
parser rootPath =
    let
        uuidParser =
            custom "UUID" Prng.Uuid.fromString
    in
    oneOf
        [ map Just (s rootPath </> map Uuid uuidParser)
        , map Nothing (s rootPath)
        ]


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

        UrlChanged route ->
            ( { model | idCurrent = route }
            , Cmd.none
            )


type alias ColoredCurrentRenderer a =
    a -> Html (Msg a)


type alias CurrentRenderer a =
    Colour -> ColoredCurrentRenderer a


{-| The whole representation of a list: the tiles representing items, and details of specific element if on its page.
-}
view : Model (Listable a) -> Int -> CurrentRenderer (Listable a) -> String -> Colour -> Html (Msg (Listable a))
view { all, idCurrent } numberOfColumns renderCurrent rootPath colour =
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
                , viewAll elements numberOfColumns rootPath colour
                ]

        RemoteData.Failure error ->
            text (buildErrorMessage error)


{-| Represent the list as tiles.
-}
viewAll : List (Listable a) -> Int -> String -> Colour -> Html (Msg (Listable a))
viewAll elements numberOfColumns rootPath colour =
    div [ class "row" ] (List.indexedMap (viewTile rootPath colour numberOfColumns) elements)


{-| Represent a single element of a list as a tile.
-}
viewTile : String -> Colour -> Int -> Int -> Listable a -> Html (Msg (Listable a))
viewTile rootPath c numberOfColumns index element =
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

        navigationTarget =
            "/" ++ rootPath ++ "/" ++ (element.id |> idToString)

        width =
            12 // numberOfColumns
    in
    div [ class ("col-md-" ++ String.fromInt width) ]
        [ a [ class ("list-component-tile " ++ colour), href navigationTarget ] [ element.title |> String.toLower |> text ]
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
