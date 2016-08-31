import Html exposing (Html, Attribute, br, div, input, label, span, text)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)

--main : Element
main = beginnerProgram { model = model, view = view, update = update }

-- MODEL

type Evaluation = NotValid
                | DontKnow
                | ValidNotImportant
                | ValidDefault
                | ValidImportant
                | ValidVeryImportant

type alias Model = Maybe Evaluation

model = Nothing




-- UPDATE

type Msg =
  Switch Evaluation

update : Msg -> Model -> Model
update (Switch newStyle) model =
  { model | style = newStyle }


-- VIEW


view : Model -> Html Msg
--view model =
--  div []
--    [ span [] [text "Hello, how are you?!"]
--    , radio Red "red" model
--    , radio Underline "underline" model
--    , radio Bold "bold" model
--    ]

view model =
  dropDown []
    [ ("",                      Nothing)
    , ("Not valid",             Just NotValid)
    , ("Don't know",            Just DontKnow)
    , ("Valid, not important",  Just ValidNotImportant)
    , ("Valid",                 Just ValidDefault)
    , ("Valid, important",      Just ValidImportant)
    , ("Valid, very important", Just ValidVeryImportant)
    ]


radio : Style -> String -> Model -> Html Msg
radio style name model =
  let
    isSelected =
      model.style == style
  in
    label []
      [ br [] []
      , input [ type' "radio", checked isSelected, onCheck (\_ -> Switch style) ] []
      , text name
      ]
