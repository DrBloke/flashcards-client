module Main exposing (main)

import Browser
import Css exposing (..)
import Html as Html exposing (Html, label)
import Html.Attributes as Attributes
import Html.Events as Events
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)


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
            model

        MarkWrong ->
            model

        MarkCorrect ->
            model


view : Model -> Html Msg
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
        |> Styled.toUnstyled


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
                |> Styled.span [ css [ remainingCardsStyle ] ]

        currentRound =
            (String.fromInt config.currentRound ++ "/" ++ String.fromInt config.totalRounds)
                |> (++) "Round:"
                |> Styled.text
                |> List.singleton
                |> Styled.span [ css [ roundsStyle ] ]
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
                    Styled.div [ css [ flipStyle ] ]
                        [ button "Flip" Flip ]

                Back ->
                    Styled.div [ css [ markStyle ] ]
                        [ button "Wrong" MarkWrong
                        , button "Correct" MarkCorrect
                        ]

        flipOrMark =
            Styled.div [ css [ flipOrMarkStyle ] ] [ buttons ]
    in
    Styled.div [ css [ toolbarStyle ] ]
        [ button "Home" GoHome
        , Styled.span [ css [ advanceStyle ] ]
            [ button "Back" GoBack
            , button "Forward" GoForward
            ]
        , flipOrMark
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



-- helper functions to be put in a library


button : String -> Msg -> Styled.Html Msg
button label msg =
    Styled.button [ css [ buttonStyle ], onClick msg ] [ Styled.text label ]



-- STYLES


containerStyle : Style
containerStyle =
    color (rgb 255 0 0)


cardStyle : Style
cardStyle =
    color (rgb 255 0 0)


remainingCardsStyle : Style
remainingCardsStyle =
    color (rgb 0 0 0)


roundsStyle : Style
roundsStyle =
    color (rgb 0 0 0)


progressStyle : Style
progressStyle =
    color (rgb 0 0 0)


flipStyle : Style
flipStyle =
    color (rgb 0 0 0)


markStyle : Style
markStyle =
    color (rgb 0 0 0)


flipOrMarkStyle : Style
flipOrMarkStyle =
    color (rgb 0 0 0)


toolbarStyle : Style
toolbarStyle =
    color (rgb 0 0 0)


advanceStyle : Style
advanceStyle =
    color (rgb 0 0 0)


buttonStyle : Style
buttonStyle =
    color (rgb 0 0 0)
