import Html exposing (Html, Attribute, br, div, input, label, span, text, node, p)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Basics exposing (..)
import List exposing (..)
import Evaluation exposing (Evaluation)

main = beginnerProgram { model = init, view = view, update = update }

-- MODEL
type alias View = { title : String
                  , viewId : ViewId
                  , typ : ViewType
                  , evaluations : List (User, Evaluation) }
type alias ViewId = Id
type ViewType = NewBoxConnection Id | NewArgument | NewCounter | NewAnswer

type alias Id = Int
type alias User = { name : String }
type alias Comments = List String
type BoxType = Question
             | Answer
             | Argument

type alias Box = { title: String
                 , typ : BoxType
                 , id : Id
                 , evaluations : List (User, Evaluation)
                 , views: List View
                 , comments: Comments
                 }

type alias Model = { box : Box 
                   , evaluation : Evaluation.Model
                   }

initBox =
  { title = "testBox"
  , typ = Question
  , id = 0
  , evaluations = [({name = "User1"}, Evaluation.ValidNotImportant)
                  ,({name = "User2"}, Evaluation.ValidImportant)
                  ,({name = "User3"}, Evaluation.NotValid)
                  ]
  , views = []
  , comments = []
  }

init = { box = initBox, evaluation = Evaluation.init }

-- UPDATE

type Msg
  = Open
  | Evaluate Evaluation  
  | AddView View
  | EvaluateView Evaluation ViewId
  | EvaluationMsg Evaluation.Msg

update : Msg -> Model -> Model
update msg model = case msg of
  EvaluationMsg msg -> { model | evaluation = Evaluation.update msg model.evaluation }
  _ -> model

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [text model.box.title
        ,Html.App.map EvaluationMsg <| Evaluation.view model.evaluation
        ]
