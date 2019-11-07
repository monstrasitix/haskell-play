data Model = Model
    String


data Message
    = NoOp


data Program model message output = Program
    { view :: model -> output
    , update :: message -> model -> (model, message)
    , initialize :: (model, message)
    }
    
    
    
program :: Program -> IO ()
program p =
    print . view $ initialize
    
    
    
aainitialize :: (Model, Message)
aainitialize =
    ("hey", NoOp)
    

aaview :: Model -> String
aaview value =
    value ++ "!!!"
    
    
aaupdate :: Message -> Model -> (Model, Message)
aaupdate message model =
    (model, message)


main :: IO ()
main =
    program $ (Program Model NoOp String)
        aaview
        aaupdate
        aainitialize
