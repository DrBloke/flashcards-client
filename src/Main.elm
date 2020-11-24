module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { totalRounds : Int
    , currentRound : Int
    , removedCards : List Card
    , remainingCards : List Card
    , isRandomised : Bool
    , cardSide : Side
    , studyTime : Int
    }

type alias Card =
    ( String, String)

type Side
    = Front
    | Back

initialModel : Model
initialModel =
    { totalRounds = 3
    , currentRound = 1
    , removedCards = []
    , remainingCards = defaultDeck
    , isRandomised = False
    , cardSide = Front
    , studyTime = 0
    }

defaultDeck =
    [ ("hello", "ola")
    , ("how are you?", "¿como estas?")
    , ("where are you from?", "¿de dondé eras?")
    , ("how old are you?", "¿quantas añas tienes?")
    ]


type Msg
    = GoHome
    | GoBack
    | GoForward
    | Flip
    | MarkWrong
    | MarkCorrect


update : Msg -> Model -> Model
update msg model =
    case msg of
        GoHome ->
            model
        GoBack ->
            model
        GoForward ->
            model
        Flip ->
            model
        MarkWrong ->
            model
        MarkCorrect ->
            model


view : Model -> Html Msg
view model =
    div [class "container"]
        [ progressView model
        , cardView model
        , toolsView model
        ]

progressView : Model -> Html Msg
progressView model =
    text "Progress view"
cardView : Model -> Html Msg
cardView model =
    text "Card view"
toolsView : Model -> Html Msg
toolsView model =
    text "Tools view"

main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
