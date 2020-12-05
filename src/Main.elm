module Main exposing (main)

import Browser
import Components exposing (..)
import Html as Html exposing (Html, label)
import Html.Attributes as Attributes
import Html.Events as Events
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)
import Style exposing (..)


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
    ( String, String )


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
    [ ( "hello", "ola" )
    , ( "how are you?", "¿como estas?" )
    , ( "where are you from?", "¿de dondé eras?" )
    , ( "how old are you?", "¿quantas añas tienes?" )
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
            { model | cardSide = Back }

        MarkWrong ->
            case model.remainingCards of
                x :: xs ->
                    { model
                        | remainingCards = xs ++ [ x ]
                        , cardSide = Front
                    }

                _ ->
                    model

        MarkCorrect ->
            case model.remainingCards of
                x :: [] ->
                    -- TODO add a start and finish page
                    { model
                        | remainingCards = x :: model.removedCards |> List.reverse
                        , cardSide = Front
                        , currentRound =
                            if model.currentRound < model.totalRounds then
                                model.currentRound + 1

                            else
                                1
                        , removedCards = []
                    }

                x :: xs ->
                    { model
                        | remainingCards = xs
                        , cardSide = Front
                        , removedCards = x :: model.removedCards
                    }

                _ ->
                    model


view : Model -> Styled.Html Msg
view model =
    let
        progressViewConfig =
            ProgressViewConfig
                model.totalRounds
                model.currentRound
                model.remainingCards

        cardViewConfig =
            CardViewConfig
                model.remainingCards
                model.cardSide

        toolsViewConfig =
            ToolsViewConfig
                model.cardSide
    in
    Styled.div [ css [ containerStyle ] ]
        [ progressView progressViewConfig
        , cardView cardViewConfig
        , toolsView toolsViewConfig
        ]


type alias ProgressViewConfig =
    { totalRounds : Int
    , currentRound : Int
    , remainingCards : List Card
    }


progressView : ProgressViewConfig -> Styled.Html Msg
progressView config =
    let
        remainingCards =
            config.remainingCards
                |> List.length
                |> String.fromInt
                |> (++) "Cards remaing:"
                |> Styled.text
                |> List.singleton
                |> Styled.div [ css [ remainingCardsStyle ] ]

        currentRound =
            (String.fromInt config.currentRound ++ "/" ++ String.fromInt config.totalRounds)
                |> (++) "Round:"
                |> Styled.text
                |> List.singleton
                |> Styled.div [ css [ roundsStyle ] ]
    in
    Styled.div [ css [ progressStyle ] ]
        [ remainingCards
        , currentRound
        ]


type alias CardViewConfig =
    { remainingCards : List Card
    , cardSide : Side
    }


cardView : CardViewConfig -> Styled.Html Msg
cardView config =
    let
        cardContent =
            case config.cardSide of
                Front ->
                    Tuple.first

                Back ->
                    Tuple.second
    in
    List.head config.remainingCards
        |> Maybe.withDefault ( "", "" )
        |> cardContent
        |> Styled.text
        |> List.singleton
        |> Styled.div [ css [ cardStyle ] ]


type alias ToolsViewConfig =
    { cardSide : Side }


toolsView : ToolsViewConfig -> Styled.Html Msg
toolsView config =
    let
        buttons =
            case config.cardSide of
                Front ->
                    -- Styled.div [ css [ flipStyle ] ]
                    buttonPlus buttonFlip "Flip" Flip

                Back ->
                    Styled.div [ css [ markStyle ] ]
                        [ button "Wrong" MarkWrong
                        , button "Correct" MarkCorrect
                        ]

        --     flipOrMark =
        --         Styled.div [ css [ flipOrMarkStyle ] ] [ buttons ]
    in
    Styled.div [ css [ toolbarStyle ] ]
        [ button "Home" GoHome
        , Styled.div [ css [ advanceStyle ] ]
            [ button "Back" GoBack
            , button "Forward" GoForward
            ]
        , buttons
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view >> Styled.toUnstyled
        , update = update
        }
