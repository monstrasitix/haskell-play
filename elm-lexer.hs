


type Parsing =
    ([String], String, String)


token_wrap :: String -> String
token_wrap value = "(" ++ value ++ ")"


lex_token :: String -> Maybe String
lex_token "." =          Just $ token_wrap "."
lex_token "," =          Just $ token_wrap ","
lex_token " " =          Just $ token_wrap " "
lex_token "\n" =         Just $ token_wrap "\n"
lex_token "\t" =         Just $ token_wrap "\t"
lex_token "[" =          Just $ token_wrap "["
lex_token "]" =          Just $ token_wrap "]"
lex_token "(" =          Just $ token_wrap "("
lex_token ")" =          Just $ token_wrap ")"
lex_token "{" =          Just $ token_wrap "{"
lex_token "}" =          Just $ token_wrap "}"
lex_token "-" =          Just $ token_wrap "-"
lex_token "+" =          Just $ token_wrap "+"
lex_token "=" =          Just $ token_wrap "="
lex_token ">" =          Just $ token_wrap ">"
lex_token "<" =          Just $ token_wrap "<"
lex_token "|" =          Just $ token_wrap "|"
lex_token ":" =          Just $ token_wrap ":"
lex_token a =            Nothing



lex_iteration :: Parsing -> Char -> Parsing
lex_iteration (tokens, remain, value) character =
    case lex_token [character] of
        Just token ->
            if (character == ' ')
            then (tokens ++ [token_wrap remain, token], "",  "")
            else (tokens ++ [remain, token], "",  "")
             
            
        Nothing ->
            (tokens, remain ++ [character], [character])



lexing :: String -> Parsing
lexing = foldl lex_iteration ([], "", "")


retrieve :: Parsing -> String
retrieve (a, _, _) = concat a


main :: IO ()
main =
    getContents >>= putStrLn . retrieve . lexing
    -- getContents >>= print . lexing



{-

module Main exposing (..)

import Browser
import Html.Html
import Html.Attributes as Attribute
import Html.Events as Event exposing (onClick)


type Msg
    = Increment
    | Decrement Int
    
    
type alias Model =
    { value : String
    , number : Int
    }
    
    
update : Msg -> Model -> (Model, Msg)
update msg model =
    case msg of
        Increment -> ({ model | number = model.number + 1 }, Cmd.none)
        Decrement int -> ({ model | number = model.number - int }, Cmd.none)
        
view : Model -> Html.Html Msg
view model =
    Html.div [ Attribute.class "Something" ]
        [ Html.text "Something"
        ]

    
    
main : Program () Modal Msg
main =
    Browser.program
        { init = (Model "Hey" 45, Cmd.none)
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }
        
        
(module)( )(Main)( )(exposing)( )(()(.)(.)())(
)(
)(import)( )Browser(
)(import)( )Html(.)Html(
)(import)( )Html(.)(Attributes)( )(as)( )Attribute(
)(import)( )Html(.)(Events)( )(as)( )(Event)( )(exposing)( )(()onClick())(
)(
)(
)(type)( )Msg(
)()( )()( )()( )()( )(=)()( )Increment(
)()( )()( )()( )()( )(|)()( )(Decrement)( )Int(
)()( )()( )()( )()( )(
)()( )()( )()( )()( )(
)(type)( )(alias)( )(Model)( )(=)(
)()( )()( )()( )()( )({)()( )(value)( )(:)()( )String(
)()( )()( )()( )()( )(,)()( )(number)( )(:)()( )Int(
)()( )()( )()( )()( )(})(
)()( )()( )()( )()( )(
)()( )()( )()( )()( )(
)(update)( )(:)()( )(Msg)( )(-)(>)()( )(Model)( )(-)(>)()( )(()Model(,)()( )Msg())(
)(update)( )(msg)( )(model)( )(=)(
)()( )()( )()( )()( )(case)( )(msg)( )of(
)()( )()( )()( )()( )()( )()( )()( )()( )(Increment)( )(-)(>)()( )(()({)()( )(model)( )(|)()( )(number)( )(=)()( )model(.)(number)( )(+)()( )(1)( )(})(,)()( )Cmd(.)none())(
)()( )()( )()( )()( )()( )()( )()( )()( )(Decrement)( )(int)( )(-)(>)()( )(()({)()( )(model)( )(|)()( )(number)( )(=)()( )model(.)(number)( )(-)()( )(int)( )(})(,)()( )Cmd(.)none())(
)()( )()( )()( )()( )()( )()( )()( )()( )(
)(view)( )(:)()( )(Model)( )(-)(>)()( )Html(.)(Html)( )Msg(
)(view)( )(model)( )(=)(
)()( )()( )()( )()( )Html(.)(div)( )([)()( )Attribute(.)(class)( )("Something")( )(])(
)()( )()( )()( )()( )()( )()( )()( )()( )([)()( )Html(.)(text)( )"Something"(
)()( )()( )()( )()( )()( )()( )()( )()( )(])(
)(
)()( )()( )()( )()( )(
)()( )()( )()( )()( )(
)(main)( )(:)()( )(Program)( )(()())()( )(Modal)( )Msg(
)(main)( )(=)(
)()( )()( )()( )()( )Browser(.)program(
)()( )()( )()( )()( )()( )()( )()( )()( )({)()( )(init)( )(=)()( )(()(\)( )(-)(>)()( )(()(Model)( )("Hey")( )45(,)()( )Cmd(.)none())())(
)()( )()( )()( )()( )()( )()( )()( )()( )(,)()( )(update)( )(=)()( )update(
)()( )()( )()( )()( )()( )()( )()( )()( )(,)()( )(view)( )(=)()( )view(
)()( )()( )()( )()( )()( )()( )()( )()( )(,)()( )(subscriptions)( )(=)()( )(()(\_)( )(-)(>)()( )Sub(.)none())(
)()( )()( )()( )()( )()( )()( )()( )()( )(})(
)


-}
