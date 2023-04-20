import Text.Printf

class New m where
    new :: m -> m

data Todo = Todo
    { todoId :: Int
    , todoDescription :: String
    , todoComplete :: Bool
    }
    
    | Incomplete Int String
    | Complete Int String
    
todoMark :: Todo -> String
todoMark = f . todoComplete
    where
        f True  = "[x]"
        f False = "[ ]"
    
instance New Todo where
    new (Incomplete id' desc)   = Todo id' desc False
    new (Complete id' desc)     = Todo id' desc True

instance Show Todo where
    show todo = printf "%s %d - %s"
        (todoMark todo)
        (todoId todo)
        (todoDescription todo)

todos :: [Todo]
todos = [ new (Incomplete 1 "Learn Haskell")
        , new (Complete 2 "Get a dog")
        , new (Incomplete 3 "Walk the dog")
        , new (Complete 4 "Prepare for brunch")
        , new (Incomplete 5 "Drink water") 
        ]

main :: IO ()
main = do
    mapM_ print todos

