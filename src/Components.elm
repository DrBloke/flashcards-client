module Components exposing (..)

-- helper functions to be put in a library

import Css exposing (..)
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)
import Style exposing (..)


button : String -> msg -> Styled.Html msg
button label msg =
    Styled.button [ css [ buttonStyle ], onClick msg ] [ Styled.text label ]


buttonPlus : Style -> String -> msg -> Styled.Html msg
buttonPlus alternateClass label msg =
    Styled.button [ css [ alternateClass ], onClick msg ] [ Styled.text label ]
