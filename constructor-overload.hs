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

todoNew :: Int -> String -> Todo
todoNew x text
    | x `mod` 2 == 0    = new (Complete x text)
    | otherwise         = new (Incomplete x text)

todoNewComplete :: Int -> String -> Todo
todoNewComplete x text = Todo x text True

todos :: [Todo]
todos = [ todoNew 1 "Learn Haskell"
        , todoNew 2 "Get a dog"
        , todoNew 3 "Walk the dog"
        , todoNew 4 "Prepare for brunch"
        , todoNew 5 "Drink water"
        ]

main :: IO ()
main = do
    mapM_ print todos

