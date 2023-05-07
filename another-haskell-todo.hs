import Data.IORef
import Data.List
import Data.Maybe
import Text.Printf

{- stdin
add "Feed my dog"
add "Do homework"
add "Walk the dog"
add "Full insurance papers"
add "Go to the bank"
mark 2
mark 4
update 3 "Pet the dog"
remove 1
remove 2
exit
-}

{- stdout
[ ] 3 - "Pet the dog"
[X] 4 - "Full insurance papers"
[ ] 5 - "Go to the bank"
-}

type AppState = (Int, [Todo])

data Todo = Todo
    { todoId :: Int
    , todoDescription:: String
    , todoComplete :: Bool
    }

todoMark :: Todo -> String
todoMark = ff . todoComplete
    where
        ff True  = "[X]"
        ff False = "[ ]"

instance Show Todo where
    show x = printf "%s %d - %s"
        (todoMark x)
        (todoId x)
        (todoDescription x)

instance Eq Todo where
    x1 == x2 = i1 == i2
        where
            i1 = todoId x1
            i2 = todoId x2

instance Ord Todo where
    compare x1 x2
        | i1 < i2   = LT
        | i1 > i2   = GT
        | otherwise = EQ
        where
            i1 = todoId x1
            i2 = todoId x2

addTodoIO :: String -> AppState -> AppState
addTodoIO text (c, todos) = (c', todos ++ [todo])
    where
        c' = succ c
        todo = Todo c' text False

markTodoIO :: Int -> AppState -> AppState
markTodoIO i (c, todos) = (c, todos')
    where
        todos' = map ff todos
        ff x
            | todoId x == i = x { todoComplete = True }
            | otherwise     = x

putTodoTextIO :: Int -> String -> AppState -> AppState
putTodoTextIO i text (c, todos) = (c, todos')
    where
        todos' = map ff todos
        ff x
            | todoId x == i = x { todoDescription = text }
            | otherwise     = x

removeTodoIO :: Int -> AppState -> AppState
removeTodoIO i (c, todos) = (c, todos')
    where
        todos' = filter ((/= i) . todoId) todos

printList :: Show a => [a] -> IO ()
printList = mapM_ print

data Action
    = AddTodo String
    | MarkTodo Int
    | RemoveTodo Int
    | UpdateTodo Int String
    | ShowTodos
    | Exit
    deriving Show

action :: [String] -> Maybe Action
action o = case o of
    ("add":xs)       -> Just $ AddTodo (intercalate " " xs)
    ("mark":x:_)     -> Just $ MarkTodo (read x)
    ("remove":x:_)   -> Just $ RemoveTodo (read x)
    ("update":x:xs)  -> Just $ UpdateTodo (read x) (intercalate " " xs)
    ["exit"]         -> Just $ Exit
    _                -> Nothing

actionPreform :: IORef AppState -> Action -> IO ()
actionPreform ref action = case action of
    (AddTodo xs)        -> modifyIORef ref (addTodoIO xs)
    (MarkTodo n)        -> modifyIORef ref (markTodoIO n)
    (RemoveTodo n)      -> modifyIORef ref (removeTodoIO n)
    (UpdateTodo n xs)   -> modifyIORef ref (putTodoTextIO n xs)
    ShowTodos           -> readIORef ref >>= printList . snd
    Exit                -> return ()

main :: IO ()
main = do
    ref <- newIORef ((0, []) :: AppState)
    
    getContents
        >>= return . map words . lines
        >>= mapM_ (actionPreform ref . fromMaybe Exit . action)

    readIORef ref >>= printList . snd
