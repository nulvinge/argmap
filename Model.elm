--type alias Argument = { title : String, argumentId : ArgumentId }
--type alias Position = { title : String, argumentId : ArgumentId, positionId : PositionId }
--type alias Counter = { title : String, argumentId : ArgumentId, positionId : PositionId, counterId : CounterId }
--type alias View = { viewTextId : ViewTextId, userId : UserId }
--type alias ViewText = { viewTextId : ViewTextId, type : ViewType, counterId : CounterId }
--type ViewType = For | Against | DontCare

--type alias Question = { title : String, positions : [Answer] }
--type alias Answer = { title : String, counters : Graph Argument }
--type alias Argument = { title : String, [View] }

type alias View = { title : String
                  , viewId : ViewId
                  , type : ViewType
                  , evaluations : [(User, Evaluation)] }
type alias ViewId = Id
type ViewType = NewConnection BoxId | NewArgument | NewCounter | NewAnswer
type Evaluation = NotValid
                | DontKnow
                | ValidNotImportant
                | ValidDefault
                | ValidImportant
                | ValidVeryImportant
type alias User = { name : String }

type alias Box = { title: String
                 , id : BoxId
                 , evaluations : [(User, Evaluation)]
                 , views: [View]
                 , comments: Comments }
type BoxId = Question Id
           | Answer Id
           | Argument Id
type Comments = NoComment

type Model = { boxes : Graph Box, activeBox : BoxId, user : User }

type Box.Action =
  | Open
  | Evaluate Evaluation  
  | AddView View
  | EvaluateView Evaluation ViewId

type Action =
  | InteractBox BoxId Box.Action
  | ModifyGraph BoxId View