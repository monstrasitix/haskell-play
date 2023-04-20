import Text.Printf

class New m where
    new :: m -> m

data Todo = Todo
    { todoId :: Int
    , todoDescription :: String
    , todoComplete :: Bool
    }
    
    | Incomplete String
    | Complete String
    
todoMark :: Todo -> String
todoMark = f . todoComplete
    where
        f True  = "[x]"
        f False = "[ ]"
    
instance New Todo where
    new (Incomplete desc)   = Todo 0 desc False
    new (Complete desc)     = Todo 0 desc True

instance Show Todo where
    show todo = printf "%s %d - %s"
        (todoMark todo)
        (todoId todo)
        (todoDescription todo)

withUnique :: (a -> Int -> a) -> [a] -> [a]
withUnique f ll = fst $ foldr ff ([], length ll) ll
    where
        ff x (acc, n) = ((f x (n - 1) : acc), n - 1)

todos :: [Todo]
todos = [ new (Incomplete "Learn Haskell")
        , new (Complete "Get a dog")
        , new (Incomplete "Walk the dog")
        , new (Complete "Prepare for brunch")
        , new (Incomplete "Drink water") 
        ]

otherTodos :: [Todo]        
otherTodos = withUnique ff todos
    where
        ff x n = x { todoId = n + 1 }

main :: IO ()
main = do
    mapM_ print todos
    print "------------------"
    mapM_ print otherTodos

