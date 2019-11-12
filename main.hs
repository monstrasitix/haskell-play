data Todo = Todo
    { todoId :: TodoId
    , todoName :: TodoName
    }
    
    
type Todos = [Todo]
type TodoId = Int
type TodoName = String


data Option
    = ShowTodos
    | AddTodo
    | RemoveTodo
    | UpdateTodo
    | CheckTodo
    | UncheckTodo
    | Exit


parse_option :: Int -> Option
parse_option 1 = ShowTodos
parse_option 2 = AddTodo
parse_option 3 = RemoveTodo
parse_option 4 = UpdateTodo
parse_option _ = Exit


todos :: Todos
todos =
    [ Todo 1 "Do one thing"
    , Todo 2 "Do one thing"
    , Todo 3 "Do one thing"
    , Todo 4 "Do one thing"
    , Todo 5 "Do one thing"
    ]
    
    
print_todo :: Todo -> String
print_todo todo =
    unwords
        [ "#"
        , (show $ todoId todo)
        , "-"
        , (todoName todo)
        ]
    
    
print_todos :: Todos -> IO ()
print_todos =
    mapM_ $ print . print_todo
    
    
add_todo :: Todos -> Todos
add_todo todos =
    todos ++ [todo]
    where
        todo = Todo
            (succ $ length todos)
            ("Something new")
       
       
remove_todo :: TodoId -> Todos -> Todos
remove_todo id =
    filter $ (/=) id . todoId
    
    
update_todo :: TodoId -> TodoName -> Todos -> Todos
update_todo id name =
    map (\x -> if todoId x /= id then x else Todo id name)


print_options :: Todos -> IO ()
print_options todos = do
    print "1 - Show Todos"
    print "2 - Add Todo"
    print "3 - Remove Todo"
    print "4 - Update Todo"
    print "5 - Exit"
    input <- getLine
    case parse_option $ read input of
        ShowTodos ->
            print_todos todos
            
        AddTodo ->
            print_todos $ add_todo todos
            
        RemoveTodo ->
            print_todos $ remove_todo 2 todos
            
        UpdateTodo ->
            print_todos $ update_todo 2 "Updated" todos
   
        Exit -> print "Exit"
    

main :: IO ()
main =
    print_options todos
