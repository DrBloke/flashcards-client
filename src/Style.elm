module Style exposing (..)

import Css exposing (..)
import Html.Styled.Attributes exposing (css, href, src)


containerStyle : Style
containerStyle =
    Css.batch
        [ height (vh 100)
        , displayFlex
        , flexDirection column
        , justifyContent spaceBetween
        , fontSize (px 50)
        ]


defaultPadding : Style
defaultPadding =
    padding (px 10)


cardStyle : Style
cardStyle =
    Css.batch
        [ displayFlex
        , justifyContent center
        , defaultPadding
        , color (rgb 255 0 0)
        ]


remainingCardsStyle : Style
remainingCardsStyle =
    color (rgb 0 0 0)


roundsStyle : Style
roundsStyle =
    color (rgb 0 0 0)


progressStyle : Style
progressStyle =
    Css.batch
        [ displayFlex
        , justifyContent spaceBetween
        , defaultPadding
        , fontSize (em 0.7)
        ]



-- flipStyle : Style
-- flipStyle =
--     Css.batch
--         []


markStyle : Style
markStyle =
    Css.batch
        [ displayFlex
        , justifyContent spaceBetween
        , minWidth (px 295)
        ]


flipOrMarkStyle : Style
flipOrMarkStyle =
    Css.batch []


toolbarStyle : Style
toolbarStyle =
    Css.batch
        [ displayFlex
        , justifyContent spaceBetween
        , defaultPadding
        ]


advanceStyle : Style
advanceStyle =
    Css.batch
        [ displayFlex
        , justifyContent spaceBetween
        , minWidth (px 280)
        ]


buttonStyle : Style
buttonStyle =
    Css.batch
        [ fontSize (em 0.8) ]


buttonFlip : Style
buttonFlip =
    Css.batch (buttonStyle :: [ minWidth (px 295) ])
