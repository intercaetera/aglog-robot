module Main exposing (main)

import Browser
import Html exposing (Html, div, text)

type Msg = Void

main : Program () Int Msg
main =
    Browser.sandbox { init = 0, update = update, view = view }


update : Msg -> number -> number
update _ model =
    model


view : Int -> Html Msg
view _ =
    div [] [ text "hello" ]
