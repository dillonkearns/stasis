module World exposing (WorldChange, init, score, view)

import Html exposing (Html)


type alias World =
    List WorldChange


type alias WorldChange =
    { nature : Int
    , crops : Int
    , cities : Int
    }


init : WorldChange
init =
    { nature = 0
    , crops = 0
    , cities = 0
    }


type alias Score =
    { co2Offset : Int
    , cropYield : Int
    , productivity : Int
    , cropUse : Int
    }


score :
    WorldChange
    -> Score
score world =
    { cropYield = world.crops
    , cropUse = world.cities
    , productivity = world.cities * 3
    , co2Offset =
        world.nature
            * 2
            - (world.cities + world.crops)
    }


view : WorldChange -> Html msg
view world =
    Html.div []
        (scoreView (score world)
            :: List.map (\string -> Html.div [] [ Html.text string ])
                [ "🌳 -> 0"
                , "🌾 -> 0"
                , "🏢 -> 0"
                ]
        )


scoreView : Score -> Html msg
scoreView worldScore =
    Html.div []
        ([ ( "🍅"
           , (worldScore.cropUse |> String.fromInt)
                ++ "/"
                ++ (worldScore.cropYield |> String.fromInt)
           )
         , ( "👷\u{200D}♀️", worldScore.productivity |> String.fromInt )
         , ( "🌬", worldScore.co2Offset |> String.fromInt )
         ]
            |> List.map
                (\( key, value ) ->
                    Html.div []
                        [ Html.text
                            (key
                                ++ value
                            )
                        ]
                )
        )
