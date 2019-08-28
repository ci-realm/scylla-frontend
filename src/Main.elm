module Main exposing (main)

import Browser exposing (sandbox)
import Element exposing (Element, alignRight, centerX, centerY, column, el, fill, height, padding, px, rgb, rgb255, row, shrink, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Region as Region


main =
    Browser.sandbox { init = init, view = view, update = update }


init : Model
init =
    { builds =
        [ { id = 1, status = "bar", project = "scylla", sha = "asdfasdf", time = "19:00", duration = "10:00" }
        , { id = 2, status = "bar", project = "scylla", sha = "asdfasdf", time = "19:00", duration = "10:00" }
        , { id = 3, status = "bar", project = "scylla", sha = "asdfasdf", time = "19:00", duration = "10:00" }
        ]
    }


type alias Model =
    { builds : List Build }


type alias Build =
    { id : Int, status : String, project : String, sha : String, time : String, duration : String }


type Msg
    = Update Model


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg" msg of
        Update new ->
            new


view model =
    Element.layout [ Font.size 20 ] <|
        container model


navItems =
    [ "Home", "Builds", "Projects" ]


mapNavItem item =
    column [ width fill ] [ text item ]


mappedNavItems =
    List.map mapNavItem navItems


dbg =
    Element.explain Debug.todo


container : Model -> Element msg
container model =
    column [ width (px 800), centerX ]
        [ row [ width fill ]
            [ column [ width fill ] [ text "Scylla" ], column [ width fill ] [ row [ width fill ] mappedNavItems ] ]
        , row [ width fill, dbg ]
            [ column [ width fill ] [ recentBuilds model ] ]
        ]


recentBuilds : Model -> Element msg
recentBuilds model =
    Element.table [ centerX, centerY, spacing 5, padding 10 ]
        { data = model.builds
        , columns =
            [ { header = text "Build", width = fill, view = \build -> text <| String.fromInt build.id }
            , { header = text "Status", width = fill, view = \build -> text build.status }
            , { header = text "Project", width = fill, view = \build -> text build.project }
            , { header = text "SHA", width = fill, view = \build -> text build.sha }
            , { header = text "Time", width = fill, view = \build -> text build.time }
            , { header = text "Duration", width = fill, view = \build -> text build.duration }
            ]
        }
