module Main exposing (main)

import Browser
import Html as Html exposing (Html, label)
import Html.Attributes as Attributes
import Html.Events as Events


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
    Html.div [ Attributes.class "container" ]
        [ progressView progressViewConfig
        , cardView cardViewConfig
        , toolsView toolsViewConfig
        ]


type alias ProgressViewConfig =
    { totalRounds : Int
    , currentRound : Int
    , remainingCards : List Card
    }


progressView : ProgressViewConfig -> Html Msg
progressView config =
    let
        remainingCards =
            config.remainingCards
                |> List.length
                |> String.fromInt
                |> Html.text
                |> List.singleton
                |> Html.span [ Attributes.class "remaining-cards" ]

        currentRound =
            (String.fromInt config.currentRound ++ "/" ++ String.fromInt config.totalRounds)
                |> Html.text
                |> List.singleton
                |> Html.span [ Attributes.class "rounds" ]
    in
    Html.div [ Attributes.class "progress" ]
        [ remainingCards
        , currentRound
        ]


type alias CardViewConfig =
    { remainingCards : List Card
    , cardSide : Side
    }


cardView : CardViewConfig -> Html Msg
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
        |> Html.text
        |> List.singleton
        |> Html.div [ Attributes.class "card-content" ]


type alias ToolsViewConfig =
    { cardSide : Side }


toolsView : ToolsViewConfig -> Html Msg
toolsView config =
    let
        buttons =
            case config.cardSide of
                Front ->
                    Html.div [ Attributes.class "flip" ]
                        [ button "Flip" Flip ]

                Back ->
                    Html.div [ Attributes.class "mark" ]
                        [ button "Wrong" MarkWrong
                        , button "Correct" MarkCorrect
                        ]

        flipOrMark =
            Html.div [ Attributes.class "flip-or-mark" ] [ buttons ]
    in
    Html.div [ Attributes.class "toolbar" ]
        [ button "Home" GoHome
        , Html.span [ Attributes.class "advance" ]
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


button : String -> Msg -> Html Msg
button label msg =
    Html.button [ Attributes.type_ "button", Events.onClick msg ] [ Html.text label ]
