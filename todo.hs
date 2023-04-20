import Text.Printf

(?:) :: Bool -> a -> a -> a
(?:) True a _   = a
(?:) False _ a  = a

data State = State
    { stateTodos :: [Todo]
    , stateCounter :: Int
    }

data Todo = Todo
    { todoId :: Int
    , todoDescription :: String
    , todoComplete :: Bool
    }

instance Show Todo where
    show (Todo idd description complete) =
        printf "%d. %s - %s" idd check description
        where
            check = (?:) complete "[x]" "[ ]"
         
menu ::  String
menu =
    "1. Show todos\n\
    \2. Add todo\n\
    \3. Toggle todo\n\
    \4. Remove todo\n\
    \5. Exit\n"
    
data MenuOption
    = ShowAll
    | Add
    | Toggle
    | Remove
    | Exit
    deriving Show
    
intToOption :: Int -> MenuOption
intToOption 1 = ShowAll
intToOption 2 = Add
intToOption 3 = Toggle
intToOption 4 = Remove
intToOption _ = Exit

    
parseLine :: String -> (MenuOption, [String])
parseLine str = (intToOption (read x), xs)
    where
        (x:xs) = words str

app :: State -> IO ()
app state = do
    (option, params) <- getLine >>= return . parseLine
    action option state params

action :: MenuOption -> State -> [String] -> IO ()
action ShowAll state _ = do
    print "---------------------------"
    mapM_ print (stateTodos state)
    print "---------------------------"
    app state
    
action Add (State todos counter) [description] = do
    let newCounter = counter + 1
    let newTodo = Todo newCounter description False
    app $ State (todos ++ [newTodo]) counter
    
action Toggle (State todos counter) [id] = do
    let num = read id
    let swap todo =
            if todoId todo == num then
                Todo (todoId todo) (todoDescription todo) (not (todoComplete todo))
            else
                todo
    app $ State (map swap todos) counter
    
action Remove (State todos counter) [id] = do
    let num = read id
    let swap todo = todoId todo /= num
    app $ State (filter swap todos) counter
    
action Exit _ _ = return ()

main :: IO ()
main = do
    putStrLn menu
    app $ State todos 0
    where
        todos =
            [ Todo 1 "asadadasd asd a sdasd" False
            , Todo 2 "asdad asd a asda adsdasd" False
            , Todo 3 "as dad a asda adsda sd" True
            ]
