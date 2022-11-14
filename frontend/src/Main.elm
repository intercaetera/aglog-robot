module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import File.Download as Download
import Http


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type GeneratedCodeReq
    = Failure
    | Loading
    | Success String


type alias Model =
    { name : String
    , generatedCode : GeneratedCodeReq
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" (Success ""), Cmd.none )


type Msg
    = Name String
    | Generate String
    | Download
    | GotCode (Result Http.Error String)


downloadFile : GeneratedCodeReq -> Cmd Msg
downloadFile generatedCode =
    case generatedCode of
        Success content -> Download.string "example.log" "text/plain" content
        _ -> Cmd.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Download ->
            ( model, downloadFile model.generatedCode )

        Name name ->
            ( { model | name = name }, Cmd.none )

        Generate name ->
            ( { model | generatedCode = Loading }, getGeneratedCode name )

        GotCode result ->
            case result of
                Ok code ->
                    ( { model | generatedCode = Success code }, Cmd.none )

                Err _ ->
                    ( { model | generatedCode = Failure }, Cmd.none )


viewCode : GeneratedCodeReq -> Html Msg
viewCode req =
    case req of
        Failure ->
            div [ class "error" ] [ text "Something went wrong..." ]

        Loading ->
            div [] [ text "Loading" ]

        Success code ->
            textarea
                [ placeholder "Generated text will appear here..."
                , readonly True
                , value code
                ]
                []


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "small-container" ]
            [ h1 [] [ text "Aglog Robot" ]
            , h3 [] [ text "Generate logs easily" ]
            , div [ class "form-field" ]
                [ input
                    [ placeholder "Candidate name..."
                    , class "name-input"
                    , value model.name
                    , onInput Name
                    ]
                    []
                , button [ onClick (Generate model.name) ] [ text "Generate" ]
                , button [ onClick (Download) ] [ text "Download" ]
                ]
            ]
        , div [ class "generated-field" ]
            [ viewCode model.generatedCode ]
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


getGeneratedCode : String -> Cmd Msg
getGeneratedCode name =
    Http.get
        { url = String.concat [ "/api/", name ]
        , expect = Http.expectString GotCode
        }
