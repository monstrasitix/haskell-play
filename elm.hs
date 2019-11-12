data Model = Model
    { numbers :: [Int]
    , limit :: Int
    }



data Program model = Program
    { model :: model
    , view :: model -> IO ()
    }
    
    
    
make_program :: Program model -> IO ()
make_program program = view program $ model program
    
    
    
initial_model :: Model
initial_model = Model [1..] 4



initial_view :: Model -> IO ()
initial_view model =
    mapM_ print . take limit' $ numbers'
    where
        numbers' = numbers model
        limit' = limit model
    
    

main :: IO ()
main =
    make_program Program
        { view = initial_view
        , model = initial_model
        }
            
            
            
