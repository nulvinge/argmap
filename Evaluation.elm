module Evaluation exposing (Msg,Model,Evaluation(..),update,view,init)

import Html exposing (Html, Attribute, br, div, input, label, span, text, node, p)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Basics exposing (..)
import List exposing (..)
import Dropdown

main = beginnerProgram { model = init, view = view, update = update }

-- MODEL

type Evaluation = NotValid
                | DontKnow
                | ValidNotImportant
                | ValidDefault
                | ValidImportant
                | ValidVeryImportant

nameMap =
    [ ("",                      Nothing)
    , ("Not valid",             Just NotValid)
    , ("Don't know",            Just DontKnow)
    , ("Valid, not important",  Just ValidNotImportant)
    , ("Valid",                 Just ValidDefault)
    , ("Valid, important",      Just ValidImportant)
    , ("Valid, very important", Just ValidVeryImportant)
    ]

type alias Msg = Dropdown.Msg
type alias Model = Dropdown.Dropdown

init = Dropdown.init "" (map fst nameMap) "Evaluation"

-- UPDATE

update : Dropdown.Msg -> Model -> Model
update = Dropdown.update

-- VIEW

view : Dropdown.Dropdown -> Html Dropdown.Msg
view model =
    div
    []
    [
        node "link"
        [
            rel "stylesheet",
            href "../Dropdown.css"
        ] 
        [],
        Dropdown.renderDropdownHtml model
    ]
